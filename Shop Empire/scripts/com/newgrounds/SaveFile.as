package com.newgrounds
{
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class SaveFile extends EventDispatcher
   {
      
      public static const STATUS_PRIVATE:* = 1;
      
      public static const STATUS_SHARED:* = 2;
      
      public static const STATUS_UNAPPROVED:* = 3;
      
      public static const STATUS_APPROVED:* = 4;
       
      
      private var _filename:String;
      
      private var _id:uint;
      
      private var _description:String;
      
      private var _contents:*;
      
      private var _loader:SmartURLLoader;
      
      private var _group:SaveGroup;
      
      private var _keys:Dictionary;
      
      private var _ratings:Dictionary;
      
      private var _fileUrl:String;
      
      private var _thumbnail:BitmapData;
      
      private var _thumbnailUrl:String;
      
      private var _authorId:uint;
      
      private var _authorName:String;
      
      private var _contentSize:uint;
      
      private var _locked:Boolean;
      
      private var _status:uint;
      
      private var duplicate_id:uint;
      
      private var _draft:Boolean;
      
      public function SaveFile(param1:SaveGroup)
      {
         super();
         this._keys = new Dictionary();
         this._ratings = new Dictionary();
         this._group = param1;
         this._description = "";
      }
      
      public function get name() : String
      {
         return this._filename;
      }
      
      public function set name(param1:String) : void
      {
         this._filename = param1;
      }
      
      public function get id() : uint
      {
         return this._id;
      }
      
      public function set id(param1:uint) : void
      {
         this._id = param1;
      }
      
      public function get description() : String
      {
         return this._description;
      }
      
      public function set description(param1:String) : void
      {
         this._description = param1;
      }
      
      public function get contents() : *
      {
         return this._contents;
      }
      
      public function set contents(param1:*) : void
      {
         this._contents = param1;
         this._contentSize = 0;
      }
      
      public function get thumbnailUrl() : String
      {
         return this._thumbnailUrl;
      }
      
      public function set thumbnailUrl(param1:String) : void
      {
         this._thumbnailUrl = param1;
      }
      
      public function get fileUrl() : String
      {
         return this._fileUrl;
      }
      
      public function set fileUrl(param1:String) : void
      {
         this._fileUrl = param1;
      }
      
      public function get thumbnail() : BitmapData
      {
         return this._thumbnail;
      }
      
      public function set thumbnail(param1:BitmapData) : void
      {
         if(this._thumbnail)
         {
            this._thumbnail.dispose();
         }
         this._thumbnail = param1.clone();
      }
      
      public function loadThumbnail() : Loader
      {
         var _loc1_:Loader = new Loader();
         if(this._thumbnailUrl)
         {
            _loc1_.load(new URLRequest(this._thumbnailUrl));
         }
         return _loc1_;
      }
      
      public function get bytesLoaded() : uint
      {
         return !!this._loader ? this._loader.bytesLoaded : this._contentSize;
      }
      
      public function get bytesTotal() : uint
      {
         return this._contentSize;
      }
      
      public function get status() : uint
      {
         return this._status;
      }
      
      internal function setStatus(param1:uint) : void
      {
         this._status = param1;
      }
      
      public function get groupId() : uint
      {
         return this._group.id;
      }
      
      public function get groupName() : String
      {
         return this._group.name;
      }
      
      public function get groupType() : uint
      {
         return this._group.type;
      }
      
      public function get authorName() : String
      {
         return this._authorName;
      }
      
      public function set authorName(param1:String) : void
      {
         this._authorName = param1;
      }
      
      public function get authorId() : uint
      {
         return this._authorId;
      }
      
      public function set authorId(param1:uint) : void
      {
         this._authorId = param1;
      }
      
      public function get draft() : Boolean
      {
         return this._draft;
      }
      
      public function set draft(param1:Boolean) : void
      {
         this._draft = param1;
      }
      
      public function get locked() : Boolean
      {
         return this._locked;
      }
      
      public function get shared() : Boolean
      {
         return this._status == STATUS_SHARED;
      }
      
      public function get isPrivate() : Boolean
      {
         return this._status == STATUS_PRIVATE;
      }
      
      public function get isPublic() : Boolean
      {
         if(this.isPrivate)
         {
            return false;
         }
         if(this._group.isType("SYSTEM") || this._group.isType("PRIVATE"))
         {
            return false;
         }
         if(this._group.isType("PUBLIC"))
         {
            return true;
         }
         if(this.approved)
         {
            return true;
         }
         return false;
      }
      
      public function get approved() : Boolean
      {
         return this._status > STATUS_UNAPPROVED;
      }
      
      public function get keys() : Dictionary
      {
         return this._keys;
      }
      
      public function get ratings() : Dictionary
      {
         return this._ratings;
      }
      
      internal function setPermissions(param1:uint, param2:Boolean) : *
      {
         param2 = this._locked;
         this._status = param1;
      }
      
      internal function setFileSize(param1:uint) : void
      {
         this._contentSize = param1;
      }
      
      public function isLocked() : Boolean
      {
         return this._locked;
      }
      
      public function getDescription() : String
      {
         return this._description;
      }
      
      public function getShared() : Boolean
      {
         return this._draft;
      }
      
      public function getDuplicateID() : uint
      {
         return this.duplicate_id;
      }
      
      public function getKeys() : Dictionary
      {
         return this._keys;
      }
      
      public function getRatings() : Dictionary
      {
         return this._ratings;
      }
      
      public function setKey(param1:*, param2:*) : void
      {
         var _loc3_:SaveKey = null;
         if(param1 is String)
         {
            _loc3_ = this._group.getKeyName(param1);
         }
         else
         {
            _loc3_ = this._group.getKeyID(param1);
         }
         if(_loc3_)
         {
            switch(_loc3_.type)
            {
               case SaveKey.TYPE_BOOLEAN:
                  this._keys[_loc3_] = {
                     "id":_loc3_.id,
                     "value":Boolean(int(param2))
                  };
                  break;
               case SaveKey.TYPE_FLOAT:
                  this._keys[_loc3_] = {
                     "id":_loc3_.id,
                     "value":Number(param2)
                  };
                  break;
               case SaveKey.TYPE_INTEGER:
                  this._keys[_loc3_] = {
                     "id":_loc3_.id,
                     "value":int(param2)
                  };
                  break;
               case SaveKey.TYPE_STRING:
               default:
                  this._keys[_loc3_] = {
                     "id":_loc3_.id,
                     "value":param2.toString()
                  };
            }
         }
      }
      
      public function getKey(param1:*) : *
      {
         var _loc2_:SaveKey = null;
         if(param1 is String)
         {
            _loc2_ = this._group.getKeyName(param1);
         }
         else
         {
            _loc2_ = this._group.getKeyID(param1);
         }
         if(_loc2_)
         {
            return this._keys[_loc2_];
         }
         return null;
      }
      
      public function setRating(param1:*, param2:Number, param3:Number) : void
      {
         var _loc4_:SaveRating = null;
         if(param1 is String)
         {
            _loc4_ = this._group.getRatingName(param1);
         }
         else
         {
            _loc4_ = this._group.getRatingID(param1);
         }
         if(_loc4_)
         {
            this._ratings[_loc4_] = {
               "id":_loc4_.id,
               "name":_loc4_.name,
               "votes":param2,
               "score":param3
            };
         }
      }
      
      public function getRating(param1:*) : Object
      {
         var _loc2_:SaveRating = null;
         if(param1 is String)
         {
            _loc2_ = this._group.getRatingName(param1);
         }
         else
         {
            _loc2_ = this._group.getRatingID(param1);
         }
         if(_loc2_)
         {
            return this._ratings[_loc2_];
         }
         return null;
      }
      
      public function sendRating(param1:String, param2:Number) : void
      {
         var _loc3_:SaveRating = this._group.getRatingName(param1);
         if(!_loc3_)
         {
            trace("[NewgroundsAPISaveFile] " + param1 + " is not a recognized save file");
            return;
         }
         if(param2 < _loc3_.minValue || param2 > _loc3_.maxValue)
         {
            trace("[NewgroundsAPISaveFile] Vote must be between " + _loc3_.minValue + " and " + _loc3_.maxValue);
            return;
         }
         _loc3_.voted = true;
         API.rateSaveFile(this,_loc3_,param2);
      }
      
      override public function toString() : String
      {
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         var _loc1_:* = "Save File " + this._filename + "   ID: " + this._id + "\n  " + this._description + "\n";
         for each(_loc2_ in this._keys)
         {
            _loc1_ += "  " + this._group.getKeyID(_loc2_.id).name + ": " + _loc2_.val + "\n";
         }
         for each(_loc3_ in this._ratings)
         {
            _loc1_ += "  " + this._group.getRatingID(_loc3_.id).name + "\n    Score: " + _loc3_.score + " Votes: " + _loc3_.votes + "\n";
         }
         return _loc1_;
      }
      
      public function toObject() : Object
      {
         var _loc2_:Object = null;
         var _loc1_:Object = {
            "group":this.groupId,
            "filename":this.name,
            "description":this.description,
            "shared":true
         };
         _loc1_.keys = [];
         for each(_loc2_ in this._keys)
         {
            _loc1_.keys.push({
               "id":_loc2_.id,
               "value":_loc2_.val
            });
         }
         return _loc1_;
      }
      
      public function save(param1:Boolean = false, param2:Boolean = false) : void
      {
         API.saveFile(this,param1,param2);
      }
      
      public function loadContents() : void
      {
         if(this._fileUrl)
         {
            this._loader = new SmartURLLoader();
            this._loader.responseFormat = URLLoaderDataFormat.BINARY;
            this._loader.addEventListener(Event.COMPLETE,this.onContentsLoaded);
            this._loader.addEventListener(IOErrorEvent.IO_ERROR,this.onContentsError);
            this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onContentsError);
            this._loader.load(this._fileUrl);
         }
      }
      
      private function onContentsError(param1:Event) : void
      {
         this._loader = null;
         dispatchEvent(new APIEvent(APIEvent.FILE_LOADED,false));
         API.callListener(APIEvent.FILE_LOADED,false);
      }
      
      private function onContentsLoaded(param1:Event) : void
      {
         var _loc2_:ByteArray = param1.target.response;
         this._contentSize = _loc2_.length;
         _loc2_.uncompress();
         var _loc3_:uint = uint(_loc2_.readUnsignedByte());
         if(_loc3_ == 0)
         {
            this._contents = new ByteArray();
            this._contents.writeBytes(_loc2_,1);
         }
         else
         {
            this._contents = _loc2_.readObject();
         }
         this._loader = null;
         dispatchEvent(new APIEvent(APIEvent.FILE_LOADED,true,{"file":this}));
         API.callListener(APIEvent.FILE_LOADED,true,{"file":this});
      }
      
      public function loadAuthorPage() : *
      {
         API.loadUserPage(this._authorId,this._authorName);
      }
      
      internal function fileSaved(param1:Object) : void
      {
         this._id = param1.save_id;
         this._thumbnailUrl = param1.thumbnail;
         this._fileUrl = param1.file_url;
      }
   }
}
