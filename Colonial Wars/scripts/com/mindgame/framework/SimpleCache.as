package com.mindgame.framework
{
   public class SimpleCache
   {
       
      
      protected var _targetClass:Class;
      
      protected var _currentIndex:int;
      
      protected var _instances:Array;
      
      public function SimpleCache(param1:Class, param2:int)
      {
         super();
         this._targetClass = param1;
         this._currentIndex = param2 - 1;
         this._instances = [];
         var _loc3_:int = 0;
         while(_loc3_ < param2)
         {
            this._instances[_loc3_] = this.getNewInstance();
            _loc3_++;
         }
      }
      
      protected function getNewInstance() : Object
      {
         return new this._targetClass();
      }
      
      public function get() : Object
      {
         if(this._currentIndex >= 0)
         {
            --this._currentIndex;
            return this._instances[this._currentIndex + 1];
         }
         return this.getNewInstance();
      }
      
      public function set(param1:Object) : void
      {
         ++this._currentIndex;
         if(this._currentIndex == this._instances.length)
         {
            this._instances[this._instances.length] = param1;
         }
         else
         {
            this._instances[this._currentIndex] = param1;
         }
      }
      
      public function clear() : void
      {
         this._instances = [];
         this._instances = null;
         this._targetClass = null;
      }
   }
}
