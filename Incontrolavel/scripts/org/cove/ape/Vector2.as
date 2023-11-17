package org.cove.ape
{
   public class Vector2
   {
       
      
      private var _y:Number = 0;
      
      private var _x:Number = 0;
      
      private var _magnitude:Number = NaN;
      
      public function Vector2(param1:Number = 0, param2:Number = 0)
      {
         super();
         this.x = param1;
         this.y = param2;
      }
      
      public function cross(param1:Vector2) : Number
      {
         return this.x * param1.y - this.y * param1.x;
      }
      
      public function times(param1:Vector2) : Vector2
      {
         return new Vector2(this.x * param1.x,this.y * param1.y);
      }
      
      public function dot(param1:Vector2) : Number
      {
         return this.x * param1.x + this.y * param1.y;
      }
      
      public function set y(param1:Number) : void
      {
         this._y = param1;
         this.invalidate();
      }
      
      public function normalize() : Vector2
      {
         var _loc1_:Number = this.magnitude();
         if(_loc1_ == 0)
         {
            _loc1_ = 0.0001;
         }
         return this.mult(1 / _loc1_);
      }
      
      public function minusEquals(param1:Vector2) : Vector2
      {
         this.x -= param1.x;
         this.y -= param1.y;
         return this;
      }
      
      public function magnitude() : Number
      {
         return !!isNaN(this._magnitude) ? (this._magnitude = Math.sqrt(this.x * this.x + this.y * this.y)) : this._magnitude;
      }
      
      public function set x(param1:Number) : void
      {
         this._x = param1;
         this.invalidate();
      }
      
      public function multEquals(param1:Number) : Vector2
      {
         this.x *= param1;
         this.y *= param1;
         return this;
      }
      
      public function plus(param1:Vector2) : Vector2
      {
         return new Vector2(this.x + param1.x,this.y + param1.y);
      }
      
      public function get y() : Number
      {
         return this._y;
      }
      
      public function normalizeEquals() : Vector2
      {
         var _loc1_:Number = this.magnitude();
         if(_loc1_ == 0)
         {
            _loc1_ = 0.0001;
         }
         return this.multEquals(1 / _loc1_);
      }
      
      public function minus(param1:Vector2) : Vector2
      {
         return new Vector2(this.x - param1.x,this.y - param1.y);
      }
      
      public function toString() : String
      {
         return "(" + Math.floor(this.x * 100) / 100 + "," + Math.floor(this.y * 100) / 100 + ")";
      }
      
      public function copy(param1:Vector2) : void
      {
         this.x = param1.x;
         this.y = param1.y;
      }
      
      public function mult(param1:Number) : Vector2
      {
         return new Vector2(this.x * param1,this.y * param1);
      }
      
      public function get x() : Number
      {
         return this._x;
      }
      
      public function plusEquals(param1:Vector2) : Vector2
      {
         this.x += param1.x;
         this.y += param1.y;
         return this;
      }
      
      private function invalidate() : void
      {
         this._magnitude = NaN;
      }
      
      public function distance(param1:Vector2) : Number
      {
         var _loc2_:Vector2 = this.minus(param1);
         return _loc2_.magnitude();
      }
      
      public function setTo(param1:Number, param2:Number) : void
      {
         this.x = param1;
         this.y = param2;
      }
      
      public function divEquals(param1:Number) : Vector2
      {
         if(param1 == 0)
         {
            param1 = 0.0001;
         }
         this.x /= param1;
         this.y /= param1;
         return this;
      }
   }
}
