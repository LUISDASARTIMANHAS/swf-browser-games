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
   
   [Embed(source="/_assets/assets.swf", symbol="ColonialWars_fla.android_ac_35")]
   public dynamic class android_ac_35 extends MovieClip
   {
       
      
      public var action:MovieClip;
      
      public function android_ac_35()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      public function actionf() : *
      {
         navigateToURL(new URLRequest("http://android.3j.com/?forcedirect=114"));
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
