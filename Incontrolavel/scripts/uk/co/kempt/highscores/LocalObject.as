package uk.co.kempt.highscores
{
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.SharedObject;
   import flash.net.URLRequest;
   import flash.system.Security;
   
   public class LocalObject
   {
      
      public static var EXTERNAL_INIT_CALLBACK:Function;
      
      public static var ESO:SharedObject;
      
      public static var LSO:SharedObject;
      
      protected static var NAME:String;
      
      public static var LOADER:Loader;
      
      public static var EXTERNAL_SO_PATH:String;
      
      public static const EXTERNAL_SO_FILE_PATH:String = "swf/so_as3.swf";
       
      
      public function LocalObject()
      {
         super();
      }
      
      private static function onIOError(param1:IOErrorEvent) : void
      {
         debug("IOError");
         addListeners(LOADER.contentLoaderInfo,false);
      }
      
      private static function addListeners(param1:LoaderInfo, param2:Boolean = true) : void
      {
         var _loc3_:Function = param2 ? param1.addEventListener : param1.removeEventListener;
         _loc3_.call(null,Event.COMPLETE,onLoadComplete);
         _loc3_.call(null,IOErrorEvent.IO_ERROR,onIOError);
      }
      
      public static function setVar(param1:String, param2:*) : void
      {
         if(ESO)
         {
            ESO.data._setData = true;
            ESO.data[param1] = param2;
            ESO.flush();
         }
         LSO.data._setData = true;
         LSO.data[param1] = param2;
         LSO.flush();
      }
      
      public static function getVar(param1:String) : *
      {
         return LSO.data[param1];
      }
      
      public static function init(param1:String, param2:Function, param3:String) : void
      {
         NAME = param1;
         EXTERNAL_INIT_CALLBACK = param2;
         Security.allowDomain(param3);
         EXTERNAL_SO_PATH = param3 + EXTERNAL_SO_FILE_PATH;
         LSO = SharedObject.getLocal(param1,"/");
         LOADER = new Loader();
         addListeners(LOADER.contentLoaderInfo);
         LOADER.load(new URLRequest(EXTERNAL_SO_PATH));
      }
      
      protected static function debug(... rest) : void
      {
         trace("LocalObject> " + rest.join(", "));
      }
      
      private static function onLoadComplete(param1:Event) : void
      {
         var tSharedObjectSWF:Object;
         var s:String = null;
         var e:Event = param1;
         debug("external shared object loaded");
         tSharedObjectSWF = Object(LOADER.content);
         try
         {
            debug("attemping to get shared object data");
            ESO = tSharedObjectSWF.getSO(NAME);
            if(ESO.data._setData)
            {
               debug("copying data from external shared object");
               for(s in ESO.data)
               {
                  LSO.data[s] = ESO.data[s];
               }
               LSO.flush();
            }
            else if(LSO.data._setData)
            {
               debug("copying data from local shared object");
               for(s in LSO.data)
               {
                  ESO.data[s] = LSO.data[s];
               }
               ESO.flush();
            }
            debug("finished copying shared object data");
         }
         catch(e:Error)
         {
            debug("getting shared object data failed, " + e.message);
         }
         if(EXTERNAL_INIT_CALLBACK != null)
         {
            EXTERNAL_INIT_CALLBACK.call(null);
         }
         else
         {
            debug("no external init");
         }
         addListeners(LOADER.contentLoaderInfo,false);
      }
   }
}
