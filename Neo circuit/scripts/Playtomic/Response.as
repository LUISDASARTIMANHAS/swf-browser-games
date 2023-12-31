package Playtomic
{
   public class Response
   {
      
      private static const ERRORS:Object = new Object();
      
      {
         ERRORS[0] = "Nothing went wrong!";
         ERRORS[1] = "General error, this typically means the player is unable to connect to the Playtomic servers";
         ERRORS[2] = "Invalid game credentials. Make sure you use your SWFID and GUID from the `API` section in the dashboard.";
         ERRORS[3] = "Request timed out.";
         ERRORS[4] = "Invalid request.";
         ERRORS[100] = "GeoIP API has been disabled. This may occur if your game is faulty or overwhelming the Playtomic servers.";
         ERRORS[200] = "Leaderboard API has been disabled. This may occur if your game is faulty or overwhelming the Playtomic servers.";
         ERRORS[201] = "The source URL or name weren\'t provided when saving a score. Make sure the player specifies a name and the game is initialized before anything else using the code in the `Set your game up` section.";
         ERRORS[202] = "Invalid auth key. You should not see this normally, players might if they tamper with your game.";
         ERRORS[203] = "No Facebook user id on a score specified as a Facebook submission.";
         ERRORS[204] = "Table name wasn\'t specified for creating a private leaderboard.";
         ERRORS[205] = "Permalink structure wasn\'t specified: http://website.com/game/whatever?leaderboard=";
         ERRORS[206] = "Leaderboard id wasn\'t provided loading a private leaderboard.";
         ERRORS[207] = "Invalid leaderboard id was provided for a private leaderboard.";
         ERRORS[208] = "Player is banned from submitting scores in your game.";
         ERRORS[209] = "Score was not the player\'s best score.  You can notify the player, or circumvent this by pecifying \'allowduplicates\' to be true in your save options.";
         ERRORS[300] = "GameVars API has been disabled. This may occur if your game is faulty or overwhelming the Playtomic servers.";
         ERRORS[400] = "Level sharing API has been disabled. This may occur if your game is faulty or overwhelming the Playtomic servers.";
         ERRORS[401] = "Invalid rating value (must be 1 - 10).";
         ERRORS[402] = "Player has already rated that level.";
         ERRORS[403] = "The level name wasn\'t provided when saving a level.";
         ERRORS[404] = "Invalid image auth. You should not see this normally, players might if they tamper with your game.";
         ERRORS[405] = "Invalid image auth (again). You should not see this normally, players might if they tamper with your game.";
         ERRORS[406] = "The level already exists. This is determined via a hash of the game id, level name, player ip address and name, and source url.";
         ERRORS[500] = "Data API has been disabled. This may occur if the Data API is not enabled for your game, or your game is faulty or overwhelming the Playtomic servers.";
         ERRORS[600] = "You have not configured your Parse.com database.  Sign up at Parse and then enter your API credentials in your Playtomic dashboard.";
         ERRORS[601] = "No response was returned from Parse.  If you experience this a lot let us know exactly what you\'re doing so we can sort out a fix for it.";
         ERRORS[6021] = "Parse\'s servers had an error.";
         ERRORS[602101] = "Object not found.  Make sure you include the classname and objectid and that they are correct.";
         ERRORS[602102] = "Invalid query.  If you think you\'re doing it right let us know what you\'re doing and we\'ll look into it.";
         ERRORS[602103] = "Invalid classname.";
         ERRORS[602104] = "Missing objectid.";
         ERRORS[602105] = "Invalid key name.";
         ERRORS[602106] = "Invalid pointer.";
         ERRORS[602107] = "Invalid JSON.";
         ERRORS[602108] = "Command unavailable.";
      }
      
      public var Success:Boolean = false;
      
      public var ErrorCode:int = 0;
      
      public function Response(param1:int, param2:int)
      {
         super();
         this.Success = param1 == 1;
         this.ErrorCode = param2;
      }
      
      public function get ErrorMessage() : String
      {
         return ERRORS[this.ErrorCode];
      }
      
      public function toString() : String
      {
         return "Playtomic.Response:" + "\nSuccess: " + this.Success + "\nErrorCode: " + this.ErrorCode + "\nErrorMessage: " + this.ErrorMessage;
      }
   }
}
