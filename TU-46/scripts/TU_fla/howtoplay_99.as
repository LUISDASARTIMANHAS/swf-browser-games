package TU_fla
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   
   [Embed(source="/_assets/assets.swf", symbol="TU_fla.howtoplay_99")]
   public dynamic class howtoplay_99 extends MovieClip
   {
       
      
      public var backBtn:SimpleButton;
      
      public var continueBtn:SimpleButton;
      
      public function howtoplay_99()
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
