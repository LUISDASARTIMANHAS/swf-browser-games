package uk.co.kempt.display
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import uk.co.kempt.Engine;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.display.MuteButton")]
   public class MuteButton extends MovieClip
   {
       
      
      private var _timer:Timer;
      
      public function MuteButton()
      {
         super();
         stop();
         mouseChildren = false;
         buttonMode = true;
         addEventListener(MouseEvent.CLICK,this.onClicked);
         this.invalidate();
         this._timer = new Timer(1000);
         this._timer.addEventListener(TimerEvent.TIMER,this.onTimerEvent,false,0,true);
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage,false,0,true);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage,false,0,true);
         if(stage)
         {
            this.onAddedToStage(null);
         }
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         this._timer.start();
      }
      
      private function onTimerEvent(param1:TimerEvent) : void
      {
         this.invalidate();
      }
      
      private function onClicked(param1:MouseEvent) : void
      {
         Engine.instance.muted = !Engine.instance.muted;
         this.invalidate();
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         this._timer.stop();
      }
      
      private function invalidate() : void
      {
         var _loc1_:int = 0;
         if(Engine.instance)
         {
            _loc1_ = Engine.instance.muted ? 2 : 1;
            if(currentFrame != _loc1_)
            {
               gotoAndStop(_loc1_);
            }
         }
      }
   }
}
