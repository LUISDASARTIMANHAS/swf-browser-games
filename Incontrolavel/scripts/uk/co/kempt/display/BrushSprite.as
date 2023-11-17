package uk.co.kempt.display
{
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import org.cove.ape.CollisionEvent;
   import org.cove.ape.RigidCircle;
   import org.cove.ape.RigidRectangle;
   import org.cove.ape.Vector2;
   import uk.co.kempt.Engine;
   import uk.co.kempt.data.BrushInfo;
   import uk.co.kempt.data.Lookup;
   import uk.co.kempt.data.ParticleType;
   import uk.co.kempt.utils.GarbageUtil;
   import uk.co.kempt.world.WorldObject;
   import uk.co.kempt.world.statics.Restriction;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.display.BrushSprite")]
   public class BrushSprite extends Sprite
   {
      
      private static const ROTATION_SPEED_LIMIT:Number = 8;
      
      private static const RANGE_SIZE:Number = 80;
      
      private static const ACCELERATION:Number = 0.24;
      
      private static const Y_MIN:Number = 0;
      
      private static const VELOCITY_MIN:Number = 0;
      
      private static const VELOCITY_MAX:Number = 6;
      
      private static const RADIUS:Number = 20 / 2;
      
      private static const MIN_DIST:Number = 12;
      
      private static const X_MIN:Number = 0;
      
      private static const X_MAX:Number = Engine.GAME_WIDTH;
      
      private static const Y_MAX:Number = Engine.GAME_HEIGHT;
       
      
      private var _staticCollisionImminent:Boolean;
      
      private var _speed:Number = 0;
      
      private var _rangedParticle:RigidRectangle;
      
      private var _targetAlpha:Number;
      
      public var anim:MovieClip;
      
      private var _targetFrame:int;
      
      private var _hitRestriction:Boolean;
      
      private var _collisions:Array;
      
      private var _rotation:Number = 0;
      
      private var _particle:RigidCircle;
      
      public function BrushSprite()
      {
         super();
         Engine.instance.addParticle(this.particle);
         Engine.instance.addParticle(this.rangedParticle);
         this.anim.gotoAndStop(1);
         MovieClip(this.anim["blackBrush"]).alpha = 0;
         this._hitRestriction = false;
      }
      
      public function positionAt(param1:DisplayObject) : void
      {
         var _loc2_:Number = param1.rotation / 180 * Math.PI;
         var _loc3_:Number = -10;
         x = param1.x + Math.cos(_loc2_) * _loc3_;
         y = param1.y + Math.sin(_loc2_) * _loc3_;
         this.rotation = param1.rotation;
      }
      
      public function get particle() : RigidCircle
      {
         return this._particle = this._particle || this.createParticle();
      }
      
      public function die() : void
      {
         this._collisions = null;
         this._particle = null;
         this._rangedParticle = null;
         GarbageUtil.kill(this);
      }
      
      public function update(param1:Point) : void
      {
         x = this.particle.px;
         y = this.particle.py;
         var _loc2_:Number = param1.x - x;
         var _loc3_:Number = param1.y - y;
         var _loc4_:Number = Math.atan2(_loc3_,_loc2_) / Math.PI * 180;
         var _loc5_:Number = this.angleDistance(_loc4_,this.rotation);
         var _loc6_:Number = Number(Math.sqrt(Math.pow(_loc2_,2) + Math.pow(_loc3_,2)));
         this.checkCollisions();
         var _loc7_:Number = Math.pow(this._speed,2) / (2 * ACCELERATION);
         if(_loc6_ < _loc7_ + MIN_DIST + this._speed)
         {
            this._speed += -ACCELERATION;
         }
         else
         {
            this._speed += ACCELERATION;
         }
         _loc5_ = Number(Math.max(-ROTATION_SPEED_LIMIT,Math.min(ROTATION_SPEED_LIMIT,_loc5_)));
         this._speed = Math.max(VELOCITY_MIN,Math.min(VELOCITY_MAX,this._speed));
         this.rotation += _loc5_;
         var _loc8_:Number = this.rotation / 180 * Math.PI;
         x += Math.cos(_loc8_) * this._speed;
         y += Math.sin(_loc8_) * this._speed;
         this._targetFrame = !!this.collisions.length ? int(this.anim.totalFrames) : 1;
         this._targetAlpha = this._staticCollisionImminent ? 1 : 0;
      }
      
      private function onRangeCollisionEvent(param1:CollisionEvent) : void
      {
         var _loc3_:WorldObject = null;
         var _loc2_:Object = Lookup.getParent(param1.collidingItem);
         if(_loc2_ is WorldObject)
         {
            _loc3_ = _loc2_ as WorldObject;
            _loc3_.flagAsInSight();
         }
      }
      
      public function reset(param1:BrushInfo = null) : void
      {
         this._speed = 0;
         if(param1)
         {
            param1.apply(this);
         }
      }
      
      private function onBrushCollisionEvent(param1:CollisionEvent) : void
      {
         var _loc3_:WorldObject = null;
         var _loc2_:Object = Lookup.getParent(param1.collidingItem);
         if(_loc2_ is WorldObject)
         {
            _loc3_ = _loc2_ as WorldObject;
            this.collisions.push(_loc3_);
         }
         if(_loc2_ is Restriction)
         {
            this._staticCollisionImminent = true;
            this._hitRestriction = true;
         }
      }
      
      public function updateBeforeAPE() : void
      {
         this._staticCollisionImminent = false;
         this.particle.velocity = new Vector2(x - this.particle.px,y - this.particle.py);
         this.particle.angularVelocity = 0;
         if(this.particle.velocity.x != 0 || this.particle.velocity.y != 0)
         {
            this._collisions = null;
         }
         var _loc1_:Number = RANGE_SIZE / 2;
         this.rangedParticle.angle = this.rotation;
         this.rangedParticle.position = new Vector2(x + _loc1_ * Math.cos(this.rangedParticle.radian),y + _loc1_ * Math.sin(this.rangedParticle.radian));
         this.rangedParticle.velocity = new Vector2();
         this.rangedParticle.angularVelocity = 0;
      }
      
      private function get collisions() : Array
      {
         return this._collisions = this._collisions || [];
      }
      
      public function push(param1:Point) : void
      {
         x += param1.x;
         y += param1.y;
      }
      
      private function createRangedParticle() : RigidRectangle
      {
         var _loc1_:RigidRectangle = new RigidRectangle(x,y,RANGE_SIZE,8);
         _loc1_.solid = false;
         _loc1_.addEventListener(CollisionEvent.COLLIDE,this.onRangeCollisionEvent);
         Lookup.register(_loc1_,this);
         return _loc1_;
      }
      
      public function get staticCollisionImminent() : Boolean
      {
         return this._staticCollisionImminent;
      }
      
      private function angleDistance(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = param1 - param2;
         while(_loc3_ > 180)
         {
            _loc3_ -= 360;
         }
         while(_loc3_ < -180)
         {
            _loc3_ += 360;
         }
         return _loc3_;
      }
      
      public function prepareForSimulation() : void
      {
      }
      
      public function updateAnyway() : void
      {
         if(this.anim.currentFrame > this._targetFrame)
         {
            this.anim.prevFrame();
         }
         else if(this.anim.currentFrame < this._targetFrame)
         {
            this.anim.nextFrame();
         }
         var _loc1_:Sprite = MovieClip(this.anim["blackBrush"]);
         _loc1_.blendMode = BlendMode.LAYER;
         _loc1_.alpha += (this._targetAlpha - _loc1_.alpha) / 5;
      }
      
      public function get rangedParticle() : RigidRectangle
      {
         return this._rangedParticle = this._rangedParticle || this.createRangedParticle();
      }
      
      private function createParticle() : RigidCircle
      {
         var _loc1_:RigidCircle = new RigidCircle(x,y,RADIUS);
         _loc1_.solid = true;
         _loc1_.type = ParticleType.BRUSH;
         _loc1_.addEventListener(CollisionEvent.COLLIDE,this.onBrushCollisionEvent);
         Lookup.register(_loc1_,this);
         return _loc1_;
      }
      
      private function checkCollisions() : void
      {
         var _loc1_:WorldObject = null;
         if(this.collisions.length)
         {
            _loc1_ = this.collisions[0];
            _loc1_.flagAsDestroyed();
         }
      }
      
      public function get hitRestriction() : Boolean
      {
         return this._hitRestriction;
      }
      
      override public function set rotation(param1:Number) : void
      {
         this._rotation = param1;
         super.rotation = this.rotation;
      }
      
      override public function get rotation() : Number
      {
         return this._rotation;
      }
   }
}
