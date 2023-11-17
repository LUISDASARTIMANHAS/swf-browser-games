package uk.co.kempt.display.particles
{
   import uk.co.kempt.display.PlayOnce;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.display.particles.BuildingDust")]
   public class BuildingDust extends PlayOnce
   {
       
      
      public function BuildingDust()
      {
         addFrameScript(17,this.frame18);
         super();
      }
      
      internal function frame18() : *
      {
         stop();
      }
   }
}
