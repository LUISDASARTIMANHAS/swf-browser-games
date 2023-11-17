package uk.co.kempt.display
{
   import fl.transitions.Tween;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.filters.BlurFilter;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.DropShadowFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import uk.co.kempt.Engine;
   import uk.co.kempt.utils.GarbageUtil;
   import uk.co.kempt.world.DangerousBuilding;
   
   public class LevelDangerSnapshot extends Sprite
   {
      
      private static const DESATURATE_MATRIX:Array = [0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0];
       
      
      private var _alphaTween:Tween;
      
      private var _bitmap:Bitmap;
      
      private var _highlight:Boolean;
      
      private var _desaturate:Boolean;
      
      public function LevelDangerSnapshot(param1:Boolean = true, param2:Boolean = true)
      {
         var _loc3_:Number = NaN;
         super();
         this._desaturate = param1;
         this._highlight = param2;
         mouseChildren = false;
         this._bitmap = new Bitmap(new BitmapData(Engine.GAME_WIDTH,Engine.GAME_HEIGHT,false,0));
         this.bitmapData.draw(Engine.instance.display,Engine.instance.display.transform.matrix);
         if(param1)
         {
            this.bitmapData.applyFilter(this.bitmapData,this.bitmapData.rect,new Point(),new ColorMatrixFilter(DESATURATE_MATRIX));
         }
         if(param2)
         {
            _loc3_ = 1.3;
            this.bitmapData.applyFilter(this.bitmapData,this.bitmapData.rect,new Point(),new BlurFilter(_loc3_,_loc3_,1));
         }
         this.drawDangerousBuildings();
         this.drawGreenGoodies();
         addChild(this.bitmap);
         this._alphaTween = new Tween(this,"alpha",null,1,1,1);
         this._alphaTween.stop();
      }
      
      public function die() : void
      {
         if(this.bitmapData)
         {
            this.bitmapData.dispose();
         }
         if(this._bitmap)
         {
            this._bitmap.bitmapData = null;
            this._bitmap = null;
         }
         GarbageUtil.kill(this);
      }
      
      private function drawDangerousBuildings() : void
      {
         var _loc3_:DangerousBuilding = null;
         var _loc4_:Array = null;
         var _loc5_:ColorTransform = null;
         var _loc1_:Array = Engine.getWorldObjects(DangerousBuilding);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc2_];
            _loc4_ = _loc3_.filters;
            if(this._highlight)
            {
               _loc3_.filters = [new DropShadowFilter(1,90,0,1,8,8,1,2)];
               _loc5_ = new ColorTransform(1,1,1,1,60);
            }
            else if(this._desaturate)
            {
               _loc3_.filters = [new ColorMatrixFilter(DESATURATE_MATRIX)];
            }
            this.bitmapData.draw(_loc3_,_loc3_.transform.matrix,_loc5_);
            _loc3_.filters = _loc4_;
            _loc2_++;
         }
      }
      
      protected function get bitmap() : Bitmap
      {
         return this._bitmap;
      }
      
      public function fadeOut() : void
      {
         this._alphaTween.continueTo(0,Engine.GAME_FRAMERATE * 2);
      }
      
      protected function get bitmapData() : BitmapData
      {
         return !!this._bitmap ? this._bitmap.bitmapData : null;
      }
      
      private function drawGreenGoodies() : void
      {
         if(this._highlight)
         {
            this.drawDisplayObject(Engine.instance.brush);
            this.drawDisplayObject(Engine.instance.currentLevel.exit);
         }
      }
      
      private function drawDisplayObject(param1:DisplayObject) : void
      {
         var _loc2_:Array = param1.filters;
         param1.filters = [new DropShadowFilter(1,90,0,1,8,8,1,2)];
         this.bitmapData.draw(param1,param1.transform.matrix);
         param1.filters = _loc2_;
      }
   }
}
