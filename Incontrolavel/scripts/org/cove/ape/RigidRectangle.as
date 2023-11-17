package org.cove.ape
{
   public class RigidRectangle extends RigidItem
   {
       
      
      private var _axes:Array;
      
      private var _extents:Array;
      
      private var _normals:Array;
      
      private var _marginCenters:Array;
      
      private var _vertices:Array;
      
      public function RigidRectangle(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number = 0, param6:Boolean = false, param7:Number = -1, param8:Number = 0.3, param9:Number = 0.2, param10:Number = 0)
      {
         if(param7 == -1)
         {
            param7 = param3 * param4;
         }
         super(param1,param2,Math.sqrt(param3 * param3 / 4 + param4 * param4 / 4),param6,param7,param7 * (param3 * param3 + param4 * param4) / 12,param8,param9,param5,param10);
         this._extents = new Array(param3 / 2,param4 / 2);
         this._axes = new Array(new Vector2(0,0),new Vector2(0,0));
         this._normals = new Array();
         this._marginCenters = new Array();
         this._vertices = new Array();
         var _loc11_:* = 0;
         while(_loc11_ < 4)
         {
            this._normals.push(new Vector2(0,0));
            this._marginCenters.push(new Vector2(0,0));
            this._vertices.push(new Vector2(0,0));
            _loc11_++;
         }
         maxRadius = Math.max(param3,param4) / 2;
      }
      
      public function get axes() : Array
      {
         return this._axes;
      }
      
      override public function setAxes(param1:Number) : void
      {
         var _loc2_:Number = Number(Math.sin(param1));
         var _loc3_:Number = Number(Math.cos(param1));
         this.axes[0].x = _loc3_;
         this.axes[0].y = _loc2_;
         this.axes[1].x = -_loc2_;
         this.axes[1].y = _loc3_;
         this._normals[0].copy(this.axes[0]);
         this._normals[1].copy(this.axes[1]);
         this._normals[2] = this.axes[0].mult(-1);
         this._normals[3] = this.axes[1].mult(-1);
         this._marginCenters[0] = this.axes[0].mult(this.extents[0]);
         this._marginCenters[1] = this.axes[1].mult(this.extents[1]);
         this._marginCenters[2] = this.axes[0].mult(-this.extents[0]);
         this._marginCenters[3] = this.axes[1].mult(-this.extents[1]);
         this._vertices[0] = this._marginCenters[0].plus(this._marginCenters[1]);
         this._vertices[1] = this._marginCenters[1].plus(this._marginCenters[2]);
         this._vertices[2] = this._marginCenters[2].plus(this._marginCenters[3]);
         this._vertices[3] = this._marginCenters[3].plus(this._marginCenters[0]);
      }
      
      public function get extents() : Array
      {
         return this._extents;
      }
      
      internal function getProjection(param1:Vector2) : Interval
      {
         var _loc2_:Number = this.extents[0] * Math.abs(param1.dot(this.axes[0])) + this.extents[1] * Math.abs(param1.dot(this.axes[1]));
         var _loc3_:Number = Number(samp.dot(param1));
         interval.min = _loc3_ - _loc2_;
         interval.max = _loc3_ + _loc2_;
         return interval;
      }
      
      public function getVertices() : Array
      {
         var _loc1_:* = new Array();
         var _loc2_:* = 0;
         while(_loc2_ < this._vertices.length)
         {
            _loc1_.push(this._vertices[_loc2_].plus(samp));
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getMarginCenters() : Array
      {
         return this._marginCenters;
      }
      
      public function getNormals() : Array
      {
         return this._normals;
      }
      
      override public function captures(param1:Vector2) : Boolean
      {
         var _loc3_:* = undefined;
         var _loc2_:* = 0;
         while(_loc2_ < this._marginCenters.length)
         {
            _loc3_ = param1.minus(this._marginCenters[_loc2_].plus(samp)).dot(this._normals[_loc2_]);
            if(_loc3_ > 0.01)
            {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
      
      override public function drawShape(param1:*) : *
      {
         var _loc2_:Number = this.extents[0] * 2;
         var _loc3_:Number = this.extents[1] * 2;
         sprite.graphics.clear();
         sprite.graphics.lineStyle(lineThickness,lineColor,lineAlpha);
         sprite.graphics.beginFill(fillColor,fillAlpha);
         sprite.graphics.drawRect(-_loc2_ / 2,-_loc3_ / 2,_loc2_,_loc3_);
         sprite.graphics.endFill();
      }
   }
}
