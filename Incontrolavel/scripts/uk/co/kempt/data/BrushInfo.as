package uk.co.kempt.data
{
   import uk.co.kempt.display.BrushSprite;
   
   public class BrushInfo
   {
       
      
      private var _y:Number;
      
      private var _x:Number;
      
      private var _rotation:Number;
      
      public function BrushInfo(param1:BrushSprite = null)
      {
         super();
         if(param1)
         {
            this.x = param1.x;
            this.y = param1.y;
            this.rotation = param1.rotation;
         }
      }
      
      public function get y() : Number
      {
         return this._y;
      }
      
      public function set y(param1:Number) : void
      {
         this._y = param1;
      }
      
      public function apply(param1:BrushSprite) : void
      {
         param1.x = this.x;
         param1.y = this.y;
         param1.rotation = this.rotation;
      }
      
      public function set x(param1:Number) : void
      {
         this._x = param1;
      }
      
      public function get x() : Number
      {
         return this._x;
      }
      
      public function set rotation(param1:Number) : void
      {
         this._rotation = param1;
      }
      
      public function get rotation() : Number
      {
         return this._rotation;
      }
   }
}
