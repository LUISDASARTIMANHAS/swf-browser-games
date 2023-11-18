package TU_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="TU_fla.rainFxmc_58")]
   public dynamic class rainFxmc_58 extends MovieClip
   {
       
      
      public var rainFx:MovieClip;
      
      public function rainFxmc_58()
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
