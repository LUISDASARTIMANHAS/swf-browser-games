package com.pavelzuk.planegame
{
   import com.pavelzuk.components.MP3Pitch;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   [Embed(source="/_assets/assets.swf", symbol="com.pavelzuk.planegame.Plane")]
   public class Plane extends MovieClip
   {
       
      
      public var thrustY:Number = 0;
      
      public var engineOnNum:Number = 100;
      
      public var thrustX:Number = 0;
      
      public var startedTurnSlowDown:Boolean = false;
      
      public var overHeatNum:Number = 0;
      
      public var lift:Number = 0;
      
      public var stallFactor:Number = 0;
      
      public var boxX:* = 200;
      
      public var velocityX:Number = 0;
      
      public var overHeatWarning:Boolean = false;
      
      public var engineOffPlayed:Boolean = true;
      
      public var velocityY:Number = 0;
      
      public var ERelease:Boolean = true;
      
      public var flapsVel:Number = 0.1;
      
      public var winText:Boolean = false;
      
      public var throttle:Number = 0;
      
      public var smokeAPM:Number = 0;
      
      public var planeOnFire:Boolean = false;
      
      public var planeOnFireWarning:Boolean = false;
      
      public var planeSlowDownWhileTurning:Number = 0;
      
      public var overSpeedSound:Sfx;
      
      public var targetSpeed:Number = 0;
      
      public var planeFireExplodeNum:int = 400;
      
      public var planeMovement:Boolean = true;
      
      public var flapsJammed:Boolean = false;
      
      public var windRelativeAngle:Number = 0;
      
      public var winMsgTimer:Number = 0;
      
      public var ambience2:Sfx;
      
      public var startX:Number = 0;
      
      public var jammGear:int = 0;
      
      public var speed:Number = 0;
      
      public var portBehind:Boolean = false;
      
      public var goingRight:Boolean = true;
      
      public var engineSoundLowering:Number = 1;
      
      public var flapsTimer:uint = 100;
      
      public var fireExtinguish:MovieClip;
      
      public var debree2:MovieClip;
      
      public var gearJammed:Boolean = false;
      
      public var gearBroke:* = false;
      
      public var overSpeedLooping:Boolean = false;
      
      public var crash4:Boolean = false;
      
      public var crash1:Boolean = false;
      
      public var Idown:Boolean = false;
      
      public var crash3:Boolean = false;
      
      public var windAbsoluteAngle:Number = 0;
      
      public var gearNum:* = 120;
      
      public var fireSound:Sfx;
      
      public var saveX:Number = 0;
      
      public var saveY:Number = 0;
      
      public var crash5:Boolean = false;
      
      public var crash2:Boolean = false;
      
      public var rainFx:MovieClip;
      
      public var flapsFailed:Boolean = false;
      
      public var rotationSlower:Number = 0;
      
      public var crashed:Boolean = false;
      
      public var planeDrive:MovieClip;
      
      public var gear:MovieClip;
      
      public var totalThr:Number = 0;
      
      public var groundHeight:Number = 14;
      
      public var flaps:String = "take off";
      
      public var throttleForStalling:Number = 0;
      
      public var engineStarting:Boolean = false;
      
      public var planeCrash:Boolean = false;
      
      public var smokeOn:Boolean = true;
      
      public var canCrash:Boolean = false;
      
      public var extinguishOnlyOncePerGame:* = false;
      
      public var brakeGearRandom:int;
      
      public var ambience:Sfx;
      
      public var engineOn:Boolean = false;
      
      public var GRelease:Boolean = true;
      
      public var spaceDown:Boolean = false;
      
      public var raining:Boolean = false;
      
      public var foodMessage:Boolean = false;
      
      public var FRelease:Boolean = true;
      
      public var win:Boolean = false;
      
      public var engineSound2:MP3Pitch;
      
      public var airMessageSaid:Boolean = false;
      
      public var totalRotation:Number = 0;
      
      public var engineStartTimer:Number = 220;
      
      public var engineSound:MP3Pitch;
      
      public var engineHeatMessageTimer:Number = 100;
      
      public var debree:MovieClip;
      
      public var unsteadyRot:Number = 0;
      
      public var inAir:Boolean = false;
      
      public var planeTurn:MovieClip;
      
      public function Plane()
      {
         this.fireSound = new Sfx("fireSound",function():*
         {
         });
         this.ambience = new Sfx("Ambience");
         this.overSpeedSound = new Sfx("overSpeed");
         this.ambience2 = new Sfx("Rain");
         super();
         addFrameScript(0,this.frame1,3,this.frame4,4,this.frame5,5,this.frame6,6,this.frame7);
      }
      
      public function toMap(param1:MouseEvent) : void
      {
         trace("map");
      }
      
      public function victory() : void
      {
         if(x >= Controller.level.map.destinationPort.x - 2600 && x <= Controller.level.map.destinationPort.x + 2600)
         {
            if(this.throttle <= 5 && this.planeCrash == false)
            {
               this.win = true;
               Controller.level.hud.pilotGui.alpha = 0;
               if(this.winText == false)
               {
                  Controller.level.hud.crashText.gotoAndPlay(220);
                  if(Tracker.mute == false)
                  {
                     GameController.playSound("cheer");
                  }
                  this.winText = true;
               }
            }
            if(y >= Controller.level.groundY - this.groundHeight && this.planeCrash == false)
            {
            }
         }
      }
      
      public function sounds() : void
      {
         var _loc1_:Number = 0.8;
         if(Tracker.mute == false)
         {
            this.fixForOtherSounds(2);
         }
         if(Tracker.mute == true)
         {
            this.fixForOtherSounds(3);
            this.engineSound.setVolume(0);
            this.engineSound2.setVolume(0);
            GameController.soundChannel.stop();
         }
         else if(this.engineOn)
         {
            this.engineSoundLowering = 1;
            this.engineOffPlayed = false;
            this.engineSound.rate = this.speed + 0.85;
            this.engineSound2.rate = this.speed - 1;
            if(this.speed > _loc1_)
            {
               this.engineSound.setVolume(1 - (this.speed - _loc1_));
               this.engineSound2.setVolume(this.speed - _loc1_);
            }
            else
            {
               this.engineSound.setVolume(_loc1_);
               this.engineSound2.setVolume(0);
            }
         }
         else
         {
            if(this.engineSoundLowering > 0)
            {
               this.engineSoundLowering -= 0.05;
            }
            if(this.speed > 1.2)
            {
               this.engineSound.setVolume(0);
            }
            else
            {
               this.engineSound.setVolume(this.engineSoundLowering);
            }
            this.engineSound2.setVolume(this.engineSoundLowering);
            if(this.engineOffPlayed == false)
            {
               if(Tracker.mute == false)
               {
                  GameController.playSound("engineOff");
               }
               this.engineOffPlayed = true;
            }
         }
      }
      
      public function saveXY() : void
      {
         this.saveX = x;
         this.saveY = y;
      }
      
      public function stopSound() : void
      {
         GameController.soundChannel.stop();
      }
      
      public function create(param1:Number, param2:Number) : void
      {
         scaleX = -1;
         Controller.fastMode = false;
         Tracker.didntLandButDidntDie = false;
         Tracker.died = false;
         Tracker.emLand = false;
         Tracker.abandon = false;
         Tracker.explodeFromFire = false;
         x = param1 + this.startX;
         y = param2;
         this.engineSound = new MP3Pitch(PlaneFly);
         this.engineSound2 = new MP3Pitch(PlaneFly2);
         this.engineSound.setVolume(1);
         this.engineSound2.setVolume(0);
         this.ambience.loop(0.8);
         if(Boolean(this.ambience2) && Tracker.weatherRandomized == "Rain")
         {
            this.ambience2.loop(0.8);
         }
         Controller.level.plane.gear.gotoAndStop(1);
         Controller.level.hud.pilotGui.flaps.gotoAndStop(3);
         Controller.level.hud.pilotGui.gearOn.alpha = 1;
         Controller.level.hud.pilotGui.zOn.alpha = 0;
      }
      
      public function engineOverheat() : void
      {
         var _loc1_:* = undefined;
         if(this.engineHeatMessageTimer > 0)
         {
            --this.engineHeatMessageTimer;
         }
         if(this.overHeatNum >= Tracker.overHeatUpgrader && this.planeOnFire == false)
         {
            this.overHeatWarning = true;
         }
         if(this.overHeatNum >= Tracker.overHeatUpgrader + 600)
         {
            this.planeOnFire = true;
         }
         if(this.engineOn)
         {
            if(this.throttle > 90 && Input.isKeyDown(Input.UP))
            {
               ++this.overHeatNum;
            }
            else if(this.overHeatNum > 0)
            {
               this.overHeatNum -= 2;
            }
         }
         else if(this.overHeatNum > 0 && this.planeOnFire == false)
         {
            this.overHeatNum -= 5;
         }
         if(this.overHeatWarning && this.planeOnFire == false)
         {
            if(this.engineHeatMessageTimer <= 0)
            {
               Controller.level.hud.addBox(16750898,"Engine Overheat");
               Controller.cantSpeed();
               this.engineHeatMessageTimer = 100;
            }
            this.overHeatWarning = false;
         }
         else if(this.planeOnFire)
         {
            _loc1_ = Math.random() * Tracker.howFastInjured;
            if(_loc1_ <= 5)
            {
               Controller.level.passengersInjured += Math.random() * 2;
            }
            --this.planeFireExplodeNum;
            if(this.planeFireExplodeNum <= 0)
            {
               this.crash5 = true;
            }
            this.velocityY += 0.25;
            if(this.engineHeatMessageTimer <= 0)
            {
               Controller.level.hud.addBox(16711680,"Engine on Fire");
               Controller.cantSpeed();
               this.engineHeatMessageTimer = 100;
            }
            Controller.level.addBlackSmoke(x,y);
            if(this.speed >= 1.7)
            {
               this.speed = 1.45;
            }
            if(this.planeOnFireWarning == false)
            {
               this.planeFireFunction();
               this.planeOnFireWarning = true;
            }
         }
      }
      
      public function airportCloseMessage() : void
      {
         Controller.level.hud.addBox(65280,"Start Decending, Airport Approaching");
         if(Tracker.mute == false)
         {
            GameController.playSound("cabinSound");
         }
         this.airMessageSaid = true;
         Controller.cantSpeed();
      }
      
      public function showStars() : void
      {
         if(y < -9600 && Controller.level.hud.rain.stars.currentFrame == 1)
         {
            Controller.level.hud.rain.stars.gotoAndPlay(2);
         }
         else if(y > -9600 && Controller.level.hud.rain.stars.currentFrame == 50)
         {
            Controller.level.hud.rain.stars.gotoAndPlay(51);
         }
      }
      
      public function fixForOtherSounds(param1:*) : void
      {
         if(param1 == 1)
         {
            trace("STOP SOUNDS");
            this.fireSound.stop();
            this.ambience.stop();
            if(this.ambience2)
            {
               this.ambience2.stop();
            }
            this.overSpeedSound.stop();
         }
         else if(param1 == 2)
         {
            this.fireSound.volume = 1;
            this.ambience.volume = 1;
            if(this.ambience2)
            {
               this.ambience2.volume = 1;
            }
            this.overSpeedSound.volume = 1;
         }
         else if(param1 == 3)
         {
            this.fireSound.volume = 0;
            this.ambience.volume = 0;
            if(this.ambience2)
            {
               this.ambience2.volume = 0;
            }
            this.overSpeedSound.volume = 0;
         }
      }
      
      internal function frame6() : *
      {
         if(Tracker.mute == false)
         {
            GameController.playSound("planeExplode");
         }
      }
      
      internal function frame4() : *
      {
         if(Tracker.mute == false)
         {
            GameController.playSound("planeExplode");
         }
         Controller.level.plane.fireSound.loop(0.8);
      }
      
      public function toUpgrades(param1:MouseEvent) : void
      {
         trace("upgrades");
      }
      
      internal function frame1() : *
      {
         stop();
         this.gear.gotoAndStop(Controller.level.plane.gearNum);
         if(this.raining == true)
         {
            this.rainFx.gotoAndStop(2);
         }
         if(this.gearBroke == true)
         {
            this.gear.gotoAndStop("gearBreak2");
         }
      }
      
      internal function frame7() : *
      {
         if(Tracker.mute == false)
         {
            GameController.playSound("planeExplode");
         }
      }
      
      public function steadyDrive() : void
      {
         if(Math.abs(this.speed) >= 0.8 && !this.inAir && !Controller.level.map.airport.hitTestPoint(Controller.level.plane.x + Controller.level.gameClip.x,Controller.level.plane.y + Controller.level.gameClip.y,false) && !Controller.level.map.destinationPort.hitTestPoint(Controller.level.plane.x + Controller.level.gameClip.x,Controller.level.plane.y + Controller.level.gameClip.y,false))
         {
            this.unsteadyRot = Math.random() * this.speed * 2 + Math.random() * -this.speed * 2;
         }
         else
         {
            this.unsteadyRot = 0;
         }
      }
      
      public function checkPlaneX() : void
      {
         if(Controller.level.map.destinationPort.x < -1000)
         {
            this.portBehind = true;
            trace("BEHIND");
         }
         if(this.portBehind == true)
         {
            scaleX = 1;
            this.startX = 2900;
            x += this.startX;
            rotation = 5;
            this.goingRight = false;
         }
         else
         {
            scaleX = -1;
            this.startX = 0;
            rotation = -5;
         }
      }
      
      public function crash() : void
      {
         var _loc2_:Object = null;
         var _loc1_:int = 0;
         while(_loc1_ < Controller.level.backgroundManager.bgArray.length)
         {
            _loc2_ = Controller.level.backgroundManager.bgArray[_loc1_];
            if(_loc2_ is MapManager)
            {
               if(!Controller.level.map.airport.hitTestPoint(Controller.level.plane.x + Controller.level.gameClip.x,Controller.level.plane.y + Controller.level.gameClip.y,false) && !Controller.level.map.destinationPort.hitTestPoint(Controller.level.plane.x + Controller.level.gameClip.x,Controller.level.plane.y + Controller.level.gameClip.y,false))
               {
                  if(_loc2_.HIT !== null && this.crashed == false)
                  {
                     if(_loc2_.HIT.hitTestPoint(Controller.level.plane.x + Controller.level.gameClip.x,Controller.level.plane.y + Controller.level.gameClip.y,false))
                     {
                        this.crash3 = true;
                        this.crash2 = false;
                        this.crash1 = false;
                        this.crash4 = false;
                        this.canCrash = false;
                     }
                  }
                  if(_loc2_.HIT2 !== null && this.crashed == false)
                  {
                     if(_loc2_.HIT2.hitTestPoint(Controller.level.plane.x + Controller.level.gameClip.x,Controller.level.plane.y + Controller.level.gameClip.y,false))
                     {
                        this.crash4 = true;
                        this.crash2 = false;
                        this.crash1 = false;
                        this.crash3 = false;
                        this.canCrash = false;
                     }
                  }
               }
            }
            _loc1_++;
         }
         if(this.inAir)
         {
            this.canCrash = true;
         }
         if(this.canCrash == true)
         {
            if(y >= Controller.level.groundY - this.groundHeight)
            {
               if(this.crashed == false)
               {
                  if(this.velocityY >= 2.5)
                  {
                     this.crash1 = true;
                     this.crash2 = false;
                     this.crash3 = false;
                     this.crash4 = false;
                  }
                  else if(this.lift * 10 >= 1.8 || this.gearNum == 0)
                  {
                     this.crash2 = true;
                     this.crash1 = false;
                     this.crash3 = false;
                     this.crash4 = false;
                  }
                  else if(this.lift * 10 >= 1.8 || this.gearNum == 0)
                  {
                     this.crash4 = true;
                     this.crash1 = false;
                     this.crash3 = false;
                     this.crash2 = false;
                  }
                  else
                  {
                     this.canCrash = false;
                     this.crash1 = false;
                     this.crash2 = false;
                     this.crash3 = false;
                     this.crash4 = false;
                  }
               }
            }
         }
         if(this.crash1)
         {
            gotoAndStop(4);
            if(Controller.level.plane.debree !== null && this.goingRight == true)
            {
               this.debree.x -= this.velocityX * 0.2;
            }
            if(Controller.level.plane.debree !== null && this.goingRight == false)
            {
               this.debree.x += this.velocityX * 0.2;
            }
            this.varsForWhenCrashed();
            if(this.crashed == false)
            {
               Controller.level.hud.crashText.gotoAndPlay(110);
            }
            this.crashed = true;
            Tracker.died = true;
         }
         else if(this.crash2)
         {
            gotoAndStop(3);
            this.varsForWhenCrashed();
            if(x >= Controller.level.map.destinationPort.x - 2600 && x <= Controller.level.map.destinationPort.x + 2600)
            {
               Tracker.brokenGear = 1000;
               this.win = true;
               Controller.level.hud.pilotGui.alpha = 0;
               if(this.winText == false)
               {
                  Controller.level.hud.crashText.gotoAndPlay(330);
                  if(Tracker.mute == false)
                  {
                     GameController.playSound("cheer");
                  }
                  this.winText = true;
               }
               this.crashed = true;
            }
            else
            {
               Tracker.emLand = true;
               if(this.crashed == false)
               {
                  Controller.level.hud.crashText.gotoAndPlay(2);
               }
               this.crashed = true;
               Tracker.didntLandButDidntDie = true;
            }
         }
         else if(this.crash3)
         {
            if(y <= 385)
            {
               gotoAndStop(5);
            }
            else
            {
               gotoAndStop(4);
            }
            this.varsForWhenCrashed();
            this.planeMovement = false;
            if(this.crashed == false)
            {
               Controller.level.hud.crashText.gotoAndPlay(110);
            }
            this.crashed = true;
            Tracker.died = true;
         }
         else if(this.crash4)
         {
            gotoAndStop(6);
            this.varsForWhenCrashed();
            this.planeMovement = false;
            if(this.crashed == false)
            {
               Controller.level.hud.crashText.gotoAndPlay(110);
            }
            this.crashed = true;
            Controller.level.planeShade.alpha = 0;
            Tracker.died = true;
         }
         else if(this.crash5)
         {
            Tracker.explodeFromFire = true;
            Controller.level.planeShade.alpha = 0;
            gotoAndStop(7);
            if(Controller.level.plane.debree !== null && this.goingRight == true)
            {
               this.debree.x -= this.velocityX * 0.2;
               this.debree.y += 2;
               this.debree2.y += 2;
            }
            if(Controller.level.plane.debree !== null && this.goingRight == false)
            {
               this.debree.x += this.velocityX * 0.8;
               this.debree.y += 2;
               this.debree2.y += 2;
            }
            this.varsForWhenCrashed();
            if(this.crashed == false)
            {
               Controller.level.hud.crashText.gotoAndPlay(110);
            }
            this.crashed = true;
         }
      }
      
      public function planeFireFunction() : void
      {
         this.fireSound.loop(0.8);
         if(Tracker.extinguishers == 1)
         {
            Controller.level.hud.addBox(16750898,"Press \'E\' to use fire extinguishers!");
         }
      }
      
      public function foodMessageF() : void
      {
         Controller.level.hud.addBox(65280,"Food is now being served, fly steadily.");
         if(Tracker.mute == false)
         {
            GameController.playSound("cabinSound");
         }
         this.foodMessage = true;
         Controller.cantSpeed();
      }
      
      public function movement() : void
      {
         var _loc1_:* = undefined;
         if(this.totalThr >= 100)
         {
            this.totalThr = 100;
         }
         if(this.goingRight)
         {
            Controller.level.cameraPlacementX = 220;
            if(this.engineOn == true)
            {
               if(this.throttle >= 100)
               {
                  this.throttle = 100;
               }
               else if(Input.isKeyDown(Input.UP))
               {
                  this.totalThr += 0.5;
                  this.totalRotation -= 0.5;
               }
            }
            if(y >= Controller.level.groundY - this.groundHeight)
            {
               this.totalRotation = -5;
            }
            if(this.stallFactor > 0)
            {
               this.totalRotation += 0.5;
            }
            this.targetSpeed = this.throttle * 0.018;
            this.targetSpeed += this.totalRotation * 0.01;
            this.speed = this.speed * 0.8 + this.targetSpeed * 0.2;
            this.thrustX = this.speed * Math.cos(this.totalRotation * Math.PI / 180);
            this.thrustY = this.speed * Math.sin(this.totalRotation * Math.PI / 180);
            this.velocityX *= 0.9;
            this.velocityY *= 0.9;
            this.velocityX += this.thrustX;
            this.velocityY += this.thrustY;
            if(this.engineOn == false && this.totalThr > 0)
            {
               this.totalThr -= 0.1;
            }
            this.velocityY += 2 - this.flapsVel;
            this.lift = Math.sqrt(this.velocityX * this.velocityX + this.velocityY * this.velocityY);
            this.lift *= 0.01;
            this.windAbsoluteAngle = Math.atan2(this.velocityY,this.velocityX) * 180 / Math.PI;
            this.windRelativeAngle = this.windAbsoluteAngle - this.totalRotation + this.unsteadyRot * 1000;
            if(this.windRelativeAngle > 32)
            {
               this.stallFactor += 0.2;
               if(this.stallFactor > 1)
               {
                  this.stallFactor = 1;
               }
            }
            else
            {
               this.stallFactor -= 0.2;
               if(this.stallFactor < 0)
               {
                  this.stallFactor = 0;
               }
            }
            this.lift *= 1 - this.stallFactor * 0.5;
            this.velocityY -= this.lift + this.unsteadyRot / 2;
            this.velocityY -= this.velocityX * 0.1;
            if(this.velocityX < 0)
            {
               this.velocityX = 0;
            }
            x += this.velocityX - this.planeSlowDownWhileTurning;
         }
         else
         {
            Controller.level.cameraPlacementX = 475;
            if(this.engineOn == true)
            {
               if(this.throttle >= 100)
               {
                  this.throttle = 100;
               }
               else if(Input.isKeyDown(Input.UP))
               {
                  this.totalThr += 0.5;
                  this.totalRotation += 0.5;
               }
            }
            if(y >= Controller.level.groundY - this.groundHeight)
            {
               this.totalRotation = 5;
            }
            if(this.stallFactor > 0)
            {
               this.totalRotation -= 0.5;
            }
            this.targetSpeed = this.throttle * 0.018;
            this.targetSpeed -= this.totalRotation * 0.01;
            this.speed = this.speed * 0.8 + this.targetSpeed * 0.2;
            this.thrustX = this.speed * Math.cos(this.totalRotation * Math.PI / 180);
            this.thrustY = this.speed * Math.sin(this.totalRotation * Math.PI / 180);
            this.velocityX *= 0.9;
            this.velocityY *= 0.9;
            this.velocityX -= this.thrustX;
            this.velocityY -= this.thrustY;
            if(this.engineOn == false && this.totalThr > 0)
            {
               this.totalThr -= 0.1;
            }
            this.velocityY += 2 - this.flapsVel;
            this.lift = Math.sqrt(this.velocityX * this.velocityX + this.velocityY * this.velocityY);
            this.lift *= 0.01;
            this.windAbsoluteAngle = Math.atan2(this.velocityY,this.velocityX) * 180 / Math.PI;
            this.windRelativeAngle = Math.abs(this.windAbsoluteAngle) + this.totalRotation + this.unsteadyRot * 1000;
            if(this.windRelativeAngle > 202)
            {
               this.stallFactor += 0.2;
               if(this.stallFactor > 1)
               {
                  this.stallFactor = 1;
               }
            }
            else
            {
               this.stallFactor -= 0.2;
               if(this.stallFactor < 0)
               {
                  this.stallFactor = 0;
               }
            }
            this.lift *= 1 - this.stallFactor * 0.5;
            this.velocityY -= this.lift + this.unsteadyRot / 2;
            this.velocityY -= Math.abs(this.velocityX) * 0.1;
            if(this.velocityX > 0)
            {
               this.velocityX = 0;
            }
            x -= Math.abs(this.velocityX) - this.planeSlowDownWhileTurning;
         }
         y += this.velocityY;
         if(y >= Controller.level.groundY - this.groundHeight)
         {
            if(this.speed > 1 && this.planeDrive !== null)
            {
               this.planeDrive.play();
            }
            else if(this.planeDrive !== null)
            {
               this.planeDrive.stop();
            }
            y = Controller.level.groundY - this.groundHeight;
            if(this.speed > 1.5 && this.smokeOn)
            {
               Controller.level.addLandSmoke(x,y);
            }
            if(this.speed >= 1 && this.lift <= 1.75 && this.inAir)
            {
               if(Tracker.mute == false)
               {
                  GameController.playSound("wheelTouch");
               }
            }
            this.inAir = false;
         }
         else
         {
            this.inAir = true;
            if(this.speed <= 1.5)
            {
               this.velocityY += 0.25;
            }
            this.unsteadyRot = 0;
         }
         rotation -= (rotation - this.totalRotation) / 20 + this.unsteadyRot;
         this.throttle -= (this.throttle - this.totalThr) / 30;
         if(this.speed >= 1.9)
         {
            if(this.gearBroke == false && this.gearNum == 120)
            {
               this.brakeGearRandom = Math.round(Math.random() * 50);
               if(this.brakeGearRandom == 1)
               {
                  this.gearNum = 0;
                  Controller.level.plane.gear.gotoAndStop("brokenGearLabel");
                  this.gearBroke = true;
                  Controller.level.hud.addBox(16750898,"Warning, Gear Broke!");
                  if(Tracker.mute == false)
                  {
                     GameController.playSound("warning");
                  }
               }
            }
            _loc1_ = Math.random() * Tracker.howFastInjured;
            if(_loc1_ <= 2)
            {
               Controller.level.passengersInjured += Math.random() * 2;
            }
            if(this.speed >= 2)
            {
               Controller.level.shake(10);
            }
            if(!this.overSpeedLooping)
            {
               Controller.cantSpeed();
               this.overSpeedSound.loop(0.8);
               Controller.level.hud.addBox(16750898,"Over Speeding, Pull Up!");
               this.overSpeedLooping = true;
            }
         }
         else
         {
            this.overSpeedSound.stop();
            this.overSpeedLooping = false;
         }
      }
      
      public function controls() : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         if(Input.isKeyDown(Input.E) && this.ERelease == true)
         {
            Controller.level.hud.pilotGui.eOn.gotoAndPlay(2);
            if(Tracker.extinguishers == 1 && this.extinguishOnlyOncePerGame == false)
            {
               if(this.planeOnFire)
               {
                  this.overHeatNum = Tracker.overHeatUpgrader + 400;
                  this.fireExtinguish.gotoAndPlay(2);
                  if(Tracker.mute == false)
                  {
                     GameController.playSound("fireStop");
                  }
                  Controller.level.hud.addBox(16750898,"Fire out!");
                  this.planeOnFire = false;
                  this.fireSound.stop();
                  this.extinguishOnlyOncePerGame = true;
               }
               else
               {
                  Controller.level.hud.addBox(16750898,"There is no fire to take out.");
               }
            }
            else if(!this.planeOnFire && Tracker.extinguishers == 0)
            {
               Controller.level.hud.addBox(16750898,"We aren\'t equipped with fire extinguishers!");
            }
            else
            {
               Controller.level.hud.addBox(16750898,"Extinguishers are out!");
            }
            this.ERelease = false;
         }
         else if(!Input.isKeyDown(Input.E))
         {
            this.ERelease = true;
         }
         if(this.totalRotation >= -4 && this.goingRight == true && this.inAir && this.flaps == "take off" || this.totalRotation <= 2 && this.goingRight == false && this.inAir && this.flaps == "take off")
         {
            this.flapsVel = -0.3;
         }
         else if(this.totalRotation <= -4 && this.goingRight == true && this.inAir && this.flaps == "take off" || this.totalRotation >= 2 && this.goingRight == false && this.inAir && this.flaps == "take off")
         {
            this.flapsVel = 0.1 + Math.random() * 0.05;
         }
         if(this.totalRotation < -45 && this.totalThr >= 0 && this.goingRight == true)
         {
            this.totalThr -= 2;
         }
         if(this.totalRotation > 45 && this.totalThr >= 0 && this.goingRight == false)
         {
            this.totalThr -= 2;
         }
         var _loc1_:* = Math.abs(this.velocityX);
         if(this.startedTurnSlowDown)
         {
            this.planeSlowDownWhileTurning += 0.05;
            if(this.planeSlowDownWhileTurning >= _loc1_)
            {
               this.planeSlowDownWhileTurning = _loc1_;
            }
         }
         else if(this.startedTurnSlowDown == false)
         {
            this.planeSlowDownWhileTurning -= 0.05;
            if(this.planeSlowDownWhileTurning <= 0)
            {
               this.planeSlowDownWhileTurning = 0;
            }
         }
         if(this.engineOn)
         {
            _loc2_ = Math.random() * Tracker.engineOffRandomNum;
            if(_loc2_ == 1234 && y < -600)
            {
               this.engineOn = false;
               this.stopSound();
               this.engineStarting = false;
               this.engineOnNum = 0;
               Controller.cantSpeed();
               Controller.level.hud.addBox(16750898,"Engine Fail, Press \'I\' to restart it!");
            }
            if(this.flapsFailed == false && this.flapsJammed == false)
            {
               if(Input.isKeyDown(Input.F) && this.FRelease == true)
               {
                  _loc3_ = Math.round(Math.random() * Tracker.howEasyJammFlaps);
                  if(_loc3_ == 1)
                  {
                     this.flapsJammed = true;
                     Controller.level.hud.addBox(16750898,"Flaps Jammed!");
                     if(Tracker.mute == false)
                     {
                        GameController.playSound("warning");
                     }
                  }
                  else
                  {
                     this.changeFlaps();
                     this.FRelease = false;
                     if(Tracker.mute == false)
                     {
                        GameController.playSound("changeFlaps");
                     }
                  }
               }
               else if(!Input.isKeyDown(Input.F))
               {
                  this.FRelease = true;
               }
            }
            if(Input.isKeyDown(Input.G) && this.GRelease == true && this.gearJammed == false)
            {
               if(this.jammGear == 1)
               {
                  this.gearJammed = true;
                  Controller.level.hud.addBox(16750898,"Gear Jammed!");
                  if(Tracker.mute == false)
                  {
                     GameController.playSound("warning");
                  }
               }
               else
               {
                  Controller.cantSpeed();
                  this.gearToggle();
                  this.GRelease = false;
               }
            }
            else if(!Input.isKeyDown(Input.G))
            {
               this.GRelease = true;
            }
            if(_loc1_ <= 15)
            {
               this.smokeAPM = 1;
            }
            else if(_loc1_ >= 15 && currentFrame !== 2)
            {
               this.smokeAPM = 3;
            }
            if(this.smokeOn)
            {
               _loc4_ = 0;
               while(_loc4_ < this.smokeAPM)
               {
                  Controller.level.addSmoke(x,y);
                  _loc4_++;
               }
            }
            if(Input.isKeyDown(Input.SPACE) && this.spaceDown == false && currentFrame !== 2)
            {
               Controller.cantSpeed();
               gotoAndStop("planeTurn");
               if(this.gearNum == 120)
               {
                  Controller.level.plane.planeTurn.gearTurning.alpha = 100;
               }
               if(this.gearNum == 0)
               {
                  Controller.level.plane.planeTurn.gearTurning.alpha = 0;
               }
               this.startedTurnSlowDown = true;
               this.spaceDown = true;
            }
            else if(!Input.isKeyDown(Input.SPACE))
            {
               this.spaceDown = false;
            }
            if(!Input.isKeyDown(Input.UP))
            {
               if(this.throttle > 95)
               {
                  this.totalThr -= 0.2;
               }
            }
         }
         if(Input.isKeyDown(Input.DOWN) && this.totalThr >= 0)
         {
            this.totalThr -= 0.7;
         }
         if(this.totalRotation < -80)
         {
            this.totalRotation = -80;
         }
         if(this.totalRotation > 80)
         {
            this.totalRotation = 80;
         }
         if(this.totalRotation < -60 && !this.goingRight)
         {
            if(this.throttleForStalling >= 2)
            {
               --this.throttleForStalling;
            }
         }
         else if(this.totalRotation > 60 && this.goingRight)
         {
            if(this.throttleForStalling >= 2)
            {
               --this.throttleForStalling;
            }
         }
         else if(this.throttleForStalling >= this.throttle)
         {
            this.throttleForStalling = this.throttle;
         }
         else
         {
            ++this.throttleForStalling;
         }
         this.rotationSlower = this.velocityX;
         if(Input.isKeyDown(Input.LEFT))
         {
            this.totalRotation -= 0.3 + this.throttleForStalling / 65;
         }
         else if(Input.isKeyDown(Input.RIGHT))
         {
            this.totalRotation += 0.3 + this.throttleForStalling / 65;
         }
         if(this.engineStarting)
         {
            --this.engineStartTimer;
            if(this.engineStartTimer <= 0)
            {
               this.engineOn = true;
               this.engineStartTimer = 220;
               this.engineStarting = false;
            }
         }
         if(Input.isKeyDown(Input.I) && this.engineOn == false && this.Idown == false && !this.engineStarting == true && this.win == false)
         {
            this.engineStartTimer = 220;
            Controller.cantSpeed();
            this.stopSound();
            if(Tracker.mute == false)
            {
               GameController.playSound("startEngine");
            }
            this.engineOnNum = 1;
            this.Idown = true;
            Controller.level.hud.addBox(65280,"Engine On");
            this.engineStarting = true;
         }
         else if(Input.isKeyDown(Input.I) && this.Idown == false && this.engineOn || Input.isKeyDown(Input.I) && this.Idown == false && !this.engineStarting)
         {
            this.engineOn = false;
            this.stopSound();
            if(Tracker.mute == false)
            {
               GameController.playSound("clickSound");
            }
            this.engineStarting = false;
            this.engineOnNum = 0;
            this.Idown = true;
            Controller.cantSpeed();
            Controller.level.hud.addBox(65280,"Engine Off");
         }
         else if(!Input.isKeyDown(Input.I))
         {
            this.Idown = false;
         }
      }
      
      internal function frame5() : *
      {
         if(Tracker.mute == false)
         {
            GameController.playSound("planeExplode");
         }
         Controller.level.plane.fireSound.loop(0.8);
      }
      
      public function gearToggle() : void
      {
         if(this.gearBroke == false)
         {
            if(Controller.level.plane.gear !== null)
            {
               if(Controller.level.plane.gear.currentFrame == 1)
               {
                  Controller.level.hud.pilotGui.gearOn.alpha = 1;
                  this.jammGear = Math.round(Math.random() * Tracker.howEasyJammGear);
                  Controller.level.plane.gear.gotoAndPlay(2);
                  this.gearNum = 120;
                  if(Tracker.mute == false)
                  {
                     GameController.playSound("gear");
                  }
               }
               if(Controller.level.plane.gear.currentFrame == 120 && this.inAir)
               {
                  Controller.level.hud.pilotGui.gearOn.alpha = 0;
                  this.jammGear = Math.round(Math.random() * Tracker.howEasyJammGear);
                  Controller.level.plane.gear.gotoAndPlay(121);
                  this.gearNum = 0;
                  if(Tracker.mute == false)
                  {
                     GameController.playSound("gear");
                  }
               }
            }
         }
      }
      
      public function changeFlaps() : void
      {
         Controller.level.hud.pilotGui.flapsOn.gotoAndPlay(2);
         if(this.flaps == "take off")
         {
            Controller.level.hud.pilotGui.flaps.gotoAndStop(1);
            this.flaps = "normal";
            this.flapsVel = 0.02;
         }
         else if(this.flaps == "normal")
         {
            Controller.level.hud.pilotGui.flaps.gotoAndStop(2);
            this.flaps = "landing";
            this.flapsVel = -0.05;
         }
         else if(this.flaps == "landing")
         {
            Controller.level.hud.pilotGui.flaps.gotoAndStop(3);
            this.flaps = "take off";
            this.flapsVel = 0.1;
         }
      }
      
      public function update() : void
      {
         if(Controller.level.plane == null)
         {
            return;
         }
         if(this.planeCrash == false)
         {
            this.controls();
         }
         this.victory();
         if(this.planeMovement == true)
         {
            this.movement();
         }
         this.sounds();
         this.engineOverheat();
         this.crash();
         this.steadyDrive();
         this.showStars();
      }
      
      public function varsForWhenCrashed() : void
      {
         this.planeCrash = true;
         this.engineOn = false;
         this.throttle = 0;
         rotation = 0;
         Controller.level.hud.pilotGui.alpha = 0;
         this.overSpeedSound.stop();
         this.overSpeedLooping = false;
         this.overHeatNum = 0;
         this.planeOnFire = false;
         this.planeSlowDownWhileTurning = 0;
      }
      
      public function destroy() : void
      {
         this.engineSound.destroy();
         this.engineSound2.destroy();
         this.engineSound = null;
         this.engineSound2 = null;
         this.ambience = null;
         if(this.ambience2)
         {
            this.ambience2 = null;
         }
         this.overSpeedSound = null;
         this.fireSound = null;
      }
      
      public function turned() : void
      {
         this.startedTurnSlowDown = false;
         if(this.goingRight == false)
         {
            this.goingRight = true;
            this.totalRotation = -20;
            scaleX = -1;
         }
         else if(this.goingRight == true)
         {
            this.goingRight = false;
            this.totalRotation = 20;
            scaleX = 1;
         }
      }
   }
}
