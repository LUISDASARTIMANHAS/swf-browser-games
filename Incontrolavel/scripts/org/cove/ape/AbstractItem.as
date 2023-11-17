package org.cove.ape
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   
   public class AbstractItem extends EventDispatcher
   {
       
      
      internal var lineAlpha:Number;
      
      internal var lineColor:uint;
      
      internal var displayObjectOffset:Vector2;
      
      internal var lineThickness:Number;
      
      internal var displayObject:DisplayObject;
      
      internal var fillAlpha:Number;
      
      private var _sprite:Sprite;
      
      internal var fillColor:uint;
      
      private var _solid:Boolean;
      
      private var _visible:Boolean;
      
      private var _alwaysRepaint:Boolean;
      
      internal var displayObjectRotation:Number;
      
      public function AbstractItem()
      {
         super();
         this._solid = true;
         this._visible = true;
         this._alwaysRepaint = false;
      }
      
      public function get solid() : Boolean
      {
         return this._solid;
      }
      
      public function setLine(param1:Number = 0, param2:uint = 0, param3:Number = 1) : void
      {
         this.lineThickness = param1;
         this.lineColor = param2;
         this.lineAlpha = param3;
      }
      
      public function set visible(param1:Boolean) : void
      {
         this._visible = param1;
         this.sprite.visible = param1;
      }
      
      public function setFill(param1:uint = 16777215, param2:Number = 1) : void
      {
         this.fillColor = param1;
         this.fillAlpha = param2;
      }
      
      public function init() : void
      {
      }
      
      public function set solid(param1:Boolean) : void
      {
         this._solid = param1;
      }
      
      public function get sprite() : Sprite
      {
         if(this._sprite != null)
         {
            return this._sprite;
         }
         if(APEngine.container == null)
         {
            throw new Error("The container property of the APEngine class has not been set");
         }
         this._sprite = new Sprite();
         APEngine.container.addChild(this._sprite);
         return this._sprite;
      }
      
      public function paint() : void
      {
      }
      
      public function cleanup() : void
      {
         this.sprite.graphics.clear();
         var _loc1_:int = 0;
         while(_loc1_ < this.sprite.numChildren)
         {
            this.sprite.removeChildAt(_loc1_);
            _loc1_++;
         }
      }
      
      public function setStyle(param1:Number = 0, param2:uint = 0, param3:Number = 1, param4:uint = 16777215, param5:Number = 1) : void
      {
         this.setLine(param1,param2,param3);
         this.setFill(param4,param5);
      }
      
      public function get visible() : Boolean
      {
         return this._visible;
      }
      
      final public function set alwaysRepaint(param1:Boolean) : void
      {
         this._alwaysRepaint = param1;
      }
      
      final public function get alwaysRepaint() : Boolean
      {
         return this._alwaysRepaint;
      }
   }
}
