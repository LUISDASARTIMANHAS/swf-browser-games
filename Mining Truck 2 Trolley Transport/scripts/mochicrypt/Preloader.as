package mochicrypt
{
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.system.*;
   import flash.utils.*;
   import mochicrypt.as3.MochiAd;
   
   public dynamic class Preloader extends MovieClip
   {
      
      private static const VERSION:String = "3.1c";
      
      private static const PAYLOAD_NAME:String = "mochicrypt.Payload";
      
      private static const PATCH_URL:String = Config.getString("patchURL","http://cdn.mochiads.com/patch.swf");
       
      
      private var payloadLoader:Loader;
      
      private var patchProgress:Number = 0;
      
      private var payloadProgress:Number = 0;
      
      private var payloadDoneTime:Number = -1;
      
      private var lastProgress:Number = 0;
      
      private var patchTimeoutMsec:Number = 5000;
      
      private var patchFailed:Boolean = false;
      
      public var background:Background;
      
      private var payloadDone:Boolean = false;
      
      private var patchDone:Boolean = false;
      
      public var icon:LockIcon;
      
      private var patchLoader:Loader;
      
      public function Preloader()
      {
         this.patchLoader = new Loader();
         super();
         loaderInfo.addEventListener(ProgressEvent.PROGRESS,this.progressHandler);
         loaderInfo.addEventListener(Event.INIT,this.initHandler);
         loaderInfo.addEventListener(Event.COMPLETE,this.completeHandler);
         loaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
      }
      
      private function update_progress() : void
      {
         var _loc1_:Number = NaN;
         if(this.payloadDone)
         {
            this.payloadProgress = 1;
            if(this.payloadDoneTime < 0)
            {
               this.payloadDoneTime = getTimer();
            }
         }
         if(this.patchDone)
         {
            this.patchProgress = 1;
         }
         else if(this.payloadDone)
         {
            if(this.patchProgress > this.lastProgress)
            {
               this.payloadDoneTime = getTimer();
            }
            else if(getTimer() - this.payloadDoneTime >= this.patchTimeoutMsec)
            {
               this.patchDone = true;
               this.patchFailed = true;
            }
         }
         this.lastProgress = Math.max(this.lastProgress,Math.min(this.payloadProgress,this.patchProgress));
      }
      
      public function ad_finished() : void
      {
         this.finish();
      }
      
      public function ad_progress(param1:Number) : void
      {
      }
      
      private function completeHandler(param1:Event) : void
      {
         if(this.payloadDone)
         {
            return;
         }
         this.payloadDone = true;
         nextFrame();
      }
      
      private function finish() : void
      {
         var payloadClass:Class;
         var vsn:String;
         var data:ByteArray;
         var S:ByteArray = null;
         var i:uint = 0;
         var j:uint = 0;
         var k:uint = 0;
         var n:uint = 0;
         var u:uint = 0;
         var v:uint = 0;
         var btn:Button = null;
         if(this.payloadLoader)
         {
            return;
         }
         if(Config.getBool("showLock",true) && Boolean(this.icon))
         {
            removeChild(this.icon);
         }
         removeChild(this.background);
         payloadClass = Class(getDefinitionByName(PAYLOAD_NAME));
         data = ByteArray(new payloadClass());
         if(data.length > 0)
         {
            S = new ByteArray();
            n = data.length - 32;
            i = 0;
            while(i < 256)
            {
               S.writeByte(i);
               i++;
            }
            j = 0;
            i = 0;
            while(i < 256)
            {
               j = uint(j + S[i] + data[n + (i & 31)] & 255);
               u = uint(S[i]);
               S[i] = S[j];
               S[j] = u;
               i++;
            }
            if(n > 131072)
            {
               n = 131072;
            }
            i = j = 0;
            k = 0;
            while(k < n)
            {
               i = uint(i + 1 & 255);
               u = uint(S[i]);
               j = uint(j + u & 255);
               v = uint(S[j]);
               S[i] = v;
               S[j] = u;
               data[k] ^= S[u + v & 255];
               k++;
            }
            data.uncompress();
         }
         if(!this.patchFailed)
         {
            try
            {
               data = this.patchLoader.content["patch"](data);
            }
            catch(error:Error)
            {
            }
         }
         vsn = String(Capabilities.version);
         vsn = String(vsn.substring(vsn.indexOf(" ") + 1,vsn.indexOf(",")));
         if(data[3] > parseInt(vsn))
         {
            btn = new Button();
            btn.x = (loaderInfo.width - btn.width) / 2;
            btn.y = (loaderInfo.height - btn.height) / 2;
            addChild(btn);
         }
         else if(data.length > 0)
         {
            this.payloadLoader = new Loader();
            addChild(this.payloadLoader);
            this.payloadLoader.loadBytes(data);
         }
         this.patchLoader.unload();
         loaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.progressHandler);
         loaderInfo.removeEventListener(Event.INIT,this.initHandler);
         loaderInfo.removeEventListener(Event.COMPLETE,this.completeHandler);
         loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
         this.patchLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.patchIOErrorHandler);
         this.patchLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.patchProgressHandler);
         this.patchLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.patchCompleteHandler);
         if(this.icon)
         {
            this.icon.removeEventListener(MouseEvent.CLICK,this.lockClicked);
         }
         this.patchLoader = null;
      }
      
      public function ad_failed() : void
      {
      }
      
      private function initHandler(param1:Event) : void
      {
         var event:Event = param1;
         var options:Object = {
            "mochicrypt_version":VERSION,
            "id":Config.getString("id","test"),
            "res":"" + loaderInfo.width + "x" + loaderInfo.height,
            "no_bg":!Config.getBool("adBackground",false),
            "color":Config.getInt("barForeColor",16747008),
            "background":Config.getInt("barBackColor",16777161),
            "outline":Config.getInt("barOutlineColor",13994812),
            "bar_offset":(Config.getBool("showLock",true) ? 20 : 0),
            "show_lock":Config.getBool("showLock",true),
            "clip":this,
            "progress_override":this.progress_override,
            "ad_started":this.ad_started,
            "ad_finished":this.ad_finished,
            "ad_loaded":this.ad_loaded,
            "ad_failed":this.ad_failed,
            "ad_skipped":this.ad_skipped,
            "ad_progress":this.ad_progress
         };
         this.patchLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.patchIOErrorHandler);
         this.patchLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.patchProgressHandler);
         this.patchLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.patchCompleteHandler);
         try
         {
            this.patchLoader.load(new URLRequest(PATCH_URL));
         }
         catch(error:Error)
         {
            patchDone = true;
            patchFailed = true;
         }
         this.background = new Background();
         addChild(this.background);
         MochiAd.showPreGameAd(options);
         if(Config.getBool("showLock",true))
         {
            this.icon = new LockIcon();
            this.icon.addFrameScript(49,this.icon.stop);
            this.icon.x = 10;
            this.icon.y = loaderInfo.height - 20;
            this.icon.buttonMode = true;
            this.icon.useHandCursor = true;
            this.icon.addEventListener(MouseEvent.CLICK,this.lockClicked);
            addChild(this.icon);
         }
         if(Boolean(loaderInfo.bytesTotal) && loaderInfo.bytesLoaded == loaderInfo.bytesTotal)
         {
            this.completeHandler(event);
         }
      }
      
      public function progress_override(param1:Object) : Number
      {
         this.update_progress();
         return this.lastProgress;
      }
      
      public function ad_loaded(param1:Number, param2:Number) : void
      {
      }
      
      private function ioErrorHandler(param1:IOErrorEvent) : void
      {
      }
      
      private function patchCompleteHandler(param1:Event) : void
      {
         if(this.patchDone)
         {
            return;
         }
         this.patchDone = true;
         this.update_progress();
      }
      
      public function ad_skipped() : void
      {
      }
      
      public function ad_started() : void
      {
      }
      
      private function patchProgressHandler(param1:ProgressEvent) : void
      {
         if(param1.bytesLoaded == param1.bytesTotal)
         {
            this.patchProgress = 1;
            this.patchDone = true;
         }
         else
         {
            this.patchProgress = Number(param1.bytesLoaded) / param1.bytesTotal;
         }
         this.update_progress();
      }
      
      private function patchIOErrorHandler(param1:IOErrorEvent) : void
      {
         this.patchDone = true;
         this.patchFailed = true;
         this.update_progress();
      }
      
      private function lockClicked(param1:Event) : void
      {
         navigateToURL(new URLRequest("https://www.mochimedia.com/r/g/" + Config.getString("slug","example-flash_api-test") + "?d=l"));
      }
      
      private function progressHandler(param1:ProgressEvent) : void
      {
         if(param1.bytesLoaded == param1.bytesTotal)
         {
            this.payloadProgress = 0;
         }
         else
         {
            this.payloadProgress = Number(param1.bytesLoaded) / param1.bytesTotal;
         }
         this.update_progress();
      }
   }
}

import flash.display.SimpleButton;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.net.URLRequest;
import flash.net.navigateToURL;

class Button extends SimpleButton
{
    
   
   public function Button()
   {
      super();
      var _loc1_:String = "Download the latest\nAdobe Flash Player";
      upState = new State(16777215,_loc1_);
      downState = new State(13421772,_loc1_);
      hitTestState = upState;
      overState = upState;
      addEventListener(MouseEvent.CLICK,this.buttonClicked);
      width = upState.width;
      height = upState.height;
   }
   
   public function buttonClicked(param1:Event) : void
   {
      navigateToURL(new URLRequest("http://get.adobe.com/flashplayer/"));
   }
}

import flash.display.Graphics;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

class State extends Sprite
{
    
   
   public function State(param1:uint, param2:String)
   {
      super();
      var _loc3_:TextFormat = new TextFormat("Verdana");
      _loc3_.align = TextFormatAlign.CENTER;
      var _loc4_:TextField;
      (_loc4_ = new TextField()).text = param2;
      _loc4_.multiline = true;
      _loc4_.x = _loc4_.y = 2;
      _loc4_.setTextFormat(_loc3_);
      _loc4_.width = _loc4_.textWidth + 4;
      _loc4_.height = _loc4_.textHeight + 4;
      addChild(_loc4_);
      var _loc5_:Graphics;
      (_loc5_ = graphics).beginFill(param1);
      _loc5_.lineStyle(1,0);
      _loc5_.drawRoundRect(0,0,_loc4_.width + 4,_loc4_.height + 4,4);
   }
}
