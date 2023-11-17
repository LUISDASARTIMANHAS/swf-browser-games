package unstoppable_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="unstoppable_fla.heliBlades_480")]
   public dynamic class heliBlades_480 extends MovieClip
   {
       
      
      public function heliBlades_480()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         play();
      }
   }
}
