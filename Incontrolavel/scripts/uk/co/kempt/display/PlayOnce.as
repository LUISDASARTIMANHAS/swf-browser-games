package uk.co.kempt.display
{
   import flash.display.MovieClip;
   import uk.co.kempt.utils.GarbageUtil;
   
   public class PlayOnce extends MovieClip
   {
       
      
      public function PlayOnce()
      {
         super();
         addFrameScript(totalFrames - 1,this.onLastFrame);
      }
      
      protected function onLastFrame() : void
      {
         stop();
         GarbageUtil.kill(this);
      }
   }
}
