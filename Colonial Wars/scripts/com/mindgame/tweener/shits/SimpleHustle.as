package com.mindgame.tweener.shits
{
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   
   use namespace MotionInternal;
   
   public class SimpleHustle extends GenericHustle
   {
      
      protected static var shits:Array = new Array();
      
      protected static var shitsLength:uint = 0;
      
      protected static var shape:Shape;
       
      
      MotionInternal var timeOffset:Number;
      
      protected var active:Boolean = true;
      
      protected var cacheVisible:Boolean;
      
      protected var detailsLength:uint;
      
      protected var initialized:Boolean;
      
      protected var paused:Boolean;
      
      protected var pauseTime:Number;
      
      protected var propertyDetails:Array;
      
      protected var sendChange:Boolean = false;
      
      protected var setVisible:Boolean;
      
      protected var startTime:Number;
      
      protected var toggleVisible:Boolean;
      
      public function SimpleHustle(param1:Object, param2:Number, param3:Object)
      {
         this.propertyDetails = new Array();
         this.startTime = getTimer() / 1000;
         super(param1,param2,param3);
         if(!shape)
         {
            shape = new Shape();
            shape.addEventListener(Event.ENTER_FRAME,shape_onEnterFrame);
         }
      }
      
      protected static function shape_onEnterFrame(param1:Event) : void
      {
         var _loc3_:SimpleHustle = null;
         var _loc2_:Number = getTimer() / 1000;
         var _loc4_:uint = 0;
         while(_loc4_ < shitsLength)
         {
            _loc3_ = shits[_loc4_];
            if(_loc3_.active)
            {
               if(_loc2_ > _loc3_.timeOffset)
               {
                  _loc3_.MotionInternal::update(_loc2_);
               }
            }
            else
            {
               shits.splice(_loc4_,1);
               --shitsLength;
               _loc4_--;
            }
            _loc4_++;
         }
      }
      
      override public function autoVisible(param1:Boolean = true) : GenericHustle
      {
         MotionInternal::autoVisible = param1;
         if(!param1)
         {
            this.toggleVisible = false;
            if(this.setVisible)
            {
               target.visible = this.cacheVisible;
            }
         }
         return this;
      }
      
      override public function delay(param1:Number) : GenericHustle
      {
         MotionInternal::delay = param1;
         this.timeOffset = this.startTime + param1;
         return this;
      }
      
      protected function initialize() : void
      {
         var _loc1_:PropertyDetails = null;
         var _loc2_:Number = NaN;
         var _loc3_:String = null;
         for(_loc3_ in properties)
         {
            _loc2_ = Number(Number(target[_loc3_]));
            _loc1_ = new PropertyDetails(target,_loc3_,_loc2_,Number(properties[_loc3_] - _loc2_));
            this.propertyDetails.push(_loc1_);
         }
         this.detailsLength = this.propertyDetails.length;
         this.initialized = true;
      }
      
      override MotionInternal function move() : void
      {
         this.toggleVisible = "alpha" in properties && target is DisplayObject;
         if(Boolean(this.toggleVisible) && !target.visible && properties.alpha != 0)
         {
            this.setVisible = true;
            this.cacheVisible = target.visible;
            target.visible = true;
         }
         this.timeOffset = this.startTime;
         shits.push(this);
         ++shitsLength;
      }
      
      override public function onUpdate(param1:Function, ... rest) : GenericHustle
      {
         MotionInternal::onUpdate = param1;
         MotionInternal::onUpdateParams = rest;
         this.sendChange = true;
         return this;
      }
      
      override MotionInternal function pause() : void
      {
         this.paused = true;
         this.pauseTime = getTimer();
      }
      
      override MotionInternal function resume() : void
      {
         if(this.paused)
         {
            this.paused = false;
            this.timeOffset += (getTimer() - this.pauseTime) / 1000;
         }
      }
      
      override MotionInternal function stop(param1:Object, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:String = null;
         if(this.active)
         {
            for(_loc4_ in param1)
            {
               if(_loc4_ in this.properties)
               {
                  this.active = false;
                  if(param2)
                  {
                     apply();
                  }
                  this.complete(param3);
                  return;
               }
            }
            if(!param1)
            {
               this.active = false;
               if(param2)
               {
                  apply();
               }
               this.complete(param3);
               return;
            }
         }
      }
      
      MotionInternal function update(param1:Number) : void
      {
         var _loc2_:PropertyDetails = null;
         var _loc3_:Number = NaN;
         var _loc4_:uint = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         if(!this.paused)
         {
            if((_loc5_ = (param1 - this.timeOffset) / duration) > 1)
            {
               _loc5_ = 1;
            }
            if(!this.initialized)
            {
               this.initialize();
            }
            if(!MotionInternal::special)
            {
               _loc3_ = Number(MotionInternal::ease.calculate(_loc5_));
               _loc4_ = 0;
               while(_loc4_ < this.detailsLength)
               {
                  _loc2_ = this.propertyDetails[_loc4_];
                  _loc2_.target[_loc2_.propertyName] = _loc2_.start + _loc2_.change * _loc3_;
                  _loc4_++;
               }
            }
            else
            {
               if(!MotionInternal::reverse)
               {
                  _loc3_ = Number(MotionInternal::ease.calculate(_loc5_));
               }
               else
               {
                  _loc3_ = Number(MotionInternal::ease.calculate(1 - _loc5_));
               }
               _loc4_ = 0;
               while(_loc4_ < this.detailsLength)
               {
                  _loc2_ = this.propertyDetails[_loc4_];
                  if(Boolean(MotionInternal::smartRotation) && (_loc2_.propertyName == "rotation" || _loc2_.propertyName == "rotationX" || _loc2_.propertyName == "rotationY" || _loc2_.propertyName == "rotationZ"))
                  {
                     if((_loc7_ = _loc2_.change % 360) > 180)
                     {
                        _loc7_ -= 360;
                     }
                     else if(_loc7_ < -180)
                     {
                        _loc7_ += 360;
                     }
                     _loc6_ = _loc2_.start + _loc7_ * _loc3_;
                  }
                  else
                  {
                     _loc6_ = _loc2_.start + _loc2_.change * _loc3_;
                  }
                  if(!MotionInternal::snapping)
                  {
                     _loc2_.target[_loc2_.propertyName] = _loc6_;
                  }
                  else
                  {
                     _loc2_.target[_loc2_.propertyName] = Math.round(_loc6_);
                  }
                  _loc4_++;
               }
            }
            if(_loc5_ === 1)
            {
               if(MotionInternal::repeat === 0)
               {
                  this.active = false;
                  if(Boolean(this.toggleVisible) && target.alpha === 0)
                  {
                     target.visible = false;
                  }
                  complete(true);
                  return;
               }
               if(MotionInternal::reflect)
               {
                  MotionInternal::reverse = !MotionInternal::reverse;
               }
               this.startTime = param1;
               this.timeOffset = this.startTime + MotionInternal::delay;
               if(MotionInternal::repeat > 0)
               {
                  --MotionInternal::repeat;
               }
            }
            if(this.sendChange)
            {
               change();
            }
         }
      }
   }
}
