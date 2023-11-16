package org.flixel.system.replay
{
   public class FrameRecord
   {
       
      
      public var frame:int;
      
      public var keys:Array;
      
      public var mouse:MouseRecord;
      
      public function FrameRecord()
      {
         super();
         this.frame = 0;
         this.keys = null;
         this.mouse = null;
      }
      
      public function create(param1:Number, param2:Array = null, param3:MouseRecord = null) : FrameRecord
      {
         this.frame = param1;
         this.keys = param2;
         this.mouse = param3;
         return this;
      }
      
      public function destroy() : void
      {
         this.keys = null;
         this.mouse = null;
      }
      
      public function save() : String
      {
         var _loc2_:Object = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc1_:* = this.frame + "keyPair";
         if(this.keys != null)
         {
            _loc3_ = 0;
            while(true)
            {
               _loc4_ = uint(this.keys.length);
               while(true)
               {
                  if(_loc3_ < _loc4_)
                  {
                     if(_loc3_ > 0)
                     {
                        _loc1_ += ",";
                        if(false)
                        {
                           break;
                        }
                     }
                     continue;
                  }
               }
            }
         }
         _loc1_ += "m";
         if(this.mouse != null)
         {
            _loc1_ += this.mouse.x + "," + this.mouse.y + "," + this.mouse.button + "," + this.mouse.wheel;
         }
         return _loc1_;
      }
      
      public function load(param1:String) : FrameRecord
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:Array = null;
         var _loc4_:Array = param1.split("k");
         this.frame = int(_loc4_[0] as String);
         var _loc5_:String = String((_loc4_ = (_loc4_[1] as String).split("m"))[0]);
         var _loc6_:String = String(_loc4_[1]);
         if(_loc5_.length > 0)
         {
            _loc4_ = _loc5_.split(",");
            _loc2_ = 0;
            _loc3_ = uint(_loc4_.length);
            while(_loc2_ < _loc3_)
            {
               if((_loc7_ = (_loc4_[_loc2_++] as String).split(":")).length == 2)
               {
                  if(this.keys == null)
                  {
                     this.keys = new Array();
                  }
                  this.keys.push({
                     "code":int(_loc7_[0] as String),
                     "value":int(_loc7_[1] as String)
                  });
               }
            }
         }
         if(_loc6_.length > 0)
         {
            if((_loc4_ = _loc6_.split(",")).length >= 4)
            {
               this.mouse = new MouseRecord(int(_loc4_[0] as String),int(_loc4_[1] as String),int(_loc4_[2] as String),int(_loc4_[3] as String));
            }
         }
         return this;
      }
   }
}
