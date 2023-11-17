package uk.co.kempt.highscores.utils
{
   public class HighscoresParser
   {
      
      protected static const DEFAULT_NODE:String = "top10";
      
      protected static const BAD_WORDS:Array = ["fuck","shit","cunt","fuk","kunt","phuk","phuck"];
       
      
      public function HighscoresParser()
      {
         super();
      }
      
      public static function filterName(param1:String, param2:Boolean = false) : String
      {
         var _loc3_:String = param1;
         var _loc4_:int;
         if((_loc4_ = findFirst(_loc3_,["\n","\r","&"])) != -1)
         {
            _loc3_ = String(_loc3_.substring(0,_loc4_));
         }
         if(param2)
         {
            _loc3_ = removeBadWords(_loc3_);
         }
         return _loc3_;
      }
      
      public static function getTopTen(param1:XML, param2:String = "top10") : XMLList
      {
         return !!param1.child(param2).score.length() ? param1.child(param2).score : param1.child(param2).team;
      }
      
      private static function findFirst(param1:String, param2:Array) : int
      {
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc3_:String = String(param1.toLowerCase());
         var _loc6_:int = -1;
         var _loc7_:int = 0;
         while(_loc7_ < param2.length)
         {
            _loc4_ = String(String(param2[_loc7_]).toLowerCase());
            if((_loc5_ = int(_loc3_.indexOf(_loc4_))) != -1)
            {
               if(_loc6_ == -1)
               {
                  _loc6_ = _loc5_;
               }
               else
               {
                  _loc6_ = int(Math.min(_loc5_,_loc6_));
               }
            }
            _loc7_++;
         }
         return _loc6_;
      }
      
      private static function removeBadWords(param1:String) : String
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:String = param1;
         var _loc6_:int = 0;
         while(_loc6_ < BAD_WORDS.length)
         {
            _loc3_ = String(String(BAD_WORDS[_loc6_]).toLowerCase());
            _loc4_ = getReplacement(_loc3_);
            _loc7_ = 0;
            while(_loc7_ < 256)
            {
               if((_loc5_ = int(_loc2_.toLowerCase().indexOf(_loc3_))) != -1)
               {
                  _loc2_ = _loc2_.substring(0,_loc5_) + _loc4_ + _loc2_.substring(_loc5_ + _loc3_.length);
               }
               else
               {
                  _loc7_ = 256;
               }
               _loc7_++;
            }
            _loc6_++;
         }
         return _loc2_;
      }
      
      public static function getIds(param1:XML, param2:String = "top10") : Array
      {
         var _loc3_:XMLList = getTopTen(param1,param2);
         return getPropsFromXMLList("pId",_loc3_);
      }
      
      private static function filterNames(param1:Array) : Array
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         var _loc5_:int = 0;
         while(_loc5_ < param1.length)
         {
            _loc2_.push(filterName(param1[_loc5_],true));
            _loc5_++;
         }
         return _loc2_;
      }
      
      public static function getPropsFromXMLList(param1:String, param2:XMLList) : Array
      {
         var _loc3_:XML = null;
         var _loc5_:String = null;
         var _loc4_:Array = [];
         for each(_loc3_ in param2)
         {
            _loc5_ = String(_loc3_.attribute(param1));
            _loc4_.push(_loc5_);
         }
         return _loc4_;
      }
      
      public static function getNames(param1:XML, param2:String = "top10") : Array
      {
         var _loc3_:XMLList = getTopTen(param1,param2);
         var _loc4_:Array = getPropsFromXMLList("name",_loc3_);
         return filterNames(_loc4_);
      }
      
      public static function getPositions(param1:XML, param2:String = "top10") : Array
      {
         var _loc3_:XMLList = getTopTen(param1,param2);
         return getPropsFromXMLList("pos",_loc3_);
      }
      
      public static function getScores(param1:XML, param2:String = "top10") : Array
      {
         var _loc3_:XMLList = getTopTen(param1,param2);
         return getPropsFromXMLList("score",_loc3_);
      }
      
      private static function getReplacement(param1:String) : String
      {
         var _loc2_:* = "";
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ += "*";
            _loc3_++;
         }
         return _loc2_;
      }
   }
}
