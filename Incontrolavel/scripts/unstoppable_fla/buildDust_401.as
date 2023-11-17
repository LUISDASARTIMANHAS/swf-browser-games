package unstoppable_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="unstoppable_fla.buildDust_401")]
   public dynamic class buildDust_401 extends MovieClip
   {
       
      
      public function buildDust_401()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}
