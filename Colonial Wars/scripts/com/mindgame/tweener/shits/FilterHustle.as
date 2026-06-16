package com.mindgame.tweener.shits
{
   import flash.display.*;
   import flash.filters.BitmapFilter;
   
   use namespace MotionInternal;
   
   public class FilterHustle extends SimpleHustle
   {
       
      
      protected var filter:BitmapFilter;
      
      protected var filterClass:Class;
      
      protected var filterIndex:int = -1;
      
      public function FilterHustle(param1:Object, param2:Number, param3:Object)
      {
         var _loc4_:BitmapFilter = null;
         super(param1,param2,param3);
         if(param3.filter is Class)
         {
            this.filterClass = param3.filter;
            for each(_loc4_ in (param1 as DisplayObject).filters)
            {
               if(_loc4_ is this.filterClass)
               {
                  this.filter = _loc4_;
               }
            }
         }
         else
         {
            this.filterIndex = param3.filter;
            this.filter = (param1 as DisplayObject).filters[this.filterIndex];
         }
      }
      
      override MotionInternal function apply() : void
      {
         var _loc1_:String = null;
         var _loc2_:Array = null;
         for(_loc1_ in properties)
         {
            if(_loc1_ != "filter")
            {
               this.filter[_loc1_] = properties[_loc1_];
            }
         }
         _loc2_ = target.filters;
         _loc2_[properties.filter] = this.filter;
         target.filters = _loc2_;
      }
      
      override protected function initialize() : void
      {
         var _loc1_:PropertyDetails = null;
         var _loc2_:Number = NaN;
         var _loc3_:String = null;
         for(_loc3_ in properties)
         {
            if(_loc3_ != "filter")
            {
               _loc2_ = Number(Number(this.filter[_loc3_]));
               _loc1_ = new PropertyDetails(this.filter,_loc3_,_loc2_,Number(properties[_loc3_] - _loc2_));
               propertyDetails.push(_loc1_);
            }
         }
         detailsLength = propertyDetails.length;
         initialized = true;
      }
      
      override MotionInternal function update(param1:Number) : void
      {
         var _loc3_:uint = 0;
         super.update(param1);
         var _loc2_:Array = (target as DisplayObject).filters;
         if(this.filterIndex > -1)
         {
            _loc2_[properties.filter] = this.filter;
         }
         else
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               if(_loc2_[_loc3_] is this.filterClass)
               {
                  _loc2_[_loc3_] = this.filter;
               }
               _loc3_++;
            }
         }
         target.filters = _loc2_;
      }
   }
}
