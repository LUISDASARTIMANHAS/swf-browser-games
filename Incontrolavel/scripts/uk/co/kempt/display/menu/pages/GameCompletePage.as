package uk.co.kempt.display.menu.pages
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import uk.co.kempt.Engine;
   import uk.co.kempt.data.LevelStatisticsCollection;
   import uk.co.kempt.display.HUD;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.display.menu.pages.GameCompletePage")]
   public class GameCompletePage extends AbstractPage
   {
       
      
      public var dBadge4:MovieClip;
      
      public var sectionScore1_txt:TextField;
      
      public var sectionScore2_txt:TextField;
      
      public var sectionScore3_txt:TextField;
      
      public var sectionScore4_txt:TextField;
      
      public var sectionScore5_txt:TextField;
      
      public var backToStart_btn:SimpleButton;
      
      public var highscores_btn:SimpleButton;
      
      public var dBadge1:MovieClip;
      
      public var dBadge2:MovieClip;
      
      public var dBadge3:MovieClip;
      
      public var percent_txt:TextField;
      
      public var submitScore_btn:SimpleButton;
      
      public var dBadge5:MovieClip;
      
      public var cost_txt:TextField;
      
      public function GameCompletePage()
      {
         super();
         addFrameScript(28,this.frame29);
         var _loc1_:LevelStatisticsCollection = Engine.instance.gameStatsCollection;
         this.sectionScore1_txt.text = HUD.formatMoney2(!!_loc1_.getStatByIndex(0) ? _loc1_.getStatByIndex(0).gross : 0);
         this.sectionScore2_txt.text = HUD.formatMoney2(!!_loc1_.getStatByIndex(1) ? _loc1_.getStatByIndex(1).gross : 0);
         this.sectionScore3_txt.text = HUD.formatMoney2(!!_loc1_.getStatByIndex(2) ? _loc1_.getStatByIndex(2).gross : 0);
         this.sectionScore4_txt.text = HUD.formatMoney2(!!_loc1_.getStatByIndex(3) ? _loc1_.getStatByIndex(3).gross : 0);
         this.sectionScore5_txt.text = HUD.formatMoney2(!!_loc1_.getStatByIndex(4) ? _loc1_.getStatByIndex(4).gross : 0);
         this.cost_txt.text = HUD.formatMoney(_loc1_.gross);
         this.dBadge1.gotoAndStop(AbstractPage.LABEL_BADGE_GREEN);
         this.dBadge2.gotoAndStop(AbstractPage.LABEL_BADGE_GREEN);
         this.dBadge3.gotoAndStop(AbstractPage.LABEL_BADGE_GREEN);
         this.dBadge4.gotoAndStop(AbstractPage.LABEL_BADGE_GREEN);
         this.dBadge5.gotoAndStop(AbstractPage.LABEL_BADGE_GREEN);
         this.backToStart_btn.addEventListener(MouseEvent.CLICK,this.onMainMenuClicked,false,0,true);
         this.highscores_btn.addEventListener(MouseEvent.CLICK,this.onHighscoresClicked,false,0,true);
         this.submitScore_btn.addEventListener(MouseEvent.CLICK,this.onSubmitScoreClicked,false,0,true);
      }
      
      internal function frame29() : *
      {
         stop();
      }
      
      private function onHighscoresClicked(param1:MouseEvent) : void
      {
         Engine.instance.highscoresSystem.show();
      }
      
      private function onSubmitScoreClicked(param1:MouseEvent) : void
      {
         Engine.instance.highscoresSystem.submit();
      }
      
      private function onMainMenuClicked(param1:MouseEvent) : void
      {
         Engine.instance.mainMenuTriggeredByUser();
      }
   }
}
