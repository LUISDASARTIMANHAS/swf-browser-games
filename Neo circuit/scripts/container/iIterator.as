package container
{
   public interface iIterator
   {
       
      
      function next() : *;
      
      function hasNext() : Boolean;
      
      function isValid() : Boolean;
      
      function start() : void;
      
      function get data() : *;
      
      function get key() : *;
      
      function set data(param1:*) : void;
   }
}
