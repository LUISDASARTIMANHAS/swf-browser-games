package org.cove.ape
{
   import flash.events.Event;
   
   public class CollisionEvent extends Event
   {
      
      public static const COLLIDE:String = "collide";
      
      public static const FIRST_COLLIDE:String = "firstCollide";
       
      
      private var _collidingItem:AbstractItem;
      
      public function CollisionEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:AbstractItem = null)
      {
         super(param1,param2,param3);
         this._collidingItem = param4;
      }
      
      public function get collidingItem() : AbstractItem
      {
         var _loc1_:SpringConstraintParticle = null;
         if(this._collidingItem is SpringConstraintParticle)
         {
            _loc1_ = this._collidingItem as SpringConstraintParticle;
            return _loc1_.parent;
         }
         return this._collidingItem;
      }
   }
}
