package uk.co.kempt.display
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class KeepUpright extends MovieClip
   {
       
      
      public function KeepUpright()
      {
         super();
         addEventListener(Event.ENTER_FRAME,this.onEnterFrameEvent,false,0,true);
      }
      
      private function onEnterFrameEvent(param1:Event) : void
      {
         var _loc2_:DisplayObject = parent;
         var _loc3_:Number = 0;
         while(_loc2_)
         {
            _loc3_ += _loc2_.rotation;
            _loc2_ = _loc2_.parent;
         }
         rotation = -_loc3_;
      }
   }
}
