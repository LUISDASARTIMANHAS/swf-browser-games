package org.cove.ape
{
   public class Composite extends AbstractCollection
   {
       
      
      private var delta:Vector2;
      
      public function Composite()
      {
         super();
         this.delta = new Vector2();
      }
      
      public function rotateByAngle(param1:Number, param2:Vector2) : void
      {
         var _loc3_:Number = param1 * MathUtil.PI_OVER_ONE_EIGHTY;
         this.rotateByRadian(_loc3_,param2);
      }
      
      public function rotateByRadian(param1:Number, param2:Vector2) : void
      {
         var _loc3_:AbstractParticle = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc4_:Vector.<AbstractParticle>;
         var _loc5_:int = int((_loc4_ = particles).length);
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc3_ = _loc4_[_loc6_];
            _loc7_ = _loc3_.center.distance(param2);
            _loc8_ = this.getRelativeAngle(param2,_loc3_.center) + param1;
            _loc3_.px = Math.cos(_loc8_) * _loc7_ + param2.x;
            _loc3_.py = Math.sin(_loc8_) * _loc7_ + param2.y;
            _loc6_++;
         }
      }
      
      public function get fixed() : Boolean
      {
         var _loc1_:int = 0;
         while(_loc1_ < particles.length)
         {
            if(!particles[_loc1_].fixed)
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
      
      private function getRelativeAngle(param1:Vector2, param2:Vector2) : Number
      {
         this.delta.setTo(param2.x - param1.x,param2.y - param1.y);
         return Math.atan2(this.delta.y,this.delta.x);
      }
      
      public function set fixed(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < particles.length)
         {
            particles[_loc2_].fixed = param1;
            _loc2_++;
         }
      }
   }
}
