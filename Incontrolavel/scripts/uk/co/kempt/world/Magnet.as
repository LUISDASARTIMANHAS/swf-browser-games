package uk.co.kempt.world
{
   import flash.geom.Point;
   import uk.co.kempt.Engine;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.world.Magnet")]
   public class Magnet extends WorldObject
   {
       
      
      private var _radius:Number;
      
      public function Magnet()
      {
         super();
         this._radius = (width + height) / 2 / 2 + 10;
         visible = false;
      }
      
      override public function update() : void
      {
         var _loc1_:Number = Engine.instance.brush.x - x;
         var _loc2_:Number = Engine.instance.brush.y - y;
         var _loc3_:Number = Number(Math.atan2(_loc2_,_loc1_));
         var _loc4_:Number = Number(Math.sqrt(Math.pow(_loc1_,2) + Math.pow(_loc2_,2)));
         var _loc5_:Number = 1 - Math.min(1,_loc4_ / this._radius);
         var _loc6_:Number = Number(Math.pow(1 + _loc5_ * 4,1.2));
         if(_loc5_ > 0)
         {
            Engine.instance.brush.push(new Point(_loc6_ * Math.cos(_loc3_),_loc6_ * Math.sin(_loc3_)));
         }
      }
   }
}
