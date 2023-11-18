package TU_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="TU_fla.flapsOn_42")]
   public dynamic class flapsOn_42 extends MovieClip
   {
       
      
      public function flapsOn_42()
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
