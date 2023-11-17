package uk.co.kempt
{
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.system.Security;
   import uk.co.kempt.display.UnstoppableLoader;
   import uk.co.kempt.translation.LanguagePicker;
   import uk.co.kempt.translation.TranslationEngine;
   import uk.co.kempt.versioning.VersionChecker;
   
   public class UnstoppableDocument extends VersionChecker
   {
      
      private static const GAME_VERSION:int = 1;
      
      private static var INSTANCE:UnstoppableDocument;
       
      
      public var languagePicker:LanguagePicker;
      
      public var loadingBar:UnstoppableLoader;
      
      public var banner:MovieClip;
      
      public function UnstoppableDocument()
      {
         addFrameScript(1,this.frame2,3,this.frame4);
         trace("v_151.3");
         INSTANCE = this;
         debug("unstoppable allowing all domains");
         Security.allowDomain("*");
         super();
         stop();
         if(this.loadingBar)
         {
            this.loadingBar.visible = false;
         }
      }
      
      public static function get instance() : UnstoppableDocument
      {
         return INSTANCE;
      }
      
      override protected function useNewVersionLoaderInfo(param1:LoaderInfo) : void
      {
         debug("useNewVersionLoaderInfo");
         this.loadingBar.addLoaderInfo(param1);
         this.loadingBar.visible = true;
      }
      
      private function checkReady(param1:Event) : void
      {
         if(this.loadingBar)
         {
            if(this.loadingBar.ready)
            {
               if(TranslationEngine.instance.ready)
               {
                  param1.currentTarget.removeEventListener(param1.type,arguments.callee);
                  this.onGameReady();
               }
            }
         }
      }
      
      override protected function stopUsingLoaderInfo(param1:LoaderInfo) : void
      {
         this.loadingBar.removeLoaderInfo(param1);
      }
      
      internal function frame2() : *
      {
         stop();
      }
      
      override public function get checkURL() : String
      {
         return "http://www.memecounter.com/comms/v.php?v=1&cId=952";
      }
      
      override public function get masterURL() : String
      {
         return "http://www.unstoppable-game.com/swf/unstoppable.swf";
      }
      
      override protected function onVersionChecked() : void
      {
         debug("version checking complete, init");
         if(stage)
         {
            this.init();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStageInit);
         }
      }
      
      private function init() : void
      {
         debug("init");
         stage.scaleMode = StageScaleMode.NO_SCALE;
         this.loadingBar.addLoaderInfo(root.loaderInfo);
         TranslationEngine.TRANSLATION_PATH = "http://www.unstoppable-game.com/translations/" + this.version + "/";
         this.loadingBar.visible = true;
         play();
         addEventListener(Event.ENTER_FRAME,this.checkReady,false,0,true);
      }
      
      private function onGameReady() : void
      {
         debug("onGameReady");
         gotoAndStop("loaded");
      }
      
      internal function frame4() : *
      {
         stop();
      }
      
      override public function get version() : int
      {
         return GAME_VERSION;
      }
      
      private function onAddedToStageInit(param1:Event) : void
      {
         debug("onAddedToStageInit");
         param1.currentTarget.removeEventListener(param1.type,arguments.callee);
         this.init();
      }
      
      override protected function onBeforeDestroy() : void
      {
         debug("we\'re about to be destroyed");
         super.onBeforeDestroy();
      }
   }
}
