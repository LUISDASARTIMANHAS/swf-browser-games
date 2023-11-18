package com.newgrounds
{
   public class Score
   {
       
      
      private var _board:ScoreBoard;
      
      private var _position:uint;
      
      private var _username:String;
      
      private var _value:String;
      
      private var _numeric_value:uint;
      
      private var _tag:String;
      
      public function Score(param1:ScoreBoard, param2:Number, param3:String, param4:String, param5:uint, param6:String)
      {
         super();
         this._board = param1;
         this._position = param2;
         this._username = param3;
         this._value = param4;
         this._numeric_value = param5;
         this._tag = param6;
      }
      
      public function get board() : ScoreBoard
      {
         return this._board;
      }
      
      public function get position() : uint
      {
         return this._position;
      }
      
      public function get username() : String
      {
         return this._username;
      }
      
      public function get value() : String
      {
         return this._value;
      }
      
      public function get numeric_value() : uint
      {
         return this._numeric_value;
      }
      
      public function get tag() : String
      {
         return this._tag;
      }
   }
}
