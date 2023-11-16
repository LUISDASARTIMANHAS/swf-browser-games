package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="CrashSignal")]
   public dynamic class CrashSignal extends MovieClip
   {
       
      
      public function CrashSignal()
      {
         super();
         addFrameScript(17,this.frame18);
      }
      
      internal function frame18() : *
      {
         stop();
      }
   }
}
