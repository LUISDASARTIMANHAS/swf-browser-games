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
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.Transition_484")]
   public dynamic class Transition_484 extends MovieClip
   {
       
      
      public var btnContinue:SimpleButton;
      
      public var head:*;
      
      public function Transition_484()
      {
         super();
         addFrameScript(54,frame55,80,frame81);
      }
      
      public function BeginGame(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = param1.currentTarget;
         _loc2_.removeEventListener(MouseEvent.CLICK,BeginGame);
         gotoAndPlay("Next Frame");
      }
      
      internal function frame81() : *
      {
         head.gotoAndPlay("Main Program");
      }
      
      internal function frame55() : *
      {
         stop();
         head = root;
         head.startCity = 1;
         head.gameLoaded = -1;
         btnContinue.addEventListener(MouseEvent.CLICK,BeginGame);
      }
   }
}
