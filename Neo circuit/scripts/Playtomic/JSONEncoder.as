package Playtomic
{
   import flash.utils.describeType;
   
   public class JSONEncoder
   {
       
      
      private var jsonString:String;
      
      public function JSONEncoder(param1:*)
      {
         super();
         this.jsonString = this.convertToString(param1);
      }
      
      public function getString() : String
      {
         return this.jsonString;
      }
      
      private function convertToString(param1:*) : String
      {
         if(param1 is String)
         {
            return this.escapeString(param1 as String);
         }
         if(param1 is Number)
         {
            return !!isFinite(param1 as Number) ? String(param1.toString()) : "null";
         }
         if(param1 is Boolean)
         {
            return !!param1 ? "true" : "false";
         }
         if(param1 is Array)
         {
            return this.arrayToString(param1 as Array);
         }
         if(param1 is Object && param1 != null)
         {
            return this.objectToString(param1);
         }
         return "null";
      }
      
      private function escapeString(param1:String) : String
      {
         var _loc3_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc2_:* = "";
         var _loc4_:Number = Number(param1.length);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = String(param1.charAt(_loc5_));
            switch(_loc3_)
            {
               case "\"":
                  _loc2_ += "\\\"";
                  break;
               case "\\":
                  _loc2_ += "\\\\";
                  break;
               case "\b":
                  _loc2_ += "\\b";
                  break;
               case "\f":
                  _loc2_ += "\\f";
                  break;
               case "\n":
                  _loc2_ += "\\n";
                  break;
               case "\r":
                  _loc2_ += "\\r";
                  break;
               case "\t":
                  _loc2_ += "\\t";
                  break;
               default:
                  if(_loc3_ < " ")
                  {
                     _loc7_ = (_loc6_ = String(_loc3_.charCodeAt(0).toString(16))).length == 2 ? "00" : "000";
                     addr37:
                     _loc2_ += "\\u" + _loc7_ + _loc6_;
                  }
                  else
                  {
                     _loc2_ += _loc3_;
                     if(false)
                     {
                        §§goto(addr37);
                     }
                  }
                  break;
            }
            _loc5_++;
         }
         return "\"" + _loc2_ + "\"";
      }
      
      private function arrayToString(param1:Array) : String
      {
         var _loc2_:* = "";
         var _loc3_:int = int(param1.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc2_.length > 0)
            {
               _loc2_ += ",";
            }
            _loc2_ += this.convertToString(param1[_loc4_]);
            _loc4_++;
         }
         return "[" + _loc2_ + "]";
      }
      
      private function objectToString(param1:Object) : String
      {
         var s:String;
         var classInfo:XML;
         var value:Object = null;
         var key:String = null;
         var v:XML = null;
         var o:Object = param1;
         do
         {
            s = "";
            classInfo = describeType(o);
         }
         while(false);
         
         if(classInfo.@name.toString() == "Object")
         {
            loop6:
            for(key in o)
            {
               value = o[key];
               while(!(value is Function))
               {
                  if(s.length > 0)
                  {
                     s += ",";
                  }
                  s += this.escapeString(key) + ":" + this.convertToString(value);
                  if(false)
                  {
                     continue;
                  }
                  continue loop6;
               }
            }
         }
         else
         {
            for each(§§pop().§§slot[6] in classInfo..*.(§§push(name() == "variable"), if(!(name() == "variable"))
            {
               §§pop();
               while(true)
               {
                  §§push(name() == "accessor" && attribute("access").charAt(0) == "r");
               }
               addr175:
            }, while(§§pop())
            {
               _loc5_[_loc6_] = _loc8_;
               if(true)
               {
                  break;
               }
               §§goto(addr175);
            }, false))
            {
               if(!(Boolean(§§pop().§§slot[6].metadata) && §§pop().§§slot[6].metadata.(@name == "Transient").length() > 0))
               {
                  if(§§pop().§§slot[2].length > 0)
                  {
                     §§pop().§§slot[2] = §§pop().§§slot[2] + ",";
                  }
                  §§pop().§§slot[2] = §§pop().§§slot[2] + (this.escapeString(§§pop().§§slot[6].@name.toString()) + ":" + this.convertToString(§§pop().§§slot[1][§§pop().§§slot[6].@name]));
               }
            }
         }
         return "{" + s + "}";
      }
   }
}
