package com.mindgame.battleship.game.upgrade
{
   public class SpeedEnemyRed extends UpdateTile
   {
       
      
      public function SpeedEnemyRed()
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
            _world.upgradeSpeedEnemyRed = this.returnSkill();
         }
      }
      
      override protected function upCountSkills() : void
      {
         _world.upgradeSpeedEnemyRed = this.returnSkill();
      }
      
      private function returnSkill() : Number
      {
         switch(targetCountUpgrades)
         {
            case 1:
               return 0.96;
            case 2:
               return 0.92;
            case 3:
               return 0.8;
            default:
               return 1;
         }
      }
   }
}
