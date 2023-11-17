package org.cove.ape
{
   public class Vector2Force implements IForce
   {
       
      
      private var fvx:Number;
      
      private var fvy:Number;
      
      private var value:Vector2;
      
      private var scaleMass:Boolean;
      
      public function Vector2Force(param1:Boolean, param2:Number, param3:Number)
      {
         super();
         this.fvx = param2;
         this.fvy = param3;
         this.scaleMass = param1;
         this.value = new Vector2(param2,param3);
      }
      
      public function set vx(param1:Number) : void
      {
         this.fvx = param1;
         this.value.x = param1;
      }
      
      public function set vy(param1:Number) : void
      {
         this.fvy = param1;
         this.value.y = param1;
      }
      
      public function set useMass(param1:Boolean) : void
      {
         this.scaleMass = param1;
      }
      
      public function getValue(param1:Number) : Vector2
      {
         if(this.scaleMass)
         {
            this.value.setTo(this.fvx * param1,this.fvy * param1);
         }
         return this.value;
      }
   }
}
