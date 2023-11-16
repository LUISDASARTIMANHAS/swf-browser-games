package
{
   public class cStoryData
   {
      
      public static const MAX_STORY_DATA:int = 1;
       
      
      public var init:Array;
      
      public var storyTexts:Array;
      
      public var tutorialTexts:Array;
      
      public function cStoryData()
      {
         this.storyTexts = [];
         this.tutorialTexts = [];
         super();
         this.init = [this.STORY0];
      }
      
      private function STORY0() : void
      {
         this.storyTexts = ["You have been looking forward to this day...","after a long time your are finally back!","Back to the NEO CIRCUIT tournament!","","Once you have been very good at this game, maybe the best...","but there was this one game. It nearly killed your brain!","","","They changed the rules after this tournament!","No direct connection to the brain and only AI enemies","","","Anyway, the only thing that really counts is, you are back...","and you are going to win it!","",""];
      }
      
      private function STORY1() : void
      {
      }
   }
}
