package TU_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="TU_fla.ag_intro_mc_93")]
   public dynamic class ag_intro_mc_93 extends MovieClip
   {
       
      
      public function ag_intro_mc_93()
      {
         super();
         addFrameScript(0,this.frame1,192,this.frame193,224,this.frame225);
      }
      
      internal function frame225() : *
      {
         stop();
      }
      
      internal function frame1() : *
      {
         gotoAndPlay(2);
      }
      
      internal function frame193() : *
      {
         GameController.transition.playTween(10);
      }
   }
}
