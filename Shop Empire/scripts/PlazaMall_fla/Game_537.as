package PlazaMall_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.Game_537")]
   public dynamic class Game_537 extends MovieClip
   {
       
      
      public var relation:*;
      
      public var pursue:MovieClip;
      
      public var work:MovieClip;
      
      public var pursueSymbol:legendstolen;
      
      public var stanby:MovieClip;
      
      public var colorMod:*;
      
      public var walk:MovieClip;
      
      public function Game_537()
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
