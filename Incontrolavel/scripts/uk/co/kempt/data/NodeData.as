package uk.co.kempt.data
{
   public class NodeData
   {
       
      
      private var _nodes:Array;
      
      private var _nodeDistance:Number;
      
      public function NodeData(param1:Number)
      {
         super();
         this._nodes = [];
         this._nodeDistance = param1;
      }
      
      public function add(param1:TrackNode) : void
      {
         this._nodes.push(param1);
         param1.parent = this;
      }
      
      public function getFormerByDistance(param1:Number) : TrackNode
      {
         var _loc2_:Number = Number(Math.floor(param1 / this.nodeDistance));
         return this.getNode(_loc2_);
      }
      
      public function get length() : uint
      {
         return this._nodes.length;
      }
      
      public function getFormer(param1:TrackNode) : TrackNode
      {
         var _loc2_:int = int(this._nodes.indexOf(param1));
         return _loc2_ > 0 ? this._nodes[_loc2_ - 1] : null;
      }
      
      public function getLatterByDistance(param1:Number) : TrackNode
      {
         var _loc2_:Number = Number(Math.ceil(param1 / this.nodeDistance));
         return this.getNode(_loc2_);
      }
      
      public function get nodes() : Array
      {
         return this._nodes.slice();
      }
      
      public function get nodeDistance() : Number
      {
         return this._nodeDistance;
      }
      
      public function getNode(param1:int) : TrackNode
      {
         return this._nodes[param1];
      }
      
      public function getNodeIndex(param1:TrackNode) : int
      {
         return this._nodes.indexOf(param1);
      }
      
      public function getLatter(param1:TrackNode) : TrackNode
      {
         var _loc2_:int = int(this._nodes.indexOf(param1));
         return _loc2_ > -1 && _loc2_ < this._nodes.length - 1 ? this._nodes[_loc2_ + 1] : null;
      }
   }
}
