package PlazaMall_fla
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.Game_528")]
   public dynamic class Game_528 extends MovieClip
   {
       
      
      public var btnUpFloor:SimpleButton;
      
      public var btnDownFloor:SimpleButton;
      
      public var floorList:TextField;
      
      public function Game_528()
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
