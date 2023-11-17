package uk.co.kempt.display.menu.pages
{
   import flash.display.MovieClip;
   import uk.co.kempt.data.LevelStatistics;
   import uk.co.kempt.display.HUD;
   
   public class AbstractPage extends MovieClip
   {
      
      public static const LABEL_BADGE_GREY:String = "no badge";
      
      public static const LABEL_BADGE_GOLD:String = "gold pres badge";
      
      public static const LABEL_BADGE_RED:String = "grey dest badge";
      
      public static const LABEL_BADGE_GREEN:String = "grey pres badge";
       
      
      public function AbstractPage()
      {
         super();
      }
      
      public static function getBadgeLabel(param1:LevelStatistics) : String
      {
         if(!param1)
         {
            return LABEL_BADGE_GREY;
         }
         if(param1.totalCost <= 0)
         {
            return LABEL_BADGE_GOLD;
         }
         if(param1.gross < 0)
         {
            return LABEL_BADGE_RED;
         }
         return LABEL_BADGE_GREEN;
      }
      
      public static function getMoneyText(param1:LevelStatistics) : String
      {
         if(!param1 || param1.gross < 0)
         {
            return "---";
         }
         return HUD.formatMoney2(param1.gross);
      }
   }
}
