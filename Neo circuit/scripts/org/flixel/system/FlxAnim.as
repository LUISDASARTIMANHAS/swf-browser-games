package org.flixel.system
{
   public class FlxAnim
   {
       
      
      public var name:String;
      
      public var delay:Number;
      
      public var frames:Array;
      
      public var looped:Boolean;
      
      public function FlxAnim(param1:String, param2:Array, param3:Number = 0, param4:Boolean = true)
      {
         super();
         this.name = param1;
         this.delay = 0;
         if(param3 > 0)
         {
            this.delay = 1 / param3;
         }
         this.frames = param2;
         this.looped = param4;
      }
      
      public function destroy() : void
      {
         this.frames = null;
      }
   }
}
