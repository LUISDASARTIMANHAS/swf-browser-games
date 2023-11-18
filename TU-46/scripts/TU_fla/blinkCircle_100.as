package TU_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="TU_fla.blinkCircle_100")]
   public dynamic class blinkCircle_100 extends MovieClip
   {
       
      
      public function blinkCircle_100()
      {
         super();
         addFrameScript(8,this.frame9);
      }
      
      internal function frame9() : *
      {
         stop();
      }
   }
}
