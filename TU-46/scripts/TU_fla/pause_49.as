package TU_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="TU_fla.pause_49")]
   public dynamic class pause_49 extends MovieClip
   {
       
      
      public var pauseMc:MovieClip;
      
      public var pause:MovieClip;
      
      public var titleMc:MovieClip;
      
      public function pause_49()
      {
         super();
         addFrameScript(0,this.frame1,14,this.frame15);
      }
      
      internal function frame15() : *
      {
         stop();
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}
