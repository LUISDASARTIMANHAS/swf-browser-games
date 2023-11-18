package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="Floor")]
   public dynamic class Floor extends MovieClip
   {
       
      
      public var worldX:Number;
      
      public var worldY:Number;
      
      public var toiletList:*;
      
      public var center:MovieClip;
      
      public var tenantList:*;
      
      public var rightSide:MovieClip;
      
      public function Floor()
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
