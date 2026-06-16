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
   
   [Embed(source="/_assets/assets.swf", symbol="ColonialWars_fla.logo4v4_183")]
   public dynamic class logo4v4_183 extends MovieClip
   {
       
      
      public var logo:MovieClip;
      
      public var buttonplay:SimpleButton;
      
      public function logo4v4_183()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      public function playlogonow(param1:Event) : *
      {
         this.logo.play();
         gotoAndStop(2);
      }
      
      public function gotowebsite(param1:Event) : *
      {
         navigateToURL(new URLRequest("http://www.4v4.com/free-online-strategy-games.html?utm_medium=brandedgames_external&utm_campaign=colonialwars&utm_source=host&utm_content=ingame"));
      }
      
      internal function frame1() : *
      {
         this.buttonplay.addEventListener(MouseEvent.CLICK,this.playlogonow);
         this.logo.addEventListener(MouseEvent.CLICK,this.gotowebsite);
         this.logo.buttonMode = true;
         stop();
      }
   }
}
