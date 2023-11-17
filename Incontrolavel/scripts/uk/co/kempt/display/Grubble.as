package uk.co.kempt.display
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import flash.geom.Point;
   import uk.co.kempt.Engine;
   import uk.co.kempt.state.WorldObjectState;
   import uk.co.kempt.world.Building;
   
   [Embed(source="/_assets/assets.swf", symbol="uk.co.kempt.display.Grubble")]
   public class Grubble extends Sprite
   {
       
      
      private var _buildingMaskData:BitmapData;
      
      private var _mask:Bitmap;
      
      private var _maskData:BitmapData;
      
      private var _buildingMask:Bitmap;
      
      public function Grubble()
      {
         super();
         this._maskData = new BitmapData(Engine.GAME_WIDTH,Engine.GAME_HEIGHT,true,16711680);
         this._buildingMaskData = this._maskData.clone();
         this._mask = new Bitmap(this._maskData);
         this._buildingMask = new Bitmap(this._buildingMaskData);
         blendMode = BlendMode.LAYER;
         this._mask.blendMode = BlendMode.ALPHA;
         this._buildingMask.blendMode = BlendMode.ALPHA;
         addChild(this._mask);
         addChild(this._buildingMask);
         this.drawBuildingMask();
         filters = [new DropShadowFilter(2,90,0,1,1,1,1,1,true)];
      }
      
      public function die() : void
      {
         this._maskData.dispose();
      }
      
      public function draw(param1:Point, param2:Point) : void
      {
         if(!param1 || !param2)
         {
            return;
         }
         var _loc3_:Sprite = new Sprite();
         var _loc4_:Graphics;
         (_loc4_ = _loc3_.graphics).lineStyle(12);
         _loc4_.moveTo(param1.x,param1.y);
         _loc4_.lineTo(param2.x,param2.y);
         this._maskData.draw(_loc3_);
         _loc4_.clear();
      }
      
      public function invalidate() : void
      {
         this._buildingMaskData.fillRect(this._buildingMaskData.rect,0);
         this.drawBuildingMask();
      }
      
      private function drawBuildingMask() : void
      {
         var _loc3_:Building = null;
         var _loc1_:Array = Engine.getWorldObjects(Building);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc2_];
            if(_loc3_.state == WorldObjectState.ALIVE)
            {
               this._buildingMaskData.draw(_loc3_,_loc3_.transform.matrix);
            }
            _loc2_++;
         }
      }
   }
}
