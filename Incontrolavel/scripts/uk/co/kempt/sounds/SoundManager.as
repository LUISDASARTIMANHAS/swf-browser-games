package uk.co.kempt.sounds
{
   import flash.events.*;
   import flash.media.*;
   import flash.net.*;
   import flash.utils.*;
   
   public class SoundManager extends EventDispatcher
   {
      
      public static var DIE:String = "die";
      
      public static var STOP:String = "stop";
      
      public static var PAUSE:String = "pause";
      
      public static var UNPAUSE:String = "unpause";
       
      
      protected var _isMuted:Boolean = false;
      
      protected var _vol:Number = 1;
      
      public function SoundManager()
      {
         super();
      }
      
      public function die() : void
      {
         dispatchEvent(new Event(DIE));
      }
      
      public function playSound(param1:Object, param2:Number = 1, param3:int = 1) : Snd
      {
         var _loc4_:Snd;
         (_loc4_ = this.newSound(param1)).volume = param2;
         _loc4_.play(0,param3);
         return _loc4_;
      }
      
      public function loopSound(param1:Object, param2:Number = 1) : Snd
      {
         var _loc3_:Snd = this.newSound(param1);
         _loc3_.volume = param2;
         _loc3_.doLoop();
         return _loc3_;
      }
      
      public function newSound(param1:Object) : Snd
      {
         var snd:Sound = null;
         var pSndRef:Object = param1;
         if(pSndRef is Array)
         {
            pSndRef = pSndRef[Math.floor(pSndRef.length * Math.random())];
         }
         if(pSndRef is Class)
         {
            snd = new (pSndRef as Class)();
         }
         else
         {
            if(!(pSndRef is String))
            {
               throw new Error("unknown sound: " + pSndRef);
            }
            try
            {
               snd = new (getDefinitionByName(String(pSndRef)) as Class)();
            }
            catch(e:Error)
            {
               snd = new Sound(new URLRequest(String(pSndRef)));
            }
         }
         return new Snd(this,snd);
      }
      
      public function set mute(param1:Boolean) : void
      {
         if(param1 != this._isMuted)
         {
            if(param1)
            {
               this._isMuted = true;
            }
            else
            {
               this._isMuted = false;
            }
            dispatchEvent(new MuteEvent(param1));
         }
      }
      
      public function pause() : void
      {
         dispatchEvent(new Event(PAUSE));
      }
      
      public function get mute() : Boolean
      {
         return this._isMuted;
      }
      
      public function get volume() : Number
      {
         return this._vol;
      }
      
      public function set volume(param1:Number) : void
      {
         var _loc2_:Number = this._vol;
         this._vol = param1;
         if(!this._isMuted)
         {
            dispatchEvent(new VolumeEvent(this._vol,_loc2_));
         }
      }
      
      public function unpause() : void
      {
         dispatchEvent(new Event(UNPAUSE));
      }
      
      public function stopAll() : void
      {
         dispatchEvent(new Event(STOP));
      }
   }
}
