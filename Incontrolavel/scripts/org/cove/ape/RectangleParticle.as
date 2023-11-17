package org.cove.ape
{
   public class RectangleParticle extends AbstractParticle
   {
       
      
      private var _axes:Array;
      
      private var _radian:Number;
      
      private var _extents:Array;
      
      public function RectangleParticle(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number = 0, param6:Boolean = false, param7:Number = 1, param8:Number = 0.3, param9:Number = 0)
      {
         super(param1,param2,param6,param7,param8,param9);
         this._extents = new Array(param3 / 2,param4 / 2);
         this._axes = new Array(new Vector2(0,0),new Vector2(0,0));
         this.radian = param5;
      }
      
      public function get radian() : Number
      {
         return this._radian;
      }
      
      public function set radian(param1:Number) : void
      {
         this._radian = param1;
         this.setAxes(param1);
      }
      
      internal function get axes() : Array
      {
         return this._axes;
      }
      
      public function set angle(param1:Number) : void
      {
         this.radian = param1 * MathUtil.PI_OVER_ONE_EIGHTY;
      }
      
      internal function get extents() : Array
      {
         return this._extents;
      }
      
      public function set width(param1:Number) : void
      {
         this._extents[0] = param1 / 2;
      }
      
      public function get width() : Number
      {
         return this._extents[0] * 2;
      }
      
      public function set height(param1:Number) : void
      {
         this._extents[1] = param1 / 2;
      }
      
      override public function init() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         cleanup();
         if(displayObject != null)
         {
            initDisplay();
         }
         else
         {
            _loc1_ = this.extents[0] * 2;
            _loc2_ = this.extents[1] * 2;
            sprite.graphics.clear();
            sprite.graphics.lineStyle(lineThickness,lineColor,lineAlpha);
            sprite.graphics.beginFill(fillColor,fillAlpha);
            sprite.graphics.drawRect(-_loc1_ / 2,-_loc2_ / 2,_loc1_,_loc2_);
            sprite.graphics.endFill();
         }
         this.paint();
      }
      
      public function get height() : Number
      {
         return this._extents[1] * 2;
      }
      
      public function get angle() : Number
      {
         return this.radian * MathUtil.ONE_EIGHTY_OVER_PI;
      }
      
      internal function getProjection(param1:Vector2) : Interval
      {
         var _loc2_:Number = this.extents[0] * Math.abs(param1.dot(this.axes[0])) + this.extents[1] * Math.abs(param1.dot(this.axes[1]));
         var _loc3_:Number = Number(samp.dot(param1));
         interval.min = _loc3_ - _loc2_;
         interval.max = _loc3_ + _loc2_;
         return interval;
      }
      
      override public function paint() : void
      {
         sprite.x = curr.x;
         sprite.y = curr.y;
         sprite.rotation = this.angle;
      }
      
      internal function setAxes(param1:Number) : void
      {
         var _loc2_:Number = Number(Math.sin(param1));
         var _loc3_:Number = Number(Math.cos(param1));
         this.axes[0].x = _loc3_;
         this.axes[0].y = _loc2_;
         this.axes[1].x = -_loc2_;
         this.axes[1].y = _loc3_;
      }
   }
}
