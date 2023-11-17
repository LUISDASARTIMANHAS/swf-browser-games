package uk.co.kempt.data
{
   import uk.co.kempt.highscores.data.HighscoresData;
   
   public class UnstoppableHighscoresData extends HighscoresData
   {
       
      
      public function UnstoppableHighscoresData()
      {
         super();
      }
      
      override public function get BACKEND_URL() : String
      {
         return "http://projects.kempt.co.uk/unstoppable/";
      }
   }
}
