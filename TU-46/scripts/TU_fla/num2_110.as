package TU_fla
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="TU_fla.num2_110")]
   public dynamic class num2_110 extends MovieClip
   {
       
      
      public var welcometo:TextField;
      
      public function num2_110()
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
