package com.mindgame.framework
{
   public class XORRandom
   {
      
      private static const MAX_RATIO:Number = 1 / uint.MAX_VALUE;
      
      private static var r:uint = Math.random() * uint.MAX_VALUE;
       
      
      public function XORRandom()
      {
         super();
      }
      
      public static function randomRangeInt(param1:int, param2:int) : int
      {
         return int(random * (param2 - param1 + 1)) + param1;
      }
      
      public static function randomRangeNumber(param1:Number, param2:Number) : Number
      {
         return random * (param2 - param1) + param1;
      }
      
      public static function get random() : Number
      {
         r ^= r << 21;
         r ^= r >>> 35;
         r ^= r << 4;
         return r * MAX_RATIO;
      }
   }
}
