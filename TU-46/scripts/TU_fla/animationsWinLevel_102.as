package TU_fla
{
   import adobe.utils.*;
   import flash.accessibility.*;
   import flash.desktop.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.sampler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.text.engine.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   
   [Embed(source="/_assets/assets.swf", symbol="TU_fla.animationsWinLevel_102")]
   public dynamic class animationsWinLevel_102 extends MovieClip
   {
       
      
      public var quickStats:MovieClip;
      
      public var threeBtns:MovieClip;
      
      public var shop:MovieClip;
      
      public var map:MovieClip;
      
      public var armorBtn:SimpleButton;
      
      public var stats:MovieClip;
      
      public function animationsWinLevel_102()
      {
         super();
         addFrameScript(0,this.frame1,274,this.frame275,322,this.frame323,364,this.frame365,405,this.frame406,437,this.frame438,478,this.frame479,514,this.frame515);
      }
      
      internal function frame275() : *
      {
         stop();
         MovieClip(root).mapFunctions();
      }
      
      internal function frame365() : *
      {
         gotoAndStop("toMapLabel");
      }
      
      internal function frame323() : *
      {
         stop();
      }
      
      internal function frame479() : *
      {
         stop();
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame406() : *
      {
         stop();
      }
      
      internal function frame438() : *
      {
         gotoAndStop("toMapLabel");
      }
      
      internal function frame515() : *
      {
         gotoAndStop("toMapLabel");
      }
   }
}
