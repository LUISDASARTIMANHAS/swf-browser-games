package com.newgrounds.components
{
   import com.newgrounds.API;
   import com.newgrounds.APIError;
   import com.newgrounds.APIEvent;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.Security;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   
   public class FlashAd extends Sprite
   {
      
      private static const DEBUG_AD_URL:String = "http://www.ngads.com/adtest.php";
      
      private static var _adResetTime:uint = 0;
      
      private static var _adURL:URLRequest;
      
      private static const REMOVED_FROM_STAGE:String = "removedFromStage";
       
      
      public var background:MovieClip;
      
      private var _showBackground:Boolean;
      
      private var _adURLLoader:URLLoader;
      
      private var _adRect:Sprite;
      
      private var _mask:Shape;
      
      private var _ad:Loader;
      
      public function FlashAd(param1:Boolean = true)
      {
         super();
         if(parent != null && getQualifiedClassName(parent) == "fl.livepreview::LivePreviewParent")
         {
            return;
         }
         Security.allowDomain("server.cpmstar.com");
         this._adRect = new Sprite();
         this._adRect.graphics.beginFill(0);
         this._adRect.graphics.moveTo(0,0);
         this._adRect.graphics.lineTo(300,0);
         this._adRect.graphics.lineTo(300,250);
         this._adRect.graphics.lineTo(0,250);
         this._adRect.graphics.lineTo(0,0);
         this._adRect.graphics.endFill();
         this._mask = new Shape();
         this._mask.graphics.beginFill(0);
         this._mask.graphics.moveTo(0,0);
         this._mask.graphics.lineTo(300,0);
         this._mask.graphics.lineTo(300,250);
         this._mask.graphics.lineTo(0,250);
         this._mask.graphics.lineTo(0,0);
         this._mask.graphics.endFill();
         addChild(this._adRect);
         this._adRect.addChild(this._mask);
         this._adRect.visible = false;
         x = Math.round(x);
         y = Math.round(y);
         scaleX = 1;
         scaleY = 1;
         if(this.background)
         {
            if(this.background.ngLinkButton)
            {
               this.background.ngLinkButton.addEventListener(MouseEvent.CLICK,this.linkClickHandler);
            }
            if(this.background.loadingClip)
            {
               this.background.loadingClip.visible = false;
            }
         }
         if(API.isFlashVersion(9,0,28))
         {
            addEventListener(REMOVED_FROM_STAGE,this.onRemovedFromStage);
         }
         if(API.adsApproved)
         {
            this.loadAdFeed(API.adFeedURL);
         }
         else
         {
            API.addEventListener(APIEvent.ADS_APPROVED,this.onAdsApproved,false,0,true);
         }
         this.showBackground = param1;
      }
      
      public function get showBackground() : Boolean
      {
         return this._showBackground;
      }
      
      public function set showBackground(param1:Boolean) : void
      {
         this._showBackground = param1;
         if(this.background)
         {
            this.background.visible = param1;
            this._adRect.mask = param1 ? this.background.adMask : null;
         }
      }
      
      public function removeAd() : void
      {
         removeEventListener(REMOVED_FROM_STAGE,this.onRemovedFromStage);
         if(Boolean(this.background) && Boolean(this.background.loadingClip))
         {
            this.background.loadingClip.visible = false;
         }
         if(this._adURLLoader)
         {
            try
            {
               this._adURLLoader.close();
            }
            catch(e:Error)
            {
            }
         }
         if(this._adRect)
         {
            this._adRect.visible = false;
         }
         if(this._ad)
         {
            trace("[NewgroundsAPI] :: Ad removed");
            try
            {
               this._ad.close();
            }
            catch(e:Error)
            {
            }
            try
            {
               Object(this._ad).unloadAndStop(true);
            }
            catch(e:Error)
            {
               _ad.unload();
            }
            if(this._ad.parent)
            {
               this._ad.parent.removeChild(this._ad);
            }
         }
         this._ad = null;
      }
      
      private function onAdsApproved(param1:APIEvent) : void
      {
         API.removeEventListener(APIEvent.ADS_APPROVED,this.onAdsApproved,false);
         if(param1.success)
         {
            this.loadAdFeed(API.adFeedURL);
         }
         else
         {
            trace("[NewgroundsAPI] :: No ad feed URL supplied to Newgrounds API ad!");
         }
      }
      
      private function loadAdFeed(param1:String) : void
      {
         var adFeedURL:String = param1;
         this._adURLLoader = new URLLoader();
         this._adURLLoader.addEventListener(Event.COMPLETE,this.onAdFeedLoaded);
         this._adURLLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onAdError);
         this._adURLLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onAdError);
         if(!adFeedURL)
         {
            trace("[Newgrounds API] :: Invalid feed URL!");
            return;
         }
         if(this.hasAdElapsed)
         {
            if(adFeedURL.indexOf("?") > -1)
            {
               _adURL = new URLRequest(adFeedURL + "&random=" + Math.random());
            }
            else
            {
               _adURL = new URLRequest(adFeedURL + "?random=" + Math.random());
            }
         }
         try
         {
            this._adURLLoader.load(_adURL);
         }
         catch(e:Error)
         {
            onAdError(null);
         }
         if(Boolean(this.background) && Boolean(this.background.loadingClip))
         {
            this.background.loadingClip.visible = true;
         }
      }
      
      private function loadAd(param1:String) : void
      {
         var url:String = param1;
         if(this._ad)
         {
            this.removeAd();
         }
         this._ad = new Loader();
         this._ad.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onAdLoaded);
         this._ad.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onAdError);
         try
         {
            Object(this._ad.contentLoaderInfo).uncaughtErrorEvents.addEventListener("uncaughtError",function(param1:Event):void
            {
            });
         }
         catch(error:Error)
         {
         }
         this._ad.load(new URLRequest(url),new LoaderContext(false,new ApplicationDomain(null)));
         if(Boolean(this.background) && Boolean(this.background.loadingClip))
         {
            this.background.loadingClip.visible = true;
         }
      }
      
      private function onAdFeedLoaded(param1:Event) : void
      {
         var _loc2_:URLLoader = URLLoader(param1.target);
         if(Boolean(_loc2_.data) && _loc2_.data != "")
         {
            this.loadAd(_loc2_.data as String);
         }
         else
         {
            dispatchEvent(new APIEvent(APIEvent.AD_ATTACHED,false,new APIError("FLASH_ADS_NOT_APPROVED","Unable to render ad")));
            if(Boolean(this.background) && Boolean(this.background.loadingClip))
            {
               this.background.loadingClip.visible = false;
            }
         }
      }
      
      private function onAdFeedError(param1:Event) : void
      {
         trace("[NewgroundsAPI] :: Unable to load ad feed!");
         if(Boolean(this.background) && Boolean(this.background.loadingClip))
         {
            this.background.loadingClip.visible = false;
         }
      }
      
      private function onAdError(param1:Event) : void
      {
         dispatchEvent(new APIEvent(APIEvent.AD_ATTACHED,false,new APIError("FLASH_ADS_NOT_APPROVED","Unable to render ad")));
         this.removeAd();
      }
      
      private function onAdLoaded(param1:Event) : void
      {
         this._adRect.addChild(this._ad);
         this._ad.mask = this._mask;
         this._adRect.visible = true;
         if(this.background)
         {
            if(this._showBackground)
            {
               this._adRect.mask = this.background.adMask;
            }
            if(this.background.loadingClip)
            {
               this.background.loadingClip.visible = false;
            }
         }
         trace("[NewgroundsAPI] :: Ad loaded!");
         dispatchEvent(new APIEvent(APIEvent.AD_ATTACHED,true));
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         this.removeAd();
      }
      
      private function get hasAdElapsed() : Boolean
      {
         if(getTimer() >= _adResetTime)
         {
            _adResetTime = getTimer() + 1000 * 60 * 5;
            return true;
         }
         return false;
      }
      
      private function linkClickHandler(param1:MouseEvent) : void
      {
         API.loadNewgrounds();
      }
   }
}
