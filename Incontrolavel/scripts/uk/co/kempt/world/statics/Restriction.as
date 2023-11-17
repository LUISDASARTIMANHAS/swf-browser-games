package uk.co.kempt.world.statics
{
   import org.cove.ape.AbstractParticle;
   import uk.co.kempt.Engine;
   import uk.co.kempt.data.Lookup;
   
   public class Restriction extends StaticObject
   {
      
      private static const FRICTION:Number = 0.4;
       
      
      public function Restriction()
      {
         super();
         friction = FRICTION;
      }
      
      override public function get hasDebris() : Boolean
      {
         return false;
      }
      
      override protected function addParticle(param1:AbstractParticle) : void
      {
         param1.fixed = true;
         param1.solid = false;
         translateParticle(param1);
         Engine.instance.addParticle(param1);
         Lookup.register(param1,this);
      }
   }
}
