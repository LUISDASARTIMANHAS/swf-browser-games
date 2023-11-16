package utils
{
   import flash.geom.Rectangle;
   
   public class cGeometry
   {
      
      public static var m_box1:cVector2 = new cVector2();
      
      public static var m_box2:cVector2 = new cVector2();
      
      public static var m_cacheVec:cVector2 = new cVector2();
      
      public static var m_localPos:cVector2 = new cVector2();
       
      
      public function cGeometry()
      {
         super();
      }
      
      public static function getRandomPolygon(param1:int, param2:Number, param3:Number, param4:Number, param5:Number) : Array
      {
         var _loc12_:Number = NaN;
         var _loc13_:cVector2 = null;
         var _loc6_:Array = [];
         var _loc7_:Number = (param4 + param2) / 2;
         var _loc8_:Number = (param5 + param3) / 2;
         var _loc9_:Number = Math.min(_loc7_,_loc8_);
         var _loc10_:Number = Math.PI * 2 / Number(param1);
         var _loc11_:int = 0;
         while(_loc11_ < param1)
         {
            _loc12_ = cHelper.random(_loc9_ * 0.2,_loc9_);
            _loc13_ = new cVector2(_loc12_,0);
            cTransformations.rotateAroundOrigin(_loc13_,_loc11_ * _loc10_);
            _loc13_.x += _loc7_;
            _loc13_.y += _loc8_;
            do
            {
               _loc6_.push(_loc13_);
               _loc11_++;
            }
            while(false);
            
         }
         return _loc6_;
      }
      
      public static function distToRayPlaneIntersect(param1:cVector2, param2:cVector2, param3:cVector2, param4:cVector2) : Number
      {
         var _loc5_:Number = -param4.dotOf(param3);
         var _loc6_:Number = param4.dotOf(param1) + _loc5_;
         var _loc7_:Number;
         if((_loc7_ = param4.dotOf(param2)) < 0.00001 && _loc7_ > -0.00001)
         {
            return -1;
         }
         return -(_loc6_ / _loc7_);
      }
      
      public static function whereIsPoint(param1:cVector2, param2:cVector2, param3:cVector2) : int
      {
         m_cacheVec.set(param2.x,param2.y);
         m_cacheVec.subtract(param1);
         var _loc4_:Number;
         if((_loc4_ = m_cacheVec.dotOf(param3)) < -0.00001)
         {
            return 1;
         }
         if(_loc4_ > 0.00001)
         {
            return -1;
         }
         return 0;
      }
      
      public static function getRayCircleIntersect(param1:cVector2, param2:cVector2, param3:cVector2, param4:Number) : Number
      {
         m_cacheVec.set(param3.x,param3.y);
         m_cacheVec.subtract(param1);
         var _loc5_:Number = m_cacheVec.length;
         var _loc6_:Number = m_cacheVec.dotOf(param2);
         var _loc7_:Number;
         if((_loc7_ = param4 * param4 - (_loc5_ * _loc5_ - _loc6_ * _loc6_)) < 0)
         {
            return -1;
         }
         return _loc6_ - Math.sqrt(_loc7_);
      }
      
      public static function doesRayIntersectCircle(param1:cVector2, param2:cVector2, param3:cVector2, param4:Number) : Boolean
      {
         m_cacheVec.set(param3.x,param3.y);
         m_cacheVec.subtract(param1);
         var _loc5_:Number = m_cacheVec.length;
         var _loc6_:Number = m_cacheVec.dotOf(param2);
         var _loc7_:Number;
         return (_loc7_ = param4 * param4 - (_loc5_ * _loc5_ - _loc6_ * _loc6_)) < 0;
      }
      
      public static function getTangentPoints(param1:cVector2, param2:Number, param3:cVector2, param4:cVector2, param5:cVector2) : Boolean
      {
         m_cacheVec.set(param3.x,param3.y);
         m_cacheVec.subtract(param1);
         var _loc6_:Number = m_cacheVec.lengthSquared;
         var _loc7_:Number = param2 * param2;
         if(_loc6_ <= _loc7_)
         {
            return false;
         }
         var _loc8_:Number = 1 / _loc6_;
         var _loc9_:Number = Math.sqrt(Math.abs(_loc6_ - _loc7_));
         param4.x = param1.x + param2 * (param2 * m_cacheVec.x - m_cacheVec.y * _loc9_) * _loc8_;
         param4.y = param1.y + param2 * (param2 * m_cacheVec.y - m_cacheVec.x * _loc9_) * _loc8_;
         param5.x = param1.x + param2 * (param2 * m_cacheVec.x - m_cacheVec.y * _loc9_) * _loc8_;
         param5.y = param1.y + param2 * (param2 * m_cacheVec.y - m_cacheVec.x * _loc9_) * _loc8_;
         return true;
      }
      
      public static function distToLineSegment(param1:cVector2, param2:cVector2, param3:cVector2) : Number
      {
         var _loc4_:Number;
         if((_loc4_ = (param3.x - param1.x) * (param2.x - param1.x) + (param3.y - param1.y) * (param2.y - param1.y)) <= 0)
         {
            return param1.distance(param3);
         }
         var _loc5_:Number;
         if((_loc5_ = (param3.x - param2.x) * (param1.x - param2.x) + (param3.y - param2.y) * (param1.y - param2.y)) <= 0)
         {
            return param2.distance(param3);
         }
         m_cacheVec.set(param2.x,param2.y);
         m_cacheVec.subtract(param1);
         m_cacheVec.multiply(_loc4_);
         m_cacheVec.divide(_loc4_ + _loc5_);
         m_cacheVec.add(param1);
         return param3.distance(m_cacheVec);
      }
      
      public static function distToLineSegmentSq(param1:cVector2, param2:cVector2, param3:cVector2) : Number
      {
         var _loc4_:Number;
         if((_loc4_ = (param3.x - param1.x) * (param2.x - param1.x) + (param3.y - param1.y) * (param2.y - param1.y)) <= 0)
         {
            return param1.distanceSquared(param3);
         }
         var _loc5_:Number;
         if((_loc5_ = (param3.x - param2.x) * (param1.x - param2.x) + (param3.y - param2.y) * (param1.y - param2.y)) <= 0)
         {
            return param2.distanceSquared(param3);
         }
         m_cacheVec.set(param2.x,param2.y);
         m_cacheVec.subtract(param1);
         m_cacheVec.multiply(_loc4_);
         m_cacheVec.divide(_loc4_ + _loc5_);
         m_cacheVec.add(param1);
         return param3.distanceSquared(m_cacheVec);
      }
      
      public static function isLineIntersecting(param1:cVector2, param2:cVector2, param3:cVector2, param4:cVector2) : Boolean
      {
         var _loc5_:Number = (param1.y - param3.y) * (param4.x - param3.x) - (param1.x - param3.x) * (param4.y - param3.y);
         var _loc6_:Number = (param1.y - param3.y) * (param2.x - param1.x) - (param1.x - param3.x) * (param2.y - param1.y);
         var _loc7_:Number;
         if((_loc7_ = (param2.x - param1.x) * (param4.y - param3.y) - (param2.y - param1.y) * (param4.x - param3.x)) == 0)
         {
            return false;
         }
         var _loc8_:Number = 1 / _loc7_;
         var _loc9_:Number = _loc5_ * _loc8_;
         var _loc10_:Number = _loc6_ * _loc8_;
         if(_loc9_ > 0 && _loc9_ < 1 && _loc10_ > 0 && _loc10_ < 1)
         {
            return true;
         }
         return false;
      }
      
      public static function lineIntersection(param1:cVector2, param2:cVector2, param3:cVector2, param4:cVector2, param5:cVector2 = null) : Number
      {
         var _loc10_:Number = NaN;
         var _loc6_:Number = (param1.y - param3.y) * (param4.x - param3.x) - (param1.x - param3.x) * (param4.y - param3.y);
         var _loc7_:Number = (param1.y - param3.y) * (param2.x - param1.x) - (param1.x - param3.x) * (param2.y - param1.y);
         var _loc8_:Number = (param2.x - param1.x) * (param4.y - param3.y) - (param2.y - param1.y) * (param4.x - param3.x);
         var _loc9_:Number = (param2.x - param1.x) * (param4.y - param3.y) - (param2.y - param1.y) * (param4.x - param3.x);
         §§push(_loc8_ == 0);
         if(!(_loc8_ == 0))
         {
            §§pop();
            while(true)
            {
               §§push(_loc9_ == 0);
            }
            addr127:
         }
         while(!§§pop())
         {
            _loc10_ = _loc6_ / _loc8_;
            if(true)
            {
               var _loc11_:Number = _loc7_ / _loc9_;
               if(_loc10_ > 0 && _loc10_ < 1 && _loc11_ > 0 && _loc11_ < 1)
               {
                  if(param5)
                  {
                     param5.x = param1.x + _loc10_ * (param2.x - param1.x);
                     param5.y = param1.y + _loc10_ * (param2.y - param1.y);
                  }
                  return param1.distance(param2) * _loc10_;
               }
               return 0;
            }
            §§goto(addr127);
         }
         return -1;
      }
      
      public static function isObjectOverlapping(param1:Array, param2:Array) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = 0;
            while(_loc4_ < param2.length)
            {
               if(isLineIntersecting(param2[_loc4_],param2[_loc4_ + 1],param1[_loc3_],param1[_loc3_ + 1]))
               {
                  return true;
               }
               _loc4_++;
            }
            _loc3_++;
         }
         return false;
      }
      
      public static function isObjectOverlappingSegment(param1:cVector2, param2:cVector2, param3:Array) : Boolean
      {
         var _loc4_:int = 0;
         while(_loc4_ < param3.length)
         {
            if(isLineIntersecting(param1,param2,param3[_loc4_],param3[_loc4_ + 1]))
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      public static function isCircleOverlapping(param1:cVector2, param2:Number, param3:cVector2, param4:Number) : Boolean
      {
         var _loc5_:Number = param1.distanceSquared(param3);
         var _loc6_:Number = param2 + param4;
         if(_loc5_ < _loc6_ * _loc6_)
         {
            return true;
         }
         return false;
      }
      
      public static function getCircleIntersectionPoints(param1:cVector2, param2:Number, param3:cVector2, param4:Number, param5:cVector2, param6:cVector2) : Boolean
      {
         if(!isCircleOverlapping(param1,param2,param3,param4))
         {
            return false;
         }
         var _loc7_:Number = param1.distance(param3);
         var _loc8_:Number = (param2 - param4 + _loc7_ * _loc7_) / (2 * _loc7_);
         var _loc9_:Number = (param4 - param2 + _loc7_ * _loc7_) / (2 * _loc7_);
         m_cacheVec.x = param1.x + _loc8_ * (param3.x - param1.x) / _loc7_;
         m_cacheVec.y = param1.y + _loc8_ * (param3.y - param1.y) / _loc7_;
         var _loc10_:Number = Math.sqrt(param2 * param2 - _loc8_ * _loc8_);
         param5.x = m_cacheVec.x - _loc10_ * (param3.y - param1.y) / _loc7_;
         param5.y = m_cacheVec.y - _loc10_ * (param3.x - param1.x) / _loc7_;
         var _loc11_:Number = Math.sqrt(param4 * param4 - _loc8_ * _loc8_);
         param6.x = m_cacheVec.x - _loc11_ * (param3.y - param1.y) / _loc7_;
         param6.y = m_cacheVec.y - _loc11_ * (param3.x - param1.x) / _loc7_;
         return true;
      }
      
      public static function getCircleIntersectionArea(param1:cVector2, param2:Number, param3:cVector2, param4:Number) : Number
      {
         if(!isCircleOverlapping(param1,param2,param3,param4))
         {
            return 0;
         }
         var _loc5_:Number = Math.sqrt((param1.x - param3.x) * (param1.x - param3.x) + (param1.y - param3.y) * (param1.y - param3.y));
         var _loc6_:Number = 2 * Math.acos((param4 * param4 + _loc5_ * _loc5_ - param2 * param2) / (param4 * _loc5_ * 2));
         var _loc7_:Number = 2 * Math.acos((param2 * param2 + _loc5_ * _loc5_ - param4 * param4) / (param2 * _loc5_ * 2));
         return 0.5 * _loc6_ * param4 * param4 - 0.5 * param4 * param4 * Math.sin(_loc6_) + 0.5 * _loc7_ * param2 * param2 - 0.5 * param2 * param2 * Math.sin(_loc7_);
      }
      
      public static function circleArea(param1:Number) : Number
      {
         return Math.PI * param1 * param1;
      }
      
      public static function isPointInCircle(param1:cVector2, param2:Number, param3:cVector2) : Boolean
      {
         m_cacheVec.set(param3.x,param3.y);
         m_cacheVec.subtract(param1);
         if(m_cacheVec.lengthSquared < param2 * param2)
         {
            return true;
         }
         return false;
      }
      
      public static function randomPointInCircle(param1:cVector2, param2:Number, param3:cVector2) : void
      {
         do
         {
            param3.x = cHelper.random(param1.x - param2,param1.x + param2);
            param3.y = cHelper.random(param1.y - param2,param1.y + param2);
         }
         while(!isPointInCircle(param1,param2,param3));
         
      }
      
      public static function isCircleOverlappingSegment(param1:cVector2, param2:cVector2, param3:cVector2, param4:Number) : Boolean
      {
         var _loc5_:Number;
         if((_loc5_ = distToLineSegmentSq(param1,param2,param3)) < param4 * param4)
         {
            return true;
         }
         return false;
      }
      
      public static function getLineCircleClosestIntersection(param1:cVector2, param2:cVector2, param3:cVector2, param4:Number, param5:cVector2) : Boolean
      {
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         m_cacheVec.set(param2.x,param2.y);
         m_cacheVec.subtract(param1);
         m_cacheVec.normalize();
         m_localPos.set(m_cacheVec.x,m_cacheVec.y);
         do
         {
            m_localPos.perpendicular();
            m_localPos = cTransformations.pointToLocalSpace(param3,m_cacheVec,m_localPos,param1);
         }
         while(false);
         
         var _loc6_:Boolean = false;
         if(m_localPos.x + param4 >= 0 && m_localPos.x - param4 <= param2.distanceSquared(param1))
         {
            if(Math.abs(m_localPos.y) < param4)
            {
               _loc7_ = m_localPos.x;
               _loc8_ = m_localPos.y;
               if((_loc9_ = _loc7_ - Math.sqrt(param4 * param4 - _loc8_ * _loc8_)) <= 0)
               {
                  _loc9_ = _loc7_ + Math.sqrt(param4 * param4 - _loc8_ * _loc8_);
               }
               _loc6_ = true;
               do
               {
                  m_cacheVec.multiply(_loc9_);
                  m_cacheVec.add(param1);
               }
               while(false);
               
               param5 = m_cacheVec;
            }
         }
         return _loc6_;
      }
      
      public static function rayBoxIntersect(param1:cVector2, param2:cVector2, param3:Rectangle) : Boolean
      {
         m_box1.set(param3.x,param3.y);
         m_box2.set(param3.x + param3.width,param3.y + param3.height);
         m_cacheVec.set(m_box2.x,m_box1.y);
         if(rayRayIntersect(param1,param2,m_box1,m_cacheVec))
         {
            return true;
         }
         m_cacheVec.set(m_box1.x,m_box2.y);
         if(rayRayIntersect(param1,param2,m_box1,m_cacheVec))
         {
            return true;
         }
         m_cacheVec.set(m_box2.x,m_box1.y);
         if(rayRayIntersect(param1,param2,m_box2,m_cacheVec))
         {
            return true;
         }
         m_cacheVec.set(m_box1.x,m_box2.y);
         if(rayRayIntersect(param1,param2,m_box2,m_cacheVec))
         {
            return true;
         }
         return false;
      }
      
      public static function rayRayIntersect(param1:cVector2, param2:cVector2, param3:cVector2, param4:cVector2) : Boolean
      {
         var _loc5_:Number = (param4.y - param3.y) * (param2.x - param1.x) - (param4.x - param3.x) * (param2.y - param1.y);
         var _loc6_:Number = (param4.x - param3.x) * (param1.y - param3.y) - (param4.y - param3.y) * (param1.x - param3.x);
         var _loc7_:Number = (param2.x - param1.x) * (param1.y - param3.y) - (param2.y - param1.y) * (param1.x - param3.x);
         if(_loc5_ == 0)
         {
            if(_loc6_ == 0 && _loc7_ == 0)
            {
               return false;
            }
            return false;
         }
         var _loc8_:Number = _loc6_ / _loc5_;
         var _loc9_:Number = _loc7_ / _loc5_;
         if(_loc8_ >= 0 && _loc8_ <= 1 && _loc9_ >= 0 && _loc9_ <= 1)
         {
            return true;
         }
         return false;
      }
      
      public static function pointInPolygon(param1:Array, param2:cVector2) : Boolean
      {
         var _loc3_:* = false;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         if(param1.length < 3)
         {
            return false;
         }
         do
         {
            _loc6_ = Number(param1[param1.length - 1].x);
            _loc7_ = Number(param1[param1.length - 1].y);
         }
         while(false);
         
         var _loc12_:int = 0;
         while(_loc12_ < param1.length)
         {
            _loc4_ = Number(param1[_loc12_].x);
            _loc5_ = Number(param1[_loc12_].y);
            if(_loc4_ > _loc6_)
            {
               _loc8_ = _loc6_;
               _loc10_ = _loc4_;
               _loc9_ = _loc7_;
               _loc11_ = _loc5_;
            }
            else
            {
               _loc8_ = _loc4_;
               _loc10_ = _loc6_;
               _loc9_ = _loc5_;
               _loc11_ = _loc7_;
            }
            if(_loc4_ < param2.x == param2.x <= _loc6_ && (param2.y - _loc9_) * (_loc10_ - _loc8_) < (_loc11_ - _loc9_) * (param2.x - _loc8_))
            {
               _loc3_ = !_loc3_;
            }
            _loc6_ = _loc4_;
            _loc7_ = _loc5_;
            _loc12_++;
         }
         return _loc3_;
      }
   }
}
