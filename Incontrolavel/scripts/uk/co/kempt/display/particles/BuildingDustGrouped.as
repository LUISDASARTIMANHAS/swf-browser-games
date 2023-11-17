package uk.co.kempt.display.particles
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.display.particles.BuildingDustGrouped")]
   public class BuildingDustGrouped extends MovieClip
   {
       
      
      public function BuildingDustGrouped()
      {
         addFrameScript(15,this.frame16);
         super();
      }
      
      internal function frame16() : *
      {
         stop();
      }
   }
}
