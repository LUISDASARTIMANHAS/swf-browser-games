package uk.co.kempt.translation
{
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import uk.co.kempt.display.menu.LanguageSelector;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.translation.LanguagePicker")]
   public dynamic class LanguagePicker extends MovieClip
   {
      
      private static const S_TRANSITION_IN:String = "transitionIn";
      
      private static const LABEL_MAIN:String = "main";
      
      private static const LABEL_WAIT:String = "wait";
      
      private static const LABEL_FAILED:String = "failed";
      
      private static const S_TRANSITION_OUT:String = "transitionOut";
      
      private static const LABEL_READY:String = "ready";
       
      
      private var _state:String;
      
      private var _wait:int;
      
      public var languageSelector:LanguageSelector;
      
      public function LanguagePicker()
      {
         super();
         if(stage)
         {
            this.init();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         }
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this.init();
      }
      
      public function enable(param1:Boolean) : void
      {
         mouseEnabled = mouseChildren = param1;
      }
      
      private function onEnterFrameEvent(param1:Event) : void
      {
         switch(this._state)
         {
            case S_TRANSITION_IN:
               this.updateStateTransitionIn();
               break;
            case S_TRANSITION_OUT:
               this.updateStateTransitionOut();
         }
      }
      
      private function doExit() : void
      {
         this._state = S_TRANSITION_OUT;
         this.enable(false);
      }
      
      private function onTransitionInFinished() : void
      {
         this._state = null;
         this.enable(true);
      }
      
      private function onTransitionOutFinished() : void
      {
         this._state = null;
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private function init() : void
      {
         var _loc3_:DisplayObject = null;
         blendMode = BlendMode.LAYER;
         alpha = 0;
         this._wait = 0;
         this._state = S_TRANSITION_IN;
         addEventListener(Event.ENTER_FRAME,this.onEnterFrameEvent,false,0,true);
         gotoAndStop(LABEL_MAIN);
         this.enable(false);
         var _loc1_:String = String(root.loaderInfo.parameters["force_lang"]);
         if(_loc1_)
         {
            if(TranslationEngine.hasLanguage(_loc1_))
            {
               trace("has forced language");
               this.loadLanguage(_loc1_);
               if(this.languageSelector)
               {
                  this.languageSelector.visible = false;
               }
               return;
            }
         }
         var _loc2_:int = int(numChildren);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = getChildAt(_loc4_);
            if(_loc3_ is SimpleButton)
            {
               SimpleButton(_loc3_).addEventListener(MouseEvent.CLICK,this.onButtonClicked,false,0,true);
            }
            _loc4_++;
         }
         this.languageSelector.addEventListener(Event.COMPLETE,this.onLanguageSelected,false,0,true);
      }
      
      private function onTranslationReady(param1:Event) : void
      {
         gotoAndStop(LABEL_READY);
         this.doExit();
      }
      
      private function onButtonClicked(param1:MouseEvent) : void
      {
         var _loc2_:SimpleButton = param1.currentTarget as SimpleButton;
         var _loc3_:String = String(_loc2_.name);
         trace(_loc3_ + " clicked");
         TranslationEngine.instance.addEventListener(Event.COMPLETE,this.onTranslationReady);
         TranslationEngine.instance.addEventListener(ErrorEvent.ERROR,this.onTranslationError);
         gotoAndStop(LABEL_WAIT);
         TranslationEngine.instance.init(_loc3_);
      }
      
      private function updateStateTransitionOut() : void
      {
         if(alpha > 0)
         {
            alpha -= 1 / (30 * 0.4);
            if(alpha <= 0)
            {
               alpha = 0;
               this.onTransitionOutFinished();
            }
         }
      }
      
      private function onLanguageSelected(param1:Event) : void
      {
         var _loc2_:String = this.languageSelector.selectedLabel;
         trace(_loc2_ + " clicked");
         this.loadLanguage(_loc2_);
      }
      
      private function updateStateTransitionIn() : void
      {
         if(this._wait < 30)
         {
            ++this._wait;
            return;
         }
         if(alpha < 1)
         {
            alpha += 1 / (30 * 0.6);
            if(alpha >= 1)
            {
               alpha = 1;
               this.onTransitionInFinished();
            }
         }
      }
      
      private function onTranslationError(param1:ErrorEvent) : void
      {
         gotoAndStop(LABEL_FAILED);
         this.doExit();
      }
      
      private function loadLanguage(param1:String) : void
      {
         TranslationEngine.instance.addEventListener(Event.COMPLETE,this.onTranslationReady,false,0,true);
         TranslationEngine.instance.addEventListener(ErrorEvent.ERROR,this.onTranslationError,false,0,true);
         gotoAndStop(LABEL_WAIT);
         TranslationEngine.instance.init(param1);
      }
   }
}
