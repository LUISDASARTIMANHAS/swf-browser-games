package com.mindgame.battleship.game
{
   import com.mindgame.battleship.Worlds.WorldComp;
   import com.mindgame.battleship.game.barriers.*;
   import com.mindgame.battleship.game.ship.*;
   import com.mindgame.battleship.game.ui.*;
   import com.mindgame.battleship.game.upgrade.*;
   import com.mindgame.framework.*;
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class ValueStock
   {
       
      
      private var xml:XML;
      
      private var loader:URLLoader;
      
      private var request:URLRequest;
      
      public var speedship:int;
      
      public var allColor:Array;
      
      public var size1:int;
      
      public var size2:int;
      
      public var debug:Boolean;
      
      public var level:int;
      
      public var moneyStart:int;
      
      public var tooltipTime:int;
      
      public var tooltipTimeUpgrade:int;
      
      public var _world:WorldComp;
      
      public function ValueStock()
      {
         super();
         this.xml = <xml>
				<values>
				//Необходимо ли показывать, рисовать курги/линии и т.п для отладки. 0 - не надо, 1 - надо
				<debug>0</debug>
				
				
				//начальное количество денег
				<moneyStart>200000</moneyStart>
				
				//скорость передвижения
				<shipspeed>24</shipspeed>
				
				//размер для текста всплывающих цифр
				<size1>15</size1>
				
				//толщина линии бегающей за мышкой
				<thicness>3</thicness>
				//цвет линии бегающей за мышкой
				<colorLine>0xFFFFFF</colorLine>
				//цвет линии бегающей за мышкой
				<colorTrueLine>0xBB930F</colorTrueLine>
				//длина 1 черточки
				<dashLength>4</dashLength>
				//расстояние между черточками
				<gapLength>5</gapLength>
				//скорость движения пунктирчиков. Больше нуля.
				<shift>0.4</shift>
				//скорость убирания черточек
				<percentStep>0.03</percentStep>
				
				//время появления подсказок 1 секунда == 35
				<tooltipTime>12</tooltipTime>
				//время появления подсказок 1 секунда == 35
				<tooltipTimeUpgrade>5</tooltipTimeUpgrade>
				
				//время скрытия экрана паузы
				<pauseDeleteTime>0.4</pauseDeleteTime>
				//время появления экрана паузы
				<pauseAddTime>1</pauseAddTime>
				
				////////////////////////////////
				//Имена кланов
				<player>Player</player>
				<neutral>Neutral</neutral>
				<cpu1>J. Anson</cpu1>
				<cpu2>R. Byrd</cpu2>
				<cpu3>N. Horat</cpu3>
				
				//Текста подсказок в апгрейд шопе
				<allAirplaneUpText>All of the player's ships are transformed into aircrafts and speed increased by 20%!</allAirplaneUpText>
				<capacityCarUpText>The player's ships capacity is increased by up to 55%/60%/70% in accordance with the island's population.</capacityCarUpText>
				<capacityUpText>The player's islands capacity is increased by 5%/10%/15%.</capacityUpText>
				<maxTimeRedText>The time spent on finishing a level is artificially decreased by 10%/20%.</maxTimeRedText>
				<regenUpText>Population increase on all of the player's islands is up by 1/2 units per second.</regenUpText>
				<speedEnemyRedText>The speed of all the enemy's transport is decreased by 4%/8%/20%.</speedEnemyRedText>
				<speedShipUpText>The speed of all the player's transport is increased by 5%/10%/20%.</speedShipUpText>
				//размер текста подсказок
				<upgradeTextSize>13</upgradeTextSize>
				
				//скорость вращения в водовороте			
				<washoutRate>0.1</washoutRate>
				//скорость приближения корабля к центру водоворота
				<shiftRate>0.25</shiftRate>
				
				//скорость вращения водоворота
				<rotateSpeed>2</rotateSpeed>
				
				//размер текста для островов
				<size2>15</size2>
				//цвет для нейтральных
				<color0>0xB1ACA4</color0>
				//цвет для игрока
				<color1>0xE72E32</color1>
				//цвет для бота 1
				<color2>0x39C400</color2>
				//цвет для бота 2
				<color3>0x00CCFF</color3>
				//цвет для бота 3
				<color4>0x9C17B6</color4> 
				</values>
				</xml>;
      }
      
      public function setValues() : void
      {
         var setValuess:* = function(param1:Event = null):void
         {
            speedship = int(xml.values.shipspeed);
            size1 = int(xml.values.size1);
            allColor = [int(xml.values.color0),int(xml.values.color1),int(xml.values.color2),int(xml.values.color3),int(xml.values.color4)];
            size2 = int(xml.values.size2);
            tooltipTime = int(xml.values.tooltipTime);
            tooltipTimeUpgrade = int(xml.values.tooltipTimeUpgrade);
            ShipBase.speedShip = int(xml.values.shipspeed);
            _world.colorLine = int(xml.values.colorLine);
            _world.colorTrueLine = int(xml.values.colorTrueLine);
            _world.thicness = int(xml.values.thicness);
            DottedLine.DASH_LENGTH = int(xml.values.dashLength);
            DottedLine.GAP_LENGTH = int(xml.values.gapLength);
            DottedLine.percentStep = Number(xml.values.percentStep);
            _world.shift = Number(xml.values.shift);
            _world.playerClan = String(xml.values.player);
            _world.neutralClan = String(xml.values.neutral);
            _world.cpu1Clan = String(xml.values.cpu1);
            _world.cpu2Clan = String(xml.values.cpu2);
            _world.cpu3Clan = String(xml.values.cpu3);
            UpgradeShop.allAirplaneUpText = String(xml.values.allAirplaneUpText);
            UpgradeShop.capacityCarUpText = String(xml.values.capacityCarUpText);
            UpgradeShop.capacityUpText = String(xml.values.capacityUpText);
            UpgradeShop.maxTimeRedText = String(xml.values.maxTimeRedText);
            UpgradeShop.regenUpText = String(xml.values.regenUpText);
            UpgradeShop.speedEnemyRedText = String(xml.values.speedEnemyRedText);
            UpgradeShop.speedShipUpText = String(xml.values.speedShipUpText);
            UpgradeTooltip.textSize = int(xml.values.upgradeTextSize);
            _world.pauseAddTime = Number(xml.values.pauseAddTime);
            _world.pauseDeleteTime = Number(xml.values.pauseDeleteTime);
            _world.washoutRate = Number(xml.values.washoutRate);
            _world.shiftRate = Number(xml.values.shiftRate);
            Whirlpool.rotateSpeed = Number(xml.values.rotateSpeed);
            _world.init();
         };
         setValuess();
      }
   }
}
