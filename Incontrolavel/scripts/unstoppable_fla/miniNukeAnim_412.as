package unstoppable_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="unstoppable_fla.miniNukeAnim_412")]
   public dynamic class miniNukeAnim_412 extends MovieClip
   {
       
      
      public function miniNukeAnim_412()
      {
         super();
         addFrameScript(24,this.frame25);
      }
      
      internal function frame25() : *
      {
         stop();
      }
   }
}
