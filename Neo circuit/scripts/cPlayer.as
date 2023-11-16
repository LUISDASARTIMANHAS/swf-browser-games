package
{
   import container.cHashMap;
   import container.iIterator;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import flash.events.TouchEvent;
   import flash.geom.Rectangle;
   import flash.ui.Multitouch;
   import flash.ui.MultitouchInputMode;
   import org.flixel.*;
   import org.flixel.plugin.photonstorm.FlxCollision;
   import patterns.cEnum;
   import utils.cGeometry;
   import utils.cGfxUtils;
   import utils.cVector2;
   
   public class cPlayer
   {
      
      public static const GAMESTATUS_PLAYING:int = cEnum.Enum(0);
      
      public static const GAMESTATUS_WON:int = cEnum.inc;
      
      public static const GAMESTATUS_LOST:int = cEnum.inc;
      
      private static const GAMESTATUS_UPDATE_TIME:Number = 0.25;
      
      private static const LINE_STRENGTH:int = 5;
      
      private static const MOUSE_EVENT_ID:int = 9999;
      
      private static const LINE_COLOR_VALID:Number = 65280;
      
      private static const LINE_COLOR_INVALID:Number = 16776960;
      
      private static const LINE_COLOR_CUT:Number = 16777215;
      
      private static const TOUCH_UPATE_TIME:Number = 0.05;
      
      private static const UPRADE_DELAY:Number = 0.5;
      
      private static var m_tempRect:Rectangle = new Rectangle();
      
      private static var m_tempVec1:cVector2 = new cVector2();
      
      private static var m_tempVec2:cVector2 = new cVector2();
      
      private static var m_tempVec3:cVector2 = new cVector2();
      
      private static var m_tempVec4:cVector2 = new cVector2();
       
      
      private var m_camBuffer:BitmapData;
      
      private var m_mouseHoverCPU:cCPU;
      
      private var m_drag:Boolean;
      
      private var m_touchPoint:FlxPoint;
      
      private var m_lineColor:int;
      
      private var m_touchEventList:cHashMap;
      
      private var m_validCpuList:Array;
      
      private var m_gameStatusTimer:Number;
      
      public var gameStatus:int;
      
      public var m_selections:Array;
      
      public var m_lastSelectedCPU:cCPU;
      
      private var m_touchTimer:Number = 0.05;
      
      private var m_actionAllowed:Boolean = true;
      
      private var m_listenersActive:Boolean = false;
      
      private var m_tutorialData:cTutorialData;
      
      private var m_upgrading:Boolean;
      
      private var m_mouseSprite:FlxSprite;
      
      private var m_boostValue:Number;
      
      public function cPlayer()
      {
         this.m_validCpuList = [];
         super();
         this.m_touchPoint = new FlxPoint();
         this.m_touchEventList = new cHashMap();
         this.m_mouseSprite = new FlxSprite(0,0);
         this.m_mouseSprite.makeGraphic(2,2);
      }
      
      public function init() : void
      {
         this.addListener();
         this.m_camBuffer = FlxG.camera.buffer;
         this.gameStatus = GAMESTATUS_PLAYING;
         this.m_lastSelectedCPU = null;
      }
      
      public function actionAllowed(param1:Boolean, param2:cTutorialData) : void
      {
         this.m_tutorialData = param2;
         this.m_actionAllowed = param1;
         if(!this.m_actionAllowed)
         {
            this.removeListener();
         }
         else
         {
            this.addListener();
         }
      }
      
      private function updateGameStatus() : void
      {
         var _loc2_:cCPU = null;
         this.m_gameStatusTimer -= FlxG.elapsed;
         while(this.m_gameStatusTimer <= 0)
         {
            this.m_gameStatusTimer = GAMESTATUS_UPDATE_TIME;
            if(true)
            {
               var _loc1_:cMap = cObjectManager.getInstance().map;
               var _loc3_:int = 0;
               var _loc4_:Array = _loc1_.cpuList;
               var _loc5_:int = 0;
               while(_loc5_ < _loc4_.length)
               {
                  _loc2_ = _loc4_[_loc5_] as cCPU;
                  if(_loc2_.owner == cCPU.PLAYER01)
                  {
                     _loc3_++;
                  }
                  _loc5_++;
               }
               if(_loc3_ == _loc1_.numControlableCpus)
               {
                  this.gameStatus = GAMESTATUS_WON;
               }
               else if(_loc3_ == 0)
               {
                  this.gameStatus = GAMESTATUS_LOST;
               }
               else
               {
                  this.gameStatus = GAMESTATUS_PLAYING;
               }
               return;
            }
         }
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
      
      public function addListener() : void
      {
         if(!this.m_actionAllowed)
         {
            return;
         }
         if(this.m_listenersActive)
         {
            return;
         }
         if(NeoCircuit.mobileRelease)
         {
            Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
            FlxG.stage.addEventListener(TouchEvent.TOUCH_BEGIN,this.onTouchBegin);
            FlxG.stage.addEventListener(TouchEvent.TOUCH_MOVE,this.onTouchMove);
            FlxG.stage.addEventListener(TouchEvent.TOUCH_END,this.onTouchEnd);
         }
         else
         {
            FlxG.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseBegin);
            FlxG.stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseEnd);
            FlxG.stage.addEventListener(TouchEvent.TOUCH_MOVE,this.onTouchMove);
         }
         this.m_listenersActive = true;
      }
      
      public function removeListener() : void
      {
         if(this.m_mouseHoverCPU != null)
         {
            this.m_mouseHoverCPU.select(false);
         }
         if(this.m_lastSelectedCPU != null)
         {
            this.m_lastSelectedCPU.select(false);
         }
         this.m_touchEventList.clear();
         this.m_mouseHoverCPU = null;
         this.m_lastSelectedCPU = null;
         this.ClearValidCPUList();
         if(!this.m_listenersActive)
         {
            return;
         }
         if(NeoCircuit.mobileRelease)
         {
            FlxG.stage.removeEventListener(TouchEvent.TOUCH_MOVE,this.onTouchMove);
            FlxG.stage.removeEventListener(TouchEvent.TOUCH_BEGIN,this.onTouchBegin);
            FlxG.stage.removeEventListener(TouchEvent.TOUCH_END,this.onTouchEnd);
         }
         else
         {
            FlxG.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseBegin);
            FlxG.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseEnd);
            FlxG.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         }
         this.m_listenersActive = false;
      }
      
      public function update() : void
      {
         if(this.gameStatus != GAMESTATUS_PLAYING)
         {
            return;
         }
         this.updateGameStatus();
         if(!this.m_actionAllowed)
         {
            return;
         }
         this.m_mouseHoverCPU = this.pickCPU(FlxG.mouse);
         if(this.m_mouseHoverCPU != null)
         {
            this.m_mouseHoverCPU.select(true,0);
         }
         if(this.m_lastSelectedCPU != this.m_mouseHoverCPU && this.m_lastSelectedCPU != null)
         {
            this.m_lastSelectedCPU.select(false);
         }
         if(this.m_mouseHoverCPU != null)
         {
            this.m_lastSelectedCPU = this.m_mouseHoverCPU;
         }
         this.upgradeCpus();
      }
      
      public function draw() : void
      {
         var _loc2_:cLineData = null;
         if(this.gameStatus != GAMESTATUS_PLAYING)
         {
            return;
         }
         if(!this.m_drag)
         {
            return;
         }
         if(this.m_upgrading)
         {
            return;
         }
         if(this.m_tutorialData != null)
         {
            if(!this.m_tutorialData.connecting && !this.m_tutorialData.cutting)
            {
               return;
            }
         }
         var _loc1_:iIterator = this.m_touchEventList.getIterator();
         while(_loc1_.isValid())
         {
            _loc2_ = _loc1_.data as cLineData;
            cGfxUtils.drawLine(this.m_camBuffer,_loc2_.xStart,_loc2_.yStart,_loc2_.xEnd,_loc2_.yEnd,this.m_lineColor,LINE_STRENGTH);
            _loc1_.next();
         }
      }
      
      public function pickCPU(param1:FlxPoint, param2:Boolean = false) : cCPU
      {
         var _loc4_:cCPU = null;
         this.m_mouseSprite.x = param1.x;
         this.m_mouseSprite.y = param1.y;
         var _loc3_:cMap = cObjectManager.getInstance().map;
         if(_loc3_.cpuList == null)
         {
            return null;
         }
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.cpuList.length)
         {
            _loc4_ = _loc3_.cpuList[_loc5_] as cCPU;
            §§push(!param2);
            if(!param2)
            {
               §§pop();
               while(true)
               {
                  §§push(_loc4_.owner != cCPU.PLAYER01);
               }
               addr57:
            }
            while(true)
            {
               if(!§§pop())
               {
                  if(_loc4_.overlapsPoint(param1))
                  {
                     if(FlxCollision.pixelPerfectCheck(this.m_mouseSprite,_loc4_))
                     {
                        return _loc4_;
                     }
                  }
               }
               _loc5_++;
               if(true)
               {
                  break;
               }
               §§goto(addr57);
            }
         }
         return null;
      }
      
      public function upgradeCpus() : void
      {
         var _loc2_:cLineData = null;
         if(this.m_tutorialData != null && !this.m_tutorialData.upgrading)
         {
            return;
         }
         if(!this.m_drag)
         {
            return;
         }
         var _loc1_:iIterator = this.m_touchEventList.getIterator();
         this.m_upgrading = false;
         while(_loc1_.isValid())
         {
            _loc2_ = _loc1_.data as cLineData;
            if(_loc2_.startCpu != null)
            {
               if(_loc2_.startCpu == _loc2_.endCpu || _loc2_.endCpu == null && _loc2_.startCpu.overlapsPoint(FlxG.mouse))
               {
                  _loc2_.upgradeTime += FlxG.elapsed;
                  if(_loc2_.upgradeTime > UPRADE_DELAY)
                  {
                     this.m_upgrading = true;
                     this.ClearValidCPUList();
                     _loc2_.startCpu.tryUpgrading();
                     if(_loc2_.startCpu.justUpgraded)
                     {
                        _loc2_.upgradeTime = int.MIN_VALUE;
                        while(true)
                        {
                           this.m_upgrading = false;
                        }
                        addr60:
                     }
                  }
               }
            }
            while(true)
            {
               _loc1_.next();
               if(true)
               {
                  break;
               }
               §§goto(addr60);
            }
         }
      }
      
      private function TryToBuildConnection(param1:cLineData) : void
      {
         if(param1.startCpu == null || param1.endCpu == null)
         {
            this.TryToCutConnection(param1);
            return;
         }
         if(this.m_tutorialData != null && !this.m_tutorialData.connecting)
         {
            return;
         }
         if(param1.startCpu.owner != cCPU.PLAYER01)
         {
            return;
         }
         if(param1.startCpu == param1.endCpu)
         {
            return;
         }
         if(!cPlayerAI.connectable(param1.startCpu,param1.endCpu,param1.powerCost))
         {
            return;
         }
         param1.startCpu.addConnection(param1.endCpu,param1.powerCost);
         FlxG.play(NeoCircuit.SFX.SndConnect);
      }
      
      private function TryToCutConnection(param1:cLineData) : void
      {
         var _loc3_:cCPU = null;
         var _loc4_:cConnection = null;
         if(this.m_tutorialData != null && !this.m_tutorialData.cutting)
         {
            return;
         }
         if(param1.startCpu != null)
         {
            return;
         }
         var _loc2_:int = 0;
         var _loc5_:Array;
         if((_loc5_ = cObjectManager.getInstance().map.cpuList) == null)
         {
            return;
         }
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc3_ = _loc5_[_loc6_] as cCPU;
            if(_loc3_.owner == cCPU.PLAYER01)
            {
               _loc2_ = 0;
               loop1:
               while(_loc2_ < _loc3_.connections.length)
               {
                  _loc4_ = _loc3_.connections[_loc2_] as cConnection;
                  m_tempVec1.set(param1.xStart,param1.yStart);
                  m_tempVec2.set(param1.xEnd,param1.yEnd);
                  m_tempVec3.set(_loc4_.startCPU.x + _loc4_.startCPU.origin.x,_loc4_.startCPU.y + _loc4_.startCPU.origin.y);
                  m_tempVec4.set(_loc4_.endCPU.x + _loc4_.endCPU.origin.x,_loc4_.endCPU.y + _loc4_.endCPU.origin.y);
                  if(!cGeometry.isLineIntersecting(m_tempVec1,m_tempVec2,m_tempVec3,m_tempVec4))
                  {
                     continue;
                  }
                  _loc3_.cutConnection(_loc4_);
                  while(true)
                  {
                     FlxG.play(NeoCircuit.SFX.SndCut);
                     continue loop1;
                  }
                  while(true)
                  {
                     _loc2_++;
                     if(true)
                     {
                        break;
                     }
                     §§goto(addr95);
                  }
               }
            }
            _loc6_++;
         }
      }
      
      private function UpdateValidCpuList(param1:cCPU) : void
      {
         var _loc3_:cCPU = null;
         if(this.m_tutorialData != null)
         {
            if(!this.m_tutorialData.connecting)
            {
               return;
            }
         }
         var _loc2_:Array = cObjectManager.getInstance().map.cpuList;
         this.m_validCpuList = [];
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc4_] as cCPU;
            if(_loc3_ != param1)
            {
               if(cPlayerAI.connectable(param1,_loc3_,0))
               {
                  this.m_validCpuList.push(_loc3_);
                  while(true)
                  {
                     _loc3_.select(true);
                  }
                  addr53:
               }
            }
            while(true)
            {
               _loc4_++;
               if(true)
               {
                  break;
               }
               §§goto(addr53);
            }
         }
      }
      
      private function SetStartLineColor(param1:cCPU) : void
      {
         if(param1 == null)
         {
            this.m_lineColor = LINE_COLOR_CUT;
            return;
         }
         if(!param1.hasFreeConnection())
         {
            this.m_lineColor = LINE_COLOR_INVALID;
         }
         else
         {
            this.m_lineColor = LINE_COLOR_VALID;
         }
         this.UpdateValidCpuList(param1);
      }
      
      private function onMouseBegin(param1:MouseEvent) : void
      {
         this.m_touchEventList.insert(MOUSE_EVENT_ID,new cLineData(param1.stageX,param1.stageY,this.m_mouseHoverCPU));
         this.SetStartLineColor(this.m_mouseHoverCPU);
         FlxG.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         this.m_drag = true;
      }
      
      private function onMouseEnd(param1:MouseEvent) : void
      {
         var _loc2_:cLineData = this.m_touchEventList.find(MOUSE_EVENT_ID) as cLineData;
         if(_loc2_ != null)
         {
            this.TryToBuildConnection(_loc2_);
         }
         this.m_drag = false;
         FlxG.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         this.m_touchEventList.remove(MOUSE_EVENT_ID);
         this.ClearValidCPUList();
      }
      
      private function onMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:cLineData = this.m_touchEventList.find(MOUSE_EVENT_ID) as cLineData;
         if(_loc2_ == null)
         {
            return;
         }
         this.m_touchPoint.x = _loc2_.xStart;
         this.m_touchPoint.y = _loc2_.yStart;
         _loc2_.startCpu = this.pickCPU(this.m_touchPoint);
         _loc2_.endCpu = this.pickCPU(FlxG.mouse,true);
         this.SetStartLineColor(_loc2_.startCpu);
         _loc2_.xEnd = param1.stageX;
         _loc2_.yEnd = param1.stageY;
      }
      
      private function onTouchBegin(param1:TouchEvent) : void
      {
         this.m_touchPoint.x = param1.stageX;
         this.m_touchPoint.y = param1.stageY;
         var _loc2_:cCPU = this.pickCPU(this.m_touchPoint);
         this.m_touchEventList.insert(param1.touchPointID,new cLineData(param1.stageX,param1.stageY,_loc2_));
         this.SetStartLineColor(_loc2_);
         this.m_drag = true;
      }
      
      private function onTouchEnd(param1:TouchEvent) : void
      {
         var _loc2_:cLineData = this.m_touchEventList.find(param1.touchPointID) as cLineData;
         if(_loc2_ != null)
         {
            this.TryToBuildConnection(_loc2_);
         }
         this.m_touchEventList.remove(param1.touchPointID);
         this.ClearValidCPUList();
         if(this.m_touchEventList.size == 0)
         {
            this.m_drag = false;
         }
      }
      
      private function onTouchMove(param1:TouchEvent) : void
      {
         if(this.m_touchPoint.x == param1.stageX && this.m_touchPoint.y == param1.stageY)
         {
            return;
         }
         var _loc2_:cLineData = this.m_touchEventList.find(param1.touchPointID) as cLineData;
         if(_loc2_ != null)
         {
            this.m_touchPoint.x = _loc2_.xStart;
            this.m_touchPoint.y = _loc2_.yStart;
            _loc2_.startCpu = this.pickCPU(this.m_touchPoint);
            this.m_touchPoint.x = param1.stageX;
            this.m_touchPoint.y = param1.stageY;
            _loc2_.endCpu = this.pickCPU(this.m_touchPoint,true);
            this.SetStartLineColor(_loc2_.startCpu);
            _loc2_.xEnd = param1.stageX;
            _loc2_.yEnd = param1.stageY;
         }
      }
      
      private function ClearValidCPUList() : void
      {
         var _loc1_:cCPU = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.m_validCpuList.length)
         {
            _loc1_ = this.m_validCpuList[_loc2_] as cCPU;
            _loc1_.select(false);
            _loc2_++;
         }
         this.m_validCpuList = [];
      }
   }
}
