package com.pavelzuk.components
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="com.pavelzuk.components.Transition")]
   public class Transition extends MovieClip
   {
       
      
      private var onStateChange:Function = null;
      
      public var active:Boolean = false;
      
      public function Transition()
      {
         super();
         addFrameScript(0,this.frame1,14,this.frame15,29,this.frame30);
         stop();
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      protected function endTween() : void
      {
         if(this.onStateChange == null)
         {
            gotoAndStop(1);
            visible = false;
            this.active = false;
         }
      }
      
      protected function changeState() : void
      {
         if(this.onStateChange != null)
         {
            this.onStateChange();
            this.onStateChange = null;
         }
      }
      
      public function playTween(param1:Object) : void
      {
         var target:Object = param1;
         play();
         if(target is Function)
         {
            this.onStateChange = target as Function;
         }
         else
         {
            this.onStateChange = function():*
            {
               GameController.timeline.gotoAndStop(target);
            };
         }
         visible = true;
         this.active = true;
      }
      
      internal function frame15() : *
      {
         this.changeState();
      }
      
      internal function frame30() : *
      {
         this.endTween();
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}
