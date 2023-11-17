package uk.co.kempt.world.smashables
{
   import flash.filters.DropShadowFilter;
   import org.cove.ape.AbstractParticle;
   
   public class StaticSmashable extends Smashable
   {
       
      
      public function StaticSmashable()
      {
         super();
         var _loc1_:Number = 5;
         filters = [new DropShadowFilter(2,45,0,0.56,_loc1_,_loc1_,1)];
      }
      
      override public function update() : void
      {
      }
      
      override public function get updateable() : Boolean
      {
         return false;
      }
      
      override protected function addParticle(param1:AbstractParticle) : void
      {
         super.addParticle(param1);
         param1.solid = false;
         param1.fixed = true;
      }
   }
}
