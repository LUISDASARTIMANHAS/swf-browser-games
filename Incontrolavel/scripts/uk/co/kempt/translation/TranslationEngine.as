package uk.co.kempt.translation
{
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.text.TextField;
   
   public class TranslationEngine extends EventDispatcher
   {
      
      public static const DEBUG:Boolean = false;
      
      private static const FILE_SUFFIX:String = ".xml";
      
      private static var INSTANCE:TranslationEngine;
      
      public static var TRANSLATION_PATH:String = "http://www.unstoppable-game.com/translations/1/";
      
      private static const LANGUAGES:Array = ["EN","FR","NL","DE","IT","ES_CA","RU","DK","FI","NO","SE","ES_AM","PT_BR","JP","KR","CN"];
      
      public static var GLOBAL_FONT_NAME:String = "Arial Unicode MS";
       
      
      private var _translationLoader:URLLoader;
      
      private var _data:XML;
      
      private var _ready:Boolean;
      
      private var _currentLanguage:String;
      
      public function TranslationEngine()
      {
         super();
         if(!INSTANCE)
         {
            INSTANCE = this;
         }
         else
         {
            trace("Attempted to create multiple instances of TranslationEngine");
         }
      }
      
      public static function hasLanguage(param1:String) : Boolean
      {
         return LANGUAGES.indexOf(param1.toUpperCase()) != -1;
      }
      
      public static function get instance() : TranslationEngine
      {
         return INSTANCE = INSTANCE || new TranslationEngine();
      }
      
      public function get ready() : Boolean
      {
         return this._ready;
      }
      
      public function translateByInstanceName(param1:TextField) : void
      {
         var _loc4_:* = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc2_:String = String(param1.name);
         this.debug("requested textfield translation for " + _loc2_);
         var _loc3_:String = this.getTranslation(_loc2_);
         if(!_loc3_ && Boolean(param1.text.length))
         {
            if(DEBUG)
            {
               this.debug("no translation found for " + _loc2_);
            }
            else if(this.ready)
            {
               trace("Warning: no translation for " + _loc2_);
            }
            _loc3_ = String(param1.text);
         }
         if(_loc3_)
         {
            _loc4_ = "<font face=\"" + this.getFontName() + "\">";
            _loc5_ = "</font>";
            _loc6_ = _loc4_ + _loc3_ + _loc5_;
            param1.embedFonts = true;
            param1.htmlText = _loc6_;
         }
      }
      
      public function init(param1:String) : void
      {
         if(!hasLanguage(param1))
         {
            trace("not a valid language: " + param1);
         }
         this._currentLanguage = param1.toLowerCase();
         var _loc2_:String = TRANSLATION_PATH + this.currentLanguage + FILE_SUFFIX;
         var _loc3_:URLLoader = new URLLoader();
         _loc3_.addEventListener(Event.COMPLETE,this.onLoadComplete,false,0,true);
         _loc3_.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadError,false,0,true);
         _loc3_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadError,false,0,true);
         this._translationLoader = _loc3_;
         _loc3_.load(new URLRequest(_loc2_));
      }
      
      public function get currentLanguage() : String
      {
         return this._currentLanguage;
      }
      
      private function getFontName() : String
      {
         return GLOBAL_FONT_NAME;
      }
      
      private function debug(... rest) : void
      {
         if(DEBUG)
         {
            trace("TranslationEngine: " + rest.join(","));
         }
      }
      
      public function getTranslation(param1:String) : String
      {
         var tResults:XMLList = null;
         var tResult:String = null;
         var pStringID:String = param1;
         this.debug("requested translation for " + pStringID);
         if(!this._data)
         {
            return null;
         }
         tResults = this._data.t.(@id == pStringID);
         tResult = tResults.length() > 0 ? tResults[0] : null;
         return tResult;
      }
      
      private function onLoadError(param1:Event) : void
      {
         this._ready = true;
         trace("Error");
         dispatchEvent(new ErrorEvent(ErrorEvent.ERROR));
      }
      
      private function onLoadComplete(param1:Event) : void
      {
         var _loc2_:URLLoader = param1.currentTarget as URLLoader;
         this.debug("Complete");
         this._data = new XML(_loc2_.data);
         this._ready = true;
         trace("~~~ TRANSLATION XML ~~~");
         trace(this._data);
         trace("~~~~~~~~~~~~~~~~~~~~~~~");
         dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}
