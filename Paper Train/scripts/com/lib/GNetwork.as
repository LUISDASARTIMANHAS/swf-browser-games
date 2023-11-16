package com.lib
{
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   
   public class GNetwork
   {
       
      
      private var loadFinishCount:int;
      
      private var loadStartCount:int;
      
      public function GNetwork()
      {
         super();
         this.loadStartCount = 0;
         this.loadFinishCount = 0;
      }
      
      public function loadFile(param1:String, param2:Function = null, param3:Function = null) : *
      {
         var req:URLRequest;
         var loader:* = undefined;
         var url:String = param1;
         var loadCompleteCallback:Function = param2;
         var loadProgressCallback:Function = param3;
         ++this.loadStartCount;
         loader = new URLLoader();
         req = new URLRequest(url);
         loader.addEventListener(Event.COMPLETE,function(param1:*):*
         {
            ++loadFinishCount;
            if(loadCompleteCallback != null)
            {
               loadCompleteCallback(loader.data);
            }
         });
         loader.addEventListener(ProgressEvent.PROGRESS,function(param1:*):*
         {
            if(loadProgressCallback != null)
            {
               loadProgressCallback(param1);
            }
         });
         try
         {
            loader.load(req);
         }
         catch(error:*)
         {
         }
      }
      
      public function loadClip(param1:String, param2:*, param3:Function = null, param4:Function = null) : *
      {
         var loader:* = undefined;
         var url:String = param1;
         var layer:* = param2;
         var loadCompleteCallback:Function = param3;
         var loadProgressCallback:Function = param4;
         loader = new Loader();
         loader.load(new URLRequest(url));
         loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(param1:*):*
         {
            if(loadCompleteCallback != null)
            {
               loadCompleteCallback(loader);
            }
         });
         loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,function(param1:*):*
         {
            if(loadProgressCallback != null)
            {
               loadProgressCallback(loader,param1);
            }
         });
         layer.addChild(loader);
      }
      
      public function gotoURL(param1:String, param2:Object = null, param3:String = "post") : *
      {
         var _loc4_:* = new URLRequest(param1);
         if(param2)
         {
            _loc4_.method = param3 == "post" ? URLRequestMethod.POST : URLRequestMethod.GET;
            _loc4_.data = param2;
         }
         navigateToURL(_loc4_);
      }
      
      public function ajaxRequest(param1:URLRequest, param2:URLVariables = null, param3:Function = null) : *
      {
         var loader:* = undefined;
         var req:URLRequest = param1;
         var vars:URLVariables = param2;
         var responseCallback:Function = param3;
         if(vars)
         {
            req.data = vars;
         }
         req.method = URLRequestMethod.GET;
         loader = new URLLoader();
         try
         {
            loader.load(req);
            if(responseCallback != null)
            {
               loader.addEventListener(Event.COMPLETE,function():*
               {
                  responseCallback(loader.data);
               });
            }
         }
         catch(error:*)
         {
         }
      }
   }
}
