package TU_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="TU_fla.randomStuff_137")]
   public dynamic class randomStuff_137 extends MovieClip
   {
       
      
      public function randomStuff_137()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         gotoAndStop(Math.round(Math.random() * 7));
      }
   }
}
