package com.mindgame.framework
{
   public class Emath
   {
       
      
      public function Emath()
      {
         super();
      }
      
      public static function distance(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         var _loc5_:Number = param3 - param1;
         var _loc6_:Number = param4 - param2;
         return Math.sqrt(_loc5_ * _loc5_ + _loc6_ * _loc6_);
      }
      
      public static function random(param1:Number, param2:Number) : Number
      {
         return Math.round(Math.random() * (param2 - param1)) + param1;
      }
      
      public static function equal(param1:Number, param2:Number, param3:Number = 0.00001) : Boolean
      {
         return Math.abs(param1 - param2) <= param3;
      }
      
      public static function getAngle(param1:Number, param2:Number, param3:Number, param4:Number, param5:Boolean = true) : Number
      {
         var _loc6_:Number = param3 - param1;
         var _loc7_:Number = param4 - param2;
         var _loc8_:Number = Number(Math.atan2(_loc7_,_loc6_));
         if(param5)
         {
            if(_loc8_ < 0)
            {
               _loc8_ = Math.PI * 2 + _loc8_;
            }
            else if(_loc8_ >= Math.PI * 2)
            {
               _loc8_ -= Math.PI * 2;
            }
         }
         return _loc8_;
      }
      
      public static function getAngleDeg(param1:Number, param2:Number, param3:Number, param4:Number, param5:Boolean = true) : Number
      {
         var _loc6_:Number = param3 - param1;
         var _loc7_:Number = param4 - param2;
         var _loc8_:Number = Math.atan2(_loc7_,_loc6_) / Math.PI * 180;
         if(param5)
         {
            if(_loc8_ < 0)
            {
               _loc8_ = 360 + _loc8_;
            }
            else if(_loc8_ >= 360)
            {
               _loc8_ -= 360;
            }
         }
         return _loc8_;
      }
      
      public static function toDegrees(param1:Number) : Number
      {
         return param1 * 180 / Math.PI;
      }
      
      public static function toRadians(param1:Number) : Number
      {
         return param1 * Math.PI / 180;
      }
      
      public static function toPercent(param1:Number, param2:Number) : Number
      {
         return param1 / param2 * 100;
      }
      
      public static function fromPercent(param1:Number, param2:Number) : Number
      {
         return param1 * param2 / 100;
      }
   }
}
