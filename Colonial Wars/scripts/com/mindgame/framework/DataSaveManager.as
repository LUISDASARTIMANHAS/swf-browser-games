package com.mindgame.framework
{
   import flash.net.*;
   
   public class DataSaveManager
   {
       
      
      private var _name:String;
      
      private var _so:SharedObject;
      
      public function DataSaveManager(param1:String = "tempCookie")
      {
         super();
         this._name = param1;
         this._so = SharedObject.getLocal(param1,"/");
      }
      
      public function getName() : String
      {
         return this._name;
      }
      
      public function clear() : void
      {
         this._so.clear();
      }
      
      public function put(param1:String, param2:*) : void
      {
         var _loc3_:Object = null;
         param1 = "key_" + param1;
         if(this._so.data.cookie == undefined)
         {
            _loc3_ = {};
            _loc3_[param1] = param2;
            this._so.data.cookie = _loc3_;
         }
         else
         {
            this._so.data.cookie[param1] = param2;
         }
         this._so.flush();
      }
      
      public function remove(param1:String) : void
      {
         if(this.isKeyExist(param1))
         {
            delete this._so.data.cookie["key_" + param1];
            this._so.flush();
         }
      }
      
      public function get(param1:String) : Object
      {
         return this.isKeyExist(param1) ? this._so.data.cookie["key_" + param1] : null;
      }
      
      public function isKeyExist(param1:String) : Boolean
      {
         param1 = "key_" + param1;
         return this._so.data.cookie != undefined && this._so.data.cookie[param1] != undefined;
      }
      
      public function isExist() : Boolean
      {
         return this.getSize() != 0;
      }
      
      public function getSize() : uint
      {
         return this._so.size;
      }
   }
}
