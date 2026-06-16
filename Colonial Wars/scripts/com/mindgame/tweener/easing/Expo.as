package com.mindgame.tweener.easing
{
   import com.mindgame.tweener.easing.equations.*;
   
   public final class Expo
   {
       
      
      public function Expo()
      {
         super();
      }
      
      public static function get easeIn() : IEasing
      {
         return new ExpoEaseIn();
      }
      
      public static function get easeOut() : IEasing
      {
         return new ExpoEaseOut();
      }
      
      public static function get easeInOut() : IEasing
      {
         return new ExpoEaseInOut();
      }
   }
}
