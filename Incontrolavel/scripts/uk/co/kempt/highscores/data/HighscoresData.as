package uk.co.kempt.highscores.data
{
   public class HighscoresData
   {
       
      
      public function HighscoresData()
      {
         super();
      }
      
      public function get DEFAULT_REASON() : String
      {
         return "unable to load page";
      }
      
      public function get FAN_OF() : String
      {
         return "fanOf";
      }
      
      public function get BACKEND_URL() : String
      {
         return "http://projects.kempt.co.uk/pepsi2/";
      }
      
      public function get LEVEL_DATA() : Array
      {
         return [null,{"title":"Level 1"},{"title":"Level 2"}];
      }
      
      public function get SEX() : String
      {
         return "sex";
      }
      
      public function get ERR_CODE() : String
      {
         return "errcode";
      }
      
      public function get LOAD_PAGE() : String
      {
         return "comms/getscores.comms.php";
      }
      
      public function get MODE() : String
      {
         return "mode";
      }
      
      public function get P_ID() : String
      {
         return "pId";
      }
      
      public function get NAME() : String
      {
         return "name";
      }
      
      public function get AUTOSAVE() : String
      {
         return "autosave";
      }
      
      public function get SUCCESS() : String
      {
         return "success";
      }
      
      public function get LEAGUE_EXT() : String
      {
         return ".xml";
      }
      
      public function get SCORE() : String
      {
         return "score";
      }
      
      public function get LEVEL() : String
      {
         return "lId";
      }
      
      public function get AGES() : Array
      {
         return ["under 21","21-45","over 45"];
      }
      
      public function get LEAGUE_PATH() : String
      {
         return "cache/leagues/";
      }
      
      public function get SUBMIT_PAGE() : String
      {
         return "comms/submitscore.comms.php";
      }
      
      public function get SEXES() : Array
      {
         return ["man","woman"];
      }
      
      public function get REASON() : String
      {
         return "reason";
      }
      
      public function get RESULT() : String
      {
         return "result";
      }
      
      public function get AGE() : String
      {
         return "age";
      }
   }
}
