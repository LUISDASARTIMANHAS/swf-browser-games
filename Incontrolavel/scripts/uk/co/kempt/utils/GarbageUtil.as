package uk.co.kempt.utils
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   
   public class GarbageUtil
   {
       
      
      public function GarbageUtil()
      {
         super();
      }
      
      public static function kill(param1:DisplayObject) : void
      {
         var _loc2_:DisplayObjectContainer = null;
         var _loc3_:int = 0;
         if(param1)
         {
            if(param1 is DisplayObjectContainer)
            {
               _loc2_ = param1 as DisplayObjectContainer;
               _loc3_ = _loc2_.numChildren - 1;
               while(_loc3_ > -1)
               {
                  kill(_loc2_.getChildAt(_loc3_));
                  _loc3_--;
               }
               if(_loc2_ is MovieClip)
               {
                  MovieClip(_loc2_).stop();
               }
            }
            if(param1.parent)
            {
               param1.parent.removeChild(param1);
            }
         }
      }
   }
}
