package uk.co.kempt.versioning
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.Security;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   
   public class VersionChecker extends MovieClip
   {
      
      private static const TIMEOUT:int = 10 * 1000;
      
      private static const VERSION_CHECK_ENABLED:Boolean = true;
      
      private static var MASTER_DOMAIN:String;
      
      private static const VERSION_CHECK_DEBUG:Boolean = true;
      
      private static var IS_MASTER:Boolean;
      
      private static const PLAYER_VERSION:int = 10;
      
      private static var SWF_VERSION:int;
      
      private static var INSTANCE:VersionChecker;
      
      private static const ORI_DOM_KEY_NAME:String = "ori_dom";
      
      private static var ORI_DOM:String = "";
      
      private static const GAME_VERSION:int = 3;
      
      private static var CURRENT_DOMAIN:String;
      
      private static const MASTER_URL:String = "http://games.killerviral.com/test/export/latest.swf";
      
      private static const CHECK_URL:String = "http://games.killerviral.com/test/assets/v.txt";
       
      
      private var _timestamp:int;
      
      private var _originalURL:String;
      
      private var _tryData:Boolean = true;
      
      private var _newMasterURL:String;
      
      private var _timeoutID:int;
      
      private var _force:Boolean;
      
      public function VersionChecker()
      {
         INSTANCE = this;
         this._timestamp = getTimer();
         this.debug("~~~ new checker of version " + this.version + " created at " + this._timestamp + "ms ~~~");
         super();
         this.debug("allowing all domains");
         Security.allowDomain("*");
         this.preVersionCheck();
         if(this.versionCheckEnabled)
         {
            this.debug("begin version checking");
            if(loaderInfo)
            {
               loaderInfo.addEventListener(Event.INIT,this.onInit,false,0,true);
               loaderInfo.addEventListener(Event.UNLOAD,this.onUnloadEvent,false,0,true);
               this.debug("listening for loaderInfo init");
            }
            else
            {
               this.debug("wait for loaderInfo");
            }
         }
         else
         {
            this.debug("version checking disabled, skipping");
            this.onVersionChecked();
         }
      }
      
      public static function get instance() : VersionChecker
      {
         return INSTANCE;
      }
      
      private function onInit(param1:Event) : void
      {
         this._originalURL = root.loaderInfo.url;
         this.debug("my location is " + this._originalURL);
         if(stage)
         {
            this.debug("stage already exists on init, calling checkVersion");
            this.checkVersion();
         }
         else
         {
            this.debug("stage doesnt exist, waiting to be added");
            addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage,false,0,true);
         }
      }
      
      public function get versionCheckEnabled() : Boolean
      {
         return VERSION_CHECK_ENABLED;
      }
      
      private function isMasterVersion() : Boolean
      {
         return false;
      }
      
      public function get currentDomain() : String
      {
         return CURRENT_DOMAIN;
      }
      
      private function loadNewVersion() : void
      {
         var _loc1_:LoaderInfo = root.loaderInfo;
         this.debug("allowing master domain: " + this.getDomainFromURL(this.currentMasterURL));
         Security.allowDomain(this.getDomainFromURL(this.currentMasterURL));
         var _loc2_:Loader = new Loader();
         var _loc3_:ApplicationDomain = new ApplicationDomain(root.loaderInfo.applicationDomain.parentDomain);
         var _loc4_:LoaderContext = new LoaderContext(false,_loc3_);
         var _loc5_:URLVariables = new URLVariables();
         var _loc6_:URLRequest = new URLRequest(this.currentMasterURL);
         this.appendParams(_loc5_);
         if(this._tryData)
         {
            _loc6_.data = _loc5_;
            this.debug("using variables " + _loc5_.toString());
         }
         else
         {
            this.debug("not using variables");
         }
         _loc2_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.newVersionLoaded);
         _loc2_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.newVersionLoadedError);
         _loc2_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.newVersionLoadedErrorRemoval,false,0,true);
         this.debug("original domain is " + ORI_DOM);
         this.debug("loading newer version from url " + this.currentMasterURL);
         _loc2_.load(_loc6_,_loc4_);
         this.useNewVersionLoaderInfo(_loc2_.contentLoaderInfo);
      }
      
      private function newVersionLoadedErrorRemoval(param1:IOErrorEvent) : void
      {
         this.debug("new version load error");
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         var tParent:DisplayObjectContainer = null;
         var e:Event = param1;
         try
         {
            this.debug("my movie parent is " + this.getMovieParent());
         }
         catch(e:Error)
         {
            debug("my movie parent is inaccessible");
         }
         try
         {
            tParent = root.parent;
         }
         catch(e:Error)
         {
            debug("my parent is inaccessible");
         }
         if(root)
         {
            if(Boolean(tParent) && tParent is Loader)
            {
               this.debug("added to stage, calling allowParentDomainAccess");
               this.allowParentDomainAccess();
            }
            else
            {
               e.currentTarget.removeEventListener(e.type,arguments.callee);
               this.debug("added to stage, calling checkVersion");
               this.checkVersion();
            }
         }
      }
      
      public function get versionCheckDebug() : Boolean
      {
         return VERSION_CHECK_DEBUG;
      }
      
      private function clearVersionLoaderListeners(param1:URLLoader) : void
      {
         param1.removeEventListener(Event.COMPLETE,this.onVersionLoad);
         param1.removeEventListener(IOErrorEvent.IO_ERROR,this.onVersionChecked);
         param1.removeEventListener(HTTPStatusEvent.HTTP_STATUS,this.onVersionHTTPStatus);
         param1.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onVersionSecurityError);
         clearTimeout(this._timeoutID);
      }
      
      protected function stopUsingLoaderInfo(param1:LoaderInfo) : void
      {
      }
      
      public function get masterURL() : String
      {
         return MASTER_URL;
      }
      
      private function onVersionTimeout(param1:URLLoader) : void
      {
         this.debug("timed out loading latest version number, skipping version checking");
         this.clearVersionLoaderListeners(param1);
         this.onVersionChecked();
      }
      
      private function checkVersion() : void
      {
         var _loc1_:URLLoader = null;
         var _loc2_:URLRequest = null;
         CURRENT_DOMAIN = this.getDomainFromURL(loaderInfo.url);
         SWF_VERSION = loaderInfo.swfVersion;
         ORI_DOM = !!loaderInfo.parameters.hasOwnProperty(this.originalDomainKeyName) ? String(loaderInfo.parameters[this.originalDomainKeyName]) : CURRENT_DOMAIN;
         MASTER_DOMAIN = this.getDomainFromURL(this.currentMasterURL);
         IS_MASTER = this.isMasterVersion();
         this.debug("current domain is " + this.currentDomain);
         if(loaderInfo.parameters.hasOwnProperty(this.originalDomainKeyName))
         {
            this.debug("storing original domain");
         }
         else
         {
            this.debug("no original domain, reverting to default");
         }
         if(!IS_MASTER)
         {
            this.debug("is not hosted on master domain, look up latest version number");
            _loc1_ = new URLLoader();
            _loc2_ = new URLRequest(this.checkURL);
            _loc1_.dataFormat = URLLoaderDataFormat.TEXT;
            _loc1_.addEventListener(Event.COMPLETE,this.onVersionLoad);
            _loc1_.addEventListener(IOErrorEvent.IO_ERROR,this.onVersionLoadError);
            _loc1_.addEventListener(HTTPStatusEvent.HTTP_STATUS,this.onVersionHTTPStatus);
            _loc1_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onVersionSecurityError);
            this._timeoutID = setTimeout(this.onVersionTimeout,TIMEOUT,_loc1_);
            this.debug("loading version number from url " + _loc2_.url);
            _loc1_.load(_loc2_);
         }
         else
         {
            this.debug("is hosted on master domain, skipping version checking");
            this.onVersionChecked();
         }
      }
      
      final public function get currentMasterURL() : String
      {
         return this._newMasterURL || this.masterURL;
      }
      
      private function onVersionSecurityError(param1:SecurityErrorEvent) : void
      {
         this.debug("security error loading latest version number, skipping version checking");
         var _loc2_:URLLoader = URLLoader(param1.target);
         this.clearVersionLoaderListeners(_loc2_);
         this.onVersionChecked();
      }
      
      public function get playerVersion() : int
      {
         return PLAYER_VERSION;
      }
      
      private function allowParentDomainAccess() : void
      {
         var tParentObject:Object = null;
         if(Boolean(this.getMovieParent()) && Boolean(this.getMovieParent().loaderInfo))
         {
            try
            {
               tParentObject = this.getMovieParent() as Object;
               this.debug("allowing parent domain: " + tParentObject.currentDomain);
               Security.allowDomain(tParentObject.currentDomain);
            }
            catch(e:Error)
            {
               debug("allowing of parent domain failed, unable to reference parent.currentDomain");
            }
         }
         else
         {
            this.debug("unable to allow parent domain");
         }
      }
      
      private function newVersionLoaded(param1:Event) : void
      {
         var tLoaderInfo:LoaderInfo;
         var tContent:DisplayObject;
         var tParentSafeMode:Boolean;
         var tNewVersion:int;
         var tOldRoot:DisplayObject;
         var tChildIndex:int;
         var tParent:DisplayObjectContainer = null;
         var tContentObject:Object = null;
         var e:Event = param1;
         this.debug("newer version loaded, swapping root");
         tLoaderInfo = LoaderInfo(e.target);
         tLoaderInfo.removeEventListener(Event.COMPLETE,this.newVersionLoaded);
         tLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.newVersionLoadedError);
         tOldRoot = root;
         tParentSafeMode = false;
         try
         {
            tParent = this.getMovieParent();
         }
         catch(e:Error)
         {
            debug("couldnt get movie parent, creating new parent and setting safe mode");
            tParentSafeMode = true;
            tParent = createNewMovieParent();
            DisplayObjectContainer(root).addChild(tParent);
         }
         this.debug("adding new loader to display");
         addChild(tLoaderInfo.loader);
         tContent = tLoaderInfo.content;
         tChildIndex = 0;
         if(!tParentSafeMode)
         {
            this.debug("parent contains old root, using correct child index");
            tChildIndex = int(tParent.getChildIndex(tOldRoot));
         }
         else
         {
            this.debug("parent doesnt contain old root, using default child index");
            tChildIndex = int(tParent.numChildren);
         }
         tNewVersion = -1;
         try
         {
            tContentObject = tContent as Object;
            tNewVersion = int(tContentObject.version);
         }
         catch(e:Error)
         {
            debug("could not access new roots version");
         }
         if(this._force || tNewVersion > this.version || tNewVersion == -1)
         {
            this.debug("replacing old version");
            if(tParentSafeMode)
            {
               this.debug("removing new loader from display");
               if(tLoaderInfo.loader.parent)
               {
                  tLoaderInfo.loader.parent.removeChild(tLoaderInfo.loader);
               }
               this.debug("adding new root to display");
               tParent.addChildAt(tContent,tChildIndex);
            }
            else
            {
               tOldRoot.parent.removeChild(tOldRoot);
               this.debug("removing new loader from display");
               if(tLoaderInfo.loader.parent)
               {
                  tLoaderInfo.loader.parent.removeChild(tLoaderInfo.loader);
               }
               this.debug("adding new root to display");
               tParent.addChildAt(tContent,tChildIndex);
               try
               {
                  this.onBeforeDestroy();
               }
               catch(e:Error)
               {
                  debug("error thrown by onBeforeDestroy: " + e.message);
               }
               this.destroy(tOldRoot);
            }
         }
         else
         {
            this.debug("new version is actually the same or older, reverting to current version");
            this.debug("removing new loader from display");
            if(tLoaderInfo.loader.parent)
            {
               tLoaderInfo.loader.parent.removeChild(tLoaderInfo.loader);
            }
            this.destroy(tContent);
            this.onVersionChecked();
         }
      }
      
      private function appendParams(param1:URLVariables) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(!param1)
         {
            _loc2_ = "no url variables";
         }
         if(root)
         {
            if(root.loaderInfo)
            {
               if(root.loaderInfo.parameters)
               {
                  for(_loc3_ in root.loaderInfo.parameters)
                  {
                     param1[_loc3_] = root.loaderInfo.parameters[_loc3_];
                  }
               }
               else
               {
                  _loc2_ = "no root loaderInfo parameters";
               }
            }
            else
            {
               _loc2_ = "no root loaderInfo";
            }
         }
         else
         {
            _loc2_ = "no root";
         }
         if(_loc2_)
         {
            this.debug("couldnt append params because " + _loc2_);
         }
      }
      
      public function getMovieParent() : DisplayObjectContainer
      {
         return !!root ? (root.parent is Loader ? root.parent.parent : root.parent) : null;
      }
      
      public function get checkURL() : String
      {
         return CHECK_URL;
      }
      
      private function onVersionLoadError(param1:IOErrorEvent) : void
      {
         this.debug("failed to load latest version number, skipping version checking");
         var _loc2_:URLLoader = URLLoader(param1.target);
         this.clearVersionLoaderListeners(_loc2_);
         this.onVersionChecked();
      }
      
      private function newVersionLoadedError(param1:IOErrorEvent) : void
      {
         var tLoaderInfo:LoaderInfo;
         var e:IOErrorEvent = param1;
         this.debug("failed to load newer version from " + this.currentMasterURL);
         tLoaderInfo = LoaderInfo(e.target);
         try
         {
            this.stopUsingLoaderInfo(tLoaderInfo);
         }
         catch(e:Error)
         {
            debug("stopUsingLoaderInfo generated error " + e.message);
         }
         tLoaderInfo.removeEventListener(Event.COMPLETE,this.newVersionLoaded);
         tLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.newVersionLoadedError);
         if(this._tryData)
         {
            this.debug("turning off sending data");
            this._tryData = false;
            this.loadNewVersion();
         }
         else if(this._newMasterURL)
         {
            this.debug("failed forced loading of new master, reloading current master version");
            this._newMasterURL = null;
            this._tryData = true;
            this.loadNewVersion();
         }
         else
         {
            this.debug("skipping version checking");
            this.onVersionChecked();
         }
      }
      
      protected function useNewVersionLoaderInfo(param1:LoaderInfo) : void
      {
      }
      
      private function getDomainFromURL(param1:String) : String
      {
         return param1.split("/")[0].indexOf("http") == -1 ? "localhost" : String(param1.split("/")[2].split("?")[0]);
      }
      
      public function debug(... rest) : void
      {
         if(this.versionCheckDebug)
         {
            trace("v" + this.version + "_" + this._timestamp + "> " + rest.join(", "));
         }
      }
      
      public function get originalDomainKeyName() : String
      {
         return ORI_DOM_KEY_NAME;
      }
      
      private function createNewMovieParent() : DisplayObjectContainer
      {
         return new MovieClip();
      }
      
      public function get version() : int
      {
         return GAME_VERSION;
      }
      
      private function onVersionHTTPStatus(param1:HTTPStatusEvent) : void
      {
         this.debug("fyi version number http status is " + param1.status);
      }
      
      public function loadNewRoot(param1:String) : void
      {
         this.debug("new root requested from " + param1);
         this._force = true;
         this._newMasterURL = param1;
         this._tryData = true;
         this.debug("attempting to load new root");
         this.loadNewVersion();
      }
      
      protected function kill(param1:DisplayObject) : void
      {
         var _loc2_:DisplayObjectContainer = null;
         var _loc3_:int = 0;
         if(param1)
         {
            if(param1 is DisplayObjectContainer)
            {
               _loc2_ = param1 as DisplayObjectContainer;
               _loc3_ = _loc2_.numChildren - 1;
               while(_loc3_ > -1)
               {
                  this.kill(_loc2_.getChildAt(_loc3_));
                  _loc3_--;
               }
               if(_loc2_ is MovieClip)
               {
                  MovieClip(_loc2_).stop();
               }
            }
            if(param1.parent)
            {
               param1.parent.removeChild(param1);
            }
         }
      }
      
      protected function preVersionCheck() : void
      {
         stop();
      }
      
      protected function onBeforeDestroy() : void
      {
         this.debug("onBeforeDestroy");
      }
      
      protected function onVersionChecked() : void
      {
         this.debug("version checking complete, begin movie");
         play();
      }
      
      private function destroy(param1:DisplayObject) : void
      {
         var tLoaderInfo:LoaderInfo = null;
         var tLoader:Loader = null;
         var pRoot:DisplayObject = param1;
         if(pRoot)
         {
            tLoaderInfo = pRoot.loaderInfo;
            try
            {
               this.stopUsingLoaderInfo(tLoaderInfo);
            }
            catch(e:Error)
            {
               debug("stopUsingLoaderInfo generated error " + e.message);
            }
            if(tLoaderInfo.loader)
            {
               tLoader = tLoaderInfo.loader;
               this.closeLoad(tLoader);
               tLoader.unloadAndStop();
               this.debug("destroyed root using unloadAndStop");
            }
            else
            {
               this.kill(pRoot);
               this.debug("destroyed root using kill");
            }
         }
      }
      
      private function onUnloadEvent(param1:Event) : void
      {
         var e:Event = param1;
         e.currentTarget.removeEventListener(e.type,arguments.callee);
         this.debug("about to be unloaded");
         try
         {
            this.onBeforeDestroy();
         }
         catch(e:Error)
         {
            debug("error thrown by onBeforeDestroy: " + e.message);
         }
      }
      
      private function closeLoad(param1:Loader) : void
      {
         var pLoader:Loader = param1;
         try
         {
            pLoader.close();
            this.debug("closed load");
         }
         catch(e:Error)
         {
            debug("couldnt close load");
         }
      }
      
      private function onVersionLoad(param1:Event) : void
      {
         var tLoader:URLLoader;
         var tURLVariables:URLVariables;
         var tLatestVersion:int;
         var e:Event = param1;
         this.debug("loaded latest version number, attempting to parse");
         tLoader = URLLoader(e.target);
         this.clearVersionLoaderListeners(tLoader);
         tURLVariables = new URLVariables();
         try
         {
            tURLVariables.decode(tLoader.data);
         }
         catch(e:Error)
         {
            debug("the version file does not contain name/value pairs");
         }
         tLatestVersion = int(int(tURLVariables.v));
         this.debug("server version file loaded, most recent version is " + tLatestVersion + ", our version is " + this.version);
         if(tLatestVersion)
         {
            if(tLatestVersion > this.version)
            {
               this.debug("newer version available");
               this.loadNewVersion();
            }
            else
            {
               this.debug("this is the latest version");
               this.onVersionChecked();
            }
         }
         else
         {
            this.debug("unable to read latest version number, skipping version checking");
            this.onVersionChecked();
         }
      }
   }
}
