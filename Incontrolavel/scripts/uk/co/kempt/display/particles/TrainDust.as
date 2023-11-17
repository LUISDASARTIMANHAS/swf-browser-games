package uk.co.kempt.display.particles
{
   import uk.co.kempt.display.PlayOnce;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.display.particles.TrainDust")]
   public class TrainDust extends PlayOnce
   {
       
      
      public function TrainDust()
      {
         addFrameScript(22,this.frame23);
         super();
      }
      
      internal function frame23() : *
      {
         stop();
      }
   }
}
