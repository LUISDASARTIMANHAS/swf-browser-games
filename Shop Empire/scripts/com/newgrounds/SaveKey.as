package com.newgrounds
{
   public class SaveKey
   {
      
      public static const TYPE_FLOAT:uint = 1;
      
      public static const TYPE_INTEGER:uint = 2;
      
      public static const TYPE_STRING:uint = 3;
      
      public static const TYPE_BOOLEAN:uint = 4;
       
      
      private var _id:uint;
      
      private var _name:String;
      
      private var _type:uint;
      
      public function SaveKey(param1:uint, param2:String, param3:uint)
      {
         super();
         this._id = param1;
         this._name = param2;
         this._type = param3;
      }
      
      public function get id() : uint
      {
         return this._id;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get type() : uint
      {
         return this._type;
      }
      
      public function get key_id() : uint
      {
         return this._id;
      }
      
      public function get key_name() : String
      {
         return this._name;
      }
      
      public function get key_type() : uint
      {
         return this._type;
      }
      
      public function isValueValid(param1:*) : Boolean
      {
         if(this._type == TYPE_INTEGER)
         {
            return param1 is int || param1 is uint;
         }
         if(this._type == TYPE_FLOAT)
         {
            return param1 is int || param1 is uint || param1 is Number;
         }
         if(this._type == TYPE_STRING)
         {
            return param1 is String;
         }
         if(this._type == TYPE_BOOLEAN)
         {
            return param1 is Boolean || param1 === 0 || param1 === 1 || param1 == "";
         }
         return false;
      }
      
      public function toString() : String
      {
         return this._name;
      }
   }
}
