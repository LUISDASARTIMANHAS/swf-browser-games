package com.mindgame.tweener.shits
{
   public class PropertyDetails
   {
       
      
      public var target:Object;
      
      public var propertyName:String;
      
      public var start:Number;
      
      public var change:Number;
      
      public function PropertyDetails(param1:Object, param2:String, param3:Number, param4:Number)
      {
         super();
         this.target = param1;
         this.propertyName = param2;
         this.start = param3;
         this.change = param4;
      }
   }
}
