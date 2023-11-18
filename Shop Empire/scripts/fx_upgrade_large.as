package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="fx_upgrade_large")]
   public dynamic class fx_upgrade_large extends MovieClip
   {
       
      
      public function fx_upgrade_large()
      {
         super();
         addFrameScript(14,frame15);
      }
      
      internal function frame15() : *
      {
         stop();
         this.parent.removeChild(this);
      }
   }
}
