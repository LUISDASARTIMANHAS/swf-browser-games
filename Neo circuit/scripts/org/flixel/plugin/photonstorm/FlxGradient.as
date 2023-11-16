package org.flixel.plugin.photonstorm
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.GradientType;
   import flash.display.InterpolationMethod;
   import flash.display.Shape;
   import flash.display.SpreadMethod;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import org.flixel.*;
   
   public class FlxGradient
   {
       
      
      public function FlxGradient()
      {
         super();
      }
      
      public static function createGradientMatrix(param1:int, param2:int, param3:Array, param4:int = 1, param5:int = 90) : Object
      {
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc6_:Matrix = new Matrix();
         var _loc7_:Number = FlxMath.asRadians(param5);
         if(param4 == 1)
         {
            _loc6_.createGradientBox(param1,param2,_loc7_,0,0);
         }
         else
         {
            _loc6_.createGradientBox(param1,param2 / param4,_loc7_,0,0);
         }
         var _loc8_:Array = new Array();
         var _loc9_:int = 0;
         while(_loc9_ < param3.length)
         {
            _loc8_.push(FlxColor.getAlphaFloat(param3[_loc9_]));
            _loc9_++;
         }
         var _loc10_:Array = new Array();
         if(param3.length == 2)
         {
            _loc10_[0] = 0;
            _loc10_[1] = 255;
         }
         else
         {
            _loc11_ = 255 / (param3.length - 1);
            _loc10_.push(0);
            _loc12_ = 1;
            while(_loc12_ < param3.length - 1)
            {
               _loc10_.push(_loc12_ * _loc11_);
               _loc12_++;
            }
            _loc10_.push(255);
         }
         return {
            "matrix":_loc6_,
            "alpha":_loc8_,
            "ratio":_loc10_
         };
      }
      
      public static function createGradientArray(param1:int, param2:int, param3:Array, param4:int = 1, param5:int = 90, param6:Boolean = true) : Array
      {
         var _loc7_:BitmapData = createGradientBitmapData(param1,param2,param3,param4,param5,param6);
         var _loc8_:Array = new Array();
         var _loc9_:int = 0;
         while(_loc9_ < _loc7_.height)
         {
            _loc8_.push(_loc7_.getPixel32(0,_loc9_));
            _loc9_++;
         }
         return _loc8_;
      }
      
      public static function createGradientFlxSprite(param1:int, param2:int, param3:Array, param4:int = 1, param5:int = 90, param6:Boolean = true) : FlxSprite
      {
         var _loc7_:BitmapData = createGradientBitmapData(param1,param2,param3,param4,param5,param6);
         var _loc8_:FlxSprite;
         (_loc8_ = new FlxSprite().makeGraphic(param1,param2)).pixels = _loc7_;
         return _loc8_;
      }
      
      public static function createGradientBitmapData(param1:int, param2:int, param3:Array, param4:int = 1, param5:int = 90, param6:Boolean = true) : BitmapData
      {
         var _loc10_:Bitmap = null;
         var _loc11_:Matrix = null;
         if(param1 < 1)
         {
            param1 = 1;
         }
         if(param2 < 1)
         {
            param2 = 1;
         }
         var _loc7_:Object = createGradientMatrix(param1,param2,param3,param4,param5);
         var _loc8_:Shape = new Shape();
         if(param6)
         {
            _loc8_.graphics.beginGradientFill(GradientType.LINEAR,param3,_loc7_.alpha,_loc7_.ratio,_loc7_.matrix,SpreadMethod.PAD,InterpolationMethod.RGB,0);
         }
         else
         {
            _loc8_.graphics.beginGradientFill(GradientType.LINEAR,param3,_loc7_.alpha,_loc7_.ratio,_loc7_.matrix,SpreadMethod.PAD,InterpolationMethod.LINEAR_RGB,0);
         }
         do
         {
            if(param4 == 1)
            {
               _loc8_.graphics.drawRect(0,0,param1,param2);
               break;
            }
            _loc8_.graphics.drawRect(0,0,param1,param2 / param4);
         }
         while(false);
         
         var _loc9_:BitmapData = new BitmapData(param1,param2,true,0);
         if(param4 == 1)
         {
            _loc9_.draw(_loc8_);
         }
         else
         {
            (_loc10_ = new Bitmap(new BitmapData(param1,param2 / param4,true,0))).bitmapData.draw(_loc8_);
            _loc10_.scaleY = param4;
            (_loc11_ = new Matrix()).scale(_loc10_.scaleX,_loc10_.scaleY);
            _loc9_.draw(_loc10_,_loc11_);
         }
         return _loc9_;
      }
      
      public static function overlayGradientOnFlxSprite(param1:FlxSprite, param2:int, param3:int, param4:Array, param5:int = 0, param6:int = 0, param7:int = 1, param8:int = 90, param9:Boolean = true) : FlxSprite
      {
         if(param2 > param1.width)
         {
            param2 = param1.width;
         }
         if(param3 > param1.height)
         {
            param3 = param1.height;
         }
         var _loc10_:FlxSprite = createGradientFlxSprite(param2,param3,param4,param7,param8,param9);
         param1.stamp(_loc10_,param5,param6);
         return param1;
      }
      
      public static function overlayGradientOnBitmapData(param1:BitmapData, param2:int, param3:int, param4:Array, param5:int = 0, param6:int = 0, param7:int = 1, param8:int = 90, param9:Boolean = true) : BitmapData
      {
         if(param2 > param1.width)
         {
            param2 = param1.width;
         }
         if(param3 > param1.height)
         {
            param3 = param1.height;
         }
         var _loc10_:BitmapData = createGradientBitmapData(param2,param3,param4,param7,param8,param9);
         param1.copyPixels(_loc10_,new Rectangle(0,0,_loc10_.width,_loc10_.height),new Point(param5,param6),null,null,true);
         return param1;
      }
   }
}
