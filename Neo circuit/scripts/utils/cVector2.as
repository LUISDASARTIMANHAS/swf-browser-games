package utils
{
   public class cVector2
   {
      
      public static const RAD_TO_DEG:Number = 180 / Math.PI;
      
      public static const DEG_TO_RAD:Number = Math.PI / 180;
       
      
      public var x:Number;
      
      public var y:Number;
      
      private var m_length:Number;
      
      private var m_v1:cVector2;
      
      private var m_v2:cVector2;
      
      private var m_oldX:Number;
      
      private var m_oldY:Number;
      
      public function cVector2(param1:Number = 0, param2:Number = 0)
      {
         super();
         this.x = param1;
         this.y = param2;
      }
      
      public static function angleBetween(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = param1 - param3;
         var _loc7_:Number = param2 - param4;
         if(_loc6_ == 0 && _loc7_ == 0)
         {
            return 0;
         }
         if(_loc6_ == 0)
         {
            if(_loc7_ >= 0)
            {
               return 0;
            }
            return 180;
         }
         _loc5_ = Math.atan(_loc7_ / _loc6_) * RAD_TO_DEG;
         if(param1 <= param3)
         {
            _loc5_ -= 270;
         }
         else
         {
            _loc5_ -= 90;
         }
         return _loc5_;
      }
      
      public static function is2ndInFOVof1st(param1:cVector2, param2:cVector2, param3:Number, param4:cVector2) : Boolean
      {
         var _loc5_:cVector2;
         (_loc5_ = param4.copy()).subtract(param1);
         _loc5_.normalize();
         return param2.dotOf(_loc5_) >= Math.cos(param3 / 2);
      }
      
      public static function rotToHeading(param1:Number, param2:cVector2) : void
      {
         var _loc3_:Number = Number(Math.cos(param1));
         var _loc4_:Number = Number(Math.sin(param1));
         param2.x = _loc3_;
         param2.y = _loc4_;
      }
      
      public function add(param1:cVector2) : void
      {
         this.x += param1.x;
         this.y += param1.y;
      }
      
      public function subtract(param1:cVector2) : void
      {
         this.x -= param1.x;
         this.y -= param1.y;
      }
      
      public function multiply(param1:Number) : void
      {
         this.x *= param1;
         this.y *= param1;
      }
      
      public function divide(param1:Number) : void
      {
         if(param1 == 0)
         {
            Debug.Assert(false,"Vector::dividedBy() - Illegal Divide by Zero!");
         }
         else
         {
            this.x /= param1;
            this.y /= param1;
         }
      }
      
      public function set(param1:Number, param2:Number) : void
      {
         this.x = param1;
         this.y = param2;
      }
      
      public function isEqualComponents(param1:int, param2:int) : Boolean
      {
         return param1 == this.x && param2 == this.y;
      }
      
      public function isEqual(param1:cVector2) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         return param1.x == this.x && param1.y == this.y;
      }
      
      public function isZero() : Boolean
      {
         return this.x == 0 || this.y == 0;
      }
      
      public function normalize() : void
      {
         if(this.length != 0)
         {
            this.x /= this.m_length;
            this.y /= this.m_length;
         }
      }
      
      public function truncate(param1:Number) : void
      {
         if(this.lengthSquared > param1 * param1)
         {
            this.normalize();
            this.multiply(param1);
         }
      }
      
      public function get length() : Number
      {
         if(this.m_oldX != this.x || this.m_oldY != this.y)
         {
            this.m_oldX = this.x;
            this.m_oldY = this.y;
            this.m_length = Math.sqrt(this.x * this.x + this.y * this.y);
         }
         return this.m_length;
      }
      
      public function get lengthSquared() : Number
      {
         return this.x * this.x + this.y * this.y;
      }
      
      public function toString() : String
      {
         return "(" + this.x + ", " + this.y + ")";
      }
      
      public function distance(param1:cVector2) : Number
      {
         var _loc2_:Number = this.x - param1.x;
         var _loc3_:Number = this.y - param1.y;
         return Math.sqrt(_loc2_ * _loc2_ + _loc3_ * _loc3_);
      }
      
      public function distanceSquared(param1:cVector2) : Number
      {
         var _loc2_:Number = this.x - param1.x;
         var _loc3_:Number = this.y - param1.y;
         return _loc2_ * _loc2_ + _loc3_ * _loc3_;
      }
      
      public function fromCommaSeparatedString(param1:String) : void
      {
         if(param1 == null)
         {
            param1 = "0,0";
         }
         var _loc2_:Array = param1.split(",");
         if(_loc2_.length >= 2)
         {
            this.x = parseFloat(_loc2_[0]);
            this.y = parseFloat(_loc2_[1]);
         }
      }
      
      public function toCommaSeparatedString() : String
      {
         return this.x + "," + this.y;
      }
      
      public function copy() : cVector2
      {
         var _loc1_:cVector2 = new cVector2(this.x,this.y);
         _loc1_.m_length = this.m_length;
         _loc1_.m_oldX = this.x;
         _loc1_.m_oldY = this.y;
         return _loc1_;
      }
      
      public function toRotation() : Number
      {
         var _loc1_:Number = Number(Math.atan(this.y / this.x));
         if(this.y < 0 && this.x > 0)
         {
            return _loc1_;
         }
         if(this.y < 0 && this.x < 0 || this.y > 0 && this.x < 0)
         {
            return _loc1_ + 3.141592653589793;
         }
         return _loc1_ + 6.283185307179586;
      }
      
      public function wrapAround(param1:cVector2, param2:cVector2) : void
      {
         if(this.x > param2.x)
         {
            this.x = param1.x + (this.x - param2.x);
         }
         else if(this.x < param1.x)
         {
            this.x = param2.x + this.x;
         }
         if(this.y < param1.y)
         {
            this.y = param2.y + this.y;
         }
         else if(this.y > param2.y)
         {
            this.y = param1.y + (this.y - param2.y);
         }
      }
      
      public function reverse() : void
      {
         this.x = -this.x;
         this.y = -this.y;
      }
      
      public function sign(param1:cVector2) : int
      {
         if(this.y * param1.x > this.x * param1.y)
         {
            return -1;
         }
         return 1;
      }
      
      public function isParallelTo(param1:cVector2) : Boolean
      {
         this.m_v1 = this.copy();
         this.m_v1.normalize();
         this.m_v2 = param1.copy();
         this.m_v2.normalize();
         return this.m_v1.x == this.m_v2.x && this.m_v1.y == this.m_v2.y || this.m_v1.x == -this.m_v2.x && this.m_v1.y == -this.m_v2.y;
      }
      
      public function perpendicular() : void
      {
         this.x = -this.y;
         this.y = this.x;
      }
      
      public function dotOf(param1:cVector2) : Number
      {
         return this.x * param1.x + this.y * param1.y;
      }
      
      public function crossOf(param1:cVector2) : Number
      {
         return this.x * param1.y - this.y * param1.x;
      }
      
      public function angleTo(param1:cVector2) : Number
      {
         return Math.acos(this.dotOf(param1) / (this.length * param1.length));
      }
      
      public function perpDotOf(param1:cVector2) : Number
      {
         this.perpendicular();
         return this.dotOf(param1);
      }
      
      public function projectionOn(param1:cVector2) : cVector2
      {
         this.m_v1 = param1.copy();
         this.m_v1.multiply(this.dotOf(param1) / param1.dotOf(param1));
         return this.m_v1;
      }
      
      public function isInsideRegion(param1:cVector2, param2:cVector2) : Boolean
      {
         return !(this.x < param1.x || this.x > param1.x + param2.x || this.y < param1.y || this.y > param1.y + param2.y);
      }
   }
}
