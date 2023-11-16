package org.flixel
{
   import flash.display.Graphics;
   
   public class FlxObject extends FlxBasic
   {
      
      public static const LEFT:uint = 1;
      
      public static const RIGHT:uint = 16;
      
      public static const UP:uint = 256;
      
      public static const DOWN:uint = 4096;
      
      public static const NONE:uint = 0;
      
      public static const CEILING:uint = UP;
      
      public static const FLOOR:uint = DOWN;
      
      public static const WALL:uint = LEFT | RIGHT;
      
      public static const ANY:uint = LEFT | RIGHT | UP | DOWN;
      
      public static const OVERLAP_BIAS:Number = 4;
      
      public static const PATH_FORWARD:uint = 0;
      
      public static const PATH_BACKWARD:uint = 1;
      
      public static const PATH_LOOP_FORWARD:uint = 16;
      
      public static const PATH_LOOP_BACKWARD:uint = 256;
      
      public static const PATH_YOYO:uint = 4096;
      
      public static const PATH_HORIZONTAL_ONLY:uint = 65536;
      
      public static const PATH_VERTICAL_ONLY:uint = 1048576;
      
      protected static const _pZero:FlxPoint = new FlxPoint();
       
      
      public var x:Number;
      
      public var y:Number;
      
      public var width:Number;
      
      public var height:Number;
      
      public var immovable:Boolean;
      
      public var velocity:FlxPoint;
      
      public var mass:Number;
      
      public var elasticity:Number;
      
      public var acceleration:FlxPoint;
      
      public var drag:FlxPoint;
      
      public var maxVelocity:FlxPoint;
      
      public var angle:Number;
      
      public var angularVelocity:Number;
      
      public var angularAcceleration:Number;
      
      public var angularDrag:Number;
      
      public var maxAngular:Number;
      
      public var scrollFactor:FlxPoint;
      
      protected var _flicker:Boolean;
      
      protected var _flickerTimer:Number;
      
      public var health:Number;
      
      protected var _point:FlxPoint;
      
      protected var _rect:FlxRect;
      
      public var moves:Boolean;
      
      public var touching:uint;
      
      public var wasTouching:uint;
      
      public var allowCollisions:uint;
      
      public var last:FlxPoint;
      
      public var path:FlxPath;
      
      public var pathSpeed:Number;
      
      public var pathAngle:Number;
      
      protected var _pathNodeIndex:int;
      
      protected var _pathMode:uint;
      
      protected var _pathInc:int;
      
      protected var _pathRotate:Boolean;
      
      public function FlxObject(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0)
      {
         super();
         this.x = param1;
         this.y = param2;
         this.last = new FlxPoint(this.x,this.y);
         this.width = param3;
         this.height = param4;
         this.mass = 1;
         this.elasticity = 0;
         this.immovable = false;
         this.moves = true;
         this.touching = NONE;
         this.wasTouching = NONE;
         this.allowCollisions = ANY;
         this.velocity = new FlxPoint();
         this.acceleration = new FlxPoint();
         this.drag = new FlxPoint();
         this.maxVelocity = new FlxPoint(10000,10000);
         this.angle = 0;
         this.angularVelocity = 0;
         this.angularAcceleration = 0;
         this.angularDrag = 0;
         this.maxAngular = 10000;
         this.scrollFactor = new FlxPoint(1,1);
         this._flicker = false;
         this._flickerTimer = 0;
         this._point = new FlxPoint();
         this._rect = new FlxRect();
         this.path = null;
         this.pathSpeed = 0;
         this.pathAngle = 0;
      }
      
      public static function separate(param1:FlxObject, param2:FlxObject) : Boolean
      {
         var _loc3_:Boolean = separateX(param1,param2);
         var _loc4_:Boolean = separateY(param1,param2);
         return _loc3_ || _loc4_;
      }
      
      public static function separateX(param1:FlxObject, param2:FlxObject) : Boolean
      {
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:FlxRect = null;
         var _loc11_:FlxRect = null;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc3_:Boolean = param1.immovable;
         var _loc4_:Boolean = param2.immovable;
         if(_loc3_ && _loc4_)
         {
            return false;
         }
         if(param1 is FlxTilemap)
         {
            return (param1 as FlxTilemap).overlapsWithCallback(param2,separateX);
         }
         if(param2 is FlxTilemap)
         {
            return (param2 as FlxTilemap).overlapsWithCallback(param1,separateX,true);
         }
         var _loc5_:Number = 0;
         var _loc6_:Number = param1.x - param1.last.x;
         var _loc7_:Number = param2.x - param2.last.x;
         if(_loc6_ != _loc7_)
         {
            _loc8_ = _loc6_ > 0 ? _loc6_ : -_loc6_;
            _loc9_ = _loc7_ > 0 ? _loc7_ : -_loc7_;
            _loc10_ = new FlxRect(param1.x - (_loc6_ > 0 ? _loc6_ : 0),param1.last.y,param1.width + (_loc6_ > 0 ? _loc6_ : -_loc6_),param1.height);
            _loc11_ = new FlxRect(param2.x - (_loc7_ > 0 ? _loc7_ : 0),param2.last.y,param2.width + (_loc7_ > 0 ? _loc7_ : -_loc7_),param2.height);
            if(_loc10_.x + _loc10_.width > _loc11_.x && _loc10_.x < _loc11_.x + _loc11_.width && _loc10_.y + _loc10_.height > _loc11_.y && _loc10_.y < _loc11_.y + _loc11_.height)
            {
               _loc12_ = _loc8_ + _loc9_ + OVERLAP_BIAS;
               if(_loc6_ > _loc7_)
               {
                  if((_loc5_ = param1.x + param1.width - param2.x) > _loc12_ || !(param1.allowCollisions & RIGHT) || !(param2.allowCollisions & LEFT))
                  {
                     _loc5_ = 0;
                  }
                  else
                  {
                     param1.touching |= RIGHT;
                     param2.touching |= LEFT;
                  }
               }
               else if(_loc6_ < _loc7_)
               {
                  if(-(_loc5_ = param1.x - param2.width - param2.x) > _loc12_ || !(param1.allowCollisions & LEFT) || !(param2.allowCollisions & RIGHT))
                  {
                     _loc5_ = 0;
                     addr200:
                  }
                  else
                  {
                     param1.touching |= LEFT;
                     param2.touching |= RIGHT;
                     if(false)
                     {
                        §§goto(addr200);
                     }
                  }
               }
            }
         }
         if(_loc5_ != 0)
         {
            _loc13_ = param1.velocity.x;
            _loc14_ = param2.velocity.x;
            if(!_loc3_ && !_loc4_)
            {
               _loc5_ *= 0.5;
               param1.x -= _loc5_;
               param2.x += _loc5_;
               _loc15_ = Math.sqrt(_loc14_ * _loc14_ * param2.mass / param1.mass) * (_loc14_ > 0 ? 1 : -1);
               _loc16_ = Math.sqrt(_loc13_ * _loc13_ * param1.mass / param2.mass) * (_loc13_ > 0 ? 1 : -1);
               _loc17_ = (_loc15_ + _loc16_) * 0.5;
               _loc15_ -= _loc17_;
               _loc16_ -= _loc17_;
               param1.velocity.x = _loc17_ + _loc15_ * param1.elasticity;
               param2.velocity.x = _loc17_ + _loc16_ * param2.elasticity;
            }
            else if(!_loc3_)
            {
               param1.x -= _loc5_;
               param1.velocity.x = _loc14_ - _loc13_ * param1.elasticity;
            }
            else if(!_loc4_)
            {
               param2.x += _loc5_;
               param2.velocity.x = _loc13_ - _loc14_ * param2.elasticity;
            }
            return true;
         }
         return false;
      }
      
      public static function separateY(param1:FlxObject, param2:FlxObject) : Boolean
      {
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:FlxRect = null;
         var _loc11_:FlxRect = null;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc3_:Boolean = param1.immovable;
         var _loc4_:Boolean = param2.immovable;
         if(_loc3_ && _loc4_)
         {
            return false;
         }
         if(param1 is FlxTilemap)
         {
            return (param1 as FlxTilemap).overlapsWithCallback(param2,separateY);
         }
         if(param2 is FlxTilemap)
         {
            return (param2 as FlxTilemap).overlapsWithCallback(param1,separateY,true);
         }
         var _loc5_:Number = 0;
         var _loc6_:Number = param1.y - param1.last.y;
         _loc7_ = param2.y - param2.last.y;
         while(_loc6_ != _loc7_)
         {
            _loc8_ = _loc6_ > 0 ? _loc6_ : -_loc6_;
            _loc9_ = _loc7_ > 0 ? _loc7_ : -_loc7_;
            if(true)
            {
               _loc10_ = new FlxRect(param1.x,param1.y - (_loc6_ > 0 ? _loc6_ : 0),param1.width,param1.height + _loc8_);
               _loc11_ = new FlxRect(param2.x,param2.y - (_loc7_ > 0 ? _loc7_ : 0),param2.width,param2.height + _loc9_);
               if(_loc10_.x + _loc10_.width > _loc11_.x && _loc10_.x < _loc11_.x + _loc11_.width && _loc10_.y + _loc10_.height > _loc11_.y && _loc10_.y < _loc11_.y + _loc11_.height)
               {
                  _loc12_ = _loc8_ + _loc9_ + OVERLAP_BIAS;
                  if(_loc6_ > _loc7_)
                  {
                     if((_loc5_ = param1.y + param1.height - param2.y) > _loc12_ || !(param1.allowCollisions & DOWN) || !(param2.allowCollisions & UP))
                     {
                        _loc5_ = 0;
                     }
                     else
                     {
                        param1.touching |= DOWN;
                        param2.touching |= UP;
                     }
                     break;
                  }
                  if(_loc6_ < _loc7_)
                  {
                     if(!(-(_loc5_ = param1.y - param2.height - param2.y) > _loc12_ || !(param1.allowCollisions & UP) || !(param2.allowCollisions & DOWN)))
                     {
                        param1.touching |= UP;
                        param2.touching |= DOWN;
                        if(false)
                        {
                        }
                        break;
                     }
                     _loc5_ = 0;
                     break;
                  }
                  break;
               }
               break;
            }
         }
         if(_loc5_ != 0)
         {
            _loc13_ = param1.velocity.y;
            _loc14_ = param2.velocity.y;
            if(!_loc3_ && !_loc4_)
            {
               _loc5_ *= 0.5;
               param1.y -= _loc5_;
               param2.y += _loc5_;
               _loc15_ = Math.sqrt(_loc14_ * _loc14_ * param2.mass / param1.mass) * (_loc14_ > 0 ? 1 : -1);
               _loc16_ = Math.sqrt(_loc13_ * _loc13_ * param1.mass / param2.mass) * (_loc13_ > 0 ? 1 : -1);
               _loc17_ = (_loc15_ + _loc16_) * 0.5;
               _loc15_ -= _loc17_;
               _loc16_ -= _loc17_;
               param1.velocity.y = _loc17_ + _loc15_ * param1.elasticity;
               param2.velocity.y = _loc17_ + _loc16_ * param2.elasticity;
            }
            else if(!_loc3_)
            {
               param1.y -= _loc5_;
               param1.velocity.y = _loc14_ - _loc13_ * param1.elasticity;
               if(param2.active && param2.moves && _loc6_ > _loc7_)
               {
                  param1.x += param2.x - param2.last.x;
               }
            }
            else if(!_loc4_)
            {
               param2.y += _loc5_;
               param2.velocity.y = _loc13_ - _loc14_ * param2.elasticity;
               if(param1.active && param1.moves && _loc6_ < _loc7_)
               {
                  param2.x += param1.x - param1.last.x;
               }
            }
            return true;
         }
         return false;
      }
      
      override public function destroy() : void
      {
         this.velocity = null;
         this.acceleration = null;
         this.drag = null;
         this.maxVelocity = null;
         this.scrollFactor = null;
         this._point = null;
         this._rect = null;
         this.last = null;
         cameras = null;
         if(this.path != null)
         {
            this.path.destroy();
         }
         this.path = null;
      }
      
      override public function preUpdate() : void
      {
         ++_ACTIVECOUNT;
         if(this._flickerTimer != 0)
         {
            if(this._flickerTimer > 0)
            {
               this._flickerTimer -= FlxG.elapsed;
               if(this._flickerTimer <= 0)
               {
                  this._flickerTimer = 0;
                  this._flicker = false;
               }
            }
         }
         this.last.x = this.x;
         this.last.y = this.y;
         if(this.path != null && this.pathSpeed != 0 && this.path.nodes[this._pathNodeIndex] != null)
         {
            this.updatePathMotion();
         }
      }
      
      override public function postUpdate() : void
      {
         if(this.moves)
         {
            this.updateMotion();
         }
         this.wasTouching = this.touching;
         this.touching = NONE;
      }
      
      protected function updateMotion() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         _loc2_ = (FlxU.computeVelocity(this.angularVelocity,this.angularAcceleration,this.angularDrag,this.maxAngular) - this.angularVelocity) / 2;
         this.angularVelocity += _loc2_;
         this.angle += this.angularVelocity * FlxG.elapsed;
         this.angularVelocity += _loc2_;
         _loc2_ = (FlxU.computeVelocity(this.velocity.x,this.acceleration.x,this.drag.x,this.maxVelocity.x) - this.velocity.x) / 2;
         this.velocity.x += _loc2_;
         _loc1_ = this.velocity.x * FlxG.elapsed;
         this.velocity.x += _loc2_;
         this.x += _loc1_;
         _loc2_ = (FlxU.computeVelocity(this.velocity.y,this.acceleration.y,this.drag.y,this.maxVelocity.y) - this.velocity.y) / 2;
         this.velocity.y += _loc2_;
         _loc1_ = this.velocity.y * FlxG.elapsed;
         this.velocity.y += _loc2_;
         this.y += _loc1_;
      }
      
      override public function draw() : void
      {
         var _loc1_:FlxCamera = null;
         if(cameras == null)
         {
            cameras = FlxG.cameras;
         }
         var _loc2_:uint = 0;
         var _loc3_:uint = uint(cameras.length);
         while(_loc2_ < _loc3_)
         {
            _loc1_ = cameras[_loc2_++];
            if(this.onScreen(_loc1_))
            {
               ++_VISIBLECOUNT;
               if(FlxG.visualDebug && !ignoreDrawDebug)
               {
                  this.drawDebug(_loc1_);
               }
            }
         }
      }
      
      override public function drawDebug(param1:FlxCamera = null) : void
      {
         var _loc7_:uint = 0;
         if(param1 == null)
         {
            param1 = FlxG.camera;
         }
         var _loc2_:Number = this.x - int(param1.scroll.x * this.scrollFactor.x);
         var _loc3_:Number = this.y - int(param1.scroll.y * this.scrollFactor.y);
         _loc2_ = Number(int(_loc2_ + (_loc2_ > 0 ? 1e-7 : -1e-7)));
         _loc3_ = Number(int(_loc3_ + (_loc3_ > 0 ? 1e-7 : -1e-7)));
         var _loc4_:int = this.width != int(this.width) ? int(this.width) : int(this.width - 1);
         var _loc5_:int = this.height != int(this.height) ? int(this.height) : int(this.height - 1);
         var _loc6_:Graphics;
         (_loc6_ = FlxG.flashGfx).clear();
         _loc6_.moveTo(_loc2_,_loc3_);
         if(this.allowCollisions)
         {
            if(this.allowCollisions != ANY)
            {
               _loc7_ = FlxG.PINK;
            }
            if(this.immovable)
            {
               _loc7_ = FlxG.GREEN;
            }
            else
            {
               _loc7_ = FlxG.RED;
            }
         }
         else
         {
            _loc7_ = FlxG.BLUE;
         }
         _loc6_.lineStyle(1,_loc7_,0.5);
         _loc6_.lineTo(_loc2_ + _loc4_,_loc3_);
         _loc6_.lineTo(_loc2_ + _loc4_,_loc3_ + _loc5_);
         _loc6_.lineTo(_loc2_,_loc3_ + _loc5_);
         _loc6_.lineTo(_loc2_,_loc3_);
         param1.buffer.draw(FlxG.flashGfxSprite);
      }
      
      public function followPath(param1:FlxPath, param2:Number = 100, param3:uint = 0, param4:Boolean = false) : void
      {
         if(param1.nodes.length <= 0)
         {
            FlxG.log("WARNING: Paths need at least one node in them to be followed.");
            return;
         }
         this.path = param1;
         this.pathSpeed = FlxU.abs(param2);
         this._pathMode = param3;
         this._pathRotate = param4;
         if(this._pathMode == PATH_BACKWARD || this._pathMode == PATH_LOOP_BACKWARD)
         {
            this._pathNodeIndex = this.path.nodes.length - 1;
            this._pathInc = -1;
         }
         else
         {
            this._pathNodeIndex = 0;
            this._pathInc = 1;
         }
      }
      
      public function stopFollowingPath(param1:Boolean = false) : void
      {
         this.pathSpeed = 0;
         if(param1 && this.path != null)
         {
            this.path.destroy();
            this.path = null;
         }
      }
      
      protected function advancePath() : FlxPoint
      {
         var _loc1_:FlxPoint = this.path.nodes[this._pathNodeIndex];
         if(_loc1_ != null)
         {
            if((this._pathMode & PATH_VERTICAL_ONLY) == 0)
            {
               this.x = _loc1_.x - this.width * 0.5;
            }
            if((this._pathMode & PATH_HORIZONTAL_ONLY) == 0)
            {
               this.y = _loc1_.y - this.height * 0.5;
            }
         }
         this._pathNodeIndex += this._pathInc;
         if((this._pathMode & PATH_BACKWARD) > 0)
         {
            if(this._pathNodeIndex < 0)
            {
               this._pathNodeIndex = 0;
               this.pathSpeed = 0;
            }
         }
         else if((this._pathMode & PATH_LOOP_FORWARD) > 0)
         {
            if(this._pathNodeIndex >= this.path.nodes.length)
            {
               this._pathNodeIndex = 0;
            }
         }
         else if((this._pathMode & PATH_LOOP_BACKWARD) > 0)
         {
            if(this._pathNodeIndex < 0)
            {
               this._pathNodeIndex = this.path.nodes.length - 1;
               if(this._pathNodeIndex < 0)
               {
                  this._pathNodeIndex = 0;
               }
            }
         }
         else if((this._pathMode & PATH_YOYO) > 0)
         {
            if(this._pathInc > 0)
            {
               if(this._pathNodeIndex >= this.path.nodes.length)
               {
                  this._pathNodeIndex = this.path.nodes.length - 2;
                  if(this._pathNodeIndex < 0)
                  {
                     this._pathNodeIndex = 0;
                  }
                  this._pathInc = -this._pathInc;
               }
            }
            else if(this._pathNodeIndex < 0)
            {
               this._pathNodeIndex = 1;
               if(this._pathNodeIndex >= this.path.nodes.length)
               {
                  this._pathNodeIndex = this.path.nodes.length - 1;
               }
               if(this._pathNodeIndex < 0)
               {
                  this._pathNodeIndex = 0;
               }
               this._pathInc = -this._pathInc;
            }
         }
         else if(this._pathNodeIndex >= this.path.nodes.length)
         {
            this._pathNodeIndex = this.path.nodes.length - 1;
            this.pathSpeed = 0;
         }
         return this.path.nodes[this._pathNodeIndex];
      }
      
      protected function updatePathMotion() : void
      {
         this._point.x = this.x + this.width * 0.5;
         this._point.y = this.y + this.height * 0.5;
         var _loc1_:FlxPoint = this.path.nodes[this._pathNodeIndex];
         var _loc2_:Number = _loc1_.x - this._point.x;
         var _loc3_:Number = _loc1_.y - this._point.y;
         var _loc4_:* = (this._pathMode & PATH_HORIZONTAL_ONLY) > 0;
         var _loc5_:* = (this._pathMode & PATH_VERTICAL_ONLY) > 0;
         if(_loc4_)
         {
            if((_loc2_ > 0 ? _loc2_ : -_loc2_) < this.pathSpeed * FlxG.elapsed)
            {
               _loc1_ = this.advancePath();
            }
         }
         else if(_loc5_)
         {
            if((_loc3_ > 0 ? _loc3_ : -_loc3_) < this.pathSpeed * FlxG.elapsed)
            {
               _loc1_ = this.advancePath();
            }
         }
         else if(Math.sqrt(_loc2_ * _loc2_ + _loc3_ * _loc3_) < this.pathSpeed * FlxG.elapsed)
         {
            _loc1_ = this.advancePath();
         }
         if(this.pathSpeed != 0)
         {
            this._point.x = this.x + this.width * 0.5;
            this._point.y = this.y + this.height * 0.5;
            if(_loc4_ || this._point.y == _loc1_.y)
            {
               this.velocity.x = this._point.x < _loc1_.x ? this.pathSpeed : -this.pathSpeed;
               if(this.velocity.x < 0)
               {
                  this.pathAngle = -90;
               }
               else
               {
                  this.pathAngle = 90;
               }
               if(!_loc4_)
               {
                  this.velocity.y = 0;
               }
            }
            else if(_loc5_ || this._point.x == _loc1_.x)
            {
               this.velocity.y = this._point.y < _loc1_.y ? this.pathSpeed : -this.pathSpeed;
               if(this.velocity.y < 0)
               {
                  this.pathAngle = 0;
               }
               else
               {
                  this.pathAngle = 180;
               }
               if(!_loc5_)
               {
                  this.velocity.x = 0;
               }
            }
            else
            {
               this.pathAngle = FlxU.getAngle(this._point,_loc1_);
               FlxU.rotatePoint(0,this.pathSpeed,0,0,this.pathAngle - 180,this.velocity);
               if(this._pathRotate)
               {
                  this.angularVelocity = 0;
                  this.angularAcceleration = 0;
                  this.angle = this.pathAngle;
               }
            }
         }
      }
      
      public function overlaps(param1:FlxObject, param2:Boolean = false, param3:FlxCamera = null) : Boolean
      {
         if(!param2)
         {
            return param1.x + param1.width > this.x && param1.x < this.x + this.width && param1.y + param1.height > this.y && param1.y < this.y + this.height;
         }
         if(param3 == null)
         {
            param3 = FlxG.camera;
         }
         var _loc4_:FlxPoint = param1.getScreenXY(null,param3);
         this.getScreenXY(this._point,param3);
         return _loc4_.x + param1.width > this._point.x && _loc4_.x < this._point.x + this.width && _loc4_.y + param1.height > this._point.y && _loc4_.y < this._point.y + this.height;
      }
      
      public function overlapsPoint(param1:FlxPoint, param2:Boolean = false, param3:FlxCamera = null) : Boolean
      {
         if(!param2)
         {
            return param1.x > this.x && param1.x < this.x + this.width && param1.y > this.y && param1.y < this.y + this.height;
         }
         if(param3 == null)
         {
            param3 = FlxG.camera;
         }
         var _loc4_:Number = param1.x - param3.scroll.x;
         var _loc5_:Number = param1.y - param3.scroll.y;
         this.getScreenXY(this._point,param3);
         return _loc4_ > this._point.x && _loc4_ < this._point.x + this.width && _loc5_ > this._point.y && _loc5_ < this._point.y + this.height;
      }
      
      public function onScreen(param1:FlxCamera = null) : Boolean
      {
         if(param1 == null)
         {
            param1 = FlxG.camera;
         }
         this.getScreenXY(this._point,param1);
         return this._point.x + this.width > 0 && this._point.x < param1.width && this._point.y + this.height > 0 && this._point.y < param1.height;
      }
      
      public function getScreenXY(param1:FlxPoint = null, param2:FlxCamera = null) : FlxPoint
      {
         if(param1 == null)
         {
            param1 = new FlxPoint();
         }
         if(param2 == null)
         {
            param2 = FlxG.camera;
         }
         param1.x = this.x - int(param2.scroll.x * this.scrollFactor.x);
         param1.y = this.y - int(param2.scroll.y * this.scrollFactor.y);
         param1.x += param1.x > 0 ? 1e-7 : -1e-7;
         param1.y += param1.y > 0 ? 1e-7 : -1e-7;
         return param1;
      }
      
      public function flicker(param1:Number = 1) : void
      {
         this._flickerTimer = param1;
         if(this._flickerTimer == 0)
         {
            this._flicker = false;
         }
      }
      
      public function get flickering() : Boolean
      {
         return this._flickerTimer != 0;
      }
      
      public function get solid() : Boolean
      {
         return (this.allowCollisions & ANY) > NONE;
      }
      
      public function set solid(param1:Boolean) : void
      {
         if(param1)
         {
            this.allowCollisions = ANY;
         }
         else
         {
            this.allowCollisions = NONE;
         }
      }
      
      public function getMidpoint(param1:FlxPoint = null) : FlxPoint
      {
         if(param1 == null)
         {
            param1 = new FlxPoint();
         }
         param1.x = this.x + this.width * 0.5;
         param1.y = this.y + this.height * 0.5;
         return param1;
      }
      
      public function reset(param1:Number, param2:Number) : void
      {
         revive();
         this.touching = NONE;
         this.wasTouching = NONE;
         this.x = param1;
         this.y = param2;
         this.last.x = this.x;
         this.last.y = this.y;
         this.velocity.x = 0;
         this.velocity.y = 0;
      }
      
      public function isTouching(param1:uint) : Boolean
      {
         return (this.touching & param1) > NONE;
      }
      
      public function justTouched(param1:uint) : Boolean
      {
         return (this.touching & param1) > NONE && (this.wasTouching & param1) <= NONE;
      }
      
      public function hurt(param1:Number) : void
      {
         this.health -= param1;
         if(this.health <= 0)
         {
            kill();
         }
      }
   }
}
