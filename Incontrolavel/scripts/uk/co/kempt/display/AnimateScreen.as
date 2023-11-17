package uk.co.kempt.display
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import uk.co.kempt.DrawingEngine;
   import uk.co.kempt.Engine;
   import uk.co.kempt.data.TrackNode;
   import uk.co.kempt.system.TrackBuilder;
   import uk.co.kempt.utils.GarbageUtil;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.display.AnimateScreen")]
   public class AnimateScreen extends Sprite
   {
      
      public static const IDLE:String = "idle";
      
      public static const ANIMATING:String = "animating";
       
      
      private var _canvasData:BitmapData;
      
      private var _drawingEngine:DrawingEngine;
      
      private var _canvasSleeper:Bitmap;
      
      private var _bridgeTime:int;
      
      private var _canvasBridge:Bitmap;
      
      private var _state:String;
      
      private var _canvasRail1:Sprite;
      
      private var _canvasRail2:Sprite;
      
      private var _canvasBridgeData:BitmapData;
      
      private var _grubble:Grubble;
      
      private var _currentBridgeIndex:int;
      
      private var _canvasRail:Bitmap;
      
      private var _canvasRailData:BitmapData;
      
      private var _currentIndex:int;
      
      public function AnimateScreen()
      {
         super();
         mouseEnabled = mouseChildren = false;
         this.init();
      }
      
      public function draw(param1:DisplayObject) : void
      {
         this._canvasRailData.draw(param1,param1.transform.matrix);
      }
      
      public function get drawingEngine() : DrawingEngine
      {
         return this._drawingEngine;
      }
      
      public function invalidateGrubble() : void
      {
         this._grubble.invalidate();
      }
      
      public function get currentBridgeIndex() : int
      {
         return this._currentBridgeIndex;
      }
      
      public function update() : void
      {
         switch(this._state)
         {
            case IDLE:
               break;
            case ANIMATING:
               this.updateAnimating();
         }
      }
      
      private function updateAnimating() : void
      {
         var _loc2_:TrackNode = null;
         var _loc3_:TrackNode = null;
         var _loc4_:int = 0;
         var _loc5_:TrackNode = null;
         var _loc1_:TrackBuilder = Engine.instance.trackBuilder;
         this.drawingEngine.update();
         if(this._canvasData)
         {
            if(this._currentIndex < this._drawingEngine.nodeData.nodes.indexOf(Engine.instance.trackBuilder.currentNode))
            {
               _loc3_ = this._drawingEngine.nodeData.getNode(this._currentIndex);
               this._drawingEngine.drawSleeper(this._canvasData,_loc3_);
               this._drawingEngine.drawRail(this._canvasRailData,_loc3_);
               ++this._currentIndex;
            }
            _loc2_ = Engine.instance.trackBuilder.currentBridgeNode;
            if(this._currentBridgeIndex != -1 && Boolean(_loc2_))
            {
               _loc4_ = int(this._drawingEngine.nodeData.nodes.indexOf(Engine.instance.trackBuilder.currentBridgeNode));
               if(this._currentBridgeIndex < _loc4_)
               {
                  if((_loc5_ = this._drawingEngine.nodeData.getNode(this._currentBridgeIndex)).former)
                  {
                     this._drawingEngine.drawBridgeFloor(this._canvasBridgeData,_loc5_);
                     this._drawingEngine.drawBridge(this._canvasRailData,_loc5_);
                     ++this._currentBridgeIndex;
                  }
               }
            }
         }
         if(_loc1_.collidingWithBuilding)
         {
            this._grubble.draw(_loc1_.previous,_loc1_.current);
         }
      }
      
      private function init() : void
      {
         this._currentIndex = 0;
         this._currentBridgeIndex = -1;
         this._canvasData = new BitmapData(Engine.GAME_WIDTH,Engine.GAME_HEIGHT,true,0);
         this._canvasRailData = new BitmapData(Engine.GAME_WIDTH,Engine.GAME_HEIGHT,true,0);
         this._canvasBridgeData = new BitmapData(Engine.GAME_WIDTH,Engine.GAME_HEIGHT,true,0);
         this._canvasSleeper = new Bitmap(this._canvasData);
         this._canvasRail = new Bitmap(this._canvasRailData);
         this._canvasBridge = new Bitmap(this._canvasBridgeData);
         this._canvasRail1 = new Sprite();
         this._canvasRail2 = new Sprite();
         this._drawingEngine = new DrawingEngine();
         this._grubble = new Grubble();
         this._state = ANIMATING;
         addChild(this._grubble);
         addChild(this._canvasBridge);
         addChild(this._canvasSleeper);
         addChild(this._canvasRail);
         addChild(this._canvasRail1);
         addChild(this._canvasRail2);
      }
      
      public function die() : void
      {
         if(this._canvasData)
         {
            try
            {
               this._canvasData.dispose();
            }
            catch(e:Error)
            {
            }
         }
         if(this._canvasRailData)
         {
            try
            {
               this._canvasRailData.dispose();
            }
            catch(e:Error)
            {
            }
         }
         if(this._canvasRail1)
         {
            this._canvasRail1.graphics.clear();
         }
         if(this._canvasRail2)
         {
            this._canvasRail2.graphics.clear();
         }
         if(this._drawingEngine)
         {
            this._drawingEngine.die();
         }
         if(this._grubble)
         {
            this._grubble.die();
         }
         this._canvasData = null;
         this._canvasRailData = null;
         this._canvasRail1 = null;
         this._canvasRail2 = null;
         this._canvasSleeper = null;
         this._drawingEngine = null;
         GarbageUtil.kill(this);
      }
      
      public function set currentBridgeIndex(param1:int) : void
      {
         this._currentBridgeIndex = param1;
      }
      
      protected function removeCanvas() : void
      {
         if(this._canvasRail1)
         {
            if(this._canvasRail1.parent)
            {
               this._canvasRail1.parent.removeChild(this._canvasRail1);
            }
            this._canvasRail1 = null;
         }
         if(this._canvasRail2)
         {
            if(this._canvasRail2.parent)
            {
               this._canvasRail2.parent.removeChild(this._canvasRail2);
            }
            this._canvasRail2 = null;
         }
         if(this._canvasData)
         {
            this._canvasData.dispose();
            this._canvasData = null;
         }
         if(this._canvasSleeper)
         {
            this._canvasSleeper.bitmapData = null;
            if(this._canvasSleeper.parent)
            {
               this._canvasSleeper.parent.removeChild(this._canvasSleeper);
            }
            this._canvasSleeper = null;
         }
         if(this._canvasBridgeData)
         {
            this._canvasBridgeData.dispose();
            this._canvasBridgeData = null;
         }
         if(this._canvasBridge)
         {
            this._canvasBridge.bitmapData = null;
            if(this._canvasBridge.parent)
            {
               this._canvasBridge.parent.removeChild(this._canvasBridge);
            }
            this._canvasBridge = null;
         }
      }
   }
}
