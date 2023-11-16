package org.flixel
{
   import flash.display.Graphics;
   import org.flixel.plugin.DebugPathDisplay;
   
   public class FlxPath
   {
       
      
      public var nodes:Array;
      
      public var debugColor:uint;
      
      public var debugScrollFactor:FlxPoint;
      
      public var ignoreDrawDebug:Boolean;
      
      protected var _point:FlxPoint;
      
      public function FlxPath(param1:Array = null)
      {
         super();
         if(param1 == null)
         {
            this.nodes = new Array();
         }
         else
         {
            this.nodes = param1;
         }
         this._point = new FlxPoint();
         do
         {
            this.debugScrollFactor = new FlxPoint(1,1);
            this.debugColor = 16777215;
         }
         while(false);
         
         var _loc2_:DebugPathDisplay = manager;
         if(_loc2_ != null)
         {
            _loc2_.add(this);
         }
      }
      
      public static function get manager() : DebugPathDisplay
      {
         return FlxG.getPlugin(DebugPathDisplay) as DebugPathDisplay;
      }
      
      public function destroy() : void
      {
         var _loc1_:DebugPathDisplay = manager;
         if(_loc1_ != null)
         {
            _loc1_.remove(this);
         }
         this.debugScrollFactor = null;
         this._point = null;
         this.nodes = null;
      }
      
      public function add(param1:Number, param2:Number) : void
      {
         this.nodes.push(new FlxPoint(param1,param2));
      }
      
      public function addAt(param1:Number, param2:Number, param3:uint) : void
      {
         if(param3 > this.nodes.length)
         {
            param3 = uint(this.nodes.length);
         }
         this.nodes.splice(param3,0,new FlxPoint(param1,param2));
      }
      
      public function addPoint(param1:FlxPoint, param2:Boolean = false) : void
      {
         if(param2)
         {
            this.nodes.push(param1);
         }
         else
         {
            this.nodes.push(new FlxPoint(param1.x,param1.y));
         }
      }
      
      public function addPointAt(param1:FlxPoint, param2:uint, param3:Boolean = false) : void
      {
         if(param2 > this.nodes.length)
         {
            param2 = uint(this.nodes.length);
         }
         if(param3)
         {
            this.nodes.splice(param2,0,param1);
         }
         else
         {
            this.nodes.splice(param2,0,new FlxPoint(param1.x,param1.y));
         }
      }
      
      public function remove(param1:FlxPoint) : FlxPoint
      {
         var _loc2_:int = int(this.nodes.indexOf(param1));
         if(_loc2_ >= 0)
         {
            return this.nodes.splice(_loc2_,1);
         }
         return null;
      }
      
      public function removeAt(param1:uint) : FlxPoint
      {
         if(this.nodes.length <= 0)
         {
            return null;
         }
         if(param1 >= this.nodes.length)
         {
            param1 = this.nodes.length - 1;
         }
         return this.nodes.splice(param1,1);
      }
      
      public function head() : FlxPoint
      {
         if(this.nodes.length > 0)
         {
            return this.nodes[0];
         }
         return null;
      }
      
      public function tail() : FlxPoint
      {
         if(this.nodes.length > 0)
         {
            return this.nodes[this.nodes.length - 1];
         }
         return null;
      }
      
      public function drawDebug(param1:FlxCamera = null) : void
      {
         var _loc3_:FlxPoint = null;
         var _loc4_:FlxPoint = null;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:Number = NaN;
         if(this.nodes.length <= 0)
         {
            return;
         }
         if(param1 == null)
         {
            param1 = FlxG.camera;
         }
         var _loc2_:Graphics = FlxG.flashGfx;
         _loc2_.clear();
         var _loc5_:uint = 0;
         var _loc6_:uint = uint(this.nodes.length);
         while(_loc5_ < _loc6_)
         {
            _loc3_ = this.nodes[_loc5_] as FlxPoint;
            this._point.x = _loc3_.x - int(param1.scroll.x * this.debugScrollFactor.x);
            this._point.y = _loc3_.y - int(param1.scroll.y * this.debugScrollFactor.y);
            this._point.x = int(this._point.x + (this._point.x > 0 ? 1e-7 : -1e-7));
            this._point.y = int(this._point.y + (this._point.y > 0 ? 1e-7 : -1e-7));
            _loc7_ = 2;
            if(_loc5_ == 0 || _loc5_ == _loc6_ - 1)
            {
               _loc7_ *= 2;
            }
            _loc8_ = this.debugColor;
            if(_loc6_ > 1)
            {
               if(_loc5_ == 0)
               {
                  _loc8_ = FlxG.GREEN;
               }
               else if(_loc5_ == _loc6_ - 1)
               {
                  _loc8_ = FlxG.RED;
               }
            }
            _loc2_.beginFill(_loc8_,0.5);
            _loc2_.lineStyle();
            _loc2_.drawRect(this._point.x - _loc7_ * 0.5,this._point.y - _loc7_ * 0.5,_loc7_,_loc7_);
            do
            {
               _loc2_.endFill();
               _loc9_ = 0.3;
            }
            while(false);
            
            if(_loc5_ < _loc6_ - 1)
            {
               _loc4_ = this.nodes[_loc5_ + 1];
            }
            else
            {
               _loc4_ = this.nodes[0];
               _loc9_ = 0.15;
            }
            _loc2_.moveTo(this._point.x,this._point.y);
            _loc2_.lineStyle(1,this.debugColor,_loc9_);
            this._point.x = _loc4_.x - int(param1.scroll.x * this.debugScrollFactor.x);
            this._point.y = _loc4_.y - int(param1.scroll.y * this.debugScrollFactor.y);
            this._point.x = int(this._point.x + (this._point.x > 0 ? 1e-7 : -1e-7));
            this._point.y = int(this._point.y + (this._point.y > 0 ? 1e-7 : -1e-7));
            do
            {
               _loc2_.lineTo(this._point.x,this._point.y);
               _loc5_++;
            }
            while(false);
            
         }
         param1.buffer.draw(FlxG.flashGfxSprite);
      }
   }
}
