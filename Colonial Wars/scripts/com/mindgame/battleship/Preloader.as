package com.mindgame.battleship
{
   import com.mindgame.tweener.*;
   import com.mindgame.tweener.easing.*;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.*;
   import flash.text.*;
   import mochi.as3.*;
   
   public class Preloader extends MovieClip
   {
       
      
      private var ready:SimpleButton;
      
      private var text:MovieClip;
      
      public function Preloader()
      {
         this.ready = new ReadyCheck_btn();
         this.text = new Loader_mc();
         super();
         addEventListener(Event.ENTER_FRAME,this.checkFrame,false,0,true);
         MochiServices.connect("8192a35ab4d0cd2b",root);
         stop();
         this.text.bytes.text = "";
         (this.text.bytes as TextField).autoSize = TextFieldAutoSize.LEFT;
         this.text.x = 202;
         this.text.y = 117;
         addChild(this.text);
         this.ready.x = 320;
         this.ready.y = 314;
         this.ready.scaleX = 0;
         this.ready.scaleY = 0;
         addChild(this.ready);
      }
      
      private function checkFrame(param1:Event) : void
      {
         this.text.bytes.text = int(loaderInfo.bytesLoaded / (loaderInfo.bytesTotal / 100)) + "%";
         if(loaderInfo.bytesLoaded == loaderInfo.bytesTotal)
         {
            this.text.bytes.text = "100%";
            removeEventListener(Event.ENTER_FRAME,this.checkFrame);
            MFTween.tween(this.ready,2,{
               "scaleX":1,
               "scaleY":1
            }).ease(Elastic.easeOut);
            this.ready.addEventListener(MouseEvent.CLICK,this.startup);
         }
      }
      
      private function startup(param1:MouseEvent) : void
      {
         gotoAndStop(2);
         this.ready.removeEventListener(MouseEvent.CLICK,this.startup);
         removeChild(this.ready);
         var _loc2_:App = new App();
         addChild(_loc2_);
      }
   }
}
