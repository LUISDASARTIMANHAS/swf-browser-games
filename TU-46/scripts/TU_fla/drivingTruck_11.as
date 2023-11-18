package TU_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="TU_fla.drivingTruck_11")]
   public dynamic class drivingTruck_11 extends MovieClip
   {
       
      
      public function drivingTruck_11()
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
