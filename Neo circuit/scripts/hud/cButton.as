package hud
{
   import com.greensock.TweenMax;
   import flash.events.MouseEvent;
   import org.flixel.*;
   import org.flixel.plugin.photonstorm.FlxExtendedSprite;
   import org.flixel.plugin.photonstorm.FlxGradient;
   
   public class cButton extends FlxGroup
   {
      
      public static var NORMAL:uint = 0;
      
      public static var HIGHLIGHT:uint = 1;
      
      public static var PRESSED:uint = 2;
       
      
      public var pauseProof:Boolean;
      
      protected var _status:uint;
      
      protected var _onClick:Function;
      
      protected var _pressed:Boolean;
      
      protected var _initialized:Boolean;
      
      public var buttonNormal:FlxExtendedSprite;
      
      public var textNormal:FlxText;
      
      protected var _alpha:Number;
      
      private var onClickParams:Array;
      
      private var enterCallback:Function;
      
      private var enterCallbackParams:Array;
      
      private var leaveCallback:Function;
      
      private var leaveCallbackParams:Array;
      
      public var borderColor:uint = 4294967295;
      
      public var offColor:Array;
      
      public var onColor:Array;
      
      private var _x:int;
      
      private var _y:int;
      
      public var width:int;
      
      public var height:int;
      
      public function cButton(param1:int, param2:int, param3:Function, param4:Array = null, param5:String = null, param6:int = 100, param7:int = 20, param8:int = 16777215)
      {
         this.offColor = [4278222848,4278255360];
         this.onColor = [4286578688,4294901760];
         super(4);
         this._x = param1;
         this._y = param2;
         this.width = param6;
         this.height = param7;
         this._onClick = param3;
         this._alpha = 1;
         this.borderColor = param8;
         this.buttonNormal = new FlxExtendedSprite(param1,param2);
         this.buttonNormal.makeGraphic(param6,param7,this.borderColor);
         this.buttonNormal.stamp(FlxGradient.createGradientFlxSprite(param6 - 2,param7 - 2,this.offColor),1,1);
         this.buttonNormal.solid = false;
         add(this.buttonNormal);
         if(param5 != null)
         {
            this.textNormal = new FlxText(param1,param2 + 3,param6,param5);
            this.textNormal.setFormat(null,8,4294967295,"center",4278190080);
            this.textNormal.antialiasing = true;
            add(this.textNormal);
         }
         this._status = NORMAL;
         this._pressed = false;
         this._initialized = false;
         this.pauseProof = false;
         if(param4)
         {
            this.onClickParams = param4;
         }
      }
      
      public function set alpha(param1:Number) : void
      {
         this._alpha = param1;
         this.buttonNormal.alpha = param1;
         this.textNormal.alpha = param1;
      }
      
      public function get alpha() : Number
      {
         return this._alpha;
      }
      
      public function set x(param1:int) : void
      {
         this._x = param1;
         this.buttonNormal.x = this._x;
         if(this.textNormal)
         {
            this.textNormal.x = this._x;
         }
      }
      
      public function get x() : int
      {
         return this._x;
      }
      
      public function set y(param1:int) : void
      {
         this._y = param1;
         this.buttonNormal.y = this._y;
         if(this.textNormal)
         {
            this.textNormal.y = this._y;
         }
      }
      
      public function get y() : int
      {
         return this._y;
      }
      
      override public function preUpdate() : void
      {
         super.preUpdate();
         if(!this._initialized)
         {
            if(FlxG.stage != null)
            {
               FlxG.stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
               this._initialized = true;
            }
         }
      }
      
      public function loadGraphic(param1:FlxSprite) : void
      {
         this.buttonNormal.pixels = param1.pixels;
         this.width = this.buttonNormal.width;
         this.height = this.buttonNormal.height;
      }
      
      public function reset() : void
      {
         this._status = NORMAL;
      }
      
      override public function update() : void
      {
         this.updateButton();
      }
      
      protected function updateButton() : void
      {
         var _loc2_:FlxCamera = null;
         var _loc1_:uint = this._status;
         if(this.buttonNormal.cameras == null)
         {
            this.buttonNormal.cameras = FlxG.cameras;
         }
         var _loc3_:uint = 0;
         var _loc4_:uint = uint(this.buttonNormal.cameras.length);
         var _loc5_:Boolean = true;
         while(_loc3_ < _loc4_)
         {
            _loc2_ = this.buttonNormal.cameras[_loc3_++] as FlxCamera;
            if(this.buttonNormal.scrollFactor.x == 0 && this.buttonNormal.scrollFactor.y == 0)
            {
               this.buttonNormal.point.x = FlxG.mouse.screenX;
               this.buttonNormal.point.y = FlxG.mouse.screenY;
            }
            else
            {
               FlxG.mouse.getWorldPosition(_loc2_,this.buttonNormal.point);
            }
            if(this.buttonNormal.overlapsPoint(this.buttonNormal.point,false,_loc2_))
            {
               _loc5_ = false;
               do
               {
                  if(FlxG.mouse.justPressed())
                  {
                     this._status = PRESSED;
                  }
                  if(this._status != NORMAL)
                  {
                     break;
                  }
                  this._status = HIGHLIGHT;
               }
               while(false);
               
            }
         }
         if(_loc5_)
         {
            this._status = NORMAL;
         }
         if(this._status != _loc1_)
         {
            if(this._status == NORMAL)
            {
               TweenMax.killTweensOf(this.textNormal.scale,true);
            }
            else if(this._status == HIGHLIGHT)
            {
               TweenMax.to(this.textNormal.scale,0.25,{
                  "x":1.2,
                  "y":1.2,
                  "yoyo":true,
                  "repeat":-1
               });
               FlxG.play(NeoCircuit.SFX.SndHover,0.5);
            }
         }
      }
      
      public function activate(param1:Boolean) : void
      {
         active = param1;
         if(!active)
         {
            TweenMax.killTweensOf(this.textNormal.scale,true);
         }
      }
      
      override public function kill() : void
      {
         TweenMax.killTweensOf(this.textNormal.scale,true);
         super.kill();
      }
      
      override public function draw() : void
      {
         super.draw();
      }
      
      override public function destroy() : void
      {
         if(FlxG.stage != null)
         {
            FlxG.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         }
         if(this.buttonNormal != null)
         {
            this.buttonNormal.destroy();
            this.buttonNormal = null;
         }
         if(this.textNormal != null)
         {
            this.textNormal.destroy();
            this.textNormal = null;
         }
         this._onClick = null;
         this._onClick = null;
         this.enterCallback = null;
         this.leaveCallback = null;
         super.destroy();
      }
      
      protected function onMouseUp(param1:MouseEvent) : void
      {
         if(exists && visible && active && this._status == PRESSED && this._onClick != null && (this.pauseProof || !FlxG.paused))
         {
            this._onClick.apply(null,this.onClickParams);
         }
      }
      
      public function updateInactiveButtonColors(param1:Array) : void
      {
         this.offColor = param1;
         this.buttonNormal.fill(0);
         this.buttonNormal.stamp(FlxGradient.createGradientFlxSprite(this.width - 2,this.height - 2,this.offColor),1,1);
      }
      
      public function updateActiveButtonColors(param1:Array) : void
      {
         this.onColor = param1;
         this.buttonNormal.fill(0);
      }
      
      public function set text(param1:String) : void
      {
         if(Boolean(this.textNormal) && this.textNormal.text != param1)
         {
            this.textNormal.text = param1;
         }
      }
      
      public function screenCenter() : void
      {
         this.buttonNormal.x = FlxG.width / 2 - this.width / 2;
         if(this.textNormal)
         {
            this.textNormal.x = this.buttonNormal.x;
         }
      }
      
      public function setMouseOverCallback(param1:Function, param2:Array = null) : void
      {
         this.enterCallback = param1;
         this.enterCallbackParams = param2;
      }
      
      public function setMouseOutCallback(param1:Function, param2:Array = null) : void
      {
         this.leaveCallback = param1;
         this.leaveCallbackParams = param2;
      }
   }
}
