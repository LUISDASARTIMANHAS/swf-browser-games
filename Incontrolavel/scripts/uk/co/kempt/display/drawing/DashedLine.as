package uk.co.kempt.display.drawing
{
   import flash.display.CapsStyle;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class DashedLine extends Sprite
   {
       
      
      internal var fill:Shape;
      
      internal var lineAlpha:Number;
      
      internal var lengthsArray:Array;
      
      internal var lineColor:uint;
      
      internal var startIndex:int;
      
      internal var lineWeight:Number;
      
      internal var curY:Number;
      
      internal var curX:Number;
      
      internal var curIndex:int;
      
      internal var stroke:Shape;
      
      internal var arraySum:Number;
      
      internal var remainingDist:Number;
      
      public function DashedLine(param1:Number = 0, param2:Number = 0, param3:Array = null)
      {
         super();
         this.preinit();
         if(param3 != null)
         {
            this.lengthsArray = param3;
         }
         else
         {
            this.lengthsArray = [5,5];
         }
         if(this.lengthsArray.length % 2 != 0)
         {
            this.lengthsArray.push(5);
         }
         var _loc4_:int = 0;
         while(_loc4_ < this.lengthsArray.length)
         {
            this.arraySum += Number(this.lengthsArray[_loc4_]);
            _loc4_++;
         }
         this.lineWeight = param1;
         this.lineColor = param2;
         this.stroke.graphics.lineStyle(this.lineWeight,this.lineColor,this.lineAlpha,false,"none",CapsStyle.NONE);
         addChild(this.fill);
         addChild(this.stroke);
      }
      
      private function getDistance(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return Number(Math.sqrt(Math.pow(param3 - param1,2) + Math.pow(param4 - param2,2)));
      }
      
      public function lineTo(param1:Number, param2:Number) : void
      {
         var _loc8_:int = 0;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc3_:Number = (param2 - this.curY) / (param1 - this.curX);
         var _loc4_:Number = this.curX;
         var _loc5_:Number = this.curY;
         var _loc6_:int = param1 < _loc4_ ? -1 : 1;
         var _loc7_:int = param2 < _loc5_ ? -1 : 1;
         loop0:
         while(Math.abs(_loc4_ - this.curX) < Math.abs(_loc4_ - param1) || Math.abs(_loc5_ - this.curY) < Math.abs(_loc5_ - param2))
         {
            _loc8_ = this.startIndex;
            while(_loc8_ < this.lengthsArray.length)
            {
               _loc9_ = this.remainingDist == 0 ? Number(this.lengthsArray[_loc8_]) : this.remainingDist;
               _loc10_ = this.getCoords(_loc9_,_loc3_).x * _loc6_;
               _loc11_ = this.getCoords(_loc9_,_loc3_).y * _loc7_;
               if(!(Math.abs(_loc4_ - this.curX) + Math.abs(_loc10_) < Math.abs(_loc4_ - param1) || Math.abs(_loc5_ - this.curY) + Math.abs(_loc11_) < Math.abs(_loc5_ - param2)))
               {
                  this.remainingDist = this.getDistance(this.curX,this.curY,param1,param2);
                  this.curIndex = _loc8_;
                  break loop0;
               }
               if(_loc8_ % 2 == 0)
               {
                  this.stroke.graphics.lineTo(this.curX + _loc10_,this.curY + _loc11_);
               }
               else
               {
                  this.stroke.graphics.moveTo(this.curX + _loc10_,this.curY + _loc11_);
               }
               this.curX += _loc10_;
               this.curY += _loc11_;
               this.curIndex = _loc8_;
               this.startIndex = 0;
               this.remainingDist = 0;
               _loc8_++;
            }
         }
         this.startIndex = this.curIndex;
         if(this.remainingDist != 0)
         {
            if(this.curIndex % 2 == 0)
            {
               this.stroke.graphics.lineTo(param1,param2);
            }
            else
            {
               this.stroke.graphics.moveTo(param1,param2);
            }
            this.remainingDist = this.lengthsArray[this.curIndex] - this.remainingDist;
         }
         else if(this.startIndex == this.lengthsArray.length - 1)
         {
            this.startIndex = 0;
         }
         else
         {
            ++this.startIndex;
         }
         this.curX = param1;
         this.curY = param2;
         this.fill.graphics.lineTo(param1,param2);
      }
      
      private function getCoords(param1:Number, param2:Number) : Point
      {
         var _loc3_:Number = Number(Math.atan(param2));
         var _loc4_:Number = Number(Math.abs(Math.sin(_loc3_) * param1));
         var _loc5_:Number = Number(Math.abs(Math.cos(_loc3_) * param1));
         return new Point(_loc5_,_loc4_);
      }
      
      public function clear() : void
      {
         this.stroke.graphics.clear();
         this.stroke.graphics.lineStyle(this.lineWeight,this.lineColor,this.lineAlpha,false,"none",CapsStyle.NONE);
         this.fill.graphics.clear();
         this.moveTo(0,0);
      }
      
      public function lineStyle(param1:Number = 0, param2:Number = 0, param3:Number = 1) : void
      {
         this.lineWeight = param1;
         this.lineColor = param2;
         this.lineAlpha = param3;
         this.stroke.graphics.lineStyle(this.lineWeight,this.lineColor,this.lineAlpha,false,"none",CapsStyle.NONE);
      }
      
      public function moveTo(param1:Number, param2:Number) : void
      {
         this.stroke.graphics.moveTo(param1,param2);
         this.fill.graphics.moveTo(param1,param2);
         this.curX = param1;
         this.curY = param2;
         this.remainingDist = 0;
         this.startIndex = 0;
      }
      
      public function beginFill(param1:uint, param2:Number = 1) : void
      {
         this.fill.graphics.beginFill(param1,param2);
      }
      
      private function preinit() : void
      {
         this.lengthsArray = [];
         this.lineColor = 0;
         this.lineWeight = 0;
         this.lineAlpha = 1;
         this.curX = 0;
         this.curY = 0;
         this.remainingDist = 0;
         this.curIndex = -1;
         this.arraySum = 0;
         this.startIndex = 0;
         this.fill = new Shape();
         this.stroke = new Shape();
      }
      
      public function endFill() : void
      {
         this.fill.graphics.endFill();
      }
   }
}
