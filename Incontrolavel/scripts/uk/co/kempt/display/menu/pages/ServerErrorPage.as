package uk.co.kempt.display.menu.pages
{
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import uk.co.kempt.Engine;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.display.menu.pages.ServerErrorPage")]
   public class ServerErrorPage extends AbstractPage
   {
       
      
      public var playAgain_btn:SimpleButton;
      
      public function ServerErrorPage()
      {
         super();
         this.playAgain_btn.addEventListener(MouseEvent.CLICK,this.onPlayAgainClicked,false,0,true);
      }
      
      private function onPlayAgainClicked(param1:MouseEvent) : void
      {
         Engine.instance.highscoresSystem.resume();
      }
   }
}
