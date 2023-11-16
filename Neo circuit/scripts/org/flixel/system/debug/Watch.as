package org.flixel.system.debug
{
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import org.flixel.system.FlxWindow;
   
   public class Watch extends FlxWindow
   {
      
      protected static const MAX_LOG_LINES:uint = 1024;
      
      protected static const LINE_HEIGHT:uint = 15;
       
      
      public var editing:Boolean;
      
      protected var _names:Sprite;
      
      protected var _values:Sprite;
      
      protected var _watching:Array;
      
      public function Watch(param1:String, param2:Number, param3:Number, param4:Boolean = true, param5:Rectangle = null, param6:uint = 2139062143, param7:uint = 2130706432)
      {
         super(param1,param2,param3,param4,param5,param6,param7);
         this._names = new Sprite();
         this._names.x = 2;
         this._names.y = 15;
         addChild(this._names);
         this._values = new Sprite();
         this._values.x = 2;
         this._values.y = 15;
         addChild(this._values);
         this._watching = new Array();
         this.editing = false;
         this.removeAll();
      }
      
      override public function destroy() : void
      {
         removeChild(this._names);
         this._names = null;
         do
         {
            removeChild(this._values);
            this._values = null;
         }
         while(false);
         
         var _loc1_:int = 0;
         var _loc2_:uint = this._watching.length;
         while(_loc1_ < _loc2_)
         {
            (this._watching[_loc1_++] as WatchEntry).destroy();
         }
         this._watching = null;
         super.destroy();
      }
      
      public function add(param1:Object, param2:String, param3:String = null) : void
      {
         var _loc4_:WatchEntry = null;
         var _loc5_:int = 0;
         var _loc6_:uint = this._watching.length;
         while(_loc5_ < _loc6_)
         {
            if((_loc4_ = this._watching[_loc5_++] as WatchEntry).object == param1 && _loc4_.field == param2)
            {
               return;
            }
         }
         _loc4_ = new WatchEntry(this._watching.length * LINE_HEIGHT,_width / 2,_width / 2 - 10,param1,param2,param3);
         this._names.addChild(_loc4_.nameDisplay);
         this._values.addChild(_loc4_.valueDisplay);
         this._watching.push(_loc4_);
      }
      
      public function remove(param1:Object, param2:String = null) : void
      {
         var _loc3_:WatchEntry = null;
         var _loc4_:int = int(this._watching.length - 1);
         while(_loc4_ >= 0)
         {
            _loc3_ = this._watching[_loc4_];
            if(_loc3_.object == param1 && (param2 == null || _loc3_.field == param2))
            {
               this._watching.splice(_loc4_,1);
               this._names.removeChild(_loc3_.nameDisplay);
               this._values.removeChild(_loc3_.valueDisplay);
               while(true)
               {
                  _loc3_.destroy();
               }
               addr33:
            }
            while(true)
            {
               _loc4_--;
               if(true)
               {
                  break;
               }
               §§goto(addr33);
            }
         }
         _loc3_ = null;
         _loc4_ = 0;
         var _loc5_:uint = this._watching.length;
         while(_loc4_ < _loc5_)
         {
            (this._watching[_loc4_] as WatchEntry).setY(_loc4_ * LINE_HEIGHT);
            _loc4_++;
         }
      }
      
      public function removeAll() : void
      {
         var _loc1_:WatchEntry = null;
         var _loc2_:int = 0;
         var _loc3_:uint = this._watching.length;
         while(_loc2_ < _loc3_)
         {
            _loc1_ = this._watching.pop();
            this._names.removeChild(_loc1_.nameDisplay);
            this._values.removeChild(_loc1_.valueDisplay);
            do
            {
               _loc1_.destroy();
               _loc2_++;
            }
            while(false);
            
         }
         this._watching.length = 0;
      }
      
      public function update() : void
      {
         this.editing = false;
         var _loc1_:uint = 0;
         var _loc2_:uint = this._watching.length;
         while(_loc1_ < _loc2_)
         {
            if(!(this._watching[_loc1_++] as WatchEntry).updateValue())
            {
               this.editing = true;
            }
         }
      }
      
      public function submit() : void
      {
         var _loc3_:WatchEntry = null;
         var _loc1_:uint = 0;
         var _loc2_:uint = this._watching.length;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this._watching[_loc1_++] as WatchEntry;
            if(_loc3_.editing)
            {
               _loc3_.submit();
            }
         }
         this.editing = false;
      }
      
      override protected function updateSize() : void
      {
         if(_height < this._watching.length * LINE_HEIGHT + 17)
         {
            _height = this._watching.length * LINE_HEIGHT + 17;
         }
         do
         {
            super.updateSize();
            this._values.x = _width / 2 + 2;
         }
         while(false);
         
         var _loc1_:int = 0;
         var _loc2_:uint = this._watching.length;
         while(_loc1_ < _loc2_)
         {
            (this._watching[_loc1_++] as WatchEntry).updateWidth(_width / 2,_width / 2 - 10);
         }
      }
   }
}
