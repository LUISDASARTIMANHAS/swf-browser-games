package uk.co.kempt.world.statics
{
   import org.cove.ape.AbstractParticle;
   import uk.co.kempt.Engine;
   import uk.co.kempt.data.Lookup;
   import uk.co.kempt.utils.GarbageUtil;
   import uk.co.kempt.world.WorldObject;
   
   public class StaticObject extends WorldObject
   {
       
      
      public function StaticObject()
      {
         super();
      }
      
      override public function get ignoreBrush() : Boolean
      {
         return false;
      }
      
      override protected function addParticle(param1:AbstractParticle) : void
      {
         param1.fixed = true;
         param1.solid = true;
         translateParticle(param1);
         Engine.instance.addParticle(param1);
         Lookup.register(param1,this);
      }
      
      override protected function get defaultCost() : int
      {
         return 0;
      }
      
      override public function die() : void
      {
         GarbageUtil.kill(this);
      }
   }
}
