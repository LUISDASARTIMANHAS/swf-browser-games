package com.newgrounds.components
{
   import com.newgrounds.API;
   import com.newgrounds.APIEvent;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getQualifiedClassName;
   
   [Embed(source="/_assets/assets.swf", symbol="com.newgrounds.components.APIConnector")]
   public class APIConnector extends MovieClip
   {
       
      
      public var errorDialog:MovieClip;
      
      public var background:MovieClip;
      
      public var viewLatestButton:SimpleButton;
      
      public var closeButton:SimpleButton;
      
      public var viewAuthorizedButton:SimpleButton;
      
      private var _initialized:Boolean;
      
      private var _movieId:String;
      
      private var _encryptionKey:String;
      
      private var _movieVersion:String;
      
      private var _showConnectingPopup:Boolean = true;
      
      private var _useErrorPopup:Boolean = true;
      
      private var _medalPopup:MedalPopup;
      
      private var _popDelay:Timer;
      
      public function APIConnector()
      {
         this._popDelay = new Timer(3000,1);
         super();
         addFrameScript(0,this.frame1,6,this.frame7,7,this.frame8);
         if(parent != null && getQualifiedClassName(parent) == "fl.livepreview::LivePreviewParent")
         {
            return;
         }
         this.useErrorPopup = true;
         this.useMedalPopup = true;
         this._popDelay.addEventListener(TimerEvent.TIMER,this.errorTimerHandler);
         addEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
         if(stage)
         {
            addEventListener(Event.RENDER,this.renderHandler);
            stage.invalidate();
         }
         else
         {
            this.clear();
         }
      }
      
      public function get movieId() : String
      {
         return this._movieId;
      }
      
      public function set movieId(param1:String) : void
      {
         this._movieId = param1;
      }
      
      public function get encryptionKey() : String
      {
         return this._encryptionKey;
      }
      
      public function set encryptionKey(param1:String) : void
      {
         this._encryptionKey = param1;
      }
      
      public function get movieVersion() : String
      {
         return this._movieVersion;
      }
      
      public function set movieVersion(param1:String) : void
      {
         this._movieVersion = param1;
      }
      
      public function get debugMode() : Boolean
      {
         return API.debugMode;
      }
      
      public function set debugMode(param1:Boolean) : void
      {
         API.debugMode = true;
      }
      
      public function get useFakeSession() : Boolean
      {
         return API.getFakeSession();
      }
      
      public function set useFakeSession(param1:Boolean) : void
      {
         API.setFakeSession(true);
      }
      
      public function get useMedalPopup() : Boolean
      {
         return this._medalPopup != null;
      }
      
      public function set useMedalPopup(param1:Boolean) : void
      {
         if(param1 && !this._medalPopup)
         {
            this._medalPopup = new MedalPopup();
            addChild(this._medalPopup);
         }
         else if(!param1 && Boolean(this._medalPopup))
         {
            removeChild(this._medalPopup);
            this._medalPopup = null;
         }
      }
      
      public function get useErrorPopup() : Boolean
      {
         return this._useErrorPopup;
      }
      
      public function set useErrorPopup(param1:Boolean) : void
      {
         this._useErrorPopup = param1;
         API.addEventListener(APIEvent.API_CONNECTED,this.movieConnectedHandler);
         if(this._useErrorPopup)
         {
            API.addEventListener(APIEvent.NEW_VERSION_AVAILABLE,this.newVersionAvailableHandler);
            API.addEventListener(APIEvent.HOST_BLOCKED,this.hostBlockedHandler);
         }
         else
         {
            API.removeEventListener(APIEvent.NEW_VERSION_AVAILABLE,this.newVersionAvailableHandler);
            API.removeEventListener(APIEvent.HOST_BLOCKED,this.hostBlockedHandler);
         }
      }
      
      public function get showConnectingPopup() : Boolean
      {
         return this._showConnectingPopup;
      }
      
      public function set showConnectingPopup(param1:Boolean) : void
      {
         this._showConnectingPopup = param1;
         if(!param1 && (currentLabel == "connecting" || currentLabel == "connected"))
         {
            this.clear();
         }
      }
      
      public function clear() : void
      {
         gotoAndStop("idle");
      }
      
      public function connect() : void
      {
         API.setVersion(this._movieVersion);
         API.connect(root.loaderInfo,this._movieId,this._encryptionKey);
         visible = true;
         if(this.showConnectingPopup)
         {
            gotoAndStop("connecting");
         }
      }
      
      private function renderHandler(param1:Event) : void
      {
         removeEventListener(Event.RENDER,this.renderHandler);
         this.clear();
         this.connect();
      }
      
      private function movieConnectedHandler(param1:APIEvent) : void
      {
         if(param1.success)
         {
            if(API.isPublishedHost() && API.hostIsCompatible() && !API.hasUserSession() && !API.debugMode)
            {
               gotoAndStop("no_login");
               this._popDelay.start();
               visible = true;
            }
            else if(this.showConnectingPopup)
            {
               gotoAndStop("connected");
            }
         }
         else
         {
            gotoAndStop("no_connect");
            this._popDelay.start();
            visible = true;
         }
      }
      
      private function newVersionAvailableHandler(param1:APIEvent) : void
      {
         gotoAndStop("new_version");
         visible = true;
         this.centerOnStage();
      }
      
      private function hostBlockedHandler(param1:APIEvent) : void
      {
         gotoAndStop("bad_host");
         visible = true;
         this.centerOnStage();
      }
      
      private function closeButtonClickHandler(param1:Event) : void
      {
         this.clear();
      }
      
      private function officialVersionClickHandler(param1:Event) : void
      {
         API.loadOfficialURL();
      }
      
      private function enterFrameHandler(param1:Event) : void
      {
         this.forceAlwaysOnTop();
      }
      
      private function initButtons() : void
      {
         if(this.viewLatestButton)
         {
            this.viewLatestButton.addEventListener(MouseEvent.CLICK,this.officialVersionClickHandler);
         }
         if(this.viewAuthorizedButton)
         {
            this.viewAuthorizedButton.addEventListener(MouseEvent.CLICK,this.officialVersionClickHandler);
         }
         if(this.closeButton)
         {
            this.closeButton.addEventListener(MouseEvent.CLICK,this.closeButtonClickHandler);
         }
      }
      
      private function forceAlwaysOnTop() : void
      {
         var myIndex:uint = 0;
         var topIndex:uint = 0;
         if(Boolean(parent) && Boolean(visible))
         {
            try
            {
               myIndex = uint(parent.getChildIndex(this));
               topIndex = parent.numChildren - 1;
               if(myIndex != topIndex)
               {
                  parent.setChildIndex(this,topIndex);
               }
            }
            catch(e:Error)
            {
            }
         }
      }
      
      private function centerOnStage() : void
      {
         if(stage)
         {
            x = stage.stageWidth / 2;
            y = stage.stageHeight / 2;
         }
      }
      
      private function errorTimerHandler(param1:TimerEvent) : void
      {
         if(this.errorDialog)
         {
            this.errorDialog.gotoAndPlay("closeme");
         }
         else
         {
            this.clear();
         }
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame7() : *
      {
         this.initButtons();
      }
      
      internal function frame8() : *
      {
         this.initButtons();
      }
   }
}
