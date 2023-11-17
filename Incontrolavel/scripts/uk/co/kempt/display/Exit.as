package uk.co.kempt.display
{
   import flash.display.Sprite;
   import flash.geom.Point;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.display.Exit")]
   public class Exit extends Sprite
   {
       
      
      private var _radius:Number;
      
      private var _radiusSquared:Number;
      
      public function Exit()
      {
         super();
         this._radius = width / 2;
         this._radiusSquared = this._radius * this._radius;
      }
      
      public function get position() : Point
      {
         return new Point(x,y);
      }
      
      public function get radiusSquared() : Number
      {
         return this._radiusSquared;
      }
      
      public function get radius() : Number
      {
         return this._radius;
      }
   }
}
