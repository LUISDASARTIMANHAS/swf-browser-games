package TU_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="TU_fla.smokesomeBlack_67")]
   public dynamic class smokesomeBlack_67 extends MovieClip
   {
       
      
      public function smokesomeBlack_67()
      {
         super();
         addFrameScript(0,this.frame1,60,this.frame61);
      }
      
      internal function frame61() : *
      {
         gotoAndPlay(2);
      }
      
      internal function frame1() : *
      {
         gotoAndPlay(Math.round(Math.random() * 50));
      }
   }
}
