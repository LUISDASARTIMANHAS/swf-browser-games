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
   
   [Embed(source="/_assets/assets.swf", symbol="TokyoBoothAvailable")]
   public dynamic class TokyoBoothAvailable extends MovieClip
   {
       
      
      public var btnStartGame:SimpleButton;
      
      public var head:*;
      
      public function TokyoBoothAvailable()
      {
         super();
         addFrameScript(12,frame13,25,frame26);
      }
      
      public function RemoveThisObject(param1:MouseEvent) : void
      {
         this.parent.removeChild(this);
      }
      
      internal function frame13() : *
      {
         head = root;
         btnStartGame.addEventListener(MouseEvent.CLICK,head.StartGame);
         btnStartGame.addEventListener(MouseEvent.CLICK,RemoveThisObject);
      }
      
      internal function frame26() : *
      {
         gotoAndPlay("BlinkStart");
      }
   }
}
