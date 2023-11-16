package
{
   import flash.geom.Rectangle;
   import org.flixel.FlxG;
   import patterns.cEnum;
   import utils.cGeometry;
   import utils.cHelper;
   import utils.cVector2;
   
   public class cPlayerAI
   {
      
      public static const DIFFICULTY_VERY_EASY:int = cEnum.Enum(0);
      
      public static const DIFFICULTY_EASY:int = cEnum.inc;
      
      public static const DIFFICULTY_MEDIUM:int = cEnum.inc;
      
      public static const DIFFICULTY_HARD:int = cEnum.inc;
      
      public static const MAX_NEIGHTBOUR_DIST:int = 57600;
      
      public static const AI_TYPE_DEFENSIVE:int = cEnum.Enum(0);
      
      public static const AI_TYPE_AGGRESSIVE:int = cEnum.inc;
      
      public static const AI_TYPE_BALANCED:int = cEnum.inc;
      
      private static var m_tempRect:Rectangle = new Rectangle();
      
      private static var m_tempVec1:cVector2 = new cVector2();
      
      private static var m_tempVec2:cVector2 = new cVector2();
       
      
      public var active:Boolean;
      
      private var UPDATE_TIMES_EASY:Array;
      
      private var ACTION_POINTS_EASY:Array;
      
      private var UPDATE_TIMES_HARD:Array;
      
      private var ACTION_POINTS_HARD:Array;
      
      private var m_playerId:int;
      
      private var m_map:cMap;
      
      private var m_cpuList:Array;
      
      private var m_enemyList:Array;
      
      private var m_neutralList:Array;
      
      private var m_underAttack:Array;
      
      private var m_data:cPlayerAiData;
      
      private var m_difficulty:int;
      
      private var m_updateTime:Number;
      
      private var m_actionPoints:int;
      
      public function cPlayerAI()
      {
         this.UPDATE_TIMES_EASY = [10,9,8,7,6,5,4,3];
         this.ACTION_POINTS_EASY = [1,1,1,1,1,1,1,1];
         this.UPDATE_TIMES_HARD = [8,7,6,5,4,3,2,1.5];
         this.ACTION_POINTS_HARD = [1,1,1,2,2,2,2,3];
         super();
      }
      
      public static function connectable(param1:cCPU, param2:cCPU, param3:Number) : Boolean
      {
         if(param1.hasConnectionTo(param2))
         {
            return false;
         }
         if(param2.owner == param1.owner && param1.hasConnectionTo(param2))
         {
            return false;
         }
         if(param2.data.type == cCPUData.BARRIER)
         {
            return false;
         }
         if(!lineOfSightCheck(param1,param2))
         {
            return false;
         }
         return true;
      }
      
      private static function lineOfSightCheck(param1:cCPU, param2:cCPU) : Boolean
      {
         var _loc4_:cCPU = null;
         var _loc3_:Array = cObjectManager.getInstance().map.cpuList;
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.length)
         {
            if((_loc4_ = _loc3_[_loc5_] as cCPU) == param1 || _loc4_ == param2)
            {
               do
               {
                  _loc5_++;
               }
               while(false);
               
               continue;
               addr36:
            }
            else
            {
               m_tempVec1.set(param1.x + param1.origin.x,param1.y + param1.origin.y);
               m_tempVec2.set(param2.x + param2.origin.x,param2.y + param2.origin.y);
               m_tempRect.x = _loc4_.x;
               m_tempRect.y = _loc4_.y;
               m_tempRect.width = _loc4_.width;
               m_tempRect.height = _loc4_.height;
            }
            while(!cGeometry.rayBoxIntersect(m_tempVec1,m_tempVec2,m_tempRect))
            {
               §§goto(addr36);
            }
            return false;
         }
         return true;
      }
      
      public function init(param1:int, param2:int, param3:int) : void
      {
         this.active = true;
         this.m_playerId = param1;
         this.m_data = cObjectManager.getInstance().playerAiDataList[param3];
         this.m_difficulty = param2;
         if(NeoCircuit.difficulty == NeoCircuit.DIFFICULTY_EASY)
         {
            this.m_updateTime = this.UPDATE_TIMES_EASY[this.m_difficulty];
            this.m_actionPoints = this.ACTION_POINTS_EASY[this.m_difficulty];
         }
         else
         {
            this.m_updateTime = this.UPDATE_TIMES_HARD[this.m_difficulty];
            this.m_actionPoints = this.ACTION_POINTS_HARD[this.m_difficulty];
         }
         this.m_map = cObjectManager.getInstance().map;
      }
      
      public function update() : void
      {
         this.m_updateTime -= FlxG.elapsed;
         if(this.m_updateTime <= 0)
         {
            if(NeoCircuit.difficulty == NeoCircuit.DIFFICULTY_EASY)
            {
               this.m_updateTime = this.UPDATE_TIMES_EASY[this.m_difficulty];
               this.m_actionPoints = this.ACTION_POINTS_EASY[this.m_difficulty];
            }
            else
            {
               this.m_updateTime = this.UPDATE_TIMES_HARD[this.m_difficulty];
               this.m_actionPoints = this.ACTION_POINTS_HARD[this.m_difficulty];
            }
            this.MakeDecision();
         }
      }
      
      public function updateLists() : void
      {
         var _loc2_:cCPU = null;
         var _loc1_:Array = this.m_map.cpuList;
         this.m_neutralList = [];
         this.m_enemyList = [];
         do
         {
            this.m_cpuList = [];
            this.m_underAttack = [];
         }
         while(false);
         
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = _loc1_[_loc3_] as cCPU;
            if(_loc2_.data.type != cCPUData.BARRIER)
            {
               if(_loc2_.owner == cCPU.NEUTRAL)
               {
                  this.m_neutralList.push(_loc2_);
               }
               else if(_loc2_.owner != this.m_playerId)
               {
                  this.m_enemyList.push(_loc2_);
               }
               else if(_loc2_.owner == this.m_playerId)
               {
                  this.m_cpuList.push(_loc2_);
                  if(_loc2_.underAttack)
                  {
                     this.m_underAttack.push(_loc2_);
                     while(true)
                     {
                        this.calculateAttackPower(_loc2_);
                     }
                     addr54:
                  }
               }
            }
            while(true)
            {
               _loc3_++;
               if(true)
               {
                  break;
               }
               §§goto(addr54);
            }
         }
      }
      
      private function calculateAttackPower(param1:cCPU) : void
      {
         var _loc2_:cConnection = null;
         param1.aiData.attackPower = 0;
         var _loc3_:int = 0;
         while(_loc3_ < param1.foreignConnections.length)
         {
            _loc2_ = param1.foreignConnections[_loc3_] as cConnection;
            if(_loc2_.startCPU.owner != param1.owner)
            {
               param1.aiData.attackPower += _loc2_.startCPU.power;
            }
            _loc3_++;
         }
      }
      
      private function calculateDefensePower(param1:cCPU) : void
      {
         var _loc2_:cConnection = null;
         param1.aiData.defensePower = param1.power;
         var _loc3_:int = 0;
         while(_loc3_ < param1.foreignConnections.length)
         {
            _loc2_ = param1.foreignConnections[_loc3_] as cConnection;
            if(_loc2_.startCPU.owner == param1.owner)
            {
               param1.aiData.defensePower += _loc2_.startCPU.power * 0.5;
            }
            _loc3_++;
         }
      }
      
      private function findNearest(param1:cCPU, param2:Array) : cCPU
      {
         var _loc4_:Number = NaN;
         var _loc6_:cCPU = null;
         var _loc3_:Number = Number.MAX_VALUE;
         var _loc5_:cCPU = null;
         var _loc7_:int = 0;
         while(_loc7_ < param2.length)
         {
            if((_loc6_ = param2[_loc7_] as cCPU) != param1)
            {
               if(lineOfSightCheck(param1,_loc6_))
               {
                  if((_loc4_ = cHelper.distanceSquared(param1.x,param1.y,_loc6_.x,_loc6_.y)) < _loc3_)
                  {
                     _loc5_ = _loc6_;
                     _loc3_ = _loc4_;
                  }
                  else if(_loc4_ == _loc3_ && _loc5_.data.type == cCPUData.HUB)
                  {
                     _loc5_ = _loc6_;
                     _loc3_ = _loc4_;
                  }
               }
            }
            _loc7_++;
         }
         return _loc5_;
      }
      
      private function findNearestBest(param1:cCPU, param2:Array) : cCPU
      {
         var _loc4_:Number = NaN;
         var _loc6_:cCPU = null;
         var _loc3_:Number = Number.MAX_VALUE;
         var _loc5_:cCPU = null;
         var _loc7_:int = 0;
         while(_loc7_ < param2.length)
         {
            if((_loc6_ = param2[_loc7_] as cCPU) != param1)
            {
               if(lineOfSightCheck(param1,_loc6_))
               {
                  if((_loc4_ = cHelper.distanceSquared(param1.x,param1.y,_loc6_.x,_loc6_.y)) < _loc3_)
                  {
                     _loc5_ = _loc6_;
                     _loc3_ = _loc4_;
                  }
                  else if(_loc4_ == _loc3_ && _loc5_.data.type == cCPUData.HUB)
                  {
                     _loc5_ = _loc6_;
                     _loc3_ = _loc4_;
                  }
               }
            }
            _loc7_++;
         }
         return _loc5_;
      }
      
      private function findNearestWeakest(param1:cCPU, param2:Array) : cCPU
      {
         var _loc5_:Number = NaN;
         var _loc7_:cCPU = null;
         var _loc3_:Number = Number.MAX_VALUE;
         var _loc4_:Number = Number.MAX_VALUE;
         var _loc6_:cCPU = null;
         var _loc8_:int = 0;
         while(_loc8_ < param2.length)
         {
            if((_loc7_ = param2[_loc8_] as cCPU) != param1)
            {
               if(lineOfSightCheck(param1,_loc7_))
               {
                  if((_loc5_ = cHelper.distanceSquared(param1.x,param1.y,_loc7_.x,_loc7_.y)) < _loc3_ && _loc7_.power < _loc4_)
                  {
                     _loc6_ = _loc7_;
                     _loc3_ = _loc5_;
                     _loc4_ == _loc7_.power;
                  }
               }
            }
            _loc8_++;
         }
         return _loc6_;
      }
      
      private function findNearestStrongest(param1:cCPU, param2:Array) : cCPU
      {
         var _loc5_:Number = NaN;
         var _loc7_:cCPU = null;
         var _loc3_:Number = Number.MAX_VALUE;
         var _loc4_:Number = Number.MIN_VALUE;
         var _loc6_:cCPU = null;
         var _loc8_:int = 0;
         while(_loc8_ < param2.length)
         {
            if((_loc7_ = param2[_loc8_] as cCPU) != param1)
            {
               if(lineOfSightCheck(param1,_loc7_))
               {
                  if((_loc5_ = cHelper.distanceSquared(param1.x,param1.y,_loc7_.x,_loc7_.y)) < _loc3_ && _loc7_.power > _loc4_)
                  {
                     _loc6_ = _loc7_;
                     _loc3_ = _loc5_;
                     _loc4_ == _loc7_.power;
                  }
               }
            }
            _loc8_++;
         }
         return _loc6_;
      }
      
      private function sortOnAscendingPower(param1:cCPU, param2:cCPU) : Number
      {
         if(param1.power > param2.power)
         {
            return 1;
         }
         if(param1.power < param2.power)
         {
            return -1;
         }
         return 0;
      }
      
      private function sortOnDecendingPower(param1:cCPU, param2:cCPU) : Number
      {
         if(param1.power < param2.power)
         {
            return 1;
         }
         if(param1.power > param2.power)
         {
            return -1;
         }
         return 0;
      }
      
      private function CollectData() : void
      {
         this.updateLists();
         var _loc1_:cCPU = null;
         this.m_cpuList.sort(this.sortOnAscendingPower);
         var _loc2_:int = 0;
         while(_loc2_ < this.m_cpuList.length)
         {
            _loc1_ = this.m_cpuList[_loc2_] as cCPU;
            this.calculateDefensePower(_loc1_);
            _loc1_.aiData.nearestNeutral = this.findNearestBest(_loc1_,this.m_neutralList);
            _loc1_.aiData.nearestEnemy = this.findNearestWeakest(_loc1_,this.m_enemyList);
            _loc1_.aiData.nearestFriend = this.findNearest(_loc1_,this.m_cpuList);
            _loc1_.aiData.weakestFriend = this.findNearestWeakest(_loc1_,this.m_cpuList);
            do
            {
               _loc1_.aiData.safety = this.updateSafetyAndNeighbours(_loc1_);
               _loc2_++;
            }
            while(false);
            
         }
         this.m_cpuList.sort(this.sortOnDecendingPower);
         _loc2_ = 0;
         while(_loc2_ < this.m_cpuList.length)
         {
            _loc1_ = this.m_cpuList[_loc2_] as cCPU;
            _loc1_.aiData.strongestFriend = this.findNearestStrongest(_loc1_,this.m_cpuList);
            _loc2_++;
         }
      }
      
      private function updateSafetyAndNeighbours(param1:cCPU) : Number
      {
         var _loc2_:Number = NaN;
         var _loc3_:cCPU = null;
         param1.aiData.neighbourList = [];
         var _loc4_:Number = 0;
         var _loc5_:int = 0;
         while(_loc5_ < this.m_cpuList.length)
         {
            _loc3_ = this.m_cpuList[_loc5_] as cCPU;
            if(_loc3_ != param1)
            {
               _loc2_ = cHelper.distanceSquared(param1.x,param1.y,_loc3_.x,_loc3_.y);
               if(_loc2_ < MAX_NEIGHTBOUR_DIST)
               {
                  if(_loc3_.owner == param1.owner)
                  {
                     _loc4_ += 0.25;
                     param1.aiData.neighbourList.push(_loc3_);
                     while(true)
                     {
                     }
                     addr38:
                  }
                  else
                  {
                     _loc4_ -= 0.25;
                  }
               }
            }
            while(true)
            {
               _loc5_++;
               if(true)
               {
                  break;
               }
               §§goto(addr38);
            }
         }
         return _loc4_;
      }
      
      private function MakeDecision() : void
      {
         this.CollectData();
         if(this.m_actionPoints > 0)
         {
            this.Defend();
         }
         if(this.m_actionPoints > 0)
         {
            this.AttackNeutrals();
         }
         if(this.m_actionPoints > 0)
         {
            this.AttackPlayers();
         }
         if(this.m_actionPoints > 0)
         {
            this.CheckSupportConnections();
         }
         if(this.m_actionPoints > 0)
         {
            this.CheckForUpgrades();
         }
      }
      
      private function CheckSupportConnections() : void
      {
         var _loc1_:cCPU = null;
         var _loc2_:cConnection = null;
         var _loc3_:int = 0;
         var _loc4_:cCPU = null;
         var _loc5_:int = 0;
         while(_loc5_ < this.m_cpuList.length)
         {
            _loc1_ = this.m_cpuList[_loc5_] as cCPU;
            _loc3_ = 0;
            while(_loc3_ < _loc1_.connections.length)
            {
               _loc2_ = _loc1_.connections[_loc3_] as cConnection;
               if(!_loc2_.endCPU.underAttack)
               {
                  if(_loc2_.endCPU.aiData.supporterOf.length <= 0)
                  {
                     if(_loc2_.endCPU.owner == _loc2_.startCPU.owner)
                     {
                        §§push(_loc1_.power < _loc1_.data.space * this.m_data.keepPowerThreshold && _loc1_.aiData.safety < this.m_data.keepPowerSafetyThreshold);
                        if(!(_loc1_.power < _loc1_.data.space * this.m_data.keepPowerThreshold && _loc1_.aiData.safety < this.m_data.keepPowerSafetyThreshold))
                        {
                           §§pop();
                           §§push(_loc2_.endCPU.data.space == _loc2_.endCPU.power);
                           if(!(_loc2_.endCPU.data.space == _loc2_.endCPU.power))
                           {
                              §§pop();
                              addr49:
                              while(true)
                              {
                                 §§push(_loc2_.endCPU.aiData.safety >= this.m_data.cutSupportSafetyThreshold);
                              }
                              addr49:
                           }
                        }
                        while(true)
                        {
                           if(§§pop())
                           {
                              _loc1_.cutConnection(_loc2_);
                           }
                           §§goto(addr49);
                        }
                     }
                  }
               }
               while(true)
               {
                  _loc3_++;
                  if(true)
                  {
                     break;
                  }
                  §§goto(addr49);
               }
            }
            if(_loc1_.hasFreeConnection())
            {
               if(_loc1_.power > _loc1_.data.space * this.m_data.keepPowerSafetyThreshold)
               {
                  if((_loc4_ = _loc1_.aiData.weakestFriend) != null && _loc4_.data.upgradeLevel < 2 && _loc4_.aiData.safety < this.m_data.supportThreshold)
                  {
                     this.addConnection(_loc1_,_loc4_,true);
                  }
               }
            }
            _loc5_++;
         }
      }
      
      private function CheckForUpgrades() : void
      {
         var _loc1_:cCPU = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.m_cpuList.length)
         {
            _loc1_ = this.m_cpuList[_loc2_] as cCPU;
            _loc1_.aiData.upgrade = _loc1_.data.space * this.m_data.upgradeThreshold <= _loc1_.power && _loc1_.data.upgradeLevel < 2 && _loc1_.aiData.safety >= this.m_data.upgradeSafety;
            §§push(_loc1_.aiData.upgrade);
            if(_loc1_.aiData.upgrade)
            {
               §§pop();
               while(true)
               {
                  §§push(this.m_actionPoints > 0);
               }
               addr37:
            }
            while(§§pop())
            {
               if(NeoCircuit.DIFFICULTY_EASY == NeoCircuit.DIFFICULTY_EASY)
               {
                  _loc1_.tryUpgrading(this.UPDATE_TIMES_EASY[this.m_difficulty]);
               }
               else
               {
                  _loc1_.tryUpgrading(this.UPDATE_TIMES_HARD[this.m_difficulty]);
                  if(false)
                  {
                     §§goto(addr37);
                     continue;
                  }
               }
               --this.m_actionPoints;
               break;
            }
            _loc2_++;
         }
      }
      
      private function AttackNeutrals() : void
      {
         var _loc1_:cCPU = null;
         var _loc2_:Number = NaN;
         var _loc3_:cCPU = null;
         var _loc4_:int = 0;
         while(_loc4_ < this.m_cpuList.length)
         {
            _loc1_ = this.m_cpuList[_loc4_] as cCPU;
            if(!_loc1_.underAttack)
            {
               if(_loc1_.hasFreeConnection())
               {
                  if(_loc1_.power >= _loc1_.data.space * this.m_data.attackNeutralThreshold)
                  {
                     if(_loc1_.aiData.nearestNeutral != null)
                     {
                        _loc3_ = _loc1_.aiData.nearestNeutral;
                        break;
                     }
                  }
               }
            }
            _loc4_++;
         }
         if(_loc3_ != null)
         {
            this.addConnection(_loc1_,_loc3_);
         }
      }
      
      private function AttackPlayers() : void
      {
         var _loc1_:cCPU = null;
         var _loc2_:Number = NaN;
         var _loc3_:cCPU = null;
         var _loc4_:int = 0;
         while(_loc4_ < this.m_cpuList.length)
         {
            _loc1_ = this.m_cpuList[_loc4_] as cCPU;
            if(!_loc1_.underAttack)
            {
               if(_loc1_.hasFreeConnection())
               {
                  if(_loc1_.aiData.nearestEnemy != null)
                  {
                     if(_loc1_.power >= _loc1_.data.space * this.m_data.attackPlayerThreshold)
                     {
                        _loc3_ = _loc1_.aiData.nearestEnemy;
                        break;
                     }
                  }
               }
            }
            _loc4_++;
         }
         if(_loc3_ != null)
         {
            this.addConnection(_loc1_,_loc3_);
         }
      }
      
      private function Defend() : void
      {
         var _loc1_:cCPU = null;
         var _loc2_:cCPU = null;
         var _loc3_:int = 0;
         var _loc4_:cConnection = null;
         var _loc5_:Array = null;
         var _loc6_:cConnection = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         while(_loc8_ < this.m_underAttack.length)
         {
            _loc1_ = this.m_underAttack[_loc8_] as cCPU;
            _loc5_ = this.GetAttackerConnections(_loc1_);
            _loc7_ = 0;
            while(_loc8_ < _loc5_.length)
            {
               if((_loc6_ = _loc5_[_loc7_] as cConnection).counterConnection == null)
               {
                  this.addConnection(_loc1_,_loc6_.startCPU);
               }
               _loc2_ = this.TryToFindSupportCPU(_loc1_);
               if(_loc2_ != null)
               {
                  _loc1_.aiData.defensePower += _loc2_.power * 0.5;
               }
               if(_loc1_.aiData.defensePower < _loc1_.aiData.attackPower)
               {
                  _loc3_ = 0;
                  while(_loc3_ < _loc1_.connections.length)
                  {
                     if((_loc4_ = _loc1_.connections[_loc3_] as cConnection).counterConnection == null)
                     {
                        _loc1_.cutConnection(_loc4_);
                     }
                     _loc3_++;
                  }
               }
               _loc8_++;
            }
            _loc8_++;
         }
      }
      
      private function GetAttackerConnections(param1:cCPU) : Array
      {
         var _loc3_:cConnection = null;
         var _loc2_:Array = [];
         var _loc4_:int = 0;
         while(_loc4_ < param1.foreignConnections.length)
         {
            _loc3_ = param1.foreignConnections[_loc4_] as cConnection;
            if(_loc3_.startCPU.owner != param1.owner)
            {
               _loc2_.push(_loc3_);
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function TryToFindSupportCPU(param1:cCPU) : cCPU
      {
         var _loc2_:cCPU = null;
         var _loc3_:cCPU = null;
         var _loc4_:Array = null;
         var _loc5_:Number = NaN;
         var _loc6_:int = 0;
         if(param1.aiData.strongestFriend != null)
         {
            if(param1.aiData.strongestFriend.hasFreeConnection())
            {
               if(this.addConnection(param1.aiData.strongestFriend,param1,true))
               {
                  _loc2_ = param1.aiData.strongestFriend;
               }
            }
         }
         if(_loc2_ == null)
         {
            _loc4_ = param1.aiData.neighbourList;
            _loc5_ = 0;
            _loc6_ = 0;
            while(_loc6_ < _loc4_.length)
            {
               _loc3_ = _loc4_[_loc6_] as cCPU;
               if(_loc3_.hasFreeConnection())
               {
                  if(this.addConnection(_loc3_,param1,true))
                  {
                     _loc2_ = _loc3_;
                  }
                  break;
               }
               _loc6_++;
            }
         }
         return _loc2_;
      }
      
      public function addConnection(param1:cCPU, param2:cCPU, param3:Boolean = false) : Boolean
      {
         var _loc4_:int = cConnection.calulcatePowerCost(param1,param2);
         if(!connectable(param1,param2,_loc4_))
         {
            return false;
         }
         if(this.m_actionPoints <= 0)
         {
            return false;
         }
         do
         {
            param1.aiData.supporterOf.push(param2);
            param1.addConnection(param2,_loc4_);
         }
         while(false);
         
         --this.m_actionPoints;
         return true;
      }
      
      public function cutConnection(param1:cCPU, param2:cCPU) : Boolean
      {
         var _loc3_:cCPU = null;
         var _loc5_:cConnection = null;
         if(this.m_actionPoints <= 0)
         {
            return false;
         }
         var _loc4_:int = 0;
         while(true)
         {
            if(_loc4_ >= param1.aiData.supporterOf.length)
            {
               _loc4_ = 0;
               if(true)
               {
                  break;
               }
            }
            else if(param1.aiData.supporterOf[_loc4_] == param2)
            {
               param1.aiData.supporterOf.splice(_loc4_,1);
            }
            _loc4_++;
         }
         while(_loc4_ < param1.connections.length)
         {
            if((_loc5_ = param1.connections[_loc4_] as cConnection).endCPU == param2)
            {
               param1.cutConnection(_loc5_);
            }
            _loc4_++;
         }
         --this.m_actionPoints;
         return true;
      }
   }
}
