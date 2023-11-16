package com.lib
{
   public class GString
   {
       
      
      public function GString()
      {
         super();
      }
      
      public static function trim(param1:String) : String
      {
         var _loc2_:String = param1;
         while(Boolean(_loc2_.length) && _loc2_.indexOf(" ") == 0)
         {
            _loc2_ = String(_loc2_.substr(1,_loc2_.length - 1));
         }
         while(Boolean(_loc2_.length) && _loc2_.lastIndexOf(" ") == _loc2_.length - 1)
         {
            _loc2_ = String(_loc2_.substr(0,_loc2_.length - 1));
         }
         return _loc2_;
      }
      
      public static function formatTime(param1:int) : String
      {
         var _loc2_:* = uint(param1 / 60000);
         var _loc3_:* = uint(param1 / 1000) % 60;
         var _loc4_:* = uint(param1 % 1000 / 10);
         return prefill(_loc2_,"0",2) + ":" + prefill(_loc3_,"0",2) + ":" + prefill(_loc4_,"0",2);
      }
      
      public static function prefill(param1:String, param2:String, param3:int) : *
      {
         var _loc4_:* = param1;
         while(_loc4_.length < param3)
         {
            _loc4_ = param2 + _loc4_;
         }
         return _loc4_;
      }
   }
}
