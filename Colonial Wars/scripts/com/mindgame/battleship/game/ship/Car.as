package com.mindgame.battleship.game.ship
{
   import com.mindgame.battleship.Worlds.*;
   import com.mindgame.battleship.game.barriers.Whirlpool;
   import com.mindgame.battleship.game.islands.*;
   import com.mindgame.framework.*;
   import flash.display.Sprite;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   
   public class Car extends Sprite
   {
      
      protected static var _world:WorldComp = WorldComp.returnWorld;
      
      protected static var animationManager:AnimationManager = _world.animationManager;
      
      protected static var getColor:GetColor = GetColor.returnGetColor;
      
      private static var allShips:Array;
      
      private static var allIsland:Array;
      
      public static var whirpool:Whirlpool;
       
      
      public var speed:int = 26;
      
      private var end:Point;
      
      private var centerPoint:Point;
      
      private var finalIsland:Island;
      
      private var startIsland:Island;
      
      private var movingVector:Evector;
      
      public var haveDest:Boolean = true;
      
      public var haveControl:Boolean = true;
      
      public var targetComplete:Boolean = true;
      
      private var angle:Number;
      
      protected var clip:Animation;
      
      protected var immunityIsland:Island;
      
      private var peoples:int;
      
      private var race:int = 0;
      
      public var findPath:Boolean = false;
      
      private var controlEnd:Boolean = false;
      
      private var controlEndCounter:int;
      
      private var checkWay:int;
      
      private var checkWayHelp:int;
      
      protected var txt:TextField;
      
      protected var showTxtNow:Boolean = false;
      
      protected var counter:int;
      
      protected var counterHelp:int;
      
      protected var effectCount:int = 35;
      
      protected var effectCountHelp:int;
      
      public var ship:Boolean = true;
      
      protected var nameInManager:String;
      
      private var angleTo:Number = 0;
      
      private var radiusWhirpool:Number = 0;
      
      public var washoutRate:Number = 0;
      
      public var shiftRate:Number = 0;
      
      protected var effectName:String;
      
      public function Car()
      {
         this.centerPoint = new Point();
         this.movingVector = new Evector();
         this.checkWay = WorldComp.fps * 5;
         this.checkWayHelp = this.checkWay;
         this.counter = 1 * WorldComp.fps;
         this.counterHelp = this.counter;
         this.effectCountHelp = this.effectCount;
         super();
      }
      
      protected function init() : void
      {
         this.txt = new TextField();
         _world.shipBase.allShips[(_world.shipBase.allShips as Array).length] = this;
         allShips = _world.shipBase.allShips;
         allIsland = _world.islandBase.allIsland;
         this.clip = animationManager.getAnimation(this.nameInManager);
         this.clip.update();
         this.createText();
         addChild(this.clip);
         this.addEventListener(MouseEvent.MOUSE_OVER,this.showTxt,false,0,true);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.hideTxt,false,0,true);
      }
      
      private function createText() : void
      {
         this.txt = new TextField();
         this.txt.defaultTextFormat = new TextFormat("Tahoma Regular",12,0);
         this.txt.background = true;
         this.txt.autoSize = TextFieldAutoSize.RIGHT;
         this.txt.selectable = false;
         this.txt.mouseEnabled = false;
         this.txt.visible = false;
         _world.txtLayer.addChild(this.txt);
      }
      
      private function showTxt(param1:MouseEvent) : void
      {
         this.txt.visible = true;
         this.counterHelp = this.counter;
         this.showTxtNow = false;
      }
      
      private function hideTxt(param1:MouseEvent) : void
      {
         this.showTxtNow = true;
      }
      
      public function changeRace() : void
      {
         this.txt.backgroundColor = getColor.getRaceColor(this.race);
      }
      
      private function editText() : void
      {
         if(this.txt == null)
         {
            this.createText();
         }
         this.txt.text = String(int(this.peoples));
      }
      
      public function set setRace(param1:int) : void
      {
         this.race = param1;
         this.changeRace();
      }
      
      public function get getRace() : int
      {
         return this.race;
      }
      
      public function setWay(param1:int, param2:int, param3:Island, param4:Island) : void
      {
         this.startIsland = param4;
         this.finalIsland = param3;
         this.end = new Point(this.finalIsland.x,this.finalIsland.y);
         this.angle = Emath.getAngle(this.startIsland.x,this.startIsland.y,this.end.x,this.end.y);
         this.movingVector.asSpeed(this.speed * _world.delta,this.angle);
         if(this.ship)
         {
            x = param1 + this.movingVector.x * (this.startIsland.width + this.startIsland.height) * 0.25;
            y = param2 + this.movingVector.y * (this.startIsland.width + this.startIsland.height) * 0.25;
         }
         else
         {
            x = param1;
            y = param2;
         }
         this.clip.update();
         this.clip.x -= width * 0.5;
         this.clip.y -= height * 0.5;
         this.txt.x = param1 - width * 0.5 + this.txt.width;
         this.txt.y = param2 + height * 0.5 - this.txt.height;
         this.rotation = Emath.toDegrees(this.angle);
         this.haveDest = true;
         if(this.findPath)
         {
            _world.islands.addChild(this);
         }
         else
         {
            _world.allLive.addChild(this);
         }
      }
      
      public function crash() : void
      {
         _world.effectManager.addAnimation("Blast",this);
         this.deleteCar();
      }
      
      private function deleteCar() : void
      {
         if(this.parent)
         {
            this.removeChild(this.clip);
            _world.txtLayer.removeChild(this.txt);
            if(this.findPath)
            {
               _world.islands.removeChild(this);
            }
            else
            {
               _world.allLive.removeChild(this);
            }
         }
         this.removeEventListener(MouseEvent.MOUSE_OVER,this.showTxt);
         this.removeEventListener(MouseEvent.MOUSE_OUT,this.hideTxt);
         this.clip = null;
      }
      
      public function removing() : void
      {
         this.finalIsland.deffPeople(this.peoples,this.race);
         if(this.finalIsland.getRace == this.race)
         {
            if(this.finalIsland.people <= this.peoples)
            {
               this.peoples = this.finalIsland.people;
            }
         }
         _world.popupValues.createValue(x,y,this.movingVector,int(Emath.distance(x,y,this.end.x,this.end.y) * 0.5),this.race,this.peoples,this.finalIsland.getRace);
         this.deleteCar();
      }
      
      public function set setPeople(param1:int) : void
      {
         this.peoples = param1;
         this.editText();
      }
      
      public function get getPeople() : int
      {
         return this.peoples;
      }
      
      public function checkHitTest() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < allShips.length)
         {
            if((allShips[_loc1_] as Car).getRace != this.race)
            {
               if((allShips[_loc1_] as Car).haveControl)
               {
                  if(Emath.distance(x,y,(allShips[_loc1_] as Car).x,(allShips[_loc1_] as Car).y) < (width + height + ((allShips[_loc1_] as Car).width + (allShips[_loc1_] as Car).height)) * 0.2)
                  {
                     this.hitShips(allShips[_loc1_] as Car);
                     break;
                  }
               }
            }
            _loc1_++;
         }
      }
      
      private function hitShips(param1:Car) : void
      {
         if(param1.peoples > this.peoples)
         {
            param1.peoples -= this.peoples;
            this.haveDest = false;
            this.peoples = 0;
            this.targetComplete = false;
         }
         else if(param1.peoples < this.peoples)
         {
            this.peoples -= param1.peoples;
            this.editText();
            param1.haveDest = false;
            param1.peoples = 0;
            param1.targetComplete = false;
         }
         else
         {
            param1.haveDest = false;
            param1.peoples = 0;
            this.haveDest = false;
            this.peoples = 0;
            param1.targetComplete = false;
            this.targetComplete = false;
         }
         _world.soundManager.playShortSound("explosion");
      }
      
      private function checkHitIsland() : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Evector = null;
         var _loc7_:Evector = null;
         var _loc8_:Point = null;
         var _loc9_:Point = null;
         var _loc1_:int = 0;
         while(_loc1_ < allIsland.length)
         {
            _loc2_ = 0;
            while(_loc2_ < (allIsland[_loc1_] as Array).length)
            {
               if((allIsland[_loc1_] as Array)[_loc2_] as Island != this.startIsland && (allIsland[_loc1_] as Array)[_loc2_] as Island != this.finalIsland && this.immunityIsland != (allIsland[_loc1_] as Array)[_loc2_] as Island)
               {
                  if(((allIsland[_loc1_] as Array)[_loc2_] as Island).hitTestPoint(x + ((allIsland[_loc1_] as Array)[_loc2_] as Island).width * 0.0002 * Math.cos(Emath.toRadians(rotation)),y + ((allIsland[_loc1_] as Array)[_loc2_] as Island).height * 0.0002 * Math.sin(Emath.toRadians(rotation)),false))
                  {
                     _loc3_ = Number(Emath.toDegrees(Emath.getAngle(x,y,((allIsland[_loc1_] as Array)[_loc2_] as Island).x,((allIsland[_loc1_] as Array)[_loc2_] as Island).y)));
                     _loc4_ = _loc3_ + 90;
                     _loc5_ = _loc3_ - 90;
                     _loc6_ = new Evector();
                     _loc7_ = new Evector();
                     _loc6_.asSpeed(((allIsland[_loc1_] as Array)[_loc2_] as Island).width,Emath.toRadians(_loc4_));
                     _loc7_.asSpeed(((allIsland[_loc1_] as Array)[_loc2_] as Island).width,Emath.toRadians(_loc5_));
                     _loc8_ = new Point(((allIsland[_loc1_] as Array)[_loc2_] as Island).x + _loc6_.x,((allIsland[_loc1_] as Array)[_loc2_] as Island).y + _loc6_.y);
                     _loc9_ = new Point(((allIsland[_loc1_] as Array)[_loc2_] as Island).x + _loc7_.x,((allIsland[_loc1_] as Array)[_loc2_] as Island).y + _loc7_.y);
                     this.immunityIsland = (allIsland[_loc1_] as Array)[_loc2_] as Island;
                     if(Emath.distance(_loc8_.x,_loc8_.y,this.end.x,this.end.y) <= Emath.distance(_loc9_.x,_loc9_.y,this.end.x,this.end.y))
                     {
                        this.movingVector.asSpeed(this.speed * _world.delta,Emath.getAngle(x,y,_loc8_.x,_loc8_.y));
                        this.rotation = Emath.toDegrees(Emath.getAngle(x,y,_loc8_.x,_loc8_.y));
                        this.controlEndCounter = Emath.distance(x,y,_loc8_.x,_loc8_.y) / (this.speed * _world.delta);
                     }
                     else
                     {
                        this.movingVector.asSpeed(this.speed * _world.delta,Emath.getAngle(x,y,_loc9_.x,_loc9_.y));
                        this.rotation = Emath.toDegrees(Emath.getAngle(x,y,_loc9_.x,_loc9_.y));
                        this.controlEndCounter = Emath.distance(x,y,_loc9_.x,_loc9_.y) / (this.speed * _world.delta);
                     }
                     this.controlEndCounter *= 0.55;
                     this.controlEnd = true;
                  }
               }
               _loc2_++;
            }
            _loc1_++;
         }
         if(this.controlEnd)
         {
            if(this.controlEndCounter <= 0)
            {
               this.angle = Emath.getAngle(x,y,this.end.x,this.end.y);
               this.rotation = Emath.toDegrees(this.angle);
               this.movingVector.asSpeed(this.speed * _world.delta,this.angle);
               this.controlEnd = false;
               this.immunityIsland = null;
            }
            else
            {
               x += this.movingVector.x;
               y += this.movingVector.y;
               --this.controlEndCounter;
            }
         }
         else
         {
            x += this.movingVector.x;
            y += this.movingVector.y;
         }
      }
      
      private function wayCheck() : void
      {
         if(this.checkWayHelp-- < 0 && !this.controlEnd)
         {
            this.angle = Emath.getAngle(x,y,this.end.x,this.end.y);
            this.movingVector.asSpeed(this.speed * _world.delta,this.angle);
            this.rotation = Emath.toDegrees(this.angle);
            this.checkWayHelp = this.checkWay;
         }
      }
      
      public function update() : void
      {
         if(this.haveControl)
         {
            if(this.haveDest)
            {
               this.clip.update();
               if(int(Emath.distance(x,y,this.end.x,this.end.y)) < (this.finalIsland.width + this.finalIsland.height) * 0.2)
               {
                  this.haveDest = false;
               }
               else
               {
                  if(this.findPath)
                  {
                     this.checkHitIsland();
                  }
                  else
                  {
                     x += this.movingVector.x;
                     y += this.movingVector.y;
                  }
                  this.wayCheck();
                  this.movingTxt();
               }
               this.checkHitTest();
               this.checkBarrier();
            }
            else if(this.targetComplete)
            {
               this.removing();
            }
            else
            {
               this.crash();
            }
         }
         else
         {
            x = whirpool.x + Math.cos(this.angleTo) * this.radiusWhirpool;
            y = whirpool.y + Math.sin(this.angleTo) * this.radiusWhirpool;
            this.angleTo += this.washoutRate;
            this.radiusWhirpool -= this.shiftRate;
            this.movingTxt();
            if(this.radiusWhirpool <= 0)
            {
               this.haveControl = true;
               this.haveDest = false;
               this.targetComplete = false;
            }
         }
      }
      
      private function checkBarrier() : void
      {
         if(_world.barriers.setBarrier)
         {
            if(int(Emath.distance(x,y,whirpool.x,whirpool.y)) < whirpool.width * 0.4)
            {
               this.haveControl = false;
               this.angleTo = Emath.getAngle(whirpool.x,whirpool.y,x,y);
               this.radiusWhirpool = whirpool.width * 0.4;
            }
         }
      }
      
      private function movingTxt() : void
      {
         this.txt.x = x - width * 0.5 + this.txt.width;
         this.txt.y = y + height * 0.5 - this.txt.height;
         if(this.showTxtNow)
         {
            if(this.counterHelp-- < 0)
            {
               this.counterHelp = this.counter;
               this.showTxtNow = false;
               this.txt.visible = false;
            }
         }
      }
   }
}
