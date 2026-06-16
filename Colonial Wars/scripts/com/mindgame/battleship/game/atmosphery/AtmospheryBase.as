package com.mindgame.battleship.game.atmosphery
{
   import com.mindgame.battleship.Worlds.*;
   import com.mindgame.battleship.game.islands.*;
   import com.mindgame.framework.*;
   import flash.geom.*;
   
   public class AtmospheryBase
   {
      
      private static var _atmBase:AtmospheryBase;
       
      
      private var _world:WorldComp;
      
      private var fps:int;
      
      private var fpsCounter:Number;
      
      private var mnog:Number = 6;
      
      private var allAnimation:Array;
      
      public var animationManager:AnimationManager;
      
      private var allIslands:Array;
      
      private var startPoint:Point;
      
      private var counter:int = 10;
      
      private var counterHelp:int;
      
      private var whale:Whale;
      
      private var fin:SharkFin;
      
      private var birds:Birds;
      
      public function AtmospheryBase()
      {
         this._world = WorldComp.returnWorld;
         this.fps = WorldComp.fps;
         this.fpsCounter = this.fps * this.mnog;
         this.allAnimation = [];
         this.startPoint = new Point();
         this.counterHelp = this.counter;
         super();
         _atmBase = this;
         this.animationManager = this._world.animationManager;
         this.whale = new Whale();
         this.whale.init();
         this._world.atmosphery.addChild(this.whale);
         this.fin = new SharkFin();
         this.fin.init();
         this._world.atmosphery.addChild(this.fin);
         this.birds = new Birds();
         this.birds.init();
         this.birds.mouseChildren = false;
         this.birds.mouseEnabled = false;
         this._world.islands.addChild(this.birds);
      }
      
      public static function get returnABase() : AtmospheryBase
      {
         return _atmBase;
      }
      
      private function addAnimation() : void
      {
         switch(int(Math.random() * 3))
         {
            case 0:
               this.mnog = 3;
               if(this.findFreePoint())
               {
                  this.allAnimation[this.allAnimation.length] = this.whale;
                  this.whale.setPosition(this.startPoint.x,this.startPoint.y,this.getRandomAngle);
               }
               break;
            case 1:
               this.mnog = 4;
               if(this.findFreePoint())
               {
                  this.allAnimation[this.allAnimation.length] = this.fin;
                  this.fin.setPosition(this.startPoint.x,this.startPoint.y);
               }
               break;
            case 2:
               this.mnog = 6;
               if(this.findIslandPoint())
               {
                  this.allAnimation[this.allAnimation.length] = this.birds;
                  this.birds.setPosition(this.startPoint.x,this.startPoint.y,0);
               }
         }
      }
      
      private function findIslandPoint() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:Island = null;
         this.allIslands = this._world.islandBase.allIsland;
         _loc1_ = int(int(Math.random() * (this.allIslands as Array).length));
         _loc2_ = (this.allIslands[_loc1_] as Array)[int(Math.random() * (this.allIslands[_loc1_] as Array).length)] as Island;
         if(_loc2_ == null)
         {
            return false;
         }
         this.startPoint.x = _loc2_.x;
         this.startPoint.y = _loc2_.y;
         return true;
      }
      
      private function findFreePoint() : Boolean
      {
         this.startPoint = this.getRandomPoint;
         this.allIslands = this._world.islandBase.allIsland;
         while(this.cicle())
         {
         }
         if(this.counterHelp <= 0)
         {
            this.counterHelp = this.counter;
            return false;
         }
         this.counterHelp = this.counter;
         return true;
      }
      
      private function cicle() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         --this.counterHelp;
         if(this.counterHelp > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < (this.allIslands as Array).length)
            {
               _loc2_ = 0;
               while(_loc2_ < (this.allIslands[_loc1_] as Array).length)
               {
                  if(((this.allIslands[_loc1_] as Array)[_loc2_] as Island).width >= Emath.distance(((this.allIslands[_loc1_] as Array)[_loc2_] as Island).x,((this.allIslands[_loc1_] as Array)[_loc2_] as Island).y,this.startPoint.x,this.startPoint.y))
                  {
                     this.startPoint = this.getRandomPoint;
                     return true;
                  }
                  _loc2_++;
               }
               _loc1_++;
            }
         }
         return false;
      }
      
      private function get getRandomPoint() : Point
      {
         return new Point(int(Math.random() * WorldComp.Width),int(Math.random() * WorldComp.Heigth));
      }
      
      private function get getRandomAngle() : int
      {
         return Math.random() * 360;
      }
      
      private function managerAtm() : void
      {
         if(this.fpsCounter < 0)
         {
            this.addAnimation();
            this.fpsCounter = this.fps * this.mnog * XORRandom.randomRangeNumber(1,3);
         }
         else
         {
            --this.fpsCounter;
         }
      }
      
      public function update() : void
      {
         var _loc1_:int = 0;
         if(this.allAnimation.length > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < this.allAnimation.length)
            {
               if((this.allAnimation[_loc1_] as AtmParent).endAnimation)
               {
                  this.allAnimation.splice(_loc1_,1);
               }
               else
               {
                  this.allAnimation[_loc1_].update();
               }
               _loc1_++;
            }
         }
         else
         {
            this.managerAtm();
         }
      }
   }
}
