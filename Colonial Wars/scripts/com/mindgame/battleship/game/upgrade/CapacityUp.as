package com.mindgame.battleship.game.upgrade
{
   public class CapacityUp extends UpdateTile
   {
       
      
      public function CapacityUp()
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
            _world.upgradeCapacityUp = this.returnSkill();
         }
      }
      
      override protected function upCountSkills() : void
      {
         _world.upgradeCapacityUp = this.returnSkill();
      }
      
      private function returnSkill() : Number
      {
         switch(targetCountUpgrades)
         {
            case 1:
               return 1.1;
            case 2:
               return 1.2;
            case 3:
               return 1.3;
            default:
               return 1;
         }
      }
   }
}
