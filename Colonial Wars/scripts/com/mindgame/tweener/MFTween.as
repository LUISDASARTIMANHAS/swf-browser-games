package com.mindgame.tweener
{
   import com.mindgame.tweener.easing.*;
   import com.mindgame.tweener.shits.*;
   import flash.display.DisplayObject;
   import flash.utils.*;
   
   use namespace MotionInternal;
   
   public class MFTween
   {
      
      public static var defaultActuator:Class = SimpleHustle;
      
      public static var defaultEase:IEasing = Expo.easeOut;
      
      private static var targetLibraries:Dictionary = new Dictionary(true);
       
      
      public function MFTween()
      {
         super();
      }
      
      public static function apply(param1:Object, param2:Object, param3:Class = null) : GenericHustle
      {
         stop(param1,param2);
         var _loc5_:GenericHustle;
         var _loc4_:Class;
         (_loc5_ = new (_loc4_ = param3 || defaultActuator)(param1,0,param2)).MotionInternal::apply();
         return _loc5_;
      }
      
      public static function effects(param1:DisplayObject, param2:Number, param3:Boolean = true) : EffectsOptions
      {
         return new EffectsOptions(param1,param2,param3);
      }
      
      private static function getLibrary(param1:Object) : Dictionary
      {
         if(!targetLibraries[param1])
         {
            targetLibraries[param1] = new Dictionary(true);
         }
         return targetLibraries[param1];
      }
      
      public static function motionPath(param1:Object, param2:Number, param3:Object, param4:Boolean = true) : GenericHustle
      {
         return tween(param1,param2,param3,param4,MotionPathHustle);
      }
      
      public static function pause(... rest) : void
      {
         var _loc2_:GenericHustle = null;
         var _loc3_:Dictionary = null;
         var _loc4_:Object = null;
         if(rest.length > 0)
         {
            for each(_loc4_ in rest)
            {
               _loc3_ = getLibrary(_loc4_);
               for each(_loc2_ in _loc3_)
               {
                  _loc2_.MotionInternal::pause();
               }
            }
         }
         else
         {
            for each(_loc3_ in targetLibraries)
            {
               for each(_loc2_ in _loc3_)
               {
                  _loc2_.MotionInternal::pause();
               }
            }
         }
      }
      
      public static function reset() : void
      {
         var _loc1_:GenericHustle = null;
         var _loc2_:Dictionary = null;
         for each(_loc2_ in targetLibraries)
         {
            for each(_loc1_ in _loc2_)
            {
               _loc1_.MotionInternal::stop(null,false,false);
            }
         }
         targetLibraries = new Dictionary(true);
      }
      
      public static function resume(... rest) : void
      {
         var _loc2_:GenericHustle = null;
         var _loc3_:Dictionary = null;
         var _loc4_:Object = null;
         if(rest.length > 0)
         {
            for each(_loc4_ in rest)
            {
               _loc3_ = getLibrary(_loc4_);
               for each(_loc2_ in _loc3_)
               {
                  _loc2_.MotionInternal::resume();
               }
            }
         }
         else
         {
            for each(_loc3_ in targetLibraries)
            {
               for each(_loc2_ in _loc3_)
               {
                  _loc2_.MotionInternal::resume();
               }
            }
         }
      }
      
      public static function stop(param1:Object, param2:Object = null, param3:Boolean = false) : void
      {
         var _loc4_:GenericHustle = null;
         var _loc5_:Dictionary = null;
         var _loc6_:Object = null;
         var _loc7_:String = null;
         if(param1)
         {
            _loc5_ = getLibrary(param1);
            if(param2 is String)
            {
               (_loc6_ = new Object())[param2] = null;
               param2 = _loc6_;
            }
            else if(param2 is Array)
            {
               _loc6_ = new Object();
               for each(_loc7_ in param2)
               {
                  _loc6_[_loc7_] = null;
               }
               param2 = _loc6_;
            }
            for each(_loc4_ in _loc5_)
            {
               _loc4_.MotionInternal::stop(param2,param3,true);
            }
         }
      }
      
      public static function timer(param1:Number, param2:Class = null) : GenericHustle
      {
         return tween(new TweenTimer(0),param1,new TweenTimer(1),false,param2);
      }
      
      public static function transform(param1:Object, param2:Number = 0, param3:Boolean = true) : TransformOptions
      {
         return new TransformOptions(param1,param2,param3);
      }
      
      public static function tween(param1:Object, param2:Number, param3:Object, param4:Boolean = true, param5:Class = null) : GenericHustle
      {
         var _loc6_:Class = null;
         var _loc7_:GenericHustle = null;
         var _loc8_:Dictionary = null;
         var _loc9_:GenericHustle = null;
         if(param1)
         {
            if(param2 > 0)
            {
               _loc7_ = new (_loc6_ = param5 || defaultActuator)(param1,param2,param3);
               _loc8_ = getLibrary(_loc7_.target);
               if(param4)
               {
                  for each(_loc9_ in _loc8_)
                  {
                     _loc9_.MotionInternal::stop(_loc7_.properties,false,false);
                  }
               }
               _loc8_[_loc7_] = _loc7_;
               _loc7_.MotionInternal::move();
               return _loc7_;
            }
            return apply(param1,param3,param5);
         }
         return null;
      }
      
      MotionInternal static function unload(param1:GenericHustle) : void
      {
         var _loc2_:Dictionary = getLibrary(param1.target);
         delete _loc2_[param1];
      }
      
      public static function update(param1:Function, param2:Number, param3:Array = null, param4:Array = null, param5:Boolean = true) : GenericHustle
      {
         var _loc6_:Object = {
            "start":param3,
            "end":param4
         };
         return tween(param1,param2,_loc6_,param5,MethodHustle);
      }
   }
}

import com.mindgame.tweener.*;
import com.mindgame.tweener.shits.*;
import flash.display.DisplayObject;

class EffectsOptions
{
    
   
   protected var duration:Number;
   
   protected var overwrite:Boolean;
   
   protected var target:DisplayObject;
   
   public function EffectsOptions(param1:DisplayObject, param2:Number, param3:Boolean)
   {
      super();
      this.target = param1;
      this.duration = param2;
      this.overwrite = param3;
   }
   
   public function filter(param1:*, param2:Object) : GenericHustle
   {
      param2.filter = param1;
      return MFTween.tween(this.target,this.duration,param2,this.overwrite,FilterHustle);
   }
}

import com.mindgame.tweener.*;
import com.mindgame.tweener.shits.*;

class TransformOptions
{
    
   
   protected var duration:Number;
   
   protected var overwrite:Boolean;
   
   protected var target:Object;
   
   public function TransformOptions(param1:Object, param2:Number, param3:Boolean)
   {
      super();
      this.target = param1;
      this.duration = param2;
      this.overwrite = param3;
   }
   
   public function color(param1:Number = 0, param2:Number = 1, param3:* = null) : GenericHustle
   {
      var _loc4_:Object = {
         "colorValue":param1,
         "colorStrength":param2
      };
      if(param3 is Number)
      {
         _loc4_.colorAlpha = param3;
      }
      return MFTween.tween(this.target,this.duration,_loc4_,this.overwrite,TransformHustle);
   }
   
   public function sound(param1:* = null, param2:* = null) : GenericHustle
   {
      var _loc3_:Object = new Object();
      if(param1 is Number)
      {
         _loc3_.soundVolume = param1;
      }
      if(param2 is Number)
      {
         _loc3_.soundPan = param2;
      }
      return MFTween.tween(this.target,this.duration,_loc3_,this.overwrite,TransformHustle);
   }
}

class TweenTimer
{
    
   
   public var progress:Number;
   
   public function TweenTimer(param1:Number)
   {
      super();
      this.progress = param1;
   }
}
