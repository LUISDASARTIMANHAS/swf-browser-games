package com.mindgame.framework
{
   import com.mindgame.battleship.*;
   import flash.display.SimpleButton;
   import flash.events.*;
   import flash.media.*;
   import flash.utils.*;
   
   public class SoundManager
   {
      
      private static var volume:Number = 1;
      
      private static var muteVolume:Number = 0;
      
      private static var oldVolume:Number = 1;
       
      
      private var allSound:Object;
      
      private var playList:Array;
      
      private var allPlaylist:Object;
      
      public var mute:Boolean = false;
      
      private var soundChannelShort:SoundChannel;
      
      private var soundChannelLong:SoundChannel;
      
      private var soundTransformShort:SoundTransform;
      
      private var soundTransformLong:SoundTransform;
      
      private var percent:Number = 0.4;
      
      private var trackNumber:int = 0;
      
      public var muteOnButton:SimpleButton;
      
      public var muteOffButton:SimpleButton;
      
      private var timer:Timer;
      
      public function SoundManager()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this.allSound = new Object();
         this.soundTransformShort = new SoundTransform();
         this.soundTransformLong = new SoundTransform();
         this.soundChannelShort = new SoundChannel();
         this.soundChannelLong = new SoundChannel();
         this.allPlaylist = new Object();
         this.playList = [];
      }
      
      public function addSound(param1:String, param2:Class, param3:Boolean = false, param4:String = "default", param5:Boolean = true) : void
      {
         this.allSound[param1] = new param2();
         if(param3)
         {
            this.addSoundInPlaylist(param4,param1,param5);
         }
      }
      
      public function addShortSound(param1:String, param2:Class, param3:Number = 1) : void
      {
         this.allSound[param1] = new param2();
      }
      
      public function playShortSound(param1:String) : void
      {
         this.setShortSoundSetup();
         this.soundChannelShort = (this.allSound[param1] as Sound).play(0,0,this.soundTransformShort);
      }
      
      public function addSoundInPlaylist(param1:String, param2:String, param3:Boolean = true) : void
      {
         var _loc4_:int = 0;
         if(this.allPlaylist[param1])
         {
            this.playList = this.allPlaylist[param1] as Array;
         }
         else
         {
            this.playList = [];
         }
         if(param3)
         {
            this.playList[this.playList.length] = this.allSound[param2] as Sound;
         }
         else
         {
            _loc4_ = 0;
            while(_loc4_ < this.playList.length + 1)
            {
               if(_loc4_ < this.playList.length)
               {
                  this.playList[this.playList.length - _loc4_] = this.playList[this.playList.length - _loc4_ - 1];
               }
               else
               {
                  this.playList[0] = this.allSound[param2];
               }
               _loc4_++;
            }
         }
         this.allPlaylist[param1] = this.playList;
      }
      
      private function delayStartPlay(param1:Function, param2:Number, param3:Boolean) : void
      {
         var del:*;
         var f:Function = param1;
         var d:Number = param2;
         var fade:Boolean = param3;
         if(this.timer != null)
         {
            this.timer = null;
         }
         if(fade)
         {
            del = function(param1:TimerEvent):void
            {
               if(oldVolume != volume)
               {
                  volume += 0.01;
                  setLongSoundSetup();
               }
            };
            oldVolume = volume;
            volume = 0;
            this.setLongSoundSetup();
            f();
            this.timer = new Timer(d * 10,100);
            this.timer.addEventListener(TimerEvent.TIMER,del,false,0,true);
         }
         else
         {
            this.timer = new Timer(d * 1000,1);
            this.timer.addEventListener(TimerEvent.TIMER_COMPLETE,f,false,0,true);
         }
         this.timer.start();
      }
      
      public function playPlaylist(param1:String, param2:int = 0, param3:Number = 0, param4:Boolean = true) : void
      {
         if(this.allPlaylist[param1])
         {
            this.playList = this.allPlaylist[param1] as Array;
            if(param2 >= 0)
            {
               this.trackNumber = param2;
            }
            else
            {
               this.trackNumber = XORRandom.randomRangeInt(0,this.playList.length);
            }
            if(param3 > 0 && !this.mute)
            {
               this.delayStartPlay(this.nextSound,param3,param4);
            }
            else
            {
               this.nextSound();
            }
         }
      }
      
      internal function nextSound(param1:Event = null) : void
      {
         if(this.trackNumber >= this.playList.length)
         {
            this.trackNumber = 0;
         }
         this.setLongSoundSetup();
         this.soundChannelLong = (this.playList[this.trackNumber] as Sound).play(0,0,this.soundTransformLong);
         this.soundChannelLong.addEventListener(Event.SOUND_COMPLETE,this.nextSound,false,0,true);
         ++this.trackNumber;
      }
      
      public function stopPlaylist() : void
      {
         this.soundChannelLong.stop();
         this.soundChannelLong.removeEventListener(Event.SOUND_COMPLETE,this.nextSound);
      }
      
      public function muteAllSound(param1:MouseEvent = null, param2:Boolean = false) : void
      {
         if(this.timer)
         {
            if(this.timer.running)
            {
               volume = oldVolume;
               this.timer.stop();
            }
         }
         if(this.mute)
         {
            if(param1 != null || param2)
            {
               App.handMute = false;
            }
            if(this.muteOnButton != null)
            {
               this.muteOnButton.visible = false;
               this.muteOffButton.visible = true;
            }
            this.mute = false;
            this.setAllVolume(oldVolume);
         }
         else
         {
            if(param1 != null || param2)
            {
               App.handMute = true;
            }
            if(this.muteOffButton != null)
            {
               this.muteOnButton.visible = true;
               this.muteOffButton.visible = false;
            }
            this.mute = true;
            oldVolume = volume;
            this.setAllVolume(muteVolume);
         }
      }
      
      public function setAllVolume(param1:Number) : void
      {
         volume = param1;
         this.setSoundSetup();
      }
      
      private function setShortSoundSetup() : void
      {
         this.soundTransformShort.volume = volume;
         this.soundChannelShort.soundTransform = this.soundTransformShort;
      }
      
      private function setLongSoundSetup() : void
      {
         this.soundTransformLong.volume = volume * this.percent;
         this.soundChannelLong.soundTransform = this.soundTransformLong;
      }
      
      private function setSoundSetup() : void
      {
         this.soundTransformShort.volume = volume;
         this.soundTransformLong.volume = volume * this.percent;
         this.soundChannelLong.soundTransform = this.soundTransformLong;
         this.soundChannelShort.soundTransform = this.soundTransformShort;
      }
   }
}
