package uk.co.kempt.world.primitives
{
   import flash.display.Sprite;
   import uk.co.kempt.utils.GarbageUtil;
   
   public class Primitive extends Sprite
   {
       
      
      public function Primitive()
      {
         super();
      }
      
      public function cleanup() : void
      {
         GarbageUtil.kill(this);
      }
   }
}
