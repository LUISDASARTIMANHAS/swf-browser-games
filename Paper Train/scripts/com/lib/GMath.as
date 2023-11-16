package com.lib
{
   import flash.geom.*;
   
   public class GMath
   {
       
      
      public function GMath()
      {
         super();
      }
      
      public static function cross(param1:Point) : Point
      {
         var _loc2_:* = new Point(param1.y,-param1.x);
         _loc2_.normalize(1);
         return _loc2_;
      }
      
      public static function getVecAngle(param1:Point) : Number
      {
         return 180 / Math.PI * Math.atan2(param1.y,param1.x);
      }
      
      public static function bezierCurve(param1:Point, param2:Point, param3:Point, param4:Point, param5:int = 32) : Array
      {
         var _loc6_:* = new Array();
         var _loc7_:* = 0;
         while(_loc7_ <= param5)
         {
            _loc6_.push(GMath.bezier(param1,param2,param3,param4,_loc7_ / param5));
            _loc7_++;
         }
         return _loc6_;
      }
      
      public static function dot(param1:Point, param2:Point) : Number
      {
         return param1.x * param2.x + param1.y * param2.y;
      }
      
      public static function lineIntersect(param1:Point, param2:Point, param3:Point, param4:Point) : Point
      {
         var _loc5_:* = param1.x;
         var _loc6_:* = param1.y;
         var _loc7_:* = param2.x;
         var _loc8_:* = param2.y;
         var _loc9_:* = param3.x;
         var _loc10_:* = param3.y;
         var _loc11_:* = param4.x;
         var _loc12_:* = param4.y;
         if(_loc5_ == _loc7_ && _loc6_ == _loc8_ || _loc9_ == _loc11_ && _loc10_ == _loc12_)
         {
            return null;
         }
         if(_loc5_ == _loc9_ && _loc6_ == _loc10_ || _loc7_ == _loc9_ && _loc8_ == _loc10_ || _loc5_ == _loc11_ && _loc6_ == _loc12_ || _loc7_ == _loc11_ && _loc8_ == _loc12_)
         {
            return null;
         }
         _loc7_ -= _loc5_;
         _loc8_ -= _loc6_;
         _loc9_ -= _loc5_;
         _loc10_ -= _loc6_;
         _loc11_ -= _loc5_;
         _loc12_ -= _loc6_;
         var _loc13_:* = Math.sqrt(_loc7_ * _loc7_ + _loc8_ * _loc8_);
         var _loc14_:* = _loc7_ / _loc13_;
         var _loc15_:* = _loc8_ / _loc13_;
         var _loc16_:* = _loc9_ * _loc14_ + _loc10_ * _loc15_;
         _loc10_ = _loc10_ * _loc14_ - _loc9_ * _loc15_;
         _loc9_ = _loc16_;
         _loc16_ = _loc11_ * _loc14_ + _loc12_ * _loc15_;
         _loc12_ = _loc12_ * _loc14_ - _loc11_ * _loc15_;
         _loc11_ = _loc16_;
         if(_loc10_ < 0 && _loc12_ < 0 || _loc10_ >= 0 && _loc12_ >= 0)
         {
            return null;
         }
         var _loc17_:*;
         if((_loc17_ = _loc11_ + (_loc9_ - _loc11_) * _loc12_ / (_loc12_ - _loc10_)) < 0 || _loc17_ > _loc13_)
         {
            return null;
         }
         var _loc18_:* = _loc5_ + _loc17_ * _loc14_;
         var _loc19_:* = _loc6_ + _loc17_ * _loc15_;
         return new Point(_loc18_,_loc19_);
      }
      
      public static function lerpVec(param1:Point, param2:Point, param3:Number) : Point
      {
         return new Point((1 - param3) * param1.x + param3 * param2.x,(1 - param3) * param1.y + param3 * param2.y);
      }
      
      public static function bezier(param1:Point, param2:Point, param3:Point, param4:Point, param5:Number) : Point
      {
         var _loc6_:* = param1.add(param3);
         var _loc7_:* = param2.add(param4);
         var _loc8_:* = Math.pow(param5,3) * (param2.x + 3 * (_loc6_.x - _loc7_.x) - param1.x) + 3 * Math.pow(param5,2) * (param1.x - 2 * _loc6_.x + _loc7_.x) + 3 * param5 * (_loc6_.x - param1.x) + param1.x;
         var _loc9_:* = Math.pow(param5,3) * (param2.y + 3 * (_loc6_.y - _loc7_.y) - param1.y) + 3 * Math.pow(param5,2) * (param1.y - 2 * _loc6_.y + _loc7_.y) + 3 * param5 * (_loc6_.y - param1.y) + param1.y;
         return new Point(_loc8_,_loc9_);
      }
   }
}
