package org.cove.ape
{
   internal final class CollisionResolver
   {
       
      
      public function CollisionResolver()
      {
         super();
      }
      
      internal static function resolve(param1:AbstractParticle, param2:AbstractParticle, param3:Vector2, param4:Number) : void
      {
         var _loc5_:Vector2 = param3.mult(param4);
         var _loc6_:Number = param1.elasticity + param2.elasticity;
         var _loc7_:Number = param1.invMass + param2.invMass;
         var _loc8_:Number = MathUtil.clamp(1 - (param1.friction + param2.friction),0,1);
         var _loc9_:Collision = param1.getComponents(param3);
         var _loc10_:Collision;
         var _loc11_:Vector2 = (_loc10_ = param2.getComponents(param3)).vn.mult((_loc6_ + 1) * param1.invMass).plus(_loc9_.vn.mult(param2.invMass - _loc6_ * param1.invMass)).divEquals(_loc7_);
         var _loc12_:Vector2 = _loc9_.vn.mult((_loc6_ + 1) * param2.invMass).plus(_loc10_.vn.mult(param1.invMass - _loc6_ * param2.invMass)).divEquals(_loc7_);
         _loc9_.vt.multEquals(_loc8_);
         _loc10_.vt.multEquals(_loc8_);
         var _loc13_:Vector2 = _loc5_.mult(param1.invMass / _loc7_);
         var _loc14_:Vector2 = _loc5_.mult(-param2.invMass / _loc7_);
         _loc11_.plusEquals(_loc9_.vt);
         _loc12_.plusEquals(_loc10_.vt);
         param1.resolveCollision(_loc13_,_loc11_,param3,param4,-1,param2);
         param2.resolveCollision(_loc14_,_loc12_,param3,param4,1,param1);
      }
   }
}
