package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="Video1")]
   public dynamic class Video1 extends MovieClip
   {
       
      
      public function Video1()
      {
         super();
         addFrameScript(165,this.frame166);
      }
      
      internal function frame166() : *
      {
         stop();
      }
   }
}
