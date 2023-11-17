package org.cove.ape
{
   public class RigidCollisionResolver
   {
       
      
      public function RigidCollisionResolver()
      {
         super();
      }
      
      public static function resolve(param1:*, param2:*, param3:*, param4:*, param5:*) : *
      {
         var _loc6_:Vector2 = param4.mult(param5);
         var _loc7_:Number = param1.elasticity + param2.elasticity;
         var _loc8_:Number = param1.invMass + param2.invMass;
         var _loc9_:* = param1.getVelocityOn(param3);
         var _loc10_:* = param2.getVelocityOn(param3);
         var _loc11_:* = _loc9_.minus(_loc10_);
         var _loc12_:* = param4.mult(_loc11_.dot(param4));
         var _loc13_:* = _loc11_.minus(_loc12_).normalize();
         var _loc14_:* = param4.plus(_loc13_.mult(-0.1)).normalize();
         var _loc15_:* = param3.minus(param1.samp);
         var _loc16_:* = param3.minus(param2.samp);
         var _loc17_:* = _loc15_.cross(_loc14_);
         var _loc18_:* = _loc16_.cross(_loc14_);
         var _loc19_:* = -_loc11_.dot(_loc14_) * (1 + _loc7_ / 2) / (_loc8_ + _loc17_ * _loc17_ / param1.mi + _loc18_ * _loc18_ / param2.mi);
         var _loc20_:* = param1.velocity.plus(_loc14_.mult(_loc19_ * param1.invMass));
         var _loc21_:* = param2.velocity.plus(_loc14_.mult(-_loc19_ * param2.invMass));
         var _loc22_:* = _loc19_ * _loc17_ / param1.mi;
         var _loc23_:* = -_loc19_ * _loc18_ / param2.mi;
         if(Math.abs(_loc22_) > 0.1 || Math.abs(_loc23_) > 0.1)
         {
         }
         param1.resolveRigidCollision(_loc22_,param2);
         param2.resolveRigidCollision(_loc23_,param1);
         var _loc24_:Vector2 = _loc6_.mult(param1.invMass / _loc8_);
         var _loc25_:Vector2 = _loc6_.mult(-param2.invMass / _loc8_);
         param1.resolveCollision(_loc24_,_loc20_,param4,param5,-1,param2);
         param2.resolveCollision(_loc25_,_loc21_,param4,param5,1,param1);
      }
   }
}
