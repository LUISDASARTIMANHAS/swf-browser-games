package uk.co.kempt.display
{
   import uk.co.kempt.Engine;
   import uk.co.kempt.state.GameState;
   
   public class PlayOnceThenStore extends PlayOnce
   {
       
      
      public function PlayOnceThenStore()
      {
         super();
      }
      
      override protected function onLastFrame() : void
      {
         switch(Engine.instance.state)
         {
            case GameState.DRAWING:
            case GameState.SIMULATION:
               Engine.instance.animateScreen.draw(this);
         }
         super.onLastFrame();
      }
   }
}
