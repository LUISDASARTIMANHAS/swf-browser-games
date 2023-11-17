package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="Video3")]
   public dynamic class Video3 extends MovieClip
   {
       
      
      public function Video3()
      {
         super();
         addFrameScript(127,this.frame128);
      }
      
      internal function frame128() : *
      {
         stop();
      }
   }
}
