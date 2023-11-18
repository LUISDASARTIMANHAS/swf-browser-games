package com.newgrounds
{
   import flash.events.Event;
   
   public class APIEvent extends Event
   {
      
      public static const API_CONNECTED:String = "movieConnected";
      
      public static const ADS_APPROVED:String = "adsApproved";
      
      public static const AD_ATTACHED:String = "adAttached";
      
      public static const HOST_BLOCKED:String = "hostBlocked";
      
      public static const NEW_VERSION_AVAILABLE:String = "newVersionAvailable";
      
      public static const EVENT_LOGGED:String = "eventLogged";
      
      public static const SCORE_POSTED:String = "scorePosted";
      
      public static const SCORES_LOADED:String = "scoresLoaded";
      
      public static const UNLOCK_MEDAL:String = "unlockMedal";
      
      public static const MEDAL_UNLOCKED:String = "medalUnlocked";
      
      public static const MEDALS_LOADED:String = "medalsLoaded";
      
      public static const METADATA_LOADED:String = "metadataLoaded";
      
      public static const FILE_PRIVS_LOADED:String = "filePrivsLoaded";
      
      public static const FILE_SAVED:String = "fileSaved";
      
      public static const FILE_LOADED:String = "fileLoaded";
      
      public static const FILE_INITIALIZED:String = "fileInitialized";
      
      public static const FILE_REQUESTED:String = "fileRequested";
      
      public static const QUERY_COMPLETE:String = "queryComplete";
      
      public static const VOTE_COMPLETE:String = "voteComplete";
       
      
      private var _data:*;
      
      private var _success:Boolean;
      
      private var _target:*;
      
      private var _error:APIError;
      
      public function APIEvent(param1:String, param2:Boolean = true, param3:* = undefined)
      {
         super(param1);
         this._data = param3;
         this._success = param2;
      }
      
      public function get success() : Boolean
      {
         return this._success;
      }
      
      public function get data() : *
      {
         return this._data;
      }
   }
}
