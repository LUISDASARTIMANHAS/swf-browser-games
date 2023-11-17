package uk.co.kempt.display.menu
{
   import fl.transitions.Tween;
   import fl.transitions.TweenEvent;
   import flash.display.BlendMode;
   import flash.display.Sprite;
   import flash.events.Event;
   import uk.co.kempt.Engine;
   import uk.co.kempt.display.LevelDangerSnapshotSequence;
   import uk.co.kempt.utils.PixelateEffect;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.display.menu.StageSelect")]
   public class StageSelect extends Sprite
   {
      
      public static const S_IN:String = "in";
      
      public static const S_OUT:String = "out";
       
      
      private var _sequence:LevelDangerSnapshotSequence;
      
      private var _alphaTween:Tween;
      
      public var sections:MapSections;
      
      private var _state:String;
      
      public function StageSelect()
      {
         super();
         this.sections.setMapArea(1);
         this.sections.addEventListener(Event.COMPLETE,this.onSectionAnimateComplete);
         blendMode = BlendMode.LAYER;
         this._alphaTween = new Tween(this,"alpha",null,1,1,8);
         this._alphaTween.stop();
         this._alphaTween.addEventListener(TweenEvent.MOTION_FINISH,this.onAlphaTweenComplete);
      }
      
      private function onAlphaTweenComplete(param1:TweenEvent) : void
      {
         switch(this._state)
         {
            case S_IN:
               this._sequence.die();
               this._sequence = null;
               Engine.instance.onTransitionInFinished();
               break;
            case S_OUT:
               this.sections.animateOut();
         }
      }
      
      public function animateIn() : void
      {
         this._state = S_IN;
         var _loc1_:int = (Engine.instance.currentLevelNum - 1) % 5 + 1;
         if(this._sequence)
         {
            this._sequence.die();
         }
         this._sequence = new LevelDangerSnapshotSequence();
         this._sequence.addEventListener(Event.COMPLETE,this.onSequenceComplete,false,0,true);
         addChildAt(this._sequence,0);
         Engine.instance.display.visible = false;
         this.sections.animateIn(_loc1_);
      }
      
      public function setMapSection(param1:int) : void
      {
         this.sections.setMapArea(param1);
      }
      
      public function animateOut() : void
      {
         this._state = S_OUT;
         var _loc1_:PixelateEffect = new PixelateEffect();
         this._alphaTween.continueTo(1,8);
      }
      
      public function reset() : void
      {
         this._state = null;
         this._alphaTween.continueTo(1,8);
         this._alphaTween.fforward();
         this._alphaTween.stop();
         this.sections.animateOut(true);
      }
      
      private function onSectionAnimateComplete(param1:Event) : void
      {
         var _loc2_:PixelateEffect = new PixelateEffect();
         switch(this._state)
         {
            case S_IN:
               this._sequence.start();
               break;
            case S_OUT:
               Engine.instance.onTransitionOutFinished();
         }
      }
      
      private function onSequenceComplete(param1:Event) : void
      {
         this._alphaTween.continueTo(0,4);
         Engine.instance.display.visible = true;
      }
   }
}
