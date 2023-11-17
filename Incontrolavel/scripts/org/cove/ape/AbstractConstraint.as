package org.cove.ape
{
   import flash.utils.getQualifiedClassName;
   
   public class AbstractConstraint extends AbstractItem
   {
       
      
      private var _stiffness:Number;
      
      public function AbstractConstraint(param1:Number)
      {
         super();
         if(getQualifiedClassName(this) == "org.cove.ape::AbstractConstraint")
         {
            throw new ArgumentError("AbstractConstraint can\'t be instantiated directly");
         }
         this.stiffness = param1;
         setStyle();
      }
      
      public function resolve() : void
      {
      }
      
      public function set stiffness(param1:Number) : void
      {
         this._stiffness = param1;
      }
      
      public function get stiffness() : Number
      {
         return this._stiffness;
      }
   }
}
