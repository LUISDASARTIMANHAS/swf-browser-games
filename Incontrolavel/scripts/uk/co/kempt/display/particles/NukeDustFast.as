package uk.co.kempt.display.particles
{
   import flash.display.MovieClip;
   import uk.co.kempt.display.PlayOnceThenStore;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.display.particles.NukeDustFast")]
   public class NukeDustFast extends PlayOnceThenStore
   {
       
      
      public var inner:MovieClip;
      
      public function NukeDustFast()
      {
         super();
      }
   }
}
