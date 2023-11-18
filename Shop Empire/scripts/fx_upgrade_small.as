package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="fx_upgrade_small")]
   public dynamic class fx_upgrade_small extends MovieClip
   {
       
      
      public function fx_upgrade_small()
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
