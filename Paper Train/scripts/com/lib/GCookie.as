package com.lib
{
   import flash.external.ExternalInterface;
   
   public class GCookie
   {
      
      private static const FUNCTION_GETCOOKIE:String = "document.insertScript = function ()" + "{ " + "if (document.snw_getCookie==null)" + "{" + "snw_getCookie = function (name)" + "{" + "var nameEQ = name + \'=\';" + "var cookieData = unescape(document.cookie);" + "var ca = cookieData.split(\';\');" + "for(var i=0;i < ca.length;i++) {" + "var c = ca[i];" + "while (c.charAt(0)==\' \') c = c.substring(1,c.length);" + "if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);" + "}" + "return null;" + "}" + "}" + "}";
      
      private static var INITIALIZED:Boolean = false;
      
      private static const FUNCTION_SETCOOKIE:String = "document.insertScript = function ()" + "{ " + "if (document.snw_setCookie==null)" + "{" + "snw_setCookie = function (name, value, days)" + "{" + "if (days) {" + "var date = new Date();" + "date.setTime(date.getTime()+(days*24*60*60*1000));" + "var expires = \'; expires=\'+date.toGMTString();" + "}" + "else var expires = \'\';" + "document.cookie = name+\'=\'+value+expires+\'; path=/\';" + "}" + "}" + "}";
       
      
      public function GCookie()
      {
         super();
      }
      
      private static function init() : void
      {
         try
         {
            ExternalInterface.call(FUNCTION_GETCOOKIE);
         }
         catch(e:*)
         {
         }
         try
         {
            ExternalInterface.call(FUNCTION_SETCOOKIE);
         }
         catch(e:*)
         {
         }
         INITIALIZED = true;
      }
      
      public static function erase(param1:String) : void
      {
         var name:String = param1;
         if(!INITIALIZED)
         {
            init();
         }
         try
         {
            ExternalInterface.call("snw_setCookie",name,"",-1);
         }
         catch(e:*)
         {
         }
      }
      
      public static function set(param1:String, param2:Object, param3:int) : void
      {
         var name:String = param1;
         var value:Object = param2;
         var days:int = param3;
         if(!INITIALIZED)
         {
            init();
         }
         try
         {
            ExternalInterface.call("snw_setCookie",name,value,days);
         }
         catch(e:*)
         {
         }
      }
      
      public static function get(param1:String) : Object
      {
         var name:String = param1;
         if(!INITIALIZED)
         {
            init();
         }
         try
         {
            return ExternalInterface.call("snw_getCookie",name);
         }
         catch(e:*)
         {
            return null;
         }
      }
   }
}
