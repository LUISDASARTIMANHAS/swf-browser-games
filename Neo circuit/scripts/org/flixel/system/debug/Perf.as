package org.flixel.system.debug
{
   import flash.geom.Rectangle;
   import flash.system.System;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.getTimer;
   import org.flixel.FlxG;
   import org.flixel.system.FlxWindow;
   
   public class Perf extends FlxWindow
   {
       
      
      protected var _text:TextField;
      
      protected var _lastTime:int;
      
      protected var _updateTimer:int;
      
      protected var _flixelUpdate:Array;
      
      protected var _flixelUpdateMarker:uint;
      
      protected var _flixelDraw:Array;
      
      protected var _flixelDrawMarker:uint;
      
      protected var _flash:Array;
      
      protected var _flashMarker:uint;
      
      protected var _activeObject:Array;
      
      protected var _objectMarker:uint;
      
      protected var _visibleObject:Array;
      
      protected var _visibleObjectMarker:uint;
      
      public function Perf(param1:String, param2:Number, param3:Number, param4:Boolean = true, param5:Rectangle = null, param6:uint = 2139062143, param7:uint = 2130706432)
      {
         super(param1,param2,param3,param4,param5,param6,param7);
         resize(90,66);
         this._lastTime = 0;
         this._updateTimer = 0;
         this._text = new TextField();
         this._text.width = _width;
         this._text.x = 2;
         this._text.y = 15;
         this._text.multiline = true;
         this._text.wordWrap = true;
         this._text.selectable = true;
         this._text.defaultTextFormat = new TextFormat("Courier",12,16777215);
         addChild(this._text);
         this._flixelUpdate = new Array(32);
         this._flixelUpdateMarker = 0;
         this._flixelDraw = new Array(32);
         this._flixelDrawMarker = 0;
         this._flash = new Array(32);
         this._flashMarker = 0;
         this._activeObject = new Array(32);
         this._objectMarker = 0;
         this._visibleObject = new Array(32);
         this._visibleObjectMarker = 0;
      }
      
      override public function destroy() : void
      {
         removeChild(this._text);
         this._text = null;
         this._flixelUpdate = null;
         this._flixelDraw = null;
         this._flash = null;
         this._activeObject = null;
         this._visibleObject = null;
         super.destroy();
      }
      
      public function update() : void
      {
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         var _loc6_:Number = NaN;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc1_:int = getTimer();
         var _loc2_:int = _loc1_ - this._lastTime;
         var _loc3_:uint = 500;
         if(_loc2_ > _loc3_)
         {
            _loc2_ = int(_loc3_);
         }
         this._lastTime = _loc1_;
         this._updateTimer += _loc2_;
         if(this._updateTimer > _loc3_)
         {
            _loc5_ = "";
            _loc6_ = 0;
            _loc4_ = 0;
            while(_loc4_ < this._flashMarker)
            {
               _loc6_ += this._flash[_loc4_++];
            }
            _loc6_ /= this._flashMarker;
            _loc5_ = (_loc5_ += uint(1 / (_loc6_ / 1000)) + "/" + FlxG.flashFramerate + "fps\n") + (Number((System.totalMemory * 9.54e-7).toFixed(2)) + "MB\n");
            _loc7_ = 0;
            _loc4_ = 0;
            while(_loc4_ < this._flixelUpdateMarker)
            {
               _loc7_ += this._flixelUpdate[_loc4_++];
            }
            _loc8_ = 0;
            _loc9_ = 0;
            _loc4_ = 0;
            while(_loc4_ < this._objectMarker)
            {
               _loc8_ += this._activeObject[_loc4_];
               _loc11_ += this._visibleObject[_loc4_++];
            }
            _loc8_ /= this._objectMarker;
            _loc5_ += "U:" + _loc8_ + " " + uint(_loc7_ / this._flixelDrawMarker) + "ms\n";
            _loc10_ = 0;
            _loc4_ = 0;
            while(_loc4_ < this._flixelDrawMarker)
            {
               _loc10_ += this._flixelDraw[_loc4_++];
            }
            _loc11_ = 0;
            _loc4_ = 0;
            while(_loc4_ < this._visibleObjectMarker)
            {
               _loc11_ += this._visibleObject[_loc4_++];
            }
            _loc11_ /= this._visibleObjectMarker;
            _loc5_ += "D:" + _loc11_ + " " + uint(_loc10_ / this._flixelDrawMarker) + "ms";
            this._text.text = _loc5_;
            this._flixelUpdateMarker = 0;
            this._flixelDrawMarker = 0;
            this._flashMarker = 0;
            this._objectMarker = 0;
            this._visibleObjectMarker = 0;
            this._updateTimer -= _loc3_;
         }
      }
      
      public function flixelUpdate(param1:int) : void
      {
         var _loc2_:* = this._flixelUpdateMarker++;
         this._flixelUpdate[_loc2_] = param1;
      }
      
      public function flixelDraw(param1:int) : void
      {
         var _loc2_:* = this._flixelDrawMarker++;
         this._flixelDraw[_loc2_] = param1;
      }
      
      public function flash(param1:int) : void
      {
         var _loc2_:* = this._flashMarker++;
         this._flash[_loc2_] = param1;
      }
      
      public function activeObjects(param1:int) : void
      {
         var _loc2_:* = this._objectMarker++;
         this._activeObject[_loc2_] = param1;
      }
      
      public function visibleObjects(param1:int) : void
      {
         var _loc2_:* = this._visibleObjectMarker++;
         this._visibleObject[_loc2_] = param1;
      }
   }
}
