package uk.co.kempt.display.particles
{
   import flash.display.MovieClip;
   import uk.co.kempt.display.PlayOnceThenStore;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.display.particles.NukeDust")]
   public class NukeDust extends PlayOnceThenStore
   {
       
      
      public var inner:MovieClip;
      
      public function NukeDust()
      {
         super();
      }
   }
}
