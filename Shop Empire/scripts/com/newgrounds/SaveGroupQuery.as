package com.newgrounds
{
   import flash.events.EventDispatcher;
   
   public class SaveGroupQuery extends EventDispatcher
   {
      
      public static const TABLE_FILES:uint = 1;
      
      public static const TABLE_KEYS:uint = 2;
      
      public static const TABLE_RATINGS:uint = 3;
      
      public static const FILE_ID:uint = 0;
      
      public static const AUTHOR_ID:uint = 1;
      
      public static const AUTHOR_NAME:uint = 2;
      
      public static const FILE_NAME:uint = 3;
      
      public static const CREATED_ON:uint = 4;
      
      public static const UPDATED_ON:uint = 5;
      
      public static const TOTAL_VIEWS:uint = 6;
      
      public static const FILE_STATUS:uint = 7;
      
      public static const SCORE:String = "score";
      
      public static const TOTAL_VOTES:String = "votes";
       
      
      private var _group:SaveGroup;
      
      private var _groupBy:Array;
      
      private var _lookupKeys:Array;
      
      private var _lookupRatings:Array;
      
      private var _fileConditions:Array;
      
      private var _keyConditions:Array;
      
      private var _ratingConditions:Array;
      
      private var _sortConditions:Array;
      
      private var _page:uint;
      
      private var _resultsPerPage:uint;
      
      private var _randomizeResults:Boolean;
      
      private var _results:Array;
      
      public function SaveGroupQuery(param1:SaveGroup)
      {
         this._results = [];
         super();
         this._group = param1;
         this.reset();
      }
      
      public function clearCache() : void
      {
         this._results = [];
      }
      
      public function get group() : SaveGroup
      {
         return this._group;
      }
      
      public function get groupId() : uint
      {
         return this._group.id;
      }
      
      public function get resultsPerPage() : uint
      {
         return this._resultsPerPage;
      }
      
      public function set resultsPerPage(param1:uint) : void
      {
         this._resultsPerPage = param1;
      }
      
      public function get page() : uint
      {
         return this._page;
      }
      
      public function set page(param1:uint) : void
      {
         this._page = param1;
      }
      
      public function get randomized() : Boolean
      {
         return this._randomizeResults;
      }
      
      public function set randomized(param1:Boolean) : void
      {
         this._randomizeResults = param1;
      }
      
      public function get results() : Array
      {
         return this._results;
      }
      
      public function reset() : void
      {
         this._fileConditions = [];
         this._keyConditions = [];
         this._ratingConditions = [];
         this._sortConditions = [];
         this._groupBy = [];
         this._lookupKeys = [];
         this._lookupRatings = [];
         this._randomizeResults = false;
         this._resultsPerPage = 20;
         this._page = 1;
         this.clearCache();
      }
      
      internal function getGroup() : SaveGroup
      {
         return this._group;
      }
      
      internal function getGroupID() : uint
      {
         return this._group.getID();
      }
      
      public function includeKey(param1:String) : void
      {
         var _loc2_:SaveKey = this._group.getKeyName(param1);
         if(_loc2_)
         {
            this._lookupKeys.push(_loc2_.id);
         }
      }
      
      public function isRandomized() : Boolean
      {
         return this._randomizeResults;
      }
      
      public function includeRating(param1:String) : void
      {
         var _loc2_:SaveRating = this._group.getRatingName(param1);
         if(_loc2_)
         {
            this._lookupRatings.push(_loc2_.id);
         }
      }
      
      public function excludeKey(param1:String) : void
      {
         var _loc2_:SaveKey = this._group.getKeyName(param1);
         var _loc3_:uint = 0;
         while(_loc3_ < this._lookupKeys.length)
         {
            if(this._lookupKeys[_loc3_] == _loc2_.id)
            {
               this._lookupKeys.splice(_loc3_,1);
               return;
            }
            _loc3_++;
         }
      }
      
      public function excludeRating(param1:String) : void
      {
         var _loc2_:SaveRating = this._group.getRatingName(param1);
         var _loc3_:uint = 0;
         while(_loc3_ < this._lookupRatings.length)
         {
            if(this._lookupRatings[_loc3_] == _loc2_.id)
            {
               this._lookupRatings.splice(_loc3_,1);
               return;
            }
            _loc3_++;
         }
      }
      
      public function groupBy(param1:uint) : void
      {
         this._groupBy.push({
            "table":TABLE_FILES,
            "field":param1
         });
      }
      
      public function groupByRating(param1:String) : void
      {
         var _loc2_:SaveRating = this._group.getRatingName(param1);
         if(!_loc2_)
         {
            return;
         }
         this._groupBy.push({
            "table":TABLE_RATINGS,
            "field":_loc2_.id
         });
      }
      
      public function groupByKey(param1:String) : void
      {
         var _loc2_:SaveKey = this._group.getKeyName(param1);
         if(!_loc2_)
         {
            return;
         }
         this._groupBy.push({
            "table":TABLE_KEYS,
            "field":_loc2_.id
         });
      }
      
      public function addFileCondition(param1:uint, param2:String, param3:*) : void
      {
         this._fileConditions.push({
            "field":param1,
            "operator":param2,
            "value":param3
         });
      }
      
      public function addKeyCondition(param1:String, param2:String, param3:*) : void
      {
         var _loc4_:SaveKey;
         if(!(_loc4_ = this._group.getKeyName(param1)))
         {
            return;
         }
         if(!this.checkValue(param3,_loc4_.type))
         {
            return;
         }
         this._keyConditions.push({
            "key_id":_loc4_.id,
            "operator":param2,
            "value":param3
         });
      }
      
      public function addRatingCondition(param1:String, param2:String, param3:*, param4:String = "score") : void
      {
         var _loc5_:SaveRating;
         if(!(_loc5_ = this._group.getRatingName(param1)))
         {
            return;
         }
         this._ratingConditions.push({
            "rating_id":_loc5_.id,
            "operator":param2,
            "value":param3,
            "column":param4
         });
      }
      
      private function addSortCondition(param1:uint, param2:uint, param3:Boolean = false, param4:* = null) : void
      {
         var _loc5_:Object = {
            "table":param1,
            "field":param2,
            "desc":param3
         };
         if(param4)
         {
            _loc5_.extra = param4;
         }
         this._sortConditions.push(_loc5_);
      }
      
      public function sortOn(param1:uint, param2:Boolean = false) : void
      {
         this.addSortCondition(TABLE_FILES,param1,param2);
      }
      
      public function sortOnKey(param1:String, param2:Boolean = false) : void
      {
         this.addSortCondition(TABLE_KEYS,this._group.getKeyName(param1).id,param2);
      }
      
      public function sortOnRating(param1:String, param2:Boolean = false, param3:String = "score") : void
      {
         this.addSortCondition(TABLE_RATINGS,this._group.getRatingName(param1).id,param2,param3);
      }
      
      public function sortOnRatingScore(param1:String, param2:Boolean) : *
      {
         this.sortOnRating(param1,param2,SCORE);
      }
      
      public function sortOnRatingVotes(param1:String, param2:Boolean) : *
      {
         this.sortOnRating(param1,param2,TOTAL_VOTES);
      }
      
      public function setResultsPerPage(param1:uint) : *
      {
         this._resultsPerPage = param1;
         this.clearCache();
      }
      
      public function setPage(param1:Number) : *
      {
         this._page = param1;
         this.clearCache();
      }
      
      public function setRandomize(param1:Boolean) : void
      {
         this._randomizeResults = param1;
      }
      
      public function execute() : void
      {
         API.executeSaveQuery(this);
      }
      
      private function checkValue(param1:*, param2:uint) : Boolean
      {
         return true;
      }
      
      internal function setResults(param1:Array) : void
      {
         this._results = param1;
      }
      
      override public function toString() : String
      {
         return "";
      }
      
      public function toObject() : Object
      {
         var _loc1_:Object = {
            "page":this._page,
            "num_results":this._resultsPerPage
         };
         if(this.isRandomized())
         {
            _loc1_.randomize = 1;
         }
         if(Boolean(this._fileConditions) && this._fileConditions.length > 0)
         {
            _loc1_.file_conditions = this._fileConditions;
         }
         if(Boolean(this._keyConditions) && this._keyConditions.length > 0)
         {
            _loc1_.key_conditions = this._keyConditions;
         }
         if(Boolean(this._ratingConditions) && this._ratingConditions.length > 0)
         {
            _loc1_.rating_conditions = this._ratingConditions;
         }
         if(Boolean(this._sortConditions) && this._sortConditions.length > 0)
         {
            _loc1_.sort_conditions = this._sortConditions;
         }
         if(Boolean(this._lookupKeys) && this._lookupKeys.length > 0)
         {
            _loc1_.lookup_keys = this._lookupKeys;
         }
         if(Boolean(this._lookupRatings) && this._lookupRatings.length > 0)
         {
            _loc1_.lookup_ratings = this._lookupRatings;
         }
         if(Boolean(this._groupBy) && this._groupBy.length > 0)
         {
            _loc1_.group_by = this._groupBy;
         }
         return _loc1_;
      }
   }
}
