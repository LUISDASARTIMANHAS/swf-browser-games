package uk.co.kempt.display.menu.pages
{
   import flash.text.TextField;
   import uk.co.kempt.Engine;
   import uk.co.kempt.data.LevelStatistics;
   import uk.co.kempt.display.HUD;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.display.menu.pages.BudgetReportPage")]
   public class BudgetReportPage extends AbstractPage
   {
       
      
      public var level_txt:TextField;
      
      public var budget_txt:TextField;
      
      public function BudgetReportPage()
      {
         super();
         var _loc1_:LevelStatistics = Engine.instance.levelStatistics;
         this.level_txt.text = 1 + Math.floor((Engine.instance.currentLevelNum - 1) / 5) + "." + (1 + (Engine.instance.currentLevelNum - 1) % 5);
         this.budget_txt.text = HUD.formatMoney(_loc1_.budget);
      }
   }
}
