package unstoppable_fla
{
   import flash.display.MovieClip;
   import uk.co.kempt.IDESounds;
   
   [Embed(source="/_assets/assets.swf", symbol="unstoppable_fla.BudgetReportPageAnim_467")]
   public dynamic class BudgetReportPageAnim_467 extends MovieClip
   {
       
      
      public function BudgetReportPageAnim_467()
      {
         super();
         addFrameScript(1,this.frame2,59,this.frame60,69,this.frame70);
      }
      
      internal function frame2() : *
      {
         IDESounds.onBudgetReportPageShowing();
      }
      
      internal function frame70() : *
      {
         stop();
      }
      
      internal function frame60() : *
      {
         IDESounds.onBudgetReportPageHiding();
      }
   }
}
