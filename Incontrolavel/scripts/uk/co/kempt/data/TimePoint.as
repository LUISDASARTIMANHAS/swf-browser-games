package uk.co.kempt.data
{
   import flash.geom.Point;
   
   public class TimePoint extends Point
   {
       
      
      private var _time:uint;
      
      public function TimePoint(param1:Number = 0, param2:Number = 0, param3:uint = 0)
      {
         super(param1,param2);
         this._time = param3;
      }
      
      override public function clone() : Point
      {
         return new TimePoint(x,y,this.time);
      }
      
      public function set time(param1:uint) : void
      {
         this._time = param1;
      }
      
      override public function toString() : String
      {
         return "(x=" + x + ", y=" + y + ", time=" + this.time + ")";
      }
      
      public function get time() : uint
      {
         return this._time;
      }
   }
}
