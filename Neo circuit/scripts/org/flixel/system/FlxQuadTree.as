package org.flixel.system
{
   import org.flixel.FlxBasic;
   import org.flixel.FlxGroup;
   import org.flixel.FlxObject;
   import org.flixel.FlxRect;
   
   public class FlxQuadTree extends FlxRect
   {
      
      public static const A_LIST:uint = 0;
      
      public static const B_LIST:uint = 1;
      
      public static var divisions:uint;
      
      protected static var _min:uint;
      
      protected static var _object:FlxObject;
      
      protected static var _objectLeftEdge:Number;
      
      protected static var _objectTopEdge:Number;
      
      protected static var _objectRightEdge:Number;
      
      protected static var _objectBottomEdge:Number;
      
      protected static var _list:uint;
      
      protected static var _useBothLists:Boolean;
      
      protected static var _processingCallback:Function;
      
      protected static var _notifyCallback:Function;
      
      protected static var _objectHullX:Number;
      
      protected static var _objectHullY:Number;
      
      protected static var _objectHullWidth:Number;
      
      protected static var _objectHullHeight:Number;
      
      protected static var _checkObjectHullX:Number;
      
      protected static var _checkObjectHullY:Number;
      
      protected static var _checkObjectHullWidth:Number;
      
      protected static var _checkObjectHullHeight:Number;
       
      
      protected var _canSubdivide:Boolean;
      
      protected var _headA:FlxList;
      
      protected var _tailA:FlxList;
      
      protected var _headB:FlxList;
      
      protected var _tailB:FlxList;
      
      protected var _northWestTree:FlxQuadTree;
      
      protected var _northEastTree:FlxQuadTree;
      
      protected var _southEastTree:FlxQuadTree;
      
      protected var _southWestTree:FlxQuadTree;
      
      protected var _leftEdge:Number;
      
      protected var _rightEdge:Number;
      
      protected var _topEdge:Number;
      
      protected var _bottomEdge:Number;
      
      protected var _halfWidth:Number;
      
      protected var _halfHeight:Number;
      
      protected var _midpointX:Number;
      
      protected var _midpointY:Number;
      
      public function FlxQuadTree(param1:Number, param2:Number, param3:Number, param4:Number, param5:FlxQuadTree = null)
      {
         var _loc6_:FlxList = null;
         var _loc7_:FlxList = null;
         super(param1,param2,param3,param4);
         this._headA = this._tailA = new FlxList();
         this._headB = this._tailB = new FlxList();
         if(param5 != null)
         {
            if(param5._headA.object != null)
            {
               _loc6_ = param5._headA;
               while(_loc6_ != null)
               {
                  if(this._tailA.object != null)
                  {
                     _loc7_ = this._tailA;
                     this._tailA = new FlxList();
                     _loc7_.next = this._tailA;
                  }
                  this._tailA.object = _loc6_.object;
                  _loc6_ = _loc6_.next;
               }
            }
            if(param5._headB.object != null)
            {
               _loc6_ = param5._headB;
               while(_loc6_ != null)
               {
                  if(this._tailB.object != null)
                  {
                     _loc7_ = this._tailB;
                     this._tailB = new FlxList();
                     _loc7_.next = this._tailB;
                  }
                  this._tailB.object = _loc6_.object;
                  _loc6_ = _loc6_.next;
               }
            }
         }
         else
         {
            _min = (width + height) / (2 * divisions);
         }
         this._canSubdivide = width > _min || height > _min;
         this._northWestTree = null;
         this._northEastTree = null;
         this._southEastTree = null;
         this._southWestTree = null;
         this._leftEdge = x;
         this._rightEdge = x + width;
         this._halfWidth = width / 2;
         this._midpointX = this._leftEdge + this._halfWidth;
         this._topEdge = y;
         this._bottomEdge = y + height;
         this._halfHeight = height / 2;
         this._midpointY = this._topEdge + this._halfHeight;
      }
      
      public function destroy() : void
      {
         this._headA.destroy();
         this._headA = null;
         this._tailA.destroy();
         this._tailA = null;
         this._headB.destroy();
         this._headB = null;
         this._tailB.destroy();
         this._tailB = null;
         if(this._northWestTree != null)
         {
            this._northWestTree.destroy();
         }
         this._northWestTree = null;
         if(this._northEastTree != null)
         {
            this._northEastTree.destroy();
         }
         this._northEastTree = null;
         if(this._southEastTree != null)
         {
            this._southEastTree.destroy();
         }
         this._southEastTree = null;
         if(this._southWestTree != null)
         {
            this._southWestTree.destroy();
         }
         this._southWestTree = null;
         _object = null;
         _processingCallback = null;
         _notifyCallback = null;
      }
      
      public function load(param1:FlxBasic, param2:FlxBasic = null, param3:Function = null, param4:Function = null) : void
      {
         this.add(param1,A_LIST);
         if(param2 != null)
         {
            this.add(param2,B_LIST);
            _useBothLists = true;
         }
         else
         {
            _useBothLists = false;
         }
         _notifyCallback = param3;
         _processingCallback = param4;
      }
      
      public function add(param1:FlxBasic, param2:uint) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:FlxBasic = null;
         var _loc5_:Array = null;
         var _loc6_:uint = 0;
         _list = param2;
         if(param1 is FlxGroup)
         {
            _loc3_ = 0;
            _loc6_ = uint((_loc5_ = (param1 as FlxGroup).members).length);
            while(_loc3_ < _loc6_)
            {
               if((_loc4_ = _loc5_[_loc3_++] as FlxBasic) != null && _loc4_.exists)
               {
                  if(_loc4_ is FlxGroup)
                  {
                     this.add(_loc4_,param2);
                  }
                  else if(_loc4_ is FlxObject)
                  {
                     _object = _loc4_ as FlxObject;
                     if(_object.exists && Boolean(_object.allowCollisions))
                     {
                        _objectLeftEdge = _object.x;
                        _objectTopEdge = _object.y;
                        _objectRightEdge = _object.x + _object.width;
                        do
                        {
                           _objectBottomEdge = _object.y + _object.height;
                           this.addObject();
                        }
                        while(false);
                        
                     }
                  }
               }
            }
         }
         else
         {
            _object = param1 as FlxObject;
            if(_object.exists && Boolean(_object.allowCollisions))
            {
               _objectLeftEdge = _object.x;
               _objectTopEdge = _object.y;
               _objectRightEdge = _object.x + _object.width;
               do
               {
                  _objectBottomEdge = _object.y + _object.height;
                  this.addObject();
               }
               while(false);
               
            }
         }
      }
      
      protected function addObject() : void
      {
         if(!this._canSubdivide || this._leftEdge >= _objectLeftEdge && this._rightEdge <= _objectRightEdge && this._topEdge >= _objectTopEdge && this._bottomEdge <= _objectBottomEdge)
         {
            this.addToList();
            return;
         }
         if(_objectLeftEdge > this._leftEdge && _objectRightEdge < this._midpointX)
         {
            if(_objectTopEdge > this._topEdge && _objectBottomEdge < this._midpointY)
            {
               if(this._northWestTree == null)
               {
                  this._northWestTree = new FlxQuadTree(this._leftEdge,this._topEdge,this._halfWidth,this._halfHeight,this);
               }
               this._northWestTree.addObject();
               return;
            }
            if(_objectTopEdge > this._midpointY && _objectBottomEdge < this._bottomEdge)
            {
               if(this._southWestTree == null)
               {
                  this._southWestTree = new FlxQuadTree(this._leftEdge,this._midpointY,this._halfWidth,this._halfHeight,this);
               }
               this._southWestTree.addObject();
               return;
            }
         }
         if(_objectLeftEdge > this._midpointX && _objectRightEdge < this._rightEdge)
         {
            if(_objectTopEdge > this._topEdge && _objectBottomEdge < this._midpointY)
            {
               if(this._northEastTree == null)
               {
                  this._northEastTree = new FlxQuadTree(this._midpointX,this._topEdge,this._halfWidth,this._halfHeight,this);
               }
               this._northEastTree.addObject();
               return;
            }
            if(_objectTopEdge > this._midpointY && _objectBottomEdge < this._bottomEdge)
            {
               if(this._southEastTree == null)
               {
                  this._southEastTree = new FlxQuadTree(this._midpointX,this._midpointY,this._halfWidth,this._halfHeight,this);
               }
               this._southEastTree.addObject();
               return;
            }
         }
         if(_objectRightEdge > this._leftEdge && _objectLeftEdge < this._midpointX && _objectBottomEdge > this._topEdge && _objectTopEdge < this._midpointY)
         {
            if(this._northWestTree == null)
            {
               this._northWestTree = new FlxQuadTree(this._leftEdge,this._topEdge,this._halfWidth,this._halfHeight,this);
            }
            this._northWestTree.addObject();
         }
         if(_objectRightEdge > this._midpointX && _objectLeftEdge < this._rightEdge && _objectBottomEdge > this._topEdge && _objectTopEdge < this._midpointY)
         {
            if(this._northEastTree == null)
            {
               this._northEastTree = new FlxQuadTree(this._midpointX,this._topEdge,this._halfWidth,this._halfHeight,this);
            }
            this._northEastTree.addObject();
         }
         if(_objectRightEdge > this._midpointX && _objectLeftEdge < this._rightEdge && _objectBottomEdge > this._midpointY && _objectTopEdge < this._bottomEdge)
         {
            if(this._southEastTree == null)
            {
               this._southEastTree = new FlxQuadTree(this._midpointX,this._midpointY,this._halfWidth,this._halfHeight,this);
            }
            this._southEastTree.addObject();
         }
         if(_objectRightEdge > this._leftEdge && _objectLeftEdge < this._midpointX && _objectBottomEdge > this._midpointY && _objectTopEdge < this._bottomEdge)
         {
            if(this._southWestTree == null)
            {
               this._southWestTree = new FlxQuadTree(this._leftEdge,this._midpointY,this._halfWidth,this._halfHeight,this);
            }
            this._southWestTree.addObject();
         }
      }
      
      protected function addToList() : void
      {
         var _loc1_:FlxList = null;
         if(_list == A_LIST)
         {
            if(this._tailA.object != null)
            {
               _loc1_ = this._tailA;
               this._tailA = new FlxList();
               _loc1_.next = this._tailA;
            }
            this._tailA.object = _object;
         }
         else
         {
            if(this._tailB.object != null)
            {
               _loc1_ = this._tailB;
               this._tailB = new FlxList();
               _loc1_.next = this._tailB;
            }
            this._tailB.object = _object;
         }
         if(!this._canSubdivide)
         {
            return;
         }
         if(this._northWestTree != null)
         {
            this._northWestTree.addToList();
         }
         if(this._northEastTree != null)
         {
            this._northEastTree.addToList();
         }
         if(this._southEastTree != null)
         {
            this._southEastTree.addToList();
         }
         if(this._southWestTree != null)
         {
            this._southWestTree.addToList();
         }
      }
      
      public function execute() : Boolean
      {
         var _loc2_:FlxList = null;
         var _loc1_:Boolean = false;
         if(_useBothLists)
         {
            _list = B_LIST;
            if(this._headA.object != null)
            {
               _loc2_ = this._headA;
               while(_loc2_ != null)
               {
                  _object = _loc2_.object;
                  §§push(_object.exists);
                  if(_object.exists)
                  {
                     §§pop();
                     while(true)
                     {
                        §§push(_object.allowCollisions > 0);
                     }
                     addr39:
                  }
                  while(§§pop() && this.overlapNode())
                  {
                     _loc1_ = true;
                     if(true)
                     {
                        break;
                     }
                     §§goto(addr39);
                  }
                  _loc2_ = _loc2_.next;
               }
            }
            _list = A_LIST;
            if(this._headB.object != null)
            {
               _loc2_ = this._headB;
               while(_loc2_ != null)
               {
                  _object = _loc2_.object;
                  if(_object.exists && _object.allowCollisions > 0)
                  {
                     if(this._northWestTree != null && this._northWestTree.overlapNode())
                     {
                        _loc1_ = true;
                     }
                     if(this._northEastTree != null && this._northEastTree.overlapNode())
                     {
                        _loc1_ = true;
                     }
                     if(this._southEastTree != null && this._southEastTree.overlapNode())
                     {
                        _loc1_ = true;
                     }
                     while(this._southWestTree != null && this._southWestTree.overlapNode())
                     {
                        _loc1_ = true;
                        if(true)
                        {
                           break;
                        }
                     }
                  }
                  _loc2_ = _loc2_.next;
               }
            }
         }
         else if(this._headA.object != null)
         {
            _loc2_ = this._headA;
            while(_loc2_ != null)
            {
               _object = _loc2_.object;
               §§push(_object.exists);
               if(_object.exists)
               {
                  §§pop();
                  while(true)
                  {
                     §§push(_object.allowCollisions > 0);
                  }
                  addr223:
               }
               while(§§pop() && this.overlapNode(_loc2_.next))
               {
                  _loc1_ = true;
                  if(true)
                  {
                     break;
                  }
                  §§goto(addr223);
               }
               _loc2_ = _loc2_.next;
            }
         }
         if(this._northWestTree != null && this._northWestTree.execute())
         {
            _loc1_ = true;
         }
         if(this._northEastTree != null && this._northEastTree.execute())
         {
            _loc1_ = true;
         }
         if(this._southEastTree != null && this._southEastTree.execute())
         {
            _loc1_ = true;
         }
         if(this._southWestTree != null && this._southWestTree.execute())
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      protected function overlapNode(param1:FlxList = null) : Boolean
      {
         var _loc3_:FlxObject = null;
         if(param1 == null)
         {
            if(_list == A_LIST)
            {
               param1 = this._headA;
            }
            else
            {
               param1 = this._headB;
            }
         }
         if(param1.object == null)
         {
            return false;
         }
         var _loc2_:Boolean = false;
         while(param1 != null)
         {
            if(!_object.exists || _object.allowCollisions <= 0)
            {
               break;
            }
            _loc3_ = param1.object;
            if(_object === _loc3_ || !_loc3_.exists || _loc3_.allowCollisions <= 0)
            {
               param1 = param1.next;
            }
            else
            {
               _objectHullX = _object.x < _object.last.x ? _object.x : _object.last.x;
               _objectHullY = _object.y < _object.last.y ? _object.y : _object.last.y;
               _objectHullWidth = _object.x - _object.last.x;
               _objectHullWidth = _object.width + (_objectHullWidth > 0 ? _objectHullWidth : -_objectHullWidth);
               _objectHullHeight = _object.y - _object.last.y;
               _objectHullHeight = _object.height + (_objectHullHeight > 0 ? _objectHullHeight : -_objectHullHeight);
               _checkObjectHullX = _loc3_.x < _loc3_.last.x ? _loc3_.x : _loc3_.last.x;
               _checkObjectHullY = _loc3_.y < _loc3_.last.y ? _loc3_.y : _loc3_.last.y;
               _checkObjectHullWidth = _loc3_.x - _loc3_.last.x;
               _checkObjectHullWidth = _loc3_.width + (_checkObjectHullWidth > 0 ? _checkObjectHullWidth : -_checkObjectHullWidth);
               _checkObjectHullHeight = _loc3_.y - _loc3_.last.y;
               _checkObjectHullHeight = _loc3_.height + (_checkObjectHullHeight > 0 ? _checkObjectHullHeight : -_checkObjectHullHeight);
               if(_objectHullX + _objectHullWidth > _checkObjectHullX && _objectHullX < _checkObjectHullX + _checkObjectHullWidth && _objectHullY + _objectHullHeight > _checkObjectHullY && _objectHullY < _checkObjectHullY + _checkObjectHullHeight)
               {
                  if(_processingCallback == null || _processingCallback(_object,_loc3_))
                  {
                     _loc2_ = true;
                  }
                  while(_loc2_ && _notifyCallback != null)
                  {
                     _notifyCallback(_object,_loc3_);
                     if(true)
                     {
                        break;
                     }
                  }
               }
               param1 = param1.next;
            }
         }
         return _loc2_;
      }
   }
}
