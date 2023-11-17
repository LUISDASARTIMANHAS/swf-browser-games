package uk.co.kempt.data
{
   import flash.utils.Dictionary;
   
   public class Lookup
   {
      
      private static var PARENTS:Dictionary;
      
      private static var OBJECTS:Dictionary;
       
      
      public function Lookup()
      {
         super();
      }
      
      private static function get parents() : Dictionary
      {
         return PARENTS = PARENTS || new Dictionary();
      }
      
      public static function register(param1:Object, param2:Object) : void
      {
         objects[param1] = param2;
         getParentObjects(param2).push(param1);
      }
      
      private static function get objects() : Dictionary
      {
         return OBJECTS = OBJECTS || new Dictionary();
      }
      
      public static function getParent(param1:Object) : Object
      {
         return objects[param1];
      }
      
      public static function getParentObjects(param1:Object) : Array
      {
         return parents[param1] = parents[param1] || [];
      }
      
      public static function clear(param1:Boolean) : void
      {
         if(param1)
         {
            OBJECTS = null;
            PARENTS = null;
         }
      }
   }
}
