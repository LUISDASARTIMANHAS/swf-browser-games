package uk.co.kempt.highscores
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import uk.co.kempt.highscores.data.HighscoresData;
   import uk.co.kempt.highscores.data.HighscoresMode;
   
   public class Highscores
   {
      
      protected static var _instance:Highscores = new Highscores();
      
      protected static var _autosave:Boolean = false;
      
      protected static var _highscoresData:HighscoresData = new HighscoresData();
       
      
      protected var _createUserCallback:Function;
      
      protected var _getScoresCallback:Function;
      
      public function Highscores()
      {
         super();
      }
      
      public static function get autosave() : Boolean
      {
         return Boolean(LocalObject.getVar(highscoresData.AUTOSAVE));
      }
      
      public static function get instance() : Highscores
      {
         return _instance;
      }
      
      public static function set highscoresData(param1:HighscoresData) : void
      {
         _highscoresData = param1 || _highscoresData;
      }
      
      public static function get highscoresData() : HighscoresData
      {
         return _highscoresData;
      }
      
      protected function debug(... rest) : void
      {
         trace("Highscores: " + rest.join(", "));
      }
      
      protected function scoresLoaded(param1:Event) : void
      {
         var tCallback:Function;
         var xml:XML = null;
         var e:Event = param1;
         var loader:URLLoader = URLLoader(e.target);
         loader.removeEventListener(Event.COMPLETE,this.scoreSubmitted);
         loader.removeEventListener(IOErrorEvent.IO_ERROR,this.scoreSubmitted);
         tCallback = this._getScoresCallback;
         this._getScoresCallback = null;
         if(!(e is IOErrorEvent))
         {
            try
            {
               xml = XML(loader.data);
               tCallback(true,xml);
            }
            catch(e:Error)
            {
               tCallback(false);
            }
         }
         else
         {
            tCallback(false);
         }
         tCallback = null;
      }
      
      public function createUser(param1:String, param2:Number, param3:Function, param4:int = 1, param5:Boolean = false, param6:int = 0, param7:int = 0, param8:int = 0) : void
      {
         this._createUserCallback = param3;
         this.debug("createUser callback is " + this._createUserCallback);
         var _loc9_:URLRequest;
         (_loc9_ = new URLRequest(highscoresData.BACKEND_URL + highscoresData.SUBMIT_PAGE)).data = new URLVariables();
         _loc9_.data[highscoresData.LEVEL] = param4;
         _loc9_.data[highscoresData.NAME] = param1;
         _loc9_.data[highscoresData.AGE] = param6;
         _loc9_.data[highscoresData.SEX] = param7;
         _loc9_.data[highscoresData.FAN_OF] = param8;
         _loc9_.data[highscoresData.SCORE] = param2;
         _loc9_.data.r = this.getRandomValue();
         LocalObject.setVar(highscoresData.AGE,param6);
         LocalObject.setVar(highscoresData.SEX,param7);
         LocalObject.setVar(highscoresData.FAN_OF,param8);
         LocalObject.setVar(highscoresData.AUTOSAVE,param5);
         this.submitAndShowThrobber(_loc9_);
      }
      
      protected function scoreSubmitted(param1:Event) : void
      {
         var tCallback:Function;
         var tLoader:URLLoader = null;
         var results:Object = null;
         var e:Event = param1;
         tLoader = URLLoader(e.target);
         var tURLVariables:URLVariables = new URLVariables();
         tLoader.removeEventListener(Event.COMPLETE,this.scoreSubmitted);
         tLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.scoreSubmitted);
         tCallback = this._createUserCallback;
         this._createUserCallback = null;
         if(!(e is IOErrorEvent))
         {
            try
            {
               tURLVariables.decode(tLoader.data);
            }
            catch(e:Error)
            {
               debug("error while decoding data");
               debug(tLoader.data);
               debug("---");
            }
            results = tURLVariables;
            if(results[highscoresData.RESULT] == highscoresData.SUCCESS)
            {
               if(!LocalObject.getVar(highscoresData.P_ID))
               {
                  LocalObject.setVar(highscoresData.P_ID,Number(results[highscoresData.P_ID]));
               }
               tCallback(true);
            }
            else
            {
               this.debug("failed to submit score " + results[highscoresData.RESULT]);
               tCallback(false,results[highscoresData.ERR_CODE]);
            }
         }
         else
         {
            tCallback(false,highscoresData.DEFAULT_REASON);
         }
         tCallback = null;
      }
      
      public function updateScore(param1:int, param2:int, param3:Function) : void
      {
         var _loc5_:URLRequest = null;
         var _loc4_:*;
         if(_loc4_ = LocalObject.getVar(highscoresData.P_ID))
         {
            this._createUserCallback = param3;
            (_loc5_ = new URLRequest(highscoresData.BACKEND_URL + highscoresData.SUBMIT_PAGE)).data = new URLVariables();
            _loc5_.data[highscoresData.P_ID] = _loc4_;
            _loc5_.data[highscoresData.LEVEL] = param1;
            _loc5_.data[highscoresData.SCORE] = param2;
            _loc5_.data.r = this.getRandomValue();
            this.submitAndShowThrobber(_loc5_);
            return;
         }
         throw new Error("unable to update score, pId not known");
      }
      
      public function getScores(param1:Function, param2:String = "level", param3:int = 0) : void
      {
         var _loc4_:URLRequest = null;
         this._getScoresCallback = param1;
         switch(param2)
         {
            case HighscoresMode.LEVEL:
            case HighscoresMode.CHEATS:
               (_loc4_ = new URLRequest(highscoresData.BACKEND_URL + highscoresData.LOAD_PAGE)).data = new URLVariables();
               _loc4_.data[highscoresData.LEVEL] = param3;
               _loc4_.data[highscoresData.MODE] = param2;
               _loc4_.method = URLRequestMethod.GET;
               break;
            case "sex":
            case "age":
            case "fanOf":
            case "country":
               (_loc4_ = new URLRequest(highscoresData.BACKEND_URL + highscoresData.LEAGUE_PATH + param2.toLowerCase() + highscoresData.LEAGUE_EXT)).data = new URLVariables();
         }
         if(LocalObject.getVar(highscoresData.P_ID))
         {
            _loc4_.data[highscoresData.P_ID] = LocalObject.getVar(highscoresData.P_ID);
         }
         _loc4_.data.r = Math.random();
         var _loc5_:URLLoader;
         (_loc5_ = new URLLoader()).dataFormat = URLLoaderDataFormat.TEXT;
         _loc5_.addEventListener(Event.COMPLETE,this.scoresLoaded);
         _loc5_.addEventListener(IOErrorEvent.IO_ERROR,this.scoresLoaded);
         _loc5_.load(_loc4_);
      }
      
      protected function getRandomValue() : Number
      {
         return Math.random();
      }
      
      protected function submitAndShowThrobber(param1:URLRequest) : void
      {
         var _loc2_:URLLoader = new URLLoader();
         _loc2_.dataFormat = URLLoaderDataFormat.TEXT;
         param1.method = URLRequestMethod.GET;
         _loc2_.addEventListener(Event.COMPLETE,this.scoreSubmitted);
         _loc2_.addEventListener(IOErrorEvent.IO_ERROR,this.scoreSubmitted);
         _loc2_.load(param1);
      }
   }
}
