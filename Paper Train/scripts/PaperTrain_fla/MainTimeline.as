package PaperTrain_fla
{
   import adobe.utils.*;
   import com.lib.*;
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
   
   public dynamic class MainTimeline extends MovieClip
   {
       
      
      public var _game:*;
      
      public var loader:*;
      
      public function MainTimeline()
      {
         super();
         addFrameScript(0,this.frame1,2,this.frame3);
      }
      
      public function startGame() : *
      {
         removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         gotoAndStop(3);
      }
      
      public function onEnterFrame(param1:Event) : *
      {
         var _loc2_:* = new Date();
         var _loc3_:* = _loc2_.time;
         var _loc4_:* = loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal;
         var _loc5_:* = loaderInfo.bytesLoaded == root.loaderInfo.bytesTotal ? true : false;
         this.loader.frame(_loc4_,_loc5_);
      }
      
      internal function frame1() : *
      {
         this.loader = new GLoader(this.startGame);
         addChild(this.loader);
         this.loader.init();
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         stop();
      }
      
      internal function frame3() : *
      {
         this._game = new PaperTrain();
         addChild(this._game);
         this._game.begin();
         stop();
      }
   }
}
