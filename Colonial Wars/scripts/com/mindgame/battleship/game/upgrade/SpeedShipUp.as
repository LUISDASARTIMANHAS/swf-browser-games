package com.mindgame.battleship.game.upgrade
{
   public class SpeedShipUp extends UpdateTile
   {
       
      
      public function SpeedShipUp()
      {
         super();
      }
      
      override public function init() : void
      {
         maxCountUpgrades = 3;
         targetCountUpgrades = 0;
         super.init();
      }
      
      override protected function upSkill() : void
      {
         if(targetCountUpgrades < maxCountUpgrades)
         {
            super.upSkill();
            _world.upgradeSpeedUp = this.returnSkill();
         }
      }
      
      override protected function upCountSkills() : void
      {
         _world.upgradeSpeedUp = this.returnSkill();
      }
      
      private function returnSkill() : Number
      {
         switch(targetCountUpgrades)
         {
            case 1:
               return 1.05;
            case 2:
               return 1.1;
            case 3:
               return 1.2;
            default:
               return 1;
         }
      }
   }
}
