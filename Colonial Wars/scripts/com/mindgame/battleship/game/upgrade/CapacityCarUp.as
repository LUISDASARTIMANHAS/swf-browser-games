package com.mindgame.battleship.game.upgrade
{
   public class CapacityCarUp extends UpdateTile
   {
       
      
      public function CapacityCarUp()
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
            _world.upgradeCapacityCarUp = this.returnSkill();
         }
      }
      
      override protected function upCountSkills() : void
      {
         _world.upgradeCapacityCarUp = this.returnSkill();
      }
      
      private function returnSkill() : Number
      {
         switch(targetCountUpgrades)
         {
            case 1:
               return 0.05;
            case 2:
               return 0.1;
            case 3:
               return 0.15;
            default:
               return 0;
         }
      }
   }
}
