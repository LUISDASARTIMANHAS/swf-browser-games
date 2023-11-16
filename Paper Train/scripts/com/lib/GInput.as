package com.lib
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   
   public class GInput extends Sprite
   {
       
      
      private var callbacks:Object;
      
      private var dragStartLayer:Point;
      
      private var mouse:MouseEvent;
      
      private var dragOffset:Point;
      
      private var dragBound:Object;
      
      private var dragEnabled:Boolean;
      
      private var keyTable:Array;
      
      private var drag:Boolean;
      
      private var dragStartMouse:Point;
      
      private var dragLayer:*;
      
      public function GInput(param1:*, param2:Object = null)
      {
         var _loc3_:* = undefined;
         super();
         this.mouse = null;
         this.dragEnabled = false;
         this.drag = false;
         this.dragLayer = null;
         this.dragBound = null;
         this.keyTable = new Array(256);
         for each(_loc3_ in this.keyTable)
         {
            _loc3_.pressed = false;
         }
         this.callbacks = !!param2 ? param2 : new Object();
         param1.addEventListener(MouseEvent.MOUSE_MOVE,this.mouseMove);
         param1.addEventListener(MouseEvent.CLICK,this.mouseClick);
         param1.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDown);
         param1.addEventListener(MouseEvent.MOUSE_UP,this.mouseUp);
         param1.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDown);
         param1.addEventListener(KeyboardEvent.KEY_UP,this.keyUp);
      }
      
      public function setDragBound(param1:Number, param2:Number, param3:Number, param4:Number) : *
      {
         this.dragBound = {
            "minx":param1,
            "miny":param2,
            "maxx":param1 + param3,
            "maxy":param2 + param4
         };
      }
      
      private function dragMouseUp(param1:MouseEvent) : *
      {
         this.drag = false;
      }
      
      public function getMouseCoord(param1:MouseEvent = null) : Point
      {
         if(param1)
         {
            return new Point(param1.stageX,param1.stageY);
         }
         return new Point(this.mouse.stageX,this.mouse.stageY);
      }
      
      private function dragMouseDown(param1:MouseEvent) : *
      {
         if(this.dragEnabled && this.dragLayer)
         {
            this.drag = true;
            this.dragStartMouse = this.getMouseCoord(param1);
            this.dragStartLayer = new Point(this.dragLayer.x,this.dragLayer.y);
         }
      }
      
      private function mouseMove(param1:MouseEvent) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         this.mouse = param1;
         if(this.dragEnabled && this.drag && this.dragLayer)
         {
            _loc2_ = this.getMouseCoord();
            this.dragOffset = _loc2_.subtract(this.dragStartMouse);
            _loc3_ = this.dragStartLayer.x + this.dragOffset.x;
            _loc4_ = this.dragStartLayer.y + this.dragOffset.y;
            if(this.dragBound)
            {
               if(_loc3_ > -this.dragBound.minx)
               {
                  _loc3_ = -this.dragBound.minx;
               }
               if(_loc4_ > -this.dragBound.miny)
               {
                  _loc4_ = -this.dragBound.miny;
               }
               if(_loc3_ < -this.dragBound.maxx)
               {
                  _loc3_ = -this.dragBound.maxx;
               }
               if(_loc4_ < -this.dragBound.maxy)
               {
                  _loc4_ = -this.dragBound.maxy;
               }
            }
            this.dragLayer.x = _loc3_;
            this.dragLayer.y = _loc4_;
         }
         if(this.callbacks.mouseMove)
         {
            this.callbacks.mouseMove(param1);
         }
      }
      
      public function enableDrag(param1:Boolean = true) : *
      {
         this.dragEnabled = param1;
      }
      
      public function removeDragLayer() : *
      {
         this.dragLayer.removeEventListener(MouseEvent.MOUSE_DOWN,this.dragMouseDown);
         this.dragLayer.removeEventListener(MouseEvent.MOUSE_UP,this.dragMouseUp);
         this.enableDrag(false);
      }
      
      private function mouseUp(param1:MouseEvent) : *
      {
         this.mouse = param1;
         this.drag = false;
         if(this.callbacks.mouseUp)
         {
            this.callbacks.mouseUp(param1);
         }
      }
      
      private function keyDown(param1:KeyboardEvent) : *
      {
         var _loc2_:* = param1.keyCode;
         if(_loc2_ > 0 && _loc2_ < this.keyTable.length)
         {
            this.keyTable[_loc2_] = {
               "pressed":true,
               "event":param1
            };
         }
         if(this.callbacks.keyDown)
         {
            this.callbacks.keyDown(param1);
         }
      }
      
      public function getKey(param1:String) : *
      {
         switch(param1)
         {
            case "escape":
               return this.keyTable[27].pressed;
            case "enter":
               return this.keyTable[13].pressed;
            case "up":
               return this.keyTable[38].pressed;
            case "down":
               return this.keyTable[40].pressed;
            case "left":
               return this.keyTable[37].pressed;
            case "right":
               return this.keyTable[39].pressed;
            default:
               return null;
         }
      }
      
      private function mouseClick(param1:MouseEvent) : *
      {
         this.mouse = param1;
         if(this.callbacks.mouseClick)
         {
            this.callbacks.mouseClick(param1);
         }
      }
      
      public function getMouse() : Object
      {
         return this.mouse;
      }
      
      public function destroy() : *
      {
         stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.mouseMove);
         stage.removeEventListener(MouseEvent.CLICK,this.mouseClick);
         stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseDown);
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.mouseUp);
         stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.keyDown);
         stage.removeEventListener(KeyboardEvent.KEY_UP,this.keyUp);
      }
      
      public function setDragLayer(param1:*, param2:Boolean = true) : *
      {
         this.dragLayer = param1;
         this.dragLayer.addEventListener(MouseEvent.MOUSE_DOWN,this.dragMouseDown);
         this.dragLayer.addEventListener(MouseEvent.MOUSE_UP,this.dragMouseUp);
         this.enableDrag(param2);
      }
      
      private function keyUp(param1:KeyboardEvent) : *
      {
         var _loc2_:* = param1.keyCode;
         if(_loc2_ > 0 && _loc2_ < this.keyTable.length)
         {
            this.keyTable[_loc2_] = {
               "pressed":false,
               "event":param1
            };
         }
         if(this.callbacks.keyUp)
         {
            this.callbacks.keyUp(param1);
         }
      }
      
      private function mouseDown(param1:MouseEvent) : *
      {
         this.mouse = param1;
         if(this.callbacks.mouseDown)
         {
            this.callbacks.mouseDown(param1);
         }
      }
   }
}
