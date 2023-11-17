package unstoppable_fla
{
   import flash.display.MovieClip;
   import uk.co.kempt.IDESounds;
   
   [Embed(source="/_assets/assets.swf", symbol="unstoppable_fla.DamageReportPageAnim_464")]
   public dynamic class DamageReportPageAnim_464 extends MovieClip
   {
       
      
      public function DamageReportPageAnim_464()
      {
         super();
         addFrameScript(1,this.frame2,86,this.frame87);
      }
      
      internal function frame87() : *
      {
         stop();
      }
      
      internal function frame2() : *
      {
         IDESounds.onDamageReportPageShowing();
      }
   }
}
