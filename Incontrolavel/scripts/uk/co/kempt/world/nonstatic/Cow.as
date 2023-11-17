package uk.co.kempt.world.nonstatic
{
   import flash.filters.DropShadowFilter;
   import uk.co.kempt.utils.MathUtil;
   import uk.co.kempt.world.Person;
   
   public class Cow extends Person
   {
       
      
      public function Cow()
      {
         super();
         var _loc1_:Number = 1;
         filters = [new DropShadowFilter(1,90,0,1,_loc1_,_loc1_)];
      }
      
      override public function update() : void
      {
         super.update();
         if(!isNaN(runningAngle))
         {
            rotation += MathUtil.radianDiff(rotation / 180 * Math.PI,runningAngle) / Math.PI * 180 / 4;
         }
      }
      
      override protected function triggerSound() : void
      {
      }
   }
}
