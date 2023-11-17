package uk.co.kempt.display.menu.pages
{
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import uk.co.kempt.Engine;
   import uk.co.kempt.highscores.utils.HighscoresParser;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.display.menu.pages.HighScoresPage")]
   public class HighScoresPage extends AbstractPage
   {
       
      
      public var findYou_btn:SimpleButton;
      
      public var topTen_btn:SimpleButton;
      
      public var scorenames_txt:TextField;
      
      public var next_btn:SimpleButton;
      
      public var scores_txt:TextField;
      
      public var scoreids_txt:TextField;
      
      public function HighScoresPage()
      {
         super();
         this.scoreids_txt.text = "";
         this.scorenames_txt.text = "";
         this.scores_txt.text = "";
         this.displayScores();
         this.next_btn.addEventListener(MouseEvent.CLICK,this.onNextClicked,false,0,true);
         this.topTen_btn.addEventListener(MouseEvent.CLICK,this.onTopTenClicked,false,0,true);
         this.findYou_btn.addEventListener(MouseEvent.CLICK,this.onFindYouClicked,false,0,true);
      }
      
      private function onTopTenClicked(param1:MouseEvent) : void
      {
         this.displayScores();
      }
      
      private function onFindYouClicked(param1:MouseEvent) : void
      {
         this.displayScores("me");
      }
      
      private function displayScores(param1:String = "top10") : void
      {
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc9_:String = null;
         var _loc2_:XML = Engine.instance.highscoresSystem.data;
         if(_loc2_)
         {
            _loc3_ = HighscoresParser.getIds(_loc2_,param1);
            _loc4_ = HighscoresParser.getNames(_loc2_,param1);
            _loc5_ = HighscoresParser.getPositions(_loc2_,param1);
            _loc6_ = HighscoresParser.getScores(_loc2_,param1);
            _loc7_ = String(Engine.instance.highscoresSystem.pId.toString());
            if((_loc8_ = int(_loc3_.indexOf(_loc7_))) != -1)
            {
               _loc9_ = "<font color=\"#F4D94E\">";
               _loc4_[_loc8_] = _loc9_ + _loc4_[_loc8_] + "</font>";
               _loc5_[_loc8_] = _loc9_ + _loc5_[_loc8_] + "</font>";
               _loc6_[_loc8_] = _loc9_ + _loc6_[_loc8_] + "</font>";
            }
            this.scoreids_txt.htmlText = _loc5_.join("<br/>");
            this.scorenames_txt.htmlText = _loc4_.join("<br/>");
            this.scores_txt.htmlText = _loc6_.join("<br/>");
         }
         else
         {
            trace("HighScoresPage: no data");
         }
      }
      
      private function onNextClicked(param1:MouseEvent) : void
      {
         Engine.instance.highscoresSystem.resume();
      }
   }
}
