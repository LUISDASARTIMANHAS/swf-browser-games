package unstoppable_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="unstoppable_fla.waterAnim_86")]
   public dynamic class waterAnim_86 extends MovieClip
   {
       
      
      public function waterAnim_86()
      {
         super();
         addFrameScript(16,this.frame17);
      }
      
      internal function frame17() : *
      {
         stop();
      }
   }
}
