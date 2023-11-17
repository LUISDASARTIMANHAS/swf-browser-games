package org.cove.ape
{
   internal class CollisionDetector
   {
      
      private static var hp:Vector2 = new Vector2();
      
      private static var cpa:AbstractParticle;
      
      private static var hitpoint:Array = new Array();
      
      private static var cpb:AbstractParticle;
      
      private static var collNormal:Vector2;
      
      private static var collDepth:Number;
       
      
      public function CollisionDetector()
      {
         super();
      }
      
      private static function closestVertexOnOBB(param1:Vector2, param2:*) : Vector2
      {
         var _loc6_:Number = NaN;
         var _loc3_:Vector2 = param1.minus(param2.samp);
         var _loc4_:Vector2 = new Vector2(param2.samp.x,param2.samp.y);
         var _loc5_:int = 0;
         while(_loc5_ < 2)
         {
            if((_loc6_ = _loc3_.dot(param2.axes[_loc5_])) >= 0)
            {
               _loc6_ = Number(param2.extents[_loc5_]);
            }
            else if(_loc6_ < 0)
            {
               _loc6_ = -param2.extents[_loc5_];
            }
            _loc4_.plusEquals(param2.axes[_loc5_].mult(_loc6_));
            _loc5_++;
         }
         return _loc4_;
      }
      
      private static function testTypes(param1:AbstractParticle, param2:AbstractParticle) : Boolean
      {
         if(!collisionIsPossible(param1,param2))
         {
            return false;
         }
         if(param1 is RigidItem && param2 is RigidItem)
         {
            testTypes2(RigidItem(param1),RigidItem(param2));
            return false;
         }
         if(param1 is RectangleParticle && param2 is RectangleParticle)
         {
            return testOBBvsOBB(param1,param2);
         }
         if(param1 is CircleParticle && param2 is CircleParticle)
         {
            return testCirclevsCircle(param1,param2);
         }
         if(param1 is RectangleParticle && param2 is CircleParticle)
         {
            return testOBBvsCircle(param1,param2);
         }
         if(param1 is CircleParticle && param2 is RectangleParticle)
         {
            return testOBBvsCircle(param2,param1);
         }
         return false;
      }
      
      private static function testTypes2(param1:RigidItem, param2:RigidItem) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         hitpoint = [];
         if(param1 is RigidRectangle && param2 is RigidRectangle)
         {
            _loc3_ = testOBBvsOBB(param1,param2);
            if(_loc3_)
            {
               _loc4_ = findHitPointRR(param1 as RigidRectangle,param2 as RigidRectangle);
            }
         }
         else if(param1 is RigidCircle && param2 is RigidCircle)
         {
            _loc3_ = testCirclevsCircle(param1,param2);
            if(_loc3_)
            {
               _loc4_ = findHitPointCC(param1 as RigidCircle,param2 as RigidCircle);
            }
         }
         else if(param1 is RigidRectangle && param2 is RigidCircle)
         {
            _loc3_ = testOBBvsCircle(param1,param2);
            if(_loc3_)
            {
               _loc4_ = findHitPointRC(param1 as RigidRectangle,param2 as RigidCircle);
            }
         }
         else if(param1 is RigidCircle && param2 is RigidRectangle)
         {
            _loc3_ = testOBBvsCircle(param2,param1);
            if(_loc3_)
            {
               if(_loc4_ = findHitPointRC(param2 as RigidRectangle,param1 as RigidCircle))
               {
                  getHP();
                  RigidCollisionResolver.resolve(param2,param1,hp,collNormal,collDepth);
                  return false;
               }
            }
         }
         if(_loc4_)
         {
            getHP();
            RigidCollisionResolver.resolve(param1,param2,hp,collNormal,collDepth);
            return false;
         }
         return _loc3_;
      }
      
      private static function collisionIsPossible(param1:AbstractParticle, param2:AbstractParticle) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc4_:Number = param1.maxRadiusSquared + param1.velocityMagnitudeSquared;
         var _loc5_:Number = param2.maxRadiusSquared + param2.velocityMagnitudeSquared;
         var _loc7_:Number;
         var _loc6_:Vector2;
         return (_loc7_ = (_loc6_ = param2.getCurrentPosition().minus(param1.getCurrentPosition())).x * _loc6_.x + _loc6_.y * _loc6_.y) < _loc4_ + _loc5_;
      }
      
      internal static function findHitPointRC(param1:RigidRectangle, param2:RigidCircle) : Boolean
      {
         var _loc3_:Boolean = false;
         if(captures(param2,param1.getVertices()))
         {
            _loc3_ = true;
         }
         if(captures(param1,param2.getVertices(param1.getNormals())))
         {
            _loc3_ = true;
         }
         return _loc3_;
      }
      
      internal static function test(param1:AbstractParticle, param2:AbstractParticle) : void
      {
         if(param1.fixed && param2.fixed)
         {
            return;
         }
         if(param1.multisample == 0 && param2.multisample == 0)
         {
            normVsNorm(param1,param2);
         }
         else if(param1.multisample > 0 && param2.multisample == 0)
         {
            sampVsNorm(param1,param2);
         }
         else if(param2.multisample > 0 && param1.multisample == 0)
         {
            sampVsNorm(param2,param1);
         }
         else if(param1.multisample == param2.multisample)
         {
            sampVsSamp(param1,param2);
         }
         else
         {
            normVsNorm(param1,param2);
         }
      }
      
      private static function testOBBvsOBB(param1:*, param2:*) : Boolean
      {
         var _loc4_:Vector2 = null;
         var _loc5_:Number = NaN;
         var _loc6_:Vector2 = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:* = false;
         collDepth = Number.POSITIVE_INFINITY;
         var _loc3_:int = 0;
         while(_loc3_ < 2)
         {
            _loc4_ = param1.axes[_loc3_];
            if((_loc5_ = testIntervals(param1.getProjection(_loc4_),param2.getProjection(_loc4_))) == 0)
            {
               return false;
            }
            _loc6_ = param2.axes[_loc3_];
            if((_loc7_ = testIntervals(param1.getProjection(_loc6_),param2.getProjection(_loc6_))) == 0)
            {
               return false;
            }
            _loc8_ = Number(Math.abs(_loc5_));
            _loc9_ = Number(Math.abs(_loc7_));
            if(_loc8_ < Math.abs(collDepth) || _loc9_ < Math.abs(collDepth))
            {
               _loc10_ = _loc8_ < _loc9_;
               collNormal = _loc10_ ? _loc4_ : _loc6_;
               collDepth = _loc10_ ? _loc5_ : _loc7_;
            }
            _loc3_++;
         }
         cpa = param1;
         cpb = param2;
         return true;
      }
      
      internal static function findHitPointRR(param1:RigidRectangle, param2:RigidRectangle) : Boolean
      {
         var _loc3_:Boolean = false;
         if(captures(param1,param2.getVertices()))
         {
            _loc3_ = true;
         }
         if(captures(param2,param1.getVertices()))
         {
            _loc3_ = true;
         }
         return _loc3_;
      }
      
      private static function testIntervals(param1:Interval, param2:Interval) : Number
      {
         if(param1.max < param2.min)
         {
            return 0;
         }
         if(param2.max < param1.min)
         {
            return 0;
         }
         var _loc3_:Number = param2.max - param1.min;
         var _loc4_:Number = param2.min - param1.max;
         return Math.abs(_loc3_) < Math.abs(_loc4_) ? _loc3_ : _loc4_;
      }
      
      internal static function getHP() : void
      {
         hp = new Vector2();
         var _loc1_:* = 0;
         while(_loc1_ < hitpoint.length)
         {
            hp.plusEquals(hitpoint[_loc1_]);
            _loc1_++;
         }
         if(hitpoint.length > 1)
         {
            hp.multEquals(1 / hitpoint.length);
         }
      }
      
      private static function sampVsSamp(param1:AbstractParticle, param2:AbstractParticle) : void
      {
         if(normVsNorm(param1,param2))
         {
            return;
         }
         var _loc3_:Number = 1 / (param1.multisample + 1);
         var _loc4_:Number = _loc3_;
         var _loc5_:int = 0;
         while(_loc5_ <= param1.multisample)
         {
            param1.samp.setTo(param1.prev.x + _loc4_ * (param1.curr.x - param1.prev.x),param1.prev.y + _loc4_ * (param1.curr.y - param1.prev.y));
            param2.samp.setTo(param2.prev.x + _loc4_ * (param2.curr.x - param2.prev.x),param2.prev.y + _loc4_ * (param2.curr.y - param2.prev.y));
            if(testTypes(param1,param2))
            {
               CollisionResolver.resolve(cpa,cpb,collNormal,collDepth);
               return;
            }
            _loc4_ += _loc3_;
            _loc5_++;
         }
      }
      
      private static function sampVsNorm(param1:AbstractParticle, param2:AbstractParticle) : void
      {
         if(normVsNorm(param1,param2))
         {
            return;
         }
         var _loc3_:Number = 1 / (param1.multisample + 1);
         var _loc4_:Number = _loc3_;
         var _loc5_:int = 0;
         while(_loc5_ <= param1.multisample)
         {
            param1.samp.setTo(param1.prev.x + _loc4_ * (param1.curr.x - param1.prev.x),param1.prev.y + _loc4_ * (param1.curr.y - param1.prev.y));
            if(testTypes(param1,param2))
            {
               CollisionResolver.resolve(cpa,cpb,collNormal,collDepth);
               return;
            }
            _loc4_ += _loc3_;
            _loc5_++;
         }
      }
      
      internal static function captures(param1:RigidItem, param2:Array) : *
      {
         var _loc3_:Boolean = false;
         var _loc4_:* = 0;
         while(_loc4_ < param2.length)
         {
            if(param1.captures(param2[_loc4_]))
            {
               hitpoint.push(param2[_loc4_]);
               _loc3_ = true;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      private static function testCirclevsCircle(param1:*, param2:*) : Boolean
      {
         var _loc3_:Number = testIntervals(param1.getIntervalX(),param2.getIntervalX());
         if(_loc3_ == 0)
         {
            return false;
         }
         var _loc4_:Number;
         if((_loc4_ = testIntervals(param1.getIntervalY(),param2.getIntervalY())) == 0)
         {
            return false;
         }
         collNormal = param1.samp.minus(param2.samp);
         var _loc5_:Number = collNormal.magnitude();
         collDepth = param1.radius + param2.radius - _loc5_;
         if(collDepth > 0)
         {
            collNormal.divEquals(_loc5_);
            cpa = param1;
            cpb = param2;
            return true;
         }
         return false;
      }
      
      private static function normVsNorm(param1:AbstractParticle, param2:AbstractParticle) : Boolean
      {
         param1.samp.copy(param1.curr);
         param2.samp.copy(param2.curr);
         if(testTypes(param1,param2))
         {
            CollisionResolver.resolve(cpa,cpb,collNormal,collDepth);
            return true;
         }
         return false;
      }
      
      internal static function findHitPointCC(param1:RigidCircle, param2:RigidCircle) : Boolean
      {
         var _loc3_:Vector2 = param2.samp.minus(param1.samp);
         if(_loc3_.magnitude() <= param1.range + param2.range)
         {
            hitpoint.push(_loc3_.normalize().multEquals(param1.range).plusEquals(param1.samp));
            return true;
         }
         return false;
      }
      
      private static function testOBBvsCircle(param1:*, param2:*) : Boolean
      {
         var _loc6_:Vector2 = null;
         var _loc7_:Number = NaN;
         var _loc8_:Vector2 = null;
         var _loc9_:Number = NaN;
         collDepth = Number.POSITIVE_INFINITY;
         var _loc3_:Array = new Array(2);
         var _loc4_:int = 0;
         while(_loc4_ < 2)
         {
            _loc6_ = param1.axes[_loc4_];
            if((_loc7_ = testIntervals(param1.getProjection(_loc6_),param2.getProjection(_loc6_))) == 0)
            {
               return false;
            }
            if(Math.abs(_loc7_) < Math.abs(collDepth))
            {
               collNormal = _loc6_;
               collDepth = _loc7_;
            }
            _loc3_[_loc4_] = _loc7_;
            _loc4_++;
         }
         var _loc5_:Number = Number(param2.radius);
         if(Math.abs(_loc3_[0]) < _loc5_ && Math.abs(_loc3_[1]) < _loc5_)
         {
            _loc8_ = closestVertexOnOBB(param2.samp,param1);
            collNormal = _loc8_.minus(param2.samp);
            _loc9_ = collNormal.magnitude();
            collDepth = _loc5_ - _loc9_;
            if(collDepth <= 0)
            {
               return false;
            }
            collNormal.divEquals(_loc9_);
         }
         cpa = param1;
         cpb = param2;
         return true;
      }
   }
}
