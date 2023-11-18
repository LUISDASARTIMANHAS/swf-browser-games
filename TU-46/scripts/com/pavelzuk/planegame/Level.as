package com.pavelzuk.planegame
{
   import flash.display.Sprite;
   import flash.net.SharedObject;
   
   public class Level
   {
       
      
      public var ground:Ground;
      
      public var passengersInjured:Number = 0;
      
      public var blackSmokeArray:Array;
      
      public var trees:*;
      
      public var cameraPlacementX:Number = 0;
      
      public var passengers:Number = 300;
      
      public var backgroundManager:BackgroundManager;
      
      public var treesGoto:String = "grass";
      
      public var smokeArray:Array;
      
      public var mapManager:*;
      
      public var groundY:Number = 400;
      
      public var bgClip:Sprite;
      
      public var planeShade:PlaneShade;
      
      public var normalLayer:Sprite;
      
      public var salary:int = 0;
      
      public var cameraOb:Object = null;
      
      public var objectArray:Array;
      
      public var plane:Plane;
      
      public var shakeTimer:Number = 0;
      
      public var map:Map;
      
      public var bottomLayer:Sprite;
      
      public var hudClip:Sprite;
      
      public var gameClip:Sprite;
      
      public var salaryNum:Number = 5000;
      
      public var landSmokeArray:Array;
      
      public var hud:HUD;
      
      public var minimumSalary:Number = 1;
      
      public var topLayer:Sprite;
      
      public function Level()
      {
         this.map = new Map();
         this.ground = new Ground();
         this.mapManager = new MapManager();
         this.trees = new Trees();
         this.objectArray = [];
         this.smokeArray = [];
         this.blackSmokeArray = [];
         this.landSmokeArray = [];
         super();
      }
      
      public function destroy() : void
      {
         this.hud.parent.removeChild(this.hud);
         this.hud = null;
         GameController.timeline.removeChild(this.hudClip);
         this.map = null;
         this.plane.destroy();
         this.plane = null;
         this.destroyLayers();
      }
      
      public function create() : void
      {
         trace(Sfx);
         trace("Level Created!");
         this.createLayers();
         GameController.timeline.addChildAt(this.hudClip = new Sprite(),1);
         this.hudClip.addChild(this.hud = new HUD());
         this.hud.create();
         this.addPlane(100,this.groundY);
         this.cameraOb = this.plane;
         this.backgroundManager = new BackgroundManager();
         this.backgroundManager.create("Mountains");
         this.ground.x = 0;
         this.ground.y = this.groundY;
         this.normalLayer.addChild(this.ground);
         this.map.x = 0;
         this.map.y = this.groundY;
         this.normalLayer.addChild(this.map);
         if(Tracker.weatherRandomized == "Rain")
         {
            trace("YES CHECKED FOR RAIN");
            Controller.level.hud.rain.gotoAndStop("rain");
            Controller.level.hud.over.gotoAndStop("rain");
            Controller.level.plane.raining = true;
            Controller.level.plane.rainFx.gotoAndStop(2);
         }
         else if(Tracker.weatherRandomized == "Fog")
         {
            Controller.level.hud.rain.gotoAndStop("fog");
            Controller.level.hud.over.gotoAndStop("fog");
         }
         else if(Tracker.weatherRandomized == "Clouds")
         {
            Controller.level.hud.over.gotoAndStop("clouds");
         }
      }
      
      public function shake(param1:Number) : void
      {
         this.shakeTimer = param1;
      }
      
      public function addLandSmoke(param1:Number, param2:Number) : void
      {
         var _loc3_:LandSmoke = new LandSmoke();
         _loc3_.x = param1;
         _loc3_.y = param2;
         _loc3_.vx = (Math.random() - Math.random()) * 5;
         _loc3_.vy = (Math.random() - Math.random()) * 5;
         _loc3_.life = Math.random() * 5 + 10;
         this.landSmokeArray.push(_loc3_);
         this.topLayer.addChild(_loc3_);
      }
      
      public function updateSmoke() : void
      {
         var _loc2_:Smoke = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.smokeArray.length)
         {
            _loc2_ = this.smokeArray[_loc1_];
            _loc2_.vy -= 0.2;
            _loc2_.vx *= 0.9;
            _loc2_.vy *= 0.9;
            _loc2_.x += _loc2_.vx;
            _loc2_.y += _loc2_.vy;
            --_loc2_.life;
            if(_loc2_.life <= 10)
            {
               _loc2_.alpha -= 0.1;
            }
            if(_loc2_.life <= 0)
            {
               _loc2_.parent.removeChild(_loc2_);
               this.smokeArray.splice(_loc1_,1);
               _loc1_--;
            }
            _loc1_++;
         }
      }
      
      public function addPlane(param1:Number, param2:Number) : void
      {
         this.planeShade = new PlaneShade();
         this.topLayer.addChild(this.planeShade);
         this.planeShade.y = this.groundY;
         this.plane = new Plane();
         this.plane.create(param1,param2);
         this.topLayer.addChild(this.plane);
      }
      
      public function update() : void
      {
         if(Controller.gamePaused)
         {
            return;
         }
         this.levelUpdate();
      }
      
      public function addBlackSmoke(param1:Number, param2:Number) : void
      {
         var _loc3_:BlackSmoke = new BlackSmoke();
         _loc3_.x = param1 - (Math.random() - Math.random()) * 2;
         _loc3_.y = param2 - (Math.random() - Math.random()) * 2;
         _loc3_.vy = (Math.random() - Math.random()) * 5;
         _loc3_.scaleX = _loc3_.scaleY = Math.random() + 0.2;
         _loc3_.life = Math.random() * 5 + 20;
         this.blackSmokeArray.push(_loc3_);
         this.topLayer.addChild(_loc3_);
      }
      
      public function cameraUpdate() : void
      {
         if(this.cameraOb == null)
         {
            return;
         }
         this.gameClip.x -= Math.round((this.gameClip.x - (this.cameraPlacementX - this.cameraOb.x)) / 2);
         this.gameClip.y -= Math.round((this.gameClip.y - (370 - this.cameraOb.y)) / 5);
         if(this.gameClip.y < 60)
         {
            this.gameClip.y = 60;
         }
      }
      
      public function saveData() : void
      {
         var _loc1_:SharedObject = GameController.getSharedObject();
         trace("Save Data!");
      }
      
      public function updateBlackSmoke() : void
      {
         var _loc2_:BlackSmoke = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.blackSmokeArray.length)
         {
            _loc2_ = this.blackSmokeArray[_loc1_];
            _loc2_.vy -= 0.2;
            _loc2_.vy *= 0.9;
            _loc2_.y += _loc2_.vy;
            --_loc2_.life;
            if(_loc2_.life <= 10)
            {
               _loc2_.alpha -= 0.1;
            }
            if(_loc2_.life <= 0)
            {
               _loc2_.parent.removeChild(_loc2_);
               this.blackSmokeArray.splice(_loc1_,1);
               _loc1_--;
            }
            _loc1_++;
         }
      }
      
      public function addSmoke(param1:Number, param2:Number) : void
      {
         var _loc3_:Smoke = new Smoke();
         _loc3_.x = param1 - (Math.random() - Math.random()) * 10;
         _loc3_.y = param2 - (Math.random() - Math.random()) * 10;
         _loc3_.vx = (Math.random() - Math.random()) * 5;
         _loc3_.vy = (Math.random() - Math.random()) * 5;
         _loc3_.scaleX = _loc3_.scaleY = Math.random() + 0.2;
         _loc3_.life = Math.random() * 25 + 50;
         this.smokeArray.push(_loc3_);
         this.normalLayer.addChild(_loc3_);
      }
      
      public function createLayers() : void
      {
         Controller.content.addChild(this.bgClip = new Sprite());
         Controller.content.addChild(this.gameClip = new Sprite());
         this.gameClip.addChild(this.bottomLayer = new Sprite());
         this.gameClip.addChild(this.normalLayer = new Sprite());
         this.gameClip.addChild(this.topLayer = new Sprite());
      }
      
      private function levelUpdate() : void
      {
         this.planeShade.x = this.plane.x;
         if(!Controller.gameOver)
         {
            this.hud.update();
         }
         if(!Controller.gameOver)
         {
            this.plane.update();
         }
         this.shakeUpdate();
         this.cameraUpdate();
         this.backgroundManager.update();
         this.updateSmoke();
         this.updateBlackSmoke();
         this.updateLandSmoke();
      }
      
      private function shakeUpdate() : void
      {
         if(this.shakeTimer > 0)
         {
            this.gameClip.x -= (Math.random() - Math.random()) * this.plane.lift * 50;
            this.gameClip.y -= (Math.random() - Math.random()) * this.plane.lift * 50;
            --this.shakeTimer;
         }
      }
      
      public function destroyLayers() : void
      {
         if(this.bgClip != null)
         {
            Controller.content.removeChild(this.bgClip);
         }
         if(this.gameClip != null)
         {
            this.gameClip.removeChild(this.bottomLayer);
            this.gameClip.removeChild(this.normalLayer);
            this.gameClip.removeChild(this.topLayer);
            this.gameClip = null;
         }
      }
      
      public function updateLandSmoke() : void
      {
         var _loc2_:LandSmoke = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.landSmokeArray.length)
         {
            _loc2_ = this.landSmokeArray[_loc1_];
            _loc2_.vy -= 0.2;
            _loc2_.vx *= 0.9;
            _loc2_.vy *= 0.9;
            --_loc2_.life;
            if(_loc2_.life <= 10)
            {
               _loc2_.alpha -= 0.1;
            }
            if(_loc2_.life <= 0)
            {
               _loc2_.parent.removeChild(_loc2_);
               this.landSmokeArray.splice(_loc1_,1);
               _loc1_--;
            }
            _loc1_++;
         }
      }
   }
}
