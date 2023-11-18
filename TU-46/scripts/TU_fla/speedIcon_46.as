package TU_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="TU_fla.speedIcon_46")]
   public dynamic class speedIcon_46 extends MovieClip
   {
       
      
      public function speedIcon_46()
      {
         super();
         addFrameScript(0,this.frame1,101,this.frame102,210,this.frame211);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame211() : *
      {
         gotoAndStop(1);
      }
      
      internal function frame102() : *
      {
         stop();
      }
   }
}
