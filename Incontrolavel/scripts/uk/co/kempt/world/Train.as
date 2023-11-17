package uk.co.kempt.world
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.filters.DropShadowFilter;
   import flash.geom.Point;
   import org.cove.ape.AbstractParticle;
   import org.cove.ape.CollisionEvent;
   import org.cove.ape.RigidCircle;
   import org.cove.ape.RigidRectangle;
   import org.cove.ape.Vector2;
   import uk.co.kempt.Engine;
   import uk.co.kempt.data.Lookup;
   import uk.co.kempt.state.WorldObjectState;
   import uk.co.kempt.system.TrainSystem;
   import uk.co.kempt.utils.GarbageUtil;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.world.Train")]
   public class Train extends WorldObject
   {
      
      private static const TRAIN_MASS:Number = 1;
      
      public static const DEBRIS_INCREMENT:Number = 2;
      
      private static const DEFAULT_SMOKE_TIME:int = 2;
      
      public static const DEBRIS_DECREMENT:Number = 0.08;
       
      
      private var _debrisParticle:RigidCircle;
      
      private var _debrisParticles:Array;
      
      private var _state:String;
      
      private var _debrisAmount:Number;
      
      public var debris_mc:MovieClip;
      
      private var _smokeTime:int;
      
      private var _trainParticle:RigidRectangle;
      
      public function Train()
      {
         super();
         this._smokeTime = 0;
         this._state = TrainSystem.S_NORMAL;
         this._debrisAmount = 0;
         this._debrisParticles = [];
         var _loc1_:Number = 2;
         filters = [new DropShadowFilter(1,90,0,1,_loc1_,_loc1_)];
         this.createDebrisParticles();
      }
      
      private function get debrisPosition() : Point
      {
         var _loc1_:Number = rotation / 180 * Math.PI;
         var _loc2_:Number = 15;
         var _loc3_:Number = x + Math.cos(_loc1_) * _loc2_;
         var _loc4_:Number = y + Math.sin(_loc1_) * _loc2_;
         return new Point(_loc3_,_loc4_);
      }
      
      override public function die() : void
      {
         this._trainParticle = null;
         GarbageUtil.kill(this);
      }
      
      private function setActiveDebrisParticle(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._debrisParticles.length)
         {
            AbstractParticle(this._debrisParticles[_loc2_]).collidable = false;
            AbstractParticle(this._debrisParticles[_loc2_]).velocity = new Vector2();
            _loc2_++;
         }
         var _loc3_:Point = this.debrisPosition;
         this._debrisParticle = this._debrisParticles[param1];
         if(this._debrisParticle)
         {
            this._debrisParticle.collidable = true;
            this._debrisParticle.position = new Vector2(_loc3_.x,_loc3_.y);
         }
      }
      
      public function get debrisAmount() : Number
      {
         return this._debrisAmount;
      }
      
      override public function updateBeforeAPE() : void
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
      
      private function onTrainCollision(param1:CollisionEvent) : void
      {
         var _loc3_:WorldObject = null;
         var _loc4_:* = false;
         var _loc2_:Object = Lookup.getParent(param1.collidingItem);
         if(_loc2_ is WorldObject && _loc2_ != this)
         {
            _loc3_ = _loc2_ as WorldObject;
            _loc4_ = _loc3_.state == WorldObjectState.ALIVE;
            _loc3_.destroy(this);
            if(_loc3_.hasDebris)
            {
               this._smokeTime = DEFAULT_SMOKE_TIME;
            }
            if(_loc4_ && _loc3_.hasDebris)
            {
               this.debrisAmount += DEBRIS_INCREMENT;
               dispatchEvent(new Event("firstImpact"));
            }
         }
      }
      
      private function updateCrashing() : void
      {
      }
      
      private function updateBeforeAPENormal() : void
      {
         var _loc4_:int = 0;
         if(this._trainParticle)
         {
            this._trainParticle.angle = rotation;
            this._trainParticle.angularVelocity = 0;
            this._trainParticle.velocity = new Vector2(x - this._trainParticle.px,y - this._trainParticle.py);
         }
         if(this.debris_mc)
         {
            _loc4_ = int(Math.round(this._debrisAmount));
            if(this.debris_mc.currentFrame != _loc4_ + 1)
            {
               this.setActiveDebrisParticle(_loc4_);
               this.debris_mc.gotoAndStop(_loc4_ + 1);
            }
         }
         var _loc1_:Point = this.debrisPosition;
         var _loc2_:Number = Number(_loc1_.x);
         var _loc3_:Number = Number(_loc1_.y);
         this._debrisParticle.velocity = new Vector2(_loc2_ - this._debrisParticle.px,_loc3_ - this._debrisParticle.py);
         this._debrisParticle.angularVelocity = 0;
         this.debrisAmount -= DEBRIS_DECREMENT;
      }
      
      override protected function addParticle(param1:AbstractParticle) : void
      {
         if(!this._trainParticle)
         {
            this._trainParticle = param1 as RigidRectangle;
            this.registerParticle(this._trainParticle);
            this._trainParticle.collidable = false;
         }
      }
      
      private function updateNormal() : void
      {
         var _loc1_:Point = null;
         var _loc2_:Number = NaN;
         if(this._smokeTime > 0)
         {
            --this._smokeTime;
            _loc1_ = position;
            _loc2_ = rotation / 180 * Math.PI;
            _loc1_.x += Math.cos(_loc2_) * 20;
            _loc1_.y += Math.sin(_loc2_) * 20;
            Engine.instance.particleEngine.spawnSmoke(_loc1_);
         }
      }
      
      override public function update() : void
      {
         switch(this._state)
         {
            case TrainSystem.S_NORMAL:
               this.updateNormal();
               break;
            case TrainSystem.S_CRASHING:
               this.updateCrashing();
         }
      }
      
      private function updateBeforeAPECrashing() : void
      {
         if(this._trainParticle)
         {
            this._trainParticle.angle = rotation;
            this._trainParticle.angularVelocity = 0;
            this._trainParticle.velocity = new Vector2(x - this._trainParticle.px,y - this._trainParticle.py);
         }
      }
      
      private function createDebrisParticles() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         if(this.debris_mc)
         {
            _loc1_ = int(this.debris_mc.totalFrames);
            _loc2_ = 1;
            while(_loc2_ <= _loc1_)
            {
               this.debris_mc.gotoAndStop(_loc2_);
               _loc3_ = !!this.debris_mc.hit_mc ? this.debris_mc.hit_mc.width / 2 : this.debris_mc.width / 2;
               this._debrisParticle = new RigidCircle(x,y,_loc3_,false,TRAIN_MASS,0,1);
               this._debrisParticle.collidable = false;
               this.registerParticle(this._debrisParticle);
               this._debrisParticles.push(this._debrisParticle);
               _loc2_++;
            }
            this.debrisAmount = 0;
         }
         else
         {
            trace("debris_mc not found");
         }
      }
      
      public function disable() : void
      {
         if(this._trainParticle)
         {
            this._trainParticle.collidable = false;
         }
         if(this._debrisParticle)
         {
            this._debrisParticle.collidable = false;
         }
         this._state = "null";
      }
      
      public function set debrisAmount(param1:Number) : void
      {
         this._debrisAmount = param1;
         this._debrisAmount = Math.max(0,this._debrisAmount);
         if(this.debris_mc)
         {
            this._debrisAmount = Math.min(this.debris_mc.totalFrames - 1,this._debrisAmount);
         }
      }
      
      public function get trainParticle() : RigidRectangle
      {
         return this._trainParticle;
      }
      
      private function registerParticle(param1:AbstractParticle) : void
      {
         param1.mass = TRAIN_MASS;
         param1.addEventListener(CollisionEvent.COLLIDE,this.onTrainCollision,false,0,true);
         Engine.instance.addParticle(param1);
         Lookup.register(param1,this);
      }
   }
}
