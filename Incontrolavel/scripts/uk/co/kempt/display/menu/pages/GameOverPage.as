package uk.co.kempt.display.menu.pages
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import uk.co.kempt.Engine;
   import uk.co.kempt.data.LevelStatisticsCollection;
   import uk.co.kempt.display.HUD;
   import uk.co.kempt.translation.TranslationEngine;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.display.menu.pages.GameOverPage")]
   public class GameOverPage extends AbstractPage
   {
      
      private static const REASON_1:String = "The train was destroyed because you took too long to build the track";
      
      private static const REASON_2:String = "The train was destroyed because you didn’t reach the exit in time";
      
      private static const REASON_3:String = "The train was destroyed in a huge explosion";
      
      private static const REASON_4:String = "The train was destroyed because the track angle was too steep!";
      
      private static const REASON_5:String = "The train destroyed the hospital in a huge explosion";
      
      private static const REASON_6:String = "You went over your allocated budget";
       
      
      public var dBadge4:MovieClip;
      
      public var sectionTitle1_txt:TextField;
      
      public var sectionTitle2_txt:TextField;
      
      public var sectionTitle3_txt:TextField;
      
      public var sectionTitle5_txt:TextField;
      
      public var sectionScore1_txt:TextField;
      
      public var sectionScore2_txt:TextField;
      
      public var sectionScore3_txt:TextField;
      
      public var sectionScore4_txt:TextField;
      
      public var sectionScore5_txt:TextField;
      
      public var backToStart_btn:SimpleButton;
      
      public var signs_mc:MovieClip;
      
      public var sectionTitle4_txt:TextField;
      
      public var playAgain_btn:SimpleButton;
      
      public var dBadge2:MovieClip;
      
      public var dBadge3:MovieClip;
      
      public var dBadge5:MovieClip;
      
      public var submitScore_btn:SimpleButton;
      
      public var dBadge1:MovieClip;
      
      public var reason_txt:TextField;
      
      public var cost_txt:TextField;
      
      public function GameOverPage()
      {
         var _loc3_:int = 0;
         super();
         addFrameScript(26,this.frame27);
         var _loc1_:int = 1 + Math.floor((Engine.instance.currentLevelNum - 1) / 5);
         var _loc2_:LevelStatisticsCollection = Engine.instance.levelStatsCollection;
         this.backToStart_btn.addEventListener(MouseEvent.CLICK,this.onBackToStartClicked,false,0,true);
         this.playAgain_btn.addEventListener(MouseEvent.CLICK,this.onPlayAgainClicked,false,0,true);
         this.submitScore_btn.addEventListener(MouseEvent.CLICK,this.onSubmitScoreClicked,false,0,true);
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
         this.cost_txt.text = "no data";
         this.cost_txt.text = HUD.formatMoney(Engine.instance.gameStatsCollection.gross);
         if(Engine.instance.levelStatistics.hitSteepCorner)
         {
            _loc3_ = 4;
         }
         else if(Engine.instance.levelStatistics.hitHospital)
         {
            _loc3_ = 5;
         }
         else if(Engine.instance.levelStatistics.hitDangerousBuilding)
         {
            _loc3_ = 3;
         }
         else if(!Engine.instance.levelStatistics.crashed && Engine.instance.levelStatistics.gross < 0)
         {
            _loc3_ = 6;
         }
         else if(!Engine.instance.levelStatistics.reachedExit)
         {
            _loc3_ = 2;
         }
         else
         {
            _loc3_ = 1;
         }
         this.reason_txt.text = TranslationEngine.instance.getTranslation("reason_" + _loc3_);
         this.signs_mc.gotoAndStop("reason" + _loc3_);
         this.dBadge1.gotoAndStop(AbstractPage.getBadgeLabel(_loc2_.getStatByIndex(0)));
         this.dBadge2.gotoAndStop(AbstractPage.getBadgeLabel(_loc2_.getStatByIndex(1)));
         this.dBadge3.gotoAndStop(AbstractPage.getBadgeLabel(_loc2_.getStatByIndex(2)));
         this.dBadge4.gotoAndStop(AbstractPage.getBadgeLabel(_loc2_.getStatByIndex(3)));
         this.dBadge5.gotoAndStop(AbstractPage.getBadgeLabel(_loc2_.getStatByIndex(4)));
      }
      
      private function onPlayAgainClicked(param1:MouseEvent) : void
      {
         Engine.instance.playAgainTriggeredByUser();
      }
      
      private function onBackToStartClicked(param1:MouseEvent) : void
      {
         Engine.instance.mainMenuTriggeredByUser();
      }
      
      internal function frame27() : *
      {
         stop();
      }
      
      private function onSubmitScoreClicked(param1:MouseEvent) : void
      {
         Engine.instance.highscoresSystem.submit();
      }
   }
}
