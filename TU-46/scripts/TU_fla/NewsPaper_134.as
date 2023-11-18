package TU_fla
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   
   [Embed(source="/_assets/assets.swf", symbol="TU_fla.NewsPaper_134")]
   public dynamic class NewsPaper_134 extends MovieClip
   {
       
      
      public var okayBtn:SimpleButton;
      
      public function NewsPaper_134()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}
