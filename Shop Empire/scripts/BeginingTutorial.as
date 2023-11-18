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
   
   [Embed(source="/_assets/assets.swf", symbol="BeginingTutorial")]
   public dynamic class BeginingTutorial extends MovieClip
   {
       
      
      public var btnStartGame:MovieClip;
      
      public var head:*;
      
      public function BeginingTutorial()
      {
         super();
         addFrameScript(0,frame1,11,frame12);
      }
      
      public function RemoveThisObject(param1:MouseEvent) : void
      {
         this.parent.removeChild(this);
      }
      
      internal function frame12() : *
      {
         gotoAndPlay("BlinkStart");
      }
      
      internal function frame1() : *
      {
         head = root;
         btnStartGame.buttonMode = true;
         btnStartGame.addEventListener(MouseEvent.CLICK,head.StartGame);
         btnStartGame.addEventListener(MouseEvent.CLICK,RemoveThisObject);
      }
   }
}
