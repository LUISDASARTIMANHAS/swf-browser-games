package org.flixel.plugin.photonstorm
{
   public class FlxMath
   {
      
      public static var getrandmax:int = int.MAX_VALUE;
      
      private static var mr:uint = 0;
      
      private static var cosTable:Array = new Array();
      
      private static var sinTable:Array = new Array();
      
      private static var coefficient1:Number = Math.PI / 4;
      
      private static const RADTODEG:Number = 180 / Math.PI;
      
      private static const DEGTORAD:Number = Math.PI / 180;
       
      
      public function FlxMath()
      {
         super();
      }
      
      public static function atan2(param1:Number, param2:Number) : Number
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc3_:Number = param1;
         var _loc4_:Number = 3 * coefficient1;
         if(_loc3_ < 0)
         {
            _loc3_ = -_loc3_;
         }
         if(param2 >= 0)
         {
            _loc5_ = (param2 - _loc3_) / (param2 + _loc3_);
            _loc6_ = coefficient1 - coefficient1 * _loc5_;
         }
         else
         {
            _loc5_ = (param2 + _loc3_) / (_loc3_ - param2);
            _loc6_ = _loc4_ - coefficient1 * _loc5_;
         }
         return param1 < 0 ? -_loc6_ : _loc6_;
      }
      
      public static function sinCosGenerator(param1:uint, param2:Number = 1, param3:Number = 1, param4:Number = 1) : void
      {
         var _loc5_:Number = param2;
         var _loc6_:Number = param3;
         var _loc7_:Number = param4 * Math.PI / param1;
         cosTable = new Array();
         sinTable = new Array();
         var _loc8_:uint = 0;
         while(_loc8_ < param1)
         {
            _loc6_ -= _loc5_ * _loc7_;
            _loc5_ += _loc6_ * _loc7_;
            cosTable[_loc8_] = _loc6_;
            sinTable[_loc8_] = _loc5_;
            _loc8_++;
         }
      }
      
      public static function getSinTable() : Array
      {
         return sinTable;
      }
      
      public static function getCosTable() : Array
      {
         return cosTable;
      }
      
      public static function sqrt(param1:Number) : Number
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(isNaN(param1))
         {
            return NaN;
         }
         var _loc2_:Number = 0.002;
         var _loc3_:Number = param1 * 0.25;
         if(param1 == 0)
         {
            return 0;
         }
         do
         {
            _loc5_ = param1 / _loc3_;
            _loc3_ = (_loc3_ + _loc5_) * 0.5;
            if((_loc4_ = _loc3_ - _loc5_) < 0)
            {
               _loc4_ = -_loc4_;
            }
         }
         while(_loc4_ > _loc2_);
         
         return _loc3_;
      }
      
      public static function miniRand() : int
      {
         var _loc1_:uint = mr;
         _loc1_++;
         _loc1_ *= 75;
         do
         {
            _loc1_ %= 65537;
            _loc1_--;
         }
         while(false);
         
         ++mr;
         if(mr == 65536)
         {
            mr = 0;
         }
         return _loc1_;
      }
      
      public static function rand(param1:Number = NaN, param2:Number = NaN, param3:Array = null) : int
      {
         var _loc4_:int = 0;
         if(isNaN(param1))
         {
            param1 = 0;
         }
         if(isNaN(param2))
         {
            param2 = getrandmax;
         }
         if(param1 == param2)
         {
            return param1;
         }
         if(param3 != null)
         {
            param3.sort(Array.NUMERIC);
            do
            {
               if(param1 < param2)
               {
                  _loc4_ = param1 + Math.random() * (param2 - param1);
               }
               else
               {
                  _loc4_ = param2 + Math.random() * (param1 - param2);
               }
            }
            while(param3.indexOf(_loc4_) >= 0);
            
            return _loc4_;
         }
         if(param1 < param2)
         {
            return param1 + Math.random() * (param2 - param1);
         }
         return param2 + Math.random() * (param1 - param2);
      }
      
      public static function randFloat(param1:Number = NaN, param2:Number = NaN) : Number
      {
         if(isNaN(param1))
         {
            param1 = 0;
         }
         if(isNaN(param2))
         {
            param2 = getrandmax;
         }
         if(param1 == param2)
         {
            return param1;
         }
         if(param1 < param2)
         {
            return param1 + Math.random() * (param2 - param1 + 1);
         }
         return param2 + Math.random() * (param1 - param2 + 1);
      }
      
      public static function chanceRoll(param1:uint = 50) : Boolean
      {
         if(param1 <= 0)
         {
            return false;
         }
         if(param1 >= 100)
         {
            return true;
         }
         if(Math.random() * 100 >= param1)
         {
            return false;
         }
         return true;
      }
      
      public static function maxAdd(param1:int, param2:int, param3:int) : int
      {
         param1 += param2;
         if(param1 > param3)
         {
            param1 = param3;
         }
         return param1;
      }
      
      public static function wrapValue(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:int = 0;
         param1 = Math.abs(param1);
         param2 = Math.abs(param2);
         param3 = Math.abs(param3);
         return int((param1 + param2) % param3);
      }
      
      public static function vectorLength(param1:Number, param2:Number) : Number
      {
         return Math.sqrt(param1 * param1 + param2 * param2);
      }
      
      public static function dotProduct(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return param1 * param3 + param2 * param4;
      }
      
      public static function randomSign() : Number
      {
         return Math.random() > 0.5 ? 1 : -1;
      }
      
      public static function asDegrees(param1:Number) : Number
      {
         return param1 * RADTODEG;
      }
      
      public static function asRadians(param1:Number) : Number
      {
         return param1 * DEGTORAD;
      }
   }
}
