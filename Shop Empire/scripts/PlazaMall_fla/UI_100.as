package PlazaMall_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.UI_100")]
   public dynamic class UI_100 extends MovieClip
   {
       
      
      public function UI_100()
      {
         super();
         addFrameScript(0,frame1,1,frame2);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame2() : *
      {
         stop();
      }
   }
}
