package com.newgrounds
{
   import flash.errors.IllegalOperationError;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.Endian;
   
   public class SmartURLLoader extends EventDispatcher
   {
      
      private static var _loaders:Dictionary = new Dictionary();
      
      private static const CRLF:String = "\r\n";
       
      
      private var _variables:Dictionary;
      
      private var _files:Dictionary;
      
      private var _hasVariables:Boolean;
      
      private var _method:String = "GET";
      
      private var _urlRequest:URLRequest;
      
      private var _urlLoader:URLLoader;
      
      private var _dataFormat:String = "text";
      
      private var _openBrowser:Boolean = false;
      
      private var _preventCache:Boolean = false;
      
      internal var _command:String;
      
      public var owner:*;
      
      public function SmartURLLoader()
      {
         super();
         this._urlRequest = new URLRequest();
         this._variables = new Dictionary();
      }
      
      public static function closeAll() : void
      {
         var _loc1_:SmartURLLoader = null;
         for each(_loc1_ in _loaders)
         {
            if(_loc1_)
            {
               _loc1_.dispose();
            }
         }
         _loaders = new Dictionary();
      }
      
      public function get responseFormat() : String
      {
         return this._dataFormat;
      }
      
      public function set responseFormat(param1:String) : void
      {
         this._dataFormat = param1;
      }
      
      public function get response() : *
      {
         return this._urlLoader.data;
      }
      
      public function get hasFiles() : Boolean
      {
         return Boolean(this._files);
      }
      
      public function get method() : String
      {
         return this._method;
      }
      
      public function set method(param1:String) : void
      {
         if(this.hasFiles && param1 == URLRequestMethod.GET)
         {
            throw new IllegalOperationError("GET cannot be used to upload files.");
         }
         this._method = param1;
      }
      
      public function get openBrowser() : Boolean
      {
         return this._openBrowser;
      }
      
      public function set openBrowser(param1:Boolean) : void
      {
         this._openBrowser = param1;
      }
      
      public function get preventCache() : Boolean
      {
         return this._preventCache;
      }
      
      public function set preventCache(param1:Boolean) : void
      {
         this._preventCache = param1;
      }
      
      public function get bytesLoaded() : uint
      {
         return !!this._urlLoader ? uint(this._urlLoader.bytesLoaded) : 0;
      }
      
      public function get bytesTotal() : uint
      {
         return !!this._urlLoader ? uint(this._urlLoader.bytesTotal) : 0;
      }
      
      public function addVariable(param1:String, param2:* = "") : void
      {
         this._variables[param1] = param2;
         if(param2)
         {
            this._hasVariables = true;
         }
      }
      
      public function addFile(param1:String, param2:ByteArray, param3:String, param4:String = "application/octet-stream") : void
      {
         this.method = URLRequestMethod.POST;
         if(!this._files)
         {
            this._files = new Dictionary();
         }
         this._files[param1] = new File(param1,param2,param3,param4);
      }
      
      public function clearVariables() : void
      {
         this._variables = new Dictionary();
      }
      
      public function clearFiles() : void
      {
         this._files = null;
      }
      
      public function load(param1:String) : void
      {
         var urlVariables:URLVariables = null;
         var key:String = null;
         var boundary:String = null;
         var i:uint = 0;
         var event:SecurityErrorEvent = null;
         var url:String = param1;
         this._urlRequest.url = url;
         if(this._preventCache)
         {
            url += "?seed=" + Math.random();
            if(this._hasVariables)
            {
               url += "&";
            }
         }
         this._urlRequest.method = this._method;
         if(this._urlRequest.method == URLRequestMethod.GET || !this.hasFiles)
         {
            this._urlRequest.contentType = "application/x-www-form-urlencoded";
            if(this._hasVariables)
            {
               urlVariables = new URLVariables();
               for(key in this._variables)
               {
                  urlVariables[key] = this._variables[key];
               }
               this._urlRequest.data = urlVariables;
            }
         }
         else
         {
            boundary = "";
            i = 0;
            while(i < 32)
            {
               boundary += String.fromCharCode(uint(97 + Math.random() * 25));
               i++;
            }
            this._urlRequest.contentType = "multipart/form-data; boundary=\"" + boundary + "\"";
            this._urlRequest.data = this.buildMultipartData(boundary);
         }
         if(this.openBrowser)
         {
            navigateToURL(this._urlRequest,"_blank");
         }
         else
         {
            this._urlLoader = new URLLoader();
            this._urlLoader.dataFormat = this._dataFormat;
            this._urlLoader.addEventListener(Event.COMPLETE,this.onComplete);
            this._urlLoader.addEventListener(ProgressEvent.PROGRESS,this.onProgress);
            this._urlLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
            this._urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS,this.onHTTPStatus);
            this._urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
            _loaders[this._urlLoader] = this;
            try
            {
               this._urlLoader.load(this._urlRequest);
            }
            catch(error:Error)
            {
               event = new SecurityErrorEvent(SecurityErrorEvent.SECURITY_ERROR,false,false,error.message);
               onSecurityError(event);
            }
         }
      }
      
      public function close() : void
      {
         try
         {
            this._urlLoader.close();
         }
         catch(e:Error)
         {
         }
      }
      
      public function dispose() : void
      {
         this.close();
         this._files = null;
         this._variables = null;
         if(this._urlLoader)
         {
            this._urlLoader.removeEventListener(Event.COMPLETE,this.onComplete);
            this._urlLoader.removeEventListener(ProgressEvent.PROGRESS,this.onProgress);
            this._urlLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
            this._urlLoader.removeEventListener(HTTPStatusEvent.HTTP_STATUS,this.onHTTPStatus);
            this._urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
            this._urlLoader = null;
         }
         this._urlRequest = null;
         delete _loaders[this];
      }
      
      private function buildMultipartData(param1:String) : ByteArray
      {
         var _loc3_:String = null;
         var _loc4_:File = null;
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.endian = Endian.BIG_ENDIAN;
         param1 = "--" + param1;
         for(_loc3_ in this._variables)
         {
            _loc2_.writeUTFBytes(param1 + CRLF);
            _loc2_.writeUTFBytes("Content-Disposition: form-data; name=\"" + _loc3_ + "\"" + CRLF);
            _loc2_.writeUTFBytes(CRLF);
            _loc2_.writeUTFBytes(this._variables[_loc3_] + CRLF);
         }
         if(this.hasFiles)
         {
            for each(_loc4_ in this._files)
            {
               _loc2_.writeUTFBytes(param1 + CRLF);
               _loc2_.writeUTFBytes("Content-Disposition: form-data; name=\"Filename\"" + CRLF);
               _loc2_.writeUTFBytes(CRLF);
               _loc2_.writeUTFBytes(_loc4_.fileName + CRLF);
               _loc2_.writeUTFBytes(param1 + CRLF);
               _loc2_.writeUTFBytes("Content-Disposition: form-data; name=\"" + _loc4_.dataField + "\"; filename=\"" + _loc4_.fileName + "\"" + CRLF);
               _loc2_.writeUTFBytes("Content-Type: " + _loc4_.contentType + CRLF);
               _loc2_.writeUTFBytes(CRLF);
               _loc2_.writeBytes(_loc4_.data);
               _loc2_.writeUTFBytes(CRLF);
            }
            _loc2_.writeUTFBytes(param1 + CRLF);
            _loc2_.writeUTFBytes("Content-Disposition: form-data; name=\"Upload\"" + CRLF);
            _loc2_.writeUTFBytes(CRLF);
            _loc2_.writeUTFBytes("Submit Query" + CRLF);
         }
         _loc2_.writeUTFBytes(param1 + "--");
         _loc2_.position = 0;
         _loc2_.position = 0;
         return _loc2_;
      }
      
      private function onComplete(param1:Event) : void
      {
         dispatchEvent(param1);
         this.dispose();
      }
      
      private function onProgress(param1:ProgressEvent) : void
      {
         dispatchEvent(param1);
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
         dispatchEvent(param1);
         this.dispose();
      }
      
      private function onSecurityError(param1:SecurityErrorEvent) : void
      {
         dispatchEvent(param1);
         this.dispose();
      }
      
      private function onHTTPStatus(param1:HTTPStatusEvent) : void
      {
         dispatchEvent(param1);
      }
   }
}

import flash.utils.ByteArray;

class File
{
    
   
   internal var fileName:String;
   
   internal var data:ByteArray;
   
   internal var dataField:String;
   
   internal var contentType:String;
   
   public function File(param1:String, param2:ByteArray, param3:String = "Filedata", param4:String = "application/octet-stream")
   {
      super();
      this.fileName = param1;
      this.data = param2;
      this.dataField = param3;
      this.contentType = param4;
   }
}
