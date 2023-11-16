package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="CrashEffect")]
   public dynamic class CrashEffect extends MovieClip
   {
       
      
      public function CrashEffect()
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
