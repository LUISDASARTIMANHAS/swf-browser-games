package com.mindgame.battleship.game.upgrade
{
   public class AllAirplaneUp extends UpdateTile
   {
       
      
      public function AllAirplaneUp()
      {
         super();
      }
      
      override public function init() : void
      {
         maxCountUpgrades = 1;
         targetCountUpgrades = 0;
         super.init();
      }
      
      override protected function upSkill() : void
      {
         if(targetCountUpgrades < maxCountUpgrades)
         {
            super.upSkill();
            _world.upgradeAllAir = this.returnSkill();
         }
      }
      
      override protected function upCountSkills() : void
      {
         _world.upgradeAllAir = this.returnSkill();
      }
      
      private function returnSkill() : Boolean
      {
         switch(targetCountUpgrades)
         {
            case 1:
               return true;
            default:
               return false;
         }
      }
   }
}
