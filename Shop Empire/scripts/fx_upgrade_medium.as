package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="fx_upgrade_medium")]
   public dynamic class fx_upgrade_medium extends MovieClip
   {
       
      
      public function fx_upgrade_medium()
      {
         super();
         addFrameScript(14,frame15);
      }
      
      internal function frame15() : *
      {
         stop();
         parent.removeChild(this);
      }
   }
}
