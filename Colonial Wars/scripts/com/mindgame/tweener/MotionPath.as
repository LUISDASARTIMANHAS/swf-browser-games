package com.mindgame.tweener
{
   import com.mindgame.tweener.shits.MotionInternal;
   
   use namespace MotionInternal;
   
   public class MotionPath
   {
       
      
      public var start:Number;
      
      protected var paths:Array;
      
      protected var totalStrength:Number;
      
      public function MotionPath()
      {
         super();
         this.paths = new Array();
         this.start = 0;
         this.totalStrength = 0;
      }
      
      public static function bezier(param1:Number, param2:Number, param3:Number = 1) : MotionPath
      {
         return new MotionPath().bezier(param1,param2,param3);
      }
      
      public static function line(param1:Number, param2:Number = 1) : MotionPath
      {
         return new MotionPath().line(param1,param2);
      }
      
      protected function addPath(param1:BezierPath) : void
      {
         this.paths.push(param1);
         this.totalStrength += param1.strength;
      }
      
      public function bezier(param1:Number, param2:Number, param3:Number = 1) : MotionPath
      {
         this.addPath(new BezierPath(param1,param2,param3));
         return this;
      }
      
      MotionInternal function calculate(param1:Number) : Number
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:BezierPath = null;
         if(this.paths.length === 1)
         {
            return (this.paths[0] as Object).calculate(this.start,param1);
         }
         _loc2_ = param1 * this.totalStrength;
         _loc3_ = this.start;
         for each(_loc4_ in this.paths)
         {
            if(_loc2_ <= _loc4_.strength)
            {
               return _loc4_.calculate(_loc3_,_loc2_ / _loc4_.strength);
            }
            _loc2_ -= _loc4_.strength;
            _loc3_ = _loc4_.end;
         }
         return 0;
      }
      
      public function line(param1:Number, param2:Number = 1) : MotionPath
      {
         this.addPath(new LinearPath(param1,param2));
         return this;
      }
      
      MotionInternal function get end() : Number
      {
         var _loc1_:BezierPath = null;
         if(this.paths.length > 0)
         {
            _loc1_ = this.paths[this.paths.length - 1];
            return _loc1_.end;
         }
         return NaN;
      }
   }
}

class BezierPath
{
    
   
   public var control:Number;
   
   public var end:Number;
   
   public var strength:Number;
   
   public function BezierPath(param1:Number, param2:Number, param3:Number)
   {
      super();
      this.end = param1;
      this.control = param2;
      this.strength = param3;
   }
   
   public function calculate(param1:Number, param2:Number) : Number
   {
      return (1 - param2) * (1 - param2) * param1 + 2 * (1 - param2) * param2 * this.control + param2 * param2 * this.end;
   }
}

class LinearPath extends BezierPath
{
    
   
   public function LinearPath(param1:Number, param2:Number)
   {
      super(param1,0,param2);
   }
   
   override public function calculate(param1:Number, param2:Number) : Number
   {
      return param1 + param2 * (end - param1);
   }
}
