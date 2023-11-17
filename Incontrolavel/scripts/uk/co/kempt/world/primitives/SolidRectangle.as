package uk.co.kempt.world.primitives
{
   import flash.display.Sprite;
   import org.cove.ape.RigidRectangle;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.world.primitives.SolidRectangle")]
   public class SolidRectangle extends Primitive
   {
       
      
      public var original:Sprite;
      
      public function SolidRectangle()
      {
         super();
      }
      
      public function get particleWidth() : Number
      {
         return this.original.width * scaleX;
      }
      
      public function getParticle() : RigidRectangle
      {
         return new RigidRectangle(x,y,this.particleWidth,this.particleHeight,rotation / 180 * Math.PI);
      }
      
      public function get particleHeight() : Number
      {
         return this.original.height * scaleY;
      }
   }
}
