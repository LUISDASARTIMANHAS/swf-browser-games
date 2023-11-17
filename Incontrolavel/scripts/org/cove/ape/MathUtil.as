package org.cove.ape
{
   internal final class MathUtil
   {
      
      internal static var ONE_EIGHTY_OVER_PI:Number = 180 / Math.PI;
      
      internal static var PI_OVER_ONE_EIGHTY:Number = Math.PI / 180;
       
      
      public function MathUtil()
      {
         super();
      }
      
      internal static function clamp(param1:Number, param2:Number, param3:Number) : Number
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
      
      internal static function sign(param1:Number) : int
      {
         if(param1 < 0)
         {
            return -1;
         }
         return 1;
      }
   }
}
