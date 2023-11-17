package uk.co.kempt.display
{
   import uk.co.kempt.Engine;
   import uk.co.kempt.sounds.UnstoppableSounds;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.display.RingOfDeath")]
   public class RingOfDeath extends PlayOnce
   {
       
      
      public function RingOfDeath()
      {
         super();
         addFrameScript(1,this.frame2);
      }
      
      internal function frame2() : *
      {
         this.onRingShowing();
      }
      
      public function onRingShowing() : void
      {
         Engine.instance.soundMan.playSound(UnstoppableSounds.RING_OF_DEATH);
      }
   }
}
