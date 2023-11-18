package com.pavelzuk.components
{
   import flash.events.SampleDataEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.utils.ByteArray;
   
   public class MP3Pitch
   {
       
      
      private var _position:Number;
      
      private var _sound:Sound;
      
      private const BLOCK_SIZE:int = 3072;
      
      private var _skip_bytes_at_end:uint;
      
      private var mySoundTransform:SoundTransform;
      
      private var _skip_bytes_at_start:uint;
      
      private var _target:ByteArray;
      
      private var _mp3:Sound;
      
      private var soundChannel:SoundChannel;
      
      private var _rate:Number;
      
      public function MP3Pitch(param1:Class, param2:uint = 0, param3:uint = 0)
      {
         super();
         this.mySoundTransform = new SoundTransform();
         this.soundChannel = new SoundChannel();
         this._skip_bytes_at_start = param2;
         this._skip_bytes_at_end = param3;
         this._target = new ByteArray();
         this._mp3 = new param1() as Sound;
         this._position = 0;
         this._rate = 0;
         this._sound = new Sound();
         this._sound.addEventListener(SampleDataEvent.SAMPLE_DATA,this.sampleData);
         this.soundChannel = this._sound.play();
      }
      
      public function set rate(param1:Number) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         this._rate = param1;
      }
      
      public function setVolume(param1:Number) : void
      {
         this.mySoundTransform.volume = param1;
         this.soundChannel.soundTransform = this.mySoundTransform;
      }
      
      public function get rate() : Number
      {
         return this._rate;
      }
      
      public function destroy() : void
      {
         this.soundChannel.stop();
         this._sound = null;
         this._target.clear();
         this._target = null;
      }
      
      private function sampleData(param1:SampleDataEvent) : void
      {
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         this._target.position = 0;
         var _loc2_:ByteArray = param1.data;
         var _loc3_:Number = this.BLOCK_SIZE * this._rate;
         var _loc4_:int = this._position;
         var _loc5_:Number;
         var _loc6_:Number = _loc5_ = this._position - _loc4_;
         var _loc7_:int = -1;
         var _loc8_:int = Math.ceil(_loc3_) + 2;
         var _loc9_:int;
         var _loc10_:int = (_loc9_ = int(this._mp3.extract(this._target,_loc8_,_loc4_))) == _loc8_ ? this.BLOCK_SIZE : int(_loc9_ / this._rate);
         var _loc15_:int = 0;
         while(_loc15_ < _loc10_)
         {
            if(int(_loc6_) != _loc7_)
            {
               _loc7_ = _loc6_;
               this._target.position = _loc7_ << 3;
               _loc11_ = Number(this._target.readFloat());
               _loc12_ = Number(this._target.readFloat());
               _loc13_ = Number(this._target.readFloat());
               _loc14_ = Number(this._target.readFloat());
            }
            _loc2_.writeFloat(_loc11_ + _loc5_ * (_loc13_ - _loc11_));
            _loc2_.writeFloat(_loc12_ + _loc5_ * (_loc14_ - _loc12_));
            _loc6_ += this._rate;
            if(this._position > this._mp3.bytesTotal - this._skip_bytes_at_end)
            {
               this._position = this._skip_bytes_at_start;
            }
            _loc5_ += this._rate;
            while(_loc5_ >= 1)
            {
               _loc5_--;
            }
            _loc15_++;
         }
         if(_loc15_ < this.BLOCK_SIZE)
         {
            while(_loc15_ < this.BLOCK_SIZE)
            {
               _loc2_.writeFloat(0);
               _loc2_.writeFloat(0);
               _loc15_++;
            }
         }
         this._position += _loc3_;
      }
   }
}
