package com.newgrounds
{
   import flash.events.Event;
   import flash.events.StatusEvent;
   import flash.net.LocalConnection;
   
   public class Bridge
   {
       
      
      private var _inConnection:LocalConnection;
      
      private var _outConnection:LocalConnection;
      
      private var _widgetId:String;
      
      public function Bridge(param1:String)
      {
         super();
         this._widgetId = param1;
         this._inConnection = new LocalConnection();
         this._outConnection = new LocalConnection();
         this._inConnection.client = this;
         this._inConnection.connect("rec_" + this._widgetId);
         this._outConnection.addEventListener(StatusEvent.STATUS,this.onStatus);
      }
      
      public function sendCommand(param1:String, param2:Object) : void
      {
         if(this._outConnection)
         {
            this._outConnection.send(this._widgetId,"sendCommand",param1,this.scrubParameters(param2));
         }
      }
      
      public function sendEvent(param1:String, param2:Object) : void
      {
         if(this._outConnection)
         {
            this._outConnection.send(this._widgetId,"sendEvent",param1,this.scrubParameters(param2));
         }
      }
      
      public function receiveEvent(param1:String, param2:Object) : void
      {
         API.callListener(param1,param2.success,param2.data);
      }
      
      public function scrubParameters(param1:Object) : Object
      {
         var _loc3_:String = null;
         var _loc2_:Object = new Object();
         for(_loc3_ in param1)
         {
            if(param1[_loc3_] is String || param1[_loc3_] is Number || param1[_loc3_] is uint || param1[_loc3_] is int || param1[_loc3_] is Boolean)
            {
               _loc2_[_loc3_] = param1[_loc3_];
            }
         }
         return _loc2_;
      }
      
      private function onStatus(param1:Event) : void
      {
      }
   }
}
