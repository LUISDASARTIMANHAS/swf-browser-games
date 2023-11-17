package uk.co.kempt.display.menu
{
   import fl.transitions.Tween;
   import fl.transitions.TweenEvent;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import uk.co.kempt.Engine;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.display.menu.StageIcon")]
   public class StageIcon extends MovieClip
   {
       
      
      private var _targetScale:Number;
      
      private var _startX:Number;
      
      private var _startY:Number;
      
      private var _startScale:Number;
      
      private var _targetX:Number;
      
      private var _targetY:Number;
      
      private var _tween:Tween;
      
      public var stage_txt:TextField;
      
      private var _string:String;
      
      private var _waitTween:Tween;
      
      private var _animPosition:Number;
      
      public var image_mc:MovieClip;
      
      public function StageIcon()
      {
         super();
         stop();
         this.image_mc.stop();
         this._animPosition = 0;
         this._startX = x;
         this._startY = y;
         this._startScale = scaleX;
         this._targetX = Engine.GAME_WIDTH / 2;
         this._targetY = Engine.GAME_HEIGHT / 2;
         this._targetScale = 6.5;
         this._tween = new Tween(this,"animPosition",null,0,0,1);
         this._tween.stop();
         this._waitTween = new Tween({},"null",null,0,1,Engine.GAME_FRAMERATE * 2);
         this._waitTween.stop();
         this._waitTween.addEventListener(TweenEvent.MOTION_FINISH,this.onWaitFinished);
         this._tween.addEventListener(TweenEvent.MOTION_FINISH,this.onTweenFinished);
      }
      
      public function activate() : void
      {
         gotoAndStop("flash");
         this._waitTween.rewind();
         this._waitTween.start();
      }
      
      private function onWaitFinished(param1:TweenEvent) : void
      {
         gotoAndStop("zoom");
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      public function set animPosition(param1:Number) : void
      {
         this._animPosition = param1;
         x = this._startX + (this._targetX - this._startX) * param1;
         y = this._startY + (this._targetY - this._startY) * param1;
         scaleX = scaleY = this._startScale + (this._targetScale - this._startScale) * param1;
      }
      
      public function get animPosition() : Number
      {
         return this._animPosition;
      }
      
      public function deactivate(param1:Boolean = false) : void
      {
         this._tween.continueTo(0,8);
         if(param1)
         {
            this._tween.fforward();
            this._tween.stop();
         }
      }
      
      public function set(param1:String) : *
      {
         this._string = param1;
         gotoAndStop("idle");
         this.stage_txt.text = param1;
         this.image_mc.gotoAndStop("level" + param1);
      }
      
      private function onTweenFinished(param1:TweenEvent) : void
      {
         if(param1.position == 0)
         {
            this.set(this._string);
         }
         dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}
