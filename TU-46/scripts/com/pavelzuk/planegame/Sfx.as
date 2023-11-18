package com.pavelzuk.planegame
{
   import flash.events.Event;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.utils.getDefinitionByName;
   
   public class Sfx
   {
       
      
      private var _channel:SoundChannel;
      
      private var _position:Number = 0;
      
      private var _vol:Number = 1;
      
      private var _sound:Sound;
      
      private var _pan:Number = 0;
      
      public var complete:Function;
      
      private var _transform:SoundTransform;
      
      private var _looping:Boolean;
      
      public function Sfx(param1:String, param2:Function = null)
      {
         this._transform = new SoundTransform();
         super();
         var _loc3_:Class = getDefinitionByName(param1) as Class;
         this._sound = new _loc3_();
         this.complete = param2;
      }
      
      public function set pan(param1:Number) : void
      {
         if(param1 < -1)
         {
            param1 = -1;
         }
         if(param1 > 1)
         {
            param1 = 1;
         }
         if(!this._channel || this._pan == param1)
         {
            return;
         }
         this._pan = this._transform.pan = param1;
         this._channel.soundTransform = this._transform;
      }
      
      public function stop() : Boolean
      {
         if(!this._channel)
         {
            return false;
         }
         this._position = this._channel.position;
         this._channel.removeEventListener(Event.SOUND_COMPLETE,this.onComplete);
         this._channel.stop();
         this._channel = null;
         return true;
      }
      
      public function get sound() : Sound
      {
         return this._sound;
      }
      
      public function get volume() : Number
      {
         return this._vol;
      }
      
      public function get pan() : Number
      {
         return this._pan;
      }
      
      public function loop(param1:Number = 1, param2:Number = 0) : void
      {
         this._looping = true;
         this.play(param1,param2);
         trace("Sound Looping");
      }
      
      public function get length() : Number
      {
         return this._sound.length / 1000;
      }
      
      public function get position() : Number
      {
         return (!!this._channel ? this._channel.position : this._position) / 1000;
      }
      
      public function resume() : void
      {
         this._channel = this._sound.play(this._position,0,this._transform);
         this._channel.addEventListener(Event.SOUND_COMPLETE,this.onComplete);
         this._position = 0;
      }
      
      public function get playing() : Boolean
      {
         return this._channel != null;
      }
      
      public function set volume(param1:Number) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(!this._channel || this._vol == param1)
         {
            return;
         }
         this._vol = this._transform.volume = param1;
         this._channel.soundTransform = this._transform;
      }
      
      private function onComplete(param1:Event = null) : void
      {
         this.stop();
         this._position = 0;
         if(this.complete != null)
         {
            this.complete();
         }
      }
      
      public function destroy() : void
      {
      }
      
      public function play(param1:Number = 1, param2:Number = 0) : void
      {
         if(Boolean(this._channel) || GameController.mute)
         {
            this.stop();
         }
         this._vol = this._transform.volume = param1 < 0 ? 0 : param1;
         this._pan = this._transform.pan = param2 < -1 ? -1 : (param2 > 1 ? 1 : param2);
         this._channel = this._sound.play(0,this._looping ? int(int.MAX_VALUE) : 0,this._transform);
         this._channel.addEventListener(Event.SOUND_COMPLETE,this.onComplete);
         this._looping = false;
         this._position = 0;
      }
   }
}
