package uk.co.kempt.world.smashables
{
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.world.smashables.TrainSmashable")]
   public class TrainSmashable extends Vehicle
   {
       
      
      public function TrainSmashable()
      {
         super();
      }
      
      override public function update() : void
      {
         if(_burnCount > 0)
         {
            _burnCount = 10;
         }
         super.update();
      }
      
      override public function get cost() : int
      {
         return 0;
      }
   }
}
