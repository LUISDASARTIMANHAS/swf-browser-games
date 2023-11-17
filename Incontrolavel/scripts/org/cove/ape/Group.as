package org.cove.ape
{
   public class Group extends AbstractCollection
   {
       
      
      private var _composites:Array;
      
      private var _collisionList:Array;
      
      private var _collideInternal:Boolean;
      
      public function Group(param1:Boolean = false)
      {
         super();
         this._composites = new Array();
         this._collisionList = new Array();
         this.collideInternal = param1;
      }
      
      public function addCollidableList(param1:Array) : void
      {
         var _loc3_:Group = null;
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = param1[_loc2_];
            this.collisionList.push(_loc3_);
            _loc2_++;
         }
      }
      
      internal function checkCollisions() : void
      {
         var _loc3_:Group = null;
         if(this.collideInternal)
         {
            this.checkCollisionGroupInternal();
         }
         var _loc1_:int = int(this.collisionList.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.collisionList[_loc2_];
            if(_loc3_ != null)
            {
               this.checkCollisionVsGroup(_loc3_);
            }
            _loc2_++;
         }
      }
      
      public function removeComposite(param1:Composite) : void
      {
         var _loc2_:int = int(this.composites.indexOf(param1));
         if(_loc2_ == -1)
         {
            return;
         }
         this.composites.splice(_loc2_,1);
         param1.isParented = false;
         param1.cleanup();
      }
      
      override public function cleanup() : void
      {
         super.cleanup();
         var _loc1_:int = 0;
         while(_loc1_ < this.composites.length)
         {
            this.composites[_loc1_].cleanup();
            _loc1_++;
         }
      }
      
      public function removeCollidable(param1:Group) : void
      {
         var _loc2_:int = int(this.collisionList.indexOf(param1));
         if(_loc2_ == -1)
         {
            return;
         }
         this.collisionList.splice(_loc2_,1);
      }
      
      public function addComposite(param1:Composite) : void
      {
         this.composites.push(param1);
         param1.isParented = true;
         if(isParented)
         {
            param1.init();
         }
      }
      
      public function addCollidable(param1:Group) : void
      {
         this.collisionList.push(param1);
      }
      
      override internal function integrate(param1:Number) : void
      {
         var _loc4_:Composite = null;
         super.integrate(param1);
         var _loc2_:int = int(this._composites.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            (_loc4_ = this._composites[_loc3_]).integrate(param1);
            _loc3_++;
         }
      }
      
      public function get composites() : Array
      {
         return this._composites;
      }
      
      override public function init() : void
      {
         super.init();
         var _loc1_:int = 0;
         while(_loc1_ < this.composites.length)
         {
            this.composites[_loc1_].init();
            _loc1_++;
         }
      }
      
      override public function getAll() : Vector.<Object>
      {
         return Vector.<Object>(particles).concat(Vector.<Object>(constraints)).concat(Vector.<Object>(this.composites));
      }
      
      public function get collisionList() : Array
      {
         return this._collisionList;
      }
      
      private function checkCollisionGroupInternal() : void
      {
         var _loc3_:Composite = null;
         var _loc4_:int = 0;
         var _loc5_:Composite = null;
         checkInternalCollisions();
         var _loc1_:int = int(this._composites.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._composites[_loc2_];
            if(_loc3_ != null)
            {
               _loc3_.checkCollisionsVsCollection(this);
               _loc4_ = _loc2_ + 1;
               while(_loc4_ < _loc1_)
               {
                  if((_loc5_ = this._composites[_loc4_]) != null)
                  {
                     _loc3_.checkCollisionsVsCollection(_loc5_);
                  }
                  _loc4_++;
               }
            }
            _loc2_++;
         }
      }
      
      override internal function satisfyConstraints() : void
      {
         var _loc3_:Composite = null;
         super.satisfyConstraints();
         var _loc1_:int = int(this._composites.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._composites[_loc2_];
            _loc3_.satisfyConstraints();
            _loc2_++;
         }
      }
      
      public function get collideInternal() : Boolean
      {
         return this._collideInternal;
      }
      
      public function set collideInternal(param1:Boolean) : void
      {
         this._collideInternal = param1;
      }
      
      override public function paint() : void
      {
         var _loc3_:Composite = null;
         super.paint();
         var _loc1_:int = int(this._composites.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._composites[_loc2_];
            _loc3_.paint();
            _loc2_++;
         }
      }
      
      private function checkCollisionVsGroup(param1:Group) : void
      {
         var _loc2_:Composite = null;
         var _loc6_:Composite = null;
         var _loc7_:int = 0;
         checkCollisionsVsCollection(param1);
         var _loc3_:int = int(this._composites.length);
         var _loc4_:int = int(param1.composites.length);
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            if((_loc6_ = this._composites[_loc5_]) != null)
            {
               _loc6_.checkCollisionsVsCollection(param1);
               _loc7_ = 0;
               while(_loc7_ < _loc4_)
               {
                  _loc2_ = param1.composites[_loc7_];
                  if(_loc2_ != null)
                  {
                     _loc6_.checkCollisionsVsCollection(_loc2_);
                  }
                  _loc7_++;
               }
            }
            _loc5_++;
         }
         _loc7_ = 0;
         while(_loc7_ < _loc4_)
         {
            _loc2_ = param1.composites[_loc7_];
            if(_loc2_ != null)
            {
               checkCollisionsVsCollection(_loc2_);
            }
            _loc7_++;
         }
      }
   }
}
