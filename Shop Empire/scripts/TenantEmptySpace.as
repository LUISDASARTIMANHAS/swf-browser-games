package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="TenantEmptySpace")]
   public dynamic class TenantEmptySpace extends MovieClip
   {
       
      
      public var worldX:Number;
      
      public var worldY:Number;
      
      public function TenantEmptySpace()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
      }
   }
}
