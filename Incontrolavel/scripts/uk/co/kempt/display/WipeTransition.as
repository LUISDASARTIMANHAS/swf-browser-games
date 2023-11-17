package uk.co.kempt.display
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.display.WipeTransition")]
   public class WipeTransition extends MovieClip
   {
       
      
      public function WipeTransition()
      {
         super();
         addFrameScript(14,this.frame15,40,this.frame41);
         stop();
      }
      
      internal function frame15() : *
      {
         this.onHidden();
      }
      
      public function hide() : void
      {
         gotoAndStop(totalFrames);
      }
      
      private function onWipeEnd() : void
      {
         stop();
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private function onHidden() : void
      {
         dispatchEvent(new Event("hidden"));
      }
      
      internal function frame41() : *
      {
         this.onWipeEnd();
      }
      
      private function onWipeStart() : void
      {
      }
      
      public function show() : void
      {
         gotoAndPlay(1);
         this.onWipeStart();
      }
   }
}
