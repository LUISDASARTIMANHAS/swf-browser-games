package uk.co.kempt
{
   import com.memecounter.Tracker;
   import fl.transitions.Tween;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import net.hires.debug.Stats;
   import org.cove.ape.APEngine;
   import org.cove.ape.AbstractConstraint;
   import org.cove.ape.AbstractParticle;
   import org.cove.ape.Group;
   import uk.co.kempt.data.LevelStatistics;
   import uk.co.kempt.data.LevelStatisticsCollection;
   import uk.co.kempt.data.Lookup;
   import uk.co.kempt.data.TimePoint;
   import uk.co.kempt.data.TrackData;
   import uk.co.kempt.display.AnimateScreen;
   import uk.co.kempt.display.BrushSprite;
   import uk.co.kempt.display.HUD;
   import uk.co.kempt.display.RingOfDeath;
   import uk.co.kempt.display.VideoViewer;
   import uk.co.kempt.display.WipeTransition;
   import uk.co.kempt.display.drawing.DashedLine;
   import uk.co.kempt.display.menu.StageSelect;
   import uk.co.kempt.display.menu.UnstoppableMenuPages;
   import uk.co.kempt.display.particles.PubeBomb;
   import uk.co.kempt.sounds.Snd;
   import uk.co.kempt.sounds.SoundManager;
   import uk.co.kempt.sounds.UnstoppableSounds;
   import uk.co.kempt.state.GameState;
   import uk.co.kempt.state.WorldObjectState;
   import uk.co.kempt.system.HighscoresSystem;
   import uk.co.kempt.system.TrackBuilder;
   import uk.co.kempt.system.TrainSystem;
   import uk.co.kempt.translation.TranslationEngine;
   import uk.co.kempt.utils.APEUtil;
   import uk.co.kempt.utils.GarbageUtil;
   import uk.co.kempt.utils.MathUtil;
   import uk.co.kempt.world.Level;
   import uk.co.kempt.world.WorldObject;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.Engine")]
   public class Engine extends Sprite
   {
      
      private static var UPDATEABLES:Array = [];
      
      public static const GAME_HEIGHT:int = 320;
      
      private static var INSTANCE:Engine;
      
      public static const GAME_WIDTH:int = 480;
      
      public static const GAME_FRAMERATE:int = 30;
      
      private static const TRACK_RENDER_DELAY:int = GAME_FRAMERATE / 2;
      
      public static const MINIMUM_POINT_DISTANCE:Number = 6;
      
      private static const QUALIFIED_CLASS_NAME_PREFIX:String = "Level";
      
      private static var TRACKED_EVENTS:Dictionary = new Dictionary();
      
      private static var GAME_START:Boolean;
      
      public static const DRAW_APE:Boolean = false;
      
      private static var CURRENT_LEVEL:int = 0;
      
      private static var WORLD_OBJECTS:Array = [];
       
      
      private var _trackData:TrackData;
      
      private var _screams:Vector.<Snd>;
      
      private var _soundMan:SoundManager;
      
      private var _mouseIsDown:Boolean;
      
      private var _brush:BrushSprite;
      
      private var _gameTime:int;
      
      public var vignette:Sprite;
      
      private var _started:Boolean;
      
      private var _menu:UnstoppableMenuPages;
      
      private var _levelStatsCollection:LevelStatisticsCollection;
      
      private var _debugLayer:Sprite;
      
      private var _drawingEnabled:Boolean;
      
      private var _currentLevel:Level;
      
      private var _muted:Boolean;
      
      private var _apeDisplay:Sprite;
      
      private var _brushCanvas:DashedLine;
      
      private var _trainContainer:Sprite;
      
      private var _levelContainer:Sprite;
      
      private var _brushCanvasAlphaTween:Tween;
      
      private var _display:Sprite;
      
      private var _particleEngine:ParticleEngine;
      
      private var _levelStatistics:LevelStatistics;
      
      private var _gameStatsCollection:LevelStatisticsCollection;
      
      private var _state:String;
      
      public var hit:Sprite;
      
      private var _trainSystem:TrainSystem;
      
      private var _delay:int;
      
      private var _defaultGroup:Group;
      
      private var _stats:Stats;
      
      private var _bgMusic:Snd;
      
      private var _successCount:int;
      
      private var _animateScreen:AnimateScreen;
      
      private var _trackBuilder:TrackBuilder;
      
      private var _target:Point;
      
      private var _highscoresSystem:HighscoresSystem;
      
      private var _videoViewer:VideoViewer;
      
      private var _warningSound:Snd;
      
      private var _qualityManager:QualityManager;
      
      private var _successDistance:Number;
      
      private var _stageSelect:StageSelect;
      
      private var _transition:WipeTransition;
      
      public var hud:HUD;
      
      public function Engine()
      {
         this._screams = new Vector.<Snd>();
         super();
         INSTANCE = this;
         CURRENT_LEVEL = 1;
         GAME_START = true;
         if(stage)
         {
            this.init();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStageEvent);
         }
      }
      
      public static function removeWorldObject(param1:WorldObject) : void
      {
         var _loc4_:WorldObject = null;
         var _loc5_:int = 0;
         var _loc2_:* = [];
         var _loc3_:* = [];
         _loc5_ = int(UPDATEABLES.length);
         while(_loc5_ >= 0)
         {
            if((_loc4_ = UPDATEABLES[_loc5_]) != param1)
            {
               if(_loc4_)
               {
                  _loc3_.push(_loc4_);
               }
            }
            _loc5_--;
         }
         _loc5_ = int(WORLD_OBJECTS.length);
         while(_loc5_ >= 0)
         {
            if((_loc4_ = WORLD_OBJECTS[_loc5_]) == param1)
            {
               if(_loc4_.state != WorldObjectState.BURIED)
               {
                  _loc4_.state = WorldObjectState.BURIED;
               }
            }
            else if(_loc4_)
            {
               _loc2_.push(_loc4_);
            }
            _loc5_--;
         }
         UPDATEABLES = _loc3_;
         WORLD_OBJECTS = _loc2_;
      }
      
      public static function trackEvent(param1:String, param2:Boolean = false) : void
      {
         var _loc3_:Boolean = !param2 || !TRACKED_EVENTS[param1];
         trace("TrackEvent: " + param1 + " | " + _loc3_);
         if(_loc3_)
         {
            TRACKED_EVENTS[param1] = true;
            trace("Sending event to tracker");
            Tracker.mcEvent(param1);
         }
      }
      
      public static function addWorldObject(param1:WorldObject) : void
      {
         WORLD_OBJECTS.push(param1);
      }
      
      public static function getWorldObjects(param1:Class = null) : Array
      {
         var _loc4_:WorldObject = null;
         param1 ||= WorldObject;
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < WORLD_OBJECTS.length)
         {
            if((Boolean(_loc4_ = WORLD_OBJECTS[_loc3_])) && _loc4_ is param1)
            {
               _loc2_.push(_loc4_);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function get instance() : Engine
      {
         return INSTANCE;
      }
      
      public static function addUpdatable(param1:WorldObject) : void
      {
         UPDATEABLES.push(param1);
      }
      
      private function checkBrushPosition() : void
      {
         var _loc4_:Number = NaN;
         var _loc1_:Number = this._currentLevel.exit.x - this._brush.x;
         var _loc2_:Number = this._currentLevel.exit.y - this._brush.y;
         var _loc3_:Number = Number(Math.sqrt(Math.pow(_loc1_,2) + Math.pow(_loc2_,2)));
         if(_loc3_ < this._currentLevel.exit.radius)
         {
            if(!this.levelStatistics.reachedExit)
            {
               this.levelStatistics.reachedExit = true;
            }
            _loc4_ = MathUtil.radianDiff(this._brush.rotation / 180 * Math.PI,this._currentLevel.exit.rotation / 180 * Math.PI);
            if(Math.abs(_loc4_) < Math.PI / 1.2)
            {
               if(isNaN(this._successDistance))
               {
                  this._successDistance = _loc3_;
               }
               else
               {
                  this._successDistance = Math.min(this._successDistance,_loc3_);
               }
            }
         }
         else
         {
            this._successCount = 0;
         }
         if(!isNaN(this._successDistance))
         {
            if(this._successDistance != _loc3_)
            {
               this.onTargetReached();
            }
         }
      }
      
      private function updateStateAboutToCrash() : void
      {
         if(this._delay > 0)
         {
            --this._delay;
            if(this._delay <= 0)
            {
               this.onTrainCrashWaitFinished();
            }
         }
      }
      
      private function updateBrush() : void
      {
         var _loc1_:Point = null;
         var _loc2_:Boolean = false;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:TimePoint = null;
         var _loc6_:TimePoint = null;
         var _loc7_:Point = null;
         if(!this._target)
         {
            _loc1_ = new Point(mouseX,mouseY);
            if(!this.levelStatistics.reachedExit)
            {
               _loc3_ = 12;
               _loc4_ = 4;
               _loc1_.x = Math.max(_loc4_,Math.min(GAME_WIDTH - _loc4_ * 2,_loc1_.x));
               _loc1_.y = Math.max(_loc3_,Math.min(GAME_HEIGHT - _loc3_ * 2,_loc1_.y));
            }
            _loc2_ = this.mouseIsDown && this.drawingEnabled;
         }
         else
         {
            _loc1_ = this._target.clone();
            _loc2_ = true;
         }
         if(_loc2_)
         {
            this._brush.update(_loc1_);
            _loc5_ = this._trackData.endPoint;
            if((_loc7_ = (_loc6_ = new TimePoint(this._brush.x,this._brush.y,this.gameTime)).subtract(_loc5_)).length >= MINIMUM_POINT_DISTANCE)
            {
               this._trackData.add(_loc6_);
               this.drawCanvas(_loc6_);
            }
         }
         if(this._brush)
         {
            this._brush.updateAnyway();
         }
         if(this.brush.hitRestriction)
         {
            if(this._animateScreen)
            {
               if(this._animateScreen.drawingEngine)
               {
                  if(this._trackBuilder.crashIndex < 1)
                  {
                     this._trackBuilder.crashPoint = new Point(this.brush.x,this.brush.y);
                     this._trackBuilder.crashIndex = this._animateScreen.drawingEngine.trackData.length + this._trackData.length + 1;
                  }
               }
            }
         }
         this.levelStatistics.distanceToExitCenter = Math.min(this.levelStatistics.distanceToExitCenter,Math.sqrt(Math.pow(this._currentLevel.exit.x - this._brush.x,2) + Math.pow(this._currentLevel.exit.y - this._brush.y,2)));
      }
      
      private function updateWorldObject(param1:WorldObject, param2:int, param3:Array) : void
      {
         if(param1)
         {
            param1.update();
         }
      }
      
      private function updateWorldObjectBeforeAPE(param1:WorldObject, param2:int, param3:Array) : void
      {
         if(param1)
         {
            param1.updateBeforeAPE();
         }
      }
      
      private function prepareWorldObjectForSimulation(param1:WorldObject, param2:int, param3:Array) : void
      {
         param1.prepareForSimulation();
      }
      
      private function initBeforeLevel() : void
      {
         this._state = GameState.DRAWING;
         this._trackData = new TrackData();
         this._target = null;
         WORLD_OBJECTS = [];
         UPDATEABLES = [];
         if(GAME_START)
         {
            GAME_START = false;
            this._gameStatsCollection = new LevelStatisticsCollection();
         }
         if((CURRENT_LEVEL - 1) % 5 == 0)
         {
            this._levelStatsCollection = new LevelStatisticsCollection();
         }
         if(!this._levelStatsCollection)
         {
            this._levelStatsCollection = new LevelStatisticsCollection();
         }
         this._levelStatistics = new LevelStatistics();
         this._gameStatsCollection.add(this._levelStatistics);
         this._levelStatsCollection.add(this._levelStatistics);
         this._levelStatistics.budget = Level.getBudgetInDollars(CURRENT_LEVEL);
         this._started = true;
         this._drawingEnabled = true;
         this.hud.timebar.reset(Level.getTimeInSeconds(CURRENT_LEVEL) * GAME_FRAMERATE);
         this.hud.update();
         this.initAPE();
      }
      
      private function init() : void
      {
         this._levelContainer = new Sprite();
         this._trainContainer = new Sprite();
         this._apeDisplay = new Sprite();
         this._brushCanvas = this._brushCanvas || new DashedLine(2,16777215);
         this._particleEngine = new ParticleEngine(this._trainContainer);
         this._videoViewer = new VideoViewer();
         this._transition = new WipeTransition();
         this._stageSelect = new StageSelect();
         this._soundMan = new SoundManager();
         this._menu = new UnstoppableMenuPages();
         this._qualityManager = new QualityManager();
         this._debugLayer = new Sprite();
         this._gameTime = 1;
         if(this._stats)
         {
            this._stats.y = GAME_HEIGHT - 20;
         }
         this._highscoresSystem = new HighscoresSystem();
         this._apeDisplay.alpha = 0.5;
         this._stageSelect.visible = false;
         this.hit.alpha = 0;
         this.hit.mouseChildren = false;
         this.initBeforeLevel();
         this.initLevel();
         this.initAfterLevel();
         this._state = GameState.INIT;
         this._delay = GAME_FRAMERATE * 2;
         this._menu.gotoAndStop(UnstoppableMenuPages.START);
         this.hit.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownEvent);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUpEvent);
         addEventListener(Event.ENTER_FRAME,this.gameLoop,false,0,true);
         stage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUpEvent);
         this._videoViewer.addEventListener(Event.COMPLETE,this.onVideoFinished);
         this._transition.addEventListener("hidden",this.onScreenHiddenByTransition,false,0,true);
         addEventListener(Event.ENTER_FRAME,this.checkTrackerReady,false,0,true);
         Tracker.init(952,root);
      }
      
      public function backToStartTriggeredByUser() : void
      {
         this.reset();
         --CURRENT_LEVEL;
         this.nextLevel();
         this.menu.gotoAndStop(UnstoppableMenuPages.BLANK);
      }
      
      private function onAddedToStageEvent(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStageEvent);
         this.init();
      }
      
      public function mainMenuTriggeredByUser() : void
      {
         this.reset();
         this._menu.gotoAndStop(UnstoppableMenuPages.START);
      }
      
      public function accost2(param1:int, param2:Point) : void
      {
         this.levelStatistics.totalCost += param1;
         this.particleEngine.spawnCostParticle(param2,param1);
      }
      
      private function checkBrushPositionOnMouseUp() : void
      {
         var _loc1_:Number = this._currentLevel.exit.x - this._brush.x;
         var _loc2_:Number = this._currentLevel.exit.y - this._brush.y;
         var _loc3_:Number = Number(Math.sqrt(Math.pow(_loc1_,2) + Math.pow(_loc2_,2)));
         if(_loc3_ < this._currentLevel.exit.radius)
         {
            this.onTargetReached();
         }
      }
      
      public function removeParticle(param1:AbstractParticle) : void
      {
         this._defaultGroup.removeParticle(param1);
      }
      
      protected function clearLevel() : void
      {
         if(Boolean(this._brushCanvas) && Boolean(this._brushCanvas.parent))
         {
            this._brushCanvas.parent.removeChild(this._brushCanvas);
         }
         if(WORLD_OBJECTS)
         {
            WORLD_OBJECTS.forEach(this.killWorldObject);
         }
         if(this._currentLevel)
         {
            this._currentLevel.die();
         }
         if(this._defaultGroup)
         {
            APEngine.removeGroup(this._defaultGroup);
         }
         if(this._trackBuilder)
         {
            this._trackBuilder.die();
         }
         if(this._brush)
         {
            this._brush.die();
         }
         if(this.trainSystem)
         {
            this.trainSystem.die();
         }
         if(this._brushCanvas)
         {
            this._brushCanvas.clear();
         }
         if(this._animateScreen)
         {
            this._animateScreen.die();
         }
         Lookup.clear(true);
         if(this._brushCanvasAlphaTween)
         {
            this._brushCanvasAlphaTween.obj = null;
         }
         if(Boolean(this.hud) && Boolean(this.hud.parent))
         {
            this.hud.parent.removeChild(this.hud);
         }
         if(this._bgMusic)
         {
            this._bgMusic.stopFade();
            this._bgMusic.die();
         }
         this.soundMan.die();
         GarbageUtil.kill(this._levelContainer);
         GarbageUtil.kill(this._trainContainer);
         this._bgMusic = null;
         this._defaultGroup = null;
         this._trainSystem = null;
         this._trackData = null;
         this._currentLevel = null;
         WORLD_OBJECTS = null;
         UPDATEABLES = null;
         this._warningSound = null;
         this._brushCanvasAlphaTween = null;
         if(Boolean(this._levelContainer) && Boolean(this._levelContainer.parent))
         {
            this._levelContainer.parent.removeChild(this._levelContainer);
         }
      }
      
      private function initAfterLevel() : void
      {
         var _loc1_:Point = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         this._brush = new BrushSprite();
         this._animateScreen = new AnimateScreen();
         this._trackBuilder = new TrackBuilder(this._animateScreen.drawingEngine.nodeData,this._trainContainer);
         if(this._currentLevel.entrance)
         {
            this._brush.positionAt(this._currentLevel.entrance);
            _loc1_ = new Point(this._currentLevel.entrance.x,this._currentLevel.entrance.y);
            _loc2_ = this._currentLevel.entrance.rotation / 180 * Math.PI;
            _loc3_ = 30;
            _loc4_ = -_loc3_ * 3;
            _loc1_.x += Math.cos(_loc2_) * _loc4_;
            _loc1_.y += Math.sin(_loc2_) * _loc4_;
            this._trackData.add(new TimePoint(_loc1_.x,_loc1_.y,this.gameTime));
            _loc1_.x += Math.cos(_loc2_) * _loc3_;
            _loc1_.y += Math.sin(_loc2_) * _loc3_;
            this._trackData.add(new TimePoint(_loc1_.x,_loc1_.y,this.gameTime));
         }
         else
         {
            trace("missing level entrance");
         }
         this._trackData.add(new TimePoint(this._brush.x,this._brush.y,this.gameTime));
         this._trackData.add(new TimePoint(this._brush.x,this._brush.y,this.gameTime));
         this._trackData.add(new TimePoint(this._brush.x,this._brush.y,this.gameTime));
         this._brushCanvas.moveTo(this._brush.x,this._brush.y);
         this.addChildren();
         this._levelStatistics.exitRadius = this.currentLevel.exit.radius;
      }
      
      private function disableBrush() : void
      {
         this._drawingEnabled = false;
         this.brush.visible = false;
      }
      
      private function transitionAfterLevel() : void
      {
         this._state = GameState.TRANSITION;
         this._stageSelect.visible = true;
         this._stageSelect.animateOut();
      }
      
      public function get drawingEnabled() : Boolean
      {
         return this._drawingEnabled;
      }
      
      public function playGame() : void
      {
         this._stageSelect.visible = false;
         this._started = true;
      }
      
      public function addParticle(param1:AbstractParticle) : void
      {
         this._defaultGroup.addParticle(param1);
      }
      
      public function get brush() : BrushSprite
      {
         return this._brush;
      }
      
      public function get gameStatsCollection() : LevelStatisticsCollection
      {
         return this._gameStatsCollection;
      }
      
      private function reset() : void
      {
         this._stageSelect.reset();
         this._stageSelect.setMapSection(1);
         CURRENT_LEVEL = 1;
         this._gameStatsCollection = new LevelStatisticsCollection();
      }
      
      public function get highscoresSystem() : HighscoresSystem
      {
         return this._highscoresSystem;
      }
      
      private function killWorldObject(param1:WorldObject, param2:int, param3:Array) : void
      {
         if(param1)
         {
            param1.state = WorldObjectState.BURIED;
         }
      }
      
      public function get trainSystem() : TrainSystem
      {
         return this._trainSystem;
      }
      
      protected function initLevel() : void
      {
         var _loc1_:Class = null;
         this.checkCurrentLevelValue();
         _loc1_ = getDefinitionByName(QUALIFIED_CLASS_NAME_PREFIX + CURRENT_LEVEL) as Class;
         this._currentLevel = new _loc1_();
         this._levelContainer.addChild(this._currentLevel);
         WORLD_OBJECTS.forEach(this.prepareWorldObjectForSimulation);
         APEngine.step();
         UPDATEABLES.forEach(this.updateWorldObjectBeforeAPE);
         UPDATEABLES.forEach(this.updateWorldObject);
         this.prepareForDrawing();
      }
      
      public function get menu() : UnstoppableMenuPages
      {
         return this._menu;
      }
      
      private function onScreenHiddenByTransition(param1:Event) : void
      {
      }
      
      public function addConstraint(param1:AbstractConstraint) : void
      {
         this._defaultGroup.addConstraint(param1);
      }
      
      public function get particleEngine() : ParticleEngine
      {
         return this._particleEngine;
      }
      
      private function checkTrackData() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TimePoint = null;
         var _loc4_:Array = null;
         if(Boolean(this.trackData) && this.trackData.length > 1)
         {
            _loc1_ = -1;
            _loc2_ = int(this.trackData.length - 1);
            while(_loc2_ >= 0)
            {
               _loc3_ = this.trackData.getPoint(_loc2_);
               if(this.gameTime - _loc3_.time > TRACK_RENDER_DELAY)
               {
                  _loc1_ = _loc2_;
                  break;
               }
               _loc2_--;
            }
            if(_loc1_ >= this.trackData.length - 1)
            {
               _loc1_--;
            }
            if(_loc1_ >= 0)
            {
               _loc4_ = this.trackData.removePoints(0,_loc1_);
               this._animateScreen.drawingEngine.trackData.appendPoints(_loc4_);
            }
         }
      }
      
      private function onVideoFinished(param1:Event) : void
      {
         this.menu.gotoAndStop(UnstoppableMenuPages.REGION_OVER);
         this._videoViewer.hide();
      }
      
      public function nextLevelTriggeredByUser() : void
      {
         if(CURRENT_LEVEL < 25)
         {
            this.nextLevel();
            this.menu.gotoAndStop(UnstoppableMenuPages.BLANK);
         }
         else
         {
            this.menu.gotoAndStop(UnstoppableMenuPages.GAME_COMPLETE);
         }
      }
      
      private function resetLevel() : void
      {
         --CURRENT_LEVEL;
         this._gameStatsCollection.removeLast();
         this._levelStatsCollection.removeLast();
         this._stageSelect.setMapSection(1 + Math.floor(CURRENT_LEVEL / 5));
         this._stageSelect.reset();
      }
      
      private function onLevelFinished() : void
      {
         var _loc1_:Boolean = Boolean(this.trainSystem) && this.trainSystem.isCrashing;
         if(this.levelStatistics.gross < 0)
         {
         }
         this._state = _loc1_ ? "null" : GameState.END_OF_LEVEL;
         this._delay = GAME_FRAMERATE * 3;
         if(this.trainSystem)
         {
            this.trainSystem.fadeOutSound();
         }
         this.menu.gotoAndStop(_loc1_ ? UnstoppableMenuPages.GAME_OVER : UnstoppableMenuPages.LEVEL_OVER);
         this._bgMusic.fadeTo(0,1,this._bgMusic.die);
         if(CURRENT_LEVEL == 25)
         {
            if(this.levelStatistics.gross > 0)
            {
               if(!_loc1_)
               {
                  trackEvent("game complete");
               }
            }
         }
      }
      
      public function get levelStatsCollection() : LevelStatisticsCollection
      {
         return this._levelStatsCollection;
      }
      
      public function get muted() : Boolean
      {
         return this._muted;
      }
      
      private function updateScreams() : void
      {
         var _loc1_:Vector.<Snd> = new Vector.<Snd>();
         var _loc2_:int = 0;
         while(_loc2_ < this._screams.length)
         {
            if(!this._screams[_loc2_].dead)
            {
               _loc1_.push(this._screams[_loc2_]);
            }
            _loc2_++;
         }
         this._screams = _loc1_;
      }
      
      private function checkCurrentLevelValue() : void
      {
         if(!loaderInfo.applicationDomain.hasDefinition(QUALIFIED_CLASS_NAME_PREFIX + CURRENT_LEVEL))
         {
            CURRENT_LEVEL = 1;
         }
      }
      
      private function updateStateInit() : void
      {
      }
      
      public function get started() : Boolean
      {
         return this._started;
      }
      
      private function checkTrackerReady(param1:Event) : void
      {
         if(Tracker.isReady)
         {
            param1.currentTarget.removeEventListener(param1.type,arguments.callee);
            trace("Tracker ready");
            if(TranslationEngine.instance.currentLanguage)
            {
               trackEvent("language is " + TranslationEngine.instance.currentLanguage,true);
            }
            else
            {
               trackEvent("language is default");
            }
         }
      }
      
      public function removeParticles(param1:Array) : void
      {
         APEUtil.removeParticlesFromGroup(this._defaultGroup,param1);
      }
      
      private function nextLevel() : void
      {
         ++CURRENT_LEVEL;
         this.checkCurrentLevelValue();
         this.clearLevel();
         this.initBeforeLevel();
         this.initLevel();
         this.initAfterLevel();
         this.transitionBeforeLevel();
      }
      
      public function onTransitionInFinished() : void
      {
         this._stageSelect.visible = false;
         this._state = GameState.WAIT;
         this._delay = GAME_FRAMERATE / 4;
         this._bgMusic = this.soundMan.loopSound(UnstoppableSounds.MUSIC_BG,0);
         this._bgMusic.fadeTo(1,2);
      }
      
      public function get state() : String
      {
         return this._state;
      }
      
      protected function get trackData() : TrackData
      {
         return this._trackData;
      }
      
      private function doStart() : void
      {
         this._state = GameState.DRAWING;
         this._started = true;
         trackEvent("start level " + CURRENT_LEVEL);
      }
      
      public function prepareForDrawing() : void
      {
         this._successDistance = NaN;
         WORLD_OBJECTS.forEach(this.prepareWorldObjectForDrawing);
      }
      
      private function onKeyUpEvent(param1:KeyboardEvent) : void
      {
         switch(param1.keyCode)
         {
            case 107:
               this.onDebug1();
               break;
            case 109:
               this.onDebug2();
         }
      }
      
      public function get currentLevel() : Level
      {
         return this._currentLevel;
      }
      
      public function personScream(param1:WorldObject) : void
      {
         var _loc2_:Snd = null;
         if(this.trainSystem.isCrashing)
         {
            return;
         }
         if(this._screams.length < 2)
         {
            this._screams.push(_loc2_ = this.soundMan.playSound(UnstoppableSounds.SCREAMS,0.5));
            _loc2_.pan = (param1.x - GAME_WIDTH / 2) / GAME_WIDTH;
         }
      }
      
      private function prepareWorldObjectForDrawing(param1:WorldObject, param2:int, param3:Array) : void
      {
         param1.prepareForDrawing();
      }
      
      private function updateStateSimulation() : void
      {
         var _loc1_:PubeBomb = null;
         this.updateScreams();
         if(this._debugLayer)
         {
            this._debugLayer.graphics.clear();
         }
         this.checkTrackData();
         this.brush.updateBeforeAPE();
         UPDATEABLES.forEach(this.updateWorldObjectBeforeAPE);
         if(this._trainSystem)
         {
            this._trainSystem.updateBeforeAPE();
         }
         if(!this._trainSystem.isCrashing)
         {
            this._trackBuilder.updateBeforeAPE();
         }
         APEngine.step();
         if(DRAW_APE)
         {
            APEngine.paint();
         }
         this.updateBrush();
         UPDATEABLES.forEach(this.updateWorldObject);
         if(this._trainSystem)
         {
            this._trainSystem.update();
         }
         this._trackBuilder.update();
         this._animateScreen.update();
         if(this._trainSystem.isCrashing)
         {
            if(this._particleEngine.epicExplosion)
            {
               _loc1_ = this._particleEngine.epicExplosion;
               if(_loc1_.state == WorldObjectState.DYING)
               {
                  this.destroyAllWithinRange(new Point(_loc1_.x,_loc1_.y),_loc1_.radius);
               }
            }
         }
         ++this._gameTime;
         this.hud.update();
         if(this.trainSystem.reachedEndOfLine)
         {
            this.onLevelFinished();
         }
      }
      
      public function onTransitionOutFinished() : void
      {
         this._stageSelect.setMapSection(1 + Math.floor(CURRENT_LEVEL / 5));
         if(CURRENT_LEVEL % 5 == 0)
         {
            this.clearLevel();
            this._videoViewer.show();
         }
         else
         {
            this.nextLevel();
         }
      }
      
      public function get animateScreen() : AnimateScreen
      {
         return this._animateScreen;
      }
      
      private function drawCanvas(param1:Point) : void
      {
         this._brushCanvas.lineTo(param1.x,param1.y);
      }
      
      private function gameLoop(param1:Event) : void
      {
         switch(this.state)
         {
            case GameState.INIT:
               this.updateStateInit();
               break;
            case GameState.DRAWING:
               this.updateStateDrawing();
               break;
            case GameState.SIMULATION:
               this.updateStateSimulation();
               break;
            case GameState.END_OF_LEVEL:
               this.updateStateEndOfLevel();
               break;
            case GameState.WAIT:
               this.updateStateWait();
               break;
            case GameState.ABOUT_TO_CRASH:
               this.updateStateAboutToCrash();
         }
      }
      
      public function get debugLayer() : Sprite
      {
         return this._debugLayer;
      }
      
      private function transitionBeforeLevel() : void
      {
         this._state = GameState.TRANSITION;
         this._stageSelect.visible = true;
         this._started = false;
         this._stageSelect.animateIn();
      }
      
      public function earlyWarning() : void
      {
         if(!this._warningSound)
         {
            this._warningSound = this.soundMan.playSound(UnstoppableSounds.START,1,4);
         }
      }
      
      private function onMouseDownEvent(param1:MouseEvent) : void
      {
         this._mouseIsDown = true;
      }
      
      public function get display() : Sprite
      {
         return this._display = this._display || new Sprite();
      }
      
      public function onTrainCrash(param1:Array = null) : void
      {
         var _loc2_:WorldObject = null;
         var _loc4_:WorldObject = null;
         var _loc6_:int = 0;
         this._state = GameState.ABOUT_TO_CRASH;
         this._delay = GAME_FRAMERATE;
         var _loc3_:Number = Number(Number.MAX_VALUE);
         if(param1)
         {
            _loc6_ = 0;
            while(_loc6_ < param1.length)
            {
               _loc2_ = param1[_loc6_];
               if(_loc2_.size < _loc3_)
               {
                  _loc3_ = _loc2_.size;
                  _loc4_ = _loc2_;
               }
               _loc6_++;
            }
         }
         if(!_loc4_)
         {
            _loc4_ = this.trainSystem.train;
         }
         var _loc5_:RingOfDeath;
         (_loc5_ = new RingOfDeath()).x = _loc4_.x;
         _loc5_.y = _loc4_.y;
         this._trainContainer.addChild(_loc5_);
         this.brush.visible = false;
         this.levelStatistics.crashed = true;
      }
      
      public function get numParticles() : int
      {
         return !!this._defaultGroup ? (!!this._defaultGroup.particles ? int(this._defaultGroup.particles.length) : 0) : 0;
      }
      
      public function get soundMan() : SoundManager
      {
         return this._soundMan;
      }
      
      public function get levelStatistics() : LevelStatistics
      {
         return this._levelStatistics;
      }
      
      private function addChildren() : void
      {
         addChild(this.display);
         this.display.addChild(this._levelContainer);
         this._currentLevel.trackDisplay.addChild(this._brushCanvas);
         this._currentLevel.trackDisplay.addChild(this._animateScreen);
         this.display.addChild(this._trainContainer);
         this.display.addChild(this._brush);
         if(DRAW_APE)
         {
            this.display.addChild(this._apeDisplay);
         }
         if(this.vignette)
         {
            addChild(this.vignette);
         }
         addChild(this.hit);
         addChild(this.hud);
         addChild(this._debugLayer);
         addChild(this._stageSelect);
         addChild(this._videoViewer);
         addChild(this._menu);
         addChild(this._transition);
         if(this._stats)
         {
            addChild(this._stats);
         }
         if(this._qualityManager)
         {
            addChild(this._qualityManager);
         }
      }
      
      public function get trackBuilder() : TrackBuilder
      {
         return this._trackBuilder;
      }
      
      private function destroyAllWithinRange(param1:Point, param2:Number) : void
      {
         var _loc3_:WorldObject = null;
         var _loc4_:Point = null;
         var _loc5_:int = 0;
         while(_loc5_ < WORLD_OBJECTS.length)
         {
            _loc3_ = WORLD_OBJECTS[_loc5_];
            if((_loc4_ = _loc3_.position.subtract(param1)).length <= param2)
            {
               if(_loc3_.state == WorldObjectState.ALIVE)
               {
                  _loc3_.destroy(this.particleEngine.epicExplosion);
               }
            }
            _loc5_++;
         }
      }
      
      public function playGameTriggeredByUser() : void
      {
         switch(this.state)
         {
            case GameState.INIT:
               this.menu.gotoAndStop(UnstoppableMenuPages.BLANK);
               this.transitionBeforeLevel();
               break;
            default:
               GAME_START = true;
               this.playAgainTriggeredByUser();
         }
      }
      
      public function playAgainTriggeredByUser() : void
      {
         this.resetLevel();
         this.nextLevel();
         this.menu.gotoAndStop(UnstoppableMenuPages.BLANK);
      }
      
      public function set muted(param1:Boolean) : void
      {
         this._muted = param1;
         var _loc2_:SoundTransform = new SoundTransform(1,0);
         _loc2_.volume = this._muted ? 0 : 1;
         SoundMixer.soundTransform = _loc2_;
         this.soundMan.mute = this._muted;
         if(this.muted)
         {
            Engine.trackEvent("user muted game",true);
         }
      }
      
      public function get gameTime() : int
      {
         return this._gameTime;
      }
      
      private function onMouseUpEvent(param1:MouseEvent) : void
      {
         this._mouseIsDown = false;
         switch(this.state)
         {
            case GameState.DRAWING:
            case GameState.SIMULATION:
               this.checkBrushPositionOnMouseUp();
         }
      }
      
      private function onTargetReached() : void
      {
         if(this._target)
         {
            return;
         }
         var _loc1_:DisplayObject = this._currentLevel.exit;
         var _loc2_:Point = new Point(_loc1_.x,_loc1_.y);
         var _loc3_:Number = _loc1_.rotation / 180 * Math.PI;
         var _loc4_:Number = 300;
         _loc2_.x += Math.cos(_loc3_) * _loc4_;
         _loc2_.y += Math.sin(_loc3_) * _loc4_;
         this._target = _loc2_;
         this.levelStatistics.timeLeft = this.hud.timebar.value;
         this.levelStatistics.reachedExit = true;
      }
      
      private function updateStateDrawing() : void
      {
         this.updateScreams();
         this.checkTrackData();
         this.brush.updateBeforeAPE();
         this._trackBuilder.updateBeforeAPE();
         UPDATEABLES.forEach(this.updateWorldObjectBeforeAPE);
         APEngine.step();
         if(DRAW_APE)
         {
            APEngine.paint();
         }
         this.updateBrush();
         this.checkBrushPosition();
         UPDATEABLES.forEach(this.updateWorldObject);
         this._trackBuilder.update();
         this._animateScreen.update();
         this.hud.update();
         if(this.hud.timebar.value == 0 && !this._trainSystem)
         {
            this.prepareForSimulation();
         }
         ++this._gameTime;
      }
      
      private function updateStateWait() : void
      {
         if(this._delay > 0)
         {
            --this._delay;
            if(this._delay <= 0)
            {
               this.doStart();
            }
         }
      }
      
      protected function onTrainCrashWaitFinished() : void
      {
         this._state = GameState.SIMULATION;
         this.display.addChild(this._brushCanvas);
         this._brushCanvas.alpha = 0;
         this._brushCanvasAlphaTween = new Tween(this._brushCanvas,"alpha",null,-0.5,1,GAME_FRAMERATE * 4);
         if(this._trackBuilder)
         {
            this._trackBuilder.crash();
         }
         this.soundMan.playSound(UnstoppableSounds.DERAIL);
      }
      
      public function prepareForSimulation() : void
      {
         this._state = GameState.SIMULATION;
         this._trainSystem = new TrainSystem(this._animateScreen.drawingEngine.nodeData,this._trainContainer);
         WORLD_OBJECTS.forEach(this.prepareWorldObjectForSimulation);
         this.brush.prepareForSimulation();
         this.trackBuilder.prepareForSimulation();
         this._bgMusic.fadeTo(0,0.2);
      }
      
      private function onTransitionComplete(param1:Event) : void
      {
         this._started = true;
      }
      
      public function accost(param1:WorldObject) : void
      {
         this.accost2(param1.cost,param1.position);
      }
      
      public function get mouseIsDown() : Boolean
      {
         return this._mouseIsDown;
      }
      
      private function initAPE() : void
      {
         APEngine.init();
         APEngine.container = this._apeDisplay;
         APEngine.constraintCollisionCycles = 1;
         this._defaultGroup = new Group(true);
         APEngine.addGroup(this._defaultGroup);
      }
      
      public function onTransitionInAlmostFinished() : void
      {
         this.menu.gotoAndStop(UnstoppableMenuPages.LEVEL_START);
      }
      
      private function updateStateEndOfLevel() : void
      {
         if(this.levelStatistics.gross < 0)
         {
            if(this._delay > 0)
            {
               --this._delay;
            }
            else
            {
               this._state = "null";
               this.menu.gotoAndStop(UnstoppableMenuPages.GAME_OVER);
            }
            return;
         }
         if(this._delay == 10)
         {
            if(CURRENT_LEVEL % 5 == 0)
            {
               this._transition.show();
            }
         }
         if(this._delay > 0)
         {
            --this._delay;
         }
         else
         {
            this._state = "null";
            this.menu.gotoAndStop(UnstoppableMenuPages.BLANK);
            this.transitionAfterLevel();
         }
      }
      
      public function get currentLevelNum() : int
      {
         return CURRENT_LEVEL;
      }
      
      private function onDebug1() : void
      {
         this.onLevelFinished();
      }
      
      private function onDebug2() : void
      {
         var _loc1_:Number = 2;
         stage.frameRate = stage.frameRate == _loc1_ ? GAME_FRAMERATE : _loc1_;
      }
   }
}
