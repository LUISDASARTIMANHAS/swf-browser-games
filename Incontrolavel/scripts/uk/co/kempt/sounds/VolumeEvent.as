package uk.co.kempt.sounds
{
   import flash.events.Event;
   
   public class VolumeEvent extends Event
   {
      
      public static const VOLUME_CHANGE:String = "volume_change";
       
      
      protected var _newVol:Number;
      
      protected var _oldVol:Number;
      
      public function VolumeEvent(param1:Number, param2:Number)
      {
         super(VOLUME_CHANGE);
         this._newVol = param1;
         this._oldVol = param2;
      }
      
      public function get newVol() : Number
      {
         return this._newVol;
      }
      
      public function get oldVol() : Number
      {
         return this._oldVol;
      }
   }
}
