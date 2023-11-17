package uk.co.kempt.data
{
   import flash.geom.Point;
   import uk.co.kempt.utils.MathUtil;
   
   public class TrackNode
   {
       
      
      private var _x:Number;
      
      private var _parent:NodeData;
      
      private var _angle:Number = NaN;
      
      private var _y:Number;
      
      public function TrackNode(param1:Number = 0, param2:Number = 0)
      {
         super();
         this.x = param1;
         this.y = param2;
         this._angle = NaN;
      }
      
      public function set y(param1:Number) : void
      {
         this._y = param1;
      }
      
      public function get cachedAngle() : Number
      {
         return this._angle;
      }
      
      public function get angle() : Number
      {
         var _loc1_:TrackNode = this.former;
         var _loc2_:TrackNode = this.latter;
         if(Boolean(_loc1_) && Boolean(_loc2_))
         {
            this._angle = MathUtil.radianThreePointAverage(_loc1_.position,this.position,_loc2_.position);
         }
         else if(_loc1_)
         {
            this._angle = MathUtil.radianAngle(_loc1_.position,this.position);
         }
         else
         {
            if(!_loc2_)
            {
               return 0;
            }
            this._angle = MathUtil.radianAngle(this.position,_loc2_.position);
         }
         return this._angle;
      }
      
      public function set parent(param1:NodeData) : void
      {
         this._parent = param1;
      }
      
      public function get index() : int
      {
         return !!this.parent ? this.parent.getNodeIndex(this) : -1;
      }
      
      public function get isLast() : Boolean
      {
         return !!this.latter ? false : true;
      }
      
      public function get distanceToFormer() : Number
      {
         return !!this.former ? MathUtil.distance(this.position,this.former.position) : Number(NaN);
      }
      
      public function get latter() : TrackNode
      {
         return !!this.parent ? this.parent.getLatter(this) : null;
      }
      
      public function set angle(param1:Number) : void
      {
         this._angle = param1;
      }
      
      public function get position() : Point
      {
         return new Point(this.x,this.y);
      }
      
      public function get parent() : NodeData
      {
         return this._parent;
      }
      
      public function set x(param1:Number) : void
      {
         this._x = param1;
      }
      
      public function get former() : TrackNode
      {
         return !!this.parent ? this.parent.getFormer(this) : null;
      }
      
      public function get x() : Number
      {
         return this._x;
      }
      
      public function get y() : Number
      {
         return this._y;
      }
      
      public function get distanceToLatter() : Number
      {
         return !!this.latter ? MathUtil.distance(this.position,this.latter.position) : Number(NaN);
      }
   }
}
