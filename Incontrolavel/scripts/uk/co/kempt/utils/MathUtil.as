package uk.co.kempt.utils
{
   import flash.geom.Point;
   
   public class MathUtil
   {
       
      
      public function MathUtil()
      {
         super();
      }
      
      public static function radianThreePointAverage(param1:Point, param2:Point, param3:Point) : Number
      {
         return radianAverage(radianAngle(param1,param2),radianAngle(param2,param3));
      }
      
      public static function radianAverage(param1:Number, param2:Number) : Number
      {
         return param1 + radianDiff(param1,param2);
      }
      
      public static function radianAngle(param1:Point, param2:Point) : Number
      {
         var _loc3_:Point = param2.subtract(param1);
         return Math.atan2(_loc3_.y,_loc3_.x);
      }
      
      public static function distance(param1:Point, param2:Point) : Number
      {
         return param2.subtract(param1).length;
      }
      
      public static function radianDiff(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = param2 - param1;
         while(_loc3_ > Math.PI)
         {
            _loc3_ -= Math.PI * 2;
         }
         while(_loc3_ < -Math.PI)
         {
            _loc3_ += Math.PI * 2;
         }
         return _loc3_;
      }
   }
}
