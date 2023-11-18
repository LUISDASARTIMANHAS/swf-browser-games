package com.newgrounds
{
   public class SaveRating
   {
       
      
      private var _id:uint;
      
      private var _name:String;
      
      private var _minValue:Number;
      
      private var _maxValue:Number;
      
      private var _isFloat:Boolean;
      
      private var _voted:Boolean;
      
      public function SaveRating(param1:uint, param2:String, param3:Boolean, param4:Number = -Infinity, param5:Number = Infinity)
      {
         super();
         this._id = param1;
         this._name = param2;
         this._isFloat = param3;
         this._minValue = param4;
         this._maxValue = param5;
      }
      
      public function get rating_id() : uint
      {
         return this._id;
      }
      
      public function get rating_name() : String
      {
         return this._name;
      }
      
      public function get id() : uint
      {
         return this._id;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get minValue() : Number
      {
         return this._minValue;
      }
      
      public function get maxValue() : Number
      {
         return this._maxValue;
      }
      
      public function get isFloat() : Boolean
      {
         return this._isFloat;
      }
      
      public function get voted() : Boolean
      {
         return this._voted;
      }
      
      public function set voted(param1:Boolean) : void
      {
         this._voted = param1;
      }
      
      public function toString() : String
      {
         return this._name;
      }
   }
}
