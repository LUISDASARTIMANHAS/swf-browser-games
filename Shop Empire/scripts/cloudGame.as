package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="cloudGame")]
   public dynamic class cloudGame extends MovieClip
   {
       
      
      public var speed:*;
      
      public var sunset:MovieClip;
      
      public var normal:MovieClip;
      
      public function cloudGame()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}
