package unstoppable_fla
{
   import flash.display.MovieClip;
   import uk.co.kempt.Engine;
   import uk.co.kempt.IDESounds;
   
   [Embed(source="/_assets/assets.swf", symbol="unstoppable_fla.bars_419")]
   public dynamic class bars_419 extends MovieClip
   {
       
      
      public function bars_419()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,20,this.frame21,23,this.frame24,42,this.frame43);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame2() : *
      {
         IDESounds.onBarsAnimateOut();
      }
      
      internal function frame43() : *
      {
         stop();
      }
      
      internal function frame21() : *
      {
         stop();
         Engine.instance.onTransitionInAlmostFinished();
      }
      
      internal function frame24() : *
      {
         IDESounds.onBarsAnimateIn();
      }
   }
}
