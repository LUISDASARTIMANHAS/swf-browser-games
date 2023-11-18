package TU_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="TU_fla.deadNewsRandom_135")]
   public dynamic class deadNewsRandom_135 extends MovieClip
   {
       
      
      public function deadNewsRandom_135()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         gotoAndStop(Math.round(Math.random() * 5));
      }
   }
}
