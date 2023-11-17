package org.cove.ape
{
   internal final class Interval
   {
       
      
      internal var min:Number;
      
      internal var max:Number;
      
      public function Interval(param1:Number, param2:Number)
      {
         super();
         this.min = param1;
         this.max = param2;
      }
      
      internal function toString() : String
      {
         return this.min + " : " + this.max;
      }
   }
}
