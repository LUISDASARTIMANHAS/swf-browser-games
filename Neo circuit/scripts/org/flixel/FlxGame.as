package org.flixel
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.display.StageAlign;
   import flash.display.StageScaleMode;
   import flash.events.*;
   import flash.text.AntiAliasType;
   import flash.text.GridFitType;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.ui.Mouse;
   import flash.utils.getTimer;
   import org.flixel.plugin.TimerManager;
   import org.flixel.system.FlxDebugger;
   import org.flixel.system.FlxReplay;
   
   public class FlxGame extends Sprite
   {
       
      
      protected var junk:String = "FlxGame_junk";
      
      protected var SndBeep:Class;
      
      protected var ImgLogo:Class;
      
      public var useSoundHotKeys:Boolean;
      
      public var forceDebugger:Boolean;
      
      internal var _state:FlxState;
      
      internal var _mouse:Sprite;
      
      protected var _iState:Class;
      
      protected var _created:Boolean;
      
      protected var _total:uint;
      
      protected var _accumulator:int;
      
      protected var _lostFocus:Boolean;
      
      internal var _step:uint;
      
      internal var _flashFramerate:uint;
      
      internal var _maxAccumulation:uint;
      
      internal var _requestedState:FlxState;
      
      internal var _requestedReset:Boolean;
      
      protected var _focus:Sprite;
      
      protected var _soundTray:Sprite;
      
      protected var _soundTrayTimer:Number;
      
      protected var _soundTrayBars:Array;
      
      internal var _debugger:FlxDebugger;
      
      internal var _debuggerUp:Boolean;
      
      internal var _replay:FlxReplay;
      
      internal var _replayRequested:Boolean;
      
      internal var _recordingRequested:Boolean;
      
      internal var _replaying:Boolean;
      
      internal var _recording:Boolean;
      
      internal var _replayCancelKeys:Array;
      
      internal var _replayTimer:int;
      
      internal var _replayCallback:Function;
      
      public function FlxGame(param1:uint, param2:uint, param3:Class, param4:Number = 1, param5:uint = 60, param6:uint = 30)
      {
         this.SndBeep = FlxGame_SndBeep;
         this.ImgLogo = FlxGame_ImgLogo;
         super();
         Mouse.hide();
         this._lostFocus = false;
         this._focus = new Sprite();
         this._focus.visible = false;
         this._soundTray = new Sprite();
         this._mouse = new Sprite();
         FlxG.init(this,param1,param2,param4);
         FlxG.framerate = param5;
         FlxG.flashFramerate = param6;
         this._accumulator = this._step;
         this._total = 0;
         this._state = null;
         this.useSoundHotKeys = true;
         this.forceDebugger = false;
         this._debuggerUp = false;
         this._replay = new FlxReplay();
         this._replayRequested = false;
         this._recordingRequested = false;
         this._replaying = false;
         this._recording = false;
         this._iState = param3;
         this._requestedState = null;
         this._requestedReset = true;
         this._created = false;
         addEventListener(Event.ENTER_FRAME,this.create);
      }
      
      internal function showSoundTray(param1:Boolean = false) : void
      {
         if(!param1)
         {
            FlxG.play(this.SndBeep);
         }
         this._soundTrayTimer = 1;
         do
         {
            this._soundTray.y = 0;
            this._soundTray.visible = true;
         }
         while(false);
         
         var _loc2_:uint = uint(Math.round(FlxG.volume * 10));
         if(FlxG.mute)
         {
            _loc2_ = 0;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < this._soundTrayBars.length)
         {
            if(_loc3_ < _loc2_)
            {
               this._soundTrayBars[_loc3_].alpha = 1;
            }
            else
            {
               this._soundTrayBars[_loc3_].alpha = 0.5;
            }
            _loc3_++;
         }
      }
      
      protected function onKeyUp(param1:KeyboardEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         if(this._debuggerUp && this._debugger.watch.editing)
         {
            return;
         }
         if(!FlxG.mobile)
         {
            if(this._debugger != null && (param1.keyCode == 192 || param1.keyCode == 220))
            {
               this._debugger.visible = !this._debugger.visible;
               this._debuggerUp = this._debugger.visible;
               if(this._debugger.visible)
               {
                  Mouse.show();
               }
               else
               {
                  Mouse.hide();
               }
               return;
            }
            if(this.useSoundHotKeys)
            {
               _loc2_ = int(param1.keyCode);
               _loc3_ = String(String.fromCharCode(param1.charCode));
               switch(_loc2_)
               {
                  case 48:
                  case 96:
                     FlxG.mute = !FlxG.mute;
                     if(FlxG.volumeHandler != null)
                     {
                        FlxG.volumeHandler(FlxG.mute ? 0 : FlxG.volume);
                     }
                     this.showSoundTray();
                     return;
                  case 109:
                  case 189:
                     FlxG.mute = false;
                     FlxG.volume -= 0.1;
                     this.showSoundTray();
                     return;
                  case 107:
                  case 187:
                     FlxG.mute = false;
                     FlxG.volume += 0.1;
                     this.showSoundTray();
                     return;
               }
            }
         }
         if(this._replaying)
         {
            return;
         }
         FlxG.keys.handleKeyUp(param1);
      }
      
      protected function onKeyDown(param1:KeyboardEvent) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:String = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         if(this._debuggerUp && this._debugger.watch.editing)
         {
            return;
         }
         if(this._replaying && this._replayCancelKeys != null && this._debugger == null && param1.keyCode != 192 && param1.keyCode != 220)
         {
            _loc2_ = false;
            _loc4_ = 0;
            _loc5_ = uint(this._replayCancelKeys.length);
            while(_loc4_ < _loc5_)
            {
               _loc3_ = String(this._replayCancelKeys[_loc4_++]);
               if(_loc3_ == "ANY" || FlxG.keys.getKeyCode(_loc3_) == param1.keyCode)
               {
                  if(this._replayCallback != null)
                  {
                     this._replayCallback();
                     this._replayCallback = null;
                  }
                  else
                  {
                     FlxG.stopReplay();
                  }
                  break;
               }
            }
            return;
         }
         FlxG.keys.handleKeyDown(param1);
      }
      
      protected function onMouseDown(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         if(this._debuggerUp)
         {
            if(this._debugger.hasMouse)
            {
               return;
            }
            if(this._debugger.watch.editing)
            {
               this._debugger.watch.submit();
            }
         }
         if(this._replaying && this._replayCancelKeys != null)
         {
            _loc3_ = 0;
            _loc4_ = uint(this._replayCancelKeys.length);
            while(_loc3_ < _loc4_)
            {
               _loc2_ = String(this._replayCancelKeys[_loc3_++] as String);
               if(_loc2_ == "MOUSE" || _loc2_ == "ANY")
               {
                  if(this._replayCallback != null)
                  {
                     this._replayCallback();
                     this._replayCallback = null;
                  }
                  else
                  {
                     FlxG.stopReplay();
                  }
                  break;
               }
            }
            return;
         }
         FlxG.mouse.handleMouseDown(param1);
      }
      
      protected function onMouseUp(param1:MouseEvent) : void
      {
         if(this._debuggerUp && this._debugger.hasMouse || this._replaying)
         {
            return;
         }
         FlxG.mouse.handleMouseUp(param1);
      }
      
      protected function onMouseWheel(param1:MouseEvent) : void
      {
         if(this._debuggerUp && this._debugger.hasMouse || this._replaying)
         {
            return;
         }
         FlxG.mouse.handleMouseWheel(param1);
      }
      
      protected function onFocus(param1:Event = null) : void
      {
         if(!this._debuggerUp)
         {
            Mouse.hide();
         }
         FlxG.resetInput();
         this._lostFocus = this._focus.visible = false;
         stage.frameRate = this._flashFramerate;
         FlxG.playSounds();
      }
      
      protected function onFocusLost(param1:Event = null) : void
      {
         if(x != 0 || y != 0)
         {
            x = 0;
            while(true)
            {
               y = 0;
            }
            addr15:
         }
         while(true)
         {
            Mouse.show();
            if(true)
            {
               break;
            }
            §§goto(addr15);
         }
         this._lostFocus = this._focus.visible = true;
         stage.frameRate = 10;
         FlxG.pauseSounds();
      }
      
      protected function onEnterFrame(param1:Event = null) : void
      {
         var _loc2_:uint = uint(getTimer());
         var _loc3_:uint = uint(_loc2_ - this._total);
         this._total = _loc2_;
         this.updateSoundTray(_loc3_);
         if(!this._lostFocus)
         {
            if(this._debugger != null && this._debugger.vcr.paused)
            {
               if(this._debugger.vcr.stepRequested)
               {
                  this._debugger.vcr.stepRequested = false;
                  this.step();
               }
            }
            else
            {
               this._accumulator += _loc3_;
               if(this._accumulator > this._maxAccumulation)
               {
                  this._accumulator = this._maxAccumulation;
               }
               while(this._accumulator >= this._step)
               {
                  this.step();
                  this._accumulator -= this._step;
               }
            }
            FlxBasic._VISIBLECOUNT = 0;
            this.draw();
            if(this._debuggerUp)
            {
               this._debugger.perf.flash(_loc3_);
               this._debugger.perf.visibleObjects(FlxBasic._VISIBLECOUNT);
               this._debugger.perf.update();
               this._debugger.watch.update();
            }
         }
      }
      
      protected function switchState() : void
      {
         FlxG.resetCameras();
         FlxG.resetInput();
         do
         {
            FlxG.destroySounds();
            if(this._debugger == null)
            {
               break;
            }
            this._debugger.watch.removeAll();
         }
         while(false);
         
         var _loc1_:TimerManager = FlxTimer.manager;
         if(_loc1_ != null)
         {
            _loc1_.clear();
         }
         if(this._state != null)
         {
            this._state.destroy();
            if(FlxU.getClassName(this._state) != FlxU.getClassName(this._requestedState))
            {
               FlxG.clearBitmapCache();
            }
         }
         this._state = this._requestedState;
         this._state.create();
      }
      
      protected function step() : void
      {
         if(this._requestedReset)
         {
            this._requestedReset = false;
            this._requestedState = new this._iState();
            this._replayTimer = 0;
            this._replayCancelKeys = null;
            FlxG.reset();
         }
         if(this._recordingRequested)
         {
            this._recordingRequested = false;
            this._replay.create(FlxG.globalSeed);
            this._recording = true;
            if(this._debugger != null)
            {
               this._debugger.vcr.recording();
               FlxG.log("FLIXEL: starting new flixel gameplay record.");
            }
         }
         else if(this._replayRequested)
         {
            this._replayRequested = false;
            this._replay.rewind();
            FlxG.globalSeed = this._replay.seed;
            if(this._debugger != null)
            {
               this._debugger.vcr.playing();
            }
            this._replaying = true;
         }
         if(this._state != this._requestedState)
         {
            this.switchState();
         }
         FlxBasic._ACTIVECOUNT = 0;
         if(this._replaying)
         {
            this._replay.playNextFrame();
            if(this._replayTimer > 0)
            {
               this._replayTimer -= this._step;
               if(this._replayTimer <= 0)
               {
                  if(this._replayCallback != null)
                  {
                     this._replayCallback();
                     this._replayCallback = null;
                  }
                  else
                  {
                     FlxG.stopReplay();
                  }
               }
            }
            if(this._replaying && this._replay.finished)
            {
               FlxG.stopReplay();
               if(this._replayCallback != null)
               {
                  this._replayCallback();
                  this._replayCallback = null;
               }
            }
            this._debugger.vcr.updateRuntime(this._step);
         }
         else
         {
            FlxG.updateInput();
         }
         if(this._recording)
         {
            this._replay.recordFrame();
            this._debugger.vcr.updateRuntime(this._step);
         }
         this.update();
         FlxG.mouse.wheel = 0;
         if(this._debuggerUp)
         {
            this._debugger.perf.activeObjects(FlxBasic._ACTIVECOUNT);
         }
      }
      
      protected function updateSoundTray(param1:Number) : void
      {
         var _loc2_:FlxSave = null;
         if(this._soundTray != null)
         {
            if(this._soundTrayTimer > 0)
            {
               this._soundTrayTimer -= param1 / 1000;
               addr28:
            }
            else if(this._soundTray.y > -this._soundTray.height)
            {
               this._soundTray.y -= param1 / 1000 * FlxG.height * 2;
               if(this._soundTray.y <= -this._soundTray.height)
               {
                  this._soundTray.visible = false;
                  if(false)
                  {
                     §§goto(addr28);
                  }
                  else
                  {
                     _loc2_ = new FlxSave();
                     if(_loc2_.bind("flixel"))
                     {
                        if(_loc2_.data.sound == null)
                        {
                           _loc2_.data.sound = new Object();
                        }
                        _loc2_.data.sound.mute = FlxG.mute;
                        do
                        {
                           _loc2_.data.sound.volume = FlxG.volume;
                           _loc2_.close();
                        }
                        while(false);
                        
                     }
                  }
               }
            }
         }
      }
      
      protected function update() : void
      {
         var _loc1_:uint = uint(getTimer());
         FlxG.elapsed = FlxG.timeScale * (this._step / 1000);
         FlxG.updateSounds();
         FlxG.updatePlugins();
         this._state.update();
         FlxG.updateCameras();
         if(this._debuggerUp)
         {
            this._debugger.perf.flixelUpdate(getTimer() - _loc1_);
         }
      }
      
      protected function draw() : void
      {
         var _loc1_:uint = uint(getTimer());
         FlxG.lockCameras();
         this._state.draw();
         FlxG.drawPlugins();
         FlxG.unlockCameras();
         if(this._debuggerUp)
         {
            this._debugger.perf.flixelDraw(getTimer() - _loc1_);
         }
      }
      
      protected function create(param1:Event) : void
      {
         if(root == null)
         {
            return;
         }
         removeEventListener(Event.ENTER_FRAME,this.create);
         this._total = getTimer();
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.align = StageAlign.TOP_LEFT;
         stage.frameRate = this._flashFramerate;
         stage.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         stage.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         stage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         addChild(this._mouse);
         if(!FlxG.mobile)
         {
            if(FlxG.debug || this.forceDebugger)
            {
               this._debugger = new FlxDebugger(FlxG.width * FlxCamera.defaultZoom,FlxG.height * FlxCamera.defaultZoom);
               addChild(this._debugger);
            }
            this.createSoundTray();
            stage.addEventListener(Event.DEACTIVATE,this.onFocusLost);
            stage.addEventListener(Event.ACTIVATE,this.onFocus);
            this.createFocusScreen();
         }
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      protected function createSoundTray() : void
      {
         this._soundTray.visible = false;
         do
         {
            this._soundTray.scaleX = 2;
            this._soundTray.scaleY = 2;
         }
         while(false);
         
         var _loc1_:Bitmap = new Bitmap(new BitmapData(80,30,true,2130706432));
         this._soundTray.x = FlxG.width / 2 * FlxCamera.defaultZoom - _loc1_.width / 2 * this._soundTray.scaleX;
         this._soundTray.addChild(_loc1_);
         var _loc2_:TextField = new TextField();
         _loc2_.width = _loc1_.width;
         _loc2_.height = _loc1_.height;
         _loc2_.multiline = true;
         _loc2_.wordWrap = true;
         _loc2_.selectable = false;
         _loc2_.embedFonts = true;
         _loc2_.antiAliasType = AntiAliasType.NORMAL;
         _loc2_.gridFitType = GridFitType.PIXEL;
         _loc2_.defaultTextFormat = new TextFormat("system",8,16777215,null,null,null,null,null,"center");
         this._soundTray.addChild(_loc2_);
         do
         {
            _loc2_.text = "VOLUME";
            _loc2_.y = 16;
         }
         while(false);
         
         var _loc3_:uint = 10;
         var _loc4_:uint = 14;
         this._soundTrayBars = new Array();
         var _loc5_:uint = 0;
         while(_loc5_ < 10)
         {
            _loc1_ = new Bitmap(new BitmapData(4,++_loc5_,false,16777215));
            _loc1_.x = _loc3_;
            _loc1_.y = _loc4_;
            this._soundTrayBars.push(this._soundTray.addChild(_loc1_));
            do
            {
               _loc3_ += 6;
               _loc4_--;
            }
            while(false);
            
         }
         this._soundTray.y = -this._soundTray.height;
         this._soundTray.visible = false;
         addChild(this._soundTray);
         var _loc6_:FlxSave;
         if((_loc6_ = new FlxSave()).bind("flixel") && _loc6_.data.sound != null)
         {
            if(_loc6_.data.sound.volume != null)
            {
               FlxG.volume = _loc6_.data.sound.volume;
            }
            if(_loc6_.data.sound.mute != null)
            {
               FlxG.mute = _loc6_.data.sound.mute;
            }
            _loc6_.destroy();
         }
      }
      
      protected function createFocusScreen() : void
      {
         var _loc1_:Graphics = this._focus.graphics;
         var _loc2_:uint = FlxG.width * FlxCamera.defaultZoom;
         var _loc3_:uint = FlxG.height * FlxCamera.defaultZoom;
         _loc1_.moveTo(0,0);
         _loc1_.beginFill(0,0.5);
         _loc1_.lineTo(_loc2_,0);
         _loc1_.lineTo(_loc2_,_loc3_);
         _loc1_.lineTo(0,_loc3_);
         do
         {
            _loc1_.lineTo(0,0);
            _loc1_.endFill();
         }
         while(false);
         
         var _loc4_:uint = _loc2_ / 2;
         var _loc5_:uint = _loc3_ / 2;
         var _loc6_:uint = FlxU.min(_loc4_,_loc5_) / 3;
         _loc1_.moveTo(_loc4_ - _loc6_,_loc5_ - _loc6_);
         _loc1_.beginFill(16777215,0.65);
         _loc1_.lineTo(_loc4_ + _loc6_,_loc5_);
         _loc1_.lineTo(_loc4_ - _loc6_,_loc5_ + _loc6_);
         do
         {
            _loc1_.lineTo(_loc4_ - _loc6_,_loc5_ - _loc6_);
            _loc1_.endFill();
         }
         while(false);
         
         var _loc7_:Bitmap;
         (_loc7_ = new this.ImgLogo()).scaleX = int(_loc6_ / 10);
         if(_loc7_.scaleX < 1)
         {
            _loc7_.scaleX = 1;
         }
         _loc7_.scaleY = _loc7_.scaleX;
         _loc7_.x -= _loc7_.scaleX;
         _loc7_.alpha = 0.35;
         this._focus.addChild(_loc7_);
         addChild(this._focus);
      }
   }
}
