package uk.co.kempt.display
{
   import flash.display.Sprite;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.display.TimeBar")]
   public class TimeBar extends Sprite
   {
       
      
      private var _total:int;
      
      private var _targetX:Number;
      
      private var _value:int;
      
      public var bar:Sprite;
      
      public function TimeBar()
      {
         super();
         this._targetX = this.bar.x;
      }
      
      public function set value(param1:int) : void
      {
         this._value = param1;
         this.doPosition();
      }
      
      public function update(param1:Number = 1) : void
      {
         this.value = Math.max(0,this.value - 1 * param1);
      }
      
      public function get total() : int
      {
         return this._total;
      }
      
      public function reset(param1:int) : void
      {
         this._value = param1;
         this._total = param1;
         this.doPosition(true);
      }
      
      public function get value() : int
      {
         return this._value;
      }
      
      private function doPosition(param1:Boolean = false) : void
      {
         var _loc2_:Number = this._targetX * (1 - this._value / this._total);
         this.bar.x += (_loc2_ - this.bar.x) / 1.8;
         if(param1)
         {
            this.bar.x = _loc2_;
         }
      }
   }
}
