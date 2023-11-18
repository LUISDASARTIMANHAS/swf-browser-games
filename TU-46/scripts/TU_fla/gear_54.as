package TU_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="TU_fla.gear_54")]
   public dynamic class gear_54 extends MovieClip
   {
       
      
      public function gear_54()
      {
         super();
         addFrameScript(0,this.frame1,119,this.frame120,239,this.frame240);
      }
      
      internal function frame240() : *
      {
         gotoAndStop(1);
      }
      
      internal function frame120() : *
      {
         stop();
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}
