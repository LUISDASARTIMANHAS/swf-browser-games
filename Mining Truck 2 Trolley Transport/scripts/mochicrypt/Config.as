package mochicrypt
{
   internal class Config
   {
      
      private static const data:Object = new ConfigData().readObject();
       
      
      public function Config()
      {
         super();
      }
      
      public static function getBool(param1:String, param2:Boolean) : Boolean
      {
         return data[param1] is Boolean ? Boolean(data[param1]) : param2;
      }
      
      public static function getInt(param1:String, param2:int) : int
      {
         return data[param1] is int ? int(data[param1]) : param2;
      }
      
      public static function getString(param1:String, param2:String) : String
      {
         return data[param1] is String ? String(data[param1]) : param2;
      }
   }
}
