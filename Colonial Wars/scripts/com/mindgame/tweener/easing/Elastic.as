package com.mindgame.tweener.easing
{
   import com.mindgame.tweener.easing.equations.*;
   
   public final class Elastic
   {
       
      
      public function Elastic()
      {
         super();
      }
      
      public static function get easeIn() : IEasing
      {
         return new ElasticEaseIn(0.1,0.4);
      }
      
      public static function get easeOut() : IEasing
      {
         return new ElasticEaseOut(0.1,0.4);
      }
      
      public static function get easeInOut() : IEasing
      {
         return new ElasticEaseInOut(0.1,0.4);
      }
      
      public static function easeInWith(param1:Number, param2:Number) : IEasing
      {
         return new ElasticEaseIn(param1,param2);
      }
      
      public static function easeOutWith(param1:Number, param2:Number) : IEasing
      {
         return new ElasticEaseOut(param1,param2);
      }
      
      public static function easeInOutWith(param1:Number, param2:Number) : IEasing
      {
         return new ElasticEaseInOut(param1,param2);
      }
   }
}
