package TU_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="TU_fla.drivingTruckBlue_12")]
   public dynamic class drivingTruckBlue_12 extends MovieClip
   {
       
      
      public function drivingTruckBlue_12()
      {
         super();
         addFrameScript(0,this.frame1,1199,this.frame1200);
      }
      
      internal function frame1() : *
      {
         gotoAndPlay(Math.random() * 1200);
      }
      
      internal function frame1200() : *
      {
         gotoAndPlay(2);
      }
   }
}
