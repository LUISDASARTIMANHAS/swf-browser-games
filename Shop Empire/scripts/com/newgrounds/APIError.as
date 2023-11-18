package com.newgrounds
{
   import flash.utils.Dictionary;
   
   public class APIError
   {
      
      public static const aliases:Array = new Array("UNKNOWN_ERROR","INVALID_API_ID","MISSING_PARAM","INVALID_STAT_ID","INVALID_COMMAND_ID","FLASH_ADS_NOT_APPROVED","PERMISSION_DENIED","IDENTIFICATION_REQUIRED","INVALID_EMAIL_ADDRESS","BANNED_USER","SESSION_EXPIRED","INVALID_SCORE","INVALID_MEDAL","INVALID_FOLDER","FILE_NOT_FOUND","SITE_ID_REQUIRED","UPLOAD_IN_PROGRESS","USER_CANCELLED","CONFIRM_REQUEST","CONNECTION_FAILED");
      
      private static const always_caps:Array = new Array("API","URL","ID");
      
      public static const error_codes:Object = init_codes();
      
      public static const error_names:Object = init_names();
       
      
      public var code:Number = 0;
      
      public var message:String;
      
      public var name:String;
      
      public var alias:String;
      
      public function APIError(param1:*, param2:String)
      {
         super();
         if(param1 is String)
         {
            param1 = error_codes[param1];
         }
         else if(!(param1 is uint))
         {
            param1 = 0;
         }
         this.code = param1;
         this.message = param2;
         this.name = error_names[param1];
         this.alias = aliases[param1];
      }
      
      public static function init_codes() : Dictionary
      {
         var _loc1_:Dictionary = new Dictionary();
         var _loc2_:uint = 0;
         while(_loc2_ < aliases.length)
         {
            _loc1_[aliases[_loc2_]] = _loc2_;
            _loc2_++;
         }
         return _loc1_;
      }
      
      private static function init_names() : Array
      {
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         var _loc1_:Array = new Array();
         var _loc2_:uint = 0;
         while(_loc2_ < aliases.length)
         {
            _loc3_ = aliases[_loc2_].toLowerCase().split("_");
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               _loc3_[_loc4_] = _loc3_[_loc4_].substr(0,1).toUpperCase() + _loc3_[_loc4_].substr(1,_loc3_[_loc4_].length);
               for each(_loc5_ in always_caps)
               {
                  if(_loc3_[_loc4_].toUpperCase() == _loc5_)
                  {
                     _loc3_[_loc4_] = _loc3_[_loc4_].toUpperCase();
                  }
               }
               _loc4_++;
            }
            _loc1_[_loc2_] = _loc3_.join(" ");
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function isError() : Boolean
      {
         return true;
      }
   }
}
