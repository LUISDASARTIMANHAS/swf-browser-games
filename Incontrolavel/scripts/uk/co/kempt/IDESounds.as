package uk.co.kempt
{
   import uk.co.kempt.sounds.UnstoppableSounds;
   
   public class IDESounds
   {
       
      
      public function IDESounds()
      {
         super();
      }
      
      public static function onBarsAnimateOut() : void
      {
         Engine.instance.soundMan.playSound(UnstoppableSounds.STATIC_BURST);
      }
      
      public static function onDamageReportPageShowing() : void
      {
         Engine.instance.soundMan.playSound(UnstoppableSounds.EFFECT_03);
      }
      
      public static function onBudgetReportPageShowing() : void
      {
         Engine.instance.soundMan.playSound(UnstoppableSounds.EFFECT_03);
      }
      
      public static function onBudgetReportPageHiding() : void
      {
         Engine.instance.soundMan.playSound(UnstoppableSounds.EFFECT_06);
      }
      
      public static function onBarsAnimateIn() : void
      {
         Engine.instance.soundMan.playSound(UnstoppableSounds.STATIC_BURST);
      }
   }
}
