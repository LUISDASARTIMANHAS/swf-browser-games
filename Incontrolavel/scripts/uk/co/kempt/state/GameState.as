package uk.co.kempt.state
{
   public class GameState
   {
      
      public static const END_OF_LEVEL:String = "endOfLevel";
      
      public static const ABOUT_TO_CRASH:String = "aboutToCrash";
      
      public static const SIMULATION:String = "simulation";
      
      public static const INIT:String = "init";
      
      public static const TRANSITION:String = "transition";
      
      public static const WAIT:String = "wait";
      
      public static const DRAWING:String = "drawing";
       
      
      public function GameState()
      {
         super();
      }
   }
}
