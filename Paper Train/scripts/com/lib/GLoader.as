package com.lib
{
   import flash.display.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.net.*;
   
   public class GLoader extends Sprite
   {
       
      
      private var logoFinishX:*;
      
      private var framecount:* = 0;
      
      private var startCallback:Function;
      
      private var percentWidget:*;
      
      private var barStartX:*;
      
      private var initPercent:Number;
      
      private var logoSpeed:*;
      
      private var initTime:int;
      
      private var loaderScreen:* = null;
      
      public function GLoader(param1:Function)
      {
         super();
         this.startCallback = param1;
      }
      
      public function initLayers(param1:Number) : *
      {
         var percentMsg:*;
         var initPercent:Number = param1;
         this.initPercent = initPercent;
         this.loaderScreen = new LoaderScreen();
         this.loaderScreen.logo.addEventListener(MouseEvent.CLICK,function():*
         {
            navigateToURL(new URLRequest("http://www.mylostgames.com/"));
         });
         this.loaderScreen.logo.buttonMode = true;
         this.loaderScreen.postit.visible = false;
         this.loaderScreen.postit.buttonPlay.addEventListener(MouseEvent.CLICK,function():*
         {
            startCallback();
         });
         this.barStartX = this.loaderScreen.bar.x;
         this.logoFinishX = this.loaderScreen.logo.x;
         this.loaderScreen.logo.x = 720;
         this.logoSpeed = 50;
         this.percentWidget = new GWidget({
            "font":HuAero,
            "color":3355443,
            "size":16,
            "align":"left",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":0
         });
         percentMsg = this.percentWidget.print("",200);
         percentMsg.x = 270;
         percentMsg.y = 520;
         this.loaderScreen.addChild(percentMsg);
         addChild(this.loaderScreen);
      }
      
      public function frame(param1:Number, param2:Boolean) : *
      {
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc3_:* = new Date();
         var _loc4_:* = _loc3_.time;
         if(!this.loaderScreen)
         {
            this.initLayers(param1);
         }
         var _loc5_:*;
         if((_loc5_ = (param1 - this.initPercent) / (1 - this.initPercent)) < 0)
         {
            _loc5_ = 0;
         }
         if(_loc5_ > 1)
         {
            _loc5_ = 1;
         }
         if(param2)
         {
            _loc5_ = 1;
         }
         this.loaderScreen.bar.x = this.barStartX - 660 * _loc5_;
         if(this.logoSpeed)
         {
            this.loaderScreen.logo.x -= this.logoSpeed;
            if(this.loaderScreen.logo.x < this.logoFinishX)
            {
               this.loaderScreen.logo.x = this.logoFinishX;
               this.logoSpeed = 0;
            }
            else
            {
               this.logoSpeed -= 2;
            }
         }
         else
         {
            ++this.framecount;
            if((_loc8_ = Math.PI * (this.framecount / 8)) < Math.PI * 2)
            {
               if((_loc9_ = Math.sin(_loc8_)) < 0)
               {
                  _loc9_ = -_loc9_;
               }
               _loc11_ = (_loc10_ = 16 * _loc9_) / 5;
               this.loaderScreen.logo.filters = new Array(new BlurFilter(_loc10_,0,1));
            }
            else
            {
               this.loaderScreen.logo.filters = undefined;
            }
         }
         var _loc6_:* = int(param1 * 100);
         var _loc7_:* = GString.prefill(_loc6_.toString(),"0",2) + "%";
         this.percentWidget.updateText("Loading... " + _loc7_);
         if(param2)
         {
            this.loaderScreen.postit.visible = true;
         }
      }
      
      public function init() : *
      {
         var _loc1_:* = new Date();
         this.initTime = _loc1_.time;
      }
   }
}
