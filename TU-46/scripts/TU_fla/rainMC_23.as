package TU_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="TU_fla.rainMC_23")]
   public dynamic class rainMC_23 extends MovieClip
   {
       
      
      public var stars:MovieClip;
      
      public function rainMC_23()
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
