package org.flixel.system
{
   import org.flixel.FlxG;
   import org.flixel.system.replay.FrameRecord;
   import org.flixel.system.replay.MouseRecord;
   
   public class FlxReplay
   {
       
      
      public var seed:Number;
      
      public var frame:int;
      
      public var frameCount:int;
      
      public var finished:Boolean;
      
      protected var _frames:Array;
      
      protected var _capacity:int;
      
      protected var _marker:int;
      
      public function FlxReplay()
      {
         super();
         this.seed = 0;
         this.frame = 0;
         this.frameCount = 0;
         this.finished = false;
         this._frames = null;
         this._capacity = 0;
         this._marker = 0;
      }
      
      public function destroy() : void
      {
         if(this._frames == null)
         {
            return;
         }
         var _loc1_:int = this.frameCount - 1;
         while(_loc1_ >= 0)
         {
            (this._frames[_loc1_--] as FrameRecord).destroy();
         }
         this._frames = null;
      }
      
      public function create(param1:Number) : void
      {
         this.destroy();
         this.init();
         this.seed = param1;
         this.rewind();
      }
      
      public function load(param1:String) : void
      {
         var _loc3_:String = null;
         this.init();
         var _loc2_:Array = param1.split("\n");
         this.seed = Number(_loc2_[0]);
         var _loc4_:uint = 1;
         var _loc5_:uint = _loc2_.length;
         while(_loc4_ < _loc5_)
         {
            _loc3_ = _loc2_[_loc4_++] as String;
            if(_loc3_.length > 3)
            {
               var _loc6_:*;
               this._frames[_loc6_ = this.frameCount++] = new FrameRecord().load(_loc3_);
               if(this.frameCount >= this._capacity)
               {
                  this._capacity *= 2;
                  this._frames.length = this._capacity;
               }
            }
         }
         this.rewind();
      }
      
      protected function init() : void
      {
         this._capacity = 100;
         this._frames = new Array(this._capacity);
         this.frameCount = 0;
      }
      
      public function save() : String
      {
         if(this.frameCount <= 0)
         {
            return null;
         }
         var _loc1_:* = this.seed + "\n";
         var _loc2_:uint = 0;
         while(_loc2_ < this.frameCount)
         {
            _loc1_ += this._frames[_loc2_++].save() + "\n";
         }
         return _loc1_;
      }
      
      public function recordFrame() : void
      {
         var _loc1_:Array = FlxG.keys.record();
         var _loc2_:MouseRecord = FlxG.mouse.record();
         if(_loc1_ == null && _loc2_ == null)
         {
            ++this.frame;
            return;
         }
         var _loc3_:* = this.frameCount++;
         this._frames[_loc3_] = new FrameRecord().create(this.frame++,_loc1_,_loc2_);
         if(this.frameCount >= this._capacity)
         {
            this._capacity *= 2;
            this._frames.length = this._capacity;
         }
      }
      
      public function playNextFrame() : void
      {
         FlxG.resetInput();
         if(this._marker >= this.frameCount)
         {
            this.finished = true;
            return;
         }
         if((this._frames[this._marker] as FrameRecord).frame != this.frame++)
         {
            return;
         }
         var _loc1_:FrameRecord = this._frames[this._marker++];
         if(_loc1_.keys != null)
         {
            FlxG.keys.playback(_loc1_.keys);
         }
         if(_loc1_.mouse != null)
         {
            FlxG.mouse.playback(_loc1_.mouse);
         }
      }
      
      public function rewind() : void
      {
         this._marker = 0;
         this.frame = 0;
         this.finished = false;
      }
   }
}
