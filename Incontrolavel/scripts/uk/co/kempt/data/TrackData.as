package uk.co.kempt.data
{
   public class TrackData
   {
       
      
      private var _points:Array;
      
      public function TrackData()
      {
         super();
         this._points = [];
      }
      
      public function add(param1:TimePoint) : void
      {
         this._points.push(param1.clone());
      }
      
      public function get points() : Array
      {
         return this._points.slice();
      }
      
      public function get endPoint() : TimePoint
      {
         return this.getPoint(this._points.length - 1);
      }
      
      public function get length() : uint
      {
         return this._points.length;
      }
      
      public function removePoints(param1:uint, param2:uint) : Array
      {
         return this._points.splice(param1,param2 - param1 + 1);
      }
      
      public function getPoint(param1:uint) : TimePoint
      {
         return !!this._points[param1] ? TimePoint(this._points[param1]).clone() as TimePoint : null;
      }
      
      public function appendPoints(param1:Array) : void
      {
         this._points = this._points.concat(param1);
      }
      
      public function get startPoint() : TimePoint
      {
         return this.getPoint(0);
      }
   }
}
