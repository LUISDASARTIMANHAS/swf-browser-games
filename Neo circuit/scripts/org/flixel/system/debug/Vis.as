package org.flixel.system.debug
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import org.flixel.FlxG;
   
   public class Vis extends Sprite
   {
       
      
      protected var ImgBounds:Class;
      
      protected var _bounds:Bitmap;
      
      protected var _overBounds:Boolean;
      
      protected var _pressingBounds:Boolean;
      
      public function Vis()
      {
         this.ImgBounds = Vis_ImgBounds;
         super();
         var _loc1_:uint = 7;
         this._bounds = new this.ImgBounds();
         addChild(this._bounds);
         this.unpress();
         this.checkOver();
         this.updateGUI();
         addEventListener(Event.ENTER_FRAME,this.init);
      }
      
      public function destroy() : void
      {
         removeChild(this._bounds);
         this._bounds = null;
         stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
      }
      
      public function onBounds() : void
      {
         FlxG.visualDebug = !FlxG.visualDebug;
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
         if(!this.checkOver())
         {
            this.unpress();
         }
         this.updateGUI();
      }
      
      protected function onMouseDown(param1:MouseEvent = null) : void
      {
         this.unpress();
         if(this._overBounds)
         {
            this._pressingBounds = true;
         }
      }
      
      protected function onMouseUp(param1:MouseEvent = null) : void
      {
         if(this._overBounds && this._pressingBounds)
         {
            this.onBounds();
         }
         this.unpress();
         this.checkOver();
         this.updateGUI();
      }
      
      protected function checkOver() : Boolean
      {
         this._overBounds = false;
         if(mouseX < 0 || mouseX > width || mouseY < 0 || mouseY > height)
         {
            return false;
         }
         if(mouseX > this._bounds.x || mouseX < this._bounds.x + this._bounds.width)
         {
            this._overBounds = true;
         }
         return true;
      }
      
      protected function unpress() : void
      {
         this._pressingBounds = false;
      }
      
      protected function updateGUI() : void
      {
         if(FlxG.visualDebug)
         {
            if(this._overBounds && this._bounds.alpha != 1)
            {
               this._bounds.alpha = 1;
            }
            else if(!this._overBounds && this._bounds.alpha != 0.9)
            {
               this._bounds.alpha = 0.9;
            }
         }
         else if(this._overBounds && this._bounds.alpha != 0.6)
         {
            this._bounds.alpha = 0.6;
         }
         else if(!this._overBounds && this._bounds.alpha != 0.5)
         {
            this._bounds.alpha = 0.5;
         }
      }
   }
}
