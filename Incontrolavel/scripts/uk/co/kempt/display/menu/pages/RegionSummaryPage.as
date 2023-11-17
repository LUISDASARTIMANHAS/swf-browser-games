package uk.co.kempt.display.menu.pages
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import uk.co.kempt.Engine;
   import uk.co.kempt.data.LevelStatisticsCollection;
   import uk.co.kempt.display.HUD;
   import uk.co.kempt.translation.TranslationEngine;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.display.menu.pages.RegionSummaryPage")]
   public class RegionSummaryPage extends AbstractPage
   {
       
      
      public var replay_btn:SimpleButton;
      
      public var title_txt:TextField;
      
      public var sectionTitle1_txt:TextField;
      
      public var sectionTitle2_txt:TextField;
      
      public var sectionTitle3_txt:TextField;
      
      public var sectionTitle5_txt:TextField;
      
      public var sectionScore1_txt:TextField;
      
      public var sectionScore2_txt:TextField;
      
      public var sectionScore3_txt:TextField;
      
      public var sectionScore4_txt:TextField;
      
      public var sectionScore5_txt:TextField;
      
      public var dBadge:MovieClip;
      
      public var sectionTitle4_txt:TextField;
      
      public var dBadge2:MovieClip;
      
      public var dBadge3:MovieClip;
      
      public var dBadge4:MovieClip;
      
      public var dBadge5:MovieClip;
      
      public var submitScore_btn:SimpleButton;
      
      public var dBadge1:MovieClip;
      
      public var next_btn:SimpleButton;
      
      public var cost_txt:TextField;
      
      public function RegionSummaryPage()
      {
         super();
         addFrameScript(24,this.frame25);
         var _loc1_:int = 1 + Math.floor((Engine.instance.currentLevelNum - 1) / 5);
         var _loc2_:LevelStatisticsCollection = Engine.instance.levelStatsCollection;
         this.sectionTitle1_txt.text = _loc1_.toString() + ".1:";
         this.sectionTitle2_txt.text = _loc1_.toString() + ".2:";
         this.sectionTitle3_txt.text = _loc1_.toString() + ".3:";
         this.sectionTitle4_txt.text = _loc1_.toString() + ".4:";
         this.sectionTitle5_txt.text = _loc1_.toString() + ".5:";
         this.sectionScore1_txt.text = AbstractPage.getMoneyText(_loc2_.getStatByIndex(0));
         this.sectionScore2_txt.text = AbstractPage.getMoneyText(_loc2_.getStatByIndex(1));
         this.sectionScore3_txt.text = AbstractPage.getMoneyText(_loc2_.getStatByIndex(2));
         this.sectionScore4_txt.text = AbstractPage.getMoneyText(_loc2_.getStatByIndex(3));
         this.sectionScore5_txt.text = AbstractPage.getMoneyText(_loc2_.getStatByIndex(4));
         this.dBadge1.gotoAndStop(AbstractPage.getBadgeLabel(_loc2_.getStatByIndex(0)));
         this.dBadge2.gotoAndStop(AbstractPage.getBadgeLabel(_loc2_.getStatByIndex(1)));
         this.dBadge3.gotoAndStop(AbstractPage.getBadgeLabel(_loc2_.getStatByIndex(2)));
         this.dBadge4.gotoAndStop(AbstractPage.getBadgeLabel(_loc2_.getStatByIndex(3)));
         this.dBadge5.gotoAndStop(AbstractPage.getBadgeLabel(_loc2_.getStatByIndex(4)));
         this.dBadge.gotoAndStop(_loc2_.totalCost > 0 ? AbstractPage.LABEL_BADGE_GREEN : AbstractPage.LABEL_BADGE_GOLD);
         this.cost_txt.text = "no data";
         this.cost_txt.text = HUD.formatMoney(Engine.instance.gameStatsCollection.gross);
         this.title_txt.text = TranslationEngine.instance.getTranslation("title_area") + " " + _loc1_.toString();
         this.replay_btn.addEventListener(MouseEvent.CLICK,this.onReplayClicked);
         this.next_btn.addEventListener(MouseEvent.CLICK,this.onNextClicked);
         this.submitScore_btn.addEventListener(MouseEvent.CLICK,this.onSubmitScoreClicked,false,0,true);
      }
      
      private function applyFormatting(param1:TextField) : void
      {
         param1.multiline = false;
         param1.wordWrap = false;
         param1.autoSize = TextFieldAutoSize.CENTER;
      }
      
      private function onReplayClicked(param1:MouseEvent) : void
      {
         Engine.instance.playAgainTriggeredByUser();
      }
      
      private function onSubmitScoreClicked(param1:MouseEvent) : void
      {
         Engine.instance.highscoresSystem.submit();
      }
      
      private function onNextClicked(param1:MouseEvent) : void
      {
         Engine.instance.nextLevelTriggeredByUser();
      }
      
      internal function frame25() : *
      {
         stop();
      }
   }
}
