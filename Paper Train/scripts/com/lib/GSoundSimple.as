package com.lib
{
   import flash.events.*;
   import flash.geom.*;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.utils.*;
   
   public class GSoundSimple
   {
       
      
      private var fadeOutCalls:int;
      
      private var menuOverFx:* = null;
      
      private var sfxSwitchCallback:* = null;
      
      private var sfxList:*;
      
      private var musicChannels:Array;
      
      private var fadeOutStep:Number;
      
      private var sfxIcon:* = null;
      
      private var fadeOutEventCount:int;
      
      private var sfxEnabled:*;
      
      private var fadeOutTimer:Timer = null;
      
      private var music:Sound = null;
      
      private var fadeVolume:Number = 1;
      
      private var sfxVolume:Number = 1;
      
      public function GSoundSimple(param1:* = true, param2:* = null)
      {
         this.sfxList = new Object();
         super();
         this.sfxEnabled = param1;
         this.menuOverFx = param2;
         this.musicChannels = new Array();
      }
      
      public function enableSfx(param1:Boolean, param2:* = true) : *
      {
         var _loc3_:* = undefined;
         if(this.sfxSwitchCallback && param2 && param1 != this.sfxEnabled)
         {
            this.sfxSwitchCallback(param1);
         }
         this.sfxEnabled = param1;
         for each(_loc3_ in this.musicChannels)
         {
            if(_loc3_.used)
            {
               this.updateChannelVolume(_loc3_.channel);
            }
         }
         if(this.sfxIcon)
         {
            if(param1)
            {
               this.sfxIcon.gotoAndStop(1);
            }
            else
            {
               this.sfxIcon.gotoAndStop(4);
            }
         }
      }
      
      public function addSfxIcon(param1:*) : *
      {
         this.sfxIcon = new param1();
         this.sfxIcon.buttonMode = true;
         this.enableSfx(this.sfxEnabled);
         this.sfxIcon.addEventListener(MouseEvent.CLICK,this.clickSfxIcon);
         this.sfxIcon.addEventListener(MouseEvent.MOUSE_OVER,this.overSfxIcon);
         this.sfxIcon.addEventListener(MouseEvent.MOUSE_OUT,this.outSfxIcon);
         return this.sfxIcon;
      }
      
      private function fadeOutEvent(param1:TimerEvent) : *
      {
         var _loc2_:* = undefined;
         ++this.fadeOutEventCount;
         if(this.fadeOutEventCount >= this.fadeOutCalls)
         {
            this.fadeVolume = 0;
         }
         else
         {
            this.fadeVolume -= this.fadeOutStep;
         }
         if(this.fadeVolume < 0)
         {
            this.fadeVolume = 0;
         }
         for each(_loc2_ in this.musicChannels)
         {
            if(_loc2_.used)
            {
               this.updateChannelVolume(_loc2_.channel);
            }
         }
      }
      
      public function getSfxVolume() : *
      {
         return this.sfxVolume;
      }
      
      private function updateChannelVolume(param1:SoundChannel) : *
      {
         if(param1)
         {
            param1.soundTransform = new SoundTransform(!!this.sfxEnabled ? this.sfxVolume * this.fadeVolume : 0);
         }
      }
      
      private function stopFadeOut() : *
      {
         this.fadeVolume = 1;
         if(this.fadeOutTimer)
         {
            this.fadeOutTimer.stop();
            this.fadeOutTimer.removeEventListener(TimerEvent.TIMER,this.fadeOutEvent);
            this.fadeOutTimer = null;
         }
      }
      
      public function fadeOutMusic(param1:int = 700) : *
      {
         if(this.fadeOutTimer)
         {
            return;
         }
         this.fadeOutCalls = int(param1 / 25) + 1;
         this.fadeOutStep = 1 / this.fadeOutCalls;
         this.fadeOutEventCount = 0;
         this.fadeOutTimer = new Timer(25,this.fadeOutCalls);
         this.fadeOutTimer.addEventListener(TimerEvent.TIMER,this.fadeOutEvent);
         this.fadeOutTimer.start();
      }
      
      public function resetChannels() : *
      {
         this.stopAllMusic();
         this.musicChannels = new Array();
      }
      
      public function playMusic(param1:*) : *
      {
         this.stopFadeOut();
         this.music = new param1();
         var _loc2_:* = new Object();
         _loc2_.channel = this.music.play(0,1000,new SoundTransform(!!this.sfxEnabled ? this.sfxVolume : 0));
         _loc2_.used = true;
         this.updateChannelVolume(_loc2_.channel);
         this.musicChannels.push(_loc2_);
         return _loc2_;
      }
      
      public function stop(param1:SoundChannel) : *
      {
         if(param1)
         {
            param1.stop();
         }
      }
      
      public function stopMusic(param1:Object) : *
      {
         if(!param1)
         {
            return;
         }
         if(!param1.used)
         {
            return;
         }
         param1.channel.stop();
         param1.used = false;
      }
      
      public function isEnabledSfx() : *
      {
         return this.sfxEnabled;
      }
      
      private function clickSfxIcon(param1:MouseEvent) : *
      {
         var _loc2_:* = undefined;
         this.sfxEnabled = !this.sfxEnabled;
         if(this.sfxSwitchCallback)
         {
            this.sfxSwitchCallback(this.sfxEnabled);
         }
         for each(_loc2_ in this.musicChannels)
         {
            if(_loc2_.used)
            {
               this.updateChannelVolume(_loc2_.channel);
            }
         }
         if(this.sfxEnabled)
         {
            this.sfxIcon.gotoAndStop(2);
         }
         else
         {
            this.sfxIcon.gotoAndStop(3);
         }
      }
      
      public function stopAllMusic() : *
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this.musicChannels)
         {
            if(_loc1_.used)
            {
               _loc1_.channel.stop();
               _loc1_.used = false;
            }
         }
      }
      
      private function outSfxIcon(param1:MouseEvent) : *
      {
         if(this.sfxEnabled)
         {
            this.sfxIcon.gotoAndStop(1);
         }
         else
         {
            this.sfxIcon.gotoAndStop(4);
         }
      }
      
      private function overSfxIcon(param1:MouseEvent) : *
      {
         if(this.menuOverFx)
         {
            this.play(this.menuOverFx);
         }
         if(this.sfxEnabled)
         {
            this.sfxIcon.gotoAndStop(2);
         }
         else
         {
            this.sfxIcon.gotoAndStop(3);
         }
      }
      
      public function setSfxSwitchCallback(param1:Function) : *
      {
         this.sfxSwitchCallback = param1;
      }
      
      public function play(param1:*, param2:Boolean = false, param3:int = 0, param4:int = 300) : SoundChannel
      {
         if(!this.sfxEnabled)
         {
            return null;
         }
         var _loc5_:* = new Date();
         var _loc6_:* = getQualifiedClassName(param1).toString();
         if(!param2)
         {
            if(this.sfxList && Boolean(this.sfxList[_loc6_]) && _loc5_.time - this.sfxList[_loc6_] < param4)
            {
               return null;
            }
            this.sfxList[_loc6_] = _loc5_.time;
         }
         var _loc7_:*;
         var _loc8_:* = (_loc7_ = new param1()).play(param3);
         this.updateChannelVolume(_loc8_);
         return _loc8_;
      }
      
      public function setSfxVolume(param1:Number) : *
      {
         var _loc2_:* = undefined;
         this.sfxVolume = param1;
         for each(_loc2_ in this.musicChannels)
         {
            if(_loc2_.used)
            {
               this.updateChannelVolume(_loc2_.channel);
            }
         }
      }
   }
}
