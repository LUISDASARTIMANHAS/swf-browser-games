package com.mindgame.tweener.easing
{
   import com.mindgame.tweener.easing.equations.*;
   
   public final class Quint
   {
       
      
      public function Quint()
      {
         super();
      }
      
      public static function get easeIn() : IEasing
      {
         return new QuintEaseIn();
      }
      
      public static function get easeOut() : IEasing
      {
         return new QuintEaseOut();
      }
      
      public static function get easeInOut() : IEasing
      {
         return new QuintEaseInOut();
      }
   }
}
