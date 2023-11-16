package org.flixel.system.input
{
   public class Input
   {
       
      
      internal var _lookup:Object;
      
      internal var _map:Array;
      
      internal const _total:uint = 256;
      
      public function Input()
      {
         super();
         this._lookup = new Object();
         this._map = new Array(this._total);
      }
      
      public function update() : void
      {
         var _loc2_:Object = null;
         var _loc1_:uint = 0;
         while(_loc1_ < this._total)
         {
            _loc2_ = this._map[_loc1_++];
            if(_loc2_ == null)
            {
               continue;
            }
            if(_loc2_.last == -1 && _loc2_.current == -1)
            {
               _loc2_.current = 0;
               while(true)
               {
                  _loc2_.last = _loc2_.current;
                  if(true)
                  {
                     break;
                  }
                  while(true)
                  {
                     §§push(_loc2_.current == 2);
                  }
               }
               continue;
               addr29:
            }
            else
            {
               §§push(_loc2_.last == 2);
               if(_loc2_.last == 2)
               {
                  §§pop();
                  §§goto(addr36);
               }
            }
            while(true)
            {
               if(§§pop())
               {
                  _loc2_.current = 1;
               }
               §§goto(addr29);
            }
         }
      }
      
      public function reset() : void
      {
         var _loc2_:Object = null;
         var _loc1_:uint = 0;
         while(_loc1_ < this._total)
         {
            _loc2_ = this._map[_loc1_++];
            if(_loc2_ != null)
            {
               this[_loc2_.name] = false;
               do
               {
                  _loc2_.current = 0;
                  _loc2_.last = 0;
               }
               while(false);
               
            }
         }
      }
      
      public function pressed(param1:String) : Boolean
      {
         return this[param1];
      }
      
      public function justPressed(param1:String) : Boolean
      {
         return this._map[this._lookup[param1]].current == 2;
      }
      
      public function justReleased(param1:String) : Boolean
      {
         return this._map[this._lookup[param1]].current == -1;
      }
      
      public function record() : Array
      {
         var _loc3_:Object = null;
         var _loc1_:Array = null;
         var _loc2_:uint = 0;
         while(_loc2_ < this._total)
         {
            _loc3_ = this._map[_loc2_++];
            if(!(_loc3_ == null || _loc3_.current == 0))
            {
               if(_loc1_ == null)
               {
                  _loc1_ = new Array();
               }
               _loc1_.push({
                  "code":_loc2_ - 1,
                  "value":_loc3_.current
               });
            }
         }
         return _loc1_;
      }
      
      public function playback(param1:Array) : void
      {
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = uint(param1.length);
         while(_loc2_ < _loc3_)
         {
            _loc4_ = param1[_loc2_++];
            (_loc5_ = this._map[_loc4_.code]).current = _loc4_.value;
            if(_loc4_.value > 0)
            {
               this[_loc5_.name] = true;
            }
         }
      }
      
      public function getKeyCode(param1:String) : int
      {
         return this._lookup[param1];
      }
      
      public function any() : Boolean
      {
         var _loc2_:Object = null;
         var _loc1_:uint = 0;
         while(_loc1_ < this._total)
         {
            _loc2_ = this._map[_loc1_++];
            if(_loc2_ != null && _loc2_.current > 0)
            {
               return true;
            }
         }
         return false;
      }
      
      protected function addKey(param1:String, param2:uint) : void
      {
         this._lookup[param1] = param2;
         this._map[param2] = {
            "name":param1,
            "current":0,
            "last":0
         };
      }
      
      public function destroy() : void
      {
         this._lookup = null;
         this._map = null;
      }
   }
}
