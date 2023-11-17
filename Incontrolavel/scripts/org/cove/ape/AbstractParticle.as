package org.cove.ape
{
   import flash.display.DisplayObject;
   import flash.utils.getQualifiedClassName;
   
   public class AbstractParticle extends AbstractItem
   {
       
      
      private var _collidable:Boolean;
      
      private var _maxRadius:Number;
      
      private var _type:String;
      
      private var forceList:Array;
      
      private var _kfr:Number;
      
      internal var prev:Vector2;
      
      private var collision:Collision;
      
      internal var interval:Interval;
      
      private var _invMass:Number;
      
      private var _typesToIgnore:Array;
      
      private var _invalidated:Boolean;
      
      private var _mass:Number;
      
      private var temp:Vector2;
      
      private var _friction:Number;
      
      internal var curr:Vector2;
      
      private var forces:Vector2;
      
      public var maxRadiusSquared:Number;
      
      private var _multisample:int;
      
      private var _center:Vector2;
      
      private var _fixed:Boolean;
      
      internal var samp:Vector2;
      
      private var firstCollision:Boolean;
      
      public function AbstractParticle(param1:Number, param2:Number, param3:Boolean, param4:Number, param5:Number, param6:Number)
      {
         super();
         if(getQualifiedClassName(this) == "org.cove.ape::AbstractParticle")
         {
            throw new ArgumentError("AbstractParticle can\'t be instantiated directly");
         }
         this.interval = new Interval(0,0);
         this.curr = new Vector2(param1,param2);
         this.prev = new Vector2(param1,param2);
         this.samp = new Vector2();
         this.temp = new Vector2();
         this.fixed = param3;
         this.forces = new Vector2();
         this.forceList = new Array();
         this.collision = new Collision(new Vector2(),new Vector2());
         this.collidable = true;
         this.firstCollision = false;
         this.mass = param4;
         this.elasticity = param5;
         this.friction = param6;
         setStyle();
         this._center = new Vector2();
         this._multisample = 0;
         this._type = "default";
         this._typesToIgnore = [];
         this.maxRadius = 0;
      }
      
      public function get friction() : Number
      {
         return this._friction;
      }
      
      private function accumulateForces() : void
      {
         var _loc1_:IForce = null;
         var _loc2_:int = int(this.forceList.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = this.forceList[_loc3_];
            this.forces.plusEquals(_loc1_.getValue(this._invMass));
            _loc3_++;
         }
         var _loc4_:Array;
         _loc2_ = int((_loc4_ = APEngine.forces).length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _loc4_[_loc3_];
            this.forces.plusEquals(_loc1_.getValue(this._invMass));
            _loc3_++;
         }
      }
      
      public function set friction(param1:Number) : void
      {
         if(param1 < 0 || param1 > 1)
         {
            throw new ArgumentError("Legal friction must be >= 0 and <=1");
         }
         this._friction = param1;
      }
      
      internal function get invMass() : Number
      {
         return this.fixed ? 0 : this._invMass;
      }
      
      public function get px() : Number
      {
         return this.curr.x;
      }
      
      public function get py() : Number
      {
         return this.curr.y;
      }
      
      public function setDisplay(param1:DisplayObject, param2:Number = 0, param3:Number = 0, param4:Number = 0) : void
      {
         displayObject = param1;
         displayObjectRotation = param4;
         displayObjectOffset = new Vector2(param2,param3);
      }
      
      public function set px(param1:Number) : void
      {
         this.curr.x = param1;
         this.prev.x = param1;
         this._invalidated = true;
      }
      
      public function resetFirstCollision() : void
      {
         this.firstCollision = false;
      }
      
      public function set py(param1:Number) : void
      {
         this.curr.y = param1;
         this.prev.y = param1;
         this._invalidated = true;
      }
      
      public function getCurrentPosition() : Vector2
      {
         return this.curr;
      }
      
      public function set fixed(param1:Boolean) : void
      {
         this._fixed = param1;
      }
      
      public function get fixed() : Boolean
      {
         return this._fixed;
      }
      
      public function get invalidated() : Boolean
      {
         return this._invalidated;
      }
      
      protected function checkIgnorance(param1:AbstractParticle) : Boolean
      {
         return this.typesToIgnore.indexOf(param1.type) != -1 || param1.typesToIgnore.indexOf(this.type) != -1;
      }
      
      internal function getComponents(param1:Vector2) : Collision
      {
         var _loc2_:Vector2 = this.velocity;
         var _loc3_:Number = param1.dot(_loc2_);
         this.collision.vn = param1.mult(_loc3_);
         this.collision.vt = _loc2_.minus(this.collision.vn);
         return this.collision;
      }
      
      private function clearForces() : void
      {
         this.forceList.length = 0;
         this.forces.setTo(0,0);
      }
      
      public function get maxRadius() : Number
      {
         return this._maxRadius;
      }
      
      internal function testParticleEvents(param1:AbstractParticle) : void
      {
         if(hasEventListener(CollisionEvent.COLLIDE))
         {
            dispatchEvent(new CollisionEvent(CollisionEvent.COLLIDE,false,false,param1));
         }
         if(Boolean(hasEventListener(CollisionEvent.FIRST_COLLIDE)) && !this.firstCollision)
         {
            this.firstCollision = true;
            dispatchEvent(new CollisionEvent(CollisionEvent.FIRST_COLLIDE,false,false,param1));
         }
      }
      
      internal function initDisplay() : void
      {
         displayObject.x = displayObjectOffset.x;
         displayObject.y = displayObjectOffset.y;
         displayObject.rotation = displayObjectRotation;
         sprite.addChild(displayObject);
      }
      
      public function get multisample() : int
      {
         return this._multisample;
      }
      
      public function set invalidated(param1:Boolean) : void
      {
         this._invalidated = param1;
      }
      
      public function set maxRadius(param1:Number) : void
      {
         this._maxRadius = param1;
         this.maxRadiusSquared = this.maxRadius * this.maxRadius;
      }
      
      internal function resolveCollision(param1:Vector2, param2:Vector2, param3:Vector2, param4:Number, param5:int, param6:AbstractParticle) : void
      {
         this.testParticleEvents(param6);
         if(this.fixed || !solid || !param6.solid)
         {
            return;
         }
         if(this.checkIgnorance(param6))
         {
            return;
         }
         this.curr.copy(this.samp);
         this.curr.plusEquals(param1);
         this.velocity = param2;
      }
      
      public function get position() : Vector2
      {
         return new Vector2(this.curr.x,this.curr.y);
      }
      
      public function get velocityMagnitudeSquared() : Number
      {
         var _loc1_:Vector2 = this.velocity;
         return _loc1_.x * _loc1_.x + _loc1_.y * _loc1_.y;
      }
      
      public function get elasticity() : Number
      {
         return this._kfr;
      }
      
      public function set collidable(param1:Boolean) : void
      {
         this._collidable = param1;
      }
      
      public function set velocity(param1:Vector2) : void
      {
         this.prev = this.curr.minus(param1);
      }
      
      public function set multisample(param1:int) : void
      {
         this._multisample = param1;
      }
      
      public function addForce(param1:IForce) : void
      {
         this.forceList.push(param1);
      }
      
      public function get center() : Vector2
      {
         this._center.setTo(this.px,this.py);
         return this._center;
      }
      
      public function set type(param1:String) : void
      {
         this._type = param1;
      }
      
      public function update(param1:Number) : void
      {
         if(this.fixed)
         {
            return;
         }
         this.accumulateForces();
         this.temp.copy(this.curr);
         var _loc2_:Vector2 = this.velocity.plus(this.forces.multEquals(param1));
         this.curr.plusEquals(_loc2_.multEquals(APEngine.damping));
         this.prev.copy(this.temp);
         this.clearForces();
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function get velocity() : Vector2
      {
         return this.curr.minus(this.prev);
      }
      
      public function get typesToIgnore() : Array
      {
         return this._typesToIgnore;
      }
      
      public function set position(param1:Vector2) : void
      {
         this.curr.copy(param1);
         this.prev.copy(param1);
         this._invalidated = true;
      }
      
      public function set mass(param1:Number) : void
      {
         if(param1 <= 0)
         {
            throw new ArgumentError("mass may not be set <= 0");
         }
         this._mass = param1;
         this._invMass = 1 / this._mass;
      }
      
      public function set elasticity(param1:Number) : void
      {
         this._kfr = param1;
      }
      
      public function get collidable() : Boolean
      {
         return this._collidable;
      }
      
      public function get mass() : Number
      {
         return this._mass;
      }
   }
}
