package uk.co.kempt.display.particles
{
   import uk.co.kempt.display.PlayOnceThenStore;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.display.particles.AngledFloorDamage")]
   public class AngledFloorDamage extends PlayOnceThenStore
   {
       
      
      public function AngledFloorDamage()
      {
         addFrameScript(7,this.frame8);
         super();
      }
      
      internal function frame8() : *
      {
         stop();
      }
   }
}
