package PlazaMall_fla
{
   import adobe.utils.*;
   import flash.accessibility.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.Game_504")]
   public dynamic class Game_504 extends MovieClip
   {
       
      
      public var tog:*;
      
      public var canClick:*;
      
      public function Game_504()
      {
         super();
         addFrameScript(0,frame1,1,frame2,2,frame3);
      }
      
      public function activeButton() : void
      {
         var _loc1_:* = undefined;
         if(!canClick)
         {
            addEventListener(MouseEvent.CLICK,onMouseClick);
            canClick = true;
            _loc1_ = this.parent;
            _loc1_.transform.colorTransform = new ColorTransform(1,1,1,1,0,0,0,0);
         }
      }
      
      public function onMouseClick(param1:MouseEvent) : void
      {
         if(buttonMode)
         {
            tog = !tog;
         }
      }
      
      internal function frame3() : *
      {
         stop();
      }
      
      internal function frame1() : *
      {
         canClick = true;
         tog = false;
         stop();
         this.buttonMode = true;
         addEventListener(MouseEvent.CLICK,onMouseClick);
         addEventListener(Event.ENTER_FRAME,buttonAnimation);
      }
      
      internal function frame2() : *
      {
         stop();
      }
      
      public function buttonAnimation(param1:Event) : void
      {
         if(tog)
         {
            gotoAndPlay(3);
         }
         else
         {
            gotoAndPlay(2);
         }
      }
      
      public function deactiveButton() : void
      {
         var _loc1_:* = undefined;
         if(canClick)
         {
            removeEventListener(MouseEvent.CLICK,onMouseClick);
            canClick = false;
            _loc1_ = this.parent;
            _loc1_.transform.colorTransform = new ColorTransform(0.5,0.5,0.5,1,0,0,0,0);
         }
      }
   }
}
