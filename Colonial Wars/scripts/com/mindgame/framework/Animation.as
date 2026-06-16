package com.mindgame.framework
{
   import flash.display.*;
   import flash.geom.*;
   import flash.utils.*;
   
   public class Animation extends Bitmap
   {
       
      
      public var frames:Array;
      
      private var totalFrame:int = 0;
      
      private var pause:Boolean = false;
      
      public var currentFrame:int = 0;
      
      public var scaleXY:Number = 1;
      
      private var X:int = 0;
      
      private var Y:int = 0;
      
      public function Animation()
      {
         this.frames = [];
         super();
      }
      
      public function buildCacheFromLibrary(param1:String) : void
      {
         this.buildCacheFromClip(new (getDefinitionByName(param1))());
      }
      
      public function buildCacheFromClip(param1:MovieClip) : void
      {
         var _loc2_:Rectangle = null;
         var _loc3_:BitmapData = null;
         var _loc4_:Matrix = null;
         var _loc5_:int = 1;
         while(_loc5_ <= param1.totalFrames)
         {
            param1.gotoAndStop(_loc5_);
            _loc2_ = param1.getRect(param1);
            _loc3_ = new BitmapData(_loc2_.width * this.scaleXY,_loc2_.height * this.scaleXY,true,0);
            (_loc4_ = new Matrix()).translate(-_loc2_.x,-_loc2_.y);
            _loc4_.scale(this.scaleXY,this.scaleXY);
            _loc4_.rotate(param1.rotation);
            _loc3_.draw(param1,_loc4_);
            this.frames[this.frames.length] = _loc3_;
            _loc5_++;
         }
      }
      
      private function goto() : void
      {
         this.bitmapData = this.frames[this.currentFrame];
         this.smoothing = true;
         if(this.currentFrame + 1 >= this.totalFrames)
         {
            this.currentFrame = 0;
         }
         else
         {
            ++this.currentFrame;
         }
      }
      
      public function update() : void
      {
         if(!this.pause)
         {
            this.goto();
         }
      }
      
      public function pauseCheck() : void
      {
         if(this.pause)
         {
            this.pause = false;
         }
         else
         {
            this.pause = true;
         }
      }
      
      public function get totalFrames() : int
      {
         this.totalFrame = this.frames.length;
         return this.totalFrame;
      }
      
      public function remove() : void
      {
         trace("работаем");
         this.frames = [];
      }
   }
}
