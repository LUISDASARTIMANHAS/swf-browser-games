package container
{
   public interface iCollection
   {
       
      
      function contains(param1:*) : Boolean;
      
      function clear() : void;
      
      function getIterator() : iIterator;
      
      function get size() : int;
      
      function isEmpty() : Boolean;
      
      function toArray() : Array;
   }
}
