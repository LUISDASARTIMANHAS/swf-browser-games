package uk.co.kempt.display.menu.pages
{
   import com.memecounter.Tracker;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import uk.co.kempt.Engine;
   import uk.co.kempt.UnstoppableDocument;
   import uk.co.kempt.display.menu.UnstoppableMenuPages;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.display.menu.pages.StartPage")]
   public class StartPage extends AbstractPage
   {
       
      
      public var play_btn:SimpleButton;
      
      public var kempt_btn:SimpleButton;
      
      public var howToPlay_btn:SimpleButton;
      
      public function StartPage()
      {
         super();
         addFrameScript(68,this.frame69,69,this.frame70);
         this.kempt_btn.addEventListener(MouseEvent.CLICK,this.onKemptClicked,false,0,true);
      }
      
      internal function frame70() : *
      {
         stop();
         this.onPageReady();
      }
      
      private function onHowToPlayClicked(param1:MouseEvent) : void
      {
         Engine.instance.menu.gotoAndStop(UnstoppableMenuPages.HOW_TO_PLAY);
      }
      
      protected function onShowBanner() : void
      {
         if(UnstoppableDocument.instance.banner)
         {
            if(UnstoppableDocument.instance.banner.currentFrame < 3)
            {
               UnstoppableDocument.instance.banner.gotoAndPlay(2);
            }
         }
      }
      
      private function onKemptClicked(param1:MouseEvent) : void
      {
         navigateToURL(new URLRequest("http://www.kempt.co.uk"),"_blank");
         Tracker.kvClick(1431);
      }
      
      internal function frame69() : *
      {
         this.onShowBanner();
      }
      
      protected function onPageReady() : void
      {
         this.howToPlay_btn.addEventListener(MouseEvent.CLICK,this.onHowToPlayClicked,false,0,true);
         this.play_btn.addEventListener(MouseEvent.CLICK,this.onPlayClicked,false,0,true);
      }
      
      private function onPlayClicked(param1:MouseEvent) : void
      {
         Engine.instance.playGameTriggeredByUser();
      }
   }
}
