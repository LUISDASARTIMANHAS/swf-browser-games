package uk.co.kempt.utils
{
   public class RangeFinder
   {
       
      
      private var _value:Number;
      
      private var _min:Number;
      
      private var _max:Number;
      
      public function RangeFinder(param1:Number = 0)
      {
         super();
         this._min = param1;
         this._max = param1;
         this._value = param1;
      }
      
      public function get value() : Number
      {
         return this._value;
      }
      
      public function get min() : Number
      {
         return this._min;
      }
      
      public function get max() : Number
      {
         return this._max;
      }
      
      public function toString() : String
      {
         return "[RangeFinder: min=" + this.min + " max=" + this.max + "]";
      }
      
      public function set value(param1:Number) : void
      {
         this._value = param1;
         this._min = Math.min(this._min,param1);
         this._max = Math.max(this._max,param1);
      }
   }
}
