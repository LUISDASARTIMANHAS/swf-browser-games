package utils
{
   import flash.utils.ByteArray;
   
   public class cFileUtils
   {
       
      
      public function cFileUtils()
      {
         super();
      }
      
      public static function ConvertFileToStringArray(param1:Class) : Array
      {
         var _loc2_:ByteArray = new param1() as ByteArray;
         var _loc3_:String = String(_loc2_.readUTFBytes(_loc2_.length));
         return _loc3_.split("\n");
      }
      
      public static function FilterComments(param1:Array) : Array
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         do
         {
            _loc2_ = String(param1[_loc3_]);
            if(_loc2_ != null)
            {
               if(_loc2_.search("##") != -1 || _loc2_ == "")
               {
                  param1.splice(_loc3_,1);
               }
               else
               {
                  _loc3_++;
               }
            }
         }
         while(_loc2_ != null);
         
         return param1;
      }
   }
}
