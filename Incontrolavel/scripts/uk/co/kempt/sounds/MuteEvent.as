package uk.co.kempt.sounds
{
   import flash.events.Event;
   
   public class MuteEvent extends Event
   {
      
      public static var MUTED:String = "muted";
       
      
      protected var _isMuted:Boolean;
      
      public function MuteEvent(param1:Boolean)
      {
         super(MUTED);
         this._isMuted = param1;
      }
      
      public function get isMuted() : Boolean
      {
         return this._isMuted;
      }
   }
}
