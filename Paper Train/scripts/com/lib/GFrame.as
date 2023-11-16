package com.lib
{
   import flash.display.*;
   import flash.events.*;
   
   public class GFrame extends Sprite
   {
       
      
      private var framecount:*;
      
      private var timerList:Array;
      
      private var permanentFrameCallback:Function;
      
      private var enterFrameCallback:Function;
      
      private var pauseCallback:Function;
      
      private var prevTime:*;
      
      private var fixElapsed:*;
      
      private var physics_frame_rate:*;
      
      private var paused:*;
      
      private var fixFrameCallback:Function;
      
      private var realElapsed:*;
      
      public function GFrame(param1:Function = null, param2:Function = null, param3:Function = null, param4:Number = 60)
      {
         super();
         this.framecount = 0;
         this.prevTime = 0;
         this.reset();
         this.enterFrameCallback = param1;
         this.fixFrameCallback = param2;
         this.pauseCallback = param3;
         this.physics_frame_rate = param4;
         addEventListener(Event.ENTER_FRAME,this.enterFrame);
      }
      
      public function destroy() : *
      {
         removeEventListener(Event.ENTER_FRAME,this.enterFrame);
      }
      
      public function pause(param1:Boolean) : *
      {
         if(param1 && this.paused || !param1 && !this.paused)
         {
            return;
         }
         this.paused = param1;
         if(this.pauseCallback != null)
         {
            this.pauseCallback(this.paused);
         }
      }
      
      public function getTime() : *
      {
         return this.realElapsed / 1000;
      }
      
      public function reset() : *
      {
         this.realElapsed = 0;
         this.fixElapsed = 0;
         this.pause(false);
         this.resetTimer();
      }
      
      private function stepFrame() : *
      {
         ++this.framecount;
         var _loc1_:* = new Date();
         var _loc2_:* = int(_loc1_.time);
         var _loc3_:* = _loc2_ - this.prevTime;
         if(this.prevTime == 0)
         {
            this.prevTime = _loc2_;
            return null;
         }
         this.prevTime = _loc2_;
         return _loc3_;
      }
      
      public function getFrameCount() : *
      {
         return this.framecount;
      }
      
      private function fixFrame(param1:Number) : *
      {
      }
      
      public function removeTimer(param1:Function) : *
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this.timerList)
         {
            if(_loc2_.used)
            {
               if(_loc2_.func == param1)
               {
                  _loc2_.used = false;
                  break;
               }
            }
         }
      }
      
      public function resetTimer() : *
      {
         this.timerList = new Array();
      }
      
      public function addTimer(param1:Number, param2:Function, param3:int = 1) : Function
      {
         var _loc5_:* = undefined;
         var _loc4_:* = new Object();
         for each(_loc5_ in this.timerList)
         {
            if(!_loc5_.used)
            {
               _loc4_ = _loc5_;
               break;
            }
         }
         _loc4_.used = true;
         _loc4_.func = param2;
         _loc4_.time = this.realElapsed + 1000 * param1;
         _loc4_.delay = 1000 * param1;
         _loc4_.count = param3;
         _loc4_.endless = param3 == 0 ? true : false;
         this.timerList.push(_loc4_);
         return param2;
      }
      
      private function timerFrame() : *
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this.timerList)
         {
            if(_loc1_.used)
            {
               while((_loc1_.endless || _loc1_.count > 0) && this.realElapsed >= _loc1_.time)
               {
                  _loc1_.func();
                  _loc1_.time += _loc1_.delay;
                  --_loc1_.count;
               }
               if(!_loc1_.endless && _loc1_.count == 0)
               {
                  _loc1_.used = false;
               }
            }
         }
      }
      
      public function addPermanentFrame(param1:Function) : *
      {
         this.permanentFrameCallback = param1;
      }
      
      private function enterFrame(param1:*) : *
      {
         var _loc2_:* = this.stepFrame();
         if(_loc2_ === null)
         {
            return;
         }
         if(this.permanentFrameCallback != null)
         {
            this.permanentFrameCallback(_loc2_ / 1000);
         }
         if(this.paused)
         {
            return;
         }
         var _loc3_:* = 1000 / this.physics_frame_rate;
         this.realElapsed += _loc2_;
         while(this.fixElapsed < this.realElapsed)
         {
            if(this.fixFrameCallback != null)
            {
               this.fixFrameCallback(_loc3_ / 1000);
            }
            this.fixElapsed += _loc3_;
         }
         this.timerFrame();
         if(this.enterFrameCallback != null)
         {
            this.enterFrameCallback(_loc2_ / 1000);
         }
      }
      
      public function isPaused() : *
      {
         return this.paused;
      }
   }
}
