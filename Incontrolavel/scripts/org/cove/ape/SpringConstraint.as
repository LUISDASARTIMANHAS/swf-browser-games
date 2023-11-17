package org.cove.ape
{
   import flash.display.DisplayObject;
   
   public class SpringConstraint extends AbstractConstraint
   {
       
      
      private var _collidable:Boolean;
      
      private var p1:AbstractParticle;
      
      private var p2:AbstractParticle;
      
      private var _scp:SpringConstraintParticle;
      
      private var _restLength:Number;
      
      public function SpringConstraint(param1:AbstractParticle, param2:AbstractParticle, param3:Number = 0.5, param4:Boolean = false, param5:Number = 1, param6:Number = 1, param7:Boolean = false)
      {
         super(param3);
         this.p1 = param1;
         this.p2 = param2;
         this.checkParticlesLocation();
         this._restLength = this.currLength;
         this.setCollidable(param4,param5,param6,param7);
      }
      
      public function get fixed() : Boolean
      {
         return this.p1.fixed && this.p2.fixed;
      }
      
      public function get rectScale() : Number
      {
         return this.scp.rectScale;
      }
      
      public function set rectScale(param1:Number) : void
      {
         if(this.scp == null)
         {
            return;
         }
         this.scp.rectScale = param1;
      }
      
      public function setDisplay(param1:DisplayObject, param2:Number = 0, param3:Number = 0, param4:Number = 0) : void
      {
         if(this.collidable)
         {
            this.scp.setDisplay(param1,param2,param3,param4);
         }
         else
         {
            displayObject = param1;
            displayObjectRotation = param4;
            displayObjectOffset = new Vector2(param2,param3);
         }
      }
      
      override public function init() : void
      {
         cleanup();
         if(this.collidable)
         {
            this.scp.init();
         }
         else if(displayObject != null)
         {
            this.initDisplay();
         }
         this.paint();
      }
      
      internal function initDisplay() : void
      {
         if(this.collidable)
         {
            this.scp.initDisplay();
         }
         else
         {
            displayObject.x = displayObjectOffset.x;
            displayObject.y = displayObjectOffset.y;
            displayObject.rotation = displayObjectRotation;
            sprite.addChild(displayObject);
         }
      }
      
      public function get angle() : Number
      {
         return this.radian * MathUtil.ONE_EIGHTY_OVER_PI;
      }
      
      public function get center() : Vector2
      {
         return this.p1.curr.plus(this.p2.curr).divEquals(2);
      }
      
      public function set rectHeight(param1:Number) : void
      {
         if(this.scp == null)
         {
            return;
         }
         this.scp.rectHeight = param1;
      }
      
      public function get restLength() : Number
      {
         return this._restLength;
      }
      
      override public function paint() : void
      {
         var _loc1_:Vector2 = null;
         if(this.collidable)
         {
            this.scp.paint();
         }
         else if(displayObject != null)
         {
            _loc1_ = this.center;
            sprite.x = _loc1_.x;
            sprite.y = _loc1_.y;
            sprite.rotation = this.angle;
         }
         else
         {
            sprite.graphics.clear();
            sprite.graphics.lineStyle(lineThickness,lineColor,lineAlpha);
            sprite.graphics.moveTo(this.p1.px,this.p1.py);
            sprite.graphics.lineTo(this.p2.px,this.p2.py);
         }
      }
      
      internal function get scp() : SpringConstraintParticle
      {
         return this._scp;
      }
      
      public function get collidable() : Boolean
      {
         return this._collidable;
      }
      
      public function setCollidable(param1:Boolean, param2:Number, param3:Number, param4:Boolean = false) : void
      {
         this._collidable = param1;
         this._scp = null;
         if(this._collidable)
         {
            this._scp = new SpringConstraintParticle(this.p1,this.p2,this,param2,param3,param4);
         }
      }
      
      public function isConnectedTo(param1:AbstractParticle) : Boolean
      {
         return param1 == this.p1 || param1 == this.p2;
      }
      
      public function get rectHeight() : Number
      {
         return this.scp.rectHeight;
      }
      
      override public function resolve() : void
      {
         if(this.p1.fixed && this.p2.fixed)
         {
            return;
         }
         var _loc1_:Number = this.currLength;
         var _loc2_:Number = (_loc1_ - this.restLength) / (_loc1_ * (this.p1.invMass + this.p2.invMass));
         var _loc3_:Vector2 = this.delta.mult(_loc2_ * stiffness);
         this.p1.curr.minusEquals(_loc3_.mult(this.p1.invMass));
         this.p2.curr.plusEquals(_loc3_.mult(this.p2.invMass));
      }
      
      public function set fixedEndLimit(param1:Number) : void
      {
         if(this.scp == null)
         {
            return;
         }
         this.scp.fixedEndLimit = param1;
      }
      
      public function get radian() : Number
      {
         var _loc1_:Vector2 = this.delta;
         return Math.atan2(_loc1_.y,_loc1_.x);
      }
      
      public function set restLength(param1:Number) : void
      {
         if(param1 <= 0)
         {
            throw new ArgumentError("restLength must be greater than 0");
         }
         this._restLength = param1;
      }
      
      public function get currLength() : Number
      {
         return this.p1.curr.distance(this.p2.curr);
      }
      
      public function get fixedEndLimit() : Number
      {
         return this.scp.fixedEndLimit;
      }
      
      private function checkParticlesLocation() : void
      {
         if(this.p1.curr.x == this.p2.curr.x && this.p1.curr.y == this.p2.curr.y)
         {
            this.p2.curr.x += 0.0001;
         }
      }
      
      internal function get delta() : Vector2
      {
         return this.p1.curr.minus(this.p2.curr);
      }
   }
}
