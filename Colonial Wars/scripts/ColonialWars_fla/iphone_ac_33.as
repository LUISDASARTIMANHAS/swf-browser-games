package ColonialWars_fla
{
   import flash.accessibility.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.net.drm.*;
   import flash.system.*;
   import flash.text.*;
   import flash.text.ime.*;
   import flash.ui.*;
   import flash.utils.*;
   
   [Embed(source="/_assets/assets.swf", symbol="ColonialWars_fla.iphone_ac_33")]
   public dynamic class iphone_ac_33 extends MovieClip
   {
       
      
      public var action:MovieClip;
      
      public function iphone_ac_33()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      public function actionf() : *
      {
         navigateToURL(new URLRequest("http://ios.3j.com/?forcedirect=114"));
      }
      
      internal function frame1() : *
      {
         stop();
         this.action.addEventListener(MouseEvent.CLICK,function():*
         {
            actionf();
         });
         this.action.buttonMode = true;
      }
   }
}
