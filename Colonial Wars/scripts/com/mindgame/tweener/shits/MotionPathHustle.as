package com.mindgame.tweener.shits
{
   import com.mindgame.tweener.*;
   
   use namespace MotionInternal;
   
   public class MotionPathHustle extends SimpleHustle
   {
       
      
      public function MotionPathHustle(param1:Object, param2:Number, param3:Object)
      {
         super(param1,param2,param3);
      }
      
      override MotionInternal function apply() : void
      {
         var _loc1_:String = null;
         for(_loc1_ in properties)
         {
            target[_loc1_] = (properties[_loc1_] as MotionPath).MotionInternal::end;
         }
      }
      
      override protected function initialize() : void
      {
         var _loc1_:PropertyPathDetails = null;
         var _loc2_:MotionPath = null;
         var _loc3_:String = null;
         for(_loc3_ in properties)
         {
            _loc2_ = properties[_loc3_] as MotionPath;
            if(_loc2_)
            {
               _loc2_.start = Number(target[_loc3_]);
               _loc1_ = new PropertyPathDetails(target,_loc3_,_loc2_);
               propertyDetails.push(_loc1_);
            }
         }
         detailsLength = propertyDetails.length;
         initialized = true;
      }
      
      override MotionInternal function update(param1:Number) : void
      {
         var _loc2_:PropertyPathDetails = null;
         var _loc3_:Number = NaN;
         var _loc4_:uint = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         if(!paused)
         {
            if((_loc5_ = (param1 - timeOffset) / duration) > 1)
            {
               _loc5_ = 1;
            }
            if(!initialized)
            {
               this.initialize();
            }
            if(!MotionInternal::special)
            {
               _loc3_ = Number(MotionInternal::ease.calculate(_loc5_));
               _loc4_ = 0;
               while(_loc4_ < detailsLength)
               {
                  _loc2_ = propertyDetails[_loc4_];
                  _loc2_.target[_loc2_.propertyName] = _loc2_.path.MotionInternal::calculate(_loc3_);
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
               while(_loc4_ < detailsLength)
               {
                  _loc2_ = propertyDetails[_loc4_];
                  if(!MotionInternal::snapping)
                  {
                     _loc2_.target[_loc2_.propertyName] = _loc2_.path.MotionInternal::calculate(_loc3_);
                  }
                  else
                  {
                     _loc2_.target[_loc2_.propertyName] = Math.round(_loc2_.path.MotionInternal::calculate(_loc3_));
                  }
                  _loc4_++;
               }
            }
            if(_loc5_ === 1)
            {
               if(MotionInternal::repeat === 0)
               {
                  active = false;
                  if(toggleVisible && target.alpha === 0)
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
               startTime = param1;
               timeOffset = startTime + MotionInternal::delay;
               if(MotionInternal::repeat > 0)
               {
                  --MotionInternal::repeat;
               }
            }
            if(sendChange)
            {
               change();
            }
         }
      }
   }
}

import com.mindgame.tweener.MotionPath;

class PropertyPathDetails
{
    
   
   public var target:Object;
   
   public var path:MotionPath;
   
   public var propertyName:String;
   
   public function PropertyPathDetails(param1:Object, param2:String, param3:MotionPath)
   {
      super();
      this.target = param1;
      this.propertyName = param2;
      this.path = param3;
   }
}
