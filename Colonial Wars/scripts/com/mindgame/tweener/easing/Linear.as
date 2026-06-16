package com.mindgame.tweener.easing
{
   import com.mindgame.tweener.easing.equations.*;
   
   public final class Linear
   {
       
      
      public function Linear()
      {
         super();
      }
      
      public static function get easeNone() : IEasing
      {
         return new LinearEaseNone();
      }
   }
}
