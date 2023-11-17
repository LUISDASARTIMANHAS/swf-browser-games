package org.cove.ape
{
   import flash.display.DisplayObjectContainer;
   
   public final class APEngine
   {
      
      private static var _damping:Number;
      
      private static var _container:DisplayObjectContainer;
      
      private static var _constraintCollisionCycles:int;
      
      private static var groups:Array;
      
      internal static var forces:Array;
      
      private static var _constraintCycles:int;
      
      private static var timeStep:Number;
      
      private static var numGroups:int;
       
      
      public function APEngine()
      {
         super();
      }
      
      public static function get container() : DisplayObjectContainer
      {
         return _container;
      }
      
      public static function get constraintCollisionCycles() : int
      {
         return _constraintCollisionCycles;
      }
      
      public static function removeForce(param1:IForce) : void
      {
         var _loc2_:int = int(forces.indexOf(param1));
         if(_loc2_ == -1)
         {
            return;
         }
         forces.splice(_loc2_,1);
      }
      
      public static function set damping(param1:Number) : void
      {
         _damping = param1;
      }
      
      public static function step() : void
      {
         integrate();
         var _loc1_:int = 0;
         while(_loc1_ < _constraintCycles)
         {
            satisfyConstraints();
            _loc1_++;
         }
         var _loc2_:int = 0;
         while(_loc2_ < _constraintCollisionCycles)
         {
            satisfyConstraints();
            checkCollisions();
            _loc2_++;
         }
      }
      
      public static function get constraintCycles() : int
      {
         return _constraintCycles;
      }
      
      public static function set constraintCollisionCycles(param1:int) : void
      {
         _constraintCollisionCycles = param1;
      }
      
      public static function init(param1:Number = 0.25) : void
      {
         timeStep = param1 * param1;
         numGroups = 0;
         groups = new Array();
         forces = new Array();
         _damping = 1;
         _constraintCycles = 0;
         _constraintCollisionCycles = 1;
      }
      
      public static function addForce(param1:IForce) : void
      {
         forces.push(param1);
      }
      
      public static function get damping() : Number
      {
         return _damping;
      }
      
      public static function set constraintCycles(param1:int) : void
      {
         _constraintCycles = param1;
      }
      
      public static function addGroup(param1:Group) : void
      {
         groups.push(param1);
         param1.isParented = true;
         ++numGroups;
         param1.init();
      }
      
      public static function set container(param1:DisplayObjectContainer) : void
      {
         _container = param1;
      }
      
      public static function paint() : void
      {
         var _loc2_:Group = null;
         var _loc1_:int = 0;
         while(_loc1_ < numGroups)
         {
            _loc2_ = groups[_loc1_];
            _loc2_.paint();
            _loc1_++;
         }
      }
      
      public static function removeGroup(param1:Group) : void
      {
         var _loc2_:int = int(groups.indexOf(param1));
         if(_loc2_ == -1)
         {
            return;
         }
         groups.splice(_loc2_,1);
         param1.isParented = false;
         --numGroups;
         param1.cleanup();
      }
      
      private static function satisfyConstraints() : void
      {
         var _loc2_:Group = null;
         var _loc1_:int = 0;
         while(_loc1_ < numGroups)
         {
            _loc2_ = groups[_loc1_];
            _loc2_.satisfyConstraints();
            _loc1_++;
         }
      }
      
      public static function removeAllForce() : void
      {
         forces = new Array();
      }
      
      private static function checkCollisions() : void
      {
         var _loc2_:Group = null;
         var _loc1_:int = 0;
         while(_loc1_ < numGroups)
         {
            _loc2_ = groups[_loc1_];
            _loc2_.checkCollisions();
            _loc1_++;
         }
      }
      
      private static function integrate() : void
      {
         var _loc2_:Group = null;
         var _loc1_:int = 0;
         while(_loc1_ < numGroups)
         {
            _loc2_ = groups[_loc1_];
            _loc2_.integrate(timeStep);
            _loc1_++;
         }
      }
   }
}
