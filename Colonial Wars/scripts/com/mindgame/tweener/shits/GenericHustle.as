package com.mindgame.tweener.shits
{
   import com.mindgame.tweener.*;
   import com.mindgame.tweener.easing.IEasing;
   
   use namespace MotionInternal;
   
   public class GenericHustle
   {
       
      
      MotionInternal var duration:Number;
      
      MotionInternal var properties:Object;
      
      MotionInternal var target:Object;
      
      MotionInternal var autoVisible:Boolean = true;
      
      MotionInternal var delay:Number = 0;
      
      MotionInternal var ease:IEasing;
      
      MotionInternal var onUpdate:Function;
      
      MotionInternal var onUpdateParams:Array;
      
      MotionInternal var onComplete:Function;
      
      MotionInternal var onCompleteParams:Array;
      
      MotionInternal var reflect:Boolean = false;
      
      MotionInternal var repeat:int = 0;
      
      MotionInternal var reverse:Boolean = false;
      
      MotionInternal var smartRotation:Boolean = false;
      
      MotionInternal var snapping:Boolean = false;
      
      MotionInternal var special:Boolean = false;
      
      public function GenericHustle(param1:Object, param2:Number, param3:Object)
      {
         super();
         this.target = param1;
         this.properties = param3;
         this.duration = param2;
         this.MotionInternal::ease = MFTween.defaultEase;
      }
      
      MotionInternal function apply() : void
      {
         var _loc1_:String = null;
         for(_loc1_ in this.properties)
         {
            this.target[_loc1_] = this.properties[_loc1_];
         }
      }
      
      public function autoVisible(param1:Boolean = true) : GenericHustle
      {
         this.MotionInternal::autoVisible = param1;
         return this;
      }
      
      protected function change() : void
      {
         if(this.MotionInternal::onUpdate != null)
         {
            this.MotionInternal::onUpdate.apply(null,this.MotionInternal::onUpdateParams);
         }
      }
      
      protected function complete(param1:Boolean = true) : void
      {
         if(param1)
         {
            this.change();
            if(this.MotionInternal::onComplete != null)
            {
               this.MotionInternal::onComplete.apply(null,this.MotionInternal::onCompleteParams);
            }
         }
         MFTween.unload(this);
      }
      
      public function delay(param1:Number) : GenericHustle
      {
         this.MotionInternal::delay = param1;
         return this;
      }
      
      public function ease(param1:IEasing) : GenericHustle
      {
         this.MotionInternal::ease = param1;
         return this;
      }
      
      MotionInternal function move() : void
      {
      }
      
      public function onUpdate(param1:Function, ... rest) : GenericHustle
      {
         this.MotionInternal::onUpdate = param1;
         this.MotionInternal::onUpdateParams = rest;
         return this;
      }
      
      public function onComplete(param1:Function, ... rest) : GenericHustle
      {
         this.MotionInternal::onComplete = param1;
         this.MotionInternal::onCompleteParams = rest;
         if(this.MotionInternal::duration == 0)
         {
            this.complete();
         }
         return this;
      }
      
      MotionInternal function pause() : void
      {
      }
      
      public function reflect(param1:Boolean = true) : GenericHustle
      {
         this.MotionInternal::reflect = true;
         this.MotionInternal::special = true;
         return this;
      }
      
      public function repeat(param1:int = -1) : GenericHustle
      {
         this.MotionInternal::repeat = param1;
         return this;
      }
      
      MotionInternal function resume() : void
      {
      }
      
      public function reverse(param1:Boolean = true) : GenericHustle
      {
         this.MotionInternal::reverse = param1;
         this.special = true;
         return this;
      }
      
      public function smartRotation(param1:Boolean = true) : GenericHustle
      {
         this.MotionInternal::smartRotation = param1;
         this.special = true;
         return this;
      }
      
      public function snapping(param1:Boolean = true) : GenericHustle
      {
         this.MotionInternal::snapping = param1;
         this.special = true;
         return this;
      }
      
      MotionInternal function stop(param1:Object, param2:Boolean, param3:Boolean) : void
      {
      }
   }
}
