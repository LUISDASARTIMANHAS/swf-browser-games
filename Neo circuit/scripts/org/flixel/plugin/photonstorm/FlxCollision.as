package org.flixel.plugin.photonstorm
{
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import org.flixel.FlxSprite;
   
   public class FlxCollision
   {
      
      public static var debug:BitmapData = new BitmapData(1,1,false);
      
      private static var colorTrans1:ColorTransform = new ColorTransform(1,1,1,1,255,-255,-255,255);
      
      private static var colorTrans2:ColorTransform = new ColorTransform(1,1,1,1,255,255,255,255);
      
      private static var boundsA:Rectangle = new Rectangle();
      
      private static var boundsB:Rectangle = new Rectangle();
      
      private static var matrixA:Matrix = new Matrix();
      
      private static var matrixB:Matrix = new Matrix();
       
      
      public function FlxCollision()
      {
         super();
      }
      
      public static function pixelPerfectCheck(param1:FlxSprite, param2:FlxSprite) : Boolean
      {
         boundsA.x = param1.x;
         boundsA.y = param1.y;
         boundsA.width = param1.width;
         boundsA.height = param1.height;
         boundsB.x = param2.x;
         boundsB.y = param2.y;
         do
         {
            boundsB.width = param2.width;
            boundsB.height = param2.height;
         }
         while(false);
         
         var _loc3_:Rectangle = boundsA.intersection(boundsB);
         if(_loc3_.isEmpty() || _loc3_.width == 0 || _loc3_.height == 0)
         {
            return false;
         }
         _loc3_.x = Math.floor(_loc3_.x);
         _loc3_.y = Math.floor(_loc3_.y);
         _loc3_.width = Math.ceil(_loc3_.width);
         _loc3_.height = Math.ceil(_loc3_.height);
         if(_loc3_.isEmpty())
         {
            return false;
         }
         matrixA.tx = -(_loc3_.x - boundsA.x + param1.offset.x);
         matrixA.ty = -(_loc3_.y - boundsA.y + param1.offset.y);
         do
         {
            matrixB.tx = -(_loc3_.x - boundsB.x + param2.offset.x);
            matrixB.ty = -(_loc3_.y - boundsB.y + param2.offset.y);
         }
         while(false);
         
         var _loc4_:BitmapData = param1.framePixels;
         var _loc5_:BitmapData = param2.framePixels;
         var _loc6_:BitmapData;
         (_loc6_ = new BitmapData(_loc3_.width,_loc3_.height,false)).draw(_loc4_,matrixA,colorTrans1,BlendMode.NORMAL);
         _loc6_.draw(_loc5_,matrixB,colorTrans2,BlendMode.DIFFERENCE);
         var _loc7_:Rectangle = _loc6_.getColorBoundsRect(4294967295,4278255615);
         _loc6_.dispose();
         return !_loc7_.isEmpty();
      }
   }
}
