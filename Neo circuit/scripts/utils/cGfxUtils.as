package utils
{
   import flash.display.BitmapData;
   import flash.display.GradientType;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   
   public class cGfxUtils
   {
      
      protected static var _gfxSprite:Sprite = new Sprite();
      
      protected static var _gfx:Graphics = _gfxSprite.graphics;
      
      protected static var _matrix:Matrix = new Matrix();
       
      
      public function cGfxUtils()
      {
         super();
      }
      
      public static function drawLine(param1:BitmapData, param2:Number, param3:Number, param4:Number, param5:Number, param6:uint, param7:uint = 1, param8:Number = 1) : void
      {
         _gfx.clear();
         _gfx.moveTo(param2,param3);
         _gfx.lineStyle(param7,param6,param8);
         _gfx.lineTo(param4,param5);
         param1.draw(_gfxSprite);
      }
      
      public static function drawCircle(param1:BitmapData, param2:Number, param3:Number, param4:int, param5:int, param6:Number, param7:Boolean = true, param8:int = 2) : void
      {
         _gfx.clear();
         if(param7)
         {
            _gfx.beginFill(param5,param6);
         }
         else
         {
            _gfx.lineStyle(param8,param5,param6);
         }
         _gfx.drawCircle(param2,param3,param4);
         if(param7)
         {
            _gfx.endFill();
         }
         param1.draw(_gfxSprite);
      }
      
      public static function drawRectangle(param1:BitmapData, param2:Number, param3:Number, param4:Number, param5:Number, param6:int, param7:Number, param8:Boolean = true, param9:int = 2) : void
      {
         _gfx.clear();
         if(param8)
         {
            _gfx.beginFill(param6,param7);
         }
         else
         {
            _gfx.lineStyle(param9,param6,param7);
         }
         _gfx.drawRect(param2,param3,param4,param5);
         if(param8)
         {
            _gfx.endFill();
         }
         param1.draw(_gfxSprite);
      }
      
      public static function drawGradientLine(param1:BitmapData, param2:Number, param3:Number, param4:Number, param5:Number, param6:Array, param7:uint = 1, param8:Number = 1) : void
      {
         var _loc9_:Number = Number(Math.abs(param4 - param2));
         var _loc10_:Number = Number(Math.abs(param5 - param3));
         var _loc11_:Number = Number(Math.atan2(_loc10_,_loc9_));
         var _loc12_:Number = param2;
         var _loc13_:Number = param3;
         if(param2 > param4)
         {
            _loc12_ = param4;
         }
         if(param3 > param5)
         {
            _loc13_ = param5;
         }
         _matrix.createGradientBox(_loc9_,_loc10_,-_loc11_,_loc12_,_loc13_);
         _gfx.clear();
         _gfx.lineStyle(param7);
         _gfx.lineGradientStyle(GradientType.LINEAR,param6,[1,1],[0,255],_matrix);
         _gfx.moveTo(param2,param3);
         _gfx.lineTo(param4,param5);
         param1.draw(_gfxSprite);
      }
   }
}
