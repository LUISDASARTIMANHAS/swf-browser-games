package com.newgrounds
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   
   public class Medal
   {
      
      private static const DEFAULT_ICON:BitmapData = new BitmapData(50,50,false,0);
      
      private static const DIFFICULT_NAMES:Array = [null,"Easy","Moderate","Challenging","Difficult","Brutal"];
       
      
      private var _id:uint;
      
      private var _name:String;
      
      private var _value:uint;
      
      private var _difficultyId:uint;
      
      private var _unlocked:Boolean = false;
      
      private var _iconUrl:URLRequest;
      
      private var _iconLoader:Loader;
      
      private var _icon:BitmapData;
      
      public function Medal(param1:uint, param2:String, param3:uint, param4:uint, param5:Boolean, param6:String)
      {
         var id:uint = param1;
         var name:String = param2;
         var value:uint = param3;
         var difficulty:uint = param4;
         var unlocked:Boolean = param5;
         var iconUrl:String = param6;
         this._icon = DEFAULT_ICON;
         super();
         this._id = id;
         this._name = name;
         this._value = value;
         this._difficultyId = difficulty;
         this._unlocked = unlocked;
         if(iconUrl)
         {
            this._iconUrl = new URLRequest(iconUrl);
            this._iconLoader = new Loader();
            this._iconLoader.contentLoaderInfo.addEventListener(Event.INIT,this.onIconLoaderInit);
            this._iconLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onIconLoaderError);
            this._iconLoader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onIconLoaderError);
            this._iconLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onIconLoaderComplete);
            try
            {
               this._iconLoader.load(this._iconUrl,new LoaderContext(true));
            }
            catch(e:Error)
            {
               onIconLoaderError(null);
            }
         }
      }
      
      public static function createFromObject(param1:Object) : Medal
      {
         return new Medal(param1.medal_id,param1.medal_name,param1.medal_value,param1.medal_difficulty,param1.medal_unlocked,param1.medal_icon);
      }
      
      public function get difficulty() : String
      {
         return DIFFICULT_NAMES[this._difficultyId];
      }
      
      public function get difficultyId() : uint
      {
         return this._difficultyId;
      }
      
      public function get icon() : BitmapData
      {
         return this._icon;
      }
      
      public function get id() : uint
      {
         return this._id;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get unlocked() : Boolean
      {
         return this._unlocked;
      }
      
      public function isUnlocked() : Boolean
      {
         return this._unlocked;
      }
      
      public function set unlocked(param1:Boolean) : void
      {
         this._unlocked = param1;
      }
      
      public function get value() : uint
      {
         return this._value;
      }
      
      public function get bytesLoaded() : uint
      {
         return !!this._iconLoader ? uint(this._iconLoader.contentLoaderInfo.bytesLoaded) : 0;
      }
      
      public function get bytesTotal() : uint
      {
         return !!this._iconLoader ? uint(this._iconLoader.contentLoaderInfo.bytesTotal) : 0;
      }
      
      public function getID() : uint
      {
         return this._id;
      }
      
      public function getName() : String
      {
         return this._name;
      }
      
      public function getValue() : uint
      {
         return this._value;
      }
      
      public function getDifficulty() : String
      {
         return DIFFICULT_NAMES[this._difficultyId];
      }
      
      private function onIconLoaderInit(param1:Event) : void
      {
      }
      
      private function onIconLoaderError(param1:IOErrorEvent) : void
      {
         trace("[NewgroundsAPI WARNING] :: Failed to load medal icon for " + this.name + " (" + this._iconUrl.url.split("/").pop() + ")");
         this._iconLoader.unload();
         this._iconLoader = null;
      }
      
      private function onIconLoaderComplete(param1:Event) : void
      {
         var _loc2_:Bitmap = this._iconLoader.content as Bitmap;
         this._icon = _loc2_.bitmapData;
         this._iconLoader.unload();
         this._iconLoader = null;
      }
      
      public function unlock() : void
      {
         if(!this._unlocked)
         {
            API.unlockMedal(this._name);
         }
      }
      
      public function createIconBitmap() : Bitmap
      {
         return new Bitmap(this.icon);
      }
      
      public function toString() : String
      {
         return this._name;
      }
   }
}
