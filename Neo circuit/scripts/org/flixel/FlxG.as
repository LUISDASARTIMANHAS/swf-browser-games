package org.flixel
{
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import org.flixel.plugin.DebugPathDisplay;
   import org.flixel.plugin.TimerManager;
   import org.flixel.system.FlxQuadTree;
   import org.flixel.system.input.*;
   
   public class FlxG
   {
      
      public static var LIBRARY_NAME:String = "flixel";
      
      public static var LIBRARY_MAJOR_VERSION:uint = 2;
      
      public static var LIBRARY_MINOR_VERSION:uint = 50;
      
      public static const DEBUGGER_STANDARD:uint = 0;
      
      public static const DEBUGGER_MICRO:uint = 1;
      
      public static const DEBUGGER_BIG:uint = 2;
      
      public static const DEBUGGER_TOP:uint = 3;
      
      public static const DEBUGGER_LEFT:uint = 4;
      
      public static const DEBUGGER_RIGHT:uint = 5;
      
      public static const RED:uint = 4294901778;
      
      public static const GREEN:uint = 4278252069;
      
      public static const BLUE:uint = 4278227177;
      
      public static const PINK:uint = 4293926655;
      
      public static const WHITE:uint = 4294967295;
      
      public static const BLACK:uint = 4278190080;
      
      internal static var _game:FlxGame;
      
      public static var paused:Boolean;
      
      public static var debug:Boolean;
      
      public static var elapsed:Number;
      
      public static var timeScale:Number;
      
      public static var width:uint;
      
      public static var height:uint;
      
      public static var worldBounds:FlxRect;
      
      public static var worldDivisions:uint;
      
      public static var visualDebug:Boolean;
      
      public static var mobile:Boolean;
      
      public static var globalSeed:Number;
      
      public static var levels:Array;
      
      public static var level:int;
      
      public static var scores:Array;
      
      public static var score:int;
      
      public static var saves:Array;
      
      public static var save:int;
      
      public static var mouse:Mouse;
      
      public static var keys:Keyboard;
      
      public static var music:FlxSound;
      
      public static var sounds:FlxGroup;
      
      public static var mute:Boolean;
      
      protected static var _volume:Number;
      
      public static var cameras:Array;
      
      public static var camera:FlxCamera;
      
      public static var useBufferLocking:Boolean;
      
      protected static var _cameraRect:Rectangle;
      
      public static var plugins:Array;
      
      public static var volumeHandler:Function;
      
      public static var flashGfxSprite:Sprite;
      
      public static var flashGfx:Graphics;
      
      protected static var _cache:Object;
       
      
      public function FlxG()
      {
         super();
      }
      
      public static function getLibraryName() : String
      {
         return FlxG.LIBRARY_NAME + " v" + FlxG.LIBRARY_MAJOR_VERSION + "." + FlxG.LIBRARY_MINOR_VERSION;
      }
      
      public static function log(param1:Object) : void
      {
         if(_game != null && _game._debugger != null)
         {
            _game._debugger.log.add(param1 == null ? "ERROR: null object" : String(param1.toString()));
         }
      }
      
      public static function watch(param1:Object, param2:String, param3:String = null) : void
      {
         if(_game != null && _game._debugger != null)
         {
            _game._debugger.watch.add(param1,param2,param3);
         }
      }
      
      public static function unwatch(param1:Object, param2:String = null) : void
      {
         if(_game != null && _game._debugger != null)
         {
            _game._debugger.watch.remove(param1,param2);
         }
      }
      
      public static function get framerate() : Number
      {
         return 1000 / _game._step;
      }
      
      public static function set framerate(param1:Number) : void
      {
         _game._step = 1000 / param1;
         if(_game._maxAccumulation < _game._step)
         {
            _game._maxAccumulation = _game._step;
         }
      }
      
      public static function get flashFramerate() : Number
      {
         if(_game.root != null)
         {
            return _game.stage.frameRate;
         }
         return 0;
      }
      
      public static function set flashFramerate(param1:Number) : void
      {
         _game._flashFramerate = param1;
         if(_game.root != null)
         {
            _game.stage.frameRate = _game._flashFramerate;
         }
         _game._maxAccumulation = 2000 / _game._flashFramerate - 1;
         if(_game._maxAccumulation < _game._step)
         {
            _game._maxAccumulation = _game._step;
         }
      }
      
      public static function random() : Number
      {
         return globalSeed = FlxU.srand(globalSeed);
      }
      
      public static function shuffle(param1:Array, param2:uint) : Array
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:Object = null;
         var _loc3_:uint = 0;
         while(_loc3_ < param2)
         {
            _loc4_ = FlxG.random() * param1.length;
            _loc5_ = FlxG.random() * param1.length;
            _loc6_ = param1[_loc5_];
            param1[_loc5_] = param1[_loc4_];
            do
            {
               param1[_loc4_] = _loc6_;
               _loc3_++;
            }
            while(false);
            
         }
         return param1;
      }
      
      public static function getRandom(param1:Array) : Object
      {
         var _loc2_:uint = 0;
         if(param1 != null)
         {
            _loc2_ = param1.length;
            if(_loc2_ > 0)
            {
               return param1[uint(FlxG.random() * _loc2_)];
            }
         }
         return null;
      }
      
      public static function loadReplay(param1:String, param2:FlxState = null, param3:Array = null, param4:Number = 0, param5:Function = null) : void
      {
         _game._replay.load(param1);
         if(param2 == null)
         {
            FlxG.resetGame();
         }
         else
         {
            FlxG.switchState(param2);
         }
         _game._replayCancelKeys = param3;
         _game._replayTimer = param4 * 1000;
         _game._replayCallback = param5;
         _game._replayRequested = true;
      }
      
      public static function reloadReplay(param1:Boolean = true) : void
      {
         if(param1)
         {
            FlxG.resetGame();
         }
         else
         {
            FlxG.resetState();
         }
         if(_game._replay.frameCount > 0)
         {
            _game._replayRequested = true;
         }
      }
      
      public static function stopReplay() : void
      {
         _game._replaying = false;
         if(_game._debugger != null)
         {
            _game._debugger.vcr.stopped();
         }
         resetInput();
      }
      
      public static function recordReplay(param1:Boolean = true) : void
      {
         if(param1)
         {
            FlxG.resetGame();
         }
         else
         {
            FlxG.resetState();
         }
         _game._recordingRequested = true;
      }
      
      public static function stopRecording() : String
      {
         _game._recording = false;
         if(_game._debugger != null)
         {
            _game._debugger.vcr.stopped();
         }
         return _game._replay.save();
      }
      
      public static function resetState() : void
      {
         _game._requestedState = new (FlxU.getClass(FlxU.getClassName(_game._state,false)))();
      }
      
      public static function resetGame() : void
      {
         _game._requestedReset = true;
      }
      
      public static function resetInput() : void
      {
         keys.reset();
         mouse.reset();
      }
      
      public static function playMusic(param1:Class, param2:Number = 1) : void
      {
         if(music == null)
         {
            music = new FlxSound();
         }
         else if(music.active)
         {
            music.stop();
         }
         music.loadEmbedded(param1,true);
         music.volume = param2;
         music.survive = true;
         music.play();
      }
      
      public static function play(param1:Class, param2:Number = 1, param3:Boolean = false) : FlxSound
      {
         var _loc4_:FlxSound;
         (_loc4_ = sounds.recycle(FlxSound) as FlxSound).loadEmbedded(param1,param3);
         _loc4_.volume = param2;
         _loc4_.play();
         return _loc4_;
      }
      
      public static function stream(param1:String, param2:Number = 1, param3:Boolean = false) : FlxSound
      {
         var _loc4_:FlxSound;
         (_loc4_ = sounds.recycle(FlxSound) as FlxSound).loadStream(param1,param3);
         _loc4_.volume = param2;
         _loc4_.play();
         return _loc4_;
      }
      
      public static function get volume() : Number
      {
         return _volume;
      }
      
      public static function set volume(param1:Number) : void
      {
         _volume = param1;
         if(_volume < 0)
         {
            _volume = 0;
         }
         else if(_volume > 1)
         {
            _volume = 1;
         }
         if(volumeHandler != null)
         {
            volumeHandler(FlxG.mute ? 0 : _volume);
         }
      }
      
      internal static function destroySounds(param1:Boolean = false) : void
      {
         var _loc3_:FlxSound = null;
         §§push(music != null);
         if(music != null)
         {
            §§pop();
            §§push(param1);
            if(!param1)
            {
               §§pop();
               while(true)
               {
                  §§push(!music.survive);
                  addr25:
                  music.destroy();
                  music = null;
                  if(false)
                  {
                     continue;
                  }
                  §§goto(addr43);
               }
               addr19:
            }
         }
         while(true)
         {
            if(§§pop())
            {
               §§goto(addr25);
            }
            break;
            §§goto(addr19);
         }
         addr43:
         var _loc2_:uint = 0;
         var _loc4_:uint = sounds.members.length;
         while(_loc2_ < _loc4_)
         {
            _loc3_ = sounds.members[_loc2_++] as FlxSound;
            §§push(_loc3_ != null);
            if(_loc3_ != null)
            {
               §§pop();
               while(true)
               {
                  §§push(param1 || !_loc3_.survive);
               }
               addr84:
            }
            while(§§pop())
            {
               _loc3_.destroy();
               if(true)
               {
                  break;
               }
               §§goto(addr84);
            }
         }
      }
      
      internal static function updateSounds() : void
      {
         if(music != null && music.active)
         {
            music.update();
         }
         if(sounds != null && sounds.active)
         {
            sounds.update();
         }
      }
      
      public static function pauseSounds() : void
      {
         var _loc2_:FlxSound = null;
         §§push(music != null);
         if(music != null)
         {
            §§pop();
            while(true)
            {
               §§push(music.exists);
            }
            addr23:
         }
         while(§§pop() && music.active)
         {
            music.pause();
            if(true)
            {
               break;
            }
            §§goto(addr23);
         }
         var _loc1_:uint = 0;
         var _loc3_:uint = sounds.members.length;
         while(_loc1_ < _loc3_)
         {
            _loc2_ = sounds.members[_loc1_++] as FlxSound;
            §§push(_loc2_ != null);
            if(_loc2_ != null)
            {
               §§pop();
               while(true)
               {
                  §§push(_loc2_.exists);
               }
               addr81:
            }
            while(§§pop() && _loc2_.active)
            {
               _loc2_.pause();
               if(true)
               {
                  break;
               }
               §§goto(addr81);
            }
         }
      }
      
      public static function playSounds() : void
      {
         var _loc2_:FlxSound = null;
         if(music != null && music.exists)
         {
            music.play();
         }
         var _loc1_:uint = 0;
         var _loc3_:uint = sounds.members.length;
         while(_loc1_ < _loc3_)
         {
            _loc2_ = sounds.members[_loc1_++] as FlxSound;
            if(_loc2_ != null && _loc2_.exists)
            {
               _loc2_.play();
            }
         }
      }
      
      public static function checkBitmapCache(param1:String) : Boolean
      {
         return _cache[param1] != undefined && _cache[param1] != null;
      }
      
      public static function createBitmap(param1:uint, param2:uint, param3:uint, param4:Boolean = false, param5:String = null) : BitmapData
      {
         var _loc6_:uint = 0;
         var _loc7_:String = null;
         if(param5 == null)
         {
            param5 = param1 + "x" + param2 + ":" + param3;
            if(param4 && checkBitmapCache(param5))
            {
               _loc6_ = 0;
               do
               {
                  _loc7_ = param5 + _loc6_++;
               }
               while(checkBitmapCache(_loc7_));
               
               param5 = _loc7_;
            }
         }
         if(!checkBitmapCache(param5))
         {
            _cache[param5] = new BitmapData(param1,param2,true,param3);
         }
         return _cache[param5];
      }
      
      public static function addBitmap(param1:Class, param2:Boolean = false, param3:Boolean = false, param4:String = null) : BitmapData
      {
         var _loc7_:uint = 0;
         var _loc8_:String = null;
         var _loc9_:BitmapData = null;
         var _loc10_:Matrix = null;
         var _loc5_:Boolean = false;
         if(param4 == null)
         {
            param4 = String(param1) + (param2 ? "_REVERSE_" : "");
            if(param3 && checkBitmapCache(param4))
            {
               _loc7_ = 0;
               do
               {
                  _loc8_ = param4 + _loc7_++;
               }
               while(checkBitmapCache(_loc8_));
               
               param4 = _loc8_;
            }
         }
         while(!checkBitmapCache(param4))
         {
            _cache[param4] = new param1().bitmapData;
            if(!param2)
            {
               break;
            }
            _loc5_ = true;
            if(true)
            {
               break;
            }
         }
         var _loc6_:BitmapData = _cache[param4];
         §§push(!_loc5_);
         if(!_loc5_)
         {
            §§pop();
            while(true)
            {
               §§push(param2);
            }
            addr128:
         }
         while(§§pop() && _loc6_.width == new param1().bitmapData.width)
         {
            _loc5_ = true;
            if(true)
            {
               break;
            }
            §§goto(addr128);
         }
         if(_loc5_)
         {
            (_loc9_ = new BitmapData(_loc6_.width << 1,_loc6_.height,true,0)).draw(_loc6_);
            (_loc10_ = new Matrix()).scale(-1,1);
            _loc10_.translate(_loc9_.width,0);
            _loc9_.draw(_loc6_,_loc10_);
            _loc6_ = _loc9_;
         }
         return _loc6_;
      }
      
      public static function clearBitmapCache() : void
      {
         _cache = new Object();
      }
      
      public static function get stage() : Stage
      {
         if(_game.root != null)
         {
            return _game.stage;
         }
         return null;
      }
      
      public static function get state() : FlxState
      {
         return _game._state;
      }
      
      public static function switchState(param1:FlxState) : void
      {
         _game._requestedState = param1;
      }
      
      public static function setDebuggerLayout(param1:uint) : void
      {
         if(_game._debugger != null)
         {
            _game._debugger.setLayout(param1);
         }
      }
      
      public static function resetDebuggerLayout() : void
      {
         if(_game._debugger != null)
         {
            _game._debugger.resetLayout();
         }
      }
      
      public static function addCamera(param1:FlxCamera) : FlxCamera
      {
         FlxG._game.addChildAt(param1._flashBitmap,FlxG._game.getChildIndex(FlxG._game._mouse));
         FlxG.cameras.push(param1);
         return param1;
      }
      
      public static function resetCameras(param1:FlxCamera = null) : void
      {
         var _loc2_:FlxCamera = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = cameras.length;
         while(_loc3_ < _loc4_)
         {
            _loc2_ = FlxG.cameras[_loc3_++] as FlxCamera;
            FlxG._game.removeChild(_loc2_._flashBitmap);
            _loc2_.destroy();
         }
         FlxG.cameras.length = 0;
         if(param1 == null)
         {
            param1 = new FlxCamera(0,0,FlxG.width,FlxG.height);
         }
         FlxG.camera = FlxG.addCamera(param1);
      }
      
      public static function flash(param1:uint = 4294967295, param2:Number = 1, param3:Function = null, param4:Boolean = false) : void
      {
         var _loc5_:uint = 0;
         var _loc6_:uint = FlxG.cameras.length;
         while(_loc5_ < _loc6_)
         {
            (FlxG.cameras[_loc5_++] as FlxCamera).flash(param1,param2,param3,param4);
         }
      }
      
      public static function fade(param1:uint = 4294967295, param2:Number = 1, param3:Function = null, param4:Boolean = false) : void
      {
         var _loc5_:uint = 0;
         var _loc6_:uint = FlxG.cameras.length;
         while(_loc5_ < _loc6_)
         {
            (FlxG.cameras[_loc5_++] as FlxCamera).fade(param1,param2,param3,param4);
         }
      }
      
      public static function shake(param1:Number = 0.05, param2:Number = 0.5, param3:Function = null, param4:Boolean = true, param5:uint = 0) : void
      {
         var _loc6_:uint = 0;
         var _loc7_:uint = FlxG.cameras.length;
         while(_loc6_ < _loc7_)
         {
            (FlxG.cameras[_loc6_++] as FlxCamera).shake(param1,param2,param3,param4,param5);
         }
      }
      
      public static function get bgColor() : uint
      {
         if(FlxG.camera == null)
         {
            return 4278190080;
         }
         return FlxG.camera.bgColor;
      }
      
      public static function set bgColor(param1:uint) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = FlxG.cameras.length;
         while(_loc2_ < _loc3_)
         {
            (FlxG.cameras[_loc2_++] as FlxCamera).bgColor = param1;
         }
      }
      
      public static function overlap(param1:FlxBasic = null, param2:FlxBasic = null, param3:Function = null, param4:Function = null) : Boolean
      {
         if(param1 == null)
         {
            param1 = FlxG.state;
         }
         if(param2 === param1)
         {
            param2 = null;
         }
         FlxQuadTree.divisions = FlxG.worldDivisions;
         var _loc5_:FlxQuadTree;
         (_loc5_ = new FlxQuadTree(FlxG.worldBounds.x,FlxG.worldBounds.y,FlxG.worldBounds.width,FlxG.worldBounds.height)).load(param1,param2,param3,param4);
         var _loc6_:Boolean = _loc5_.execute();
         _loc5_.destroy();
         return _loc6_;
      }
      
      public static function collide(param1:FlxBasic = null, param2:FlxBasic = null, param3:Function = null) : Boolean
      {
         return overlap(param1,param2,param3,FlxObject.separate);
      }
      
      public static function addPlugin(param1:FlxBasic) : FlxBasic
      {
         var _loc2_:Array = FlxG.plugins;
         var _loc3_:uint = 0;
         var _loc4_:uint = _loc2_.length;
         while(_loc3_ < _loc4_)
         {
            if(_loc2_[_loc3_++].toString() == param1.toString())
            {
               return param1;
            }
         }
         _loc2_.push(param1);
         return param1;
      }
      
      public static function getPlugin(param1:Class) : FlxBasic
      {
         var _loc2_:Array = FlxG.plugins;
         var _loc3_:uint = 0;
         var _loc4_:uint = _loc2_.length;
         while(_loc3_ < _loc4_)
         {
            if(_loc2_[_loc3_++] is param1)
            {
               return plugins[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
      
      public static function removePlugin(param1:FlxBasic) : FlxBasic
      {
         var _loc2_:Array = FlxG.plugins;
         var _loc3_:int = int(_loc2_.length - 1);
         while(_loc3_ >= 0)
         {
            if(_loc2_[_loc3_] == param1)
            {
               _loc2_.splice(_loc3_,1);
            }
            _loc3_--;
         }
         return param1;
      }
      
      public static function removePluginType(param1:Class) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:Array = FlxG.plugins;
         var _loc4_:int = int(_loc3_.length - 1);
         while(_loc4_ >= 0)
         {
            if(_loc3_[_loc4_] is param1)
            {
               _loc3_.splice(_loc4_,1);
               _loc2_ = true;
            }
            _loc4_--;
         }
         return _loc2_;
      }
      
      internal static function init(param1:FlxGame, param2:uint, param3:uint, param4:Number) : void
      {
         FlxG._game = param1;
         FlxG.width = param2;
         FlxG.height = param3;
         FlxG.mute = false;
         FlxG._volume = 0.5;
         FlxG.sounds = new FlxGroup();
         FlxG.volumeHandler = null;
         FlxG.clearBitmapCache();
         if(flashGfxSprite == null)
         {
            flashGfxSprite = new Sprite();
            flashGfx = flashGfxSprite.graphics;
         }
         FlxCamera.defaultZoom = param4;
         FlxG._cameraRect = new Rectangle();
         FlxG.cameras = new Array();
         useBufferLocking = false;
         plugins = new Array();
         addPlugin(new DebugPathDisplay());
         addPlugin(new TimerManager());
         FlxG.mouse = new Mouse(FlxG._game._mouse);
         FlxG.keys = new Keyboard();
         FlxG.mobile = false;
         FlxG.levels = new Array();
         FlxG.scores = new Array();
         FlxG.visualDebug = false;
      }
      
      internal static function reset() : void
      {
         FlxG.clearBitmapCache();
         FlxG.resetInput();
         FlxG.destroySounds(true);
         FlxG.levels.length = 0;
         FlxG.scores.length = 0;
         FlxG.level = 0;
         FlxG.score = 0;
         FlxG.paused = false;
         FlxG.timeScale = 1;
         FlxG.elapsed = 0;
         FlxG.globalSeed = Math.random();
         do
         {
            FlxG.worldBounds = new FlxRect(-10,-10,FlxG.width + 20,FlxG.height + 20);
            FlxG.worldDivisions = 6;
         }
         while(false);
         
         var _loc1_:DebugPathDisplay = FlxG.getPlugin(DebugPathDisplay) as DebugPathDisplay;
         if(_loc1_ != null)
         {
            _loc1_.clear();
         }
      }
      
      internal static function updateInput() : void
      {
         FlxG.keys.update();
         if(!_game._debuggerUp || !_game._debugger.hasMouse)
         {
            FlxG.mouse.update(FlxG._game.mouseX,FlxG._game.mouseY);
         }
      }
      
      internal static function lockCameras() : void
      {
         var _loc1_:FlxCamera = null;
         var _loc2_:Array = FlxG.cameras;
         var _loc3_:uint = 0;
         var _loc4_:uint = _loc2_.length;
         while(_loc3_ < _loc4_)
         {
            _loc1_ = _loc2_[_loc3_++] as FlxCamera;
            if(!(_loc1_ == null || !_loc1_.exists || !_loc1_.visible))
            {
               if(useBufferLocking)
               {
                  _loc1_.buffer.lock();
               }
               do
               {
                  _loc1_.fill();
                  _loc1_.screen.dirty = true;
               }
               while(false);
               
            }
         }
      }
      
      internal static function unlockCameras() : void
      {
         var _loc1_:FlxCamera = null;
         var _loc2_:Array = FlxG.cameras;
         var _loc3_:uint = 0;
         var _loc4_:uint = _loc2_.length;
         loop0:
         while(_loc3_ < _loc4_)
         {
            _loc1_ = _loc2_[_loc3_++] as FlxCamera;
            §§push(_loc1_ == null || !_loc1_.exists);
            if(!(_loc1_ == null || !_loc1_.exists))
            {
               §§pop();
               while(true)
               {
                  §§push(!_loc1_.visible);
               }
               addr53:
            }
            while(!§§pop())
            {
               _loc1_.drawFX();
               if(useBufferLocking)
               {
                  _loc1_.buffer.unlock();
                  if(false)
                  {
                     §§goto(addr53);
                     continue;
                  }
               }
               continue loop0;
            }
         }
      }
      
      internal static function updateCameras() : void
      {
         var _loc1_:FlxCamera = null;
         var _loc2_:Array = FlxG.cameras;
         var _loc3_:uint = 0;
         var _loc4_:uint = _loc2_.length;
         while(_loc3_ < _loc4_)
         {
            _loc1_ = _loc2_[_loc3_++] as FlxCamera;
            if(_loc1_ != null && _loc1_.exists)
            {
               if(_loc1_.active)
               {
                  _loc1_.update();
               }
               _loc1_._flashBitmap.x = _loc1_.x;
               do
               {
                  _loc1_._flashBitmap.y = _loc1_.y;
                  _loc1_._flashBitmap.visible = _loc1_.exists && _loc1_.visible;
               }
               while(false);
               
            }
         }
      }
      
      internal static function updatePlugins() : void
      {
         var _loc1_:FlxBasic = null;
         var _loc2_:Array = FlxG.plugins;
         var _loc3_:uint = 0;
         var _loc4_:uint = _loc2_.length;
         while(_loc3_ < _loc4_)
         {
            _loc1_ = _loc2_[_loc3_++] as FlxBasic;
            if(_loc1_.exists && _loc1_.active)
            {
               _loc1_.update();
            }
         }
      }
      
      internal static function drawPlugins() : void
      {
         var _loc1_:FlxBasic = null;
         var _loc2_:Array = FlxG.plugins;
         var _loc3_:uint = 0;
         var _loc4_:uint = _loc2_.length;
         while(_loc3_ < _loc4_)
         {
            _loc1_ = _loc2_[_loc3_++] as FlxBasic;
            if(_loc1_.exists && _loc1_.visible)
            {
               _loc1_.draw();
            }
         }
      }
   }
}
