package
{
   import com.adobe.serialization.json.JSON;
   import com.lib.*;
   import flash.display.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.net.*;
   import flash.text.*;
   import flash.ui.*;
   
   public class PaperTrain extends Sprite
   {
       
      
      private var pauseScreen:*;
      
      private var twitterURL:* = "http://twitter.com/paper_train";
      
      private var levelBlockLayers:Array;
      
      private var clicksWidget:GWidget;
      
      private var levelClearedScreen:*;
      
      private var trainLayer:*;
      
      private var guiFont:*;
      
      public var network:GNetwork;
      
      private var ownHost:* = false;
      
      private var hiScoresLoading:Boolean;
      
      private var mouseCursor:MovieClip;
      
      private var carGap:* = 0;
      
      private var particleLayer:*;
      
      private var trainStartOffset:*;
      
      private var hsScoresWidget:GWidget;
      
      private var signalEffectLayer:*;
      
      private var inkEffectLayer:*;
      
      private var switchLayer:*;
      
      private var hiScores:Array;
      
      private var cowLayer:*;
      
      private var wrapper:Sprite;
      
      private var tutorialLayer:*;
      
      private var clearedPostitX:*;
      
      private var chnGameMusic:Object;
      
      private var levelFailedScreen:*;
      
      private var highScoresScreen:*;
      
      private var forwardTrackLen:* = 35;
      
      private var trainCrashAccelerate:* = 90;
      
      private var playScreen:Sprite;
      
      private var sfxList:Object;
      
      private var particles:Array;
      
      private var trackLayer:*;
      
      private var facebookURL:* = "http://www.facebook.com/pages/Paper-Train/170069126361364";
      
      private var spdWidget:GWidget;
      
      private var carBogie:* = 3.5;
      
      private var levelWidget:GWidget;
      
      private var trainShadowLayer:*;
      
      private var blurHolder:Sprite;
      
      private var gameWidth:* = 720;
      
      private var sfxEnabled:Boolean;
      
      private var gameScreen:String;
      
      private var musicType:*;
      
      private var trainAccelerate:* = 50;
      
      private var gsound:GSoundSimple;
      
      private var clearedWidget:GWidget;
      
      private var failedPostitX:*;
      
      private var pausePostitX:*;
      
      private var markerLayer:*;
      
      private var curveData:Object;
      
      private var objectMarkers:Array;
      
      private var gameVars:*;
      
      private var cowGroups:Array;
      
      private var trainClosedOffset:*;
      
      private var levelStartScreen:*;
      
      private var objectLayer:*;
      
      private var gfxEffects:Array;
      
      private var guiFontColor:* = 5592405;
      
      private var cowRadiusLayer:*;
      
      private var chnMenuMusic:Object;
      
      private var fullVersionURL:* = "http://www.mylostgames.com/paper_train_full_version";
      
      private var physics_frame_rate:* = 30;
      
      private var minParticleDelay:*;
      
      private var frame:GFrame;
      
      private var gameStat:GameStat;
      
      private var markers:Array;
      
      private var paypalURL:* = "https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=5PX4SCB4NH4CN";
      
      private var com:*;
      
      private var level:Object;
      
      private var guiScreen:*;
      
      private var maxParticleDelay:*;
      
      private var signLayer:*;
      
      private var signOverLayer:*;
      
      private var hsNamesWidget:GWidget;
      
      private var carBogieDist:*;
      
      private var chnAmbient:Object;
      
      private var gameHeight:* = 560;
      
      private var levelId:int;
      
      private var input:GInput;
      
      private var hiScoresUpdated:Boolean;
      
      private var carLength:* = 28.7;
      
      private var buttonMotions:Array;
      
      private var FINALIZED:* = true;
      
      private var game:Object;
      
      private var shadowOffset:*;
      
      private var ldr:*;
      
      public function PaperTrain()
      {
         this.guiFont = GUIFont;
         this.carBogieDist = this.carLength - 2 * this.carBogie;
         this.shadowOffset = new Point(4,4);
         this.minParticleDelay = 0.2 * this.physics_frame_rate;
         this.maxParticleDelay = 0.4 * this.physics_frame_rate;
         this.trainStartOffset = this.carLength;
         this.trainClosedOffset = this.carLength / 2;
         this.gameVars = new Object();
         super();
         this.com = new Common(this);
      }
      
      private function refreshCarriageClip(param1:Object, param2:Object, param3:Number, param4:Number, param5:Number, param6:int) : *
      {
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         _loc7_ = param1.totalDistance / this.com.trainSpeed;
         _loc8_ = param1.speed / this.com.trainSpeed;
         if(param1.crashed)
         {
            _loc8_ = 4 * (1 - _loc8_);
         }
         _loc9_ = Math.PI * 2 * _loc7_ + Math.PI * param6 * (130 / 180);
         _loc10_ = param3 + 0.4 * _loc8_ * Math.sin(_loc9_);
         _loc11_ = param4 + 0.4 * _loc8_ * Math.cos(_loc9_);
         _loc12_ = param5 + 1.4 * _loc8_ * Math.cos(_loc9_);
         param2.clip.x = _loc10_;
         param2.clip.y = _loc11_;
         param2.clip.rotation = _loc12_;
         param2.shadow.x = _loc10_ + this.shadowOffset.x;
         param2.shadow.y = _loc11_ + this.shadowOffset.y;
         param2.shadow.rotation = _loc12_;
         param2.hit.x = param3;
         param2.hit.y = param4;
         param2.hit.rotation = param5;
      }
      
      private function AddTrain(param1:int, param2:int = 0) : *
      {
         var _loc4_:* = undefined;
         var _loc6_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         var _loc15_:* = undefined;
         var _loc3_:* = this.com.trackPoints[param1];
         if(_loc3_.indices.length < 1 || _loc3_.indices.length > 2 || !_loc3_.start && !_loc3_.spawn)
         {
            trace("AddTrain() error!");
            return null;
         }
         if(_loc3_.indices.length == 1)
         {
            _loc4_ = this.com.trackPoints[param1].indices[0];
         }
         else if(_loc3_.indices.length == 2)
         {
            if(_loc3_.startDir)
            {
               _loc4_ = this.com.trackPoints[param1].indices[1];
            }
            else
            {
               _loc4_ = this.com.trackPoints[param1].indices[0];
            }
         }
         var _loc5_:* = new Object();
         if(param2)
         {
            if(!_loc3_.spawn)
            {
               trace("AddTrain() error!");
               return null;
            }
            _loc3_.lastTrain = _loc5_;
            _loc5_.spawnPoint = _loc3_;
            _loc3_.trainDistanceFromThis = 0;
            _loc6_ = param2;
         }
         else
         {
            if(!_loc3_.start)
            {
               trace("AddTrain() error!");
               return null;
            }
            _loc6_ = !!_loc3_.startLen ? _loc3_.startLen : 1;
         }
         _loc5_.carriages = new Array();
         _loc5_.long = this.getTrainLong(_loc6_);
         _loc5_.startSpeed = this.com.trainSpeed;
         _loc5_.speed = 0;
         _loc5_.speedToReach = 0;
         _loc5_.accelerate = this.trainAccelerate;
         _loc5_.totalDistance = 0;
         var _loc7_:* = _loc5_.long - this.carBogie + (Boolean(_loc3_.turnBack) || Boolean(_loc3_.closed) ? this.trainClosedOffset : this.trainStartOffset);
         var _loc8_:int = 0;
         for(; _loc8_ < _loc6_; _loc13_.x = _loc10_.dPoint.x,_loc13_.y = _loc10_.dPoint.y,_loc13_.rotation = _loc12_,_loc9_.clip = _loc13_,(_loc14_ = new CarriageShadow()).x = _loc13_.x + this.shadowOffset.x,_loc14_.y = _loc13_.y + this.shadowOffset.y,_loc14_.rotation = _loc12_,_loc9_.shadow = _loc14_,(_loc15_ = new CarriageHit()).x = _loc10_.dPoint.x,_loc15_.y = _loc10_.dPoint.y,_loc15_.rotation = _loc12_,_loc9_.hit = _loc15_,_loc5_.carriages.push(_loc9_),_loc8_++)
         {
            _loc9_ = new Object();
            _loc10_ = this.com.followTrack(param1,_loc4_,0,_loc7_);
            _loc11_ = this.com.followTrack(param1,_loc4_,0,_loc7_ - this.carBogieDist);
            _loc7_ -= this.carLength + this.carGap;
            if(Boolean(_loc10_.overflow) || Boolean(_loc11_.overflow))
            {
               trace("AddTrain() overflow!");
               return null;
            }
            _loc9_.bogie1 = new Object();
            _loc9_.bogie1.p1 = _loc10_.dFirst;
            _loc9_.bogie1.p2 = _loc10_.dNext;
            _loc9_.bogie1.pOffs = _loc10_.dOffs;
            _loc9_.bogie1.pRevOffs = _loc10_.dRevOffs;
            _loc9_.bogie1.pnt = _loc10_.dPoint;
            _loc9_.bogie2 = new Object();
            _loc9_.bogie2.p1 = _loc11_.dFirst;
            _loc9_.bogie2.p2 = _loc11_.dNext;
            _loc9_.bogie2.pOffs = _loc11_.dOffs;
            _loc9_.bogie2.pRevOffs = _loc11_.dRevOffs;
            _loc9_.bogie2.pnt = _loc11_.dPoint;
            _loc12_ = GMath.getVecAngle(new Point(_loc11_.dPoint.x - _loc10_.dPoint.x,_loc11_.dPoint.y - _loc10_.dPoint.y));
            _loc9_.x = _loc10_.dPoint.x;
            _loc9_.y = _loc10_.dPoint.y;
            _loc9_.rotation = _loc12_;
            if(_loc8_ == 0)
            {
               _loc13_ = new Engine1();
               continue;
            }
            switch(int(Math.random() * 3))
            {
               case 0:
                  _loc13_ = new Carriage1();
                  break;
               case 1:
                  _loc13_ = new Carriage2();
                  break;
               case 2:
                  _loc13_ = new Carriage3();
                  break;
            }
         }
         this.com.trains.push(_loc5_);
         this.addTrainClip(_loc5_);
         return _loc5_;
      }
      
      private function updateCow(param1:Object, param2:Object, param3:Number) : *
      {
         if(!param2.alive)
         {
            return;
         }
         var _loc4_:* = this.frame.getTime();
         var _loc5_:* = Math.PI * 0.5 * _loc4_;
         param2.dir.x += 0.005 * Math.cos(_loc5_);
         param2.dir.y += 0.005 * Math.sin(_loc5_);
         param2.dir.normalize(1);
         param2.pos.x += param2.spd * param2.dir.x * param3;
         param2.pos.y += param2.spd * param2.dir.y * param3;
         var _loc6_:*;
         if((_loc6_ = Point.distance(param1.center,param2.pos)) > param1.radius)
         {
            param2.dir = param1.center.subtract(param2.pos);
            param2.dir.normalize(1);
            param2.pos.x += param2.spd * param2.dir.x * param3;
            param2.pos.y += param2.spd * param2.dir.y * param3;
            this.addCowStopEvent(param2,true);
         }
         if(this.frame.getTime() > param2.nextEvent)
         {
            if(param2.event == "stop")
            {
               param2.spd = 0;
               this.addCowStartEvent(param2);
            }
            else if(param2.event == "start")
            {
               this.randomizeCowDirection(param2);
               this.randomizeCowSpeed(param2);
               this.addCowStopEvent(param2);
            }
         }
         param2.clip.x = param2.pos.x;
         param2.clip.y = param2.pos.y;
         param2.clip.rotation = GMath.getVecAngle(param2.dir) + 90;
         param2.shadow.x = param2.pos.x + this.shadowOffset.x;
         param2.shadow.y = param2.pos.y + this.shadowOffset.y;
         param2.shadow.rotation = param2.clip.rotation;
      }
      
      public function stopTrains() : *
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this.com.trains)
         {
            this.stopTrain(_loc1_);
         }
      }
      
      private function calcLevelTrainSpeedBonus() : *
      {
         var _loc1_:* = undefined;
         switch(this.game.levelSpeed)
         {
            case 1:
               _loc1_ = 0;
               break;
            case 2:
               _loc1_ = 100;
               break;
            case 3:
               _loc1_ = 500;
               break;
            case 4:
               _loc1_ = 1000;
         }
         this.game.levelSpeedBonus = _loc1_;
      }
      
      private function carriageHitTest(param1:Object, param2:Object) : *
      {
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         var _loc15_:* = undefined;
         var _loc16_:* = undefined;
         var _loc17_:* = undefined;
         var _loc18_:* = undefined;
         var _loc19_:* = undefined;
         var _loc20_:* = undefined;
         var _loc21_:* = undefined;
         var _loc22_:* = undefined;
         if(!param1.hit.hitTestObject(param2.hit))
         {
            return false;
         }
         var _loc3_:* = new Array();
         var _loc4_:* = new Array();
         var _loc5_:* = 0;
         while(_loc5_ < 2)
         {
            if(_loc5_ == 0)
            {
               _loc7_ = param1;
               _loc8_ = _loc3_;
            }
            else
            {
               _loc7_ = param2;
               _loc8_ = _loc4_;
            }
            _loc9_ = _loc7_.bogie1.pnt;
            _loc10_ = _loc7_.bogie2.pnt;
            (_loc11_ = _loc9_.subtract(_loc10_)).normalize(5);
            _loc12_ = new Point(-_loc11_.x,-_loc11_.y);
            (_loc13_ = GMath.cross(_loc11_)).normalize(5);
            _loc14_ = new Point(-_loc13_.x,-_loc13_.y);
            _loc15_ = _loc9_.add(_loc13_);
            _loc16_ = _loc10_.add(_loc13_);
            _loc17_ = _loc10_.add(_loc14_);
            _loc18_ = _loc9_.add(_loc14_);
            _loc19_ = _loc10_.add(_loc12_);
            _loc20_ = _loc9_.add(_loc11_);
            _loc8_.push({
               "p1":_loc15_,
               "p2":_loc16_
            });
            _loc8_.push({
               "p1":_loc16_,
               "p2":_loc19_
            });
            _loc8_.push({
               "p1":_loc19_,
               "p2":_loc17_
            });
            _loc8_.push({
               "p1":_loc17_,
               "p2":_loc18_
            });
            _loc8_.push({
               "p1":_loc18_,
               "p2":_loc20_
            });
            _loc8_.push({
               "p1":_loc20_,
               "p2":_loc15_
            });
            _loc5_++;
         }
         for each(_loc6_ in _loc3_)
         {
            for each(_loc21_ in _loc4_)
            {
               if(_loc22_ = GMath.lineIntersect(_loc6_.p1,_loc6_.p2,_loc21_.p1,_loc21_.p2))
               {
                  return _loc22_;
               }
            }
         }
         return false;
      }
      
      private function toggleSwitchMarker(param1:Object) : *
      {
         if(param1.hideSwitch)
         {
            return;
         }
         if(!this.isMarkerSwitchable(param1))
         {
            this.playSfx("railswitcherror");
            return;
         }
         this.playSfx("railswitch");
         param1.turnSwitch ^= 1;
         this.updateSignLayer();
      }
      
      private function mouseMove(param1:*) : *
      {
         this.mouseCursor.x = param1.stageX;
         this.mouseCursor.y = param1.stageY;
      }
      
      private function emitParticles(param1:Number) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         for each(_loc2_ in this.com.trains)
         {
            if(!_loc2_.leftTheLevel)
            {
               if(_loc2_.speed != 0)
               {
                  if(_loc2_.nextParticle > 0)
                  {
                     --_loc2_.nextParticle;
                  }
                  else
                  {
                     _loc2_.nextParticle = this.minParticleDelay + Math.random() * (this.maxParticleDelay - this.minParticleDelay);
                     _loc3_ = _loc2_.carriages[0];
                     switch(int(Math.random() * 3))
                     {
                        case 0:
                           _loc4_ = new EngineSmoke1();
                           break;
                        case 1:
                           _loc4_ = new EngineSmoke2();
                           break;
                        case 2:
                           _loc4_ = new EngineSmoke3();
                     }
                     _loc5_ = _loc3_.bogie1.pnt;
                     _loc6_ = _loc3_.bogie2.pnt;
                     (_loc7_ = GMath.cross(_loc5_.subtract(_loc6_))).normalize(8 + 4 * Math.random());
                     (_loc8_ = _loc7_.clone()).normalize(1);
                     _loc9_ = _loc5_.x + 2 * (Math.random() - 0.5) + 4 * _loc8_.x;
                     _loc10_ = _loc5_.y + 2 * (Math.random() - 0.5) + 4 * _loc8_.y;
                     _loc11_ = 120 + 60 * Math.random();
                     _loc12_ = 0.3 + 0.05 * Math.random();
                     this.addParticle({
                        "x":_loc9_,
                        "y":_loc10_,
                        "moveSpd":_loc7_,
                        "alphaSpd":-0.4,
                        "rotSpd":_loc11_,
                        "scaleSpd":_loc12_
                     },_loc4_);
                  }
               }
            }
         }
      }
      
      private function addCowStartEvent(param1:Object, param2:Boolean = false) : *
      {
         var _loc3_:* = param2 ? 10 + 15 * Math.random() : 15 + 15 * Math.random();
         param1.event = "start";
         param1.nextEvent = this.frame.getTime() + _loc3_;
      }
      
      private function resetParticles() : *
      {
         this.particles = new Array();
         while(this.particleLayer.numChildren)
         {
            this.particleLayer.removeChildAt(0);
         }
         this.resetEffects();
      }
      
      private function buildGUI(param1:*) : *
      {
         var levelMsg:* = undefined;
         var clearedMsg:* = undefined;
         var clicksMsg:* = undefined;
         var spdMsg:* = undefined;
         var screenLayer:* = param1;
         var gui:* = new Sprite();
         this.guiScreen = new GUI();
         this.guiScreen.restart.visible = false;
         this.guiScreen.pause.visible = false;
         this.guiScreen.menuButton.visible = false;
         this.guiScreen.exitButton.visible = false;
         this.guiScreen.levelPostit.visible = false;
         this.guiScreen.clearedPostit.visible = false;
         this.guiScreen.clicksPostit.visible = false;
         this.guiScreen.spdPostit.visible = false;
         if(this.gameScreen == "play")
         {
            this.guiScreen.restart.visible = true;
            this.guiScreen.pause.visible = true;
            this.guiScreen.menuButton.visible = true;
            this.guiScreen.exitButton.visible = true;
            this.guiScreen.levelPostit.visible = true;
            this.guiScreen.clearedPostit.visible = true;
            this.guiScreen.clicksPostit.visible = true;
            this.guiScreen.spdPostit.visible = true;
         }
         else if(this.gameScreen == "selectlevel")
         {
            this.guiScreen.exitButton.visible = true;
         }
         else if(this.gameScreen == "highscores")
         {
            this.guiScreen.exitButton.visible = true;
         }
         else if(this.gameScreen == "addgametosite")
         {
            this.guiScreen.exitButton.visible = true;
         }
         else if(this.gameScreen == "fullversion")
         {
            this.guiScreen.exitButton.visible = true;
         }
         else if(this.gameScreen == "instructions")
         {
            this.guiScreen.exitButton.visible = true;
         }
         this.guiScreen.soundSwitch.sfxButton.buttonMode = true;
         this.guiScreen.restart.restartButton.buttonMode = true;
         this.guiScreen.pause.pauseButton.buttonMode = true;
         this.guiScreen.menuButton.buttonMode = true;
         this.guiScreen.exitButton.buttonMode = true;
         this.guiScreen.fullVersionButton.buttonMode = true;
         if(this.gsound.isEnabledSfx())
         {
            this.guiScreen.soundSwitch.sfxButton.gotoAndStop("enabled");
         }
         else
         {
            this.guiScreen.soundSwitch.sfxButton.gotoAndStop("disabled");
         }
         this.guiScreen.pause.pauseButton.gotoAndStop("pause");
         this.guiScreen.fullVersionButton.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            if(gameScreen == "pause")
            {
               pauseGame(false);
            }
            if(gameScreen == "play" || gameScreen == "levelcleared" || gameScreen == "levelstart" || gameScreen == "submitscore" || gameScreen == "congrat" || gameScreen == "levelfailed")
            {
               stopAmbient();
               destroyLevel();
            }
            wrapper.removeChild(screenLayer);
            showFullVersionScreen();
         });
         this.guiScreen.soundSwitch.sfxButton.addEventListener(MouseEvent.CLICK,function():*
         {
            if(gsound.isEnabledSfx())
            {
               gsound.enableSfx(false);
               guiScreen.soundSwitch.sfxButton.gotoAndStop("disabled");
            }
            else
            {
               gsound.enableSfx(true);
               guiScreen.soundSwitch.sfxButton.gotoAndStop("enabled");
               gsound.play(Click);
            }
         });
         this.guiScreen.pause.pauseButton.addEventListener(MouseEvent.CLICK,function():*
         {
            if(game.menuDisabled)
            {
               return;
            }
            gsound.play(Click);
            if(frame.isPaused())
            {
               pauseGame(false);
            }
            else
            {
               pauseGame(true);
            }
         });
         this.guiScreen.menuButton.addEventListener(MouseEvent.CLICK,function():*
         {
            if(game.menuDisabled)
            {
               return;
            }
            gsound.play(Click);
            if(frame.isPaused())
            {
               pauseGame(false);
            }
            else
            {
               pauseGame(true);
            }
         });
         this.guiScreen.exitButton.addEventListener(MouseEvent.CLICK,function():*
         {
            if(game.menuDisabled)
            {
               return;
            }
            gsound.play(Click);
            if(gameScreen == "pause")
            {
               pauseGame(false);
            }
            if(gameScreen == "play" || gameScreen == "levelcleared" || gameScreen == "levelstart" || gameScreen == "submitscore" || gameScreen == "congrat" || gameScreen == "levelfailed")
            {
               stopAmbient();
               destroyLevel();
            }
            wrapper.removeChild(screenLayer);
            showOpenScreen();
         });
         this.guiScreen.restart.restartButton.addEventListener(MouseEvent.CLICK,function():*
         {
            if(gameScreen != "play" || Boolean(game.menuDisabled))
            {
               return;
            }
            gsound.play(Click);
            startLevel(true);
         });
         if(this.gameScreen == "play")
         {
            this.levelWidget = new GWidget({
               "font":this.guiFont,
               "color":0,
               "size":14,
               "align":"left",
               "margin":0,
               "embed":true,
               "antiAlias":true,
               "letterSpacing":1
            });
            levelMsg = this.levelWidget.print("");
            levelMsg.x = 20;
            levelMsg.y = 5;
            levelMsg.scaleY = 1.4;
            this.guiScreen.levelPostit.addChild(levelMsg);
            this.guiScreen.levelPostit.visible = false;
            this.clearedWidget = new GWidget({
               "font":this.guiFont,
               "color":0,
               "size":14,
               "align":"left",
               "margin":0,
               "embed":true,
               "antiAlias":true,
               "letterSpacing":1
            });
            clearedMsg = this.clearedWidget.print("");
            clearedMsg.x = 35;
            clearedMsg.y = 5;
            clearedMsg.scaleY = 1.4;
            this.guiScreen.clearedPostit.addChild(clearedMsg);
            this.guiScreen.clearedPostit.visible = false;
            this.clicksWidget = new GWidget({
               "font":this.guiFont,
               "color":this.guiFontColor,
               "size":14,
               "align":"left",
               "margin":0,
               "embed":true,
               "antiAlias":true,
               "letterSpacing":1
            });
            clicksMsg = this.clicksWidget.print("");
            clicksMsg.x = 8;
            clicksMsg.y = 5;
            clicksMsg.scaleY = 1.4;
            this.guiScreen.clicksPostit.addChild(clicksMsg);
            this.guiScreen.clicksPostit.visible = false;
            this.spdWidget = new GWidget({
               "font":this.guiFont,
               "color":this.guiFontColor,
               "size":14,
               "align":"left",
               "margin":0,
               "embed":true,
               "antiAlias":true,
               "letterSpacing":1
            });
            spdMsg = this.spdWidget.print("");
            spdMsg.x = 8;
            spdMsg.y = 5;
            spdMsg.scaleY = 1.4;
            this.guiScreen.spdPostit.addChild(spdMsg);
            this.guiScreen.spdPostit.visible = false;
         }
         gui.addChild(this.guiScreen);
         return gui;
      }
      
      private function checkHitCow(param1:Object) : Boolean
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         for each(_loc2_ in this.com.trains)
         {
            if(!_loc2_.leftTheLevel)
            {
               if(_loc2_.speed != 0)
               {
                  _loc3_ = 0;
                  while(_loc3_ < _loc2_.carriages.length)
                  {
                     _loc4_ = _loc2_.carriages[_loc3_];
                     if(this.carriageCowHitTest(_loc4_,param1))
                     {
                        return true;
                     }
                     _loc3_++;
                  }
               }
            }
         }
         return false;
      }
      
      private function removeTracks() : *
      {
         this.removeLevelBlocks();
         this.removeMarkers();
         this.removeSigns();
         this.com.trackPoints = new Array();
         this.com.connectPoints = new Array();
      }
      
      private function removeCarriageClip(param1:Object) : *
      {
         this.trainShadowLayer.removeChild(param1.shadow);
         this.trainLayer.removeChild(param1.clip);
         this.trainLayer.removeChild(param1.hit);
      }
      
      private function rotateCow(param1:Object) : *
      {
         var _loc2_:* = param1.dir.x;
         var _loc3_:* = param1.dir.y;
         param1.dir.x = -_loc3_;
         param1.dir.y = _loc2_;
         param1.dir.normalize(1);
      }
      
      private function removeSigns() : *
      {
         while(this.signLayer.numChildren)
         {
            this.signLayer.removeChildAt(0);
         }
         while(this.switchLayer.numChildren)
         {
            this.switchLayer.removeChildAt(0);
         }
      }
      
      private function showOpenScreen() : *
      {
         var followMsg:*;
         var gui:*;
         var openScreen:* = undefined;
         var buttonSelectOffset:* = undefined;
         var orig:* = undefined;
         this.gameScreen = "open";
         this.playMusic("menu");
         this.gsound.play(SfxDraw2);
         while(this.wrapper.numChildren)
         {
            this.wrapper.removeChildAt(0);
         }
         openScreen = new OpenScreen();
         this.wrapper.addChild(openScreen);
         gui = this.buildGUI(openScreen);
         openScreen.addChild(gui);
         buttonSelectOffset = 3;
         orig = new Object();
         orig.facebook = {
            "x":openScreen.facebookIcon.x,
            "y":openScreen.facebookIcon.y,
            "xs":openScreen.shadowFacebook.x,
            "ys":openScreen.shadowFacebook.y
         };
         orig.twitter = {
            "x":openScreen.twitterIcon.x,
            "y":openScreen.twitterIcon.y,
            "xs":openScreen.shadowTwitter.x,
            "ys":openScreen.shadowTwitter.y
         };
         orig.start = {
            "x":openScreen.rubberStart.x,
            "y":openScreen.rubberStart.y,
            "xs":openScreen.shadowRubberStart.x,
            "ys":openScreen.shadowRubberStart.y
         };
         orig.instructions = {
            "x":openScreen.pencilInstructions.x,
            "y":openScreen.pencilInstructions.y,
            "xs":openScreen.shadowPencilInstructions.x,
            "ys":openScreen.shadowPencilInstructions.y
         };
         orig.selectLevel = {
            "x":openScreen.pencilSelectLevel.x,
            "y":openScreen.pencilSelectLevel.y,
            "xs":openScreen.shadowPencilSelectLevel.x,
            "ys":openScreen.shadowPencilSelectLevel.y
         };
         orig.highScores = {
            "x":openScreen.pencilHighScores.x,
            "y":openScreen.pencilHighScores.y,
            "xs":openScreen.shadowPencilHighScores.x,
            "ys":openScreen.shadowPencilHighScores.y
         };
         orig.moreGames = {
            "x":openScreen.pencilMoreGames.x,
            "y":openScreen.pencilMoreGames.y,
            "xs":openScreen.shadowPencilMoreGames.x,
            "ys":openScreen.shadowPencilMoreGames.y
         };
         orig.addGame = {
            "x":openScreen.pencilAddGame.x,
            "y":openScreen.pencilAddGame.y,
            "xs":openScreen.shadowPencilAddGame.x,
            "ys":openScreen.shadowPencilAddGame.y
         };
         openScreen.facebookIcon.visible = false;
         openScreen.twitterIcon.visible = false;
         openScreen.rubberStart.visible = false;
         openScreen.pencilInstructions.visible = false;
         openScreen.pencilSelectLevel.visible = false;
         openScreen.pencilWalkthrough.visible = false;
         openScreen.pencilHighScores.visible = false;
         openScreen.pencilMoreGames.visible = false;
         openScreen.pencilAddGame.visible = false;
         openScreen.shadowFacebook.visible = false;
         openScreen.shadowTwitter.visible = false;
         openScreen.shadowRubberStart.visible = false;
         openScreen.shadowPencilInstructions.visible = false;
         openScreen.shadowPencilSelectLevel.visible = false;
         openScreen.shadowPencilWalkthrough.visible = false;
         openScreen.shadowPencilHighScores.visible = false;
         openScreen.shadowPencilMoreGames.visible = false;
         openScreen.shadowPencilAddGame.visible = false;
         this.buttonMotions = new Array();
         this.buttonMotions.push({
            "id":"facebook",
            "button":openScreen.facebookButton,
            "start":-0.5,
            "duration":0.15,
            "clip":openScreen.facebookIcon,
            "shadowClip":openScreen.shadowFacebook,
            "xofs":openScreen.shadowFacebook.x - openScreen.facebookIcon.x,
            "yofs":openScreen.shadowFacebook.y - openScreen.facebookIcon.y,
            "path":new GPath(this.curveData.facebookIcon)
         });
         this.buttonMotions.push({
            "id":"twitter",
            "button":openScreen.twitterButton,
            "start":-0.6,
            "duration":0.15,
            "clip":openScreen.twitterIcon,
            "shadowClip":openScreen.shadowTwitter,
            "xofs":openScreen.shadowTwitter.x - openScreen.twitterIcon.x,
            "yofs":openScreen.shadowTwitter.y - openScreen.twitterIcon.y,
            "path":new GPath(this.curveData.twitterIcon)
         });
         this.buttonMotions.push({
            "id":"start",
            "button":openScreen.startButton,
            "start":-0.7,
            "duration":0.2,
            "clip":openScreen.rubberStart,
            "shadowClip":openScreen.shadowRubberStart,
            "xofs":openScreen.shadowRubberStart.x - openScreen.rubberStart.x,
            "yofs":openScreen.shadowRubberStart.y - openScreen.rubberStart.y,
            "path":new GPath(this.curveData.rubberStart)
         });
         this.buttonMotions.push({
            "id":"instructions",
            "button":openScreen.instructionsButton,
            "start":-0.2,
            "duration":0.4,
            "clip":openScreen.pencilInstructions,
            "shadowClip":openScreen.shadowPencilInstructions,
            "xofs":openScreen.shadowPencilInstructions.x - openScreen.pencilInstructions.x,
            "yofs":openScreen.shadowPencilInstructions.y - openScreen.pencilInstructions.y,
            "path":new GPath(this.curveData.pencilInstructions)
         });
         this.buttonMotions.push({
            "id":"selectlevel",
            "button":openScreen.selectLevelButton,
            "start":-0.6,
            "duration":0.4,
            "clip":openScreen.pencilSelectLevel,
            "shadowClip":openScreen.shadowPencilSelectLevel,
            "xofs":openScreen.shadowPencilSelectLevel.x - openScreen.pencilSelectLevel.x,
            "yofs":openScreen.shadowPencilSelectLevel.y - openScreen.pencilSelectLevel.y,
            "path":new GPath(this.curveData.pencilSelectLevel)
         });
         this.buttonMotions.push({
            "id":"highscores",
            "button":openScreen.highScoresButton,
            "start":-0.65,
            "duration":0.4,
            "clip":openScreen.pencilHighScores,
            "shadowClip":openScreen.shadowPencilHighScores,
            "xofs":openScreen.shadowPencilHighScores.x - openScreen.pencilHighScores.x,
            "yofs":openScreen.shadowPencilHighScores.y - openScreen.pencilHighScores.y,
            "path":new GPath(this.curveData.pencilHighScores)
         });
         this.buttonMotions.push({
            "id":"moregames",
            "hideAtFullVersion":true,
            "button":openScreen.moreGamesButton,
            "start":-0.3,
            "duration":0.4,
            "clip":openScreen.pencilMoreGames,
            "shadowClip":openScreen.shadowPencilMoreGames,
            "xofs":openScreen.shadowPencilMoreGames.x - openScreen.pencilMoreGames.x,
            "yofs":openScreen.shadowPencilMoreGames.y - openScreen.pencilMoreGames.y,
            "path":new GPath(this.curveData.pencilMoreGames)
         });
         this.buttonMotions.push({
            "id":"addgame",
            "hideAtFullVersion":true,
            "button":openScreen.addGameButton,
            "start":-0.7,
            "duration":0.4,
            "clip":openScreen.pencilAddGame,
            "shadowClip":openScreen.shadowPencilAddGame,
            "xofs":openScreen.shadowPencilAddGame.x - openScreen.pencilAddGame.x,
            "yofs":openScreen.shadowPencilAddGame.y - openScreen.pencilAddGame.y,
            "path":new GPath(this.curveData.pencilAddGame)
         });
         openScreen.facebookButton.addEventListener(MouseEvent.MOUSE_OVER,function(param1:*):*
         {
            if(getButtonMotion("facebook").finished)
            {
               playSfx("mouseover");
            }
            setButtonOffset(param1,getButtonMotion("facebook"),orig.facebook,1,0);
         });
         openScreen.facebookButton.addEventListener(MouseEvent.MOUSE_OUT,function(param1:*):*
         {
            setButtonOffset(param1,getButtonMotion("facebook"),orig.facebook);
         });
         openScreen.facebookButton.addEventListener(MouseEvent.CLICK,function(param1:*):*
         {
            if(!getButtonMotion("facebook").finished)
            {
               return;
            }
            gsound.play(Click);
            network.gotoURL(facebookURL);
         });
         openScreen.twitterButton.addEventListener(MouseEvent.MOUSE_OVER,function(param1:*):*
         {
            if(getButtonMotion("twitter").finished)
            {
               playSfx("mouseover");
            }
            setButtonOffset(param1,getButtonMotion("twitter"),orig.twitter,1,0);
         });
         openScreen.twitterButton.addEventListener(MouseEvent.MOUSE_OUT,function(param1:*):*
         {
            setButtonOffset(param1,getButtonMotion("twitter"),orig.twitter);
         });
         openScreen.twitterButton.addEventListener(MouseEvent.CLICK,function(param1:*):*
         {
            if(!getButtonMotion("twitter").finished)
            {
               return;
            }
            gsound.play(Click);
            network.gotoURL(twitterURL);
         });
         openScreen.startButton.addEventListener(MouseEvent.MOUSE_MOVE,function(param1:*):*
         {
            setButtonOffset(param1,getButtonMotion("start"),orig.start,buttonSelectOffset,0.5);
         });
         openScreen.startButton.addEventListener(MouseEvent.MOUSE_OVER,function(param1:*):*
         {
            if(getButtonMotion("start").finished)
            {
               playSfx("mouseover");
            }
            setButtonOffset(param1,getButtonMotion("start"),orig.start,buttonSelectOffset,0.5);
         });
         openScreen.startButton.addEventListener(MouseEvent.MOUSE_OUT,function(param1:*):*
         {
            setButtonOffset(param1,getButtonMotion("start"),orig.start);
         });
         openScreen.startButton.addEventListener(MouseEvent.CLICK,function(param1:*):*
         {
            if(!getButtonMotion("start").finished)
            {
               return;
            }
            gsound.play(Click);
            wrapper.removeChild(openScreen);
            showSelectLevelScreen();
         });
         openScreen.instructionsButton.addEventListener(MouseEvent.MOUSE_MOVE,function(param1:*):*
         {
            setButtonOffset(param1,getButtonMotion("instructions"),orig.instructions,buttonSelectOffset);
         });
         openScreen.instructionsButton.addEventListener(MouseEvent.MOUSE_OVER,function(param1:*):*
         {
            if(getButtonMotion("instructions").finished)
            {
               playSfx("mouseover");
            }
            setButtonOffset(param1,getButtonMotion("instructions"),orig.instructions,buttonSelectOffset);
         });
         openScreen.instructionsButton.addEventListener(MouseEvent.MOUSE_OUT,function(param1:*):*
         {
            setButtonOffset(param1,getButtonMotion("instructions"),orig.instructions);
         });
         openScreen.instructionsButton.addEventListener(MouseEvent.CLICK,function(param1:*):*
         {
            if(!getButtonMotion("instructions").finished)
            {
               return;
            }
            gsound.play(Click);
            wrapper.removeChild(openScreen);
            showInstructionsScreen();
         });
         openScreen.selectLevelButton.addEventListener(MouseEvent.MOUSE_MOVE,function(param1:*):*
         {
            setButtonOffset(param1,getButtonMotion("selectlevel"),orig.selectLevel,buttonSelectOffset);
         });
         openScreen.selectLevelButton.addEventListener(MouseEvent.MOUSE_OVER,function(param1:*):*
         {
            if(getButtonMotion("selectlevel").finished)
            {
               playSfx("mouseover");
            }
            setButtonOffset(param1,getButtonMotion("selectlevel"),orig.selectLevel,buttonSelectOffset);
         });
         openScreen.selectLevelButton.addEventListener(MouseEvent.MOUSE_OUT,function(param1:*):*
         {
            setButtonOffset(param1,getButtonMotion("selectlevel"),orig.selectLevel);
         });
         openScreen.selectLevelButton.addEventListener(MouseEvent.CLICK,function(param1:*):*
         {
            if(!getButtonMotion("selectlevel").finished)
            {
               return;
            }
            gsound.play(Click);
            wrapper.removeChild(openScreen);
            showSelectLevelScreen();
         });
         openScreen.walkthroughButton.visible = false;
         openScreen.highScoresButton.addEventListener(MouseEvent.MOUSE_MOVE,function(param1:*):*
         {
            setButtonOffset(param1,getButtonMotion("highscores"),orig.highScores,buttonSelectOffset);
         });
         openScreen.highScoresButton.addEventListener(MouseEvent.MOUSE_OVER,function(param1:*):*
         {
            if(getButtonMotion("highscores").finished)
            {
               playSfx("mouseover");
            }
            setButtonOffset(param1,getButtonMotion("highscores"),orig.highScores,buttonSelectOffset);
         });
         openScreen.highScoresButton.addEventListener(MouseEvent.MOUSE_OUT,function(param1:*):*
         {
            setButtonOffset(param1,getButtonMotion("highscores"),orig.highScores);
         });
         openScreen.highScoresButton.addEventListener(MouseEvent.CLICK,function(param1:*):*
         {
            if(!getButtonMotion("highscores").finished)
            {
               return;
            }
            gsound.play(Click);
            wrapper.removeChild(openScreen);
            showHighScoresScreen();
         });
         openScreen.moreGamesButton.addEventListener(MouseEvent.MOUSE_MOVE,function(param1:*):*
         {
            setButtonOffset(param1,getButtonMotion("moregames"),orig.moreGames,buttonSelectOffset);
         });
         openScreen.moreGamesButton.addEventListener(MouseEvent.MOUSE_OVER,function(param1:*):*
         {
            if(getButtonMotion("moregames").finished)
            {
               playSfx("mouseover");
            }
            setButtonOffset(param1,getButtonMotion("moregames"),orig.moreGames,buttonSelectOffset);
         });
         openScreen.moreGamesButton.addEventListener(MouseEvent.MOUSE_OUT,function(param1:*):*
         {
            setButtonOffset(param1,getButtonMotion("moregames"),orig.moreGames);
         });
         openScreen.moreGamesButton.addEventListener(MouseEvent.CLICK,function(param1:*):*
         {
            if(!getButtonMotion("moregames").finished)
            {
               return;
            }
            gsound.play(Click);
            gameStat.goToMyLostGames("",null,"paper_train_openscreen_PlayMoreGames");
         });
         openScreen.addGameButton.addEventListener(MouseEvent.MOUSE_MOVE,function(param1:*):*
         {
            setButtonOffset(param1,getButtonMotion("addgame"),orig.addGame,buttonSelectOffset);
         });
         openScreen.addGameButton.addEventListener(MouseEvent.MOUSE_OVER,function(param1:*):*
         {
            if(getButtonMotion("addgame").finished)
            {
               playSfx("mouseover");
            }
            setButtonOffset(param1,getButtonMotion("addgame"),orig.addGame,buttonSelectOffset);
         });
         openScreen.addGameButton.addEventListener(MouseEvent.MOUSE_OUT,function(param1:*):*
         {
            setButtonOffset(param1,getButtonMotion("addgame"),orig.addGame);
         });
         openScreen.addGameButton.addEventListener(MouseEvent.CLICK,function(param1:*):*
         {
            if(!getButtonMotion("addgame").finished)
            {
               return;
            }
            gsound.play(Click);
            wrapper.removeChild(openScreen);
            showAddGameScreen();
         });
         openScreen.buttonMyLostGames.addEventListener(MouseEvent.CLICK,function(param1:*):*
         {
            gsound.play(Click);
            gameStat.goToMyLostGames("",null,"paper_train_openscreen_MyLostGames");
         });
         openScreen.background.gotoAndStop(1);
         followMsg = GWidget.echo("follow paper train on<br/>facebook and twitter<br/>for updates!",{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":10,
            "align":"left",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":1,
            "multiLine":true
         },290);
         followMsg.x = 450;
         followMsg.y = 90;
         followMsg.scaleY = 1.4;
         followMsg.rotation = -0.5;
         openScreen.addChild(followMsg);
      }
      
      private function stopAmbient() : *
      {
         this.gsound.stopMusic(this.chnAmbient);
      }
      
      private function resetCows() : *
      {
         var _loc1_:* = undefined;
         this.game.totalCows = 0;
         this.removeCows();
         for each(_loc1_ in this.objectMarkers)
         {
            if(_loc1_.proto.type == "cow")
            {
               this.addCowGroup(_loc1_.proto,_loc1_.x,_loc1_.y);
            }
         }
         this.game.cowsSaved = this.game.totalCows;
      }
      
      private function addMarker(param1:*) : *
      {
         var markerSize:*;
         var marker:* = param1;
         this.markers.push(marker);
         markerSize = 20;
         marker.layer = new Sprite();
         marker.layer.graphics.beginFill(0,0.01);
         marker.layer.graphics.drawRect(-markerSize / 2,-markerSize / 2,markerSize,markerSize);
         marker.layer.x = marker.x;
         marker.layer.y = marker.y;
         if(marker.initial)
         {
            if(marker.initial.turnSwitch)
            {
               marker.turnSwitch = marker.initial.turnSwitch;
            }
            if(marker.initial.spd)
            {
               marker.spd = marker.initial.spd;
            }
         }
         else
         {
            marker.initial = {
               "turnSwitch":marker.turnSwitch,
               "spd":marker.spd
            };
         }
         if(marker.isSwitch && !marker.hideSwitch || Boolean(marker.spd))
         {
            marker.layer.addEventListener(MouseEvent.CLICK,function(param1:*):*
            {
               clickMarker(marker);
            });
            marker.layer.buttonMode = true;
            if(marker.spd)
            {
               marker.layer.addEventListener(MouseEvent.MOUSE_OVER,function(param1:*):*
               {
                  overMarker(marker);
               });
               marker.layer.addEventListener(MouseEvent.MOUSE_OUT,function(param1:*):*
               {
                  outMarker(marker);
               });
            }
         }
         this.markerLayer.addChild(marker.layer);
      }
      
      private function overMarker(param1:Object) : *
      {
         if(!this.com.runningLevel)
         {
            return;
         }
         if(!param1.sign)
         {
            return;
         }
         var _loc2_:* = new param1.sign();
         _loc2_.x = param1.x;
         _loc2_.y = param1.y;
         _loc2_.rotation = param1.rotation;
         this.signOverLayer.addChild(_loc2_);
      }
      
      private function loadLevel() : *
      {
         this.level = this.com.levelData.levelList[this.levelId - 1];
         this.dataLoaded(this.level,false);
      }
      
      private function startLevel(param1:Boolean = false) : *
      {
         this.resetLevel();
         this.resetCows();
         if(param1)
         {
            this.runLevel();
         }
         else
         {
            this.showLevelStartScreen();
         }
      }
      
      private function pauseEvent(param1:Boolean) : *
      {
         if(param1)
         {
            this.showPauseScreen();
         }
         else
         {
            this.destroyPauseScreen();
         }
      }
      
      private function cowHitFrame(param1:Number) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         if(this.gameScreen != "play" || !this.com.isRunningLevel())
         {
            return;
         }
         for each(_loc2_ in this.cowGroups)
         {
            for each(_loc3_ in _loc2_.cows)
            {
               if(_loc3_.alive)
               {
                  if(this.checkHitCow(_loc3_))
                  {
                     this.playSfx("cowhit");
                     this.playEffect("cowhit",_loc3_.pos);
                     this.removeCow(_loc3_);
                     --this.game.cowsSaved;
                  }
               }
            }
         }
      }
      
      private function addParticle(param1:Object, param2:*) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         _loc3_ = null;
         for each(_loc4_ in this.particles)
         {
            if(!_loc4_.used)
            {
               _loc3_ = _loc4_;
               break;
            }
         }
         if(!_loc3_)
         {
            _loc3_ = new Object();
            this.particles.push(_loc3_);
         }
         _loc3_.used = true;
         _loc3_.clip = param2;
         _loc3_.clip.x = param1.x;
         _loc3_.clip.y = param1.y;
         _loc3_.clip.alpha = !!param1.alpha ? param1.alpha : 1;
         _loc3_.clip.rotation = !!param1.rot ? param1.rot : 0;
         _loc3_.clip.scaleX = !!param1.scale ? param1.scale : 1;
         _loc3_.clip.scaleY = !!param1.scale ? param1.scale : 1;
         _loc3_.moveSpd = new Point(!!param1.moveSpd.x ? Number(param1.moveSpd.x) : 0,!!param1.moveSpd.y ? Number(param1.moveSpd.y) : 0);
         _loc3_.alphaSpd = !!param1.alphaSpd ? param1.alphaSpd : 0;
         _loc3_.rotSpd = !!param1.rotSpd ? param1.rotSpd : 0;
         _loc3_.scaleSpd = !!param1.scaleSpd ? param1.scaleSpd : 0;
         this.particleLayer.addChild(_loc3_.clip);
      }
      
      private function randomizeCowSpeed(param1:Object) : *
      {
         param1.spd = 12 + 5 * Math.random();
      }
      
      private function dataLoaded(param1:*, param2:Boolean) : *
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         if(!param1.data)
         {
            return;
         }
         var _loc3_:* = param2 ? com.adobe.serialization.json.JSON.decode(param1.data) : param1.data;
         if(!_loc3_)
         {
            return;
         }
         if(_loc3_.blocks)
         {
            for each(_loc4_ in _loc3_.blocks)
            {
               _loc5_ = this.com.getProtoByName(_loc4_.type,_loc4_.name);
               _loc6_ = _loc4_.x;
               _loc7_ = _loc4_.y;
               _loc8_ = _loc4_.rotation;
               _loc9_ = _loc4_.sx;
               _loc10_ = _loc4_.sy;
               if(_loc5_.marker)
               {
                  this.addObjectMarker(_loc5_,_loc6_,_loc7_);
               }
               else
               {
                  this.addLevelBlockLayer(_loc5_,_loc4_.type,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_);
               }
            }
         }
         if(_loc3_.markers)
         {
            for each(_loc11_ in _loc3_.markers)
            {
               this.addMarker(_loc11_);
            }
         }
         this.buildTrack();
         this.showTutorial();
         this.startLevel();
      }
      
      private function showInstructionsScreen() : *
      {
         var corner:*;
         var gui:*;
         var instructions:*;
         var intMsg1:*;
         var instructionsScreen:* = undefined;
         this.gameScreen = "instructions";
         while(this.wrapper.numChildren)
         {
            this.wrapper.removeChildAt(0);
         }
         instructionsScreen = new InstructionsScreen();
         this.wrapper.addChild(instructionsScreen);
         gui = this.buildGUI(instructionsScreen);
         instructionsScreen.addChild(gui);
         corner = new Point(185,55);
         instructions = "control railway traffic without crashing any trains.<br/><br/>" + "you can stop and start the trains at the control square spots by clicking on the squares on the railway.<br/><br/>" + "red square stops the train.<br/>" + "green square starts the train.<br/>" + "blue square switches the tracks for the train.<br/><br/>" + "for each train you successfully let off the map you get 100 points!<br/><br/>" + "for each time you use a control square to stear the trains you lose 10 points!<br/><br/>" + "for each cow you save from getting hit by a train you get 100 points! (only available in full version.)";
         intMsg1 = GWidget.echo(instructions,{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":11,
            "align":"left",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":1,
            "multiLine":true
         },420);
         intMsg1.x = corner.x;
         intMsg1.y = corner.y;
         intMsg1.scaleY = 1.4;
         intMsg1.rotation = -0.5;
         instructionsScreen.postit.addChild(intMsg1);
         instructionsScreen.postit.playButton.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            wrapper.removeChild(instructionsScreen);
            showSelectLevelScreen();
         });
         instructionsScreen.postit.backButton.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            wrapper.removeChild(instructionsScreen);
            showOpenScreen();
         });
         instructionsScreen.postit.fullVersionButton.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            wrapper.removeChild(instructionsScreen);
            showFullVersionScreen();
         });
      }
      
      private function fixFrame(param1:Number) : *
      {
         if(this.com.isRunningLevel())
         {
            this.moveTrains(param1);
            this.emitParticles(param1);
         }
      }
      
      private function getHighScores() : *
      {
         if(this.hiScoresLoading)
         {
            return;
         }
         this.hiScoresUpdated = false;
         this.hiScoresLoading = true;
         this.gameStat.getHighScores(this.hiScoresReceiver);
      }
      
      private function removeMarkers() : *
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this.markers)
         {
            this.markerLayer.removeChild(_loc1_.layer);
         }
         while(this.signOverLayer.numChildren)
         {
            this.signOverLayer.removeChildAt(0);
         }
         this.markers = new Array();
      }
      
      private function showLevelStartScreen() : *
      {
         var fmsg:*;
         var trainSpdMsg:*;
         var selectMoreMsg:*;
         var smallFontSize:*;
         var numTotalTrainsMsg:*;
         var cowsMsg:*;
         var startYoffs:*;
         var followMsg:*;
         var leftBlockWidth:*;
         var rowHeight:*;
         var levelMsg:*;
         var valTrainSpdMsg:*;
         var spdMsg:*;
         var widgetLayer:*;
         var totalTrainsMsg:*;
         var numCowsMsg:*;
         var rightBlockWidth:*;
         var smallLetterSpacing:*;
         var postitWidth:*;
         var yoffs:* = undefined;
         var fvmsg:* = undefined;
         this.gameScreen = "levelstart";
         this.playMusic("game");
         this.gsound.setSfxVolume(1);
         this.levelStartScreen = new LevelStartScreen();
         this.wrapper.addChild(this.levelStartScreen);
         startYoffs = 50;
         rowHeight = 11;
         postitWidth = 460;
         leftBlockWidth = 300;
         rightBlockWidth = 160;
         smallFontSize = 12;
         smallLetterSpacing = 1;
         widgetLayer = new Sprite();
         widgetLayer.scaleY = 1.4;
         this.levelStartScreen.startPostit.addChild(widgetLayer);
         levelMsg = GWidget.echo(this.getLevelName(),{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":24,
            "align":"center",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":1
         },postitWidth);
         levelMsg.x = 0;
         levelMsg.y = 10;
         widgetLayer.addChild(levelMsg);
         switch(int(Math.random() * 2))
         {
            case 0:
               fvmsg = "too fast or too slow? you can choose different train speeds in full version.";
               break;
            case 1:
               fvmsg = "too easy for you? new obstacles and speeds can challange you in the full version.";
         }
         selectMoreMsg = GWidget.echo(fvmsg,{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":smallFontSize,
            "align":"center",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":1,
            "multiLine":true
         },360);
         selectMoreMsg.x = 50;
         selectMoreMsg.y = 105;
         widgetLayer.addChild(selectMoreMsg);
         yoffs = startYoffs;
         totalTrainsMsg = GWidget.echo("trains to lead off:",{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":smallFontSize,
            "align":"right",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":smallLetterSpacing
         },leftBlockWidth);
         totalTrainsMsg.x = 0;
         totalTrainsMsg.y = yoffs;
         widgetLayer.addChild(totalTrainsMsg);
         yoffs += rowHeight;
         cowsMsg = GWidget.echo("cows to handle:",{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":smallFontSize,
            "align":"right",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":smallLetterSpacing
         },leftBlockWidth);
         cowsMsg.x = 0;
         cowsMsg.y = yoffs;
         widgetLayer.addChild(cowsMsg);
         yoffs += rowHeight;
         trainSpdMsg = GWidget.echo("train speed:",{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":smallFontSize,
            "align":"right",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":smallLetterSpacing
         },leftBlockWidth);
         trainSpdMsg.x = 0;
         trainSpdMsg.y = yoffs;
         widgetLayer.addChild(trainSpdMsg);
         yoffs += rowHeight;
         yoffs = startYoffs;
         numTotalTrainsMsg = GWidget.echo(this.level.totalTrains.toString(),{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":smallFontSize,
            "align":"left",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":smallLetterSpacing
         },rightBlockWidth);
         numTotalTrainsMsg.x = leftBlockWidth + 15;
         numTotalTrainsMsg.y = yoffs;
         widgetLayer.addChild(numTotalTrainsMsg);
         yoffs += rowHeight;
         numCowsMsg = GWidget.echo(this.game.totalCows.toString(),{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":smallFontSize,
            "align":"left",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":smallLetterSpacing
         },rightBlockWidth);
         numCowsMsg.x = leftBlockWidth + 15;
         numCowsMsg.y = yoffs;
         widgetLayer.addChild(numCowsMsg);
         yoffs += rowHeight;
         spdMsg = this.getTrainSpeedText(!!this.level.defaultSpeed ? int(this.level.defaultSpeed) : 1);
         valTrainSpdMsg = GWidget.echo(spdMsg,{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":smallFontSize,
            "align":"left",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":smallLetterSpacing
         },rightBlockWidth);
         valTrainSpdMsg.x = leftBlockWidth + 15;
         valTrainSpdMsg.y = yoffs;
         widgetLayer.addChild(valTrainSpdMsg);
         yoffs += rowHeight;
         fmsg = "follow us on facebook and<br/>twitter for latest versions!";
         followMsg = GWidget.echo(fmsg,{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":10,
            "align":"left",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":1,
            "multiLine":true
         },400);
         followMsg.x = 145;
         followMsg.y = 232;
         followMsg.scaleY = 1.4;
         widgetLayer.addChild(followMsg);
         this.levelStartScreen.startPostit.spd1Button.addEventListener(MouseEvent.CLICK,function():*
         {
            game.levelSpeed = 1;
            gsound.play(Click);
            destroyStartScreen();
         });
         this.levelStartScreen.startPostit.spd2Button.addEventListener(MouseEvent.CLICK,function():*
         {
            game.levelSpeed = 2;
            gsound.play(Click);
            destroyStartScreen();
         });
         this.levelStartScreen.startPostit.spd3Button.addEventListener(MouseEvent.CLICK,function():*
         {
            game.levelSpeed = 3;
            gsound.play(Click);
            destroyStartScreen();
         });
         this.levelStartScreen.startPostit.spd4Button.addEventListener(MouseEvent.CLICK,function():*
         {
            game.levelSpeed = 4;
            gsound.play(Click);
            destroyStartScreen();
         });
         this.levelStartScreen.startPostit.startButton.addEventListener(MouseEvent.CLICK,function():*
         {
            game.levelSpeed = !!level.defaultSpeed ? level.defaultSpeed : 1;
            gsound.play(Click);
            destroyStartScreen();
         });
         this.levelStartScreen.startPostit.fullVersionButton.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            blurPlayScreen(false);
            destroyLevel();
            wrapper.removeChild(levelStartScreen);
            wrapper.removeChild(playScreen);
            showFullVersionScreen();
         });
         this.levelStartScreen.startPostit.facebookIcon.buttonMode = true;
         this.levelStartScreen.startPostit.facebookIcon.addEventListener(MouseEvent.CLICK,function(param1:*):*
         {
            gsound.play(Click);
            network.gotoURL(facebookURL);
         });
         this.levelStartScreen.startPostit.twitterIcon.buttonMode = true;
         this.levelStartScreen.startPostit.twitterIcon.addEventListener(MouseEvent.CLICK,function(param1:*):*
         {
            gsound.play(Click);
            network.gotoURL(twitterURL);
         });
         this.blurPlayScreen(true);
         this.levelStartScreen.startPostit.spd1Button.visible = false;
         this.levelStartScreen.startPostit.spd2Button.visible = false;
         this.levelStartScreen.startPostit.spd3Button.visible = false;
         this.levelStartScreen.startPostit.spd4Button.visible = false;
         this.guiScreen.levelPostit.visible = false;
         this.guiScreen.clearedPostit.visible = false;
         this.guiScreen.clicksPostit.visible = false;
         this.guiScreen.spdPostit.visible = false;
      }
      
      private function getMovedCarriages(param1:*, param2:*) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:Number = NaN;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         _loc3_ = param1.carriages[0].bogie1;
         _loc4_ = param1.carriages[0].bogie2;
         _loc5_ = param1.carriages[param1.carriages.length - 1].bogie2;
         _loc6_ = param1.carriages[param1.carriages.length - 1].bogie1;
         _loc7_ = 0;
         if(param1.speed > 0)
         {
            _loc8_ = this.com.followTrack(_loc3_.p1,_loc3_.p2,_loc3_.pOffs,param2);
            _loc9_ = this.com.followTrack(_loc4_.p1,_loc4_.p2,_loc4_.pOffs,param2);
            _loc11_ = this.com.followTrack(_loc3_.p1,_loc3_.p2,_loc3_.pOffs,this.forwardTrackLen);
            _loc12_ = new Array();
            _loc10_ = param1.carriages.length - 1;
            while(_loc10_ >= 0)
            {
               _loc12_.push(this.com.followTrack(_loc5_.p1,_loc5_.p2,_loc5_.pOffs,param2 + _loc7_));
               _loc12_.push(this.com.followTrack(_loc5_.p1,_loc5_.p2,_loc5_.pOffs,param2 + _loc7_ + this.carBogieDist));
               _loc7_ += this.carLength + this.carGap;
               _loc10_--;
            }
         }
         else
         {
            _loc8_ = this.com.followTrack(_loc5_.p2,_loc5_.p1,_loc5_.pRevOffs,param2);
            _loc9_ = this.com.followTrack(_loc6_.p2,_loc6_.p1,_loc6_.pRevOffs,param2);
            _loc11_ = this.com.followTrack(_loc5_.p2,_loc5_.p1,_loc5_.pRevOffs,this.forwardTrackLen);
            _loc12_ = new Array();
            _loc10_ = 0;
            while(_loc10_ < param1.carriages.length)
            {
               _loc12_.push(this.com.followTrack(_loc3_.p2,_loc3_.p1,_loc3_.pRevOffs,param2 + _loc7_));
               _loc12_.push(this.com.followTrack(_loc3_.p2,_loc3_.p1,_loc3_.pRevOffs,param2 + _loc7_ + this.carBogieDist));
               _loc7_ += this.carLength + this.carGap;
               _loc10_++;
            }
         }
         return {
            "forwardBogieFirst":_loc8_,
            "forwardBogieNext":_loc9_,
            "forwardTrack":_loc11_,
            "bogieList":_loc12_
         };
      }
      
      private function saveAvailableLevels() : *
      {
         var _loc1_:* = undefined;
         this.gameVars.levels = new Array();
         for each(_loc1_ in this.com.levelData.levelList)
         {
            if(_loc1_.available)
            {
               this.gameVars.levels.push(1);
            }
            else
            {
               this.gameVars.levels.push(0);
            }
         }
         this.gameStat.saveGameVars(this.gameVars);
      }
      
      private function updateParticle(param1:Object, param2:Number) : *
      {
         if(!param1 || !param1.used)
         {
            return;
         }
         param1.clip.x += param1.moveSpd.x * param2;
         param1.clip.y += param1.moveSpd.y * param2;
         param1.clip.alpha += param1.alphaSpd * param2;
         param1.clip.rotation += param1.rotSpd * param2;
         param1.clip.scaleX += param1.scaleSpd * param2;
         param1.clip.scaleY += param1.scaleSpd * param2;
         if(param1.clip.alpha < 0.1)
         {
            param1.used = false;
            this.particleLayer.removeChild(param1.clip);
         }
      }
      
      private function removeCow(param1:Object) : *
      {
         if(!param1.alive)
         {
            return;
         }
         this.cowLayer.removeChild(param1.layer);
         param1.alive = false;
      }
      
      private function updateMotions(param1:Number) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         if(this.gameScreen != "open")
         {
            return;
         }
         if(!this.buttonMotions || !this.buttonMotions.length)
         {
            return;
         }
         for each(_loc2_ in this.buttonMotions)
         {
            if(!_loc2_.finished)
            {
               if(_loc2_.time == undefined)
               {
                  _loc2_.time = _loc2_.start;
               }
               _loc3_ = _loc2_.time / _loc2_.duration;
               _loc2_.time += param1;
               _loc2_.path.updateClip(_loc2_.clip,_loc3_);
               _loc2_.shadowClip.x = _loc2_.clip.x + _loc2_.xofs;
               _loc2_.shadowClip.y = _loc2_.clip.y + _loc2_.yofs;
               _loc2_.clip.visible = true;
               _loc2_.shadowClip.visible = true;
               if(_loc3_ >= 1)
               {
                  _loc2_.finished = true;
               }
            }
         }
      }
      
      private function sfxSwitched(param1:Boolean) : *
      {
         this.gameVars.sfx = param1;
         this.gameStat.saveGameVars(this.gameVars);
      }
      
      private function addSelectLevelEvents(param1:*, param2:*, param3:int) : *
      {
         var postit:* = param1;
         var selectLevelScreen:* = param2;
         var levelId:int = param3;
         postit.button.addEventListener(MouseEvent.MOUSE_OVER,function(param1:*):*
         {
            playSfx("mouseover");
            postit.paper.x = -2;
            postit.paper.y = -2;
            postit.shadow.x = 6;
            postit.shadow.y = 6;
         });
         postit.button.addEventListener(MouseEvent.MOUSE_OUT,function(param1:*):*
         {
            postit.paper.x = 0;
            postit.paper.y = 0;
            postit.shadow.x = 4;
            postit.shadow.y = 4;
         });
         postit.button.addEventListener(MouseEvent.CLICK,function(param1:*):*
         {
            gsound.play(Click);
            wrapper.removeChild(selectLevelScreen);
            startGame(levelId);
         });
      }
      
      private function isLastLevel(param1:*) : *
      {
         return param1 == this.com.levelData.levelList.length;
      }
      
      private function randomizeCowDirection(param1:Object, param2:Boolean = false) : *
      {
         if(!param1.dir || param2)
         {
            param1.dir = new Point(Math.random() - 0.5,Math.random() - 0.5);
         }
         param1.dir.x += 0.8 * (Math.random() - 0.5);
         param1.dir.y += 0.8 * (Math.random() - 0.5);
         param1.dir.normalize(1);
      }
      
      private function blurPlayScreen(param1:Boolean) : *
      {
         var _loc2_:* = undefined;
         if(param1)
         {
            _loc2_ = new BlurFilter(8,8,1);
            this.blurHolder.filters = new Array(_loc2_);
         }
         else
         {
            this.blurHolder.filters = undefined;
         }
      }
      
      private function showAddGameScreen() : *
      {
         var embedScript:*;
         var embedGameMsg:*;
         var embedMsg:*;
         var downloadMsg:*;
         var gui:*;
         var addGameScreen:* = undefined;
         this.gameScreen = "addgametosite";
         while(this.wrapper.numChildren)
         {
            this.wrapper.removeChildAt(0);
         }
         addGameScreen = new AddGameScreen();
         this.wrapper.addChild(addGameScreen);
         gui = this.buildGUI(addGameScreen);
         addGameScreen.addChild(gui);
         embedGameMsg = GWidget.echo("use this script to embed this game to your site",{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":11,
            "align":"left",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":1
         });
         embedGameMsg.x = 30;
         embedGameMsg.y = 30;
         embedGameMsg.scaleY = 1.4;
         addGameScreen.postit.addChild(embedGameMsg);
         embedScript = "<object width=\'" + this.gameWidth + "\' height=\'" + this.gameHeight + "\' bgcolor=\'#ffffff\'><param name=\'movie\' value=\'http://www.mylostgames.com/swf/paper_train.swf\'></param><param name=\'allowScriptAccess\' value=\'always\'></param><param name=\'allowNetworking\' value=\'all\'></param><embed src=\'http://www.mylostgames.com/swf/paper_train.swf\' allowNetworking=\'all\' allowScriptAccess=\'always\' type=\'application/x-shockwave-flash\' width=\'" + this.gameWidth + "\' height=\'" + this.gameHeight + "\' bgcolor=\'#ffffff\'></embed></object>";
         embedMsg = GWidget.echo(embedScript,{
            "font":Courier,
            "size":14,
            "color":this.guiFontColor,
            "margin":8,
            "embed":true,
            "letterSpacing":0,
            "multiLine":true,
            "mouseEnabled":true,
            "html":false,
            "style":this.embedWidgetStyle
         },580);
         embedMsg.x = 30;
         embedMsg.y = 70;
         addGameScreen.postit.addChild(embedMsg);
         downloadMsg = GWidget.echo("click here to download (.zip)",{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":14,
            "align":"left",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":1
         });
         downloadMsg.x = 30;
         downloadMsg.y = 270;
         downloadMsg.scaleY = 1.4;
         addGameScreen.postit.addChild(downloadMsg);
         downloadMsg.buttonMode = true;
         downloadMsg.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            network.gotoURL("http://www.mylostgames.com/download/paper_train.zip");
         });
         addGameScreen.postit.backButton.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            wrapper.removeChild(addGameScreen);
            showOpenScreen();
         });
         addGameScreen.postit.fullVersionButton.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            wrapper.removeChild(addGameScreen);
            showFullVersionScreen();
         });
      }
      
      public function startTrains() : *
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this.com.trains)
         {
            this.startTrain(_loc1_);
         }
      }
      
      private function hiScoresReceiver(param1:Object) : *
      {
         var _loc2_:* = undefined;
         this.hiScores = new Array();
         for each(_loc2_ in param1.scores)
         {
            this.hiScores.push({
               "name":_loc2_.name,
               "score":_loc2_.score
            });
         }
         this.hiScoresUpdated = true;
         this.hiScoresLoading = false;
      }
      
      private function addLevelBlockLayer(param1:*, param2:*, param3:*, param4:*, param5:*, param6:*, param7:*) : *
      {
         var _loc8_:* = new Object();
         this.levelBlockLayers.push(_loc8_);
         _loc8_.proto = param1;
         _loc8_.type = param2;
         _loc8_.x = param3;
         _loc8_.y = param4;
         _loc8_.rotation = param5;
         _loc8_.sx = param6;
         _loc8_.sy = param7;
         if(param2 == "track")
         {
            _loc8_.clip = new param1.clip();
            _loc8_.clip.x = param3;
            _loc8_.clip.y = param4;
            _loc8_.clip.rotation = param5;
            _loc8_.clip.scaleX = param6;
            _loc8_.clip.scaleY = param7;
            this.trackLayer.addChild(_loc8_.clip);
         }
         else if(param2 == "object")
         {
            _loc8_.clip = new param1.clip();
            _loc8_.clip.x = param3;
            _loc8_.clip.y = param4;
            _loc8_.clip.rotation = param5;
            _loc8_.clip.scaleX = param6;
            _loc8_.clip.scaleY = param7;
            this.objectLayer.addChild(_loc8_.clip);
         }
         return _loc8_;
      }
      
      private function resetSpawns() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         for(_loc1_ in this.com.trackPoints)
         {
            _loc2_ = this.com.trackPoints[_loc1_];
            if(_loc2_.spawn)
            {
               _loc2_.firstSpawn = true;
               _loc2_.trainDistanceFromThis = 0;
               _loc2_.nextSpawnDistance = undefined;
               _loc2_.numCarriagesForSpawn = undefined;
            }
         }
      }
      
      public function moveTrains(param1:Number) : *
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this.com.trains)
         {
            if(!_loc2_.leftTheLevel)
            {
               this.moveTrain(_loc2_,param1);
            }
         }
         this.trainHitTest();
      }
      
      public function begin() : *
      {
         this.gameStat = new GameStat("paper_train",this.FINALIZED);
         this.gameStat.checkHost(this.checkHostCallBack);
      }
      
      private function isSfxPlayable(param1:String, param2:Number) : *
      {
         if(this.sfxList && this.sfxList[param1] && this.frame.getTime() - this.sfxList[param1] < param2)
         {
            return false;
         }
         return true;
      }
      
      private function updateCows(param1:Number) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         for each(_loc2_ in this.cowGroups)
         {
            for each(_loc3_ in _loc2_.cows)
            {
               this.updateCow(_loc2_,_loc3_,param1);
            }
         }
      }
      
      private function resetEffects() : *
      {
         this.gfxEffects = new Array();
         while(this.inkEffectLayer.numChildren)
         {
            this.inkEffectLayer.removeChildAt(0);
         }
         while(this.signalEffectLayer.numChildren)
         {
            this.signalEffectLayer.removeChildAt(0);
         }
      }
      
      private function moveTrain(param1:Object, param2:Number) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         if(param1.speed != param1.speedToReach)
         {
            if(param1.speedToReach > param1.speed)
            {
               param1.speed += param1.accelerate * param2;
               if(param1.speed > param1.speedToReach)
               {
                  param1.speed = param1.speedToReach;
               }
            }
            else
            {
               param1.speed -= param1.accelerate * param2;
               if(param1.speed < param1.speedToReach)
               {
                  param1.speed = param1.speedToReach;
               }
            }
         }
         if(param1.speed == 0)
         {
            if(param1.stop && !param1.crashed && param1.lastStopID && param1.lastStopID != -1 && Boolean(this.com.trackPoints[param1.lastStopID].setSpd))
            {
               param1.stop = false;
               param1.speedToReach = param1.lastSpeedToReach;
               this.playSfx("horn");
            }
            return;
         }
         if(param1.carriages[0].overflow)
         {
            this.removeCarriageClip(param1.carriages[0]);
            param1.carriages.splice(0,1);
         }
         else if(param1.carriages[param1.carriages.length - 1].overflow)
         {
            this.removeCarriageClip(param1.carriages[param1.carriages.length - 1]);
            param1.carriages.pop();
         }
         if(!param1.carriages.length)
         {
            param1.leftTheLevel = true;
            ++this.game.clearedCount;
            return;
         }
         _loc3_ = Math.abs(param1.speed * param2);
         param1.totalDistance += _loc3_;
         _loc5_ = (_loc4_ = this.getMovedCarriages(param1,_loc3_)).forwardBogieFirst;
         _loc6_ = _loc4_.forwardBogieNext;
         _loc7_ = _loc4_.forwardTrack;
         _loc8_ = _loc4_.bogieList;
         param1.switchIndices = new Array();
         for each(_loc9_ in _loc8_)
         {
            if(_loc9_.switchIdx)
            {
               param1.switchIndices.push(_loc9_.switchIdx);
            }
         }
         if(!param1.crashed)
         {
            for each(_loc10_ in _loc7_.markerList)
            {
               if(Boolean(_loc10_.turnBack) && (param1.speed > 0 && param1.speedToReach > 0 || param1.speed < 0 && param1.speedToReach < 0))
               {
                  if((_loc12_ = (_loc11_ = param1.speed * param1.speed / (2 * param1.accelerate)) + 20 - _loc10_.distance) > 0)
                  {
                     param1.speedToReach *= -1;
                     break;
                  }
               }
               else if(_loc10_.closed)
               {
                  if((_loc12_ = (_loc11_ = param1.speed * param1.speed / (2 * param1.accelerate)) + 20 - _loc10_.distance) > 0)
                  {
                     param1.speedToReach = 0;
                     this.playSfx("stop");
                     break;
                  }
               }
               else if(Boolean(_loc10_.setSpd) && _loc10_.setSpd < Math.abs(param1.speed))
               {
                  if((param1.speed * param1.speed - _loc10_.setSpd * _loc10_.setSpd) / (2 * param1.accelerate) > _loc10_.distance)
                  {
                     if(param1.speedToReach)
                     {
                        param1.speedToReach = param1.speedToReach / Math.abs(param1.speedToReach) * Math.abs(_loc10_.setSpd);
                     }
                     break;
                  }
               }
               else if(_loc10_.stop && param1.speedToReach != 0 && (param1.lastStopID == undefined || param1.lastStopID != _loc10_.id))
               {
                  if((_loc12_ = (_loc11_ = param1.speed * param1.speed / (2 * param1.accelerate)) + 20 - _loc10_.distance) > 0)
                  {
                     param1.stop = true;
                     param1.lastSpeedToReach = param1.speedToReach;
                     param1.speedToReach = 0;
                     param1.lastStopID = _loc10_.id;
                     this.playSfx("stop");
                     break;
                  }
               }
            }
            if(_loc5_.markerList.length)
            {
               if((_loc10_ = _loc5_.markerList[_loc5_.markerList.length - 1]).setSpd && _loc10_.setSpd > Math.abs(param1.speed) && Math.abs(param1.speed) <= Math.abs(param1.speedToReach))
               {
                  if(param1.speedToReach)
                  {
                     param1.speedToReach = param1.speedToReach / Math.abs(param1.speedToReach) * Math.abs(_loc10_.setSpd);
                  }
               }
            }
            if(_loc6_.markerList.length)
            {
               _loc10_ = _loc6_.markerList[_loc6_.markerList.length - 1];
               if(Boolean(param1.lastStopID) && param1.lastStopID == _loc10_.id)
               {
                  param1.lastStopID = -1;
               }
            }
         }
         this.updateCarriagePositions(param1,_loc8_);
      }
      
      private function playSfx(param1:String) : *
      {
         if(param1 == "stop")
         {
            switch(int(3 * Math.random()))
            {
               case 0:
                  this.gsound.play(SfxStop1);
                  break;
               case 1:
                  this.gsound.play(SfxStop2);
                  break;
               case 2:
                  this.gsound.play(SfxStop3);
            }
         }
         else if(param1 == "crash" && this.isSfxPlayable(param1,1.2))
         {
            switch(int(2 * Math.random()))
            {
               case 0:
                  this.gsound.play(SfxCrash1);
                  break;
               case 1:
                  this.gsound.play(SfxCrash2);
            }
         }
         else if(param1 == "horn")
         {
            switch(int(4 * Math.random()))
            {
               case 0:
                  this.gsound.play(SfxHorn1);
                  break;
               case 1:
                  this.gsound.play(SfxHorn2);
                  break;
               case 2:
                  this.gsound.play(SfxHorn3);
                  break;
               case 3:
                  this.gsound.play(SfxHorn4);
            }
         }
         else if(param1 == "mouseover")
         {
            this.gsound.play(SfxPencilDropLight,false,0,80);
         }
         else if(param1 == "railswitch")
         {
            this.gsound.play(SfxRailSwitch);
         }
         else if(param1 == "railswitcherror")
         {
            this.gsound.play(SfxRailSwitchError);
         }
         else if(param1 == "cowhit")
         {
            this.gsound.play(SfxCowHit1);
         }
         this.sfxList[param1] = this.frame.getTime();
      }
      
      private function spawnFrame(param1:Number) : *
      {
         if(!this.game.enableSpawn)
         {
            return;
         }
         if(this.game.spawnTrainCount >= this.level.totalTrains)
         {
            return;
         }
         if(this.com.isRunningLevel())
         {
            this.spawnTrain(param1);
         }
      }
      
      private function hideTutorial() : *
      {
         while(this.tutorialLayer.numChildren)
         {
            this.tutorialLayer.removeChildAt(0);
         }
      }
      
      private function buildHint1() : *
      {
         var _loc3_:* = undefined;
         var _loc1_:* = new Sprite();
         var _loc2_:* = new Hint1();
         _loc2_.buttonMode = true;
         _loc1_.addChild(_loc2_);
         _loc2_.cow.gotoAndStop(1);
         _loc3_ = "you can control the directions of the cows and get bonus points for saving them in the full version. buy now!";
         this.addHintEventListeners(_loc2_);
         var _loc4_:*;
         (_loc4_ = GWidget.echo(_loc3_,{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":10,
            "align":"left",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":1,
            "multiLine":true
         },170)).x = 10;
         _loc4_.y = 10;
         _loc4_.scaleY = 1.4;
         _loc2_.postit1.addChild(_loc4_);
         return _loc1_;
      }
      
      private function calculateScore() : *
      {
         var _loc2_:* = undefined;
         this.game.clearedScore = this.game.clearedCount * 100;
         this.game.clickScore = -this.game.clickCount * 10;
         this.game.cowScore = 0;
         this.game.levelTotalScore = this.game.clearedScore + this.game.levelSpeedBonus + this.game.cowScore + this.game.clickScore;
         if(!this.level.bestScore)
         {
            this.level.bestScore = 0;
         }
         else
         {
            this.level.played = true;
         }
         if(this.game.levelTotalScore > this.level.bestScore)
         {
            this.level.bestScore = this.game.levelTotalScore;
         }
         var _loc1_:* = 0;
         for each(_loc2_ in this.com.levelData.levelList)
         {
            if(_loc2_.bestScore)
            {
               _loc1_ += _loc2_.bestScore;
            }
         }
         this.game.gameTotalScore = _loc1_;
      }
      
      private function startTrain(param1:Object, param2:Boolean = false) : *
      {
         param1.speedToReach = param1.startSpeed;
         if(param2)
         {
            param1.speed = param1.speedToReach;
         }
      }
      
      private function playAmbient() : *
      {
         this.gsound.stopMusic(this.chnAmbient);
         this.chnAmbient = this.gsound.playMusic(SfxAmbient1);
      }
      
      private function updateSignLayer() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         var _loc15_:* = undefined;
         var _loc16_:* = undefined;
         var _loc17_:* = undefined;
         var _loc18_:* = undefined;
         var _loc19_:* = undefined;
         while(this.signOverLayer.numChildren)
         {
            this.signOverLayer.removeChildAt(0);
         }
         while(this.signLayer.numChildren)
         {
            this.signLayer.removeChildAt(0);
         }
         while(this.switchLayer.numChildren)
         {
            this.switchLayer.removeChildAt(0);
         }
         for each(_loc1_ in this.com.connectPoints)
         {
            this.com.trackPoints[_loc1_].start = undefined;
            this.com.trackPoints[_loc1_].spawn = undefined;
            this.com.trackPoints[_loc1_].out = undefined;
            this.com.trackPoints[_loc1_].closed = undefined;
            this.com.trackPoints[_loc1_].turnSwitch = undefined;
            this.com.trackPoints[_loc1_].hideSwitch = undefined;
            this.com.trackPoints[_loc1_].turnBack = undefined;
            this.com.trackPoints[_loc1_].startLen = undefined;
            this.com.trackPoints[_loc1_].startDir = undefined;
            this.com.trackPoints[_loc1_].spawnMinLen = undefined;
            this.com.trackPoints[_loc1_].spawnMaxLen = undefined;
            this.com.trackPoints[_loc1_].spawnMinDist = undefined;
            this.com.trackPoints[_loc1_].spawnMaxDist = undefined;
            this.com.trackPoints[_loc1_].setSpd = undefined;
            this.com.trackPoints[_loc1_].stop = undefined;
            _loc2_ = this.com.trackPoints[_loc1_];
            if(_loc2_.indices.length > 3)
            {
               trace("Too much connectpnts at [" + int(_loc2_.x) + ";" + int(_loc2_.y) + "]");
            }
            else
            {
               _loc3_ = null;
               for each(_loc4_ in this.markers)
               {
                  if(Math.abs(_loc2_.x - _loc4_.x) < 1 && Math.abs(_loc2_.y - _loc4_.y) < 1)
                  {
                     if(_loc3_)
                     {
                        trace("More marker at [" + int(_loc4_.x) + ";" + int(_loc4_.y) + "]");
                        break;
                     }
                     _loc3_ = _loc4_;
                  }
               }
               if(_loc3_)
               {
                  if(_loc3_.start)
                  {
                     this.com.trackPoints[_loc1_].start = true;
                  }
                  if(_loc3_.spawn)
                  {
                     this.com.trackPoints[_loc1_].spawn = true;
                  }
                  if(_loc3_.out)
                  {
                     this.com.trackPoints[_loc1_].out = true;
                  }
                  if(_loc3_.closed)
                  {
                     this.com.trackPoints[_loc1_].closed = true;
                  }
                  if(_loc3_.turnSwitch)
                  {
                     this.com.trackPoints[_loc1_].turnSwitch = true;
                  }
                  if(_loc3_.hideSwitch)
                  {
                     this.com.trackPoints[_loc1_].hideSwitch = true;
                  }
                  if(_loc3_.turnBack)
                  {
                     this.com.trackPoints[_loc1_].turnBack = true;
                  }
                  if(_loc3_.startLen)
                  {
                     this.com.trackPoints[_loc1_].startLen = _loc3_.startLen;
                  }
                  if(_loc3_.startDir)
                  {
                     this.com.trackPoints[_loc1_].startDir = _loc3_.startDir;
                  }
                  if(_loc3_.spawnMinLen)
                  {
                     this.com.trackPoints[_loc1_].spawnMinLen = _loc3_.spawnMinLen;
                  }
                  if(_loc3_.spawnMaxLen)
                  {
                     this.com.trackPoints[_loc1_].spawnMaxLen = _loc3_.spawnMaxLen;
                  }
                  if(_loc3_.spawnMinDist)
                  {
                     this.com.trackPoints[_loc1_].spawnMinDist = _loc3_.spawnMinDist;
                  }
                  if(_loc3_.spawnMaxDist)
                  {
                     this.com.trackPoints[_loc1_].spawnMaxDist = _loc3_.spawnMaxDist;
                  }
                  if(_loc3_.spd == "norm")
                  {
                     this.com.trackPoints[_loc1_].setSpd = this.com.trainSpeed;
                     _loc3_.sign = SpdSign_norm;
                  }
                  else if(_loc3_.spd == "half")
                  {
                     this.com.trackPoints[_loc1_].setSpd = this.com.trainHalfSpeed;
                     _loc3_.sign = SpdSign_half;
                  }
                  else if(_loc3_.spd == "zero")
                  {
                     this.com.trackPoints[_loc1_].stop = true;
                     _loc3_.sign = SpdSign_stop;
                  }
                  if(_loc3_.spd)
                  {
                     _loc5_ = new _loc3_.sign();
                     _loc3_.rotation = 90 + this.com.snap45Degree(GMath.getVecAngle(new Point(_loc2_.x - this.com.trackPoints[_loc2_.indices[0]].x,_loc2_.y - this.com.trackPoints[_loc2_.indices[0]].y)));
                     _loc5_.x = _loc3_.x;
                     _loc5_.y = _loc3_.y;
                     _loc5_.rotation = _loc3_.rotation;
                     this.signLayer.addChild(_loc5_);
                  }
                  if(_loc2_.indices.length == 1)
                  {
                     _loc6_ = null;
                     if(_loc3_.closed)
                     {
                        _loc6_ = new Rail_close();
                     }
                     else if(_loc3_.turnBack)
                     {
                        _loc6_ = new Rail_turnBack();
                     }
                     else if(_loc3_.start)
                     {
                        _loc6_ = new Rail_start();
                     }
                     else if(_loc3_.spawn)
                     {
                        _loc6_ = new Rail_spawn();
                     }
                     if(_loc6_)
                     {
                        _loc6_.x = _loc3_.x;
                        _loc6_.y = _loc3_.y;
                        _loc6_.rotation = 90 + this.com.snap45Degree(GMath.getVecAngle(new Point(_loc2_.x - this.com.trackPoints[_loc2_.indices[0]].x,_loc2_.y - this.com.trackPoints[_loc2_.indices[0]].y)));
                        this.signLayer.addChild(_loc6_);
                     }
                  }
                  if(_loc2_.indices.length == 3 && !_loc3_.hideSwitch)
                  {
                     _loc7_ = new Point(this.com.trackPoints[_loc2_.indices[0]].x - _loc2_.x,this.com.trackPoints[_loc2_.indices[0]].y - _loc2_.y);
                     _loc8_ = new Point(this.com.trackPoints[_loc2_.indices[1]].x - _loc2_.x,this.com.trackPoints[_loc2_.indices[1]].y - _loc2_.y);
                     _loc9_ = new Point(this.com.trackPoints[_loc2_.indices[2]].x - _loc2_.x,this.com.trackPoints[_loc2_.indices[2]].y - _loc2_.y);
                     _loc10_ = GMath.getVecAngle(_loc7_);
                     _loc11_ = GMath.getVecAngle(_loc8_);
                     _loc12_ = GMath.getVecAngle(_loc9_);
                     _loc13_ = _loc10_ - _loc11_;
                     _loc14_ = _loc10_ - _loc12_;
                     _loc15_ = _loc11_ - _loc12_;
                     if(_loc13_ < 0)
                     {
                        _loc13_ += 360;
                     }
                     if(_loc14_ < 0)
                     {
                        _loc14_ += 360;
                     }
                     if(_loc15_ < 0)
                     {
                        _loc15_ += 360;
                     }
                     if(_loc13_ < 20 || _loc13_ > 340)
                     {
                        _loc16_ = GMath.dot(_loc7_,_loc8_) > 0 ? 0 : 1;
                        _loc17_ = GMath.dot(_loc7_,_loc8_) > 0 ? 1 : 0;
                     }
                     else if(_loc14_ < 20 || _loc14_ > 340)
                     {
                        _loc16_ = GMath.dot(_loc7_,_loc9_) > 0 ? 0 : 2;
                        _loc17_ = GMath.dot(_loc7_,_loc9_) > 0 ? 2 : 0;
                     }
                     else if(_loc15_ < 20 || _loc15_ > 340)
                     {
                        _loc16_ = GMath.dot(_loc8_,_loc9_) > 0 ? 1 : 2;
                        _loc17_ = GMath.dot(_loc8_,_loc9_) > 0 ? 2 : 1;
                     }
                     else
                     {
                        trace("switch angle error");
                     }
                     _loc18_ = this.com.drawSwitchArrow(_loc1_,!!_loc3_.turnSwitch ? _loc2_.indices[_loc16_] : _loc2_.indices[_loc17_]);
                     this.switchLayer.addChild(_loc18_);
                     (_loc19_ = new SwitchSign()).x = _loc3_.x;
                     _loc19_.y = _loc3_.y;
                     _loc19_.rotation = 90 + this.com.snap45Degree(GMath.getVecAngle(new Point(_loc2_.x - this.com.trackPoints[_loc2_.indices[0]].x,_loc2_.y - this.com.trackPoints[_loc2_.indices[0]].y)));
                     this.signLayer.addChild(_loc19_);
                  }
               }
            }
         }
      }
      
      private function showPauseScreen() : *
      {
         var pauseMsg:*;
         this.gameScreen = "pause";
         this.gsound.setSfxVolume(0.35);
         this.pauseScreen = new PauseScreen();
         this.wrapper.addChild(this.pauseScreen);
         pauseMsg = GWidget.echo("Game Paused",{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":24,
            "align":"left",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":1
         });
         pauseMsg.x = 55;
         pauseMsg.y = 20;
         this.pauseScreen.pausePostit.addChild(pauseMsg);
         this.pausePostitX = this.pauseScreen.pausePostit.x;
         this.pauseScreen.pausePostit.x = this.gameWidth;
         this.pauseScreen.pausePostit.continueButton.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            pauseGame(false);
         });
         this.pauseScreen.pausePostit.exitButton.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            pauseGame(false);
            stopAmbient();
            destroyLevel();
            wrapper.removeChild(playScreen);
            showOpenScreen();
         });
         this.pauseScreen.pausePostit.selectLevelButton.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            pauseGame(false);
            stopAmbient();
            destroyLevel();
            wrapper.removeChild(playScreen);
            showSelectLevelScreen();
         });
         this.pauseScreen.pausePostit.moreGamesButton.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            gameStat.goToMyLostGames("",null,"paper_train_pause_PlayMoreGames");
         });
         this.pauseScreen.pausePostit.facebookIcon.buttonMode = true;
         this.pauseScreen.pausePostit.facebookIcon.addEventListener(MouseEvent.CLICK,function(param1:*):*
         {
            gsound.play(Click);
            network.gotoURL(facebookURL);
         });
         this.pauseScreen.pausePostit.twitterIcon.buttonMode = true;
         this.pauseScreen.pausePostit.twitterIcon.addEventListener(MouseEvent.CLICK,function(param1:*):*
         {
            gsound.play(Click);
            network.gotoURL(twitterURL);
         });
         this.blurPlayScreen(true);
      }
      
      private function removeCows() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         for each(_loc1_ in this.cowGroups)
         {
            for each(_loc2_ in _loc1_.cows)
            {
               this.removeCow(_loc2_);
            }
         }
         this.cowGroups = new Array();
         while(this.cowRadiusLayer.numChildren)
         {
            this.cowRadiusLayer.removeChildAt(0);
         }
      }
      
      private function updateCarriagePositions(param1:Object, param2:Array) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:int = 0;
         if(param1.speed > 0)
         {
            _loc3_ = param1.carriages.length - 1;
            while(_loc3_ >= 0)
            {
               _loc4_ = param1.carriages[_loc3_];
               _loc6_ = param2[_loc8_++];
               if(!(_loc5_ = param2[_loc8_++]).overflow && !_loc6_.overflow)
               {
                  _loc4_.bogie2.p1 = _loc6_.dFirst;
                  _loc4_.bogie2.p2 = _loc6_.dNext;
                  _loc4_.bogie2.pOffs = _loc6_.dOffs;
                  _loc4_.bogie2.pRevOffs = _loc6_.dRevOffs;
                  _loc4_.bogie2.pnt = _loc6_.dPoint;
                  _loc4_.bogie1.p1 = _loc5_.dFirst;
                  _loc4_.bogie1.p2 = _loc5_.dNext;
                  _loc4_.bogie1.pOffs = _loc5_.dOffs;
                  _loc4_.bogie1.pRevOffs = _loc5_.dRevOffs;
                  _loc4_.bogie1.pnt = _loc5_.dPoint;
                  _loc7_ = GMath.getVecAngle(new Point(_loc6_.dPoint.x - _loc5_.dPoint.x,_loc6_.dPoint.y - _loc5_.dPoint.y));
                  _loc4_.x = _loc5_.dPoint.x;
                  _loc4_.y = _loc5_.dPoint.y;
                  _loc4_.rotation = _loc7_;
                  this.refreshCarriageClip(param1,_loc4_,_loc5_.dPoint.x,_loc5_.dPoint.y,_loc7_,_loc3_);
               }
               else
               {
                  _loc4_.overflow = true;
                  _loc4_.clip.visible = false;
                  _loc4_.shadow.visible = false;
                  _loc4_.hit.visible = false;
               }
               _loc3_--;
            }
         }
         else
         {
            _loc3_ = 0;
            while(_loc3_ < param1.carriages.length)
            {
               _loc4_ = param1.carriages[_loc3_];
               _loc5_ = param2[_loc8_++];
               _loc6_ = param2[_loc8_++];
               if(!_loc5_.overflow && !_loc6_.overflow)
               {
                  _loc4_.bogie1.p2 = _loc5_.dFirst;
                  _loc4_.bogie1.p1 = _loc5_.dNext;
                  _loc4_.bogie1.pRevOffs = _loc5_.dOffs;
                  _loc4_.bogie1.pOffs = _loc5_.dRevOffs;
                  _loc4_.bogie1.pnt = _loc5_.dPoint;
                  _loc4_.bogie2.p2 = _loc6_.dFirst;
                  _loc4_.bogie2.p1 = _loc6_.dNext;
                  _loc4_.bogie2.pRevOffs = _loc6_.dOffs;
                  _loc4_.bogie2.pOffs = _loc6_.dRevOffs;
                  _loc4_.bogie2.pnt = _loc6_.dPoint;
                  _loc7_ = GMath.getVecAngle(new Point(_loc6_.dPoint.x - _loc5_.dPoint.x,_loc6_.dPoint.y - _loc5_.dPoint.y));
                  _loc4_.x = _loc5_.dPoint.x;
                  _loc4_.y = _loc5_.dPoint.y;
                  _loc4_.rotation = _loc7_;
                  this.refreshCarriageClip(param1,_loc4_,_loc5_.dPoint.x,_loc5_.dPoint.y,_loc7_,_loc3_);
               }
               else
               {
                  _loc4_.overflow = true;
                  _loc4_.clip.visible = false;
                  _loc4_.shadow.visible = false;
                  _loc4_.hit.visible = false;
               }
               _loc3_++;
            }
         }
      }
      
      private function showSubmitScoreScreen() : *
      {
         var ptsTotalMsg:*;
         var inputWidget:*;
         var inputMsg:*;
         var submitScoreScreen:* = undefined;
         var postitWidth:* = undefined;
         var widgetLayer:* = undefined;
         var nameTextField:* = undefined;
         this.gameScreen = "submitscore";
         submitScoreScreen = new SubmitScoreScreen();
         this.wrapper.addChild(submitScoreScreen);
         postitWidth = 460;
         widgetLayer = new Sprite();
         widgetLayer.scaleY = 1.4;
         submitScoreScreen.postit.addChild(widgetLayer);
         ptsTotalMsg = GWidget.echo("your score: " + this.game.gameTotalScore.toString(),{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":20,
            "align":"center",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":1
         },postitWidth);
         ptsTotalMsg.x = 0;
         ptsTotalMsg.y = 40;
         widgetLayer.addChild(ptsTotalMsg);
         inputWidget = new GWidget({
            "font":this.guiFont,
            "color":16777215,
            "size":18,
            "align":"left",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":2,
            "inputField":true,
            "inputFieldMaxChars":16,
            "restrictChars":" A-Za-z0-9.\'"
         });
         inputMsg = inputWidget.print("",290,25);
         inputMsg.x = 95;
         inputMsg.y = 70;
         widgetLayer.addChild(inputMsg);
         nameTextField = inputWidget.getTextField();
         stage.focus = nameTextField;
         this.stopAmbient();
         submitScoreScreen.postit.checkIcon.visible = false;
         submitScoreScreen.postit.submitScoreButton.addEventListener(MouseEvent.CLICK,function():*
         {
            var _loc2_:* = undefined;
            gsound.play(Click);
            var _loc1_:* = GString.trim(nameTextField.text);
            if(_loc1_.length)
            {
               gameStat.setHighScore(game.gameTotalScore,0,_loc1_);
               submitScoreScreen.postit.submitScoreButton.visible = false;
               submitScoreScreen.postit.checkIcon.visible = true;
               _loc2_ = GWidget.echo("score saved",{
                  "font":guiFont,
                  "color":guiFontColor,
                  "size":16,
                  "align":"center",
                  "margin":0,
                  "embed":true,
                  "antiAlias":true,
                  "letterSpacing":1
               },postitWidth);
               _loc2_.x = 0;
               _loc2_.y = 95;
               widgetLayer.addChild(_loc2_);
            }
         });
         submitScoreScreen.postit.nextLevelButton.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            blurPlayScreen(false);
            destroyLevel();
            gameScreen = "play";
            ++levelId;
            loadLevel();
            wrapper.removeChild(submitScoreScreen);
         });
         submitScoreScreen.postit.selectLevelButton.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            blurPlayScreen(false);
            destroyLevel();
            wrapper.removeChild(submitScoreScreen);
            wrapper.removeChild(playScreen);
            showSelectLevelScreen();
         });
         submitScoreScreen.postit.fullVersionButton.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            blurPlayScreen(false);
            destroyLevel();
            wrapper.removeChild(submitScoreScreen);
            wrapper.removeChild(playScreen);
            showFullVersionScreen();
         });
         submitScoreScreen.postit.continueButton.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            wrapper.removeChild(submitScoreScreen);
            showCongratScreen();
         });
         this.blurPlayScreen(true);
         if(this.levelId == this.com.levelData.numFreeLevel)
         {
            submitScoreScreen.postit.nextLevelButton.visible = false;
            submitScoreScreen.postit.selectLevelButton.visible = false;
            submitScoreScreen.postit.fullVersionButton.visible = false;
         }
         else
         {
            submitScoreScreen.postit.continueButton.visible = false;
         }
      }
      
      private function setupFullVerShot(param1:*) : *
      {
         var _loc2_:* = new param1();
         _loc2_.x = (this.gameWidth - _loc2_.width) / 2;
         _loc2_.y = 140;
         _loc2_.rotation = 2;
         return _loc2_;
      }
      
      private function showSelectLevelScreen() : *
      {
         var py:*;
         var corner:*;
         var gui:*;
         var selectLevelScreen:* = undefined;
         var px:* = undefined;
         var levelCount:* = undefined;
         var freeLevel:* = undefined;
         var postit:* = undefined;
         var levelMsg:* = undefined;
         var pcrot:* = undefined;
         var pcx:* = undefined;
         var pcy:* = undefined;
         this.gameScreen = "selectlevel";
         while(this.wrapper.numChildren)
         {
            this.wrapper.removeChildAt(0);
         }
         selectLevelScreen = new SelectLevelScreen();
         this.wrapper.addChild(selectLevelScreen);
         gui = this.buildGUI(selectLevelScreen);
         selectLevelScreen.addChild(gui);
         corner = new Point(125,145);
         py = 0;
         while(py < 5)
         {
            px = 0;
            while(px < 6)
            {
               if((py & 1) == 0)
               {
                  levelCount = 1 + py * 6 + px;
               }
               else
               {
                  levelCount = 1 + py * 6 + 5 - px;
               }
               freeLevel = this.isLevelAvailable(levelCount);
               postit = new Object();
               postit.shadow = new SelectLevelPostitShadow();
               postit.shadow.x = 4;
               postit.shadow.y = 4;
               postit.paper = new Sprite();
               postit.button = new SelectLevelPostit();
               postit.button.alpha = 0;
               postit.button.buttonMode = true;
               levelMsg = GWidget.echo(GString.prefill(levelCount.toString(),"0",2),{
                  "font":this.guiFont,
                  "color":this.guiFontColor,
                  "size":20,
                  "align":"left",
                  "margin":0,
                  "embed":true,
                  "antiAlias":true,
                  "letterSpacing":1
               });
               levelMsg.x = -22;
               levelMsg.y = -16;
               levelMsg.scaleY = 1.4;
               pcrot = -12 - 8 * Math.random();
               pcx = 5 * Math.random();
               pcy = 10 + 5 * Math.random();
               if(freeLevel)
               {
                  postit.clip = new SelectLevelPostit();
               }
               else
               {
                  postit.clip = new SelectLevelGrayPostit();
                  postit.paperclipback = new SelectLevelPaperClipBack();
                  postit.paperclipback.x = pcx;
                  postit.paperclipback.y = pcy;
                  postit.paperclipback.rotation = pcrot;
                  postit.paper.addChild(postit.paperclipback);
               }
               postit.paper.addChild(postit.clip);
               postit.paper.addChild(levelMsg);
               if(!freeLevel)
               {
                  postit.paperclipfront = new SelectLevelPaperClip();
                  postit.paperclipfront.x = pcx;
                  postit.paperclipfront.y = pcy;
                  postit.paperclipfront.rotation = pcrot;
                  postit.paper.addChild(postit.paperclipfront);
               }
               postit.layer = new Sprite();
               postit.layer.x = corner.x + px * 90 + int(3 * px + 5 * py) % 4;
               postit.layer.y = corner.y + py * 70 + int(3 * px + 5 * py + 1) % 4;
               postit.layer.rotation = -2 + int(3 * px + 5 * py) % 4;
               postit.layer.addChild(postit.shadow);
               postit.layer.addChild(postit.paper);
               if(freeLevel)
               {
                  postit.layer.addChild(postit.button);
               }
               selectLevelScreen.addChild(postit.layer);
               if(freeLevel)
               {
                  this.addSelectLevelEvents(postit,selectLevelScreen,levelCount);
               }
               px++;
            }
            py++;
         }
         selectLevelScreen.buttonMyLostGames.addEventListener(MouseEvent.CLICK,function(param1:*):*
         {
            gsound.play(Click);
            gameStat.goToMyLostGames("",null,"paper_train_selectlevel_MyLostGames");
         });
         selectLevelScreen.fullVersionButton.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            wrapper.removeChild(selectLevelScreen);
            showFullVersionScreen();
         });
         selectLevelScreen.decor.decor1.visible = false;
      }
      
      private function levelFailed() : *
      {
         if(Boolean(this.game.levelFailed) || Boolean(this.game.levelCleared))
         {
            return;
         }
         this.game.menuDisabled = false;
         this.game.levelFailed = true;
         this.com.runningLevel = false;
         this.showLevelFailedScreen();
      }
      
      private function removeLevelBlocks() : *
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this.levelBlockLayers)
         {
            if(_loc1_.type == "track")
            {
               this.trackLayer.removeChild(_loc1_.clip);
            }
            else if(_loc1_.type == "object")
            {
               this.objectLayer.removeChild(_loc1_.clip);
            }
         }
         this.levelBlockLayers = new Array();
      }
      
      private function addCarriageClip(param1:Object) : *
      {
         this.trainShadowLayer.addChild(param1.shadow);
         this.trainLayer.addChild(param1.clip);
         this.trainLayer.addChild(param1.hit);
      }
      
      private function destroyStartScreen() : *
      {
         this.guiScreen.levelPostit.visible = true;
         this.guiScreen.clearedPostit.visible = true;
         this.guiScreen.clicksPostit.visible = true;
         this.guiScreen.spdPostit.visible = true;
         this.gameScreen = "play";
         stage.focus = this.playScreen;
         this.wrapper.removeChild(this.levelStartScreen);
         this.runLevel();
      }
      
      private function removeTrains() : *
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this.com.trains)
         {
            this.removeTrainClip(_loc1_);
         }
         while(this.com.trains.length)
         {
            this.com.trains.pop();
         }
      }
      
      private function pauseFrame(param1:Number) : *
      {
         if(!this.pauseScreen)
         {
            return;
         }
         this.pauseScreen.pausePostit.x -= 2500 * param1;
         if(this.pauseScreen.pausePostit.x < this.pausePostitX)
         {
            this.pauseScreen.pausePostit.x = this.pausePostitX;
         }
      }
      
      private function pauseGame(param1:Boolean) : *
      {
         if(!this.frame.isPaused() && this.gameScreen != "play")
         {
            return;
         }
         this.frame.pause(param1);
         if(param1)
         {
            this.guiScreen.pause.pauseButton.gotoAndStop("play");
            this.com.runningLevel = false;
            this.stopAmbient();
         }
         else
         {
            this.guiScreen.pause.pauseButton.gotoAndStop("pause");
            this.com.runningLevel = true;
            this.playAmbient();
         }
      }
      
      private function clearedFrame(param1:Number) : *
      {
         if(!this.levelClearedScreen)
         {
            return;
         }
         this.levelClearedScreen.clearedPostit.x -= 2500 * param1;
         if(this.levelClearedScreen.clearedPostit.x < this.clearedPostitX)
         {
            this.levelClearedScreen.clearedPostit.x = this.clearedPostitX;
         }
      }
      
      private function addCow(param1:Object) : *
      {
         var _loc2_:* = new Object();
         param1.cows.push(_loc2_);
         _loc2_.alive = true;
         _loc2_.layer = new Sprite();
         _loc2_.clip = new Cow();
         _loc2_.clip.gotoAndStop(1);
         _loc2_.shadow = new CowShadow();
         _loc2_.layer.addChild(_loc2_.shadow);
         _loc2_.layer.addChild(_loc2_.clip);
         var _loc3_:* = new Point(Math.random(),Math.random());
         _loc3_.normalize(0.95 * param1.radius * Math.random());
         var _loc4_:* = param1.center.x + _loc3_.x;
         var _loc5_:* = param1.center.y + _loc3_.y;
         _loc2_.pos = new Point(_loc4_,_loc5_);
         this.randomizeCowDirection(_loc2_);
         _loc2_.spd = 0;
         this.addCowStartEvent(_loc2_,true);
         this.cowLayer.addChild(_loc2_.layer);
         ++this.game.totalCows;
      }
      
      private function outMarker(param1:Object) : *
      {
         if(!this.com.runningLevel)
         {
            return;
         }
         while(this.signOverLayer.numChildren)
         {
            this.signOverLayer.removeChildAt(0);
         }
      }
      
      private function showLevelFailedScreen() : *
      {
         this.gameScreen = "levelfailed";
         this.levelFailedScreen = new LevelFailedScreen();
         this.wrapper.addChild(this.levelFailedScreen);
         this.stopAmbient();
         this.failedPostitX = this.levelFailedScreen.failedPostit.x;
         this.levelFailedScreen.failedPostit.x = this.gameWidth;
         this.levelFailedScreen.failedPostit.restartButton.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            blurPlayScreen(false);
            startLevel(true);
            gameScreen = "play";
            wrapper.removeChild(levelFailedScreen);
         });
         this.levelFailedScreen.failedPostit.selectLevelButton.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            blurPlayScreen(false);
            destroyLevel();
            wrapper.removeChild(levelFailedScreen);
            wrapper.removeChild(playScreen);
            showSelectLevelScreen();
         });
         this.levelFailedScreen.failedPostit.fullVersionButton.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            blurPlayScreen(false);
            destroyLevel();
            wrapper.removeChild(levelFailedScreen);
            wrapper.removeChild(playScreen);
            showFullVersionScreen();
         });
         this.blurPlayScreen(true);
      }
      
      private function resetMarkers() : *
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this.markers)
         {
            if(_loc1_.initial)
            {
               _loc1_.turnSwitch = _loc1_.initial.turnSwitch;
               _loc1_.spd = _loc1_.initial.spd;
            }
         }
         this.updateSignLayer();
      }
      
      private function crashEvent() : *
      {
         if(this.game.trainCollision)
         {
            return;
         }
         this.game.trainCollision = true;
         this.game.enableSpawn = false;
      }
      
      private function embedWidgetStyle(param1:int, param2:int) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         _loc3_ = 2;
         _loc4_ = param1 + _loc3_;
         _loc5_ = param2 + _loc3_;
         _loc6_ = -_loc3_ / 2;
         _loc7_ = param1 + _loc3_ / 2;
         _loc8_ = param2 + _loc3_ / 2;
         (_loc9_ = new Sprite()).graphics.lineStyle(_loc3_,0,1,true,LineScaleMode.NORMAL,CapsStyle.ROUND,JointStyle.ROUND);
         _loc9_.graphics.moveTo(_loc6_,_loc6_);
         _loc9_.graphics.lineTo(_loc6_,_loc8_);
         _loc9_.graphics.lineTo(_loc7_,_loc8_);
         _loc9_.graphics.lineTo(_loc7_,_loc6_);
         _loc9_.graphics.lineTo(_loc6_,_loc6_);
         (_loc10_ = new Sprite()).graphics.beginFill(16777215,0.7);
         _loc10_.graphics.drawRect(0,0,_loc4_ - _loc3_,_loc5_ - _loc3_);
         (_loc11_ = new Sprite()).addChild(_loc9_);
         _loc11_.addChild(_loc10_);
         return _loc11_;
      }
      
      private function stopTrain(param1:Object, param2:Boolean = false) : *
      {
         param1.speedToReach = 0;
         if(param2)
         {
            param1.speed = param1.speedToReach;
         }
      }
      
      private function stopMusic() : *
      {
         this.gsound.stopMusic(this.chnMenuMusic);
         this.gsound.stopMusic(this.chnGameMusic);
      }
      
      private function failedFrame(param1:Number) : *
      {
         if(!this.levelFailedScreen)
         {
            return;
         }
         this.levelFailedScreen.failedPostit.x -= 2500 * param1;
         if(this.levelFailedScreen.failedPostit.x < this.failedPostitX)
         {
            this.levelFailedScreen.failedPostit.x = this.failedPostitX;
         }
      }
      
      private function spawnTrain(param1:Number) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         for(_loc2_ in this.com.trackPoints)
         {
            _loc3_ = this.com.trackPoints[_loc2_];
            if(_loc3_.spawn)
            {
               _loc3_.trainDistanceFromThis += this.com.trainSpeed * param1;
               _loc4_ = this.getNumCarriagesForSpawn(_loc3_);
               _loc5_ = this.getTrainLong(_loc4_);
               if(_loc3_.trainDistanceFromThis >= this.getNextSpawnDistance(_loc3_,_loc5_))
               {
                  if(_loc6_ = this.AddTrain(_loc2_,_loc4_))
                  {
                     ++this.game.spawnTrainCount;
                     this.startTrain(_loc6_,true);
                     _loc3_.firstSpawn = false;
                     _loc3_.nextSpawnDistance = 0;
                     _loc3_.numCarriagesForSpawn = 0;
                  }
               }
            }
         }
      }
      
      private function playMusic(param1:String) : *
      {
         if(param1 == this.musicType)
         {
            return;
         }
         this.musicType = param1;
         this.gsound.stopMusic(this.chnMenuMusic);
         this.gsound.stopMusic(this.chnGameMusic);
         if(param1 == "menu")
         {
            this.chnMenuMusic = this.gsound.playMusic(MusicMenu);
         }
         else if(param1 == "game")
         {
            this.chnGameMusic = this.gsound.playMusic(MusicGame);
         }
      }
      
      private function checkHostCallBack(param1:Boolean) : *
      {
         this.ownHost = param1;
         this.continueGame();
      }
      
      private function permanentFrame(param1:Number) : *
      {
         if(this.gameScreen == "pause")
         {
            this.pauseFrame(param1);
         }
         if(this.gameScreen == "levelfailed")
         {
            this.failedFrame(param1);
         }
         if(this.gameScreen == "levelcleared")
         {
            this.clearedFrame(param1);
         }
      }
      
      private function calcTrainSpeed() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:* = 35;
         switch(this.game.levelSpeed)
         {
            case 1:
               _loc1_ = 35;
               break;
            case 2:
               _loc1_ = 45;
               break;
            case 3:
               _loc1_ = 60;
               break;
            case 4:
               _loc1_ = 75;
         }
         this.com.trainSpeed = _loc1_;
         this.com.trainHalfSpeed = _loc1_ / 2;
         var _loc3_:* = _loc1_ / _loc2_;
         this.trainAccelerate = 50 * _loc3_;
         this.trainCrashAccelerate = 90 * _loc3_;
         this.forwardTrackLen = 35 * _loc3_;
      }
      
      private function removeTrainClip(param1:Object) : *
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in param1.carriages)
         {
            this.removeCarriageClip(_loc2_);
         }
      }
      
      private function isLevelAvailable(param1:int) : *
      {
         if(param1 > 6)
         {
            return false;
         }
         var _loc2_:* = this.com.levelData.levelList[param1 - 1];
         if(!_loc2_.available)
         {
            return false;
         }
         return true;
      }
      
      private function startGame(param1:int) : *
      {
         this.levelId = param1;
         this.showPlayScreen();
      }
      
      private function showTutorial() : *
      {
         this.hideTutorial();
         var _loc1_:* = null;
         if(this.levelId == 1)
         {
            _loc1_ = this.buildTutorial1();
         }
         else if(this.levelId == 2)
         {
            _loc1_ = this.buildTutorial2();
         }
         else if(this.levelId == 8)
         {
            _loc1_ = this.buildTutorial3();
         }
         else if(this.levelId == 4)
         {
            _loc1_ = this.buildHint1();
         }
         if(_loc1_ !== null)
         {
            _loc1_.x = this.com.backgroundXOffset;
            _loc1_.y = this.com.backgroundYOffset;
            this.tutorialLayer.addChild(_loc1_);
         }
      }
      
      private function buildTrack() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         for each(_loc1_ in this.levelBlockLayers)
         {
            if(_loc1_.type == "track")
            {
               _loc3_ = this.com.trackPoints.length;
               for(_loc4_ in _loc1_.proto.pnts)
               {
                  _loc5_ = _loc1_.proto.pnts[_loc4_];
                  for(_loc6_ in _loc1_.proto.connectpnts)
                  {
                     if(_loc1_.proto.connectpnts[_loc6_] == _loc4_)
                     {
                        this.com.connectPoints.push(_loc4_ + _loc3_);
                     }
                  }
                  this.com.addTrackPoint(_loc5_,_loc1_,_loc3_);
               }
               this.com.mergeConnectPoints();
            }
         }
         for each(_loc2_ in this.com.connectPoints)
         {
            this.com.trackPoints[_loc2_].isConnectPoint = true;
         }
         this.updateSignLayer();
      }
      
      private function continueGame() : *
      {
         var vars:* = this.gameStat.restoreGameVars();
         if(vars && vars.sfx != undefined)
         {
            this.gameVars.sfx = vars.sfx;
         }
         else
         {
            this.gameVars.sfx = 1;
         }
         this.restoreLevels(vars);
         this.gsound = new GSoundSimple(this.gameVars.sfx);
         this.gsound.setSfxSwitchCallback(this.sfxSwitched);
         this.chnAmbient = null;
         this.chnMenuMusic = null;
         this.chnGameMusic = null;
         this.musicType = null;
         this.sfxList = new Object();
         this.curveData = new CurveData(this);
         this.network = new GNetwork();
         this.input = new GInput(stage,{
            "mouseClick":this.mouseClick,
            "mouseMove":this.mouseMove,
            "keyDown":this.keyDown
         });
         this.frame = new GFrame(this.enterFrame,this.fixFrame,this.pauseEvent,this.physics_frame_rate);
         this.frame.addPermanentFrame(this.permanentFrame);
         this.wrapper = new Sprite();
         this.mouseCursor = new MouseCursor();
         addChild(this.wrapper);
         this.gameScreen = "";
         this.game = new Object();
         this.game.gameTotalScore = 0;
         this.hiScores = new Array();
         this.hiScoresUpdated = false;
         this.hiScoresLoading = false;
         this.showOpenScreen();
         this.frame.addTimer(0.25,function():*
         {
            spawnFrame(0.25);
         },0);
         this.frame.addTimer(0.2,function():*
         {
            cowHitFrame(0.2);
         },0);
      }
      
      private function toggleSpeedMarker(param1:Object) : *
      {
         if(param1.spd == "norm")
         {
            if(param1.halfSpd)
            {
               param1.spd = "half";
            }
            else if(param1.zeroSpd)
            {
               param1.spd = "zero";
            }
         }
         else if(param1.spd == "half")
         {
            if(param1.zeroSpd)
            {
               param1.spd = "zero";
            }
            else if(param1.normSpd)
            {
               param1.spd = "norm";
            }
         }
         else if(param1.spd == "zero")
         {
            if(param1.normSpd)
            {
               param1.spd = "norm";
            }
            else if(param1.halfSpd)
            {
               param1.spd = "half";
            }
         }
         this.updateSignLayer();
      }
      
      private function getLevelName() : *
      {
         return "Level " + this.levelId;
      }
      
      private function trainCrashed(param1:Object, param2:Point) : *
      {
         this.crashEvent();
         if(param1.crashed)
         {
            return;
         }
         param1.crashed = true;
         param1.collision = new Object();
         param1.collision.carriages = new Array();
         param1.speedToReach = 0;
         param1.accelerate = this.trainCrashAccelerate;
         this.playSfx("crash");
         this.playEffect("crash",param2);
         if(!this.game.trainCrashed)
         {
            this.game.trainCrashed = true;
            this.game.menuDisabled = true;
            this.frame.addTimer(4,this.levelFailed);
         }
      }
      
      private function addCowGroup(param1:*, param2:*, param3:*) : *
      {
         var _loc4_:* = new Object();
         this.cowGroups.push(_loc4_);
         _loc4_.cows = new Array();
         _loc4_.center = new Point(param2,param3);
         _loc4_.radius = 80;
         _loc4_.radiusClip = this.BuildRadiusClip(_loc4_);
         this.cowRadiusLayer.addChild(_loc4_.radiusClip);
         var _loc5_:* = 4;
         var _loc6_:* = 0;
         while(_loc6_ < _loc5_)
         {
            this.addCow(_loc4_);
            _loc6_++;
         }
      }
      
      private function levelCleared() : *
      {
         if(Boolean(this.game.levelCleared) || Boolean(this.game.levelFailed) || Boolean(this.game.trainCrashed))
         {
            return;
         }
         this.game.levelCleared = true;
         this.com.runningLevel = false;
         this.calculateScore();
         if(this.isLastLevel(this.levelId))
         {
            this.showLevelClearedScreen();
         }
         else
         {
            this.enableLevel(this.levelId + 1);
            this.saveAvailableLevels();
            this.showLevelClearedScreen();
         }
      }
      
      private function showCongratScreen() : *
      {
         var congratMsg:*;
         var postitWidth:*;
         var widgetLayer:*;
         var followMsg:*;
         var congratScreen:* = undefined;
         var cmsg:* = undefined;
         var fmsg:* = undefined;
         this.gameScreen = "congrat";
         congratScreen = new CongratScreen();
         this.wrapper.addChild(congratScreen);
         postitWidth = 460;
         widgetLayer = new Sprite();
         widgetLayer.scaleY = 1.4;
         congratScreen.postit.addChild(widgetLayer);
         cmsg = "congratulations, traffic control expert! you have successfully finished the first 7 levels. your journey ends here, for now. but do you think you’re good enough to continue?! do you want to be the traffic control master? let’s see, shall we?!";
         congratMsg = GWidget.echo(cmsg,{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":10,
            "align":"left",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":1,
            "multiLine":true
         },270);
         congratMsg.x = 20;
         congratMsg.y = 20;
         congratMsg.scaleY = 1.4;
         widgetLayer.addChild(congratMsg);
         fmsg = "follow us on facebook and<br/>win the full version!";
         followMsg = GWidget.echo(fmsg,{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":10,
            "align":"left",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":1,
            "multiLine":true
         },400);
         followMsg.x = 145;
         followMsg.y = 232;
         followMsg.scaleY = 1.4;
         widgetLayer.addChild(followMsg);
         congratScreen.postit.badge.gotoAndStop(1);
         this.stopAmbient();
         congratScreen.postit.fullVersionButton.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            blurPlayScreen(false);
            destroyLevel();
            wrapper.removeChild(congratScreen);
            wrapper.removeChild(playScreen);
            showFullVersionScreen();
         });
         congratScreen.postit.newGameButton.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            blurPlayScreen(false);
            destroyLevel();
            wrapper.removeChild(congratScreen);
            wrapper.removeChild(playScreen);
            showOpenScreen();
         });
         congratScreen.postit.facebookIcon.buttonMode = true;
         congratScreen.postit.facebookIcon.addEventListener(MouseEvent.CLICK,function(param1:*):*
         {
            gsound.play(Click);
            network.gotoURL(facebookURL);
         });
         congratScreen.postit.twitterIcon.buttonMode = true;
         congratScreen.postit.twitterIcon.addEventListener(MouseEvent.CLICK,function(param1:*):*
         {
            gsound.play(Click);
            network.gotoURL(twitterURL);
         });
         congratScreen.postit.newGameButton.visible = false;
         this.blurPlayScreen(true);
      }
      
      public function resetLevel() : *
      {
         this.game.trainCollision = false;
         this.game.enableSpawn = true;
         this.game.clearedCount = 0;
         this.game.levelCleared = false;
         this.game.levelFailed = false;
         this.game.menuDisabled = false;
         this.game.trainCrashed = false;
         this.game.spawnTrainCount = 0;
         this.game.clickCount = 0;
         this.resetParticles();
      }
      
      private function showFullVersionScreen() : *
      {
         var fvMsg1:*;
         var corner:*;
         var fullversion:*;
         var gui:*;
         var fullversionScreen:* = undefined;
         var fullVerShot:* = undefined;
         this.gameScreen = "fullversion";
         while(this.wrapper.numChildren)
         {
            this.wrapper.removeChildAt(0);
         }
         fullversionScreen = new FullVersionScreen();
         this.wrapper.addChild(fullversionScreen);
         gui = this.buildGUI(fullversionScreen);
         fullversionScreen.addChild(gui);
         corner = new Point(30,25);
         fullversion = "the full version of paper train offers more levels, more graphics, more features, and you get to play any level at any time. you can also get bonus points at more difficult levels for handling new obstacles (e.g. cows, airplanes) and faster trains.<br/><br/>" + "full version of the game offers:<br/><br/>" + "- 30 different levels<br/>" + "- flexible selection of levels<br/>" + "- 4 levels of train speed<br/>" + "- extra obstacles<br/>" + "- more graphics<br/>" + "- more sound effects<br/>" + "- better quality music and sound effects<br/>" + "- no advertisements<br/><br/>" + "in full version you can select speed and levels as you wish and improve your game at your own pace.<br/><br/>" + "use your talent and skills to create the most difficult journey and reach the highest scores!";
         fvMsg1 = GWidget.echo(fullversion,{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":11,
            "align":"left",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":1,
            "multiLine":true
         },580);
         fvMsg1.x = corner.x;
         fvMsg1.y = corner.y;
         fvMsg1.scaleY = 1.4;
         fvMsg1.rotation = -0.5;
         fullversionScreen.postit.addChild(fvMsg1);
         fullversionScreen.postit.continueButton.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            wrapper.removeChild(fullversionScreen);
            showFullVersionScreen2();
         });
      }
      
      private function showFullVersionScreen2() : *
      {
         var fvMsg1:*;
         var fvMsg2:*;
         var moreinfo:*;
         var fvMsg4:*;
         var fvMsg3:*;
         var paypalmsg:*;
         var amountmsg:*;
         var buymsg:*;
         var gui:*;
         var fullversionScreen:* = undefined;
         var fullVerShot:* = undefined;
         this.gameScreen = "fullversion";
         while(this.wrapper.numChildren)
         {
            this.wrapper.removeChildAt(0);
         }
         fullversionScreen = new FullVersionScreen2();
         this.wrapper.addChild(fullversionScreen);
         gui = this.buildGUI(fullversionScreen);
         fullversionScreen.addChild(gui);
         moreinfo = "for more details and screenshots<br/> before purchasing, click here!";
         fvMsg1 = GWidget.echo(moreinfo,{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":17,
            "align":"center",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":1,
            "multiLine":true
         },640);
         fvMsg1.x = 0;
         fvMsg1.y = 145;
         fvMsg1.scaleY = 1.5;
         fullversionScreen.postit.addChild(fvMsg1);
         fvMsg1.buttonMode = true;
         fvMsg1.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            network.gotoURL(fullVersionURL);
         });
         paypalmsg = "paypal accepts most major credit cards. after payment, you will be directed to the full version page. the link to the full version will also be sent to you via e-mail within an hour. should you not receive the e-mail, please contact us and we will assist you.";
         fvMsg2 = GWidget.echo(paypalmsg,{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":10,
            "align":"left",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":1,
            "multiLine":true
         },580);
         fvMsg2.x = 30;
         fvMsg2.y = 270;
         fvMsg2.scaleY = 1.4;
         fullversionScreen.postit.addChild(fvMsg2);
         buymsg = "buy the full version of papertrain now for just";
         fvMsg3 = GWidget.echo(buymsg,{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":10,
            "align":"left",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":1,
            "multiLine":true
         },580);
         fvMsg3.x = 30;
         fvMsg3.y = 360;
         fvMsg3.scaleY = 1.4;
         fullversionScreen.postit.addChild(fvMsg3);
         amountmsg = "$6.99!";
         fvMsg4 = GWidget.echo(amountmsg,{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":16,
            "align":"left",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":1,
            "multiLine":true
         },580);
         fvMsg4.x = 520;
         fvMsg4.y = 353;
         fvMsg4.scaleY = 1.4;
         fullversionScreen.postit.addChild(fvMsg4);
         fullversionScreen.postit.thumb1.buttonMode = true;
         fullversionScreen.postit.thumb2.buttonMode = true;
         fullversionScreen.postit.thumb3.buttonMode = true;
         fullversionScreen.postit.thumb4.buttonMode = true;
         fullversionScreen.postit.thumb1.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            network.gotoURL(fullVersionURL);
         });
         fullversionScreen.postit.thumb2.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            network.gotoURL(fullVersionURL);
         });
         fullversionScreen.postit.thumb3.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            network.gotoURL(fullVersionURL);
         });
         fullversionScreen.postit.thumb4.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            network.gotoURL(fullVersionURL);
         });
         fullversionScreen.postit.thumb1.addEventListener(MouseEvent.MOUSE_OVER,function():*
         {
            playSfx("mouseover");
            fullVerShot = setupFullVerShot(FullVerShot1);
            fullversionScreen.postit.addChild(fullVerShot);
         });
         fullversionScreen.postit.thumb2.addEventListener(MouseEvent.MOUSE_OVER,function():*
         {
            playSfx("mouseover");
            fullVerShot = setupFullVerShot(FullVerShot2);
            fullversionScreen.postit.addChild(fullVerShot);
         });
         fullversionScreen.postit.thumb3.addEventListener(MouseEvent.MOUSE_OVER,function():*
         {
            playSfx("mouseover");
            fullVerShot = setupFullVerShot(FullVerShot3);
            fullversionScreen.postit.addChild(fullVerShot);
         });
         fullversionScreen.postit.thumb4.addEventListener(MouseEvent.MOUSE_OVER,function():*
         {
            playSfx("mouseover");
            fullVerShot = setupFullVerShot(FullVerShot4);
            fullversionScreen.postit.addChild(fullVerShot);
         });
         fullversionScreen.postit.thumb1.addEventListener(MouseEvent.MOUSE_OUT,function():*
         {
            fullversionScreen.postit.removeChild(fullVerShot);
         });
         fullversionScreen.postit.thumb2.addEventListener(MouseEvent.MOUSE_OUT,function():*
         {
            fullversionScreen.postit.removeChild(fullVerShot);
         });
         fullversionScreen.postit.thumb3.addEventListener(MouseEvent.MOUSE_OUT,function():*
         {
            fullversionScreen.postit.removeChild(fullVerShot);
         });
         fullversionScreen.postit.thumb4.addEventListener(MouseEvent.MOUSE_OUT,function():*
         {
            fullversionScreen.postit.removeChild(fullVerShot);
         });
         fullversionScreen.postit.backButton.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            wrapper.removeChild(fullversionScreen);
            showFullVersionScreen();
         });
         fullversionScreen.postit.buttonMyLostGames.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            network.gotoURL(fullVersionURL);
         });
         fullversionScreen.postit.exitButton.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            wrapper.removeChild(fullversionScreen);
            showOpenScreen();
         });
         fullversionScreen.postit.paypalButton.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            if(FINALIZED)
            {
               network.gotoURL(paypalURL);
            }
         });
      }
      
      private function showPlayScreen() : *
      {
         this.gameScreen = "play";
         while(this.wrapper.numChildren)
         {
            this.wrapper.removeChildAt(0);
         }
         this.playScreen = new Sprite();
         this.playScreen.x = -this.com.backgroundXOffset;
         this.playScreen.y = -this.com.backgroundYOffset;
         this.wrapper.addChild(this.playScreen);
         this.switchLayer = new Sprite();
         this.trackLayer = new Sprite();
         this.inkEffectLayer = new Sprite();
         this.signLayer = new Sprite();
         this.signOverLayer = new Sprite();
         this.trainShadowLayer = new Sprite();
         this.trainLayer = new Sprite();
         this.particleLayer = new Sprite();
         this.markerLayer = new Sprite();
         this.objectLayer = new Sprite();
         this.cowRadiusLayer = new Sprite();
         this.cowLayer = new Sprite();
         this.signalEffectLayer = new Sprite();
         this.tutorialLayer = new Sprite();
         var _loc1_:* = new Background();
         _loc1_.x = this.com.backgroundXOffset;
         _loc1_.y = this.com.backgroundYOffset;
         var _loc2_:* = new BackgroundMask();
         _loc2_.x = this.com.backgroundXOffset;
         _loc2_.y = this.com.backgroundYOffset;
         this.blurHolder = new Sprite();
         this.blurHolder.addChild(_loc1_);
         this.blurHolder.addChild(this.switchLayer);
         this.blurHolder.addChild(this.trackLayer);
         this.blurHolder.addChild(this.signLayer);
         this.blurHolder.addChild(this.inkEffectLayer);
         this.blurHolder.addChild(this.trainShadowLayer);
         this.blurHolder.addChild(this.trainLayer);
         this.blurHolder.addChild(this.particleLayer);
         this.blurHolder.addChild(this.objectLayer);
         this.blurHolder.addChild(this.signalEffectLayer);
         this.blurHolder.addChild(_loc2_);
         this.blurHolder.addChild(this.cowRadiusLayer);
         this.blurHolder.addChild(this.cowLayer);
         this.blurHolder.addChild(this.signOverLayer);
         this.blurHolder.addChild(this.markerLayer);
         this.blurHolder.addChild(this.tutorialLayer);
         this.playScreen.addChild(this.blurHolder);
         var _loc3_:* = this.buildGUI(this.playScreen);
         _loc3_.x = this.com.backgroundXOffset;
         _loc3_.y = this.com.backgroundYOffset;
         this.playScreen.addChild(_loc3_);
         this.playScreen.focusRect = false;
         stage.focus = this.playScreen;
         this.destroyLevel();
         this.loadLevel();
      }
      
      private function updateHighScoresScreen() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         if(this.gameScreen != "highscores")
         {
            return;
         }
         if(this.hiScoresLoading)
         {
            this.highScoresScreen.postit.hsLoaderAnim.visible = true;
            return;
         }
         this.highScoresScreen.postit.hsLoaderAnim.visible = false;
         if(!this.hiScoresUpdated)
         {
            return;
         }
         this.hiScoresUpdated = false;
         _loc2_ = "";
         for each(_loc1_ in this.hiScores)
         {
            _loc2_ += _loc1_.name + "........<br/>";
         }
         this.hsNamesWidget.updateText(_loc2_);
         _loc3_ = "";
         for each(_loc1_ in this.hiScores)
         {
            _loc3_ += GString.prefill(String(_loc1_.score),"0",5) + "<br/>";
         }
         this.hsScoresWidget.updateText(_loc3_);
      }
      
      private function enterFrame(param1:Number) : *
      {
         this.updateParticles(param1);
         this.updateMotions(param1);
         if(this.gameScreen == "play" && Boolean(this.com.runningLevel))
         {
            this.updateGUI();
            this.updateCows(param1);
            if(this.game.clearedCount >= this.level.totalTrains)
            {
               this.levelCleared();
            }
         }
         if(this.gameScreen == "highscores")
         {
            this.updateHighScoresScreen();
         }
      }
      
      private function trainHitTest() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         for each(_loc2_ in this.com.trains)
         {
            if(!_loc2_.leftTheLevel)
            {
               _loc3_ = 0;
               while(_loc3_ < _loc2_.carriages.length)
               {
                  _loc4_ = _loc2_.carriages[_loc3_];
                  for each(_loc5_ in this.com.trains)
                  {
                     if(!_loc5_.leftTheLevel)
                     {
                        _loc6_ = 0;
                        while(_loc6_ < _loc5_.carriages.length)
                        {
                           _loc7_ = _loc5_.carriages[_loc6_];
                           if(_loc2_ == _loc5_)
                           {
                              if(_loc6_ - _loc3_ > 4 || _loc3_ - _loc6_ > 4)
                              {
                                 _loc1_ = this.carriageHitTest(_loc4_,_loc7_);
                                 if(_loc1_)
                                 {
                                    this.addCollideCarriage(_loc2_,_loc4_,_loc1_);
                                    this.addCollideCarriage(_loc5_,_loc7_,_loc1_);
                                 }
                              }
                           }
                           else
                           {
                              _loc1_ = this.carriageHitTest(_loc4_,_loc7_);
                              if(_loc1_)
                              {
                                 this.addCollideCarriage(_loc2_,_loc4_,_loc1_);
                                 this.addCollideCarriage(_loc5_,_loc7_,_loc1_);
                              }
                           }
                           _loc6_++;
                        }
                     }
                  }
                  _loc3_++;
               }
            }
         }
      }
      
      private function getNextSpawnDistance(param1:Object, param2:Number) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         if(param1.firstSpawn)
         {
            if(!param1.nextSpawnDistance)
            {
               param1.nextSpawnDistance = int(Math.random() * 5);
            }
            return param1.nextSpawnDistance * this.carLength;
         }
         if(!param1.nextSpawnDistance)
         {
            if(Boolean(param1.spawnMinDist) && Boolean(param1.spawnMaxDist))
            {
               _loc3_ = param1.spawnMinDist;
               _loc4_ = param1.spawnMaxDist;
               if(_loc3_ < 1)
               {
                  _loc3_ = 1;
               }
               if(_loc4_ < _loc3_)
               {
                  _loc4_ = _loc3_;
               }
               if(_loc3_ > _loc4_)
               {
                  _loc3_ = _loc4_;
               }
               param1.nextSpawnDistance = _loc3_ + int(Math.random() * (1 + _loc4_ - _loc3_));
            }
            else
            {
               param1.nextSpawnDistance = 1;
            }
         }
         return param1.nextSpawnDistance * this.carLength + param2;
      }
      
      private function addObjectMarker(param1:*, param2:*, param3:*) : *
      {
         var _loc4_:* = new Object();
         this.objectMarkers.push(_loc4_);
         _loc4_.proto = param1;
         _loc4_.x = param2;
         _loc4_.y = param3;
      }
      
      private function destroyLevel() : *
      {
         this.com.runningLevel = false;
         this.removeTrains();
         this.removeTracks();
         this.removeCows();
         this.resetParticles();
         this.hideTutorial();
         this.objectMarkers = new Array();
      }
      
      private function restoreLevels(param1:Object) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         if(!param1 || param1.levels == undefined)
         {
            return;
         }
         _loc2_ = 1;
         for each(_loc3_ in param1.levels)
         {
            if(_loc3_)
            {
               this.enableLevel(_loc2_);
            }
            _loc2_++;
         }
      }
      
      private function addHintEventListeners(param1:*) : *
      {
         var hint:* = param1;
         hint.addEventListener(MouseEvent.MOUSE_OVER,function():*
         {
            playSfx("mouseover");
         });
         hint.addEventListener(MouseEvent.MOUSE_OUT,function():*
         {
         });
         hint.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            if(gameScreen != "play")
            {
               return;
            }
            stopAmbient();
            destroyLevel();
            wrapper.removeChild(playScreen);
            showFullVersionScreen();
         });
      }
      
      private function addCowStopEvent(param1:Object, param2:Boolean = false) : *
      {
         var _loc3_:* = param2 ? 0.5 : 1.5 + 0.7 * Math.random();
         param1.event = "stop";
         param1.nextEvent = this.frame.getTime() + _loc3_;
      }
      
      private function keyDown(param1:*) : *
      {
         if(param1.keyCode == 27 && (this.gameScreen == "play" || this.gameScreen == "pause") && !this.game.menuDisabled)
         {
            if(this.frame.isPaused())
            {
               this.pauseGame(false);
            }
            else
            {
               this.pauseGame(true);
            }
         }
      }
      
      private function addCollideCarriage(param1:*, param2:*, param3:Point) : *
      {
         this.trainCrashed(param1,param3);
         param1.collision.carriages.push(param2);
      }
      
      private function destroyPauseScreen() : *
      {
         this.gsound.setSfxVolume(1);
         this.gameScreen = "play";
         stage.focus = this.playScreen;
         this.wrapper.removeChild(this.pauseScreen);
         this.com.runningLevel = true;
         this.blurPlayScreen(false);
      }
      
      private function checkPremiumCallBack(param1:Object) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         while(numChildren)
         {
            removeChildAt(0);
         }
         if(Boolean(param1) && Boolean(param1.valid))
         {
            this.continueGame();
         }
         else
         {
            if(Boolean(param1) && param1.error == "auth_inactive")
            {
               _loc2_ = "Access code inactived";
            }
            else if(Boolean(param1) && param1.error == "auth_failed")
            {
               _loc2_ = "Invalid access code";
            }
            else
            {
               _loc2_ = "Missing access code";
            }
            _loc3_ = GWidget.echo(_loc2_,{
               "font":HuAero,
               "color":this.guiFontColor,
               "size":16,
               "align":"center",
               "margin":0,
               "embed":true,
               "antiAlias":true,
               "letterSpacing":0,
               "multiLine":true
            },this.gameWidth);
            _loc3_.x = 0;
            _loc3_.y = this.gameHeight / 2;
            addChild(_loc3_);
         }
      }
      
      public function resetTrains() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         this.removeTrains();
         this.resetSpawns();
         for(_loc2_ in this.com.trackPoints)
         {
            if(this.com.trackPoints[_loc2_].start)
            {
               this.AddTrain(_loc2_);
            }
         }
         this.resetParticles();
      }
      
      private function runLevel() : *
      {
         this.calcLevelTrainSpeedBonus();
         this.calcTrainSpeed();
         this.resetTrains();
         this.startTrains();
         this.resetMarkers();
         this.blurPlayScreen(false);
         this.playAmbient();
         this.com.runningLevel = true;
      }
      
      private function enableLevel(param1:*) : *
      {
         this.com.levelData.levelList[param1 - 1].available = true;
      }
      
      private function buildTutorial1() : *
      {
         var _loc1_:* = new Sprite();
         var _loc2_:* = new Tutorial1();
         _loc1_.addChild(_loc2_);
         var _loc3_:* = GWidget.echo("avoid trains crashing into each other<br/><br/>esc: pause",{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":13,
            "align":"left",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":1,
            "multiLine":true
         },200);
         _loc3_.x = 10;
         _loc3_.y = 10;
         _loc3_.scaleY = 1.4;
         _loc2_.postit1.addChild(_loc3_);
         var _loc4_:*;
         (_loc4_ = GWidget.echo("= start train",{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":13,
            "align":"left",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":1
         },200)).x = 40;
         _loc4_.y = 8;
         _loc4_.scaleY = 1.4;
         _loc2_.postit2.addChild(_loc4_);
         var _loc5_:*;
         (_loc5_ = GWidget.echo("= stop train",{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":13,
            "align":"left",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":1
         },200)).x = 40;
         _loc5_.y = 32;
         _loc5_.scaleY = 1.4;
         _loc2_.postit2.addChild(_loc5_);
         var _loc6_:*;
         (_loc6_ = GWidget.echo("click here to stop or start the train",{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":13,
            "align":"center",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":1,
            "multiLine":true
         },200)).x = 10;
         _loc6_.y = 62;
         _loc6_.scaleY = 1.4;
         _loc2_.postit2.addChild(_loc6_);
         return _loc1_;
      }
      
      private function buildTutorial2() : *
      {
         var _loc1_:* = new Sprite();
         var _loc2_:* = new Tutorial2();
         _loc1_.addChild(_loc2_);
         var _loc3_:* = GWidget.echo("= switch point",{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":13,
            "align":"left",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":1
         },200);
         _loc3_.x = 40;
         _loc3_.y = 8;
         _loc3_.scaleY = 1.4;
         _loc2_.postit1.addChild(_loc3_);
         var _loc4_:*;
         (_loc4_ = GWidget.echo("click here to switch tracks",{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":13,
            "align":"center",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":1,
            "multiLine":true
         },200)).x = 10;
         _loc4_.y = 38;
         _loc4_.scaleY = 1.4;
         _loc2_.postit1.addChild(_loc4_);
         return _loc1_;
      }
      
      private function buildTutorial3() : *
      {
         var _loc1_:* = new Sprite();
         var _loc2_:* = new Tutorial3();
         _loc1_.addChild(_loc2_);
         _loc2_.cow.gotoAndStop(1);
         var _loc3_:* = GWidget.echo("click on the cow to make it go a different direction.<br/><br/>get bonus points for saving their lives.",{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":10,
            "align":"left",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":1,
            "multiLine":true
         },200);
         _loc3_.x = 10;
         _loc3_.y = 10;
         _loc3_.scaleY = 1.4;
         _loc2_.postit1.addChild(_loc3_);
         return _loc1_;
      }
      
      private function getNumCarriagesForSpawn(param1:Object) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         if(!param1.numCarriagesForSpawn)
         {
            if(Boolean(param1.spawnMinLen) && Boolean(param1.spawnMaxLen))
            {
               _loc2_ = param1.spawnMinLen;
               _loc3_ = param1.spawnMaxLen;
               if(_loc3_ < _loc2_)
               {
                  _loc3_ = _loc2_;
               }
               if(_loc2_ > _loc3_)
               {
                  _loc2_ = _loc3_;
               }
               param1.numCarriagesForSpawn = _loc2_ + int(Math.random() * (1 + _loc3_ - _loc2_));
            }
            else if(param1.startLen)
            {
               param1.numCarriagesForSpawn = param1.startLen;
            }
            else
            {
               param1.numCarriagesForSpawn = 1;
            }
         }
         return param1.numCarriagesForSpawn;
      }
      
      private function showHighScoresScreen() : *
      {
         var hsNamesMsg:*;
         var scoresWidth:*;
         var corner:*;
         var gui:*;
         var hsScoresMsg:*;
         var namesWidth:*;
         this.getHighScores();
         this.gameScreen = "highscores";
         while(this.wrapper.numChildren)
         {
            this.wrapper.removeChildAt(0);
         }
         this.highScoresScreen = new HighScoresScreen();
         this.wrapper.addChild(this.highScoresScreen);
         gui = this.buildGUI(this.highScoresScreen);
         this.highScoresScreen.addChild(gui);
         corner = new Point(30,100);
         namesWidth = 330;
         scoresWidth = 270;
         this.hsNamesWidget = new GWidget({
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":20,
            "align":"right",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":1,
            "multiLine":true
         });
         hsNamesMsg = this.hsNamesWidget.print("",namesWidth);
         hsNamesMsg.x = corner.x;
         hsNamesMsg.y = corner.y;
         hsNamesMsg.scaleY = 1.4;
         this.highScoresScreen.postit.addChild(hsNamesMsg);
         this.hsScoresWidget = new GWidget({
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":20,
            "align":"left",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":1,
            "multiLine":true
         });
         hsScoresMsg = this.hsScoresWidget.print("",scoresWidth);
         hsScoresMsg.x = corner.x + namesWidth;
         hsScoresMsg.y = corner.y;
         hsScoresMsg.scaleY = 1.4;
         this.highScoresScreen.postit.addChild(hsScoresMsg);
         this.highScoresScreen.postit.backButton.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            wrapper.removeChild(highScoresScreen);
            showOpenScreen();
         });
         this.highScoresScreen.buttonMyLostGames.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            gameStat.goToMyLostGames("",null,"paper_train_highscores_MyLostGames");
         });
         this.highScoresScreen.postit.fullVersionButton.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            wrapper.removeChild(highScoresScreen);
            showFullVersionScreen();
         });
      }
      
      private function isMarkerSwitchable(param1:Object) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc2_:* = new Array();
         for each(_loc3_ in this.com.trains)
         {
            if(Boolean(_loc3_.switchIndices) && Boolean(_loc3_.switchIndices.length))
            {
               _loc2_ = _loc2_.concat(_loc3_.switchIndices);
            }
         }
         for each(_loc4_ in _loc2_)
         {
            if((_loc5_ = this.com.trackPoints[_loc4_]).x == param1.x && _loc5_.y == param1.y)
            {
               return false;
            }
         }
         return true;
      }
      
      private function addTrainClip(param1:Object) : *
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in param1.carriages)
         {
            this.addCarriageClip(_loc2_);
         }
      }
      
      private function updateGUI() : *
      {
         if(!this.com.runningLevel)
         {
            return;
         }
         var _loc1_:* = this.getLevelName();
         this.levelWidget.updateText(_loc1_);
         var _loc2_:* = "train " + GString.prefill(this.game.clearedCount.toString(),"0",2) + "/" + GString.prefill(this.level.totalTrains.toString(),"0",2);
         this.clearedWidget.updateText(_loc2_);
         var _loc3_:* = this.game.clickCount.toString() + " clicks";
         this.clicksWidget.updateText(_loc3_);
         var _loc4_:* = this.getTrainSpeedText(this.game.levelSpeed);
         this.spdWidget.updateText(_loc4_);
         this.guiScreen.levelPostit.visible = true;
         this.guiScreen.clearedPostit.visible = true;
         this.guiScreen.clicksPostit.visible = true;
         this.guiScreen.spdPostit.visible = true;
      }
      
      private function getTrainSpeedText(param1:int) : *
      {
         switch(param1)
         {
            case 1:
               return "slow";
            case 2:
               return "normal";
            case 3:
               return "speedy";
            case 4:
               return "express";
            default:
               return;
         }
      }
      
      private function mouseClick(param1:*) : *
      {
      }
      
      private function playEffect(param1:String, param2:Point, param3:Number = 10, param4:Number = 0.3) : *
      {
         var _loc6_:* = undefined;
         var _loc8_:* = undefined;
         var _loc10_:* = undefined;
         var _loc5_:* = false;
         for each(_loc6_ in this.gfxEffects)
         {
            if(Point.distance(_loc6_.pnt,param2) < param3 && this.frame.getTime() < _loc6_.start + param4)
            {
               _loc5_ = true;
            }
         }
         if(_loc5_)
         {
            return;
         }
         var _loc7_:* = new Sprite();
         switch(param1)
         {
            case "crash":
               (_loc8_ = new CrashEffect()).rotation = 360 * Math.random();
               _loc7_.addChild(_loc8_);
               (_loc10_ = new CrashSignal()).scaleX = 0.8;
               _loc10_.scaleY = 0.8;
               _loc7_.addChild(_loc10_);
               break;
            case "cowhit":
               (_loc8_ = new CrashEffect()).rotation = 360 * Math.random();
               _loc8_.scaleX = 0.6;
               _loc8_.scaleY = 0.6;
               _loc7_.addChild(_loc8_);
         }
         var _loc9_:* = new Object();
         this.gfxEffects.push(_loc9_);
         _loc9_.start = this.frame.getTime();
         _loc9_.clip = _loc7_;
         _loc9_.pnt = param2;
         _loc9_.clip.x = param2.x;
         _loc9_.clip.y = param2.y;
         this.inkEffectLayer.addChild(_loc9_.clip);
      }
      
      private function setButtonOffset(param1:MouseEvent, param2:Object, param3:*, param4:* = 0, param5:* = 1) : *
      {
         if(!param2.finished)
         {
            return;
         }
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         if(param4)
         {
            _loc6_ = param5 * (550 - param1.stageX) / 8;
            _loc7_ = param5 * (param2.clip.height / 2 - param1.localY) / 40;
         }
         param2.clip.x = param3.x - param4 + _loc6_;
         param2.clip.y = param3.y - param4 + _loc7_;
         param2.shadowClip.x = param3.xs + param4 * 2 + _loc6_;
         param2.shadowClip.y = param3.ys + param4 * 2 + _loc7_;
      }
      
      private function clickMarker(param1:Object) : *
      {
         if(!this.com.runningLevel)
         {
            return;
         }
         if(param1.isSwitch)
         {
            this.toggleSwitchMarker(param1);
         }
         else if(param1.spd)
         {
            this.toggleSpeedMarker(param1);
         }
         this.outMarker(param1);
         this.overMarker(param1);
         ++this.game.clickCount;
      }
      
      private function carriageCowHitTest(param1:Object, param2:Object) : Boolean
      {
         var _loc18_:* = undefined;
         var _loc19_:* = undefined;
         var _loc20_:* = undefined;
         if(!param1.hit.hitTestObject(param2.clip))
         {
            return false;
         }
         var _loc3_:* = new Array();
         var _loc4_:* = new Array();
         var _loc5_:* = param1.bogie1.pnt;
         var _loc6_:* = param1.bogie2.pnt;
         var _loc7_:*;
         (_loc7_ = GMath.cross(_loc5_.subtract(_loc6_))).normalize(5);
         var _loc8_:* = new Point(-_loc7_.x,-_loc7_.y);
         var _loc9_:* = _loc5_.add(_loc7_);
         var _loc10_:* = _loc6_.add(_loc7_);
         var _loc11_:* = _loc6_.add(_loc8_);
         var _loc12_:* = _loc5_.add(_loc8_);
         _loc3_.push({
            "p1":_loc9_,
            "p2":_loc10_
         });
         _loc3_.push({
            "p1":_loc10_,
            "p2":_loc11_
         });
         _loc3_.push({
            "p1":_loc11_,
            "p2":_loc12_
         });
         _loc3_.push({
            "p1":_loc12_,
            "p2":_loc9_
         });
         var _loc13_:* = 5;
         var _loc14_:* = param2.pos.add(new Point(-_loc13_,-_loc13_));
         var _loc15_:* = param2.pos.add(new Point(-_loc13_,_loc13_));
         var _loc16_:* = param2.pos.add(new Point(_loc13_,-_loc13_));
         var _loc17_:* = param2.pos.add(new Point(_loc13_,_loc13_));
         _loc4_.push({
            "p1":_loc14_,
            "p2":_loc16_
         });
         _loc4_.push({
            "p1":_loc15_,
            "p2":_loc17_
         });
         for each(_loc18_ in _loc3_)
         {
            for each(_loc19_ in _loc4_)
            {
               if(_loc20_ = GMath.lineIntersect(_loc18_.p1,_loc18_.p2,_loc19_.p1,_loc19_.p2))
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function BuildRadiusClip(param1:Object) : *
      {
         var _loc2_:* = new Sprite();
         _loc2_.graphics.lineStyle(1,4473924,0.5,true,LineScaleMode.NORMAL,CapsStyle.ROUND,JointStyle.ROUND);
         _loc2_.graphics.drawCircle(param1.center.x,param1.center.y,param1.radius);
         _loc2_.visible = false;
         return _loc2_;
      }
      
      private function showLevelClearedScreen() : *
      {
         var clearedMsg:*;
         var ptsGameTotalMsg:*;
         var trainsClearedMsg:*;
         var ptsClearedMsg:*;
         var scoreStartYoffs:*;
         var ptsTotalMsg:*;
         var clicksMsg:*;
         var smallFontSize:*;
         var levelBestMsg:*;
         var leftBlockWidth:*;
         var rowHeight:*;
         var totalMsg:*;
         var ptsLevelSpdMsg:*;
         var ptsClickMsg:*;
         var widgetLayer:*;
         var gameTotalMsg:*;
         var rightBlockWidth:*;
         var ptsLevelBestMsg:*;
         var postitWidth:*;
         var smallLetterSpacing:*;
         var levelSpdMsg:*;
         var yoffs:* = undefined;
         this.gameScreen = "levelcleared";
         this.levelClearedScreen = new LevelClearedScreen();
         this.wrapper.addChild(this.levelClearedScreen);
         scoreStartYoffs = 40;
         rowHeight = 11;
         postitWidth = 460;
         leftBlockWidth = 260;
         rightBlockWidth = 200;
         smallFontSize = 12;
         smallLetterSpacing = 1;
         widgetLayer = new Sprite();
         widgetLayer.scaleY = 1.4;
         this.levelClearedScreen.clearedPostit.addChild(widgetLayer);
         clearedMsg = GWidget.echo(this.getLevelName() + " cleared",{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":24,
            "align":"center",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":1
         },postitWidth);
         clearedMsg.x = 0;
         clearedMsg.y = 5;
         widgetLayer.addChild(clearedMsg);
         yoffs = scoreStartYoffs;
         trainsClearedMsg = GWidget.echo(this.game.clearedCount.toString() + " trains led off:",{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":smallFontSize,
            "align":"right",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":smallLetterSpacing
         },leftBlockWidth);
         trainsClearedMsg.x = 0;
         trainsClearedMsg.y = yoffs;
         widgetLayer.addChild(trainsClearedMsg);
         yoffs += rowHeight;
         levelSpdMsg = GWidget.echo("speed bonus:",{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":smallFontSize,
            "align":"right",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":smallLetterSpacing
         },leftBlockWidth);
         levelSpdMsg.x = 0;
         levelSpdMsg.y = yoffs;
         widgetLayer.addChild(levelSpdMsg);
         yoffs += rowHeight;
         clicksMsg = GWidget.echo(this.game.clickCount.toString() + " clicks:",{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":smallFontSize,
            "align":"right",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":smallLetterSpacing
         },leftBlockWidth);
         clicksMsg.x = 0;
         clicksMsg.y = yoffs;
         widgetLayer.addChild(clicksMsg);
         yoffs += rowHeight;
         yoffs += 10;
         totalMsg = GWidget.echo("total:",{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":smallFontSize,
            "align":"right",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":smallLetterSpacing
         },leftBlockWidth);
         totalMsg.x = 0;
         totalMsg.y = yoffs;
         widgetLayer.addChild(totalMsg);
         yoffs += rowHeight;
         levelBestMsg = GWidget.echo("your best:",{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":smallFontSize,
            "align":"right",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":smallLetterSpacing
         },leftBlockWidth);
         levelBestMsg.x = 0;
         levelBestMsg.y = yoffs;
         widgetLayer.addChild(levelBestMsg);
         yoffs += 20;
         gameTotalMsg = GWidget.echo("game total:",{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":18,
            "align":"right",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":smallLetterSpacing
         },leftBlockWidth);
         gameTotalMsg.x = 0;
         gameTotalMsg.y = yoffs;
         widgetLayer.addChild(gameTotalMsg);
         yoffs = scoreStartYoffs;
         ptsClearedMsg = GWidget.echo(this.game.clearedScore.toString() + " pts",{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":smallFontSize,
            "align":"left",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":smallLetterSpacing
         },rightBlockWidth);
         ptsClearedMsg.x = leftBlockWidth + 15;
         ptsClearedMsg.y = yoffs;
         widgetLayer.addChild(ptsClearedMsg);
         yoffs += rowHeight;
         ptsLevelSpdMsg = GWidget.echo(this.game.levelSpeedBonus.toString() + " pts",{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":smallFontSize,
            "align":"left",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":smallLetterSpacing
         },rightBlockWidth);
         ptsLevelSpdMsg.x = leftBlockWidth + 15;
         ptsLevelSpdMsg.y = yoffs;
         widgetLayer.addChild(ptsLevelSpdMsg);
         yoffs += rowHeight;
         ptsClickMsg = GWidget.echo(this.game.clickScore.toString() + " pts",{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":smallFontSize,
            "align":"left",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":smallLetterSpacing
         },rightBlockWidth);
         ptsClickMsg.x = leftBlockWidth + 15;
         ptsClickMsg.y = yoffs;
         widgetLayer.addChild(ptsClickMsg);
         yoffs += rowHeight;
         yoffs += 10;
         ptsTotalMsg = GWidget.echo(this.game.levelTotalScore.toString() + " pts",{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":smallFontSize,
            "align":"left",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":smallLetterSpacing
         },rightBlockWidth);
         ptsTotalMsg.x = leftBlockWidth + 15;
         ptsTotalMsg.y = yoffs;
         widgetLayer.addChild(ptsTotalMsg);
         yoffs += rowHeight;
         ptsLevelBestMsg = GWidget.echo(!!this.level.played ? this.level.bestScore.toString() + " pts" : "n/a",{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":smallFontSize,
            "align":"left",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":smallLetterSpacing
         },rightBlockWidth);
         ptsLevelBestMsg.x = leftBlockWidth + 15;
         ptsLevelBestMsg.y = yoffs;
         widgetLayer.addChild(ptsLevelBestMsg);
         yoffs += 20;
         ptsGameTotalMsg = GWidget.echo(this.game.gameTotalScore.toString(),{
            "font":this.guiFont,
            "color":this.guiFontColor,
            "size":18,
            "align":"left",
            "margin":0,
            "embed":true,
            "antiAlias":true,
            "letterSpacing":smallLetterSpacing
         },rightBlockWidth);
         ptsGameTotalMsg.x = leftBlockWidth + 15;
         ptsGameTotalMsg.y = yoffs;
         widgetLayer.addChild(ptsGameTotalMsg);
         this.stopAmbient();
         this.clearedPostitX = this.levelClearedScreen.clearedPostit.x;
         this.levelClearedScreen.clearedPostit.x = this.gameWidth;
         this.levelClearedScreen.clearedPostit.submitScoreButton.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            wrapper.removeChild(levelClearedScreen);
            showSubmitScoreScreen();
         });
         this.levelClearedScreen.clearedPostit.nextLevelButton.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            blurPlayScreen(false);
            destroyLevel();
            gameScreen = "play";
            ++levelId;
            loadLevel();
            wrapper.removeChild(levelClearedScreen);
         });
         this.levelClearedScreen.clearedPostit.selectLevelButton.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            blurPlayScreen(false);
            destroyLevel();
            wrapper.removeChild(levelClearedScreen);
            wrapper.removeChild(playScreen);
            showSelectLevelScreen();
         });
         this.levelClearedScreen.clearedPostit.fullVersionButton.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            blurPlayScreen(false);
            destroyLevel();
            wrapper.removeChild(levelClearedScreen);
            wrapper.removeChild(playScreen);
            showFullVersionScreen();
         });
         this.levelClearedScreen.clearedPostit.continueButton.addEventListener(MouseEvent.CLICK,function():*
         {
            gsound.play(Click);
            wrapper.removeChild(levelClearedScreen);
            showCongratScreen();
         });
         this.blurPlayScreen(true);
         if(this.levelId == this.com.levelData.numFreeLevel)
         {
            this.levelClearedScreen.clearedPostit.nextLevelButton.visible = false;
            this.levelClearedScreen.clearedPostit.selectLevelButton.visible = false;
            this.levelClearedScreen.clearedPostit.fullVersionButton.visible = false;
         }
         else
         {
            this.levelClearedScreen.clearedPostit.continueButton.visible = false;
         }
      }
      
      private function updateParticles(param1:Number) : *
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this.particles)
         {
            this.updateParticle(_loc2_,param1);
         }
      }
      
      private function getTrainLong(param1:int) : *
      {
         return param1 * (this.carLength + this.carGap) - this.carGap;
      }
      
      private function getButtonMotion(param1:String) : *
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this.buttonMotions)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}
