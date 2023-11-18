package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="fx_smoke")]
   public dynamic class fx_smoke extends MovieClip
   {
       
      
      public var worldX:*;
      
      public var worldY:*;
      
      public function fx_smoke()
      {
         super();
         addFrameScript(0,frame1,7,frame8);
      }
      
      internal function frame1() : *
      {
      }
      
      internal function frame8() : *
      {
         stop();
         this.parent.removeChild(this);
      }
   }
}
