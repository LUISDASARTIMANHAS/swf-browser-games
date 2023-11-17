package org.cove.ape
{
   public class CircleParticle extends AbstractParticle
   {
       
      
      private var _radius:Number;
      
      public function CircleParticle(param1:Number, param2:Number, param3:Number, param4:Boolean = false, param5:Number = 1, param6:Number = 0.3, param7:Number = 0)
      {
         super(param1,param2,param4,param5,param6,param7);
         this._radius = param3;
      }
      
      override public function init() : void
      {
         cleanup();
         if(displayObject != null)
         {
            initDisplay();
         }
         else
         {
            sprite.graphics.clear();
            sprite.graphics.lineStyle(lineThickness,lineColor,lineAlpha);
            sprite.graphics.beginFill(fillColor,fillAlpha);
            sprite.graphics.drawCircle(0,0,this.radius);
            sprite.graphics.endFill();
         }
         this.paint();
      }
      
      public function set radius(param1:Number) : void
      {
         this._radius = param1;
      }
      
      internal function getProjection(param1:Vector2) : Interval
      {
         var _loc2_:Number = Number(samp.dot(param1));
         interval.min = _loc2_ - this._radius;
         interval.max = _loc2_ + this._radius;
         return interval;
      }
      
      internal function getIntervalY() : Interval
      {
         interval.min = samp.y - this._radius;
         interval.max = samp.y + this._radius;
         return interval;
      }
      
      public function get radius() : Number
      {
         return this._radius;
      }
      
      internal function getIntervalX() : Interval
      {
         interval.min = samp.x - this._radius;
         interval.max = samp.x + this._radius;
         return interval;
      }
      
      override public function paint() : void
      {
         sprite.x = curr.x;
         sprite.y = curr.y;
      }
   }
}
