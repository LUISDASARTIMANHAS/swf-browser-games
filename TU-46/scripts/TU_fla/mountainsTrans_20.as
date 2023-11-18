package TU_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="TU_fla.mountainsTrans_20")]
   public dynamic class mountainsTrans_20 extends MovieClip
   {
       
      
      public function mountainsTrans_20()
      {
         super();
         addFrameScript(0,this.frame1,99,this.frame100);
      }
      
      internal function frame100() : *
      {
         stop();
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}
