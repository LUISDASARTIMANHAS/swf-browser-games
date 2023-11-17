package uk.co.kempt.world.primitives
{
   import flash.display.Sprite;
   import org.cove.ape.RigidRectangle;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.world.primitives.RigidSolidRectangle")]
   public class RigidSolidRectangle extends Primitive
   {
       
      
      public var original:Sprite;
      
      public function RigidSolidRectangle()
      {
         super();
      }
      
      public function getParticle() : RigidRectangle
      {
         var _loc1_:Number = this.original.width * scaleX;
         var _loc2_:Number = this.original.height * scaleY;
         return new RigidRectangle(x,y,_loc1_,_loc2_,rotation / 180 * Math.PI);
      }
   }
}
