package org.cove.ape
{
   public class RigidCircle extends RigidItem
   {
       
      
      private var _radius:*;
      
      public function RigidCircle(param1:Number, param2:Number, param3:Number, param4:Boolean = false, param5:Number = -1, param6:Number = 0.3, param7:Number = 0.2, param8:Number = 0, param9:Number = 0)
      {
         this._radius = param3;
         if(param5 == -1)
         {
            param5 = Math.PI * param3 * param3;
         }
         super(param1,param2,param3,param4,param5,param5 * param3 * param3 / 2,param6,param7,param8,param9);
         maxRadius = param3;
      }
      
      internal function getIntervalX() : Interval
      {
         interval.min = samp.x - this._radius;
         interval.max = samp.x + this._radius;
         return interval;
      }
      
      internal function getProjection(param1:Vector2) : Interval
      {
         var _loc2_:Number = Number(samp.dot(param1));
         interval.min = _loc2_ - this._radius;
         interval.max = _loc2_ + this._radius;
         return interval;
      }
      
      public function get radius() : Number
      {
         return this._radius;
      }
      
      override public function drawShape(param1:*) : *
      {
         param1.clear();
         param1.lineStyle(lineThickness,lineColor,lineAlpha);
         param1.beginFill(fillColor,fillAlpha);
         param1.drawCircle(0,0,this.radius);
         param1.moveTo(this.radius,0);
         param1.lineTo(-this.radius,0);
         param1.moveTo(0,this.radius);
         param1.lineTo(0,-this.radius);
         param1.endFill();
      }
      
      internal function getIntervalY() : Interval
      {
         interval.min = samp.y - this._radius;
         interval.max = samp.y + this._radius;
         return interval;
      }
      
      public function getVertices(param1:Array) : Array
      {
         var _loc2_:* = new Array();
         var _loc3_:* = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_.push(param1[_loc3_].mult(this.radius).plusEquals(samp));
            _loc3_++;
         }
         return _loc2_;
      }
   }
}
