package uk.co.kempt.display
{
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.Dictionary;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.display.UnstoppableLoader")]
   public class UnstoppableLoader extends Sprite
   {
      
      public static const LOADING:String = "loading";
      
      public static const LOADED:String = "loaded";
       
      
      private var _loaders:Dictionary;
      
      private var _startBytes:int;
      
      public var anim:MovieClip;
      
      private var _state:String;
      
      private var _loaderInfos:Array;
      
      public function UnstoppableLoader()
      {
         super();
         if(stage)
         {
            this.init();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage,false,0,true);
         }
      }
      
      private function updateLoading() : void
      {
         var _loc3_:LoaderInfo = null;
         var _loc8_:int = 0;
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         while(_loc5_ < this._loaderInfos.length)
         {
            _loc3_ = this._loaderInfos[_loc5_];
            if(_loc3_.bytesTotal <= 0)
            {
               _loc4_ = true;
            }
            else
            {
               _loc1_ += _loc3_.bytesTotal;
               _loc2_ += _loc3_.bytesLoaded;
               if(!_loc3_.content)
               {
                  _loc4_ = true;
               }
            }
            _loc5_++;
         }
         if(_loc1_ == 0)
         {
            return;
         }
         if(this._startBytes <= 0)
         {
            if(_loc2_ < _loc1_)
            {
               this._startBytes = _loc2_;
            }
            else
            {
               this._startBytes = 1;
            }
         }
         var _loc6_:Number = (_loc2_ - this._startBytes) / (_loc1_ - this._startBytes);
         var _loc7_:int = int(Math.round(1 + (this.anim.totalFrames - 1) * _loc6_));
         if(this.anim.currentFrame < _loc7_)
         {
            _loc8_ = int(Math.round(Math.max(1,Math.min(3,(_loc7_ - this.anim.currentFrame) / 2))));
            this.anim.gotoAndStop(this.anim.currentFrame + _loc8_);
         }
         if(!_loc4_ && _loc2_ == _loc1_ && this.anim.currentFrame >= this.anim.totalFrames)
         {
            this._state = LOADED;
            dispatchEvent(new Event(Event.COMPLETE));
         }
      }
      
      public function get ready() : Boolean
      {
         return this.state == LOADED;
      }
      
      public function removeLoaderInfo(param1:LoaderInfo) : void
      {
         var _loc2_:int = int(this._loaderInfos.indexOf(param1));
         if(_loc2_ != -1)
         {
            this._loaderInfos.splice(_loc2_);
         }
      }
      
      public function getLoader(param1:String) : Loader
      {
         return this._loaders[param1];
      }
      
      public function load(param1:String) : void
      {
         var _loc2_:Loader = new Loader();
         var _loc3_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         var _loc4_:URLRequest = new URLRequest(param1);
         _loc2_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onIOErrorEvent);
         _loc2_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoaderCompleteEvent);
         _loc2_.load(_loc4_,_loc3_);
         this._loaderInfos.push(_loc2_.contentLoaderInfo);
         this._loaders[param1] = _loc2_;
         this._state = LOADING;
      }
      
      private function updateLoaded() : void
      {
      }
      
      public function addLoaderInfo(param1:LoaderInfo) : void
      {
         if(param1)
         {
            this._loaderInfos.push(param1);
            this._state = LOADING;
         }
      }
      
      private function onEnterFrameEvent(param1:Event) : void
      {
         this.update();
      }
      
      public function update() : void
      {
         switch(this._state)
         {
            case LOADING:
               this.updateLoading();
               break;
            case LOADED:
               this.updateLoaded();
         }
      }
      
      private function onIOErrorEvent(param1:IOErrorEvent) : void
      {
      }
      
      public function get state() : String
      {
         return this._state;
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this.init();
      }
      
      private function onLoaderCompleteEvent(param1:Event) : void
      {
      }
      
      private function init() : void
      {
         this._loaderInfos = [];
         this._loaders = new Dictionary();
         this._state = LOADING;
         this.anim.stop();
         addEventListener(Event.ENTER_FRAME,this.onEnterFrameEvent,false,0,true);
      }
   }
}
