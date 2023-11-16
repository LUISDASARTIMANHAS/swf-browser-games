package com.lib
{
   import com.adobe.serialization.json.JSON;
   import flash.geom.*;
   import flash.utils.*;
   
   public class GPath
   {
       
      
      private var segments:int = 100;
      
      private var storedPrevKey:int = -1;
      
      private var storedCurrKey:int = -1;
      
      private var curve:Object = null;
      
      private var lookupTable:Array;
      
      public function GPath(param1:*)
      {
         super();
         if(!param1)
         {
            return;
         }
         if(getQualifiedClassName(param1) == "Object")
         {
            this.parseCurve(param1);
         }
         else
         {
            this.parseCurve(com.adobe.serialization.json.JSON.decode(param1));
         }
         this.calculateCurveLength();
      }
      
      private function calcDistanceBetweenKeys(param1:Object, param2:Object) : Number
      {
         var _loc7_:* = undefined;
         var _loc3_:* = GMath.bezierCurve(param1.pos,param2.pos,param1.c2,param2.c1,this.segments);
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = 0;
         for each(_loc7_ in _loc3_)
         {
            _loc4_ = _loc5_;
            _loc5_ = _loc7_;
            if(_loc4_)
            {
               _loc6_ += Point.distance(_loc4_,_loc5_);
            }
         }
         return _loc6_;
      }
      
      private function parseCurve(param1:Object) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         this.curve = new Object();
         this.curve.cid = param1.cid;
         this.curve.duration = param1.duration;
         this.curve.keys = new Array();
         for each(_loc2_ in param1.keys)
         {
            this.curve.keys.push({
               "pos":new Point(_loc2_.pos.x,_loc2_.pos.y),
               "c1":new Point(_loc2_.c1.x,_loc2_.c1.y),
               "c2":new Point(_loc2_.c2.x,_loc2_.c2.y)
            });
         }
         this.curve.chns = new Array();
         for each(_loc3_ in param1.chns)
         {
            _loc4_ = new Object();
            this.curve.chns.push(_loc4_);
            _loc4_.name = _loc3_.name;
            _loc4_.yFactor = _loc3_.yFactor;
            _loc4_.keys = new Array();
            for each(_loc2_ in _loc3_.keys)
            {
               _loc4_.keys.push({"pos":new Point(_loc2_.pos.x,_loc2_.pos.y)});
            }
         }
      }
      
      private function getChannelValue(param1:String, param2:Number) : Number
      {
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc3_:* = this.getChannelByName(param1);
         if(!_loc3_)
         {
            return 0;
         }
         if(param2 < 0)
         {
            param2 = 0;
         }
         if(param2 > 1)
         {
            param2 = 1;
         }
         var _loc4_:* = null;
         var _loc5_:* = null;
         for each(_loc6_ in _loc3_.keys)
         {
            _loc4_ = _loc5_;
            _loc5_ = _loc6_;
            if(_loc4_)
            {
               if(param2 >= _loc4_.pos.x && param2 < _loc5_.pos.x)
               {
                  break;
               }
            }
         }
         if((_loc7_ = (param2 - _loc4_.pos.x) / (_loc5_.pos.x - _loc4_.pos.x)) < 0)
         {
            _loc7_ = 0;
         }
         if(_loc7_ > 1)
         {
            _loc7_ = 1;
         }
         var _loc8_:*;
         return (_loc8_ = _loc4_.pos.y + _loc7_ * (_loc5_.pos.y - _loc4_.pos.y)) * _loc3_.yFactor;
      }
      
      private function getLookupTable(param1:Object, param2:Object) : Array
      {
         var _loc9_:* = undefined;
         var _loc3_:* = new Array();
         var _loc4_:* = GMath.bezierCurve(param1.pos,param2.pos,param1.c2,param2.c1,this.segments);
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = param1.dist;
         var _loc8_:* = 0;
         for each(_loc9_ in _loc4_)
         {
            _loc5_ = _loc6_;
            _loc6_ = _loc9_;
            if(_loc5_)
            {
               _loc7_ += Point.distance(_loc5_,_loc6_);
            }
            _loc3_.push({
               "d":_loc7_ / this.curve.totalDist,
               "t":_loc8_ / this.segments
            });
            _loc8_++;
         }
         _loc3_.push({
            "d":param2.dist / this.curve.totalDist,
            "t":1
         });
         return _loc3_;
      }
      
      public function updateClip(param1:*, param2:Number) : *
      {
         var _loc3_:* = this.getObjectValues(param2);
         param1.x = _loc3_.pos.x;
         param1.y = _loc3_.pos.y;
         param1.scaleX = _loc3_.scale;
         param1.scaleY = _loc3_.scale;
         param1.rotation = _loc3_.rotation;
         param1.alpha = _loc3_.alpha;
      }
      
      private function d2t(param1:Number, param2:Array) : Number
      {
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc3_:* = null;
         var _loc4_:* = null;
         for each(_loc5_ in param2)
         {
            _loc3_ = _loc4_;
            _loc4_ = _loc5_;
            if(_loc3_)
            {
               if(param1 >= _loc3_.d && param1 < _loc4_.d)
               {
                  _loc6_ = (param1 - _loc3_.d) / (_loc4_.d - _loc3_.d);
                  return _loc3_.t + _loc6_ * (_loc4_.t - _loc3_.t);
               }
            }
         }
         return _loc4_.t;
      }
      
      public function getDuration() : Number
      {
         return this.curve.duration;
      }
      
      private function calculateCurveLength() : *
      {
         var _loc4_:* = undefined;
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = 0;
         for each(_loc4_ in this.curve.keys)
         {
            _loc1_ = _loc2_;
            _loc2_ = _loc4_;
            if(_loc1_)
            {
               _loc3_ += this.calcDistanceBetweenKeys(_loc1_,_loc2_);
            }
            _loc2_.dist = _loc3_;
         }
         this.curve.totalDist = _loc3_;
      }
      
      private function getChannelByName(param1:String) : *
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this.curve.chns)
         {
            if(_loc2_.name == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getObjectValues(param1:Number) : Object
      {
         var _loc2_:* = this.getChannelValue("time",param1);
         var _loc3_:* = this.getChannelValue("rotation",param1);
         var _loc4_:* = this.getChannelValue("scale",param1);
         var _loc5_:* = this.getChannelValue("z",param1);
         var _loc6_:* = this.getChannelValue("alpha",param1);
         if(_loc5_ < 0.1)
         {
            _loc5_ = 0.1;
         }
         var _loc7_:*;
         if(!(_loc7_ = this.getPosition(_loc2_)))
         {
            return null;
         }
         return {
            "pos":_loc7_,
            "scale":_loc4_ * (1 / _loc5_),
            "rotation":_loc3_,
            "alpha":_loc6_
         };
      }
      
      public function getCurve() : Object
      {
         return this.curve;
      }
      
      public function getLength() : Number
      {
         return this.curve.totalDist;
      }
      
      public function getPosition(param1:Number) : Point
      {
         var _loc5_:* = undefined;
         if(!this.curve.keys.length)
         {
            return null;
         }
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param1 > 1)
         {
            param1 = 1;
         }
         var _loc2_:* = param1 * this.curve.totalDist;
         var _loc3_:* = null;
         var _loc4_:* = null;
         for each(_loc5_ in this.curve.keys)
         {
            _loc3_ = _loc4_;
            _loc4_ = _loc5_;
            if(_loc3_)
            {
               if(_loc2_ >= _loc3_.dist && _loc2_ < _loc4_.dist)
               {
                  break;
               }
            }
         }
         if(!_loc3_)
         {
            return _loc4_.pos;
         }
         if(_loc3_ != this.storedPrevKey || _loc4_ != this.storedCurrKey)
         {
            this.lookupTable = this.getLookupTable(_loc3_,_loc4_);
         }
         var _loc6_:* = this.d2t(param1,this.lookupTable);
         return GMath.bezier(_loc3_.pos,_loc4_.pos,_loc3_.c2,_loc4_.c1,_loc6_);
      }
   }
}
