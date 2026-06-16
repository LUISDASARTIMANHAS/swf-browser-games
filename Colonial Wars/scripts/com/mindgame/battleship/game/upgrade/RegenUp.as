package com.mindgame.battleship.game.upgrade
{
   public class RegenUp extends UpdateTile
   {
       
      
      public function RegenUp()
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
            this.upCountSkills();
         }
      }
      
      override protected function upCountSkills() : void
      {
         _world.upgradeRegenUp = this.returnSkill();
      }
      
      private function returnSkill() : int
      {
         switch(targetCountUpgrades)
         {
            case 1:
               return 1;
            case 2:
               return 2;
            default:
               return 0;
         }
      }
   }
}
