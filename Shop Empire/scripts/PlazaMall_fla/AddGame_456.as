package PlazaMall_fla
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.AddGame_456")]
   public dynamic class AddGame_456 extends MovieClip
   {
       
      
      public function AddGame_456()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function link(param1:MouseEvent) : void
      {
         var _loc2_:URLRequest = null;
         _loc2_ = new URLRequest("http://www.gamesfree.com/games/exclusive.html");
         navigateToURL(_loc2_,"_blank");
      }
      
      internal function frame1() : *
      {
         buttonMode = true;
         addEventListener(MouseEvent.CLICK,link);
      }
   }
}
