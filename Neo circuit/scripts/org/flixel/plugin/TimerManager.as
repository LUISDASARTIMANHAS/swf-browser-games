package org.flixel.plugin
{
   import org.flixel.*;
   
   public class TimerManager extends FlxBasic
   {
       
      
      protected var _timers:Array;
      
      public function TimerManager()
      {
         super();
         this._timers = new Array();
         visible = false;
      }
      
      override public function destroy() : void
      {
         this.clear();
         this._timers = null;
      }
      
      override public function update() : void
      {
         var _loc2_:FlxTimer = null;
         var _loc1_:int = this._timers.length - 1;
         while(_loc1_ >= 0)
         {
            _loc2_ = this._timers[_loc1_--] as FlxTimer;
            §§push(_loc2_ != null);
            if(_loc2_ != null)
            {
               §§pop();
               while(true)
               {
                  §§push(!_loc2_.paused);
               }
               addr49:
            }
            while(§§pop() && !_loc2_.finished)
            {
               _loc2_.update();
               if(true)
               {
                  break;
               }
               §§goto(addr49);
            }
         }
      }
      
      public function add(param1:FlxTimer) : void
      {
         this._timers.push(param1);
      }
      
      public function remove(param1:FlxTimer) : void
      {
         var _loc2_:int = int(this._timers.indexOf(param1));
         if(_loc2_ >= 0)
         {
            this._timers.splice(_loc2_,1);
         }
      }
      
      public function clear() : void
      {
         var _loc2_:FlxTimer = null;
         var _loc1_:int = this._timers.length - 1;
         while(_loc1_ >= 0)
         {
            _loc2_ = this._timers[_loc1_--] as FlxTimer;
            if(_loc2_ != null)
            {
               _loc2_.destroy();
            }
         }
         this._timers.length = 0;
      }
   }
}
