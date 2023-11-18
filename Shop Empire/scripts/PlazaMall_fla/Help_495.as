package PlazaMall_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.Help_495")]
   public dynamic class Help_495 extends MovieClip
   {
       
      
      public var worldY:Number;
      
      public var toiletList:*;
      
      public var tenantList:*;
      
      public function Help_495()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         tenantList = new Array();
         toiletList = new Array();
      }
   }
}
