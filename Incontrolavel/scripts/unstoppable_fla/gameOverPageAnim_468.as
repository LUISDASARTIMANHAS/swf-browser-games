package unstoppable_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="unstoppable_fla.gameOverPageAnim_468")]
   public dynamic class gameOverPageAnim_468 extends MovieClip
   {
       
      
      public function gameOverPageAnim_468()
      {
         super();
         addFrameScript(10,this.frame11);
      }
      
      internal function frame11() : *
      {
         stop();
      }
   }
}
