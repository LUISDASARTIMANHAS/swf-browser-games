package org.flixel.system
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import org.flixel.FlxU;
   
   public class FlxWindow extends Sprite
   {
       
      
      protected var ImgHandle:Class;
      
      public var minSize:Point;
      
      public var maxSize:Point;
      
      protected var _width:uint;
      
      protected var _height:uint;
      
      protected var _bounds:Rectangle;
      
      protected var _background:Bitmap;
      
      protected var _header:Bitmap;
      
      protected var _shadow:Bitmap;
      
      protected var _title:TextField;
      
      protected var _handle:Bitmap;
      
      protected var _overHeader:Boolean;
      
      protected var _overHandle:Boolean;
      
      protected var _drag:Point;
      
      protected var _dragging:Boolean;
      
      protected var _resizing:Boolean;
      
      protected var _resizable:Boolean;
      
      public function FlxWindow(param1:String, param2:Number, param3:Number, param4:Boolean = true, param5:Rectangle = null, param6:uint = 2139062143, param7:uint = 2130706432)
      {
         this.ImgHandle = FlxWindow_ImgHandle;
         super();
         this._width = param2;
         this._height = param3;
         this._bounds = param5;
         this.minSize = new Point(50,30);
         if(this._bounds != null)
         {
            this.maxSize = new Point(this._bounds.width,this._bounds.height);
         }
         else
         {
            this.maxSize = new Point(Number.MAX_VALUE,Number.MAX_VALUE);
         }
         this._drag = new Point();
         this._resizable = param4;
         this._shadow = new Bitmap(new BitmapData(1,2,true,4278190080));
         addChild(this._shadow);
         this._background = new Bitmap(new BitmapData(1,1,true,param6));
         this._background.y = 15;
         addChild(this._background);
         this._header = new Bitmap(new BitmapData(1,15,true,param7));
         addChild(this._header);
         this._title = new TextField();
         this._title.x = 2;
         this._title.height = 16;
         this._title.selectable = false;
         this._title.multiline = false;
         this._title.defaultTextFormat = new TextFormat("Courier",12,16777215);
         this._title.text = param1;
         addChild(this._title);
         if(this._resizable)
         {
            this._handle = new this.ImgHandle();
            addChild(this._handle);
         }
         if(this._width != 0 || this._height != 0)
         {
            this.updateSize();
         }
         this.bound();
         addEventListener(Event.ENTER_FRAME,this.init);
      }
      
      public function destroy() : void
      {
         this.minSize = null;
         this.maxSize = null;
         this._bounds = null;
         removeChild(this._shadow);
         this._shadow = null;
         removeChild(this._background);
         this._background = null;
         removeChild(this._header);
         this._header = null;
         removeChild(this._title);
         this._title = null;
         if(this._handle != null)
         {
            removeChild(this._handle);
         }
         this._handle = null;
         this._drag = null;
      }
      
      public function resize(param1:Number, param2:Number) : void
      {
         this._width = param1;
         this._height = param2;
         this.updateSize();
      }
      
      public function reposition(param1:Number, param2:Number) : void
      {
         x = param1;
         y = param2;
         this.bound();
      }
      
      protected function init(param1:Event = null) : void
      {
         if(root == null)
         {
            return;
         }
         removeEventListener(Event.ENTER_FRAME,this.init);
         stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         stage.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
      }
      
      protected function onMouseMove(param1:MouseEvent = null) : void
      {
         if(this._dragging)
         {
            this._overHeader = true;
            this.reposition(parent.mouseX - this._drag.x,parent.mouseY - this._drag.y);
         }
         else if(this._resizing)
         {
            this._overHandle = true;
            this.resize(mouseX - this._drag.x,mouseY - this._drag.y);
         }
         else
         {
            §§push(mouseX >= 0 && mouseX <= this._width && mouseY >= 0);
            if(mouseX >= 0 && mouseX <= this._width && mouseY >= 0)
            {
               §§pop();
               while(true)
               {
                  §§push(mouseY <= this._height);
                  addr14:
                  this._overHandle = mouseX >= this._width - this._handle.width && mouseY >= this._height - this._handle.height;
                  if(false)
                  {
                     continue;
                  }
                  addr160:
                  this.updateGUI();
                  return;
                  addr143:
               }
               addr37:
            }
            while(true)
            {
               if(!§§pop())
               {
                  this._overHandle = this._overHeader = false;
                  break;
               }
               this._overHeader = mouseX <= this._header.width && mouseY <= this._header.height;
               if(this._resizable)
               {
                  §§goto(addr14);
               }
               §§goto(addr143);
               §§goto(addr37);
            }
         }
         §§goto(addr160);
      }
      
      protected function onMouseDown(param1:MouseEvent = null) : void
      {
         if(this._overHeader)
         {
            this._dragging = true;
            this._drag.x = mouseX;
            this._drag.y = mouseY;
         }
         else if(this._overHandle)
         {
            this._resizing = true;
            this._drag.x = this._width - mouseX;
            this._drag.y = this._height - mouseY;
         }
      }
      
      protected function onMouseUp(param1:MouseEvent = null) : void
      {
         this._dragging = false;
         this._resizing = false;
      }
      
      protected function bound() : void
      {
         if(this._bounds != null)
         {
            x = FlxU.bound(x,this._bounds.left,this._bounds.right - this._width);
            y = FlxU.bound(y,this._bounds.top,this._bounds.bottom - this._height);
         }
      }
      
      protected function updateSize() : void
      {
         this._width = FlxU.bound(this._width,this.minSize.x,this.maxSize.x);
         this._height = FlxU.bound(this._height,this.minSize.y,this.maxSize.y);
         this._header.scaleX = this._width;
         this._background.scaleX = this._width;
         this._background.scaleY = this._height - 15;
         this._shadow.scaleX = this._width;
         this._shadow.y = this._height;
         this._title.width = this._width - 4;
         if(this._resizable)
         {
            this._handle.x = this._width - this._handle.width;
            this._handle.y = this._height - this._handle.height;
         }
      }
      
      protected function updateGUI() : void
      {
         if(this._overHeader || this._overHandle)
         {
            if(this._title.alpha != 1)
            {
               this._title.alpha = 1;
            }
         }
         else if(this._title.alpha != 0.65)
         {
            this._title.alpha = 0.65;
         }
      }
   }
}
