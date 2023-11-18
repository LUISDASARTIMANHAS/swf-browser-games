package com.pavelzuk.planegame
{
   public class BackgroundManager
   {
       
      
      public var bgArray:Array;
      
      public var theme:String = "Mountains";
      
      public var bgSky:Background;
      
      public function BackgroundManager()
      {
         this.bgArray = [];
         super();
      }
      
      public function update() : void
      {
         var _loc1_:Background = null;
         this.bgSky.y = Controller.level.groundY + Controller.level.gameClip.y;
         for each(_loc1_ in this.bgArray)
         {
            _loc1_.update();
         }
      }
      
      public function create(param1:String) : void
      {
         var _loc2_:int = 0;
         this.bgSky = new Bg();
         Controller.level.bgClip.addChild(this.bgSky);
         this.bgSky.x = 0;
         this.theme = param1;
         _loc2_ = 0;
         while(_loc2_ < 2)
         {
            this.addBackGround(_loc2_,3,2);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 2)
         {
            this.addBackGround(_loc2_,1,2);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            this.addBackGround(_loc2_,2,2);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 2)
         {
            this.addBackGround(_loc2_,4,2);
            _loc2_++;
         }
      }
      
      private function addBackGround(param1:Number, param2:int, param3:int) : void
      {
         var _loc4_:Background = null;
         if(param2 == 1)
         {
            (_loc4_ = new Ground()).create(param1,Controller.level.groundY,670,param3,1,this.theme);
         }
         else if(param2 == 2)
         {
            (_loc4_ = new Cloud()).create(param1,Controller.level.groundY,1400,param3,0.6,this.theme);
         }
         else if(param2 == 3)
         {
            (_loc4_ = new Trees()).create(param1,Controller.level.groundY,670,param3,0.3,this.theme);
         }
         else if(param2 == 4)
         {
            (_loc4_ = new MapManager()).create(param1,Controller.level.groundY,900,param3,1,this.theme);
         }
         Controller.level.bgClip.addChild(_loc4_);
         this.bgArray.push(_loc4_);
      }
   }
}
