package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   
   [Embed(source="/_assets/assets.swf", symbol="HighScoresScreen")]
   public dynamic class HighScoresScreen extends MovieClip
   {
       
      
      public var postit:MovieClip;
      
      public var buttonMyLostGames:SimpleButton;
      
      public function HighScoresScreen()
      {
         super();
      }
   }
}
