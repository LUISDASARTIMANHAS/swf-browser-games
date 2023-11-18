package
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
   
   [Embed(source="/_assets/assets.swf", symbol="GameOverScreen")]
   public dynamic class GameOverScreen extends MovieClip
   {
       
      
      public function GameOverScreen()
      {
         super();
         addFrameScript(0,frame1,48,frame49,59,frame60);
      }
      
      internal function frame1() : *
      {
         stage.addEventListener(KeyboardEvent.KEY_UP,SkipAnimation);
         stage.addEventListener(MouseEvent.CLICK,SkipAnimation);
      }
      
      public function SkipAnimation(param1:Event) : void
      {
         gotoAndPlay("startBlink");
      }
      
      internal function frame49() : *
      {
         stage.removeEventListener(KeyboardEvent.KEY_UP,SkipAnimation);
         stage.removeEventListener(MouseEvent.CLICK,SkipAnimation);
         stage.addEventListener(KeyboardEvent.KEY_UP,BackToMainMenu);
         stage.addEventListener(MouseEvent.CLICK,BackToMainMenu);
      }
      
      public function BackToMainMenu(param1:Event) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = root;
         stage.removeEventListener(KeyboardEvent.KEY_UP,BackToMainMenu);
         stage.removeEventListener(MouseEvent.CLICK,BackToMainMenu);
         this.parent.removeChild(this);
         _loc2_.BackToMainMenu();
      }
      
      internal function frame60() : *
      {
         gotoAndPlay("blink");
      }
   }
}
