package uk.co.kempt
{
   import flash.display.BitmapData;
   import flash.display.CapsStyle;
   import flash.display.Graphics;
   import flash.display.LineScaleMode;
   import flash.display.Sprite;
   import flash.geom.Point;
   import uk.co.kempt.data.NodeData;
   import uk.co.kempt.data.TrackData;
   import uk.co.kempt.data.TrackNode;
   import uk.co.kempt.display.drawing.BridgeEdgeSprite;
   import uk.co.kempt.display.drawing.RailSprite;
   import uk.co.kempt.display.drawing.TrackSleeperSprite;
   import uk.co.kempt.utils.MathUtil;
   
   public class DrawingEngine
   {
      
      private static const SLEEPER_LENGTH:Number = 10;
      
      private static const COLOR_RAIL_LOW:uint = 0;
      
      private static const COLOR_SLEEPER:uint = 6572853;
      
      private static const NODE_INTERVAL:int = 3;
      
      private static const RAIL_THICKNESS_LAYER_1:Number = 1;
      
      private static const BRIDGE_EDGE_DISTANCE_FROM_CENTER:Number = 6;
      
      private static const RAIL_DISTANCE_FROM_CENTER:Number = 1.8;
      
      private static const COLOR_RAIL:uint = 10066329;
      
      private static const RAIL_THICKNESS_LAYER_2:Number = 0.5;
      
      private static const SLEEPER_THICKNESS:Number = 2;
       
      
      private var _distToNode:Number = 3;
      
      private var _trackData:TrackData;
      
      private var _nodeData:NodeData;
      
      private var _currentIndex:int;
      
      private var _distToNextPoint:Number;
      
      public function DrawingEngine()
      {
         super();
         this._trackData = new TrackData();
         this._nodeData = new NodeData(NODE_INTERVAL);
         this._currentIndex = 0;
         this._distToNode = NODE_INTERVAL;
         this._distToNextPoint = NaN;
      }
      
      public function die() : void
      {
         this._trackData = null;
         this._nodeData = null;
      }
      
      public function drawSleeper(param1:BitmapData, param2:TrackNode) : void
      {
         var _loc3_:Sprite = new TrackSleeperSprite();
         _loc3_.rotation = (param2.angle + Math.PI / 2) / Math.PI * 180;
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         param1.draw(_loc3_,_loc3_.transform.matrix);
      }
      
      public function update() : void
      {
         this.compute();
      }
      
      public function drawBridge(param1:BitmapData, param2:TrackNode) : void
      {
         var _loc11_:Point = null;
         var _loc12_:Point = null;
         var _loc16_:Number = NaN;
         var _loc3_:BridgeEdgeSprite = new BridgeEdgeSprite();
         var _loc4_:TrackNode;
         if(!(_loc4_ = param2.former))
         {
            return;
         }
         var _loc5_:Number = param2.angle;
         var _loc6_:Number;
         var _loc7_:Number = (_loc6_ = _loc4_.angle) - Math.PI / 2;
         var _loc8_:Number = _loc6_ + Math.PI / 2;
         var _loc9_:Number = _loc5_ - Math.PI / 2;
         var _loc10_:Number = _loc5_ + Math.PI / 2;
         _loc11_ = _loc4_.position.add(new Point(BRIDGE_EDGE_DISTANCE_FROM_CENTER * Math.cos(_loc7_),BRIDGE_EDGE_DISTANCE_FROM_CENTER * Math.sin(_loc7_)));
         _loc12_ = _loc4_.position.add(new Point(BRIDGE_EDGE_DISTANCE_FROM_CENTER * Math.cos(_loc8_),BRIDGE_EDGE_DISTANCE_FROM_CENTER * Math.sin(_loc8_)));
         var _loc13_:Point = param2.position.add(new Point(BRIDGE_EDGE_DISTANCE_FROM_CENTER * Math.cos(_loc9_),BRIDGE_EDGE_DISTANCE_FROM_CENTER * Math.sin(_loc9_)));
         var _loc14_:Point = param2.position.add(new Point(BRIDGE_EDGE_DISTANCE_FROM_CENTER * Math.cos(_loc10_),BRIDGE_EDGE_DISTANCE_FROM_CENTER * Math.sin(_loc10_)));
         var _loc15_:Number = Number(Math.sqrt(Math.pow(_loc13_.x - _loc11_.x,2) + Math.pow(_loc13_.y - _loc11_.y,2)));
         _loc16_ = Number(Math.sqrt(Math.pow(_loc14_.x - _loc12_.x,2) + Math.pow(_loc14_.y - _loc12_.y,2)));
         var _loc17_:Number = MathUtil.radianAngle(_loc4_.position,param2.position);
         _loc3_.rotation = 0;
         _loc3_.width = _loc15_;
         _loc3_.x = _loc11_.x;
         _loc3_.y = _loc11_.y;
         _loc3_.rotation = _loc17_ / Math.PI * 180;
         param1.draw(_loc3_,_loc3_.transform.matrix);
         _loc3_.rotation = 0;
         _loc3_.width = _loc16_;
         _loc3_.x = _loc12_.x;
         _loc3_.y = _loc12_.y;
         _loc3_.rotation = _loc17_ / Math.PI * 180;
         param1.draw(_loc3_,_loc3_.transform.matrix);
      }
      
      public function drawRail(param1:BitmapData, param2:TrackNode) : void
      {
         var _loc3_:RailSprite = new RailSprite();
         var _loc4_:TrackNode;
         if(!(_loc4_ = param2.former))
         {
            return;
         }
         var _loc5_:Number = param2.angle;
         var _loc6_:Number;
         var _loc7_:Number = (_loc6_ = _loc4_.angle) - Math.PI / 2;
         var _loc8_:Number = _loc6_ + Math.PI / 2;
         var _loc9_:Number = _loc5_ - Math.PI / 2;
         var _loc10_:Number = _loc5_ + Math.PI / 2;
         var _loc11_:Point = _loc4_.position.add(new Point(RAIL_DISTANCE_FROM_CENTER * Math.cos(_loc7_),RAIL_DISTANCE_FROM_CENTER * Math.sin(_loc7_)));
         var _loc12_:Point = _loc4_.position.add(new Point(RAIL_DISTANCE_FROM_CENTER * Math.cos(_loc8_),RAIL_DISTANCE_FROM_CENTER * Math.sin(_loc8_)));
         var _loc13_:Point = param2.position.add(new Point(RAIL_DISTANCE_FROM_CENTER * Math.cos(_loc9_),RAIL_DISTANCE_FROM_CENTER * Math.sin(_loc9_)));
         var _loc14_:Point = param2.position.add(new Point(RAIL_DISTANCE_FROM_CENTER * Math.cos(_loc10_),RAIL_DISTANCE_FROM_CENTER * Math.sin(_loc10_)));
         var _loc15_:Number = Number(Math.sqrt(Math.pow(_loc13_.x - _loc11_.x,2) + Math.pow(_loc13_.y - _loc11_.y,2)));
         var _loc16_:Number = Number(Math.sqrt(Math.pow(_loc14_.x - _loc12_.x,2) + Math.pow(_loc14_.y - _loc12_.y,2)));
         var _loc17_:Number = MathUtil.radianAngle(_loc4_.position,param2.position);
         _loc3_.rotation = 0;
         _loc3_.width = _loc15_;
         _loc3_.x = _loc11_.x;
         _loc3_.y = _loc11_.y;
         _loc3_.rotation = _loc17_ / Math.PI * 180;
         param1.draw(_loc3_,_loc3_.transform.matrix);
         _loc3_.rotation = 0;
         _loc3_.width = _loc16_;
         _loc3_.x = _loc12_.x;
         _loc3_.y = _loc12_.y;
         _loc3_.rotation = _loc17_ / Math.PI * 180;
         param1.draw(_loc3_,_loc3_.transform.matrix);
      }
      
      public function get trackData() : TrackData
      {
         return this._trackData;
      }
      
      private function compute() : void
      {
         if(this._currentIndex > this.trackData.length - 2)
         {
            return;
         }
         var _loc1_:Point = this.trackData.getPoint(this._currentIndex);
         var _loc2_:Point = this.trackData.getPoint(this._currentIndex + 1);
         var _loc3_:Number = MathUtil.radianAngle(_loc1_,_loc2_);
         if(isNaN(this._distToNextPoint))
         {
            this._distToNextPoint = MathUtil.distance(_loc1_,_loc2_);
         }
         if(this._nodeData.length <= 0)
         {
            this._nodeData.add(new TrackNode(_loc1_.x,_loc1_.y));
         }
         var _loc4_:int = this._currentIndex;
         while(_loc4_ < this.trackData.length - 2)
         {
            while(this._distToNode < this._distToNextPoint)
            {
               _loc1_ = _loc1_.add(new Point(this._distToNode * Math.cos(_loc3_),this._distToNode * Math.sin(_loc3_)));
               this._nodeData.add(new TrackNode(_loc1_.x,_loc1_.y));
               this._distToNextPoint -= this._distToNode;
               this._distToNode = NODE_INTERVAL;
            }
            if(this._currentIndex >= this.trackData.length - 2)
            {
               return;
            }
            ++this._currentIndex;
            this._distToNode -= this._distToNextPoint;
            _loc1_ = this.trackData.getPoint(this._currentIndex);
            _loc2_ = this.trackData.getPoint(this._currentIndex + 1);
            this._distToNextPoint = MathUtil.distance(_loc1_,_loc2_);
            _loc3_ = MathUtil.radianAngle(_loc1_,_loc2_);
            _loc4_++;
         }
      }
      
      public function get nodeData() : NodeData
      {
         return this._nodeData;
      }
      
      public function drawRail2(param1:Graphics, param2:Graphics, param3:TrackNode) : void
      {
         var _loc4_:TrackNode;
         if(!(_loc4_ = param3.former))
         {
            return;
         }
         var _loc5_:Number = param3.angle;
         var _loc6_:Number;
         var _loc7_:Number = (_loc6_ = _loc4_.angle) - Math.PI / 2;
         var _loc8_:Number = _loc6_ + Math.PI / 2;
         var _loc9_:Number = _loc5_ - Math.PI / 2;
         var _loc10_:Number = _loc5_ + Math.PI / 2;
         var _loc11_:Point = _loc4_.position.add(new Point(RAIL_DISTANCE_FROM_CENTER * Math.cos(_loc7_),RAIL_DISTANCE_FROM_CENTER * Math.sin(_loc7_)));
         var _loc12_:Point = _loc4_.position.add(new Point(RAIL_DISTANCE_FROM_CENTER * Math.cos(_loc8_),RAIL_DISTANCE_FROM_CENTER * Math.sin(_loc8_)));
         var _loc13_:Point = param3.position.add(new Point(RAIL_DISTANCE_FROM_CENTER * Math.cos(_loc9_),RAIL_DISTANCE_FROM_CENTER * Math.sin(_loc9_)));
         var _loc14_:Point = param3.position.add(new Point(RAIL_DISTANCE_FROM_CENTER * Math.cos(_loc10_),RAIL_DISTANCE_FROM_CENTER * Math.sin(_loc10_)));
         param1.lineStyle(RAIL_THICKNESS_LAYER_1,COLOR_RAIL_LOW);
         param1.moveTo(_loc11_.x,_loc11_.y);
         param1.lineTo(_loc13_.x,_loc13_.y);
         param1.lineStyle(RAIL_THICKNESS_LAYER_1,COLOR_RAIL_LOW);
         param1.moveTo(_loc12_.x,_loc12_.y);
         param1.lineTo(_loc14_.x,_loc14_.y);
         param2.lineStyle(RAIL_THICKNESS_LAYER_2,COLOR_RAIL);
         param2.moveTo(_loc11_.x,_loc11_.y);
         param2.lineTo(_loc13_.x,_loc13_.y);
         param2.lineStyle(RAIL_THICKNESS_LAYER_2,COLOR_RAIL);
         param2.moveTo(_loc12_.x,_loc12_.y);
         param2.lineTo(_loc14_.x,_loc14_.y);
      }
      
      public function drawBridgeFloor(param1:BitmapData, param2:TrackNode) : void
      {
         var _loc3_:TrackNode = param2.former;
         if(!_loc3_)
         {
            return;
         }
         var _loc5_:Graphics;
         var _loc4_:Sprite;
         (_loc5_ = (_loc4_ = new Sprite()).graphics).lineStyle(BRIDGE_EDGE_DISTANCE_FROM_CENTER * 2,8221792,1,false,LineScaleMode.NONE,CapsStyle.ROUND);
         _loc5_.moveTo(_loc3_.x,_loc3_.y);
         _loc5_.lineTo(param2.x,param2.y);
         param1.draw(_loc4_,_loc4_.transform.matrix);
         _loc5_.clear();
      }
   }
}
