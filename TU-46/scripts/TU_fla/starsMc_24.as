package TU_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="TU_fla.starsMc_24")]
   public dynamic class starsMc_24 extends MovieClip
   {
       
      
      public function starsMc_24()
      {
         super();
         addFrameScript(0,this.frame1,49,this.frame50);
      }
      
      internal function frame50() : *
      {
         stop();
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}
