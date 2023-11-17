package uk.co.kempt.world.primitives
{
   import flash.display.Sprite;
   import org.cove.ape.RigidCircle;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.world.primitives.SolidCircle")]
   public class SolidCircle extends Primitive
   {
       
      
      public var original:Sprite;
      
      public function SolidCircle()
      {
         super();
      }
      
      public function get particleRadius() : Number
      {
         return this.original.width / 2 * scaleX;
      }
      
      public function getParticle() : RigidCircle
      {
         return new RigidCircle(x,y,this.particleRadius);
      }
   }
}
