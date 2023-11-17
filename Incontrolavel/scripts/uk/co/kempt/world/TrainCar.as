package uk.co.kempt.world
{
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import org.cove.ape.RigidRectangle;
   import org.cove.ape.Vector2;
   import org.cove.ape.Vector2Force;
   import uk.co.kempt.Engine;
   import uk.co.kempt.system.TrainSystem;
   import uk.co.kempt.utils.MathUtil;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.world.TrainCar")]
   public class TrainCar extends Sprite
   {
      
      public static const DEFAULT_ROTATION_SPEED_THRESHOLD:Number = 0.055;
      
      public static var UNIQUE:Boolean = true;
      
      public static const DEFAULT_ROTATION_SPEED_THRESHOLD_INCREMENT:Number = 0.018;
       
      
      private var _sibling:TrainCar;
      
      private var _speedX:Number;
      
      public var anim:MovieClip;
      
      private var _state:String;
      
      private var _magnetOffTime:int;
      
      private var _trackPosition:Object;
      
      private var _speedY:Number;
      
      private var _rotationSpeedThreshold:Number = 0.055;
      
      private var _rearParticle:RigidRectangle;
      
      private var _leanRatio:Number;
      
      private var _rotation:Number;
      
      private var _rotationSpeed:Number;
      
      private var _unique:Boolean;
      
      private var _previousRotation:Number;
      
      public function TrainCar()
      {
         super();
         this._rotation = super.rotation;
         this._previousRotation = 0;
         this._speedX = 0;
         this._speedY = 0;
         this._state = TrainSystem.S_NORMAL;
         this._leanRatio = 0;
         if(UNIQUE)
         {
            this._unique = true;
            UNIQUE = false;
         }
         var _loc1_:Number = 2;
         filters = [new DropShadowFilter(1,90,0,1,_loc1_,_loc1_)];
      }
      
      public function get rotationSpeedThreshold() : Number
      {
         return this._rotationSpeedThreshold;
      }
      
      public function set rotationSpeedThreshold(param1:Number) : void
      {
         this._rotationSpeedThreshold = param1;
      }
      
      private function applyFriction() : void
      {
         var _loc1_:Number = this.magnetOff ? 0.93 : 0.9;
         this._rearParticle.velocity = this._rearParticle.velocity.mult(_loc1_);
         this._rearParticle.angularVelocity *= this.magnetOff ? 0.95 : 0.5;
      }
      
      private function applyFrictionCrashing() : void
      {
         var _loc1_:Number = 0.95;
         this._rearParticle.velocity = this._rearParticle.velocity.mult(_loc1_);
         this._rearParticle.angularVelocity *= 0.9;
      }
      
      public function set sibling(param1:TrainCar) : void
      {
         this._sibling = param1;
      }
      
      public function get trackPosition() : Object
      {
         return this._trackPosition;
      }
      
      private function leanAnim() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:int = 0;
         if(this.anim)
         {
            _loc1_ = this.findFrameLabelNum(this.anim,"leanStart");
            _loc2_ = this.findFrameLabelNum(this.anim,"leanEnd");
            _loc3_ = _loc2_ - _loc1_;
            _loc4_ = _loc1_ + _loc3_ / 2;
            _loc5_ = Number(Math.max(-1,Math.min(1,this._rotationSpeed / 0.05)));
            _loc6_ = _loc4_ + _loc3_ / 2 * -_loc5_;
            if(this.anim.currentFrame > _loc6_)
            {
               this.anim.prevFrame();
            }
            else if(this.anim.currentFrame < _loc6_)
            {
               this.anim.nextFrame();
            }
            this._leanRatio = _loc5_;
         }
      }
      
      public function get magnetOffTime() : int
      {
         return this._magnetOffTime;
      }
      
      public function set rearParticle(param1:RigidRectangle) : void
      {
         this._rearParticle = param1;
      }
      
      private function applyRearParticleNudge() : void
      {
         var _loc1_:Number = Number(this.trackPosition.angle);
         if(this.rotationSpeed > 0)
         {
            _loc1_ -= Math.PI / 2;
         }
         else
         {
            _loc1_ += Math.PI / 2;
         }
         var _loc2_:Number = 10;
         var _loc3_:Vector2Force = new Vector2Force(false,_loc2_ * Math.cos(_loc1_),_loc2_ * Math.sin(_loc1_));
         this.rearParticle.addForce(_loc3_);
      }
      
      public function get magnetOff() : Boolean
      {
         return this._magnetOffTime > 0;
      }
      
      public function set trackPosition(param1:Object) : void
      {
         if(this._trackPosition)
         {
            this._speedX = param1.x - this._trackPosition.x;
            this._speedY = param1.y - this._trackPosition.y;
         }
         this._trackPosition = param1;
         this._rotationSpeed = MathUtil.radianDiff(this._previousRotation / 180 * Math.PI,this.trackPosition.rotation / 180 * Math.PI);
         this._previousRotation = this.trackPosition.rotation;
      }
      
      public function set magnetOffTime(param1:int) : void
      {
         this._magnetOffTime = param1;
      }
      
      public function get isCrashing() : Boolean
      {
         return this._state == TrainSystem.S_CRASHING;
      }
      
      public function get leanRatio() : Number
      {
         return this._leanRatio;
      }
      
      public function get sibling() : TrainCar
      {
         return this._sibling;
      }
      
      public function get rearParticle() : RigidRectangle
      {
         return this._rearParticle;
      }
      
      public function useTrackPosition() : void
      {
         x = this.trackPosition.x;
         y = this.trackPosition.y;
         this.rotation = this.trackPosition.rotation;
      }
      
      public function updateBeforeAPE() : void
      {
         switch(this._state)
         {
            case TrainSystem.S_NORMAL:
               this.updateBeforeAPENormal();
               break;
            case TrainSystem.S_CRASHING:
               this.updateBeforeAPECrashing();
         }
      }
      
      private function updateBeforeAPECrashing() : void
      {
         if(this.rearParticle)
         {
            this.applyFrictionCrashing();
         }
      }
      
      private function updateBeforeAPENormal() : void
      {
         if(this.rearParticle)
         {
            if(Math.abs(this._rotationSpeed) > this.rotationSpeedThreshold)
            {
               this._magnetOffTime = Engine.GAME_FRAMERATE * 0.5;
            }
            this.applyFriction();
            if(!this.magnetOff)
            {
               this.applyMagnet();
            }
            if(this._magnetOffTime > 0)
            {
               --this._magnetOffTime;
            }
         }
         this.leanAnim();
      }
      
      private function findFrameLabelNum(param1:MovieClip, param2:String) : int
      {
         var pClip:MovieClip = param1;
         var pName:String = param2;
         var tFrameNum:int = -1;
         pClip.currentLabels.some(function(param1:FrameLabel, param2:int, param3:Array):Boolean
         {
            if(param1.name == pName)
            {
               tFrameNum = param1.frame;
               return true;
            }
            return false;
         });
         return tFrameNum;
      }
      
      public function get rotationSpeed() : Number
      {
         return this._rotationSpeed;
      }
      
      public function get speedX() : Number
      {
         return this._speedX;
      }
      
      public function get speedY() : Number
      {
         return this._speedY;
      }
      
      private function applyMagnet() : void
      {
         var _loc5_:Number = NaN;
         var _loc1_:Number = -TrainSystem.CARRIAGE_SEPERATION / 2;
         var _loc2_:Vector2 = new Vector2(this.trackPosition.x,this.trackPosition.y);
         var _loc3_:Number = this.trackPosition.rotation / 180 * Math.PI;
         _loc2_.x += Math.cos(_loc3_) * _loc1_;
         _loc2_.y += Math.sin(_loc3_) * _loc1_;
         var _loc4_:Vector2 = _loc2_.minus(this._rearParticle.position);
         _loc5_ = 1;
         this._rearParticle.position = this._rearParticle.position.plus(_loc4_.mult(_loc5_));
         this._rearParticle.velocity = new Vector2();
      }
      
      public function destroy() : void
      {
         this._state = TrainSystem.S_CRASHING;
         switch(Math.floor(Math.random() * 3))
         {
            case 0:
               this.anim.gotoAndStop("destruct");
               break;
            case 1:
               this.anim.gotoAndStop("destruct2");
               break;
            case 2:
               this.anim.gotoAndStop("destruct3");
         }
      }
      
      override public function set rotation(param1:Number) : void
      {
         this._rotation = param1;
         super.rotation = param1;
      }
      
      override public function get rotation() : Number
      {
         return this._rotation;
      }
   }
}
