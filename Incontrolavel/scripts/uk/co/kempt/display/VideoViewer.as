package uk.co.kempt.display
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import uk.co.kempt.Engine;
   import uk.co.kempt.utils.GarbageUtil;
   
   public class VideoViewer extends Sprite
   {
      
      private static const VIDEOS:Array = [Video1,Video2,Video3];
       
      
      private var _currentVideo:MovieClip;
      
      private var _currentIndex:int;
      
      public function VideoViewer()
      {
         super();
         graphics.beginFill(0);
         graphics.drawRect(0,0,Engine.GAME_WIDTH,Engine.GAME_HEIGHT);
         this._currentIndex = 0;
         this.hide();
      }
      
      private function showVideo() : void
      {
         this.removeCurrentVideo();
         var _loc1_:Class = VIDEOS[this._currentIndex];
         this._currentVideo = new _loc1_() as MovieClip;
         this._currentVideo.addFrameScript(this._currentVideo.totalFrames - 1,this.onVideoFinished);
         this._currentVideo.play();
         this._currentVideo.y = (Engine.GAME_HEIGHT - this._currentVideo.height) / 2;
         addChild(this._currentVideo);
         ++this._currentIndex;
         if(this._currentIndex >= VIDEOS.length)
         {
            this._currentIndex = 0;
         }
      }
      
      private function removeCurrentVideo() : void
      {
         if(this._currentVideo)
         {
            GarbageUtil.kill(this._currentVideo);
            this._currentVideo = null;
         }
      }
      
      public function hide() : void
      {
         visible = false;
         this.removeCurrentVideo();
      }
      
      public function show() : void
      {
         visible = true;
         this.showVideo();
      }
      
      private function onVideoFinished() : void
      {
         this.removeCurrentVideo();
         dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}
