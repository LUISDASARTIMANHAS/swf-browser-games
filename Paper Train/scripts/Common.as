package
{
   import com.lib.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.net.*;
   import flash.text.*;
   
   public class Common extends Sprite
   {
       
      
      public var objData:Object;
      
      public var runningLevel:Boolean;
      
      public var trackPoints:Array;
      
      private var switchColor:* = 5205239;
      
      public var levelData:Object;
      
      public var blockData:Object;
      
      public var backgroundXOffset:* = -8;
      
      private var switchLineWidth:*;
      
      public var trainSpeed:* = 35;
      
      public var backgroundYOffset:* = -14;
      
      public var trains:Array;
      
      public var trainHalfSpeed:* = 15;
      
      public var connectPoints:Array;
      
      private var main:*;
      
      public var trackWidth:* = 7;
      
      public function Common(param1:*)
      {
         this.switchLineWidth = this.trackWidth;
         super();
         this.main = param1;
         this.blockData = new BlockData(param1);
         this.objData = new ObjData(param1);
         this.levelData = new LevelData(param1);
         this.trains = new Array();
         this.trackPoints = new Array();
         this.connectPoints = new Array();
         this.runningLevel = false;
      }
      
      public function addTrackPoint(param1:Object, param2:Object, param3:int) : *
      {
         var _loc5_:int = 0;
         var _loc4_:* = new Object();
         var _loc6_:* = this.rotateBy(param2.rotation,param1.x * param2.sx,param1.y * param2.sy);
         _loc4_.x = param2.x + _loc6_.x;
         _loc4_.y = param2.y + _loc6_.y;
         _loc4_.indices = new Array();
         for each(_loc5_ in param1.indices)
         {
            _loc4_.indices.push(_loc5_ + param3);
         }
         this.trackPoints.push(_loc4_);
      }
      
      private function isConnectable(param1:int, param2:int) : *
      {
         if(Math.abs(this.trackPoints[param1].x - this.trackPoints[param2].x) > 1 || Math.abs(this.trackPoints[param1].y - this.trackPoints[param2].y) > 1)
         {
            return false;
         }
         var _loc3_:* = this.trackPoints[param1].indices[0];
         var _loc4_:* = this.trackPoints[param2].indices[0];
         var _loc5_:* = new Point(this.trackPoints[_loc3_].x - this.trackPoints[param1].x,this.trackPoints[_loc3_].y - this.trackPoints[param1].y);
         var _loc6_:* = new Point(this.trackPoints[param1].x - this.trackPoints[_loc4_].x,this.trackPoints[param1].y - this.trackPoints[_loc4_].y);
         _loc5_.normalize(1);
         _loc6_.normalize(1);
         var _loc7_:*;
         if((_loc7_ = Math.acos(GMath.dot(_loc5_,_loc6_)) * 180 / Math.PI) > 20 && _loc7_ < 160)
         {
            return false;
         }
         if(_loc7_ > 200 && _loc7_ < 340)
         {
            return false;
         }
         return true;
      }
      
      public function drawSwitchArrow(param1:*, param2:*) : *
      {
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         var _loc15_:* = undefined;
         var _loc16_:* = undefined;
         var _loc3_:* = this.followTrack(param1,param2,0,50);
         var _loc4_:* = _loc3_.pnts;
         var _loc5_:*;
         (_loc5_ = new Sprite()).graphics.lineStyle(this.switchLineWidth,this.switchColor,1,true,LineScaleMode.NORMAL,CapsStyle.NONE,JointStyle.MITER,3);
         _loc5_.graphics.moveTo(_loc4_[0].x,_loc4_[0].y);
         for each(_loc6_ in _loc4_)
         {
            _loc5_.graphics.lineTo(_loc6_.x,_loc6_.y);
         }
         _loc5_.graphics.lineStyle(1,16777215,1,true,LineScaleMode.NORMAL,CapsStyle.NONE,JointStyle.MITER,3);
         _loc5_.graphics.moveTo(_loc4_[0].x,_loc4_[0].y);
         for each(_loc6_ in _loc4_)
         {
            _loc5_.graphics.lineTo(_loc6_.x,_loc6_.y);
         }
         _loc7_ = _loc4_[_loc4_.length - 1];
         _loc8_ = _loc4_[_loc4_.length - 2];
         (_loc9_ = _loc7_.subtract(_loc8_)).normalize(0.2);
         _loc7_ = _loc7_.subtract(_loc9_);
         (_loc10_ = GMath.cross(_loc9_)).normalize(0.5 * this.switchLineWidth);
         _loc11_ = new Point(-_loc10_.x,-_loc10_.y);
         _loc9_.normalize(0.8 * this.switchLineWidth);
         _loc12_ = _loc7_.add(_loc10_);
         _loc13_ = _loc7_.add(_loc11_);
         _loc14_ = _loc7_.add(_loc9_);
         (_loc15_ = new Vector.<Number>())[0] = _loc12_.x;
         _loc15_[1] = _loc12_.y;
         _loc15_[2] = _loc13_.x;
         _loc15_[3] = _loc13_.y;
         _loc15_[4] = _loc14_.x;
         _loc15_[5] = _loc14_.y;
         (_loc16_ = new Sprite()).graphics.beginFill(this.switchColor,1);
         _loc16_.graphics.lineStyle(0,0,0,true,LineScaleMode.NORMAL,CapsStyle.NONE,JointStyle.MITER,3);
         _loc16_.graphics.drawTriangles(_loc15_);
         _loc5_.addChild(_loc16_);
         return _loc5_;
      }
      
      public function rotateBy(param1:int, param2:Number, param3:Number) : *
      {
         var _loc5_:* = undefined;
         param1 %= 360;
         if(param1 < 0)
         {
            param1 += 360;
         }
         var _loc4_:* = new Object();
         if(param1 == 0)
         {
            _loc4_.x = param2;
            _loc4_.y = param3;
         }
         else if(param1 == 90)
         {
            _loc4_.x = -param3;
            _loc4_.y = param2;
         }
         else if(param1 == 180)
         {
            _loc4_.x = -param2;
            _loc4_.y = -param3;
         }
         else if(param1 == 270)
         {
            _loc4_.x = param3;
            _loc4_.y = -param2;
         }
         else
         {
            _loc5_ = Math.PI * param1 / 180;
            _loc4_.x = param2 * Math.cos(_loc5_) - param3 * Math.sin(_loc5_);
            _loc4_.y = param2 * Math.sin(_loc5_) + param3 * Math.cos(_loc5_);
         }
         return _loc4_;
      }
      
      private function mergePoints(param1:int, param2:int) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         for each(_loc3_ in this.trackPoints)
         {
            for(_loc4_ in _loc3_.indices)
            {
               if(_loc3_.indices[_loc4_] == param2)
               {
                  _loc3_.indices[_loc4_] = param1;
               }
            }
         }
         this.trackPoints[param1].indices = this.trackPoints[param1].indices.concat(this.trackPoints[param2].indices);
         this.trackPoints.splice(param2,1);
         for each(_loc3_ in this.trackPoints)
         {
            for(_loc4_ in _loc3_.indices)
            {
               if(_loc3_.indices[_loc4_] > param2)
               {
                  --_loc3_.indices[_loc4_];
               }
            }
         }
      }
      
      public function getProtoByName(param1:String, param2:String) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         if(param1 == "track")
         {
            for each(_loc3_ in this.blockData.blockList)
            {
               if(_loc3_.name == param2)
               {
                  return _loc3_;
               }
            }
         }
         else if(param1 == "object")
         {
            for each(_loc4_ in this.objData.objList)
            {
               if(_loc4_.name == param2)
               {
                  return _loc4_;
               }
            }
            return this.objData.obj_missing;
         }
         return null;
      }
      
      public function followTrack(param1:int, param2:int, param3:Number, param4:Number) : *
      {
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         var _loc15_:* = undefined;
         var _loc16_:* = undefined;
         var _loc17_:* = undefined;
         var _loc5_:*;
         (_loc5_ = new Object()).markerList = new Array();
         _loc5_.pnts = new Array();
         var _loc6_:* = param1;
         var _loc7_:* = param2;
         var _loc8_:* = param4 + param3;
         var _loc9_:* = new Point(this.trackPoints[_loc6_].x,this.trackPoints[_loc6_].y);
         var _loc11_:*;
         var _loc10_:*;
         (_loc11_ = (_loc10_ = new Point(this.trackPoints[_loc7_].x,this.trackPoints[_loc7_].y)).subtract(_loc9_)).normalize(param3);
         _loc5_.pnts.push(_loc9_.add(_loc11_));
         while(true)
         {
            _loc12_ = param4 - _loc8_;
            if(_loc6_ != param1)
            {
               if(this.trackPoints[_loc6_].setSpd)
               {
                  _loc5_.markerList.push({
                     "distance":_loc12_,
                     "setSpd":this.trackPoints[_loc6_].setSpd,
                     "id":_loc6_
                  });
               }
               if(this.trackPoints[_loc6_].stop)
               {
                  _loc5_.markerList.push({
                     "distance":_loc12_,
                     "stop":true,
                     "id":_loc6_
                  });
               }
            }
            _loc9_ = new Point(this.trackPoints[_loc6_].x,this.trackPoints[_loc6_].y);
            _loc14_ = (_loc13_ = (_loc10_ = new Point(this.trackPoints[_loc7_].x,this.trackPoints[_loc7_].y)).subtract(_loc9_)).length;
            if(_loc8_ <= _loc14_)
            {
               (_loc15_ = _loc13_).normalize(_loc8_);
               _loc16_ = _loc9_.add(_loc15_);
               _loc5_.dFirst = _loc6_;
               _loc5_.dNext = _loc7_;
               _loc5_.dOffs = _loc8_;
               _loc5_.dRevOffs = (1 - _loc8_ / _loc14_) * _loc14_;
               _loc5_.dPoint = _loc16_;
               _loc5_.pnts.push(_loc16_);
               break;
            }
            _loc8_ -= _loc14_;
            _loc5_.pnts.push(_loc10_);
            if(this.trackPoints[_loc7_].indices.length == 1)
            {
               _loc12_ = param4 - _loc8_;
               if(this.trackPoints[_loc7_].closed)
               {
                  _loc5_.markerList.push({
                     "distance":_loc12_,
                     "closed":true,
                     "id":_loc7_
                  });
               }
               if(this.trackPoints[_loc7_].turnBack)
               {
                  _loc5_.markerList.push({
                     "distance":_loc12_,
                     "turnBack":true,
                     "id":_loc7_
                  });
               }
               _loc5_.dFirst = -1;
               _loc5_.dNext = -1;
               _loc5_.dOffs = 0;
               _loc5_.dRevOffs = 0;
               _loc5_.dPoint = null;
               _loc5_.overflow = true;
               break;
            }
            if(this.trackPoints[_loc7_].indices.length == 2)
            {
               if(this.trackPoints[_loc7_].indices[0] == _loc6_)
               {
                  _loc6_ = _loc7_;
                  _loc7_ = this.trackPoints[_loc7_].indices[1];
               }
               else
               {
                  _loc6_ = _loc7_;
                  _loc7_ = this.trackPoints[_loc7_].indices[0];
               }
            }
            else if(this.trackPoints[_loc7_].indices.length == 3)
            {
               _loc17_ = _loc7_;
               _loc7_ = this.getSwitchSide(_loc7_,_loc6_);
               _loc6_ = _loc17_;
               _loc5_.switchIdx = _loc6_;
            }
            else
            {
               trace("followTrack() error!");
            }
         }
         return _loc5_;
      }
      
      public function mergeConnectPoints() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         for(_loc1_ in this.connectPoints)
         {
            for(_loc2_ in this.connectPoints)
            {
               if(_loc1_ != _loc2_)
               {
                  _loc3_ = this.connectPoints[_loc1_];
                  _loc4_ = this.connectPoints[_loc2_];
                  if(this.isConnectable(_loc3_,_loc4_))
                  {
                     this.mergePoints(_loc3_,_loc4_);
                     this.connectPoints.splice(_loc2_,1);
                     for(_loc5_ in this.connectPoints)
                     {
                        if(this.connectPoints[_loc5_] > _loc4_)
                        {
                           --this.connectPoints[_loc5_];
                        }
                     }
                  }
               }
            }
         }
      }
      
      public function isRunningLevel() : *
      {
         return this.runningLevel;
      }
      
      private function getSwitchSide(param1:int, param2:int) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         if(this.trackPoints[param1].indices.length != 3)
         {
            trace("getSwitchSide() indices length != 3");
            return -1;
         }
         if(this.trackPoints[param1].indices[0] == param2)
         {
            _loc3_ = this.trackPoints[param1].indices[1];
            _loc4_ = this.trackPoints[param1].indices[2];
         }
         else if(this.trackPoints[param1].indices[1] == param2)
         {
            _loc3_ = this.trackPoints[param1].indices[0];
            _loc4_ = this.trackPoints[param1].indices[2];
         }
         else
         {
            if(this.trackPoints[param1].indices[2] != param2)
            {
               trace("getSwitchSide() cannot found pFrom!");
               return -1;
            }
            _loc3_ = this.trackPoints[param1].indices[0];
            _loc4_ = this.trackPoints[param1].indices[1];
         }
         var _loc5_:* = new Point(this.trackPoints[_loc3_].x,this.trackPoints[_loc3_].y);
         var _loc6_:* = new Point(this.trackPoints[_loc4_].x,this.trackPoints[_loc4_].y);
         var _loc7_:* = new Point(this.trackPoints[param2].x,this.trackPoints[param2].y);
         var _loc8_:*;
         var _loc9_:* = (_loc8_ = new Point(this.trackPoints[param1].x,this.trackPoints[param1].y)).subtract(_loc7_);
         var _loc10_:* = _loc5_.subtract(_loc8_);
         var _loc11_:* = _loc6_.subtract(_loc8_);
         var _loc12_:* = GMath.getVecAngle(_loc10_) - GMath.getVecAngle(_loc9_);
         var _loc13_:* = GMath.getVecAngle(_loc11_) - GMath.getVecAngle(_loc9_);
         if(_loc12_ < 0)
         {
            _loc12_ += 360;
         }
         if(_loc13_ < 0)
         {
            _loc13_ += 360;
         }
         var _loc14_:* = _loc12_ < 20 || _loc12_ > 340 ? true : false;
         var _loc15_:* = _loc13_ < 20 || _loc13_ > 340 ? true : false;
         if(_loc14_ && !_loc15_)
         {
            return _loc3_;
         }
         if(_loc15_ && !_loc14_)
         {
            return _loc4_;
         }
         if(_loc14_ && _loc15_)
         {
            if(this.trackPoints[param1].turnSwitch)
            {
               return GMath.dot(_loc10_,_loc11_) > 0 ? _loc3_ : _loc4_;
            }
            return GMath.dot(_loc10_,_loc11_) > 0 ? _loc4_ : _loc3_;
         }
         trace("getSwitchSide() sa1, sa2 error!");
         return -1;
      }
      
      public function snap45Degree(param1:Number) : *
      {
         return int(Math.round(int(param1) % 360 / 45) * 45);
      }
   }
}
