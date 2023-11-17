package org.cove.ape
{
   import flash.display.Sprite;
   
   internal class SpringConstraintParticle extends RectangleParticle
   {
       
      
      private var p1:AbstractParticle;
      
      private var p2:AbstractParticle;
      
      private var lambda:Vector2;
      
      private var _rectHeight:Number;
      
      private var avgVelocity:Vector2;
      
      private var rca:Vector2;
      
      private var rcb:Vector2;
      
      private var _rectScale:Number;
      
      internal var parent:SpringConstraint;
      
      private var scaleToLength:Boolean;
      
      private var s:Number;
      
      private var _fixedEndLimit:Number;
      
      public function SpringConstraintParticle(param1:AbstractParticle, param2:AbstractParticle, param3:SpringConstraint, param4:Number, param5:Number, param6:Boolean)
      {
         super(0,0,0,0,0,false);
         this.p1 = param1;
         this.p2 = param2;
         this.lambda = new Vector2(0,0);
         this.avgVelocity = new Vector2(0,0);
         this.parent = param3;
         this.rectScale = param5;
         this.rectHeight = param4;
         this.scaleToLength = param6;
         this.fixedEndLimit = 0;
         this.rca = new Vector2();
         this.rcb = new Vector2();
      }
      
      override public function get fixed() : Boolean
      {
         return this.parent.fixed;
      }
      
      override internal function get invMass() : Number
      {
         if(this.p1.fixed && this.p2.fixed)
         {
            return 0;
         }
         return 1 / ((this.p1.mass + this.p2.mass) / 2);
      }
      
      internal function get rectScale() : Number
      {
         return this._rectScale;
      }
      
      private function setCorners(param1:RectangleParticle, param2:int) : void
      {
         var _loc3_:Number = Number(param1.curr.x);
         var _loc4_:Number = Number(param1.curr.y);
         var _loc5_:Array = param1.axes;
         var _loc6_:Array = param1.extents;
         var _loc7_:Number = _loc5_[0].x * _loc6_[0];
         var _loc8_:Number = _loc5_[0].y * _loc6_[0];
         var _loc9_:Number = _loc5_[1].x * _loc6_[1];
         var _loc10_:Number = _loc5_[1].y * _loc6_[1];
         var _loc11_:Number = _loc7_ - _loc9_;
         var _loc12_:Number = _loc8_ - _loc10_;
         var _loc13_:Number = _loc7_ + _loc9_;
         var _loc14_:Number = _loc8_ + _loc10_;
         if(param2 == 0)
         {
            this.rca.x = _loc3_ - _loc13_;
            this.rca.y = _loc4_ - _loc14_;
            this.rcb.x = _loc3_ + _loc11_;
            this.rcb.y = _loc4_ + _loc12_;
         }
         else if(param2 == 1)
         {
            this.rca.x = _loc3_ + _loc11_;
            this.rca.y = _loc4_ + _loc12_;
            this.rcb.x = _loc3_ + _loc13_;
            this.rcb.y = _loc4_ + _loc14_;
         }
         else if(param2 == 2)
         {
            this.rca.x = _loc3_ + _loc13_;
            this.rca.y = _loc4_ + _loc14_;
            this.rcb.x = _loc3_ - _loc11_;
            this.rcb.y = _loc4_ - _loc12_;
         }
         else if(param2 == 3)
         {
            this.rca.x = _loc3_ - _loc11_;
            this.rca.y = _loc4_ - _loc12_;
            this.rcb.x = _loc3_ - _loc13_;
            this.rcb.y = _loc4_ - _loc14_;
         }
      }
      
      internal function set rectScale(param1:Number) : void
      {
         this._rectScale = param1;
      }
      
      override public function get friction() : Number
      {
         return (this.p1.friction + this.p2.friction) / 2;
      }
      
      override public function init() : void
      {
         var _loc1_:Sprite = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(displayObject != null)
         {
            this.initDisplay();
         }
         else
         {
            _loc1_ = new Sprite();
            this.parent.sprite.addChild(_loc1_);
            _loc1_.name = "inner";
            _loc2_ = this.parent.currLength * this.rectScale;
            _loc3_ = this.rectHeight;
            _loc1_.graphics.clear();
            _loc1_.graphics.lineStyle(this.parent.lineThickness,this.parent.lineColor,this.parent.lineAlpha);
            _loc1_.graphics.beginFill(this.parent.fillColor,this.parent.fillAlpha);
            _loc1_.graphics.drawRect(-_loc2_ / 2,-_loc3_ / 2,_loc2_,_loc3_);
            _loc1_.graphics.endFill();
         }
         this.paint();
      }
      
      override internal function initDisplay() : void
      {
         displayObject.x = displayObjectOffset.x;
         displayObject.y = displayObjectOffset.y;
         displayObject.rotation = displayObjectRotation;
         var _loc1_:Sprite = new Sprite();
         _loc1_.name = "inner";
         _loc1_.addChild(displayObject);
         this.parent.sprite.addChild(_loc1_);
      }
      
      internal function set rectHeight(param1:Number) : void
      {
         this._rectHeight = param1;
      }
      
      internal function updatePosition() : void
      {
         var _loc1_:Vector2 = this.parent.center;
         curr.setTo(_loc1_.x,_loc1_.y);
         width = this.scaleToLength ? this.parent.currLength * this.rectScale : this.parent.restLength * this.rectScale;
         height = this.rectHeight;
         radian = this.parent.radian;
      }
      
      override public function get velocity() : Vector2
      {
         var _loc1_:Vector2 = this.p1.velocity;
         var _loc2_:Vector2 = this.p2.velocity;
         this.avgVelocity.setTo((_loc1_.x + _loc2_.x) / 2,(_loc1_.y + _loc2_.y) / 2);
         return this.avgVelocity;
      }
      
      override public function paint() : void
      {
         var _loc1_:Vector2 = this.parent.center;
         var _loc2_:Sprite = this.parent.sprite;
         if(this.scaleToLength)
         {
            _loc2_.getChildByName("inner").width = this.parent.currLength * this.rectScale;
         }
         else if(displayObject != null)
         {
            _loc2_.getChildByName("inner").width = this.parent.restLength * this.rectScale;
         }
         _loc2_.x = _loc1_.x;
         _loc2_.y = _loc1_.y;
         _loc2_.rotation = this.parent.angle;
      }
      
      private function getContactPointParam(param1:AbstractParticle) : Number
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Array = null;
         var _loc5_:Number = NaN;
         var _loc6_:int = 0;
         var _loc7_:Number = NaN;
         if(param1 is CircleParticle)
         {
            _loc2_ = this.closestParamPoint(param1.curr);
         }
         else if(param1 is RectangleParticle)
         {
            _loc4_ = new Array(4);
            _loc5_ = Number(Number.POSITIVE_INFINITY);
            _loc6_ = 0;
            while(_loc6_ < 4)
            {
               this.setCorners(param1 as RectangleParticle,_loc6_);
               if((_loc7_ = this.closestPtSegmentSegment()) < _loc5_)
               {
                  _loc5_ = _loc7_;
                  _loc3_ = _loc6_;
                  _loc4_[_loc6_] = this.s;
               }
               _loc6_++;
            }
            _loc2_ = Number(_loc4_[_loc3_]);
         }
         return _loc2_;
      }
      
      internal function set fixedEndLimit(param1:Number) : void
      {
         this._fixedEndLimit = param1;
      }
      
      private function closestPtSegmentSegment() : Number
      {
         var _loc8_:Number = NaN;
         var _loc1_:Vector2 = this.p1.curr;
         var _loc2_:Vector2 = this.p2.curr;
         var _loc3_:Vector2 = this.rca;
         var _loc4_:Vector2 = this.rcb;
         var _loc5_:Vector2 = _loc2_.minus(_loc1_);
         var _loc6_:Vector2 = _loc4_.minus(_loc3_);
         var _loc7_:Vector2 = _loc1_.minus(_loc3_);
         var _loc9_:Number = _loc5_.dot(_loc5_);
         var _loc10_:Number = _loc6_.dot(_loc6_);
         var _loc11_:Number = _loc6_.dot(_loc7_);
         var _loc12_:Number = _loc5_.dot(_loc7_);
         var _loc13_:Number = _loc5_.dot(_loc6_);
         var _loc14_:Number;
         if((_loc14_ = _loc9_ * _loc10_ - _loc13_ * _loc13_) != 0)
         {
            this.s = MathUtil.clamp((_loc13_ * _loc11_ - _loc12_ * _loc10_) / _loc14_,0,1);
         }
         else
         {
            this.s = 0.5;
         }
         if((_loc8_ = (_loc13_ * this.s + _loc11_) / _loc10_) < 0)
         {
            _loc8_ = 0;
            this.s = MathUtil.clamp(-_loc12_ / _loc9_,0,1);
         }
         else if(_loc8_ > 0)
         {
            _loc8_ = 1;
            this.s = MathUtil.clamp((_loc13_ - _loc12_) / _loc9_,0,1);
         }
         var _loc15_:Vector2 = _loc1_.plus(_loc5_.mult(this.s));
         var _loc16_:Vector2 = _loc3_.plus(_loc6_.mult(_loc8_));
         var _loc17_:Vector2 = _loc15_.minus(_loc16_);
         return _loc17_.dot(_loc17_);
      }
      
      override internal function resolveCollision(param1:Vector2, param2:Vector2, param3:Vector2, param4:Number, param5:int, param6:AbstractParticle) : void
      {
         var _loc10_:Number = NaN;
         var _loc11_:AbstractParticle = null;
         testParticleEvents(param6);
         if(this.fixed || !param6.solid)
         {
            return;
         }
         var _loc7_:Number = this.getContactPointParam(param6);
         var _loc8_:Number = 1 - _loc7_;
         var _loc9_:Number = _loc7_;
         if(this.p1.fixed)
         {
            if(_loc9_ <= this.fixedEndLimit)
            {
               return;
            }
            this.lambda.setTo(param1.x / _loc9_,param1.y / _loc9_);
            this.p2.curr.plusEquals(this.lambda);
            this.p2.velocity = param2;
         }
         else if(this.p2.fixed)
         {
            if(_loc8_ <= this.fixedEndLimit)
            {
               return;
            }
            this.lambda.setTo(param1.x / _loc8_,param1.y / _loc8_);
            this.p1.curr.plusEquals(this.lambda);
            this.p1.velocity = param2;
         }
         else
         {
            if((_loc10_ = _loc8_ * _loc8_ + _loc9_ * _loc9_) == 0)
            {
               return;
            }
            this.lambda.setTo(param1.x / _loc10_,param1.y / _loc10_);
            this.p1.curr.plusEquals(this.lambda.mult(_loc8_));
            this.p2.curr.plusEquals(this.lambda.mult(_loc9_));
            if(_loc7_ == 0.5)
            {
               this.p1.velocity = param2;
               this.p2.velocity = param2;
            }
            else
            {
               (_loc11_ = _loc7_ < 0.5 ? this.p1 : this.p2).velocity = param2;
            }
         }
      }
      
      internal function get rectHeight() : Number
      {
         return this._rectHeight;
      }
      
      internal function get fixedEndLimit() : Number
      {
         return this._fixedEndLimit;
      }
      
      override public function get elasticity() : Number
      {
         return (this.p1.elasticity + this.p2.elasticity) / 2;
      }
      
      override public function get mass() : Number
      {
         return (this.p1.mass + this.p2.mass) / 2;
      }
      
      private function closestParamPoint(param1:Vector2) : Number
      {
         var _loc2_:Vector2 = this.p2.curr.minus(this.p1.curr);
         var _loc3_:Number = _loc2_.dot(param1.minus(this.p1.curr)) / _loc2_.dot(_loc2_);
         return MathUtil.clamp(_loc3_,0,1);
      }
   }
}
