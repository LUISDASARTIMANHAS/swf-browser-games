package org.flixel.system.input
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import org.flixel.FlxCamera;
   import org.flixel.FlxG;
   import org.flixel.FlxPoint;
   import org.flixel.system.replay.MouseRecord;
   
   public class Mouse extends FlxPoint
   {
       
      
      protected var ImgDefaultCursor:Class;
      
      public var wheel:int;
      
      public var screenX:int;
      
      public var screenY:int;
      
      protected var _current:int;
      
      protected var _last:int;
      
      protected var _cursorContainer:Sprite;
      
      protected var _cursor:Bitmap;
      
      protected var _lastX:int;
      
      protected var _lastY:int;
      
      protected var _lastWheel:int;
      
      protected var _point:FlxPoint;
      
      protected var _screenPosition:FlxPoint;
      
      public function Mouse(param1:Sprite)
      {
         this.ImgDefaultCursor = Mouse_ImgDefaultCursor;
         do
         {
            super();
            this._cursorContainer = param1;
         }
         while(false);
         
         this._lastX = this.screenX = 0;
         this._lastY = this.screenY = 0;
         this._lastWheel = this.wheel = 0;
         this._current = 0;
         this._last = 0;
         this._cursor = null;
         this._point = new FlxPoint();
         this._screenPosition = new FlxPoint();
      }
      
      public function destroy() : void
      {
         this._cursorContainer = null;
         this._cursor = null;
         this._point = null;
         this._screenPosition = null;
      }
      
      public function show(param1:Class = null, param2:Number = 1, param3:int = 0, param4:int = 0) : void
      {
         this._cursorContainer.visible = true;
         if(param1 != null)
         {
            this.load(param1,param2,param3,param4);
         }
         else if(this._cursor == null)
         {
            this.load();
         }
      }
      
      public function hide() : void
      {
         this._cursorContainer.visible = false;
      }
      
      public function get visible() : Boolean
      {
         return this._cursorContainer.visible;
      }
      
      public function load(param1:Class = null, param2:Number = 1, param3:int = 0, param4:int = 0) : void
      {
         if(this._cursor != null)
         {
            this._cursorContainer.removeChild(this._cursor);
         }
         if(param1 == null)
         {
            param1 = this.ImgDefaultCursor;
         }
         this._cursor = new param1();
         this._cursor.x = param3;
         this._cursor.y = param4;
         this._cursor.scaleX = param2;
         this._cursor.scaleY = param2;
         this._cursorContainer.addChild(this._cursor);
      }
      
      public function unload() : void
      {
         if(this._cursor != null)
         {
            if(this._cursorContainer.visible)
            {
               this.load();
            }
            else
            {
               this._cursorContainer.removeChild(this._cursor);
               this._cursor = null;
            }
         }
      }
      
      public function update(param1:int, param2:int) : void
      {
         this._screenPosition.make(param1,param2);
         this.getScreenPosition(null,this._point);
         this.screenX = this._point.x;
         this.screenY = this._point.y;
         this.updateCursor();
         if(this._last == -1 && this._current == -1)
         {
            this._current = 0;
         }
         else if(this._last == 2 && this._current == 2)
         {
            this._current = 1;
         }
         this._last = this._current;
      }
      
      protected function updateCursor() : void
      {
         this.getWorldPosition(null,this);
         this._cursorContainer.x = this._screenPosition.x;
         this._cursorContainer.y = this._screenPosition.y;
      }
      
      public function getWorldPosition(param1:FlxCamera = null, param2:FlxPoint = null) : FlxPoint
      {
         if(param1 == null)
         {
            param1 = FlxG.camera;
         }
         if(param2 == null)
         {
            param2 = new FlxPoint();
         }
         this.getScreenPosition(param1,this._point);
         return param2.make(this._point.x + param1.scroll.x,this._point.y + param1.scroll.y);
      }
      
      public function getScreenPosition(param1:FlxCamera = null, param2:FlxPoint = null) : FlxPoint
      {
         if(param1 == null)
         {
            param1 = FlxG.camera;
         }
         if(param2 == null)
         {
            param2 = new FlxPoint();
         }
         return param2.make(this._screenPosition.x / param1.zoom,this._screenPosition.y / param1.zoom);
      }
      
      public function reset() : void
      {
         this._current = 0;
         this._last = 0;
      }
      
      public function pressed() : Boolean
      {
         return this._current > 0;
      }
      
      public function justPressed() : Boolean
      {
         return this._current == 2;
      }
      
      public function justReleased() : Boolean
      {
         return this._current == -1;
      }
      
      public function handleMouseDown(param1:MouseEvent) : void
      {
         if(this._current > 0)
         {
            this._current = 1;
         }
         else
         {
            this._current = 2;
         }
      }
      
      public function handleMouseUp(param1:MouseEvent) : void
      {
         if(this._current > 0)
         {
            this._current = -1;
         }
         else
         {
            this._current = 0;
         }
      }
      
      public function handleMouseWheel(param1:MouseEvent) : void
      {
         this.wheel = param1.delta;
      }
      
      public function record() : MouseRecord
      {
         if(this._lastX == this.screenX && this._lastY == this.screenY && this._current == 0 && this._lastWheel == this.wheel)
         {
            return null;
         }
         this._lastX = this.screenX;
         this._lastY = this.screenY;
         this._lastWheel = this.wheel;
         return new MouseRecord(this.screenX,this.screenY,this._current,this.wheel);
      }
      
      public function playback(param1:MouseRecord) : void
      {
         this.screenX = param1.x;
         this.screenY = param1.y;
         this._current = param1.button;
         this.wheel = param1.wheel;
         this.updateCursor();
      }
   }
}
