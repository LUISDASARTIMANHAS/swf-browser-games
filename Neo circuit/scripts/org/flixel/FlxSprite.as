package org.flixel
{
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import org.flixel.system.FlxAnim;
   
   public class FlxSprite extends FlxObject
   {
       
      
      protected var ImgDefault:Class;
      
      public var origin:FlxPoint;
      
      public var offset:FlxPoint;
      
      public var scale:FlxPoint;
      
      public var blend:String;
      
      public var antialiasing:Boolean;
      
      public var finished:Boolean;
      
      public var frameWidth:uint;
      
      public var frameHeight:uint;
      
      public var frames:uint;
      
      public var framePixels:BitmapData;
      
      public var dirty:Boolean;
      
      protected var _animations:Array;
      
      protected var _flipped:uint;
      
      protected var _curAnim:FlxAnim;
      
      protected var _curFrame:uint;
      
      protected var _curIndex:uint;
      
      protected var _frameTimer:Number;
      
      protected var _callback:Function;
      
      protected var _facing:uint;
      
      protected var _alpha:Number;
      
      protected var _color:uint;
      
      protected var _bakedRotation:Number;
      
      protected var _pixels:BitmapData;
      
      protected var _flashPoint:Point;
      
      protected var _flashRect:Rectangle;
      
      protected var _flashRect2:Rectangle;
      
      protected var _flashPointZero:Point;
      
      protected var _colorTransform:ColorTransform;
      
      protected var _matrix:Matrix;
      
      public function FlxSprite(param1:Number = 0, param2:Number = 0, param3:Class = null)
      {
         this.ImgDefault = FlxSprite_ImgDefault;
         super(param1,param2);
         health = 1;
         this._flashPoint = new Point();
         this._flashRect = new Rectangle();
         this._flashRect2 = new Rectangle();
         this._flashPointZero = new Point();
         this.offset = new FlxPoint();
         this.origin = new FlxPoint();
         this.scale = new FlxPoint(1,1);
         this._alpha = 1;
         this._color = 16777215;
         this.blend = null;
         this.antialiasing = false;
         cameras = null;
         this.finished = false;
         this._facing = RIGHT;
         this._animations = new Array();
         this._flipped = 0;
         this._curAnim = null;
         this._curFrame = 0;
         this._curIndex = 0;
         this._frameTimer = 0;
         do
         {
            this._matrix = new Matrix();
            this._callback = null;
         }
         while(false);
         
         if(param3 == null)
         {
            param3 = this.ImgDefault;
         }
         this.loadGraphic(param3);
      }
      
      override public function destroy() : void
      {
         var _loc1_:FlxAnim = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         if(this._animations != null)
         {
            _loc2_ = 0;
            _loc3_ = this._animations.length;
            while(_loc2_ < _loc3_)
            {
               _loc1_ = this._animations[_loc2_++];
               if(_loc1_ != null)
               {
                  _loc1_.destroy();
               }
            }
            this._animations = null;
         }
         this._flashPoint = null;
         this._flashRect = null;
         this._flashRect2 = null;
         this._flashPointZero = null;
         this.offset = null;
         this.origin = null;
         this.scale = null;
         this._curAnim = null;
         this._matrix = null;
         this._callback = null;
         this.framePixels = null;
      }
      
      public function loadGraphic(param1:Class, param2:Boolean = false, param3:Boolean = false, param4:uint = 0, param5:uint = 0, param6:Boolean = false) : FlxSprite
      {
         this._bakedRotation = 0;
         this._pixels = FlxG.addBitmap(param1,param3,param6);
         if(param3)
         {
            this._flipped = this._pixels.width >> 1;
         }
         else
         {
            this._flipped = 0;
         }
         if(param4 == 0)
         {
            if(param2)
            {
               param4 = uint(this._pixels.height);
               addr20:
            }
            else if(this._flipped > 0)
            {
               param4 = this._pixels.width * 0.5;
            }
            else
            {
               param4 = uint(this._pixels.width);
               if(false)
               {
                  §§goto(addr20);
               }
            }
         }
         width = this.frameWidth = param4;
         if(param5 == 0)
         {
            if(param2)
            {
               param5 = width;
            }
            else
            {
               param5 = uint(this._pixels.height);
            }
         }
         height = this.frameHeight = param5;
         this.resetHelpers();
         return this;
      }
      
      public function loadRotatedGraphic(param1:Class, param2:uint = 16, param3:int = -1, param4:Boolean = false, param5:Boolean = false) : FlxSprite
      {
         var _loc12_:BitmapData = null;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         var _loc17_:uint = 0;
         var _loc18_:Number = NaN;
         var _loc19_:uint = 0;
         var _loc20_:uint = 0;
         var _loc21_:uint = 0;
         var _loc22_:uint = 0;
         var _loc6_:uint = Math.sqrt(param2);
         var _loc7_:BitmapData = FlxG.addBitmap(param1);
         if(param3 >= 0)
         {
            _loc12_ = _loc7_;
            _loc7_ = new BitmapData(_loc12_.height,_loc12_.height);
            _loc13_ = uint(param3 * _loc7_.width);
            _loc14_ = 0;
            _loc15_ = uint(_loc12_.width);
            if(_loc13_ >= _loc15_)
            {
               _loc14_ = uint(_loc13_ / _loc15_) * _loc7_.height;
               _loc13_ %= _loc15_;
            }
            this._flashRect.x = _loc13_;
            this._flashRect.y = _loc14_;
            this._flashRect.width = _loc7_.width;
            do
            {
               this._flashRect.height = _loc7_.height;
               _loc7_.copyPixels(_loc12_,this._flashRect,this._flashPointZero);
            }
            while(false);
            
         }
         var _loc8_:uint = uint(_loc7_.width);
         if(_loc7_.height > _loc8_)
         {
            _loc8_ = uint(_loc7_.height);
         }
         if(param5)
         {
            _loc8_ *= 1.5;
         }
         var _loc9_:uint = FlxU.ceil(param2 / _loc6_);
         width = _loc8_ * _loc9_;
         height = _loc8_ * _loc6_;
         var _loc10_:String = String(param1) + ":" + param3 + ":" + width + "x" + height;
         var _loc11_:Boolean = FlxG.checkBitmapCache(_loc10_);
         this._pixels = FlxG.createBitmap(width,height,0,true,_loc10_);
         width = this.frameWidth = this._pixels.width;
         height = this.frameHeight = this._pixels.height;
         this._bakedRotation = 360 / param2;
         if(!_loc11_)
         {
            _loc16_ = 0;
            _loc18_ = 0;
            _loc19_ = _loc7_.width * 0.5;
            _loc20_ = _loc7_.height * 0.5;
            _loc21_ = _loc8_ * 0.5;
            _loc22_ = _loc8_ * 0.5;
            while(_loc16_ < _loc6_)
            {
               _loc17_ = 0;
               while(true)
               {
                  if(_loc17_ >= _loc9_)
                  {
                     _loc22_ += _loc8_;
                     _loc16_++;
                     if(true)
                     {
                        break;
                     }
                  }
                  else
                  {
                     this._matrix.identity();
                     this._matrix.translate(-_loc19_,-_loc20_);
                     this._matrix.rotate(_loc18_ * 0.017453293);
                     this._matrix.translate(_loc8_ * _loc17_ + _loc21_,_loc22_);
                     _loc18_ += this._bakedRotation;
                     this._pixels.draw(_loc7_,this._matrix,null,null,null,param4);
                     _loc17_++;
                  }
               }
            }
         }
         this.frameWidth = this.frameHeight = width = height = _loc8_;
         this.resetHelpers();
         if(param5)
         {
            width = _loc7_.width;
            height = _loc7_.height;
            this.centerOffsets();
         }
         return this;
      }
      
      public function makeGraphic(param1:uint, param2:uint, param3:uint = 4294967295, param4:Boolean = false, param5:String = null) : FlxSprite
      {
         this._bakedRotation = 0;
         this._pixels = FlxG.createBitmap(param1,param2,param3,param4,param5);
         width = this.frameWidth = this._pixels.width;
         height = this.frameHeight = this._pixels.height;
         this.resetHelpers();
         return this;
      }
      
      protected function resetHelpers() : void
      {
         this._flashRect.x = 0;
         this._flashRect.y = 0;
         this._flashRect.width = this.frameWidth;
         this._flashRect.height = this.frameHeight;
         this._flashRect2.x = 0;
         this._flashRect2.y = 0;
         this._flashRect2.width = this._pixels.width;
         this._flashRect2.height = this._pixels.height;
         if(this.framePixels == null || this.framePixels.width != width || this.framePixels.height != height)
         {
            this.framePixels = new BitmapData(width,height);
         }
         this.origin.make(this.frameWidth * 0.5,this.frameHeight * 0.5);
         this.framePixels.copyPixels(this._pixels,this._flashRect,this._flashPointZero);
         this.frames = this._flashRect2.width / this._flashRect.width * (this._flashRect2.height / this._flashRect.height);
         if(this._colorTransform != null)
         {
            this.framePixels.colorTransform(this._flashRect,this._colorTransform);
         }
         this._curIndex = 0;
      }
      
      override public function postUpdate() : void
      {
         super.postUpdate();
         this.updateAnimation();
      }
      
      override public function draw() : void
      {
         var _loc1_:FlxCamera = null;
         if(_flickerTimer != 0)
         {
            _flicker = !_flicker;
            if(_flicker)
            {
               return;
            }
         }
         do
         {
            if(this.dirty)
            {
               this.calcFrame();
            }
            if(cameras != null)
            {
               break;
            }
            cameras = FlxG.cameras;
         }
         while(false);
         
         var _loc2_:uint = 0;
         var _loc3_:uint = cameras.length;
         while(_loc2_ < _loc3_)
         {
            _loc1_ = cameras[_loc2_++];
            if(this.onScreen(_loc1_))
            {
               _point.x = x - int(_loc1_.scroll.x * scrollFactor.x) - this.offset.x;
               _point.y = y - int(_loc1_.scroll.y * scrollFactor.y) - this.offset.y;
               _point.x += _point.x > 0 ? 1e-7 : -1e-7;
               _point.y += _point.y > 0 ? 1e-7 : -1e-7;
               if((angle == 0 || this._bakedRotation > 0) && this.scale.x == 1 && this.scale.y == 1 && this.blend == null)
               {
                  this._flashPoint.x = _point.x;
                  this._flashPoint.y = _point.y;
                  _loc1_.buffer.copyPixels(this.framePixels,this._flashRect,this._flashPoint,null,null,true);
               }
               else
               {
                  this._matrix.identity();
                  this._matrix.translate(-this.origin.x,-this.origin.y);
                  this._matrix.scale(this.scale.x,this.scale.y);
                  if(angle != 0 && this._bakedRotation <= 0)
                  {
                     this._matrix.rotate(angle * 0.017453293);
                  }
                  do
                  {
                     this._matrix.translate(_point.x + this.origin.x,_point.y + this.origin.y);
                     _loc1_.buffer.draw(this.framePixels,this._matrix,null,this.blend,null,this.antialiasing);
                  }
                  while(false);
                  
                  ++_VISIBLECOUNT;
               }
               if(FlxG.visualDebug && !ignoreDrawDebug)
               {
                  drawDebug(_loc1_);
               }
            }
         }
      }
      
      public function stamp(param1:FlxSprite, param2:int = 0, param3:int = 0) : void
      {
         param1.drawFrame();
         var _loc4_:BitmapData = param1.framePixels;
         if((param1.angle == 0 || param1._bakedRotation > 0) && param1.scale.x == 1 && param1.scale.y == 1 && param1.blend == null)
         {
            this._flashPoint.x = param2;
            this._flashPoint.y = param3;
            this._flashRect2.width = _loc4_.width;
            this._flashRect2.height = _loc4_.height;
            this._pixels.copyPixels(_loc4_,this._flashRect2,this._flashPoint,null,null,true);
            this._flashRect2.width = this._pixels.width;
            this._flashRect2.height = this._pixels.height;
            this.calcFrame();
            return;
         }
         this._matrix.identity();
         this._matrix.translate(-param1.origin.x,-param1.origin.y);
         this._matrix.scale(param1.scale.x,param1.scale.y);
         if(param1.angle != 0)
         {
            this._matrix.rotate(param1.angle * 0.017453293);
         }
         this._matrix.translate(param2 + param1.origin.x,param3 + param1.origin.y);
         this._pixels.draw(_loc4_,this._matrix,null,param1.blend,null,param1.antialiasing);
         this.calcFrame();
      }
      
      public function drawLine(param1:Number, param2:Number, param3:Number, param4:Number, param5:uint, param6:uint = 1) : void
      {
         var _loc7_:Graphics;
         (_loc7_ = FlxG.flashGfx).clear();
         _loc7_.moveTo(param1,param2);
         var _loc8_:Number;
         if((_loc8_ = Number(param5 >> 24 & 255) / 255) <= 0)
         {
            _loc8_ = 1;
         }
         _loc7_.lineStyle(param6,param5,_loc8_);
         _loc7_.lineTo(param3,param4);
         this._pixels.draw(FlxG.flashGfxSprite);
         this.dirty = true;
      }
      
      public function fill(param1:uint) : void
      {
         this._pixels.fillRect(this._flashRect2,param1);
         if(this._pixels != this.framePixels)
         {
            this.dirty = true;
         }
      }
      
      protected function updateAnimation() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         if(this._bakedRotation > 0)
         {
            _loc1_ = this._curIndex;
            _loc2_ = angle % 360;
            if(_loc2_ < 0)
            {
               _loc2_ += 360;
            }
            this._curIndex = _loc2_ / this._bakedRotation + 0.5;
            if(_loc1_ != this._curIndex)
            {
               this.dirty = true;
            }
         }
         else if(this._curAnim != null && this._curAnim.delay > 0 && (this._curAnim.looped || !this.finished))
         {
            this._frameTimer += FlxG.elapsed;
            while(this._frameTimer > this._curAnim.delay)
            {
               this._frameTimer -= this._curAnim.delay;
               do
               {
                  if(this._curFrame != this._curAnim.frames.length - 1)
                  {
                     ++this._curFrame;
                     break;
                  }
                  if(this._curAnim.looped)
                  {
                     this._curFrame = 0;
                  }
                  this.finished = true;
               }
               while(false);
               
               this._curIndex = this._curAnim.frames[this._curFrame];
               this.dirty = true;
            }
         }
         if(this.dirty)
         {
            this.calcFrame();
         }
      }
      
      public function drawFrame(param1:Boolean = false) : void
      {
         if(param1 || this.dirty)
         {
            this.calcFrame();
         }
      }
      
      public function addAnimation(param1:String, param2:Array, param3:Number = 0, param4:Boolean = true) : void
      {
         this._animations.push(new FlxAnim(param1,param2,param3,param4));
      }
      
      public function addAnimationCallback(param1:Function) : void
      {
         this._callback = param1;
      }
      
      public function play(param1:String, param2:Boolean = false) : void
      {
         if(!param2 && this._curAnim != null && param1 == this._curAnim.name && (this._curAnim.looped || !this.finished))
         {
            return;
         }
         this._curFrame = 0;
         do
         {
            this._curIndex = 0;
            this._frameTimer = 0;
         }
         while(false);
         
         var _loc3_:uint = 0;
         var _loc4_:uint = this._animations.length;
         while(_loc3_ < _loc4_)
         {
            if(this._animations[_loc3_].name == param1)
            {
               this._curAnim = this._animations[_loc3_];
               if(this._curAnim.delay <= 0)
               {
                  this.finished = true;
               }
               else
               {
                  this.finished = false;
               }
               this._curIndex = this._curAnim.frames[this._curFrame];
               this.dirty = true;
               return;
            }
            _loc3_++;
         }
         FlxG.log("WARNING: No animation called \"" + param1 + "\"");
      }
      
      public function randomFrame() : void
      {
         this._curAnim = null;
         this._curIndex = int(FlxG.random() * (this._pixels.width / this.frameWidth));
         this.dirty = true;
      }
      
      public function setOriginToCorner() : void
      {
         this.origin.x = this.origin.y = 0;
      }
      
      public function centerOffsets(param1:Boolean = false) : void
      {
         this.offset.x = (this.frameWidth - width) * 0.5;
         this.offset.y = (this.frameHeight - height) * 0.5;
         if(param1)
         {
            x += this.offset.x;
            y += this.offset.y;
         }
      }
      
      public function get pixels() : BitmapData
      {
         return this._pixels;
      }
      
      public function set pixels(param1:BitmapData) : void
      {
         this._pixels = param1;
         width = this.frameWidth = this._pixels.width;
         height = this.frameHeight = this._pixels.height;
         this.resetHelpers();
      }
      
      public function get facing() : uint
      {
         return this._facing;
      }
      
      public function set facing(param1:uint) : void
      {
         if(this._facing != param1)
         {
            this.dirty = true;
         }
         this._facing = param1;
      }
      
      public function get alpha() : Number
      {
         return this._alpha;
      }
      
      public function set alpha(param1:Number) : void
      {
         if(param1 > 1)
         {
            param1 = 1;
         }
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param1 == this._alpha)
         {
            return;
         }
         this._alpha = param1;
         if(this._alpha != 1 || this._color != 16777215)
         {
            this._colorTransform = new ColorTransform((this._color >> 16) * 0.00392,(this._color >> 8 & 255) * 0.00392,(this._color & 255) * 0.00392,this._alpha);
         }
         else
         {
            this._colorTransform = null;
         }
         this.dirty = true;
      }
      
      public function get color() : uint
      {
         return this._color;
      }
      
      public function set color(param1:uint) : void
      {
         param1 &= 16777215;
         if(this._color == param1)
         {
            return;
         }
         this._color = param1;
         if(this._alpha != 1 || this._color != 16777215)
         {
            this._colorTransform = new ColorTransform((this._color >> 16) * 0.00392,(this._color >> 8 & 255) * 0.00392,(this._color & 255) * 0.00392,this._alpha);
         }
         else
         {
            this._colorTransform = null;
         }
         this.dirty = true;
      }
      
      public function get frame() : uint
      {
         return this._curIndex;
      }
      
      public function set frame(param1:uint) : void
      {
         this._curAnim = null;
         this._curIndex = param1;
         this.dirty = true;
      }
      
      override public function onScreen(param1:FlxCamera = null) : Boolean
      {
         if(param1 == null)
         {
            param1 = FlxG.camera;
         }
         getScreenXY(_point,param1);
         _point.x -= this.offset.x;
         _point.y -= this.offset.y;
         if((angle == 0 || this._bakedRotation > 0) && this.scale.x == 1 && this.scale.y == 1)
         {
            return _point.x + this.frameWidth > 0 && _point.x < param1.width && _point.y + this.frameHeight > 0 && _point.y < param1.height;
         }
         var _loc2_:Number = this.frameWidth / 2;
         var _loc3_:Number = this.frameHeight / 2;
         var _loc4_:Number = this.scale.x > 0 ? this.scale.x : -this.scale.x;
         var _loc5_:Number = this.scale.y > 0 ? this.scale.y : -this.scale.y;
         var _loc6_:Number = Math.sqrt(_loc2_ * _loc2_ + _loc3_ * _loc3_) * (_loc4_ >= _loc5_ ? _loc4_ : _loc5_);
         _point.x += _loc2_;
         _point.y += _loc3_;
         return _point.x + _loc6_ > 0 && _point.x - _loc6_ < param1.width && _point.y + _loc6_ > 0 && _point.y - _loc6_ < param1.height;
      }
      
      public function pixelsOverlapPoint(param1:FlxPoint, param2:uint = 255, param3:FlxCamera = null) : Boolean
      {
         if(param3 == null)
         {
            param3 = FlxG.camera;
         }
         getScreenXY(_point,param3);
         _point.x -= this.offset.x;
         _point.y -= this.offset.y;
         this._flashPoint.x = param1.x - param3.scroll.x - _point.x;
         this._flashPoint.y = param1.y - param3.scroll.y - _point.y;
         return this.framePixels.hitTest(this._flashPointZero,param2,this._flashPoint);
      }
      
      protected function calcFrame() : void
      {
         var _loc1_:uint = this._curIndex * this.frameWidth;
         var _loc2_:uint = 0;
         var _loc3_:uint = !!this._flipped ? this._flipped : uint(this._pixels.width);
         if(_loc1_ >= _loc3_)
         {
            _loc2_ = uint(_loc1_ / _loc3_) * this.frameHeight;
            _loc1_ %= _loc3_;
         }
         if(Boolean(this._flipped) && this._facing == LEFT)
         {
            _loc1_ = uint((this._flipped << 1) - _loc1_ - this.frameWidth);
         }
         this._flashRect.x = _loc1_;
         do
         {
            this._flashRect.y = _loc2_;
            this.framePixels.copyPixels(this._pixels,this._flashRect,this._flashPointZero);
         }
         while(false);
         
         this._flashRect.x = this._flashRect.y = 0;
         if(this._colorTransform != null)
         {
            this.framePixels.colorTransform(this._flashRect,this._colorTransform);
         }
         if(this._callback != null)
         {
            this._callback(this._curAnim != null ? this._curAnim.name : null,this._curFrame,this._curIndex);
         }
         this.dirty = false;
      }
   }
}
