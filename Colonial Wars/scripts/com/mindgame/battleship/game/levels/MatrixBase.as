package com.mindgame.battleship.game.levels
{
   import com.mindgame.battleship.Worlds.*;
   
   public class MatrixBase
   {
       
      
      private var level:Array;
      
      private var levelStock:LevelStock;
      
      private var parser:MatrixParser;
      
      public function MatrixBase()
      {
         this.levelStock = new LevelStock();
         this.parser = new MatrixParser();
         super();
      }
      
      public function setRandomLelvel() : void
      {
         trace("устанавливаем уровень",WorldComp.targetLevel);
         this.level = this.levelStock.getLevel(WorldComp.targetLevel);
         this.parser.parseMatrix(this.level);
      }
   }
}
