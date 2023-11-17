package uk.co.kempt.display
{
   import fl.transitions.Tween;
   import fl.transitions.TweenEvent;
   import fl.transitions.easing.Regular;
   import flash.display.Sprite;
   import flash.events.Event;
   import uk.co.kempt.utils.GarbageUtil;
   
   public class LevelDangerSnapshotSequence extends Sprite
   {
      
      private static const TIME_2:int = 30;
      
      private static const TIME_3:int = 12;
      
      private static const EASE_2:Function = Regular.easeOut;
      
      private static const EASE_3:Function = Regular.easeOut;
      
      private static function EASE_1():*
      {
      }
      private static const TIME_1:int = 89;
       
      
      private var _tween1:Tween;
      
      private var _levelDangerSnapshot2:LevelDangerSnapshot;
      
      private var _levelDangerSnapshot3:LevelDangerSnapshot;
      
      private var _tween2:Tween;
      
      private var _levelDangerSnapshot1:LevelDangerSnapshot;
      
      private var _tween3:Tween;
      
      public function LevelDangerSnapshotSequence()
      {
         super();
         this._levelDangerSnapshot1 = new LevelDangerSnapshot(true,false);
         this._levelDangerSnapshot2 = new LevelDangerSnapshot();
         this._levelDangerSnapshot3 = new LevelDangerSnapshot(false,false);
         this._levelDangerSnapshot2.alpha = 0;
         this._levelDangerSnapshot3.alpha = 0;
         this._tween1 = new Tween({},"alpha",EASE_1,1,1,TIME_1);
         this._tween2 = new Tween(this._levelDangerSnapshot2,"alpha",EASE_2,0,1,TIME_2);
         this._tween3 = new Tween(this._levelDangerSnapshot3,"alpha",EASE_3,0,1,TIME_3);
         this._tween1.stop();
         this._tween2.stop();
         this._tween3.stop();
         this._tween1.addEventListener(TweenEvent.MOTION_FINISH,this.onTween1Finish,false,0,true);
         this._tween2.addEventListener(TweenEvent.MOTION_FINISH,this.onTween2Finish,false,0,true);
         this._tween3.addEventListener(TweenEvent.MOTION_FINISH,this.onTween3Finish,false,0,true);
         addChild(this._levelDangerSnapshot1);
         addChild(this._levelDangerSnapshot2);
         addChild(this._levelDangerSnapshot3);
      }
      
      public function die() : void
      {
         this._levelDangerSnapshot1.die();
         this._levelDangerSnapshot2.die();
         this._levelDangerSnapshot3.die();
         this._tween1.obj = null;
         this._tween2.obj = null;
         this._tween3.obj = null;
         this._tween1 = null;
         this._tween2 = null;
         this._tween3 = null;
         GarbageUtil.kill(this);
      }
      
      private function onTween3Finish(param1:TweenEvent) : void
      {
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      public function start() : void
      {
         this._tween1.start();
      }
      
      private function onTween1Finish(param1:TweenEvent) : void
      {
         this._tween2.start();
      }
      
      private function onTween2Finish(param1:TweenEvent) : void
      {
         this._tween3.start();
      }
   }
}
