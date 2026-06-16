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
   
   [Embed(source="/_assets/assets.swf", symbol="ColonialWars_fla.logo_ac_25")]
   public dynamic class logo_ac_25 extends MovieClip
   {
       
      
      public var action:MovieClip;
      
      public function logo_ac_25()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      public function actionf() : *
      {
         navigateToURL(new URLRequest("http://www.4v4.com/free-online-strategy-games.html?utm_medium=brandedgames_external&utm_campaign=colonialwars&utm_source=host&utm_content=ingame"));
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
