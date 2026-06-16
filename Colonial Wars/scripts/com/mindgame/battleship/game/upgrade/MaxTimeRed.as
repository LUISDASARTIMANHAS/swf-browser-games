package com.mindgame.battleship.game.upgrade
{
   public class MaxTimeRed extends UpdateTile
   {
       
      
      public function MaxTimeRed()
      {
         super();
      }
      
      override public function init() : void
      {
         maxCountUpgrades = 2;
         targetCountUpgrades = 0;
         super.init();
      }
      
      override protected function upSkill() : void
      {
         if(targetCountUpgrades < maxCountUpgrades)
         {
            super.upSkill();
            _world.upgradeMaxTimeRed = this.returnSkill();
         }
      }
      
      override protected function upCountSkills() : void
      {
         _world.upgradeMaxTimeRed = this.returnSkill();
      }
      
      private function returnSkill() : Number
      {
         switch(targetCountUpgrades)
         {
            case 1:
               return 0.9;
            case 2:
               return 0.8;
            default:
               return 1;
         }
      }
   }
}
