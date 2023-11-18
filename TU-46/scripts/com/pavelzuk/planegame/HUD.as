package com.pavelzuk.planegame
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.*;
   
   [Embed(source="/_assets/assets.swf", symbol="com.pavelzuk.planegame.HUD")]
   public class HUD extends Sprite
   {
       
      
      public var zIcons:MovieClip;
      
      public var boxList:Array;
      
      public var rain:MovieClip;
      
      public var over:MovieClip;
      
      public var tutorial:MovieClip;
      
      public var pilotGui:MovieClip;
      
      public var pauseMc:MovieClip;
      
      public var crashText:MovieClip;
      
      public var messageTimer:Number = 50;
      
      public function HUD()
      {
         this.boxList = [];
         super();
      }
      
      internal function pmgBtnF(param1:MouseEvent) : void
      {
         navigateToURL(new URLRequest("http://armorgames.com"),"_blank");
      }
      
      public function create() : *
      {
         this.over.mouseEnabled = false;
         this.pilotGui.throttleAnimation.mouseEnabled = false;
         this.pilotGui.muteOn.alpha = 0;
      }
      
      public function messages() : void
      {
      }
      
      internal function confirmtoquitBtn2F(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         GameController.transition.playTween(function():*
         {
            Tracker.abandon = true;
            Controller.pauseToggle();
            Controller.destroy();
            GameController.timeline.gotoAndStop(30);
         });
         Controller.level.hud.pauseMc.pauseMc.confirmtoquit.confirmBtn.removeEventListener(MouseEvent.CLICK,this.confirmtoquitBtn2F);
         Controller.level.hud.pauseMc.pauseMc.confirmtoquit.cancelBtn.removeEventListener(MouseEvent.CLICK,this.canceltoquitBtn2F);
         Controller.level.hud.pauseMc.pauseMc.removeEventListener(MouseEvent.CLICK,this.pmgBtnF);
         Controller.level.hud.pauseMc.titleMc.armorBtn.removeEventListener(MouseEvent.CLICK,this.armorBtnF);
      }
      
      internal function canceltoquitBtnF(param1:MouseEvent) : void
      {
         Controller.level.hud.pauseMc.pauseMc.confirmtoquit.x = -1800;
         Controller.level.hud.pauseMc.pauseMc.confirmtoquit.y = -40;
         Controller.level.hud.pauseMc.pauseMc.confirmtoquit.confirmBtn.removeEventListener(MouseEvent.CLICK,this.confirmtoquitBtnF);
         Controller.level.hud.pauseMc.pauseMc.confirmtoquit.cancelBtn.removeEventListener(MouseEvent.CLICK,this.canceltoquitBtnF);
      }
      
      internal function resumeBtnF(param1:MouseEvent) : void
      {
         Controller.pauseToggle();
         Controller.level.hud.pauseMc.pauseMc.confirmtoquit.confirmBtn.removeEventListener(MouseEvent.CLICK,this.confirmtoquitBtnF);
         Controller.level.hud.pauseMc.pauseMc.confirmtoquit.cancelBtn.removeEventListener(MouseEvent.CLICK,this.canceltoquitBtnF);
         Controller.level.hud.pauseMc.pauseMc.confirmtoquit2.confirmBtn.removeEventListener(MouseEvent.CLICK,this.confirmtoquitBtn2F);
         Controller.level.hud.pauseMc.pauseMc.confirmtoquit2.cancelBtn.removeEventListener(MouseEvent.CLICK,this.canceltoquitBtn2F);
         Controller.level.hud.pauseMc.pauseMc.removeEventListener(MouseEvent.CLICK,this.pmgBtnF);
         Controller.level.hud.pauseMc.titleMc.armorBtn.removeEventListener(MouseEvent.CLICK,this.armorBtnF);
      }
      
      public function update() : void
      {
         if(Controller.level.hud == null)
         {
            return;
         }
         this.pilotGuis();
         this.messages();
         this.updateBoxes();
      }
      
      internal function canceltoquitBtn2F(param1:MouseEvent) : void
      {
         Controller.level.hud.pauseMc.pauseMc.confirmtoquit2.x = -1800;
         Controller.level.hud.pauseMc.pauseMc.confirmtoquit2.y = -40;
         Controller.level.hud.pauseMc.pauseMc.confirmtoquit2.confirmBtn.removeEventListener(MouseEvent.CLICK,this.confirmtoquitBtn2F);
         Controller.level.hud.pauseMc.pauseMc.confirmtoquit2.cancelBtn.removeEventListener(MouseEvent.CLICK,this.canceltoquitBtn2F);
      }
      
      internal function addWinBox(param1:*, param2:*) : void
      {
         var _loc3_:Box = null;
         if(Tracker.mute == false)
         {
            GameController.playSound("newMessage");
         }
         _loc3_ = new Box();
         _loc3_.gotoAndStop(2);
         _loc3_.x = 335;
         _loc3_.y = 560;
         _loc3_.targetY = this.boxList.length * 30 + 138;
         _loc3_.vy = -20;
         _loc3_.life = 99999999;
         this.boxList.push(_loc3_);
         addChild(_loc3_);
         _loc3_.txt.text = String(param2);
         _loc3_.txt.textColor = param1;
      }
      
      internal function quitBtnF(param1:MouseEvent) : void
      {
         Controller.level.hud.pauseMc.pauseMc.confirmtoquit.x = 180;
         Controller.level.hud.pauseMc.pauseMc.confirmtoquit.y = -40;
         Controller.level.hud.pauseMc.pauseMc.confirmtoquit.confirmBtn.addEventListener(MouseEvent.CLICK,this.confirmtoquitBtnF);
         Controller.level.hud.pauseMc.pauseMc.confirmtoquit.cancelBtn.addEventListener(MouseEvent.CLICK,this.canceltoquitBtnF);
         Controller.level.hud.pauseMc.pauseMc.confirmtoquit2.confirmBtn.removeEventListener(MouseEvent.CLICK,this.confirmtoquitBtn2F);
         Controller.level.hud.pauseMc.pauseMc.confirmtoquit2.cancelBtn.removeEventListener(MouseEvent.CLICK,this.canceltoquitBtn2F);
      }
      
      internal function pauseHud() : void
      {
         Controller.level.hud.pilotGui.alpha = 0;
         Controller.level.hud.pauseMc.gotoAndPlay(2);
         Controller.level.hud.pauseMc.pauseMc.resumeBtn.addEventListener(MouseEvent.CLICK,this.resumeBtnF);
         Controller.level.hud.pauseMc.pauseMc.quitBtn.addEventListener(MouseEvent.CLICK,this.quitBtnF);
         Controller.level.hud.pauseMc.pauseMc.pmgBtn.addEventListener(MouseEvent.CLICK,this.pmgBtnF);
         Controller.level.hud.pauseMc.titleMc.armorBtn.addEventListener(MouseEvent.CLICK,this.armorBtnF);
         if(Tracker.currentCity !== "tupolev")
         {
            Controller.level.hud.pauseMc.pauseMc.abandonBtn.addEventListener(MouseEvent.CLICK,this.abandonBtnF);
         }
      }
      
      internal function loop(param1:Event) : void
      {
         this.updateBoxes();
      }
      
      internal function addBox(param1:*, param2:*) : void
      {
         if(Tracker.mute == false)
         {
            GameController.playSound("newMessage");
         }
         var _loc3_:Box = new Box();
         _loc3_.x = 10;
         _loc3_.y = 560;
         _loc3_.targetY = this.boxList.length * 20 + 168;
         _loc3_.vy = -20;
         _loc3_.life = 300;
         this.boxList.push(_loc3_);
         addChild(_loc3_);
         _loc3_.txt.text = String(param2);
         _loc3_.txt.textColor = param1;
      }
      
      internal function armorBtnF(param1:MouseEvent) : void
      {
         navigateToURL(new URLRequest("http://www.armorgames.com/"),"_blank");
      }
      
      internal function updateBoxes() : void
      {
         var _loc2_:Box = null;
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         while(_loc1_ < this.boxList.length)
         {
            _loc2_ = this.boxList[_loc1_];
            if(_loc2_.y <= _loc2_.targetY - _loc2_.vy)
            {
               _loc2_.y = _loc2_.targetY;
               _loc2_.vy = 0;
            }
            else
            {
               _loc2_.vy *= 0.95;
               _loc2_.vy -= 0.2;
               _loc2_.y += _loc2_.vy;
            }
            --_loc2_.life;
            if(_loc2_.life <= 0)
            {
               _loc2_.alpha -= 0.02;
               if(_loc2_.alpha <= 0)
               {
                  _loc2_.parent.removeChild(_loc2_);
                  this.boxList.splice(_loc1_,1);
                  _loc2_ = null;
                  _loc1_--;
                  _loc3_ = 0;
                  while(_loc3_ < this.boxList.length)
                  {
                     if(Controller.level.plane.win == false)
                     {
                        this.boxList[_loc3_].targetY = _loc3_ * 20 + 168;
                     }
                     _loc3_++;
                  }
               }
            }
            _loc1_++;
         }
      }
      
      internal function confirmtoquitBtnF(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         GameController.transition.playTween(function():*
         {
            Controller.pauseToggle();
            Controller.destroy();
            GameController.timeline.gotoAndStop(14);
            GameController.timeline.gotoAndStop(15);
         });
         Controller.level.hud.pauseMc.pauseMc.confirmtoquit.confirmBtn.removeEventListener(MouseEvent.CLICK,this.confirmtoquitBtnF);
         Controller.level.hud.pauseMc.pauseMc.confirmtoquit.cancelBtn.removeEventListener(MouseEvent.CLICK,this.canceltoquitBtnF);
         Controller.level.hud.pauseMc.pauseMc.removeEventListener(MouseEvent.CLICK,this.pmgBtnF);
         Controller.level.hud.pauseMc.titleMc.armorBtn.removeEventListener(MouseEvent.CLICK,this.armorBtnF);
      }
      
      internal function abandonBtnF(param1:MouseEvent) : void
      {
         Controller.level.hud.pauseMc.pauseMc.confirmtoquit2.x = 180;
         Controller.level.hud.pauseMc.pauseMc.confirmtoquit2.y = -40;
         Controller.level.hud.pauseMc.pauseMc.confirmtoquit2.confirmBtn.addEventListener(MouseEvent.CLICK,this.confirmtoquitBtn2F);
         Controller.level.hud.pauseMc.pauseMc.confirmtoquit2.cancelBtn.addEventListener(MouseEvent.CLICK,this.canceltoquitBtn2F);
      }
      
      internal function unpauseHud() : void
      {
         Controller.level.hud.pilotGui.alpha = 1;
         Controller.level.hud.pauseMc.gotoAndPlay("pauseLabel");
         Controller.level.hud.pauseMc.pauseMc.resumeBtn.removeEventListener(MouseEvent.CLICK,this.resumeBtnF);
         Controller.level.hud.pauseMc.pauseMc.quitBtn.removeEventListener(MouseEvent.CLICK,this.quitBtnF);
         Controller.level.hud.pauseMc.pauseMc.confirmtoquit.confirmBtn.removeEventListener(MouseEvent.CLICK,this.confirmtoquitBtnF);
         Controller.level.hud.pauseMc.pauseMc.confirmtoquit.cancelBtn.removeEventListener(MouseEvent.CLICK,this.canceltoquitBtnF);
         Controller.level.hud.pauseMc.pauseMc.confirmtoquit2.confirmBtn.removeEventListener(MouseEvent.CLICK,this.confirmtoquitBtn2F);
         Controller.level.hud.pauseMc.pauseMc.confirmtoquit2.cancelBtn.removeEventListener(MouseEvent.CLICK,this.canceltoquitBtn2F);
         Controller.level.hud.pauseMc.titleMc.armorBtn.removeEventListener(MouseEvent.CLICK,this.armorBtnF);
         Controller.level.hud.pauseMc.pauseMc.removeEventListener(MouseEvent.CLICK,this.pmgBtnF);
      }
      
      public function pilotGuis() : void
      {
         this.pilotGui.radarMap.mapMc.destinationMini.x = Tracker.destinationNumFix;
         this.pilotGui.radarMap.mapMc.x = -Math.floor(Controller.level.plane.x) / 220;
         this.pilotGui.radarMap.mapMc.y = -Math.floor(Controller.level.plane.y + 6500) / 220;
         this.pilotGui.radarMap.line.y = this.pilotGui.radarMap.mapMc.y;
         this.pilotGui.speedAnim.gotoAndStop(Math.round(Controller.level.plane.speed * 100));
         this.pilotGui.throttle.text = String(Math.round(Controller.level.plane.throttle));
         this.pilotGui.heightTxt.text = String(Math.round(Math.abs(Controller.level.plane.y - 400)) - Controller.level.plane.groundHeight);
         this.pilotGui.heightMC.rotation = Math.round(Math.abs(Controller.level.plane.y - 400)) / 20;
         this.pilotGui.engineOn.alpha = Controller.level.plane.engineOnNum;
         this.pilotGui.throttleAnimation.gotoAndStop(Math.round(Controller.level.plane.throttle * 2));
         if(Controller.level.plane.y == Controller.level.groundY - Controller.level.plane.groundHeight)
         {
            this.pilotGui.animationY.gotoAndStop(250);
         }
         else
         {
            this.pilotGui.animationY.gotoAndStop(Math.round(Controller.level.plane.velocityY * 50) + 250);
         }
      }
   }
}
