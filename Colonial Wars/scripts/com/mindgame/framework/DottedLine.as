package com.mindgame.framework
{
   import flash.display.Graphics;
   import flash.geom.*;
   
   public class DottedLine
   {
      
      public static var DASH_LENGTH:Number = 8;
      
      public static var GAP_LENGTH:Number = 4;
      
      public static var percent:Number = 1;
      
      public static var percentStep:Number = 0.05;
      
      public static var start:Point = new Point();
      
      public static var end:Point = new Point();
      
      public static var active:Boolean = false;
      
      public static var inEnd:Boolean = false;
      
      public static var allIslands:Array = [];
       
      
      public function DottedLine()
      {
         super();
      }
      
      public static function dashedLine(param1:Graphics, param2:Point, param3:Point, param4:Number = 0, param5:Boolean = true) : void
      {
         var _loc6_:* = false;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         if(param5)
         {
            start.x = param2.x;
            start.y = param2.y;
            end.x = param3.x;
            end.y = param3.y;
            percent = 1;
            if((param4 %= 1) < 0)
            {
               param4 += 1;
            }
            _loc6_ = false;
            _loc7_ = param4 * (GAP_LENGTH + DASH_LENGTH);
            _loc8_ = Number(Point.distance(param2,param3));
            _loc9_ = Number(Math.atan2(param3.y - param2.y,param3.x - param2.x));
            _loc10_ = Number(Math.cos(_loc9_));
            _loc11_ = Number(Math.sin(_loc9_));
            if(_loc7_ > GAP_LENGTH)
            {
               param1.moveTo(param2.x,param2.y);
               _loc12_ = param2.x + (_loc7_ - GAP_LENGTH) * _loc10_;
               _loc13_ = param2.y + (_loc7_ - GAP_LENGTH) * _loc11_;
               param1.lineTo(_loc12_,_loc13_);
            }
            while(_loc7_ < _loc8_)
            {
               _loc12_ = param2.x + _loc7_ * _loc10_;
               _loc13_ = param2.y + _loc7_ * _loc11_;
               if(_loc6_)
               {
                  param1.lineTo(_loc12_,_loc13_);
                  _loc7_ += GAP_LENGTH;
               }
               else
               {
                  param1.moveTo(_loc12_,_loc13_);
                  _loc7_ += DASH_LENGTH;
               }
               _loc6_ = !_loc6_;
            }
            if(_loc6_)
            {
               param1.lineTo(param3.x,param3.y);
            }
         }
         else
         {
            _loc7_ = GAP_LENGTH + DASH_LENGTH;
            _loc9_ = Number(Math.atan2(end.y - start.y,end.x - start.x));
            _loc10_ = Number(Math.cos(_loc9_));
            _loc11_ = Number(Math.sin(_loc9_));
            _loc8_ = Point.distance(start,end) * percent;
            if(_loc7_ > GAP_LENGTH)
            {
               param1.moveTo(end.x,end.y);
               _loc12_ = end.x - (_loc7_ - GAP_LENGTH) * _loc10_;
               _loc13_ = end.y - (_loc7_ - GAP_LENGTH) * _loc11_;
               param1.lineTo(_loc12_,_loc13_);
            }
            while(_loc7_ < _loc8_)
            {
               _loc12_ = end.x - _loc7_ * _loc10_;
               _loc13_ = end.y - _loc7_ * _loc11_;
               if(_loc6_)
               {
                  param1.lineTo(_loc12_,_loc13_);
                  _loc7_ += GAP_LENGTH;
               }
               else
               {
                  param1.moveTo(_loc12_,_loc13_);
                  _loc7_ += DASH_LENGTH;
               }
               _loc6_ = !_loc6_;
            }
            percent -= percentStep;
            if(percent <= 0)
            {
               active = false;
               param1.clear();
               inEnd = false;
            }
         }
      }
   }
}
