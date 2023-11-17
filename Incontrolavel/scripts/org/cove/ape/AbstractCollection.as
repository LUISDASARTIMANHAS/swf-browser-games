package org.cove.ape
{
   import flash.display.Sprite;
   import flash.utils.getQualifiedClassName;
   
   public class AbstractCollection
   {
       
      
      private var _sprite:Sprite;
      
      private var _particles:Vector.<AbstractParticle>;
      
      private var _isParented:Boolean;
      
      private var _constraints:Vector.<AbstractConstraint>;
      
      public function AbstractCollection()
      {
         super();
         if(getQualifiedClassName(this) == "org.cove.ape::AbstractCollection")
         {
            throw new ArgumentError("AbstractCollection can\'t be instantiated directly");
         }
         this._isParented = false;
         this._particles = new Vector.<AbstractParticle>();
         this._constraints = new Vector.<AbstractConstraint>();
      }
      
      public function removeConstraint(param1:AbstractConstraint) : void
      {
         var _loc2_:int = int(this._constraints.indexOf(param1));
         if(_loc2_ == -1)
         {
            return;
         }
         this._constraints.splice(_loc2_,1);
         param1.cleanup();
      }
      
      public function getAll() : Vector.<Object>
      {
         return Vector.<Object>(this._particles).concat(Vector.<Object>(this._constraints));
      }
      
      internal function checkCollisionsVsCollection(param1:AbstractCollection) : void
      {
         var _loc5_:AbstractParticle = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:AbstractParticle = null;
         var _loc10_:SpringConstraint = null;
         var _loc11_:SpringConstraint = null;
         var _loc12_:int = 0;
         var _loc2_:int = int(this._particles.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(!((_loc5_ = this._particles[_loc3_]) == null || !_loc5_.collidable))
            {
               _loc6_ = int(param1.particles.length);
               _loc7_ = 0;
               while(_loc7_ < _loc6_)
               {
                  if((_loc9_ = param1.particles[_loc7_]) != null && _loc9_.collidable)
                  {
                     CollisionDetector.test(_loc5_,_loc9_);
                  }
                  _loc7_++;
               }
               _loc8_ = int(param1.constraints.length);
               _loc7_ = 0;
               while(_loc7_ < _loc8_)
               {
                  if((_loc10_ = SpringConstraint(param1.constraints[_loc7_])) != null && _loc10_.collidable && !_loc10_.isConnectedTo(_loc5_))
                  {
                     _loc10_.scp.updatePosition();
                     CollisionDetector.test(_loc5_,_loc10_.scp);
                  }
                  _loc7_++;
               }
            }
            _loc3_++;
         }
         var _loc4_:int = int(this._constraints.length);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            if(!((_loc11_ = SpringConstraint(this._constraints[_loc3_])) == null || !_loc11_.collidable))
            {
               _loc6_ = int(param1.particles.length);
               _loc12_ = 0;
               while(_loc12_ < _loc6_)
               {
                  if((_loc9_ = param1.particles[_loc12_]) != null && _loc9_.collidable && !_loc11_.isConnectedTo(_loc9_))
                  {
                     _loc11_.scp.updatePosition();
                     CollisionDetector.test(_loc9_,_loc11_.scp);
                  }
                  _loc12_++;
               }
            }
            _loc3_++;
         }
      }
      
      public function get sprite() : Sprite
      {
         if(this._sprite != null)
         {
            return this._sprite;
         }
         if(APEngine.container == null)
         {
            throw new Error("The container property of the APEngine class has not been set");
         }
         this._sprite = new Sprite();
         APEngine.container.addChild(this._sprite);
         return this._sprite;
      }
      
      internal function checkInternalCollisions() : void
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:AbstractParticle = null;
         var _loc9_:AbstractParticle = null;
         var _loc10_:int = 0;
         var _loc1_:Vector.<AbstractParticle> = new Vector.<AbstractParticle>();
         var _loc2_:int = int(this._particles.length);
         var _loc4_:Vector.<AbstractParticle> = new Vector.<AbstractParticle>();
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            if((_loc8_ = this._particles[_loc6_]).collidable)
            {
               _loc1_.push(_loc8_);
               if(!_loc8_.fixed && (_loc8_.invalidated || _loc8_.velocity.x != 0 || _loc8_.velocity.y != 0))
               {
                  _loc8_.invalidated = false;
                  _loc4_.push(_loc8_);
               }
            }
            _loc6_++;
         }
         _loc2_ = int(_loc1_.length);
         _loc3_ = int(_loc4_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc8_ = _loc4_[_loc5_];
            _loc6_ = 0;
            while(_loc6_ < _loc2_)
            {
               _loc9_ = _loc1_[_loc6_];
               if(_loc8_ != _loc9_)
               {
                  CollisionDetector.test(_loc8_,_loc9_);
               }
               _loc6_++;
            }
            _loc5_++;
         }
      }
      
      public function addParticle(param1:AbstractParticle) : void
      {
         this.particles.push(param1);
         if(this.isParented)
         {
            param1.init();
         }
      }
      
      public function init() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.particles.length)
         {
            this.particles[_loc1_].init();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._constraints.length)
         {
            this._constraints[_loc1_].init();
            _loc1_++;
         }
      }
      
      internal function satisfyConstraints() : void
      {
         var _loc3_:AbstractConstraint = null;
         var _loc1_:int = int(this._constraints.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._constraints[_loc2_];
            _loc3_.resolve();
            _loc2_++;
         }
      }
      
      internal function get isParented() : Boolean
      {
         return this._isParented;
      }
      
      public function paint() : void
      {
         var _loc1_:AbstractParticle = null;
         var _loc4_:SpringConstraint = null;
         var _loc2_:int = int(this._particles.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = this._particles[_loc3_];
            if(!_loc1_.fixed || _loc1_.alwaysRepaint)
            {
               _loc1_.paint();
            }
            _loc3_++;
         }
         _loc2_ = int(this._constraints.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(!(_loc4_ = SpringConstraint(this._constraints[_loc3_])).fixed || _loc4_.alwaysRepaint)
            {
               _loc4_.paint();
            }
            _loc3_++;
         }
      }
      
      public function addConstraint(param1:AbstractConstraint) : void
      {
         this._constraints.push(param1);
         if(this.isParented)
         {
            param1.init();
         }
      }
      
      internal function set isParented(param1:Boolean) : void
      {
         this._isParented = param1;
      }
      
      public function removeParticle(param1:AbstractParticle) : void
      {
         var _loc2_:int = int(this.particles.indexOf(param1));
         if(_loc2_ == -1)
         {
            return;
         }
         this.particles.splice(_loc2_,1);
         param1.cleanup();
      }
      
      public function cleanup() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.particles.length)
         {
            this.particles[_loc1_].cleanup();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._constraints.length)
         {
            this._constraints[_loc1_].cleanup();
            _loc1_++;
         }
      }
      
      public function get particles() : Vector.<AbstractParticle>
      {
         return this._particles;
      }
      
      internal function integrate(param1:Number) : void
      {
         var _loc4_:AbstractParticle = null;
         var _loc2_:int = int(this._particles.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            (_loc4_ = this._particles[_loc3_]).update(param1);
            _loc3_++;
         }
      }
      
      public function get constraints() : Vector.<AbstractConstraint>
      {
         return this._constraints;
      }
   }
}
