package org.flixel
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class FlxCamera extends FlxBasic
   {
      
      public static const STYLE_LOCKON:uint = 0;
      
      public static const STYLE_PLATFORMER:uint = 1;
      
      public static const STYLE_TOPDOWN:uint = 2;
      
      public static const STYLE_TOPDOWN_TIGHT:uint = 3;
      
      public static const SHAKE_BOTH_AXES:uint = 0;
      
      public static const SHAKE_HORIZONTAL_ONLY:uint = 1;
      
      public static const SHAKE_VERTICAL_ONLY:uint = 2;
      
      public static var defaultZoom:Number;
       
      
      public var x:Number;
      
      public var y:Number;
      
      public var width:uint;
      
      public var height:uint;
      
      public var target:FlxObject;
      
      public var deadzone:FlxRect;
      
      public var bounds:FlxRect;
      
      public var scroll:FlxPoint;
      
      public var buffer:BitmapData;
      
      public var bgColor:uint;
      
      public var screen:FlxSprite;
      
      protected var _zoom:Number;
      
      protected var _point:FlxPoint;
      
      protected var _color:uint;
      
      internal var _flashBitmap:Bitmap;
      
      protected var _flashRect:Rectangle;
      
      protected var _flashPoint:Point;
      
      protected var _fxFlashColor:uint;
      
      protected var _fxFlashDuration:Number;
      
      protected var _fxFlashComplete:Function;
      
      protected var _fxFlashAlpha:Number;
      
      protected var _fxFadeColor:uint;
      
      protected var _fxFadeDuration:Number;
      
      protected var _fxFadeComplete:Function;
      
      protected var _fxFadeAlpha:Number;
      
      protected var _fxShakeIntensity:Number;
      
      protected var _fxShakeDuration:Number;
      
      protected var _fxShakeComplete:Function;
      
      protected var _fxShakeOffset:FlxPoint;
      
      protected var _fxShakeDirection:uint;
      
      protected var _fill:BitmapData;
      
      public function FlxCamera(param1:int, param2:int, param3:int, param4:int, param5:Number = 0)
      {
         super();
         this.x = param1;
         this.y = param2;
         this.width = param3;
         this.height = param4;
         this.target = null;
         this.deadzone = null;
         this.scroll = new FlxPoint();
         this._point = new FlxPoint();
         this.bounds = null;
         this.screen = new FlxSprite();
         this.screen.makeGraphic(this.width,this.height,0,true);
         this.screen.setOriginToCorner();
         this.buffer = this.screen.pixels;
         this.bgColor = FlxG.bgColor;
         this._color = 16777215;
         this._flashBitmap = new Bitmap(this.buffer);
         this._flashBitmap.x = this.x;
         this._flashBitmap.y = this.y;
         this.zoom = param5;
         this._flashRect = new Rectangle(0,0,this.width,this.height);
         this._flashPoint = new Point();
         this._fxFlashColor = 0;
         this._fxFlashDuration = 0;
         this._fxFlashComplete = null;
         this._fxFlashAlpha = 0;
         this._fxFadeColor = 0;
         this._fxFadeDuration = 0;
         this._fxFadeComplete = null;
         this._fxFadeAlpha = 0;
         this._fxShakeIntensity = 0;
         this._fxShakeDuration = 0;
         this._fxShakeComplete = null;
         this._fxShakeOffset = new FlxPoint();
         this._fxShakeDirection = 0;
         this._fill = new BitmapData(this.width,this.height,true,0);
      }
      
      override public function destroy() : void
      {
         this.screen.destroy();
         this.screen = null;
         this.target = null;
         this.scroll = null;
         this.deadzone = null;
         this.bounds = null;
         this.buffer = null;
         this._flashBitmap = null;
         this._flashRect = null;
         this._flashPoint = null;
         this._fxFlashComplete = null;
         this._fxFadeComplete = null;
         this._fxShakeComplete = null;
         this._fxShakeOffset = null;
         this._fill = null;
      }
      
      override public function update() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this.target != null)
         {
            if(this.deadzone == null)
            {
               this.focusOn(this.target.getMidpoint(this._point));
            }
            else
            {
               _loc2_ = this.target.x + (this.target.x > 0 ? 1e-7 : -1e-7);
               _loc3_ = this.target.y + (this.target.y > 0 ? 1e-7 : -1e-7);
               _loc1_ = _loc2_ - this.deadzone.x;
               if(this.scroll.x > _loc1_)
               {
                  this.scroll.x = _loc1_;
               }
               _loc1_ = _loc2_ + this.target.width - this.deadzone.x - this.deadzone.width;
               if(this.scroll.x < _loc1_)
               {
                  this.scroll.x = _loc1_;
               }
               _loc1_ = _loc3_ - this.deadzone.y;
               if(this.scroll.y > _loc1_)
               {
                  this.scroll.y = _loc1_;
               }
               _loc1_ = _loc3_ + this.target.height - this.deadzone.y - this.deadzone.height;
               if(this.scroll.y < _loc1_)
               {
                  this.scroll.y = _loc1_;
               }
            }
         }
         if(this.bounds != null)
         {
            if(this.scroll.x < this.bounds.left)
            {
               this.scroll.x = this.bounds.left;
            }
            if(this.scroll.x > this.bounds.right - this.width)
            {
               this.scroll.x = this.bounds.right - this.width;
            }
            if(this.scroll.y < this.bounds.top)
            {
               this.scroll.y = this.bounds.top;
            }
            if(this.scroll.y > this.bounds.bottom - this.height)
            {
               this.scroll.y = this.bounds.bottom - this.height;
            }
         }
         if(this._fxFlashAlpha > 0)
         {
            this._fxFlashAlpha -= FlxG.elapsed / this._fxFlashDuration;
            if(this._fxFlashAlpha <= 0 && this._fxFlashComplete != null)
            {
               this._fxFlashComplete();
            }
         }
         if(this._fxFadeAlpha > 0 && this._fxFadeAlpha < 1)
         {
            this._fxFadeAlpha += FlxG.elapsed / this._fxFadeDuration;
            if(this._fxFadeAlpha >= 1)
            {
               this._fxFadeAlpha = 1;
               if(this._fxFadeComplete != null)
               {
                  this._fxFadeComplete();
               }
            }
         }
         if(this._fxShakeDuration > 0)
         {
            this._fxShakeDuration -= FlxG.elapsed;
            if(this._fxShakeDuration <= 0)
            {
               this._fxShakeOffset.make();
               if(this._fxShakeComplete != null)
               {
                  this._fxShakeComplete();
               }
            }
            else
            {
               if(this._fxShakeDirection == SHAKE_BOTH_AXES || this._fxShakeDirection == SHAKE_HORIZONTAL_ONLY)
               {
                  this._fxShakeOffset.x = (FlxG.random() * this._fxShakeIntensity * this.width * 2 - this._fxShakeIntensity * this.width) * this._zoom;
               }
               if(this._fxShakeDirection == SHAKE_BOTH_AXES || this._fxShakeDirection == SHAKE_VERTICAL_ONLY)
               {
                  this._fxShakeOffset.y = (FlxG.random() * this._fxShakeIntensity * this.height * 2 - this._fxShakeIntensity * this.height) * this._zoom;
               }
            }
         }
      }
      
      public function follow(param1:FlxObject, param2:uint = 0) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         this.target = param1;
         switch(param2)
         {
            case STYLE_PLATFORMER:
               _loc4_ = this.width / 8;
               _loc5_ = this.height / 3;
               this.deadzone = new FlxRect((this.width - _loc4_) / 2,(this.height - _loc5_) / 2 - _loc5_ * 0.25,_loc4_,_loc5_);
               break;
            case STYLE_TOPDOWN:
               _loc3_ = FlxU.max(this.width,this.height) / 4;
               this.deadzone = new FlxRect((this.width - _loc3_) / 2,(this.height - _loc3_) / 2,_loc3_,_loc3_);
               break;
            case STYLE_TOPDOWN_TIGHT:
               _loc3_ = FlxU.max(this.width,this.height) / 8;
               addr25:
               this.deadzone = new FlxRect((this.width - _loc3_) / 2,(this.height - _loc3_) / 2,_loc3_,_loc3_);
               break;
            case STYLE_LOCKON:
            default:
               this.deadzone = null;
               if(true)
               {
                  break;
               }
               §§goto(addr25);
         }
      }
      
      public function focusOn(param1:FlxPoint) : void
      {
         param1.x += param1.x > 0 ? 1e-7 : -1e-7;
         param1.y += param1.y > 0 ? 1e-7 : -1e-7;
         this.scroll.make(param1.x - this.width * 0.5,param1.y - this.height * 0.5);
      }
      
      public function setBounds(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:Boolean = false) : void
      {
         if(this.bounds == null)
         {
            this.bounds = new FlxRect();
         }
         this.bounds.make(param1,param2,param3,param4);
         if(param5)
         {
            FlxG.worldBounds.copyFrom(this.bounds);
         }
         this.update();
      }
      
      public function flash(param1:uint = 4294967295, param2:Number = 1, param3:Function = null, param4:Boolean = false) : void
      {
         if(!param4 && this._fxFlashAlpha > 0)
         {
            return;
         }
         this._fxFlashColor = param1;
         if(param2 <= 0)
         {
            param2 = Number(Number.MIN_VALUE);
         }
         this._fxFlashDuration = param2;
         this._fxFlashComplete = param3;
         this._fxFlashAlpha = 1;
      }
      
      public function fade(param1:uint = 4294967295, param2:Number = 1, param3:Function = null, param4:Boolean = false) : void
      {
         if(!param4 && this._fxFadeAlpha > 0)
         {
            return;
         }
         this._fxFadeColor = param1;
         if(param2 <= 0)
         {
            param2 = Number(Number.MIN_VALUE);
         }
         this._fxFadeDuration = param2;
         this._fxFadeComplete = param3;
         this._fxFadeAlpha = Number.MIN_VALUE;
      }
      
      public function shake(param1:Number = 0.05, param2:Number = 0.5, param3:Function = null, param4:Boolean = true, param5:uint = 0) : void
      {
         if(!param4 && (this._fxShakeOffset.x != 0 || this._fxShakeOffset.y != 0))
         {
            return;
         }
         this._fxShakeIntensity = param1;
         this._fxShakeDuration = param2;
         this._fxShakeComplete = param3;
         this._fxShakeDirection = param5;
         this._fxShakeOffset.make();
      }
      
      public function stopFX() : void
      {
         this._fxFlashAlpha = 0;
         this._fxFadeAlpha = 0;
         this._fxShakeDuration = 0;
         this._flashBitmap.x = this.x;
         this._flashBitmap.y = this.y;
      }
      
      public function copyFrom(param1:FlxCamera) : FlxCamera
      {
         if(param1.bounds == null)
         {
            this.bounds = null;
         }
         else
         {
            if(this.bounds == null)
            {
               this.bounds = new FlxRect();
            }
            this.bounds.copyFrom(param1.bounds);
         }
         this.target = param1.target;
         if(this.target != null)
         {
            if(param1.deadzone == null)
            {
               this.deadzone = null;
            }
            else
            {
               if(this.deadzone == null)
               {
                  this.deadzone = new FlxRect();
               }
               this.deadzone.copyFrom(param1.deadzone);
            }
         }
         return this;
      }
      
      public function get zoom() : Number
      {
         return this._zoom;
      }
      
      public function set zoom(param1:Number) : void
      {
         if(param1 == 0)
         {
            this._zoom = defaultZoom;
         }
         else
         {
            this._zoom = param1;
         }
         this._flashBitmap.scaleX = this._zoom;
         this._flashBitmap.scaleY = this._zoom;
      }
      
      public function get alpha() : Number
      {
         return this._flashBitmap.alpha;
      }
      
      public function set alpha(param1:Number) : void
      {
         this._flashBitmap.alpha = param1;
      }
      
      public function get angle() : Number
      {
         return this._flashBitmap.rotation;
      }
      
      public function set angle(param1:Number) : void
      {
         this._flashBitmap.rotation = param1;
      }
      
      public function get color() : uint
      {
         return this._color;
      }
      
      public function set color(param1:uint) : void
      {
         this._color = param1;
         var _loc2_:ColorTransform = this._flashBitmap.transform.colorTransform;
         _loc2_.redMultiplier = (this._color >> 16) * 0.00392;
         _loc2_.greenMultiplier = (this._color >> 8 & 255) * 0.00392;
         _loc2_.blueMultiplier = (this._color & 255) * 0.00392;
         this._flashBitmap.transform.colorTransform = _loc2_;
      }
      
      public function get antialiasing() : Boolean
      {
         return this._flashBitmap.smoothing;
      }
      
      public function set antialiasing(param1:Boolean) : void
      {
         this._flashBitmap.smoothing = param1;
      }
      
      public function getScale() : FlxPoint
      {
         return this._point.make(this._flashBitmap.scaleX,this._flashBitmap.scaleY);
      }
      
      public function setScale(param1:Number, param2:Number) : void
      {
         this._flashBitmap.scaleX = param1;
         this._flashBitmap.scaleY = param2;
      }
      
      public function fill(param1:uint = 0, param2:Boolean = true) : void
      {
         if(param1 == 0)
         {
            param1 = this.bgColor;
         }
         this._fill.fillRect(this._flashRect,param1);
         this.buffer.copyPixels(this._fill,this._flashRect,this._flashPoint,null,null,param2);
      }
      
      internal function drawFX() : void
      {
         var _loc1_:Number = NaN;
         if(this._fxFlashAlpha > 0)
         {
            _loc1_ = this._fxFlashColor >> 24;
            this.fill((uint((_loc1_ <= 0 ? 255 : _loc1_) * this._fxFlashAlpha) << 24) + (this._fxFlashColor & 16777215));
         }
         if(this._fxFadeAlpha > 0)
         {
            _loc1_ = this._fxFadeColor >> 24;
            this.fill((uint((_loc1_ <= 0 ? 255 : _loc1_) * this._fxFadeAlpha) << 24) + (this._fxFadeColor & 16777215));
         }
         if(this._fxShakeOffset.x != 0 || this._fxShakeOffset.y != 0)
         {
            this._flashBitmap.x = this.x + this._fxShakeOffset.x;
            this._flashBitmap.y = this.y + this._fxShakeOffset.y;
         }
      }
   }
}
