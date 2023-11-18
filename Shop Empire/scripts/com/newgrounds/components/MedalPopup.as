package com.newgrounds.components
{
   import com.newgrounds.API;
   import com.newgrounds.APIEvent;
   import com.newgrounds.Medal;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import flash.utils.getQualifiedClassName;
   
   [Embed(source="/_assets/assets.swf", symbol="com.newgrounds.components.MedalPopup")]
   public class MedalPopup extends MovieClip
   {
       
      
      public var medalNameText:TextField;
      
      public var medalValueText:TextField;
      
      public var medalContainer:Sprite;
      
      private var _initialized:Boolean;
      
      private var _medal:Medal;
      
      private var _medalIcon:Bitmap;
      
      private var _medalQueue:Array;
      
      private var _popDelay:Timer;
      
      public function MedalPopup()
      {
         this._medalQueue = [];
         this._popDelay = new Timer(3000,1);
         super();
         addFrameScript(0,this.frame1,9,this.frame10,18,this.frame19);
         if(parent != null && getQualifiedClassName(parent) == "fl.livepreview::LivePreviewParent")
         {
            return;
         }
         visible = false;
         addEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
         stop();
         API.addEventListener(APIEvent.MEDAL_UNLOCKED,this.onMedalUnlocked,false,0,true);
         this._popDelay.addEventListener(TimerEvent.TIMER,this.timerHandler);
      }
      
      public function get popupTime() : Number
      {
         return this._popDelay.delay / 1000;
      }
      
      public function set popupTime(param1:Number) : void
      {
         if(isNaN(param1))
         {
            param1 = 3;
         }
         this._popDelay.delay = param1 * 1000;
      }
      
      private function enterFrameHandler(param1:Event) : void
      {
         var myIndex:uint = 0;
         var topIndex:uint = 0;
         var event:Event = param1;
         if(Boolean(this._medalQueue.length) && !visible)
         {
            this._medal = this._medalQueue.pop();
            this._popDelay.start();
            gotoAndPlay("medal_show");
            visible = true;
         }
         if(Boolean(visible) && Boolean(parent))
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
            catch(error:Error)
            {
            }
         }
      }
      
      private function onMedalUnlocked(param1:APIEvent) : void
      {
         if(param1.success && param1.data && param1.data.medal is Medal)
         {
            this._medalQueue.push(Medal(param1.data.medal));
         }
      }
      
      private function showMedalInfo() : void
      {
         if(!this._medal)
         {
            return;
         }
         if(this.medalContainer)
         {
            this._medalIcon = this._medal.createIconBitmap();
            this.medalContainer.addChild(this._medalIcon);
         }
         if(this.medalNameText)
         {
            this.medalNameText.text = this._medal.name;
         }
         if(this.medalValueText)
         {
            this.medalValueText.text = this._medal.value.toString() + "pts";
         }
         this._popDelay.start();
         stop();
      }
      
      private function timerHandler(param1:TimerEvent) : void
      {
         if(Boolean(this._medalIcon) && Boolean(this._medalIcon.parent))
         {
            this._medalIcon.parent.removeChild(this._medalIcon);
            this._medalIcon = null;
         }
         gotoAndPlay("medal_hide");
         this._popDelay.stop();
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame10() : *
      {
         this.showMedalInfo();
         stop();
      }
      
      internal function frame19() : *
      {
         stop();
         visible = false;
      }
   }
}
