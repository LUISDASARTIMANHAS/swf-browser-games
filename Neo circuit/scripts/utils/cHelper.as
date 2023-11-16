package utils
{
   import flash.geom.Rectangle;
   
   public class cHelper
   {
      
      private static const m_bitmask:int = (1 << 31) - 1;
      
      private static var m_seed:int = (1 ^ 2147483647) & m_bitmask;
      
      public static var m_number:int = 42129;
      
      private static const DAY_IN_SECONDS:int = 3600 * 24;
      
      private static const HOUR_IN_SECONDS:int = 3600;
      
      private static const MINUTE_IN_SECONDS:int = 60;
      
      private static const m_millisecondsSubst:String = "#milliseconds#";
      
      private static const m_minuteSubst:String = "#minutes#";
      
      private static const m_secondSubst:String = "#seconds#";
       
      
      public function cHelper()
      {
         super();
      }
      
      public static function isEven(param1:int) : Boolean
      {
         return (param1 & 1) == 0;
      }
      
      public static function abs(param1:int) : int
      {
         return param1 < 0 ? int(-param1) : param1;
      }
      
      public static function abs_float(param1:Number) : Number
      {
         return param1 < 0 ? -param1 : param1;
      }
      
      public static function rad2deg(param1:Number) : Number
      {
         return param1 * 180 / Math.PI;
      }
      
      public static function isPowerOfTwo(param1:int) : Boolean
      {
         return param1 != 0 && !(param1 & param1 - 1);
      }
      
      public static function deg2rad(param1:Number) : Number
      {
         return param1 * Math.PI / 180;
      }
      
      public static function isInRange(param1:int, param2:int, param3:int) : Boolean
      {
         return param1 >= param2 && param1 <= param3;
      }
      
      public static function isInRectangle(param1:int, param2:int, param3:Rectangle) : Boolean
      {
         if(isInRange(param1,param3.x,param3.right) && isInRange(param2,param3.y,param3.bottom))
         {
            return true;
         }
         return false;
      }
      
      public static function isInRangeEx(param1:int, param2:int, param3:int) : Boolean
      {
         return param1 > param2 && param1 < param3;
      }
      
      public static function random_int(param1:int = 0, param2:int = 2147483647) : int
      {
         if(param1 <= param2)
         {
            if(param2 < int.MAX_VALUE)
            {
               param2++;
               if(false)
               {
                  §§goto(addr18);
               }
            }
            var _loc3_:int = param2 - param1;
            var _loc4_:int = _loc3_ * Math.random();
            return param1 + _loc4_;
         }
         Debug.Assert(false,"#e0as001# parameters invalid! Minimum is greater than maximum!");
         addr18:
         return 0;
      }
      
      public static function random(param1:Number, param2:Number) : Number
      {
         if(param1 > param2)
         {
            Debug.Assert(false,"#e0as002# parameters invalid! Minimum is greater than maximum!");
            return 0;
         }
         var _loc3_:Number = param2 - param1;
         var _loc4_:Number = _loc3_ * Math.random();
         return param1 + _loc4_;
      }
      
      public static function setSeed(param1:int) : void
      {
         m_seed = (param1 ^ 2147483647) & m_bitmask;
      }
      
      public static function random2() : int
      {
         m_seed = m_seed * m_number % 2147483647;
         return m_seed;
      }
      
      public static function randomSeed_int(param1:int = 0, param2:int = 2147483647) : int
      {
         if(param1 <= param2)
         {
            if(param2 < int.MAX_VALUE)
            {
               param2++;
               if(false)
               {
                  §§goto(addr18);
               }
            }
            var _loc3_:int = param2 - param1;
            var _loc4_:int = _loc3_ * Number(random2() / int.MAX_VALUE);
            return param1 + _loc4_;
         }
         Debug.Assert(false,"#e0as001# parameters invalid! Minimum is greater than maximum!");
         addr18:
         return 0;
      }
      
      public static function formatTime(param1:Number) : String
      {
         var _loc7_:String = null;
         if(param1 < 0)
         {
            param1 = 0;
         }
         var _loc2_:int = param1;
         var _loc3_:int = (param1 - _loc2_) * 100;
         var _loc4_:int;
         var _loc5_:int = (_loc4_ = _loc2_ % HOUR_IN_SECONDS) / MINUTE_IN_SECONDS;
         var _loc6_:int = _loc4_ % MINUTE_IN_SECONDS;
         return String((_loc7_ = "#minutes#:#seconds#:#milliseconds#").replace(m_minuteSubst,cStringUtil.sprintf("%02u",_loc5_)).replace(m_secondSubst,cStringUtil.sprintf("%02u",_loc6_)).replace(m_millisecondsSubst,cStringUtil.sprintf("%02u",_loc3_)));
      }
      
      public static function sin(param1:Number) : Number
      {
         var _loc2_:Number = NaN;
         if(param1 < -3.14159265)
         {
            param1 += 6.28318531;
         }
         else if(param1 > 3.14159265)
         {
            param1 -= 6.28318531;
         }
         if(param1 < 0)
         {
            _loc2_ = 1.27323954 * param1 + 0.405284735 * param1 * param1;
            if(_loc2_ < 0)
            {
               _loc2_ = 0.225 * (_loc2_ * -_loc2_ - _loc2_) + _loc2_;
            }
            else
            {
               _loc2_ = 0.225 * (_loc2_ * _loc2_ - _loc2_) + _loc2_;
            }
         }
         else
         {
            _loc2_ = 1.27323954 * param1 - 0.405284735 * param1 * param1;
            if(_loc2_ < 0)
            {
               _loc2_ = 0.225 * (_loc2_ * -_loc2_ - _loc2_) + _loc2_;
            }
            else
            {
               _loc2_ = 0.225 * (_loc2_ * _loc2_ - _loc2_) + _loc2_;
            }
         }
         return _loc2_;
      }
      
      public static function cos(param1:Number) : Number
      {
         var _loc2_:Number = NaN;
         param1 += 1.57079632;
         if(param1 > 3.14159265)
         {
            param1 -= 6.28318531;
         }
         if(param1 < 0)
         {
            _loc2_ = 1.27323954 * param1 + 0.405284735 * param1 * param1;
            if(_loc2_ < 0)
            {
               _loc2_ = 0.225 * (_loc2_ * -_loc2_ - _loc2_) + _loc2_;
            }
            else
            {
               _loc2_ = 0.225 * (_loc2_ * _loc2_ - _loc2_) + _loc2_;
            }
         }
         else
         {
            _loc2_ = 1.27323954 * param1 - 0.405284735 * param1 * param1;
            if(_loc2_ < 0)
            {
               _loc2_ = 0.225 * (_loc2_ * -_loc2_ - _loc2_) + _loc2_;
            }
            else
            {
               _loc2_ = 0.225 * (_loc2_ * _loc2_ - _loc2_) + _loc2_;
            }
         }
         return _loc2_;
      }
      
      public static function distanceSquared(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         var _loc5_:Number = param1 - param3;
         var _loc6_:Number = param2 - param4;
         return _loc5_ * _loc5_ + _loc6_ * _loc6_;
      }
      
      public static function distance(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         var _loc5_:Number = param1 - param3;
         var _loc6_:Number = param2 - param4;
         return Math.sqrt(_loc5_ * _loc5_ + _loc6_ * _loc6_);
      }
      
      public static function distanceManhatten(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return Math.abs(param1 - param3) + Math.abs(param2 - param4);
      }
      
      public static function min(param1:Number, param2:Number) : Number
      {
         return param1 < param2 ? param1 : param2;
      }
      
      public static function max(param1:Number, param2:Number) : Number
      {
         return param1 > param2 ? param1 : param2;
      }
      
      public static function TrimInt(param1:int, param2:int, param3:int) : int
      {
         if(param1 < param2)
         {
            return param2;
         }
         if(param1 > param3)
         {
            return param3;
         }
         return param1;
      }
      
      public static function TrimNumber(param1:Number, param2:Number, param3:Number) : Number
      {
         if(param1 < param2)
         {
            return param2;
         }
         if(param1 > param3)
         {
            return param3;
         }
         return param1;
      }
      
      public static function ConvertStringToRectangle(param1:String) : Rectangle
      {
         var _loc2_:Array = param1.split(",");
         return new Rectangle(_loc2_[0],_loc2_[1],_loc2_[2],_loc2_[3]);
      }
   }
}
