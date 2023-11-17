package uk.co.kempt.world.nonstatic
{
   import flash.display.Sprite;
   import flash.geom.Point;
   import uk.co.kempt.system.TrackBuilder;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.world.nonstatic.Workman")]
   public class Workman extends Sprite
   {
      
      private static const SPEED:Number = TrackBuilder.TOP_SPEED + 2;
       
      
      private var _destination:Point;
      
      public function Workman()
      {
         super();
         this._destination = new Point();
      }
      
      public function update() : void
      {
         var _loc1_:Point = new Point(this.destination.x - x,this.destination.y - y);
         var _loc2_:Number = Number(Math.atan2(_loc1_.y,_loc1_.x));
         var _loc3_:Number = Number(Math.sqrt(Math.pow(_loc1_.x,2) + Math.pow(_loc1_.y,2)));
         var _loc4_:Number = Number(Math.min(_loc3_,SPEED));
         x += Math.cos(_loc2_) * _loc4_;
         y += Math.sin(_loc2_) * _loc4_;
      }
      
      public function set destination(param1:Point) : void
      {
         this._destination = param1;
      }
      
      public function get destination() : Point
      {
         return this._destination;
      }
   }
}
