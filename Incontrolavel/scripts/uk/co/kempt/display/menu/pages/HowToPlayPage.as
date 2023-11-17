package uk.co.kempt.display.menu.pages
{
   import flash.display.FrameLabel;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import uk.co.kempt.Engine;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.display.menu.pages.HowToPlayPage")]
   public class HowToPlayPage extends AbstractPage
   {
      
      private static const LABEL_END:String = "end";
      
      private static const LABEL_START:String = "start";
       
      
      private var _start:int;
      
      public var play_btn:SimpleButton;
      
      private var _end:int;
      
      public var backToStart_btn:SimpleButton;
      
      public function HowToPlayPage()
      {
         super();
         addFrameScript(29,this.frame30);
         this.searchLabels();
         this.play_btn.addEventListener(MouseEvent.CLICK,this.onPlayClicked,false,0,true);
         this.backToStart_btn.addEventListener(MouseEvent.CLICK,this.onBackToStartClicked,false,0,true);
      }
      
      private function onBackToStartClicked(param1:MouseEvent) : void
      {
         if(currentFrame <= this._start)
         {
            Engine.instance.mainMenuTriggeredByUser();
         }
         else
         {
            prevFrame();
         }
      }
      
      private function searchLabels() : void
      {
         var _loc2_:FrameLabel = null;
         var _loc1_:int = int(currentLabels.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = currentLabels[_loc3_];
            switch(_loc2_.name)
            {
               case LABEL_START:
                  this._start = _loc2_.frame;
                  break;
               case LABEL_END:
                  this._end = _loc2_.frame;
                  break;
            }
            _loc3_++;
         }
      }
      
      internal function frame30() : *
      {
         stop();
      }
      
      private function onPlayClicked(param1:MouseEvent) : void
      {
         if(currentFrame >= this._end)
         {
            Engine.instance.playGameTriggeredByUser();
         }
         else
         {
            nextFrame();
         }
         if(currentFrame >= this._end)
         {
            Engine.trackEvent("user read instructions",true);
         }
      }
   }
}
