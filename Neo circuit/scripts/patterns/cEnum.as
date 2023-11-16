package patterns
{
   public class cEnum
   {
      
      private static var m_currentIncrement:int = 0;
       
      
      public function cEnum()
      {
         super();
      }
      
      public static function Enum(param1:int) : int
      {
         m_currentIncrement = param1;
         return m_currentIncrement;
      }
      
      public static function get inc() : int
      {
         return ++m_currentIncrement;
      }
   }
}
