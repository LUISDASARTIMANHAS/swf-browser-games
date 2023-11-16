package org.flixel.plugin.photonstorm
{
   import org.flixel.FlxPoint;
   import org.flixel.FlxSprite;
   
   public class FlxExtendedSprite extends FlxSprite
   {
       
      
      public function FlxExtendedSprite(param1:Number = 0, param2:Number = 0, param3:Class = null)
      {
         super(param1,param2,param3);
      }
      
      public function get point() : FlxPoint
      {
         return _point;
      }
      
      public function set point(param1:FlxPoint) : void
      {
         _point = param1;
      }
   }
}
