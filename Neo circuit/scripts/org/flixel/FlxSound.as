package org.flixel
{
   import flash.events.Event;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.net.URLRequest;
   
   public class FlxSound extends FlxBasic
   {
       
      
      public var x:Number;
      
      public var y:Number;
      
      public var survive:Boolean;
      
      public var name:String;
      
      public var artist:String;
      
      public var amplitude:Number;
      
      public var amplitudeLeft:Number;
      
      public var amplitudeRight:Number;
      
      protected var _sound:Sound;
      
      protected var _channel:SoundChannel;
      
      protected var _transform:SoundTransform;
      
      protected var _position:Number;
      
      protected var _volume:Number;
      
      protected var _volumeAdjust:Number;
      
      protected var _looped:Boolean;
      
      protected var _target:FlxObject;
      
      protected var _radius:Number;
      
      protected var _pan:Boolean;
      
      protected var _fadeOutTimer:Number;
      
      protected var _fadeOutTotal:Number;
      
      protected var _pauseOnFadeOut:Boolean;
      
      protected var _fadeInTimer:Number;
      
      protected var _fadeInTotal:Number;
      
      public function FlxSound()
      {
         super();
         this.createSound();
      }
      
      protected function createSound() : void
      {
         this.destroy();
         this.x = 0;
         this.y = 0;
         if(this._transform == null)
         {
            this._transform = new SoundTransform();
         }
         this._transform.pan = 0;
         this._sound = null;
         this._position = 0;
         this._volume = 1;
         this._volumeAdjust = 1;
         this._looped = false;
         this._target = null;
         this._radius = 0;
         this._pan = false;
         this._fadeOutTimer = 0;
         this._fadeOutTotal = 0;
         this._pauseOnFadeOut = false;
         this._fadeInTimer = 0;
         this._fadeInTotal = 0;
         exists = false;
         active = false;
         visible = false;
         this.name = null;
         this.artist = null;
         this.amplitude = 0;
         this.amplitudeLeft = 0;
         this.amplitudeRight = 0;
      }
      
      override public function destroy() : void
      {
         this.stop();
         this._transform = null;
         this._sound = null;
         this._target = null;
         this.name = null;
         this.artist = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         var _loc3_:Number = NaN;
         if(this._position != 0)
         {
            return;
         }
         var _loc1_:Number = 1;
         var _loc2_:Number = 1;
         if(this._target != null)
         {
            _loc1_ = FlxU.getDistance(new FlxPoint(this._target.x,this._target.y),new FlxPoint(this.x,this.y)) / this._radius;
            if(_loc1_ < 0)
            {
               _loc1_ = 0;
            }
            if(_loc1_ > 1)
            {
               _loc1_ = 1;
            }
            if(this._pan)
            {
               _loc3_ = (this._target.x - this.x) / this._radius;
               if(_loc3_ < -1)
               {
                  _loc3_ = -1;
               }
               else if(_loc3_ > 1)
               {
                  _loc3_ = 1;
               }
               this._transform.pan = _loc3_;
            }
         }
         if(this._fadeOutTimer > 0)
         {
            this._fadeOutTimer -= FlxG.elapsed;
            if(this._fadeOutTimer <= 0)
            {
               if(this._pauseOnFadeOut)
               {
                  this.pause();
               }
               else
               {
                  this.stop();
               }
            }
            _loc2_ = this._fadeOutTimer / this._fadeOutTotal;
            if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
         }
         else if(this._fadeInTimer > 0)
         {
            this._fadeInTimer -= FlxG.elapsed;
            _loc2_ = this._fadeInTimer / this._fadeInTotal;
            if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
            _loc2_ = 1 - _loc2_;
         }
         this._volumeAdjust = _loc1_ * _loc2_;
         this.updateTransform();
         if(this._transform.volume > 0 && this._channel != null)
         {
            this.amplitudeLeft = this._channel.leftPeak / this._transform.volume;
            this.amplitudeRight = this._channel.rightPeak / this._transform.volume;
            this.amplitude = (this.amplitudeLeft + this.amplitudeRight) * 0.5;
         }
      }
      
      public function loadEmbedded(param1:Class, param2:Boolean = false) : FlxSound
      {
         this.stop();
         this.createSound();
         this._sound = new param1();
         this._looped = param2;
         this.updateTransform();
         exists = true;
         return this;
      }
      
      public function loadStream(param1:String, param2:Boolean = false) : FlxSound
      {
         this.stop();
         this.createSound();
         this._sound = new Sound();
         this._sound.addEventListener(Event.ID3,this.gotID3);
         this._sound.load(new URLRequest(param1));
         this._looped = param2;
         this.updateTransform();
         exists = true;
         return this;
      }
      
      public function proximity(param1:Number, param2:Number, param3:FlxObject, param4:Number, param5:Boolean = true) : FlxSound
      {
         this.x = param1;
         this.y = param2;
         this._target = param3;
         this._radius = param4;
         this._pan = param5;
         return this;
      }
      
      public function play() : void
      {
         if(this._position < 0)
         {
            return;
         }
         if(this._sound == null)
         {
            return;
         }
         if(this._looped)
         {
            if(this._position == 0)
            {
               if(this._channel == null)
               {
                  this._channel = this._sound.play(0,9999,this._transform);
               }
               if(this._channel == null)
               {
                  exists = false;
               }
            }
            else
            {
               this._channel = this._sound.play(this._position,0,this._transform);
               if(this._channel == null)
               {
                  exists = false;
               }
               else
               {
                  this._channel.addEventListener(Event.SOUND_COMPLETE,this.looped);
               }
            }
         }
         else if(this._position == 0)
         {
            if(this._channel == null)
            {
               this._channel = this._sound.play(0,0,this._transform);
               if(this._channel == null)
               {
                  exists = false;
               }
               else
               {
                  this._channel.addEventListener(Event.SOUND_COMPLETE,this.stopped);
               }
            }
         }
         else
         {
            this._channel = this._sound.play(this._position,0,this._transform);
            if(this._channel == null)
            {
               exists = false;
            }
         }
         active = this._channel != null;
         this._position = 0;
      }
      
      public function pause() : void
      {
         if(this._channel == null)
         {
            this._position = -1;
            return;
         }
         this._position = this._channel.position;
         this._channel.stop();
         if(this._looped)
         {
            while(this._position >= this._sound.length)
            {
               this._position -= this._sound.length;
            }
         }
         this._channel = null;
         active = false;
      }
      
      public function stop() : void
      {
         this._position = 0;
         if(this._channel != null)
         {
            this._channel.stop();
            this.stopped();
         }
      }
      
      public function fadeOut(param1:Number, param2:Boolean = false) : void
      {
         this._pauseOnFadeOut = param2;
         this._fadeInTimer = 0;
         this._fadeOutTimer = param1;
         this._fadeOutTotal = this._fadeOutTimer;
      }
      
      public function fadeIn(param1:Number) : void
      {
         this._fadeOutTimer = 0;
         this._fadeInTimer = param1;
         this._fadeInTotal = this._fadeInTimer;
         this.play();
      }
      
      public function get volume() : Number
      {
         return this._volume;
      }
      
      public function set volume(param1:Number) : void
      {
         this._volume = param1;
         if(this._volume < 0)
         {
            this._volume = 0;
         }
         else if(this._volume > 1)
         {
            this._volume = 1;
         }
         this.updateTransform();
      }
      
      public function getActualVolume() : Number
      {
         return this._volume * this._volumeAdjust;
      }
      
      internal function updateTransform() : void
      {
         this._transform.volume = (FlxG.mute ? 0 : 1) * FlxG.volume * this._volume * this._volumeAdjust;
         if(this._channel != null)
         {
            this._channel.soundTransform = this._transform;
         }
      }
      
      protected function looped(param1:Event = null) : void
      {
         if(this._channel == null)
         {
            return;
         }
         this._channel.removeEventListener(Event.SOUND_COMPLETE,this.looped);
         this._channel = null;
         this.play();
      }
      
      protected function stopped(param1:Event = null) : void
      {
         if(!this._looped)
         {
            this._channel.removeEventListener(Event.SOUND_COMPLETE,this.stopped);
         }
         else
         {
            this._channel.removeEventListener(Event.SOUND_COMPLETE,this.looped);
         }
         this._channel = null;
         exists = false;
         active = false;
      }
      
      protected function gotID3(param1:Event = null) : void
      {
         FlxG.log("got ID3 info!");
         if(this._sound.id3.songName.length > 0)
         {
            this.name = this._sound.id3.songName;
         }
         if(this._sound.id3.artist.length > 0)
         {
            this.artist = this._sound.id3.artist;
         }
         this._sound.removeEventListener(Event.ID3,this.gotID3);
      }
   }
}
