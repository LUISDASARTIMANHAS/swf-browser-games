package com.mindgame.framework
{
   import com.mindgame.battleship.Worlds.*;
   
   public class GetColor
   {
      
      private static var getColorThis:GetColor;
       
      
      private var _world:WorldComp;
      
      private var allColor:Array;
      
      public function GetColor()
      {
         this._world = WorldComp.returnWorld;
         this.allColor = this._world.valueStock.allColor;
         super();
         getColorThis = this;
      }
      
      public static function get returnGetColor() : GetColor
      {
         return getColorThis;
      }
      
      public function getRaceColor(param1:int) : int
      {
         if(param1 == 0)
         {
            return this.allColor[0];
         }
         if(param1 == 1)
         {
            return this.allColor[1];
         }
         if(param1 == 2)
         {
            return this.allColor[2];
         }
         if(param1 == 3)
         {
            return this.allColor[3];
         }
         if(param1 == 4)
         {
            return this.allColor[4];
         }
      }
   }
}
