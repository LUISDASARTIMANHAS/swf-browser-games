package uk.co.kempt.world.smashables
{
   import uk.co.kempt.Engine;
   import uk.co.kempt.sounds.UnstoppableSounds;
   
   public class SmashableTrees extends StaticSmashable
   {
       
      
      public function SmashableTrees()
      {
         super();
      }
      
      override protected function onDying() : void
      {
         super.onDying();
         Engine.instance.soundMan.playSound(UnstoppableSounds.TREE);
      }
   }
}
