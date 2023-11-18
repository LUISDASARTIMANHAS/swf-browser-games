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
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.UI_570")]
   public dynamic class UI_570 extends MovieClip
   {
       
      
      public var toggleMusic:MovieClip;
      
      public var myParent:*;
      
      public var toggleSFX:MovieClip;
      
      public var bgmSlider:MovieClip;
      
      public var sfxSlider:MovieClip;
      
      public function UI_570()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         myParent = this.parent.parent;
         toggleMusic.buttonMode = true;
         toggleSFX.buttonMode = true;
         toggleMusic.addEventListener(MouseEvent.CLICK,ToggleBGM);
         toggleSFX.addEventListener(MouseEvent.CLICK,ToggleSE);
      }
      
      public function ToggleBGM(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         if(myParent.bgmVolume > 0)
         {
            myParent.bgmVolume = 0;
         }
         else
         {
            myParent.bgmVolume = 1;
         }
         with(bgmSlider)
         {
            slideBar.x = helpBar.x + helpBar.width * myParent.bgmVolume;
         }
         with(myParent)
         {
            bgmTransform.volume = bgmVolume * bgmEnvironment;
            bgmChannel.soundTransform = bgmTransform;
         }
      }
      
      public function ToggleSE(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         if(myParent.seVolume > 0)
         {
            myParent.seVolume = 0;
         }
         else
         {
            myParent.seVolume = 1;
         }
         with(sfxSlider)
         {
            slideBar.x = helpBar.x + helpBar.width * myParent.seVolume;
         }
         with(myParent)
         {
            seTransform.volume = seVolume;
            try
            {
               seChannel.soundTransform = seTransform;
            }
            catch(e:Error)
            {
            }
         }
      }
   }
}
