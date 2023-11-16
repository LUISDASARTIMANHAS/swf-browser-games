package com.lib
{
   import com.adobe.crypto.MD5;
   import com.adobe.serialization.json.JSON;
   import flash.events.*;
   import flash.net.*;
   
   public class GameStat
   {
       
      
      private var hiScores:Array;
      
      private var level:int = 0;
      
      private var finalized:Boolean;
      
      private var hiScoresCallBack:Function;
      
      private var checkHostAjax:URLLoader;
      
      private var score:int = 0;
      
      private var minimumLevel:int = -1;
      
      private var mode:String;
      
      private var minimumScore:int = -1;
      
      private var checkHostCallBackCalled:Boolean;
      
      private var checkPremiumCallBack:Function;
      
      private var ownhost:Boolean;
      
      private var factor:int = 17;
      
      private var hiScoreAjax:URLLoader;
      
      private var checkHostCallBack:Function;
      
      private var hostChecked:Boolean;
      
      private var player:String;
      
      private var nohost:Boolean;
      
      private var game:String;
      
      private var statValue:int = 0;
      
      public function GameStat(param1:String, param2:Boolean = false)
      {
         this.hiScores = new Array();
         super();
         this.game = param1;
         this.mode = "";
         this.finalized = param2;
         this.nohost = false;
         this.ownhost = false;
         this.checkHostCallBackCalled = false;
         this.hostChecked = false;
         var _loc3_:* = int(Math.random() * 65536);
         this.statValue = _loc3_ % this.factor;
      }
      
      private function jsRequest(param1:String) : *
      {
         var _loc2_:URLRequest = new URLRequest("javascript: " + param1 + "; void(0);");
         navigateToURL(_loc2_,"_self");
      }
      
      private function updateHighScores() : *
      {
         var md5:*;
         var loader:*;
         var vars:URLVariables;
         var req:URLRequest;
         if(this.nohost)
         {
            return;
         }
         this.player = GString.trim(this.player);
         if(!this.player.length)
         {
            return;
         }
         md5 = MD5.hash("causal " + this.game + this.mode + this.player + this.level + this.score);
         req = new URLRequest("http://www.mylostgames.com/ajax/update_highscores");
         vars = new URLVariables();
         vars.game = this.game;
         vars.mode = this.mode;
         vars.name = this.player;
         vars.level = this.level;
         vars.score = this.score;
         vars.ownhost = this.ownhost ? 1 : 0;
         vars.md5 = md5;
         req.data = vars;
         req.method = URLRequestMethod.GET;
         loader = new URLLoader();
         try
         {
            loader.load(req);
         }
         catch(error:*)
         {
         }
         if(this.ownhost)
         {
            this.jsRequest("highscores.refresh(\'" + this.game + "\');");
         }
      }
      
      public function setPlayerName(param1:String) : *
      {
         this.player = param1;
      }
      
      private function _checkPremium(param1:String) : *
      {
         var vars:URLVariables;
         var req:URLRequest;
         var loader:* = undefined;
         var auth:String = param1;
         if(!auth || !auth.length)
         {
            this.checkPremiumCallBack(false);
            return;
         }
         req = new URLRequest("http://www.mylostgames.com/ajax/check_premium");
         vars = new URLVariables();
         vars.auth = auth;
         req.data = vars;
         req.method = URLRequestMethod.GET;
         loader = new URLLoader();
         loader.addEventListener(Event.COMPLETE,function():*
         {
            var _loc1_:* = com.adobe.serialization.json.JSON.decode(loader.data);
            if(_loc1_)
            {
               checkPremiumCallBack(_loc1_);
            }
            else
            {
               checkPremiumCallBack(null);
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
      
      private function errorHandler(param1:*) : *
      {
         if(this.checkHostCallBackCalled)
         {
            return;
         }
         this.checkHostCallBackCalled = true;
         this.ownhost = false;
         this.nohost = false;
         this.updateStat();
         this.checkHostCallBack(this.ownhost);
      }
      
      public function goToMyLostGames(param1:String = "", param2:Object = null, param3:String = "") : *
      {
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         if(!this.finalized)
         {
            return;
         }
         var _loc4_:String = "http://www.mylostgames.com/" + param1;
         var _loc5_:URLRequest = new URLRequest(_loc4_);
         if(Boolean(param2) || Boolean(param3))
         {
            _loc6_ = new URLVariables();
            if(param2)
            {
               for(_loc7_ in param2)
               {
                  _loc6_[_loc7_] = param2[_loc7_];
               }
            }
            if(param3)
            {
               _loc6_.referer = param3;
            }
            _loc5_.data = _loc6_;
            _loc5_.method = URLRequestMethod.POST;
         }
         navigateToURL(_loc5_);
      }
      
      public function checkPremium(param1:String, param2:Function) : *
      {
         this.checkPremiumCallBack = param2;
         this._checkPremium(param1);
      }
      
      private function hostReceived(param1:Event) : *
      {
         if(this.checkHostCallBackCalled)
         {
            return;
         }
         this.checkHostCallBackCalled = true;
         this.ownhost = this.checkHostAjax.data == "mylostgames.com";
         this.nohost = this.checkHostAjax.data == "none";
         this.updateStat();
         this.checkHostCallBack(this.ownhost);
      }
      
      public function setMinimumLevelForHiScores(param1:int) : *
      {
         this.minimumLevel = param1;
      }
      
      public function setGameMode(param1:String) : *
      {
         this.mode = param1;
      }
      
      private function errorHandler_sec(param1:*) : *
      {
         if(this.checkHostCallBackCalled)
         {
            return;
         }
         this.checkHostCallBackCalled = true;
         this.ownhost = false;
         this.nohost = false;
         this.updateStat();
         this.checkHostCallBack(this.ownhost);
      }
      
      private function updateStat() : *
      {
         var loader:*;
         var date:*;
         var vars:URLVariables;
         var time:*;
         var req:URLRequest;
         if(this.nohost)
         {
            return;
         }
         date = new Date();
         time = int(date.time / 1000);
         if(this.finalized && time % this.factor != this.statValue)
         {
            return;
         }
         req = new URLRequest("http://www.mylostgames.com/ajax/update_stat");
         vars = new URLVariables();
         vars.game = this.game;
         vars.mode = this.mode;
         vars.duration = 0;
         vars.level = 0;
         vars.score = 0;
         vars.ownhost = this.ownhost ? 1 : 0;
         vars.factor = this.finalized ? this.factor : 1;
         req.data = vars;
         req.method = URLRequestMethod.GET;
         loader = new URLLoader();
         try
         {
            loader.load(req);
         }
         catch(error:*)
         {
         }
      }
      
      public function setHighScore(param1:int = 0, param2:int = 0, param3:* = "") : *
      {
         this.score = param1;
         this.level = param2;
         if(!this.IsHiscoresReached())
         {
            return;
         }
         if(param3)
         {
            this.player = param3;
         }
         this.updateHighScores();
      }
      
      public function checkHost(param1:Function) : *
      {
         if(this.hostChecked)
         {
            return;
         }
         this.hostChecked = true;
         this.checkHostCallBack = param1;
         this._checkHost();
      }
      
      private function _checkHost() : *
      {
         var req:URLRequest = new URLRequest("/ajax/checkhost");
         this.checkHostAjax = new URLLoader();
         this.checkHostAjax.addEventListener(Event.COMPLETE,this.hostReceived);
         this.checkHostAjax.addEventListener(IOErrorEvent.IO_ERROR,this.errorHandler);
         this.checkHostAjax.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.errorHandler_sec);
         try
         {
            this.checkHostAjax.load(req);
         }
         catch(error:*)
         {
            if(!checkHostCallBackCalled)
            {
               checkHostCallBackCalled = true;
               ownhost = false;
               nohost = false;
               checkHostCallBack(ownhost);
            }
         }
      }
      
      public function getHighScores(param1:Function) : *
      {
         this.hiScoresCallBack = param1;
         this._getHighScores();
      }
      
      private function _getHighScores() : *
      {
         var req:URLRequest = new URLRequest("http://www.mylostgames.com/ajax/get_highscores");
         var vars:URLVariables = new URLVariables();
         vars.game = this.game;
         req.data = vars;
         req.method = URLRequestMethod.GET;
         this.hiScoreAjax = new URLLoader();
         this.hiScoreAjax.addEventListener(Event.COMPLETE,this.highScoresReceived);
         try
         {
            this.hiScoreAjax.load(req);
         }
         catch(error:*)
         {
         }
      }
      
      public function saveGameVars(param1:Object) : *
      {
         var _loc2_:* = this.game + "_params";
         GCookie.set(_loc2_,com.adobe.serialization.json.JSON.encode(param1),365);
      }
      
      public function setMinimumScoreForHiScores(param1:int) : *
      {
         this.minimumScore = param1;
      }
      
      private function IsHiscoresReached() : *
      {
         var _loc2_:* = undefined;
         if(this.hiScores.length < 10)
         {
            return true;
         }
         if(this.score > this.minimumScore && this.level > this.minimumLevel)
         {
            return true;
         }
         var _loc1_:int = 65536 * 32767;
         for each(_loc2_ in this.hiScores)
         {
            if(_loc2_.score < _loc1_)
            {
               _loc1_ = int(_loc2_.score);
            }
         }
         return this.score > _loc1_;
      }
      
      public function restoreGameVars() : Object
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc1_:* = this.game + "_params";
         var _loc2_:* = GCookie.get(_loc1_);
         if(_loc2_)
         {
            _loc3_ = _loc2_.toString();
            if(_loc3_)
            {
               if(_loc4_ = com.adobe.serialization.json.JSON.decode(_loc3_))
               {
                  return _loc4_;
               }
            }
         }
         return new Object();
      }
      
      private function highScoresReceived(param1:Event) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc2_:* = new Object();
         if(this.hiScoreAjax.data)
         {
            if(_loc4_ = com.adobe.serialization.json.JSON.decode(this.hiScoreAjax.data))
            {
               _loc2_ = _loc4_;
            }
         }
         this.hiScoresCallBack(_loc2_);
         this.hiScores = new Array();
         for each(_loc3_ in _loc2_.scores)
         {
            this.hiScores.push(_loc3_);
         }
      }
   }
}
