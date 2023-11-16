package org.flixel
{
   public class FlxGroup extends FlxBasic
   {
      
      public static const ASCENDING:int = -1;
      
      public static const DESCENDING:int = 1;
       
      
      public var members:Array;
      
      public var length:Number;
      
      protected var _maxSize:uint;
      
      protected var _marker:uint;
      
      protected var _sortIndex:String;
      
      protected var _sortOrder:int;
      
      public function FlxGroup(param1:uint = 0)
      {
         super();
         this.members = new Array();
         this.length = 0;
         this._maxSize = param1;
         this._marker = 0;
         this._sortIndex = null;
      }
      
      override public function destroy() : void
      {
         var _loc1_:FlxBasic = null;
         var _loc2_:uint = 0;
         if(this.members != null)
         {
            _loc2_ = 0;
            while(_loc2_ < this.length)
            {
               _loc1_ = this.members[_loc2_++] as FlxBasic;
               if(_loc1_ != null)
               {
                  _loc1_.destroy();
               }
            }
            this.members.length = 0;
            this.members = null;
         }
         this._sortIndex = null;
      }
      
      override public function preUpdate() : void
      {
      }
      
      override public function update() : void
      {
         var _loc1_:FlxBasic = null;
         var _loc2_:uint = 0;
         while(_loc2_ < this.length)
         {
            _loc1_ = this.members[_loc2_++] as FlxBasic;
            if(_loc1_ != null && _loc1_.exists && _loc1_.active)
            {
               _loc1_.preUpdate();
               do
               {
                  _loc1_.update();
                  _loc1_.postUpdate();
               }
               while(false);
               
            }
         }
      }
      
      override public function draw() : void
      {
         var _loc1_:FlxBasic = null;
         var _loc2_:uint = 0;
         while(_loc2_ < this.length)
         {
            _loc1_ = this.members[_loc2_++] as FlxBasic;
            §§push(_loc1_ != null);
            if(_loc1_ != null)
            {
               §§pop();
               while(true)
               {
                  §§push(_loc1_.exists);
               }
               addr48:
            }
            while(§§pop() && _loc1_.visible)
            {
               _loc1_.draw();
               if(true)
               {
                  break;
               }
               §§goto(addr48);
            }
         }
      }
      
      public function get maxSize() : uint
      {
         return this._maxSize;
      }
      
      public function set maxSize(param1:uint) : void
      {
         var _loc2_:FlxBasic = null;
         this._maxSize = param1;
         if(this._marker >= this._maxSize)
         {
            this._marker = 0;
         }
         if(this._maxSize == 0 || this.members == null || this._maxSize >= this.members.length)
         {
            return;
         }
         var _loc3_:uint = this._maxSize;
         var _loc4_:uint = this.members.length;
         while(_loc3_ < _loc4_)
         {
            _loc2_ = this.members[_loc3_++] as FlxBasic;
            if(_loc2_ != null)
            {
               _loc2_.destroy();
            }
         }
         this.length = this.members.length = this._maxSize;
      }
      
      public function add(param1:FlxBasic) : FlxBasic
      {
         if(this.members.indexOf(param1) >= 0)
         {
            return param1;
         }
         var _loc2_:uint = 0;
         var _loc3_:uint = this.members.length;
         while(_loc2_ < _loc3_)
         {
            if(this.members[_loc2_] == null)
            {
               this.members[_loc2_] = param1;
               if(_loc2_ >= this.length)
               {
                  this.length = _loc2_ + 1;
               }
               return param1;
            }
            _loc2_++;
         }
         if(this._maxSize > 0)
         {
            if(this.members.length >= this._maxSize)
            {
               return param1;
            }
            if(this.members.length * 2 <= this._maxSize)
            {
               this.members.length *= 2;
            }
            else
            {
               this.members.length = this._maxSize;
            }
         }
         else
         {
            this.members.length *= 2;
         }
         this.members[_loc2_] = param1;
         this.length = _loc2_ + 1;
         return param1;
      }
      
      public function recycle(param1:Class = null) : FlxBasic
      {
         var _loc2_:FlxBasic = null;
         if(this._maxSize > 0)
         {
            if(this.length < this._maxSize)
            {
               if(param1 == null)
               {
                  return null;
               }
               return this.add(new param1() as FlxBasic);
            }
            var _loc3_:*;
            var _loc4_:* = (_loc3_ = this)._marker + 1;
            _loc3_._marker = _loc4_;
            _loc2_ = this.members[(_loc3_ = this)._marker];
            if(this._marker >= this._maxSize)
            {
               this._marker = 0;
            }
            return _loc2_;
         }
         _loc2_ = this.getFirstAvailable(param1);
         if(_loc2_ != null)
         {
            return _loc2_;
         }
         if(param1 == null)
         {
            return null;
         }
         return this.add(new param1() as FlxBasic);
      }
      
      public function remove(param1:FlxBasic, param2:Boolean = false) : FlxBasic
      {
         var _loc3_:int = this.members.indexOf(param1);
         §§push(_loc3_ < 0);
         if(!(_loc3_ < 0))
         {
            §§pop();
            while(true)
            {
               §§push(_loc3_ >= this.members.length);
            }
            addr26:
         }
         while(true)
         {
            if(§§pop())
            {
               return null;
            }
            if(!param2)
            {
               this.members[_loc3_] = null;
               break;
            }
            this.members.splice(_loc3_,1);
            if(true)
            {
               --this.length;
               break;
            }
            §§goto(addr26);
         }
         return param1;
      }
      
      public function replace(param1:FlxBasic, param2:FlxBasic) : FlxBasic
      {
         var _loc3_:int = this.members.indexOf(param1);
         if(_loc3_ < 0 || _loc3_ >= this.members.length)
         {
            return null;
         }
         this.members[_loc3_] = param2;
         return param2;
      }
      
      public function sort(param1:String = "y", param2:int = -1) : void
      {
         this._sortIndex = param1;
         this._sortOrder = param2;
         this.members.sort(this.sortHandler);
      }
      
      public function setAll(param1:String, param2:Object, param3:Boolean = true) : void
      {
         var _loc4_:FlxBasic = null;
         var _loc5_:uint = 0;
         while(_loc5_ < this.length)
         {
            if((_loc4_ = this.members[_loc5_++] as FlxBasic) != null)
            {
               if(param3 && _loc4_ is FlxGroup)
               {
                  (_loc4_ as FlxGroup).setAll(param1,param2,param3);
               }
               else
               {
                  _loc4_[param1] = param2;
               }
            }
         }
      }
      
      public function callAll(param1:String, param2:Boolean = true) : void
      {
         var _loc3_:FlxBasic = null;
         var _loc4_:uint = 0;
         while(_loc4_ < this.length)
         {
            _loc3_ = this.members[_loc4_++] as FlxBasic;
            if(_loc3_ != null)
            {
               if(param2 && _loc3_ is FlxGroup)
               {
                  (_loc3_ as FlxGroup).callAll(param1,param2);
               }
               else
               {
                  _loc3_[param1]();
               }
            }
         }
      }
      
      public function getFirstAvailable(param1:Class = null) : FlxBasic
      {
         var _loc2_:FlxBasic = null;
         var _loc3_:uint = 0;
         do
         {
            if(_loc3_ >= this.length)
            {
               return null;
            }
            _loc2_ = this.members[_loc3_++] as FlxBasic;
            §§push(_loc2_ != null && !_loc2_.exists);
            if(_loc2_ != null && !_loc2_.exists)
            {
               §§pop();
               §§push(param1 == null);
               if(!(param1 == null))
               {
                  §§pop();
                  §§push(_loc2_ is param1);
                  continue;
               }
            }
         }
         while(!§§pop());
         
         return _loc2_;
      }
      
      public function getFirstNull() : int
      {
         var _loc1_:FlxBasic = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = this.members.length;
         while(_loc2_ < _loc3_)
         {
            if(this.members[_loc2_] == null)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function getFirstExtant() : FlxBasic
      {
         var _loc1_:FlxBasic = null;
         var _loc2_:uint = 0;
         while(_loc2_ < this.length)
         {
            _loc1_ = this.members[_loc2_++] as FlxBasic;
            if(_loc1_ != null && _loc1_.exists)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function getFirstAlive() : FlxBasic
      {
         var _loc1_:FlxBasic = null;
         var _loc2_:uint = 0;
         while(_loc2_ < this.length)
         {
            _loc1_ = this.members[_loc2_++] as FlxBasic;
            if(_loc1_ != null && _loc1_.exists && _loc1_.alive)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function getFirstDead() : FlxBasic
      {
         var _loc1_:FlxBasic = null;
         var _loc2_:uint = 0;
         while(_loc2_ < this.length)
         {
            _loc1_ = this.members[_loc2_++] as FlxBasic;
            if(_loc1_ != null && !_loc1_.alive)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function countLiving() : int
      {
         var _loc2_:FlxBasic = null;
         var _loc1_:int = -1;
         var _loc3_:uint = 0;
         while(_loc3_ < this.length)
         {
            _loc2_ = this.members[_loc3_++] as FlxBasic;
            if(_loc2_ != null)
            {
               if(_loc1_ < 0)
               {
                  _loc1_ = 0;
               }
               while(_loc2_.exists && _loc2_.alive)
               {
                  _loc1_++;
                  if(true)
                  {
                     break;
                  }
               }
            }
         }
         return _loc1_;
      }
      
      public function countDead() : int
      {
         var _loc2_:FlxBasic = null;
         var _loc1_:int = -1;
         var _loc3_:uint = 0;
         while(_loc3_ < this.length)
         {
            _loc2_ = this.members[_loc3_++] as FlxBasic;
            if(_loc2_ != null)
            {
               if(_loc1_ < 0)
               {
                  _loc1_ = 0;
               }
               if(!_loc2_.alive)
               {
                  _loc1_++;
               }
            }
         }
         return _loc1_;
      }
      
      public function getRandom() : FlxBasic
      {
         return FlxG.getRandom(this.members) as FlxBasic;
      }
      
      public function clear() : void
      {
         this.length = this.members.length = 0;
      }
      
      override public function kill() : void
      {
         var _loc1_:FlxBasic = null;
         var _loc2_:uint = 0;
         while(_loc2_ < this.length)
         {
            _loc1_ = this.members[_loc2_++] as FlxBasic;
            if(_loc1_ != null && _loc1_.exists)
            {
               _loc1_.kill();
            }
         }
         super.kill();
      }
      
      override public function revive() : void
      {
         var _loc1_:FlxBasic = null;
         var _loc2_:uint = 0;
         while(_loc2_ < this.length)
         {
            _loc1_ = this.members[_loc2_++] as FlxBasic;
            if(_loc1_ != null && !_loc1_.exists)
            {
               _loc1_.revive();
            }
         }
         super.revive();
      }
      
      protected function sortHandler(param1:FlxBasic, param2:FlxBasic) : int
      {
         if(param1[this._sortIndex] < param2[this._sortIndex])
         {
            return this._sortOrder;
         }
         if(param1[this._sortIndex] > param2[this._sortIndex])
         {
            return -this._sortOrder;
         }
         return 0;
      }
   }
}
