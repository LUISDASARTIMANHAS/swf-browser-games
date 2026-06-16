package com.mindgame.battleship.game.barriers
{
   import com.mindgame.battleship.Worlds.*;
   import flash.geom.*;
   
   public class Barriers
   {
       
      
      protected var _world:WorldComp;
      
      public var allBarriers:Array;
      
      protected var xy:Point;
      
      public var scaleXY:Number = 1;
      
      public var setBarrier:Boolean = false;
      
      public function Barriers()
      {
         this._world = WorldComp.returnWorld;
         this.allBarriers = [];
         this.xy = new Point();
         super();
      }
      
      public function setCoord(param1:int, param2:int) : void
      {
         this.xy.x = param1;
         this.xy.y = param2;
         this.setBarrier = true;
      }
      
      public function addBarrier(param1:String) : void
      {
         var _loc2_:Whirlpool = null;
         if(this.setBarrier)
         {
            switch(param1)
            {
               case "Whirlpool":
                  _loc2_ = new Whirlpool();
                  this.allBarriers[this.allBarriers.length] = _loc2_;
                  _loc2_.init(this.xy.x,this.xy.y,this.scaleXY);
            }
         }
      }
      
      public function clear() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.allBarriers.length)
         {
            (this.allBarriers[_loc1_] as Whirlpool).remove();
            _loc1_++;
         }
         this.setBarrier = false;
         this.allBarriers = [];
      }
      
      public function update() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.allBarriers.length)
         {
            (this.allBarriers[_loc1_] as Whirlpool).update();
            _loc1_++;
         }
      }
   }
}
