package uk.co.kempt.world
{
   import uk.co.kempt.Engine;
   
   public class DangerousBuilding extends Building
   {
       
      
      private var _destroyer:WorldObject;
      
      public function DangerousBuilding()
      {
         super();
      }
      
      override public function destroy(param1:WorldObject) : void
      {
         this._destroyer = param1;
         super.destroy(param1);
      }
      
      override protected function onDying() : void
      {
         super.onDying();
         if(!Engine.instance.trainSystem.isCrashing)
         {
            Engine.instance.levelStatistics.hitDangerousBuilding = true;
         }
         Engine.instance.trainSystem.crash([this._destroyer,this]);
      }
   }
}
