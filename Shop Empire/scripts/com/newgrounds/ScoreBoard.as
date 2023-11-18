package com.newgrounds
{
   import flash.events.EventDispatcher;
   
   public class ScoreBoard extends EventDispatcher
   {
       
      
      private var _name:String;
      
      private var _id:uint;
      
      private var _scores:Array;
      
      private var _period:String = "Today";
      
      private var _num_results:uint = 10;
      
      private var _numScores:uint;
      
      private var _desiredNumResults:uint;
      
      private var _startRank:uint;
      
      private var _endRank:uint;
      
      private var _page:uint = 1;
      
      private var _tag:String;
      
      public function ScoreBoard(param1:uint, param2:String, param3:String)
      {
         super();
         this._name = param2;
         this._id = param1;
         this._scores = [];
         this._tag = param3;
      }
      
      public function exists() : Boolean
      {
         return this._id > 0;
      }
      
      public function get id() : Number
      {
         return this._id;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get period() : String
      {
         return this._period;
      }
      
      public function get page() : uint
      {
         return this._page;
      }
      
      public function get num_results() : uint
      {
         return this._num_results;
      }
      
      public function get scores() : Array
      {
         return this._scores;
      }
      
      public function get tag() : String
      {
         return this._tag;
      }
      
      public function get num_scores() : uint
      {
         return this._numScores;
      }
      
      public function postScore(param1:uint, param2:String = null) : void
      {
         if(param2)
         {
            this._tag = param2;
         }
         API.postScore(this._name,param1);
      }
      
      public function loadScores(param1:String = "Today", param2:uint = 1, param3:uint = 10) : void
      {
         this._period = param1;
         if(!this._period || this._period == "")
         {
            this._period = ScoreBoardPeriod.TODAY;
         }
         this._page = param2;
         this._num_results = param3;
         this._desiredNumResults = 0;
         API.loadScores(this.name);
      }
      
      public function loadScoresInRange(param1:String = "Today", param2:uint = 1, param3:uint = 10) : void
      {
         if(param2 == 0)
         {
            param2 = 1;
         }
         if(param3 < param2)
         {
            param3 = param2;
         }
         this._period = param1;
         if(!this._period || this._period == "")
         {
            this._period = ScoreBoardPeriod.TODAY;
         }
         this._desiredNumResults = param3 - param2 + 1;
         this._num_results = this._desiredNumResults;
         while(int((param2 - 1) / this._num_results) != int((param3 - 1) / this._num_results))
         {
            ++this._num_results;
         }
         this._page = (param2 - 1) / this._num_results;
         this._startRank = param2;
         this._endRank = param3;
         ++this._page;
         API.loadScores(this.name);
      }
      
      internal function setScores(param1:Array, param2:String, param3:Number, param4:Number, param5:uint) : void
      {
         var _loc7_:uint = 0;
         this._period = param2;
         this._page = param3;
         this._num_results = param4;
         this._numScores = param5;
         this._scores = [];
         var _loc6_:uint = 0;
         while(_loc6_ < param1.length)
         {
            _loc7_ = uint(this._num_results * (this._page - 1) + 1 + _loc6_);
            if(!this._desiredNumResults || _loc7_ >= this._startRank && _loc7_ <= this._endRank)
            {
               this._scores.push(new Score(this,_loc7_,param1[_loc6_].username,param1[_loc6_].value,param1[_loc6_].numeric_value,param1[_loc6_].tag));
            }
            _loc6_++;
         }
         this._num_results = this._scores.length;
      }
   }
}
