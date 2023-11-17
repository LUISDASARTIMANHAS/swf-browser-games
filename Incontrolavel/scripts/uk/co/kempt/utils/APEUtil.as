package uk.co.kempt.utils
{
   import org.cove.ape.APEngine;
   import org.cove.ape.Group;
   
   public class APEUtil
   {
       
      
      public function APEUtil()
      {
         super();
      }
      
      public static function addCollidableList(param1:Group, param2:Array) : void
      {
         var _loc3_:int = 0;
         while(_loc3_ < param2.length)
         {
            param1.addCollidable(param2[_loc3_]);
            _loc3_++;
         }
      }
      
      public static function removeFromGroup(param1:Group, param2:Group) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param2.composites.length)
         {
            param1.removeComposite(param2.composites[_loc3_]);
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < param2.constraints.length)
         {
            param1.removeConstraint(param2.constraints[_loc3_]);
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < param2.particles.length)
         {
            param1.removeParticle(param2.particles[_loc3_]);
            _loc3_++;
         }
      }
      
      public static function removeCollidableList(param1:Group, param2:Array) : void
      {
         var _loc3_:int = 0;
         while(_loc3_ < param2.length)
         {
            param1.removeCollidable(param2[_loc3_]);
            _loc3_++;
         }
      }
      
      public static function addFromGroup(param1:Group, param2:Group) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param2.composites.length)
         {
            param1.addComposite(param2.composites[_loc3_]);
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < param2.constraints.length)
         {
            param1.addConstraint(param2.constraints[_loc3_]);
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < param2.particles.length)
         {
            param1.addParticle(param2.particles[_loc3_]);
            _loc3_++;
         }
      }
      
      public static function removeCollidableListFromAPE(param1:Array) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            APEngine.removeGroup(param1[_loc2_]);
            _loc2_++;
         }
      }
      
      public static function addCollidableListToAPE(param1:Array) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            APEngine.addGroup(param1[_loc2_]);
            _loc2_++;
         }
      }
      
      public static function removeParticlesFromGroup(param1:Group, param2:Array) : void
      {
         var _loc3_:int = 0;
         while(_loc3_ < param2.length)
         {
            param1.removeParticle(param2[_loc3_]);
            _loc3_++;
         }
      }
   }
}
