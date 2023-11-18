package PlazaMall_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.Game_525")]
   public dynamic class Game_525 extends MovieClip
   {
       
      
      public var workSymbol:legendunderconstruction;
      
      public var relation:*;
      
      public var stanby:MovieClip;
      
      public var work:MovieClip;
      
      public var colorMod:*;
      
      public var walk:MovieClip;
      
      public function Game_525()
      {
         super();
         addFrameScript(0,frame1,1,frame2,2,frame3);
      }
      
      internal function frame3() : *
      {
         work.visible = false;
         stanby.visible = false;
         walk.visible = false;
         stop();
      }
      
      internal function frame1() : *
      {
         work.visible = false;
         stanby.visible = false;
         walk.visible = false;
         stop();
      }
      
      internal function frame2() : *
      {
         work.visible = false;
         stanby.visible = false;
         walk.visible = false;
         stop();
      }
   }
}
