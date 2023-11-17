package uk.co.kempt.system
{
   import uk.co.kempt.Engine;
   import uk.co.kempt.data.UnstoppableHighscoresData;
   import uk.co.kempt.display.menu.UnstoppableMenuPages;
   import uk.co.kempt.highscores.Highscores;
   import uk.co.kempt.highscores.LocalObject;
   import uk.co.kempt.highscores.utils.HighscoresParser;
   
   public class HighscoresSystem
   {
       
      
      private var _data:XML;
      
      private var _error:String;
      
      private var _errcode:int;
      
      private var _pageToResume:String;
      
      private var _localObjectReady:Boolean;
      
      public function HighscoresSystem()
      {
         super();
         this.init();
      }
      
      private function showHighScores(param1:String = "level") : void
      {
         Engine.instance.menu.gotoAndStop(UnstoppableMenuPages.WAIT);
         Highscores.instance.getScores(this.onHighScoresReady,param1);
      }
      
      private function storePageToResume() : void
      {
         var _loc1_:String = String(Engine.instance.menu.currentLabel);
         switch(_loc1_)
         {
            case UnstoppableMenuPages.CREATE_USER:
            case UnstoppableMenuPages.HIGHSCORES:
            case UnstoppableMenuPages.WAIT:
               break;
            default:
               this._pageToResume = _loc1_;
         }
      }
      
      public function get error() : String
      {
         return this._error;
      }
      
      private function onScoreSubmitted(param1:Boolean, param2:String = "") : void
      {
         this.debug("onScoreSubmitted " + param1);
         if(!param1)
         {
            this.debug(param2);
         }
         this.showHighScores();
      }
      
      public function get isLoggedIn() : Boolean
      {
         return !!LocalObject.getVar(Highscores.highscoresData.P_ID) ? true : false;
      }
      
      private function init() : void
      {
         Highscores.highscoresData = new UnstoppableHighscoresData();
         LocalObject.init("unstoppable",this.onLocalObjectReady,Highscores.highscoresData.BACKEND_URL);
      }
      
      public function get currentScore() : int
      {
         return Engine.instance.gameStatsCollection.gross;
      }
      
      protected function debug(... rest) : void
      {
         trace("HighscoresSystem: " + rest.join(", "));
      }
      
      public function submit() : void
      {
         this.storePageToResume();
         if(this.isLoggedIn)
         {
            this.submitHighScore();
         }
         else
         {
            Engine.instance.menu.gotoAndStop(UnstoppableMenuPages.CREATE_USER);
         }
      }
      
      private function onHighScoresReady(param1:Boolean, param2:XML = null) : void
      {
         this._data = param2;
         this.debug("onHighScoresReady " + param1);
         Engine.instance.menu.gotoAndStop(UnstoppableMenuPages.HIGHSCORES);
      }
      
      public function createUser(param1:String) : void
      {
         this.storePageToResume();
         this._error = null;
         this._errcode = 0;
         this.debug("create user with score " + this.currentScore);
         Engine.instance.menu.gotoAndStop(UnstoppableMenuPages.WAIT);
         Highscores.instance.createUser(HighscoresParser.filterName(param1),this.currentScore,this.onUserCreated,1,true);
      }
      
      public function get data() : XML
      {
         return this._data;
      }
      
      public function get pId() : int
      {
         return LocalObject.getVar(Highscores.highscoresData.P_ID);
      }
      
      public function resume() : void
      {
         if(this._pageToResume)
         {
            Engine.instance.menu.gotoAndStop(this._pageToResume);
         }
         else
         {
            trace("no page to resume");
         }
      }
      
      public function get errcode() : int
      {
         return this._errcode;
      }
      
      private function onLocalObjectReady() : void
      {
         this._localObjectReady = true;
         this.debug("local object ready");
         this.debug("autosave is " + Highscores.autosave);
         this.debug("user logged in " + this.isLoggedIn);
      }
      
      private function submitHighScore() : void
      {
         Engine.instance.menu.gotoAndStop(UnstoppableMenuPages.WAIT);
         this.debug("submit score " + this.currentScore);
         Highscores.instance.updateScore(1,this.currentScore,this.onScoreSubmitted);
      }
      
      public function show() : void
      {
         this.storePageToResume();
         this.showHighScores();
      }
      
      private function onUserCreated(param1:Boolean, param2:String = "") : void
      {
         this.debug("onUserCreated " + param1);
         this.debug("user logged in " + this.isLoggedIn);
         if(!param1)
         {
            this.debug("error code " + param2);
         }
         if(param1)
         {
            this.showHighScores();
            Engine.trackEvent("user submitted score");
         }
         else
         {
            this._error = param2;
            this._errcode = parseInt(param2);
            if(this._errcode == 3)
            {
               Engine.instance.menu.gotoAndStop(UnstoppableMenuPages.CREATE_USER);
            }
            else
            {
               Engine.instance.menu.gotoAndStop(UnstoppableMenuPages.SERVER_ERROR);
            }
         }
      }
   }
}
