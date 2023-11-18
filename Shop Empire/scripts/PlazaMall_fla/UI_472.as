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
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.UI_472")]
   public dynamic class UI_472 extends MovieClip
   {
       
      
      public var helpBar:MovieClip;
      
      public var myParent:*;
      
      public var slideBar:SimpleButton;
      
      public function UI_472()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function MouseDownEvent(param1:MouseEvent) : void
      {
         slideBar.x = mouseX;
         UpdateSound();
         stage.addEventListener(MouseEvent.MOUSE_UP,MouseUpEvent);
         stage.addEventListener(MouseEvent.MOUSE_MOVE,MouseMoveEvent);
      }
      
      public function MouseMoveEvent(param1:MouseEvent) : void
      {
         slideBar.x = mouseX;
         if(slideBar.x < helpBar.x)
         {
            slideBar.x = helpBar.x;
         }
         if(slideBar.x > helpBar.x + helpBar.width)
         {
            slideBar.x = helpBar.x + helpBar.width;
         }
         UpdateSound();
      }
      
      internal function frame1() : *
      {
         buttonMode = true;
         myParent = root;
         slideBar.x = helpBar.x + helpBar.width * myParent.bgmVolume;
         addEventListener(MouseEvent.MOUSE_DOWN,MouseDownEvent);
      }
      
      public function UpdateSound() : void
      {
         myParent.bgmVolume = (slideBar.x - helpBar.x) / helpBar.width;
         if(myParent.currentLabel == "Main Program")
         {
            with(myParent)
            {
               
               bgmTransform.volume = bgmVolume * bgmEnvironment;
               bgmChannel.soundTransform = bgmTransform;
            }
         }
         else if(myParent.currentLabel == "Main Menu")
         {
            with(myParent)
            {
               
               bgmTransform.volume = bgmVolume;
               mainMenuBGMChannel.soundTransform = bgmTransform;
            }
         }
      }
      
      public function MouseUpEvent(param1:MouseEvent) : void
      {
         stage.removeEventListener(MouseEvent.MOUSE_UP,MouseUpEvent);
         stage.removeEventListener(MouseEvent.MOUSE_MOVE,MouseMoveEvent);
      }
   }
}
