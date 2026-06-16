package com.mindgame.tweener.shits
{
   use namespace MotionInternal;
   
   public class MethodHustle extends SimpleHustle
   {
       
      
      protected var tweenProperties:Object;
      
      public function MethodHustle(param1:Object, param2:Number, param3:Object)
      {
         this.tweenProperties = new Object();
         super(param1,param2,param3);
         if(!param3.start)
         {
            param3.start = new Array();
         }
         if(!param3.end)
         {
            param3.end = param3.start;
         }
      }
      
      override MotionInternal function apply() : void
      {
         (target as Function).apply(null,properties.end);
      }
      
      override protected function initialize() : void
      {
         var _loc1_:PropertyDetails = null;
         var _loc2_:String = null;
         var _loc3_:Object = null;
         var _loc4_:uint = 0;
         while(_loc4_ < (properties.start as Array).length)
         {
            _loc2_ = "param" + _loc4_;
            _loc3_ = properties.start[_loc4_];
            this.tweenProperties[_loc2_] = _loc3_;
            if(_loc3_ is Number)
            {
               _loc1_ = new PropertyDetails(this.tweenProperties,_loc2_,_loc3_ as Number,Number(properties.end[_loc4_]) - (_loc3_ as Number));
               propertyDetails.push(_loc1_);
            }
            _loc4_++;
         }
         detailsLength = propertyDetails.length;
         initialized = true;
      }
      
      override MotionInternal function update(param1:Number) : void
      {
         super.update(param1);
         var _loc2_:Array = new Array();
         var _loc3_:uint = 0;
         while(_loc3_ < properties.start.length)
         {
            _loc2_.push(this.tweenProperties["param" + _loc3_]);
            _loc3_++;
         }
         (target as Function).apply(null,_loc2_);
      }
   }
}
