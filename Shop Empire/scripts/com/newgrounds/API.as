package com.newgrounds
{
   import com.adobe.crypto.MD5;
   import com.adobe.images.PNGEncoder;
   import com.adobe.serialization.json.JSON;
   import com.newgrounds.components.FlashAd;
   import flash.display.DisplayObject;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.SharedObject;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.navigateToURL;
   import flash.system.Capabilities;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class API
   {
      
      public static const VERSION:String = "2.4.18";
      
      private static var do_echo:Boolean = false;
      
      private static const GATEWAY_URL:String = "http://www.ngads.com/gateway_v2.php";
      
      private static const AD_TERMS_URL:String = "http://www.newgrounds.com/wiki/flashads/terms/";
      
      private static const COMMANDS_WIKI_URL:String = "http://www.newgrounds.com/wiki/flashapi/commands/";
      
      private static var _debug:Boolean = true;
      
      private static var _connected:Boolean = false;
      
      private static var _isMetadataLoaded:Boolean = false;
      
      private static var _preloadComplete:Boolean = false;
      
      private static var _adsApproved:Boolean = false;
      
      private static var _saveGroupId:uint;
      
      private static var _saveFileId:uint;
      
      private static var _trackerId:uint;
      
      private static var _movieId:String;
      
      private static var _encryptionKey:String;
      
      private static var _url:String;
      
      private static var _host:String;
      
      private static var connected:Boolean;
      
      private static var version:String;
      
      private static var ad_url:String;
      
      private static var _fakeSession:Boolean = false;
      
      private static var publisher_id:uint;
      
      private static var session_id:String;
      
      private static var user_email:String;
      
      private static var user_name:String;
      
      private static var user_id:uint;
      
      private static var userpage_format:String;
      
      private static var _medals:Array;
      
      private static var timeoutTimer:Timer = new Timer(8000,1);
      
      private static var _userpageFormat:String;
      
      private static var _scoreboards:Array = new Array();
      
      private static var _bridge:Bridge;
      
      private static var save_file:SaveFile;
      
      private static var _imageFilePath:String;
      
      private static var _saveFilePath:String;
      
      private static var _saveGroups:Array = [];
      
      private static var root:DisplayObject;
      
      private static var _eventDispatcher:EventDispatcher = new EventDispatcher();
      
      private static var score_page_counts:Object = new Object();
      
      private static var compression_radix:String = "/g8236klvBQ#&|;Zb*7CEA59%s`Oue1wziFp$rDVY@TKxUPWytSaGHJ>dmoMR^<0~4qNLhc(I+fjn)X";
      
      private static var compressor:BaseN = new BaseN(compression_radix);
      
      public static var errors:Dictionary = APIError.init_codes();
      
      private static var sharedObjects:Dictionary = new Dictionary();
      
      private static var _preloadAssets:Array = [];
      
      public static var periods:Object = getPeriodAliases();
      
      private static var period_aliases:Object = {
         "t":{
            "name":"Today",
            "alias":"TODAY"
         },
         "p":{
            "name":"Yesterday",
            "alias":"YESTERDAY"
         },
         "w":{
            "name":"This Week",
            "alias":"THIS_WEEK"
         },
         "m":{
            "name":"This Month",
            "alias":"THIS_MONTH"
         },
         "y":{
            "name":"This Year",
            "alias":"THIS_YEAR"
         },
         "a":{
            "name":"All-Time",
            "alias":"ALL_TIME"
         }
      };
      
      private static var secureCommand:String;
       
      
      public function API()
      {
         super();
      }
      
      public static function get adFeedURL() : String
      {
         return ad_url;
      }
      
      public static function get preloadComplete() : Boolean
      {
         return _preloadComplete;
      }
      
      private static function assertConnected() : Boolean
      {
         if(!_connected)
         {
            return false;
         }
         return true;
      }
      
      public static function setVersion(param1:String) : void
      {
         if(Boolean(param1) && param1 != "")
         {
            version = param1;
         }
      }
      
      public static function setUserEmail(param1:String) : void
      {
         user_email = param1;
      }
      
      public static function setFakeSession(param1:Boolean) : void
      {
         _fakeSession = param1;
      }
      
      public static function getFakeSession() : Boolean
      {
         return _fakeSession;
      }
      
      public static function get debugMode() : Boolean
      {
         return _debug;
      }
      
      public static function set debugMode(param1:Boolean) : void
      {
         _debug = param1;
      }
      
      public static function getTrackerID() : uint
      {
         return _trackerId;
      }
      
      public static function getUserID() : uint
      {
         return user_id;
      }
      
      public static function getUserName() : String
      {
         return user_name;
      }
      
      public static function isConnected() : Boolean
      {
         return _connected;
      }
      
      public static function getID() : uint
      {
         return _trackerId;
      }
      
      public static function getOfficialURL() : String
      {
         var _loc1_:* = GATEWAY_URL + "?tracker_id=" + _movieId + "&command_id=" + getCommandID("loadOfficalVersion") + "&seed=" + Math.random();
         if(debugMode)
         {
            _loc1_ += "&debug=1";
         }
         return _loc1_;
      }
      
      public static function get adsApproved() : Boolean
      {
         return _adsApproved;
      }
      
      public static function hasUserSession() : Boolean
      {
         return session_id != null && session_id != "" && publisher_id != 0;
      }
      
      public static function isNewgrounds() : Boolean
      {
         return publisher_id == 1 || Boolean(_host) && _host.toLowerCase().indexOf("ungrounded.net") > -1;
      }
      
      public static function hostIsCompatible() : Boolean
      {
         return publisher_id != 0;
      }
      
      public static function hasUserEmail() : Boolean
      {
         return user_email != null && user_email != "";
      }
      
      public static function connectionTimeOut(param1:Event = null) : void
      {
         dispatchEvent(new APIEvent(APIEvent.API_CONNECTED,false,new APIError("CONNECTION_FAILED","Connection to NewgroundsAPI gateway timed out.")));
      }
      
      public static function connect(param1:LoaderInfo, param2:String, param3:String = null) : void
      {
         var flashVars:Object;
         var loaderInfo:LoaderInfo = param1;
         var m_id:String = param2;
         var encrypt_key:String = param3;
         if(!loaderInfo)
         {
            fatalError("Null loaderInfo paremeter passed in to connectMovie!","");
            return;
         }
         try
         {
            if(loaderInfo.loader)
            {
               loaderInfo = loaderInfo.loader.loaderInfo;
            }
         }
         catch(error:Error)
         {
         }
         _url = loaderInfo.url;
         _host = _url;
         if(_host.indexOf("http://") > -1 || _host.indexOf("https://") > -1)
         {
            _host = _host.split("/")[2].toLowerCase();
         }
         else
         {
            _host = "localhost";
         }
         flashVars = loaderInfo.parameters;
         if(isPublishedHost())
         {
            debugMode = false;
         }
         if(!debugMode && Boolean(flashVars))
         {
            if(flashVars.NewgroundsAPI_UserName)
            {
               user_name = flashVars.NewgroundsAPI_UserName;
            }
            if(flashVars.NewgroundsAPI_UserID)
            {
               user_id = flashVars.NewgroundsAPI_UserID;
            }
            if(flashVars.NewgroundsAPI_PublisherID)
            {
               publisher_id = flashVars.NewgroundsAPI_PublisherID;
            }
            else
            {
               publisher_id = 0;
            }
            if(flashVars.NewgroundsAPI_UserpageFormat)
            {
               _userpageFormat = flashVars.NewgroundsAPI_UserpageFormat;
            }
            if(flashVars.NewgroundsAPI_SessionID)
            {
               session_id = flashVars.NewgroundsAPI_SessionID;
            }
            if(flashVars.NewgroundsAPI_SaveGroupID)
            {
               _saveGroupId = flashVars.NewgroundsAPI_SaveGroupID;
            }
            if(flashVars.NewgroundsAPI_SaveFileID)
            {
               _saveFileId = flashVars.NewgroundsAPI_SaveFileID;
            }
            if(flashVars.NewgroundsAPI_SandboxID)
            {
               _bridge = new Bridge(flashVars.NewgroundsAPI_SandboxID);
            }
         }
         else
         {
            publisher_id = 1;
            if(_fakeSession)
            {
               session_id = "D3bu64p1U53R";
               user_id = 10;
               user_name = "API-Debugger";
            }
         }
         if(connected)
         {
            fatalError("NewgroundsAPI.connect() - connection already in progress","connect");
            return;
         }
         timeoutTimer.start();
         if(!m_id)
         {
            fatalError("NewgroundsAPI.connectMovie() - missing required movieId parameter","connectMovie");
         }
         _movieId = String(m_id);
         _trackerId = uint(_movieId.substring(0,_movieId.indexOf(":")));
         _encryptionKey = encrypt_key;
         connected = true;
         sendCommand("connectMovie",{
            "host":getHost(),
            "movie_version":version
         });
      }
      
      private static function getHost() : String
      {
         return _host;
      }
      
      public static function isPublishedHost() : Boolean
      {
         return getHost() != "localhost" && getHost().indexOf("file://") == -1;
      }
      
      public static function loadUserPage(param1:uint = 0, param2:String = null) : Boolean
      {
         var _loc3_:* = null;
         if(param1 == 0 && param2 == null)
         {
            if(!hasUserSession())
            {
               return false;
            }
            param1 = user_id;
            param2 = user_name;
         }
         if(publisher_id == 1)
         {
            _loc3_ = "http://" + param2.toLowerCase() + ".newgrounds.com";
            navigateToURL(new URLRequest(_loc3_),"_blank");
            return true;
         }
         if(userpage_format)
         {
            _loc3_ = userpage_format;
            _loc3_ = String(_loc3_.split(":user_id:").join(param1.toString()));
            _loc3_ = String(_loc3_.split(":user_name:").join(escape(param2)));
            navigateToURL(new URLRequest(_loc3_),"_blank");
            return true;
         }
         return false;
      }
      
      public static function loadNewgrounds() : void
      {
         sendCommand("loadNewgrounds",{"host":getHost()},true);
      }
      
      public static function loadOfficialURL() : void
      {
         navigateToURL(new URLRequest(getOfficialURL()));
      }
      
      public static function loadMySite() : void
      {
         sendCommand("loadMySite",{"host":getHost()},true);
      }
      
      public static function loadCustomLink(param1:String) : void
      {
         sendCommand("loadCustomLink",{
            "host":getHost(),
            "link":param1
         },true);
      }
      
      public static function logCustomEvent(param1:String) : void
      {
         sendCommand("logCustomEvent",{
            "host":getHost(),
            "event":param1
         });
      }
      
      public static function getScoreBoard(param1:String) : ScoreBoard
      {
         var _loc2_:ScoreBoard = null;
         for each(_loc2_ in _scoreboards)
         {
            if(_loc2_.name == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function getScoreBoardById(param1:uint) : ScoreBoard
      {
         var _loc2_:ScoreBoard = null;
         for each(_loc2_ in _scoreboards)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function postScore(param1:String, param2:uint, param3:String = "") : void
      {
         if(!param1 || param1 == "")
         {
            sendError({"command_id":getCommandID("postScore")},new APIError("MISSING_PARAM","missing required parameter(s)"));
            return;
         }
         if(param3 == null)
         {
            param3 = "";
         }
         sendSecureCommand("postScore",{
            "user_name":user_name,
            "board":param1,
            "value":param2,
            "publisher_id":publisher_id,
            "tag":param3
         });
      }
      
      public static function loadScores(param1:String, param2:String = null, param3:String = null) : void
      {
         var _loc4_:String = "loadScores";
         var _loc5_:ScoreBoard;
         if(!(_loc5_ = getScoreBoard(param1)) || !_loc5_.id)
         {
            sendError({"command_id":getCommandID(_loc4_)},new APIError("MISSING_PARAM","missing required ScoreBoard instance"));
            return;
         }
         var _loc6_:Object;
         (_loc6_ = {}).publisher_id = publisher_id;
         if(param2)
         {
            _loc6_.period = param2;
         }
         else
         {
            _loc6_.period = _loc5_.period;
         }
         _loc6_.board = _loc5_.id;
         _loc6_.num_results = _loc5_.num_results;
         _loc6_.page = _loc5_.page;
         if(!param3 || param3 == "")
         {
            _loc6_.tag = _loc5_.tag;
         }
         else
         {
            _loc6_.tag = param3;
         }
         sendCommand(_loc4_,_loc6_);
      }
      
      public static function loadScoresInRange(param1:String, param2:String = "All-Time", param3:uint = 1, param4:uint = 10) : void
      {
         if(!param1 || param1 == "")
         {
            sendError({"command_id":getCommandID("postScore")},new APIError("MISSING_PARAM","missing required parameter(s)"));
            return;
         }
         var _loc5_:ScoreBoard;
         if(_loc5_ = getScoreBoard(param1))
         {
            _loc5_.loadScoresInRange(param2,param3,param4);
         }
         else
         {
            sendWarning("loadScoresInRange: Scoreboard " + param1 + " could not be found.");
         }
      }
      
      private static function populateMedals(param1:Array) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:Object = null;
         if(_medals === null)
         {
            _medals = new Array();
            _loc2_ = 0;
            while(_loc2_ < param1.length)
            {
               _loc3_ = param1[_loc2_];
               _medals.push(Medal.createFromObject(_loc3_));
               _loc2_++;
            }
         }
         sendMessage("Medals loaded!");
      }
      
      private static function populateSaveGroups(param1:Array) : void
      {
         var _loc3_:SaveGroup = null;
         _saveGroups = [];
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = SaveGroup.createFromObject(param1[_loc2_]);
            _saveGroups.push(_loc3_);
            _loc2_++;
         }
      }
      
      private static function populateScoreBoards(param1:Array) : void
      {
         _scoreboards = [];
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            _scoreboards.push(new ScoreBoard(param1[_loc2_].id,param1[_loc2_].name,""));
            _loc2_++;
         }
      }
      
      public static function getMedals() : Array
      {
         return _medals;
      }
      
      public static function getMedalById(param1:uint) : Medal
      {
         var _loc2_:Medal = null;
         for each(_loc2_ in _medals)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function getMedal(param1:String) : Medal
      {
         var _loc2_:Medal = null;
         for each(_loc2_ in _medals)
         {
            if(_loc2_.name == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function unlockMedal(param1:String) : void
      {
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         if(!param1 || param1 == "")
         {
            sendError({"command_id":getCommandID("unlockMedal")},new APIError("MISSING_PARAM","missing required medal name"));
            return;
         }
         var _loc2_:Medal = getMedal(param1);
         if(!_loc2_)
         {
            sendMessage("No medal with name: " + param1);
            return;
         }
         if(hasUserSession() || debugMode)
         {
            sendMessage("Attempting to unlock \'" + _loc2_.name + "\'");
            if(_loc2_.unlocked)
            {
               sendWarning("Medal \'" + _loc2_.name + "\' is already unlocked!");
               return;
            }
            _loc3_ = new Object();
            _loc3_.medal_id = _loc2_.id;
            sendSecureCommand("unlockMedal",_loc3_);
         }
         else
         {
            sendMessage("Locally unlocking " + _loc2_.name);
            if(_loc2_.unlocked)
            {
               sendWarning("Medal \'" + _loc2_.name + "\' is already unlocked!");
               return;
            }
            _loc2_.unlocked = true;
            if(!(_loc4_ = loadLocal("medals_unlocked")))
            {
               _loc4_ = new Object();
            }
            _loc4_[_loc2_.id.toString()] = true;
            saveLocal("medals_unlocked",_loc4_);
            callListener(APIEvent.UNLOCK_MEDAL,true,{"medal":_loc2_});
         }
      }
      
      public static function loadMedals() : void
      {
         if(_medals)
         {
            dispatchEvent(new APIEvent(APIEvent.MEDALS_LOADED,true,{"medals":getMedals()}));
            return;
         }
         var _loc1_:Object = new Object();
         if(hasUserSession())
         {
            _loc1_.publisher_id = publisher_id;
            _loc1_.user_id = user_id;
         }
         sendCommand("getMedals",_loc1_);
      }
      
      public static function saveLocal(param1:String, param2:Object, param3:uint = 0) : void
      {
         var sharedObj:SharedObject = null;
         var save_id:String = param1;
         var save_data:Object = param2;
         var size_allocation:uint = param3;
         try
         {
            if(!sharedObjects[save_id])
            {
               sharedObjects[save_id] = SharedObject.getLocal("ng_ap_secure_" + _trackerId + "_" + save_id);
            }
            sharedObj = sharedObjects[save_id];
            sharedObj.data[save_id] = encodeData(save_data);
            sharedObj.flush();
         }
         catch(e:Error)
         {
            sendWarning("saveLocal ERROR: " + e);
         }
      }
      
      public static function loadLocal(param1:String) : Object
      {
         var sharedObj:SharedObject = null;
         var save_id:String = param1;
         try
         {
            if(!sharedObjects[save_id])
            {
               sharedObjects[save_id] = SharedObject.getLocal("ng_ap_secure_" + _trackerId + "_" + save_id);
            }
            sharedObj = sharedObjects[save_id];
            if(sharedObj && sharedObj.data && Boolean(sharedObj.data[save_id]))
            {
               return decodeData(sharedObj.data[save_id]);
            }
            return null;
         }
         catch(e:Error)
         {
            sendWarning("loadLocal ERROR: " + e);
         }
         return null;
      }
      
      public static function encodeData(param1:Object) : String
      {
         return compressHex(RC4.encrypt(com.adobe.serialization.json.JSON.encode(param1),_encryptionKey));
      }
      
      public static function decodeData(param1:String) : *
      {
         return com.adobe.serialization.json.JSON.decode(RC4.decrypt(uncompressHex(param1),_encryptionKey));
      }
      
      private static function compressHex(param1:String) : String
      {
         var _loc2_:uint = param1.length % 6;
         var _loc3_:String = "";
         var _loc4_:uint = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ += compressor.encode(uint("0x" + param1.substr(_loc4_,6)),4);
            _loc4_ += 6;
         }
         return _loc2_.toString() + _loc3_;
      }
      
      private static function uncompressHex(param1:String) : String
      {
         var _loc4_:uint = 0;
         var _loc6_:String = null;
         var _loc7_:uint = 0;
         var _loc8_:String = null;
         var _loc2_:uint = uint(uint(param1.charAt(0)));
         var _loc3_:String = "";
         var _loc5_:uint = 1;
         while(_loc5_ < param1.length)
         {
            _loc6_ = String(param1.substr(_loc5_,4));
            _loc8_ = String((_loc7_ = uint(uint(compressor.decode(_loc6_)))).toString(16));
            if(_loc5_ + 4 < param1.length)
            {
               _loc4_ = 6;
            }
            else
            {
               _loc4_ = _loc2_;
            }
            while(_loc8_.length < _loc4_)
            {
               _loc8_ = "0" + _loc8_;
            }
            _loc3_ += _loc8_;
            _loc5_ += 4;
         }
         return _loc3_;
      }
      
      public static function getSaveGroupById(param1:uint) : SaveGroup
      {
         if(!_saveGroups || _saveGroups.length < 1)
         {
            sendWarning("No save groups found");
            return null;
         }
         var _loc2_:uint = 0;
         while(_loc2_ < _saveGroups.length)
         {
            if(_saveGroups[_loc2_].id == param1)
            {
               return _saveGroups[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public static function getSaveGroup(param1:String) : SaveGroup
      {
         if(!_saveGroups || _saveGroups.length < 1)
         {
            sendWarning("No save groups found");
            return null;
         }
         var _loc2_:uint = 0;
         while(_loc2_ < _saveGroups.length)
         {
            if(_saveGroups[_loc2_].name == param1)
            {
               return _saveGroups[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public static function getCurrentSaveFile() : *
      {
         return save_file;
      }
      
      public static function setCurrentSaveFile(param1:SaveFile) : *
      {
         save_file = param1;
      }
      
      public static function newSaveQuery(param1:String) : SaveGroupQuery
      {
         var _loc2_:SaveGroup = getSaveGroup(param1);
         if(_loc2_)
         {
            return _loc2_.newQuery();
         }
         return null;
      }
      
      public static function executeSaveQuery(param1:SaveGroupQuery) : void
      {
         sendCommand("lookupSaveFiles",{
            "publisher_id":publisher_id,
            "group_id":param1.groupId,
            "query":com.adobe.serialization.json.JSON.encode(param1.toObject())
         },false,null,param1);
      }
      
      public static function lookupSaveFiles(param1:SaveGroup) : void
      {
         var _loc2_:SaveGroupQuery = param1.getQuery(false);
         sendCommand("lookupSaveFiles",{
            "publisher_id":publisher_id,
            "group_id":param1.id,
            "query":_loc2_.toObject()
         },false,null,_loc2_);
      }
      
      public static function checkFilePrivledges(param1:SaveFile) : void
      {
         sendCommand("checkFilePrivs",{
            "group":param1.groupId,
            "filename":param1.name,
            "user_id":(!!user_id ? user_id : 0),
            "publisher_id":publisher_id
         });
      }
      
      public static function newSaveFile(param1:String) : SaveFile
      {
         var _loc2_:SaveGroup = getSaveGroup(param1);
         if(_loc2_)
         {
            return new SaveFile(_loc2_);
         }
         sendError({"command_id":"newSaveFile"},new APIError("INVALID_SAVE_GROUP","\'" + _loc2_ + "\' is not a valid save group."));
         return null;
      }
      
      public static function saveFile(param1:SaveFile, param2:Boolean = false, param3:Boolean = false) : void
      {
         var _loc4_:Object;
         (_loc4_ = param1.toObject()).user_name = user_name;
         if(param1.id)
         {
            _loc4_.save_id = param1.id;
         }
         _loc4_.overwrite = param2 ? 1 : 0;
         if(param3)
         {
            _loc4_.draft = 1;
         }
         var _loc5_:ByteArray = new ByteArray();
         if(param1.contents is ByteArray)
         {
            _loc5_.writeByte(0);
            _loc5_.writeBytes(param1.contents);
         }
         else
         {
            _loc5_.writeByte(1);
            _loc5_.writeObject(param1.contents);
         }
         _loc5_.compress();
         var _loc6_:Object;
         (_loc6_ = new Object()).file = _loc5_;
         if(param1.thumbnail)
         {
            _loc6_.thumbnail = PNGEncoder.encode(param1.thumbnail);
         }
         save_file = param1;
         sendSecureCommand("saveFile",_loc4_,null,_loc6_,param1);
      }
      
      public static function rateSaveFile(param1:SaveFile, param2:SaveRating, param3:Number) : void
      {
         sendSecureCommand("rateSaveFile",{
            "group":param1.groupId,
            "save_id":param1.id,
            "rating_id":param2.id,
            "vote":param3,
            "user_id":user_id
         },null,null,param1);
      }
      
      public static function loadSaveFile(param1:Number, param2:Boolean = true) : *
      {
         var _loc3_:Object = {
            "publisher_id":publisher_id,
            "save_id":param1,
            "get_contents":param2
         };
         save_file = null;
         sendCommand("loadSaveFile",_loc3_);
      }
      
      public static function loadFilesByDate(param1:String, param2:Boolean = true, param3:String = null, param4:* = null) : void
      {
         var _loc7_:* = undefined;
         var _loc5_:SaveGroup;
         if(!(_loc5_ = getSaveGroup(param1)))
         {
            _loc7_ = new APIError("QUERY_INCOMPLETE","The query could not be preformed, check the spelling of your save group name.");
            sendError({"command_id":"loadFilesByDate"},_loc7_);
            return;
         }
         var _loc6_:SaveGroupQuery = _loc5_.newQuery();
         if(param3)
         {
            _loc6_.addKeyCondition(param3,"=",param4);
         }
         _loc6_.sortOn(SaveGroupQuery.CREATED_ON,param2);
         _loc6_.execute();
      }
      
      public static function loadFilesByViews(param1:String, param2:Boolean = true, param3:String = null, param4:* = null) : void
      {
         var _loc7_:* = undefined;
         var _loc5_:SaveGroup;
         if(!(_loc5_ = getSaveGroup(param1)))
         {
            _loc7_ = new APIError("QUERY_INCOMPLETE","The query could not be preformed, check the spelling of your save group name.");
            sendError({"command_id":"loadFilesByViews"},_loc7_);
            return;
         }
         var _loc6_:SaveGroupQuery = _loc5_.newQuery();
         if(param3)
         {
            _loc6_.addKeyCondition(param3,"=",param4);
         }
         _loc6_.sortOn(SaveGroupQuery.TOTAL_VIEWS,param2);
         _loc6_.execute();
      }
      
      public static function loadFilesByRating(param1:String, param2:String, param3:Boolean = true, param4:String = null, param5:* = null) : void
      {
         var _loc8_:* = undefined;
         var _loc6_:SaveGroup;
         if(!(_loc6_ = getSaveGroup(param1)))
         {
            _loc8_ = new APIError("QUERY_INCOMPLETE","The query could not be preformed, check the spelling of your save group name.");
            sendError({"command_id":"loadFilesByDate"},_loc8_);
            return;
         }
         var _loc7_:SaveGroupQuery = _loc6_.newQuery();
         if(param4)
         {
            _loc7_.addKeyCondition(param4,"=",param5);
         }
         _loc7_.sortOnRating(param2,param3);
         _loc7_.execute();
      }
      
      public static function onRemoteAuthentication(param1:String) : *
      {
         var _loc2_:Object = com.adobe.serialization.json.JSON.decode(RC4.decrypt(param1,_encryptionKey));
         user_id = _loc2_.NewgroundsAPI_UserID;
         user_name = _loc2_.NewgroundsAPI_UserName;
         session_id = _loc2_.NewgroundsAPI_SessionID;
         publisher_id = _loc2_.NewgroundsAPI_PublisherID;
      }
      
      private static function doEvent(param1:Object) : void
      {
         var _loc2_:* = null;
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc5_:Boolean = false;
         var _loc6_:ScoreBoard = null;
         var _loc7_:Array = null;
         var _loc8_:* = undefined;
         var _loc9_:String = null;
         var _loc10_:Medal = null;
         var _loc11_:SaveGroup = null;
         var _loc12_:Object = null;
         var _loc13_:Object = null;
         var _loc14_:Object = null;
         var _loc15_:SaveFile = null;
         var _loc16_:uint = 0;
         var _loc17_:Object = null;
         var _loc18_:uint = 0;
         var _loc19_:APIError = null;
         var _loc20_:Object = null;
         switch(getCommandName(param1.command_id))
         {
            case "connectMovie":
               timeoutTimer.stop();
               if(param1.success)
               {
                  sendMessage("You have successfully connected to the Newgrounds API Gateway");
                  sendMessage("Movie identified as \"" + param1.movie_name + "\"");
                  callListener(APIEvent.API_CONNECTED,param1.success,{"title":param1.movie_name});
                  _loc5_ = false;
                  if(param1.ad_status === -1)
                  {
                     _loc2_ = "This movie was not approved to run Flash Ads.";
                     sendWarning(_loc2_);
                     sendWarning("visit " + AD_TERMS_URL + " to view our approval guidelines");
                     if(!param1.ad_url)
                     {
                        callListener(APIEvent.ADS_APPROVED,false,new APIError("FLASH_ADS_NOT_APPROVED",_loc2_));
                     }
                     else
                     {
                        _loc5_ = true;
                     }
                  }
                  else if(param1.ad_status === 0)
                  {
                     _loc2_ = "Flash Ads are currently awaiting approval.";
                     sendNotice(_loc2_);
                     if(!param1.ad_url)
                     {
                        callListener(APIEvent.ADS_APPROVED,false,new APIError("FLASH_ADS_NOT_APPROVED",_loc2_));
                     }
                     else
                     {
                        _loc5_ = true;
                     }
                  }
                  if(param1.ad_url)
                  {
                     ad_url = unescape(param1.ad_url);
                     if(!_loc5_)
                     {
                        sendMessage("This movie has been approved to run Flash Ads!");
                     }
                     _adsApproved = true;
                     callListener(APIEvent.ADS_APPROVED,true);
                  }
                  if(param1.deny_host)
                  {
                     _loc2_ = getHost() + " does not have permission to run this movie!";
                     sendWarning(_loc2_);
                     sendWarning("\tUpdate your API configuration to unblock " + getHost());
                     callListener(APIEvent.HOST_BLOCKED,true,{
                        "real_url":unescape(param1.movie_url),
                        "url":getOfficialURL()
                     });
                  }
                  if(param1.movie_version)
                  {
                     sendWarning("According to your API Configuration, this version is out of date.");
                     if(version)
                     {
                        sendWarning("\tThe this movie is version " + version);
                     }
                     sendWarning("\tThe most current version is " + param1.movie_version);
                     callListener(APIEvent.NEW_VERSION_AVAILABLE,true,{
                        "version":param1.movie_version,
                        "real_url":unescape(param1.movie_url),
                        "url":getOfficialURL()
                     });
                  }
                  if(param1.request_portal_url)
                  {
                     sendCommand("setPortalID",{"portal_url":_url});
                  }
                  sendCommand("preloadSettings",{
                     "publisher_id":publisher_id,
                     "user_id":user_id
                  });
                  break;
               }
               callListener(APIEvent.API_CONNECTED,param1.success,{});
               return;
               break;
            case "preloadSettings":
               if(param1.medals)
               {
                  populateMedals(param1.medals);
                  if(!hasUserSession() && !debugMode)
                  {
                     echo("Checking for SharedObject Medals...");
                     if(_loc8_ = loadLocal("medals_unlocked"))
                     {
                        for(_loc9_ in _loc8_)
                        {
                           if(_loc8_[_loc9_])
                           {
                              _loc10_ = getMedalById(uint(_loc9_));
                              echo("Now unlocking " + _loc10_.name);
                              _loc10_.unlocked = true;
                           }
                        }
                     }
                  }
               }
               if(param1.save_groups)
               {
                  populateSaveGroups(param1.save_groups);
               }
               if(param1.save_file_path)
               {
                  _saveFilePath = param1.save_file_path + "/";
               }
               if(param1.image_file_path)
               {
                  _imageFilePath = param1.image_file_path + "/";
               }
               if(param1.score_boards)
               {
                  populateScoreBoards(param1.score_boards);
               }
               sendMessage("Metadata loaded!");
               callListener(APIEvent.METADATA_LOADED,param1.success);
               if(Boolean(_saveFileId) && Boolean(_saveGroupId))
               {
                  if(_loc11_ = getSaveGroupById(_saveGroupId))
                  {
                     callListener(APIEvent.FILE_REQUESTED,true,{
                        "save_id":_saveFileId,
                        "group":_loc11_
                     });
                  }
               }
               _preloadComplete = true;
               break;
            case "logCustomEvent":
               if(param1.success)
               {
                  sendMessage("Event \'" + param1.event + "\' was logged.");
               }
               callListener(APIEvent.EVENT_LOGGED,param1.success,{"event":param1.event});
               break;
            case "postScore":
               if(param1.success)
               {
                  _loc4_ = "User";
                  if(user_email)
                  {
                     _loc4_ = user_email;
                  }
                  else if(user_name)
                  {
                     _loc4_ = user_name;
                  }
                  if(_loc6_ = getScoreBoardById(param1.board))
                  {
                     sendMessage(_loc4_ + " posted " + param1.value + " to \'" + _loc6_.name + "\'");
                  }
                  if(param1.best_scores)
                  {
                     _loc12_ = {
                        "today":param1.best_scores.D,
                        "yesterday":param1.best_scores.P,
                        "week":param1.best_scores.W,
                        "year":param1.best_scores.Y,
                        "all_time":param1.best_scores.A
                     };
                  }
                  else
                  {
                     _loc12_ = {};
                  }
                  if(param1.best_ranks)
                  {
                     _loc13_ = {
                        "today":param1.best_ranks.D,
                        "yesterday":param1.best_ranks.P,
                        "week":param1.best_ranks.W,
                        "year":param1.best_ranks.Y,
                        "all_time":param1.best_ranks.A
                     };
                  }
                  else
                  {
                     _loc13_ = {};
                  }
                  if(param1.num_scores)
                  {
                     _loc14_ = {
                        "today":param1.num_scores.D,
                        "yesterday":param1.num_scores.P,
                        "week":param1.num_scores.W,
                        "year":param1.num_scores.Y,
                        "all_time":param1.num_scores.A
                     };
                  }
                  else
                  {
                     _loc14_ = {};
                  }
                  _loc3_ = {
                     "score":param1.score,
                     "value":param1.value,
                     "username":_loc4_,
                     "best_scores":_loc12_,
                     "best_ranks":_loc13_,
                     "num_scores":_loc14_
                  };
               }
               callListener(APIEvent.SCORE_POSTED,param1.success,_loc3_);
               break;
            case "loadScores":
               _loc3_ = new Object();
               if(_loc6_ = getScoreBoardById(param1.board))
               {
                  _loc6_.setScores(param1.scores,param1.period,param1.page,param1.num_results,param1.num_scores);
               }
               callListener(APIEvent.SCORES_LOADED,param1.success,{"board":_loc6_});
               break;
            case "unlockMedal":
               if(_medals)
               {
                  if((_loc10_ = getMedal(param1.medal_name)).unlocked)
                  {
                     return;
                  }
                  _loc10_.unlocked = true;
                  callListener(APIEvent.MEDAL_UNLOCKED,param1.success,{
                     "medal_id":_loc10_.id,
                     "medal":_loc10_
                  });
               }
               break;
            case "getMedals":
               if(param1.success)
               {
                  populateMedals(param1.medals);
               }
               callListener(APIEvent.MEDALS_LOADED,param1.success,_loc3_);
               break;
            case "loadSaveFile":
               if(param1.success)
               {
                  _loc11_ = getSaveGroupById(param1.group_id);
                  (_loc15_ = new SaveFile(_loc11_)).id = param1.file.save_id;
                  _loc15_.name = param1.file.filename;
                  _loc15_.fileUrl = _saveFilePath + param1.file.file;
                  _loc15_.thumbnailUrl = _imageFilePath + param1.file.thumb;
                  _loc15_.authorName = param1.file.user_name;
                  _loc15_.authorId = param1.file.user_id;
                  _loc15_.setStatus(param1.file.status);
                  _loc15_.description = param1.file.description;
                  _loc15_.setFileSize(param1.file.file_size);
                  if(Boolean(param1.file.keys) && Boolean(param1.file.keys.length))
                  {
                     _loc16_ = 0;
                     while(_loc16_ < param1.file.keys.length)
                     {
                        _loc15_.setKey(param1.file.keys[_loc16_].id,param1.file.keys[_loc16_].value);
                        _loc16_++;
                     }
                  }
                  if(Boolean(param1.file.ratings) && Boolean(param1.file.ratings.length))
                  {
                     _loc16_ = 0;
                     while(_loc16_ < param1.file.ratings.length)
                     {
                        _loc15_.setRating(param1.file.ratings[_loc16_].id,param1.file.ratings[_loc16_].votes,param1.file.ratings[_loc16_].score);
                        _loc16_++;
                     }
                  }
                  if(param1.get_contents)
                  {
                     _loc15_.loadContents();
                  }
               }
               save_file = _loc15_;
               callListener(APIEvent.FILE_INITIALIZED,param1.success,{
                  "save_id":_loc15_.id,
                  "file":_loc15_
               });
               break;
            case "lookupSaveFiles":
               _loc7_ = [];
               if(Boolean(param1.success) && Boolean(param1.files))
               {
                  _loc16_ = 0;
                  while(_loc16_ < param1.files.length)
                  {
                     _loc17_ = param1.files[_loc16_];
                     (_loc15_ = new SaveFile(getSaveGroupById(param1.group_id))).name = _loc17_.filename;
                     _loc15_.id = _loc17_.save_id;
                     _loc15_.description = _loc17_.description;
                     _loc15_.thumbnailUrl = _imageFilePath + _loc17_.thumb;
                     _loc15_.fileUrl = _saveFilePath + _loc17_.file;
                     _loc15_.authorName = _loc17_.user_name;
                     _loc15_.authorId = _loc17_.user_id;
                     _loc15_.setStatus(_loc17_.status);
                     _loc15_.setFileSize(_loc17_.file_size);
                     if(Boolean(_loc17_.keys) && Boolean(_loc17_.keys.length))
                     {
                        _loc18_ = 0;
                        while(_loc18_ < _loc17_.keys.length)
                        {
                           _loc15_.setKey(_loc17_.keys[_loc18_].id,_loc17_.keys[_loc18_].value);
                           _loc18_++;
                        }
                     }
                     if(Boolean(_loc17_.ratings) && Boolean(_loc17_.ratings.length))
                     {
                        _loc18_ = 0;
                        while(_loc18_ < _loc17_.ratings.length)
                        {
                           _loc15_.setRating(_loc17_.ratings[_loc18_].id,_loc17_.ratings[_loc18_].votes,_loc17_.ratings[_loc18_].score);
                           _loc18_++;
                        }
                     }
                     _loc7_.push(_loc15_);
                     _loc16_++;
                  }
               }
               param1.owner.setResults(_loc7_);
               param1.owner.dispatchEvent(new APIEvent(APIEvent.QUERY_COMPLETE,param1.success,{"query":param1.owner}));
               callListener(APIEvent.QUERY_COMPLETE,param1.success,{"query":param1.owner});
               break;
            case "rateSaveFile":
               _loc15_ = param1.owner;
               param1.success = param1.success && !param1.already_voted;
               if(param1.success)
               {
                  _loc15_.setRating(param1.rating_id,param1.votes,param1.score);
               }
               param1.file = _loc15_;
               if(param1.already_voted)
               {
                  _loc19_ = new APIError("PERMISSION_DENIED","You have already voted on this item today");
                  _loc15_.dispatchEvent(new APIEvent(APIEvent.VOTE_COMPLETE,param1.success,{
                     "error":_loc19_,
                     "file":_loc15_,
                     "save_id":_loc15_.id
                  }));
                  callListener(APIEvent.VOTE_COMPLETE,param1.success,param1);
               }
               else
               {
                  _loc20_ = _loc15_.getRating(param1.rating_id);
                  _loc15_.dispatchEvent(new APIEvent(APIEvent.VOTE_COMPLETE,param1.success,{
                     "rating":_loc20_,
                     "file":_loc15_,
                     "save_id":_loc15_.id
                  }));
                  API.callListener(APIEvent.VOTE_COMPLETE,param1.success,{
                     "rating":_loc20_,
                     "file":_loc15_,
                     "save_id":_loc15_.id
                  });
               }
               break;
            case "saveFile":
               _loc3_ = {};
               if(param1.success)
               {
                  _loc3_ = {
                     "save_id":param1.save_id,
                     "filename":param1.filename,
                     "file_url":param1.file_url,
                     "thumbnail":param1.thumbnail,
                     "icon":param1.icon
                  };
                  SaveFile(param1.owner).fileSaved(_loc3_);
               }
               param1.owner.dispatchEvent(new APIEvent(APIEvent.FILE_SAVED,param1.success,{
                  "save_id":save_file.id,
                  "file":save_file
               }));
               callListener(APIEvent.FILE_SAVED,param1.success,{
                  "save_id":save_file.id,
                  "file":save_file
               });
               save_file = null;
               break;
            case "checkFilePrivs":
               _loc3_ = {
                  "filename":param1.filename,
                  "folder":param1.folder,
                  "can_read":param1.can_read,
                  "can_write":param1.can_write
               };
               callListener(APIEvent.FILE_PRIVS_LOADED,param1.success,_loc3_);
         }
      }
      
      public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:uint = 0, param5:Boolean = false) : void
      {
         _eventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public static function hasEventListener(param1:String) : Boolean
      {
         return _eventDispatcher.hasEventListener(param1);
      }
      
      public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         _eventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      private static function dispatchEvent(param1:Event) : void
      {
         _eventDispatcher.dispatchEvent(param1);
         echo("Fired Event: " + param1.type);
      }
      
      internal static function callListener(param1:String, param2:Boolean = true, param3:* = undefined) : void
      {
         dispatchEvent(new APIEvent(param1,param2,param3));
         if(_bridge)
         {
            _bridge.sendEvent(param1,{
               "success":param2,
               "data":param3
            });
         }
      }
      
      private static function getCommandName(param1:String) : String
      {
         return param1;
      }
      
      private static function getCommandID(param1:String) : String
      {
         return param1;
      }
      
      private static function getPeriodAliases() : Object
      {
         var _loc2_:String = null;
         var _loc1_:Object = new Object();
         for(_loc2_ in period_aliases)
         {
            _loc1_[period_aliases[_loc2_].alias] = _loc2_;
         }
         return _loc1_;
      }
      
      public static function getPeriodName(param1:String) : String
      {
         var _loc2_:String = null;
         for(_loc2_ in period_aliases)
         {
            if(_loc2_ == param1)
            {
               return period_aliases[_loc2_].name;
            }
         }
         return null;
      }
      
      public static function getPeriodAlias(param1:String) : String
      {
         var _loc2_:String = null;
         for(_loc2_ in period_aliases)
         {
            if(_loc2_ == param1)
            {
               return period_aliases[_loc2_].alias;
            }
         }
         return null;
      }
      
      private static function sendError(param1:Object, param2:APIError) : void
      {
         var _loc3_:String = "[NewgroundsAPI ERROR] :: " + getCommandName(param1.command_id) + "() - " + param2.name + ":\n\t\t\t\t" + param2.message;
         trace(_loc3_);
         if(_bridge)
         {
            _bridge.sendEvent("trace",{"data":_loc3_});
         }
      }
      
      private static function sendWarning(param1:String, param2:String = null) : void
      {
         if(param2)
         {
            param1 += "\n[NewgroundsAPI WARNING] :: \tSee " + COMMANDS_WIKI_URL + param2.toLowerCase() + " for additional information.";
         }
         trace(param1);
         if(_bridge)
         {
            _bridge.sendEvent("trace",{"data":param1});
         }
      }
      
      private static function sendNotice(param1:String, param2:String = null) : void
      {
         var _loc3_:String = null;
         if(param2)
         {
            param1 += "\n[NewgroundsAPI NOTICE] :: \tSee " + COMMANDS_WIKI_URL + param2.toLowerCase() + " for additional information.";
         }
         trace(param1);
         if(_bridge)
         {
            _bridge.sendEvent("trace",{"data":param1});
         }
      }
      
      private static function fatalError(param1:String, param2:String) : void
      {
         if(param2)
         {
            param1 += "\n\tSee " + COMMANDS_WIKI_URL + param2.toLowerCase() + " for additional information.";
         }
         trace("***ERROR*** class=API\n\n" + param1);
      }
      
      public static function openLoginPage() : *
      {
         if(hasUserSession())
         {
            return;
         }
      }
      
      public static function sendSecureCommand(param1:String, param2:Object, param3:Object = null, param4:Object = null, param5:* = null) : void
      {
         if(!debugMode && !hasUserSession() && !hasUserEmail())
         {
            sendError({"command_id":getCommandID(param1)},new APIError("IDENTIFICATION_REQUIRED","You must be logged in or provide an e-mail address ( using NewgroundsAPI.setUserEmail(\"name@domain.com\"); ) to use " + param1 + "()."));
            return;
         }
         if(!param1)
         {
            fatalError("Missing command","sendSecureCommand");
         }
         if(!param2)
         {
            fatalError("Missing secure_params","sendSecureCommand");
         }
         if(!param3)
         {
            param3 = new Object();
         }
         var _loc6_:String = "";
         var _loc7_:uint = 0;
         while(_loc7_ < 16)
         {
            _loc6_ += compression_radix.charAt(Math.floor(Math.random() * compression_radix.length));
            _loc7_++;
         }
         if(debugMode && !session_id)
         {
            param2.session_id = "";
         }
         else
         {
            param2.session_id = session_id;
         }
         param2.as_version = 3;
         param2.user_email = user_email;
         param2.publisher_id = publisher_id;
         param2.seed = _loc6_;
         param2.command_id = getCommandID(param1);
         var _loc8_:String = MD5.hash(_loc6_);
         var _loc9_:String = RC4.encrypt(com.adobe.serialization.json.JSON.encode(param2),_encryptionKey);
         var _loc10_:String = _loc8_ + _loc9_;
         param3.secure = compressHex(_loc10_);
         secureCommand = param1;
         sendCommand("securePacket",param3,false,param4,param5);
      }
      
      public static function stopPendingCommands() : void
      {
         SmartURLLoader.closeAll();
      }
      
      private static function onCommandComplete(param1:Event) : void
      {
         var i:uint;
         var response:Object = null;
         var error:APIError = null;
         var e:Event = param1;
         var loader:SmartURLLoader = SmartURLLoader(e.target);
         echo("INPUT: \n" + loader.response + "\n");
         i = 0;
         while(i < _preloadAssets.length)
         {
            if(_preloadAssets[i] == loader)
            {
               _preloadAssets.splice(i,1);
               break;
            }
            i++;
         }
         try
         {
            response = com.adobe.serialization.json.JSON.decode(loader.response);
         }
         catch(error:Error)
         {
         }
         if(!response)
         {
            response = {
               "command_id":loader._command,
               "success":false
            };
         }
         response.owner = loader.owner;
         if(!response || !response.success)
         {
            if(response.command_id == "connectMovie")
            {
               connected = false;
            }
            error = new APIError(response.error_code,response.error_msg);
            sendError(response,error);
            if(response.command_id)
            {
               doEvent(response);
            }
         }
         else
         {
            doEvent(response);
         }
      }
      
      private static function onCommandError(param1:Event) : void
      {
         var _loc2_:Object = {"success":false};
         var _loc3_:SmartURLLoader = SmartURLLoader(param1.target);
         _loc2_.owner = _loc3_.owner;
         var _loc4_:uint = 0;
         while(_loc4_ < _preloadAssets.length)
         {
            if(_preloadAssets[_loc4_] == _loc3_)
            {
               _preloadAssets.splice(_loc4_,1);
               break;
            }
            _loc4_++;
         }
         if(_loc3_._command)
         {
            _loc2_.command_id = _loc3_._command;
            if(_loc2_.command_id == "connectMovie")
            {
               connected = false;
            }
            doEvent(_loc2_);
         }
      }
      
      private static function sendCommand(param1:String, param2:Object, param3:Boolean = false, param4:Object = null, param5:* = null) : void
      {
         var _loc7_:* = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         if(!connected && param1 != "connectMovie")
         {
            _loc7_ = "NewgroundsAPI." + param1 + "() - NewgroundsAPI.connectMovie() must be called before this command can be called\n";
            fatalError(_loc7_,"connectMovie");
         }
         var _loc6_:SmartURLLoader;
         (_loc6_ = new SmartURLLoader()).addVariable("command_id",getCommandID(param1));
         _loc6_.addVariable("tracker_id",_movieId);
         if(debugMode)
         {
            _loc6_.addVariable("debug",1);
         }
         if(param2)
         {
            for(_loc8_ in param2)
            {
               _loc6_.addVariable(_loc8_,param2[_loc8_]);
            }
         }
         if(param4)
         {
            for(_loc9_ in param4)
            {
               _loc6_.addFile(_loc9_,param4[_loc9_],_loc9_);
            }
         }
         if(param3)
         {
            _loc6_.method = URLRequestMethod.GET;
         }
         else
         {
            _loc6_.method = URLRequestMethod.POST;
         }
         _loc6_.preventCache = true;
         if(param3)
         {
            _loc6_.openBrowser = true;
            _loc6_.method = URLRequestMethod.GET;
         }
         else
         {
            _loc6_.addEventListener(Event.COMPLETE,onCommandComplete);
            _loc6_.addEventListener(IOErrorEvent.IO_ERROR,onCommandError);
            _loc6_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onCommandError);
            _loc6_.method = URLRequestMethod.POST;
         }
         if(param2.secure)
         {
            _loc6_._command = secureCommand;
         }
         else
         {
            _loc6_._command = getCommandID(param1);
         }
         _loc6_.owner = param5;
         _loc6_.load(GATEWAY_URL);
      }
      
      public static function isFlashVersion(param1:uint, param2:uint = 0, param3:uint = 0, param4:uint = 0) : Boolean
      {
         var _loc6_:Array = Capabilities.version.split(" ")[1].split(",");
         var _loc7_:Array = arguments;
         var _loc8_:uint = 0;
         while(_loc8_ < _loc7_.length)
         {
            _loc6_[_loc8_] = uint(_loc6_[_loc8_]);
            _loc8_++;
         }
         _loc8_ = 0;
         while(_loc8_ < _loc7_.length)
         {
            if(_loc6_[_loc8_] > _loc7_[_loc8_])
            {
               return true;
            }
            if(_loc6_[_loc8_] < _loc7_[_loc8_])
            {
               return false;
            }
            _loc8_++;
         }
         return true;
      }
      
      public static function createAd() : FlashAd
      {
         sendMessage("You may see a security sandbox violation. This is normal!");
         return new FlashAd();
      }
      
      public static function sendMessage(param1:String, param2:Boolean = false) : void
      {
         var _loc3_:String = "[NewgroundsAPI] :: " + param1;
         trace(_loc3_);
         if(_bridge)
         {
            _bridge.sendEvent("trace",{"data":_loc3_});
         }
      }
      
      private static function echo(param1:String) : void
      {
         if(do_echo)
         {
            trace(param1);
         }
      }
   }
}
