package org.cove.ape
{
   public class RigidItem extends AbstractParticle
   {
       
      
      private var _radian:Number;
      
      private var _range:Number;
      
      private var torque:Number;
      
      private var _frictionalCoefficient:Number;
      
      private var _prevRadian:Number;
      
      private var _angularVelocity:Number;
      
      private var _mi:Number;
      
      public function RigidItem(param1:Number, param2:Number, param3:Number, param4:Boolean, param5:Number = 1, param6:Number = -1, param7:Number = 0.3, param8:Number = 0.2, param9:Number = 0, param10:Number = 0)
      {
         this._range = param3;
         this._frictionalCoefficient = param8;
         this._radian = param9;
         this._angularVelocity = param10;
         this.torque = 0;
         if(param4)
         {
            param5 = Number(Number.POSITIVE_INFINITY);
            this._mi = Number.POSITIVE_INFINITY;
         }
         else if(param6 == -1)
         {
            this._mi = param5;
         }
         else
         {
            this._mi = param6;
         }
         super(param1,param2,param4,param5,param7,0);
         setStyle(0,16777215,1,0,1);
      }
      
      public function set radian(param1:Number) : void
      {
         this._radian = param1;
         this.setAxes(param1);
      }
      
      public function get range() : Number
      {
         return this._range;
      }
      
      override public function update(param1:Number) : void
      {
         this.radian += this.angularVelocity * APEngine.damping;
         super.update(param1);
         this.torque = 0;
      }
      
      public function addTorque(param1:*) : *
      {
         this.angularVelocity += param1;
         if(Math.abs(param1) > 0.03)
         {
         }
      }
      
      override public function init() : void
      {
         cleanup();
         if(displayObject != null)
         {
            initDisplay();
         }
         else
         {
            this.drawShape(sprite.graphics);
         }
         this.paint();
      }
      
      public function getVelocityOn(param1:Vector2) : *
      {
         var _loc2_:* = param1.minus(samp);
         var _loc3_:* = _loc2_.normalize();
         var _loc4_:* = this.angularVelocity * _loc2_.magnitude();
         var _loc5_:*;
         return (_loc5_ = new Vector2(-_loc3_.y,_loc3_.x).multEquals(_loc4_)).plusEquals(velocity);
      }
      
      public function get frictionalCoefficient() : Number
      {
         return this._frictionalCoefficient;
      }
      
      public function get angle() : Number
      {
         return this.radian * MathUtil.ONE_EIGHTY_OVER_PI;
      }
      
      public function get mi() : Number
      {
         return this._mi;
      }
      
      override public function paint() : void
      {
         sprite.x = curr.x;
         sprite.y = curr.y;
         sprite.rotation = this.angle;
      }
      
      public function get angularVelocity() : Number
      {
         return this._angularVelocity;
      }
      
      public function get radian() : Number
      {
         return this._radian;
      }
      
      public function set frictionalCoefficient(param1:*) : void
      {
         this._frictionalCoefficient = param1;
      }
      
      public function resolveRigidCollision(param1:Number, param2:*) : void
      {
         if(fixed || !solid || !param2.solid)
         {
            return;
         }
         if(checkIgnorance(param2))
         {
            return;
         }
         this.addTorque(param1);
      }
      
      public function set angle(param1:Number) : void
      {
         this.radian = param1 * MathUtil.PI_OVER_ONE_EIGHTY;
      }
      
      public function setAxes(param1:Number) : void
      {
      }
      
      public function captures(param1:Vector2) : Boolean
      {
         var _loc2_:* = param1.distance(samp) - this.range;
         if(_loc2_ <= 0)
         {
            return true;
         }
         return false;
      }
      
      public function drawShape(param1:*) : *
      {
      }
      
      public function set angularVelocity(param1:Number) : void
      {
         this._angularVelocity = param1;
      }
   }
}
