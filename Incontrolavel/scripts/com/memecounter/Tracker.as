package com.memecounter
{
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.system.*;
   import flash.utils.*;
   
   public class Tracker
   {
      
      private static var ori_dom:String;
      
      private static var lurl:String;
      
      public static const ORI_DOM:String = "ori_dom";
      
      public static const LOCALHOST:String = "localhost";
      
      private static var _isReady:Boolean = false;
      
      private static var _isInited:Boolean = false;
      
      private static const MAX_ATTEMPTS:int = 3;
      
      public static var c:uint;
      
      public static var d:String = "";
      
      public static var a:uint = 0;
      
      public static var root:DisplayObject;
      
      public static var mcEvent:Function;
      
      public static var fpv:String = "";
      
      public static const LOCAL:String = "Local";
      
      private static var l:Loader;
      
      private static const ERROR_URL:String = "http://error.distralytics.com/comms/";
      
      public static const TRACKER_PATH:String = "/node/tracking/trackerAS3.swf";
      
      public static var da:Array = ["distralytics.com","distralytics.co.uk"];
      
      private static var tracker:MovieClip;
       
      
      public function Tracker()
      {
         super();
      }
      
      private static function loadComplete(param1:Event) : void
      {
         var e:Event = param1;
         try
         {
            tracker = e.target.content;
            tracker.init(Tracker,root);
         }
         catch(e:Error)
         {
            trace("Memecounter error: unable to access tracker object due to security sandbox.");
         }
      }
      
      public static function init(param1:uint, param2:DisplayObject) : void
      {
         var _loc3_:uint = 0;
         if(!_isInited)
         {
            _isInited = true;
            c = param1;
            root = param2;
            _loc3_ = 0;
            while(_loc3_ < da.length)
            {
               Security.allowDomain("*" + da[_loc3_]);
               Security.allowDomain(da[_loc3_]);
               Security.allowDomain(c + ".c." + da[_loc3_]);
               Security.allowDomain("*." + da[_loc3_]);
               _loc3_++;
            }
            ori_dom = !!root.loaderInfo.parameters.hasOwnProperty(ORI_DOM) ? String(root.loaderInfo.parameters[ORI_DOM]) : "";
            d = ori_dom != "" ? ori_dom : (new LocalConnection().domain.indexOf(LOCALHOST) == -1 ? String(new LocalConnection().domain) : LOCAL);
            fpv = Capabilities.version.split(" ")[1].split(",")[0];
            lurl = TRACKER_PATH + "?c=" + c + "&r=" + Math.floor(Math.random() * 10000000000) + "&d=" + d + "&p=" + fpv + "&as=3";
            l = new Loader();
            l.contentLoaderInfo.addEventListener(Event.INIT,loadComplete);
            l.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,loadError);
            lc();
            mcEvent = kvEvent;
         }
      }
      
      public static function trackerReady() : void
      {
         _isReady = true;
      }
      
      public static function get isReady() : Boolean
      {
         return _isReady;
      }
      
      public static function mcClick(param1:String, param2:String = null) : void
      {
         if(_isReady)
         {
            tracker.mcClick(param1,param2);
         }
      }
      
      private static function loadError(param1:Event) : void
      {
         var _loc2_:URLLoader = null;
         var _loc3_:URLRequest = null;
         var _loc4_:URLVariables = null;
         ++a;
         if(a < MAX_ATTEMPTS)
         {
            lc();
         }
         else
         {
            _loc2_ = new URLLoader();
            _loc3_ = new URLRequest(ERROR_URL);
            _loc4_ = new URLVariables();
            _loc3_.method = URLRequestMethod.GET;
            _loc3_.data = _loc4_;
            _loc4_.error = "Unable to load SWF";
            _loc4_.c = c;
            _loc4_.fd = root.loaderInfo.loaderURL;
            _loc4_.p = fpv;
            _loc4_.mv = "3.3.x";
            _loc4_.r = Math.random();
            _loc2_.load(_loc3_);
         }
      }
      
      public static function kvCountry() : String
      {
         if(_isReady)
         {
            return tracker.kvCountry();
         }
         return "";
      }
      
      public static function kvClick(param1:uint) : void
      {
         if(_isReady)
         {
            tracker.kvClick(param1);
         }
      }
      
      public static function kvEvent(param1:*) : void
      {
         if(_isReady)
         {
            tracker.kvEvent(param1);
         }
      }
      
      private static function lc() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = String(da[a % da.length]);
         if(_loc2_.charAt(0) === ".")
         {
            _loc1_ = "http://" + _loc2_.substr(1,_loc2_.length - 1) + lurl;
         }
         else
         {
            _loc1_ = "http://" + c + ".c." + _loc2_ + lurl;
         }
         Security.allowDomain(_loc1_);
         l.load(new URLRequest(_loc1_));
      }
   }
}
