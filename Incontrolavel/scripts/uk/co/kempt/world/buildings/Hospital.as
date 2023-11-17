package uk.co.kempt.world.buildings
{
   import uk.co.kempt.Engine;
   import uk.co.kempt.world.DangerousBuilding;
   
   public class Hospital extends DangerousBuilding
   {
       
      
      public function Hospital()
      {
         super();
      }
      
      override protected function onDying() : void
      {
         if(!Engine.instance.trainSystem.isCrashing)
         {
            Engine.instance.levelStatistics.hitHospital = true;
         }
         super.onDying();
      }
   }
}
