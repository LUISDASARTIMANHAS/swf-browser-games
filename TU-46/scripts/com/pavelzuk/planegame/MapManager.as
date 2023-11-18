package com.pavelzuk.planegame
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="com.pavelzuk.planegame.MapManager")]
   public class MapManager extends Background
   {
       
      
      public var HIT2:MovieClip;
      
      public var planeDistance:Number;
      
      public var HIT:MovieClip;
      
      public var milesRemaining:Number;
      
      public var wrongWayWarning:Boolean = false;
      
      public var map:Array;
      
      public function MapManager()
      {
         this.map = [[0,"trees","treesbg"],[-10,"trees","treesbg"],[-50,"mountains","treesbg"],[-100,"trees","treesbg"],[-120,"grass","treesbg"],[-180,"trees","treesbg"]];
         super();
         addFrameScript(9,this.frame10,19,this.frame20,49,this.frame50);
      }
      
      override public function create(param1:int, param2:int, param3:int, param4:int, param5:Number, param6:String) : void
      {
         count = param4;
         slowDown = param5;
         tileWidth = param3;
         x = tileWidth * param1 - tileWidth;
         y = Controller.level.groundY;
         startX = x;
         startY = y;
         gotoAndStop(param6);
         this.changeFrame(param1);
         Controller.level.plane.checkPlaneX();
         this.checkCity();
      }
      
      public function mapUpdate() : void
      {
         if(Controller.level.plane.startX >= 1000)
         {
            if(Controller.level.gameClip.x / 220 > this.map[5][0])
            {
               gotoAndStop(this.map[5][1]);
               Controller.level.treesGoto = this.map[5][2];
            }
            else if(Controller.level.gameClip.x / 220 > this.map[4][0])
            {
               gotoAndStop(this.map[4][1]);
               Controller.level.treesGoto = this.map[4][2];
            }
            else if(Controller.level.gameClip.x / 220 > this.map[3][0])
            {
               gotoAndStop(this.map[3][1]);
               Controller.level.treesGoto = this.map[3][2];
            }
            else if(Controller.level.gameClip.x / 220 > this.map[2][0])
            {
               gotoAndStop(this.map[2][1]);
               Controller.level.treesGoto = this.map[2][2];
            }
            else if(Controller.level.gameClip.x / 220 > this.map[1][0])
            {
               gotoAndStop(this.map[1][1]);
               Controller.level.treesGoto = this.map[1][2];
            }
            else if(Controller.level.gameClip.x / 220 > this.map[0][0])
            {
               gotoAndStop(this.map[0][1]);
               Controller.level.treesGoto = this.map[0][2];
            }
         }
         if(Controller.level.plane.startX == 0)
         {
            if(Controller.level.gameClip.x / 220 < this.map[5][0])
            {
               gotoAndStop(this.map[5][1]);
               Controller.level.treesGoto = this.map[5][2];
            }
            else if(Controller.level.gameClip.x / 220 < this.map[4][0])
            {
               gotoAndStop(this.map[4][1]);
               Controller.level.treesGoto = this.map[4][2];
            }
            else if(Controller.level.gameClip.x / 220 < this.map[3][0])
            {
               gotoAndStop(this.map[3][1]);
               Controller.level.treesGoto = this.map[3][2];
            }
            else if(Controller.level.gameClip.x / 220 < this.map[2][0])
            {
               gotoAndStop(this.map[2][1]);
               Controller.level.treesGoto = this.map[2][2];
            }
            else if(Controller.level.gameClip.x / 220 < this.map[1][0])
            {
               gotoAndStop(this.map[1][1]);
               Controller.level.treesGoto = this.map[1][2];
            }
            else if(Controller.level.gameClip.x / 220 < this.map[0][0])
            {
               gotoAndStop(this.map[0][1]);
               Controller.level.treesGoto = this.map[0][2];
            }
         }
      }
      
      internal function frame50() : *
      {
         this.gotoAndStop(Math.round(Math.random() * 4 + currentFrame));
      }
      
      override public function update() : void
      {
         this.planeDistance = Math.round(Controller.level.plane.x / 220);
         this.milesRemaining = Math.abs(this.planeDistance - Math.round(Controller.level.map.destinationPort.x / 220));
         if(this.milesRemaining <= 30 && Controller.level.plane.airMessageSaid == false && Controller.level.plane.inAir)
         {
            Controller.level.plane.airportCloseMessage();
         }
         if(Math.abs(this.milesRemaining) <= Math.abs(Tracker.destinationNumFix / 2) && Controller.level.plane.foodMessage == false && Tracker.currentCity !== "tupolev")
         {
            Controller.level.plane.foodMessageF();
         }
         Controller.level.hud.pilotGui.destinationNum.text = String(this.milesRemaining);
         x = Controller.level.gameClip.x * slowDown + startX;
         y = Controller.level.gameClip.y * slowDown + startY;
         if(x < -tileWidth)
         {
            startX += tileWidth * count;
            this.mapUpdate();
         }
         if(x > tileWidth * (count - 1))
         {
            startX -= tileWidth * count;
            this.mapUpdate();
         }
         x = Controller.level.gameClip.x * slowDown + startX;
         y = Controller.level.gameClip.y * slowDown + startY;
      }
      
      public function checkCity() : void
      {
         if(Tracker.currentCity == "tupolev")
         {
            Controller.level.map.airport.gotoAndStop("tupolev");
            this.map = [[0,"grass","treesbg"],[-10,"grass","treesbg"],[-70,"trees","treesbg"],[-100,"trees","treesbg"],[-120,"grass","treesbg"],[-220,"trees","treesbg"]];
            if(Tracker.currentDestination == "russia")
            {
               Controller.level.map.destinationPort.x = Math.round(186 * 220);
               Controller.level.map.destinationPort.gotoAndStop("russia");
            }
         }
         if(Tracker.currentCity == "russia")
         {
            Controller.level.map.airport.gotoAndStop("russia");
            if(Tracker.currentDestination == "uk")
            {
               this.map = [[0,"grass","treesbg"],[15,"trees","treesbg"],[50,"trees","waterbg"],[100,"water","waterbg"],[198,"grass","waterbg"],[228,"trees","waterbg"]];
               Controller.level.map.destinationPort.x = Math.round(Tracker.ukDis * 220);
               Controller.level.map.destinationPort.gotoAndStop("uk");
            }
            else if(Tracker.currentDestination == "japan")
            {
               this.map = [[0,"grass","treesbg"],[-15,"trees","treesbg"],[-400,"mountains","mountainsbg"],[-600,"water","waterbg"],[-650,"grass","waterbg"],[-680,"trees","waterbg"]];
               Controller.level.map.destinationPort.x = Math.round(Tracker.japanDis * 220);
               Controller.level.map.destinationPort.gotoAndStop("japan");
            }
            else if(Tracker.currentDestination == "usa")
            {
               this.map = [[0,"trees","treesbg"],[170,"trees","waterbg"],[180,"water","waterbg"],[660,"trees","waterbg"],[689,"grass","waterbg"],[719,"trees","waterbg"]];
               Controller.level.map.destinationPort.x = Math.round(Tracker.usaDis * 220);
               Controller.level.map.destinationPort.gotoAndStop("usa");
            }
            else if(Tracker.currentDestination == "australia")
            {
               this.map = [[0,"trees","treesbg"],[-180,"trees","waterbg"],[-150,"mountains","mountainsbg"],[-660,"water","waterbg"],[-748,"grass","waterbg"],[-778,"trees","waterbg"]];
               Controller.level.map.destinationPort.x = Math.round(Tracker.australiaDis * 220);
               Controller.level.map.destinationPort.gotoAndStop("australia");
            }
         }
         if(Tracker.currentCity == "uk")
         {
            Controller.level.map.airport.gotoAndStop("uk");
            if(Tracker.currentDestination == "russia")
            {
               this.map = [[0,"trees","waterbg"],[-60,"water","waterbg"],[-90,"grass","treesbg"],[-120,"water","waterbg"],[-198,"grass","waterbg"],[-228,"trees","waterbg"]];
               Controller.level.map.destinationPort.x = Math.round(Tracker.russiaDis * 220);
               Controller.level.map.destinationPort.gotoAndStop("russia");
            }
            else if(Tracker.currentDestination == "japan")
            {
               this.map = [[0,"trees","waterbg"],[-30,"water","waterbg"],[-90,"trees","treesbg"],[-630,"mountains","mountainsbg"],[-850,"grass","waterbg"],[-880,"water","waterbg"]];
               Controller.level.map.destinationPort.x = Math.round(Tracker.japanDis * 220);
               Controller.level.map.destinationPort.gotoAndStop("japan");
            }
            else if(Tracker.currentDestination == "usa")
            {
               this.map = [[0,"trees","waterbg"],[30,"water","waterbg"],[450,"trees","waterbg"],[509,"grass","treesbg"],[539,"trees","treesbg"],[600,"water","waterbg"]];
               Controller.level.map.destinationPort.x = Math.round(Tracker.usaDis * 220);
               Controller.level.map.destinationPort.gotoAndStop("usa");
            }
            else if(Tracker.currentDestination == "brazil")
            {
               this.map = [[0,"trees","waterbg"],[30,"water","waterbg"],[520,"trees","waterbg"],[615,"grass","mountainsbg"],[645,"trees","mountainsbg"],[700,"trees","mountainsbg"]];
               Controller.level.map.destinationPort.x = Math.round(Tracker.brazilDis * 220);
               Controller.level.map.destinationPort.gotoAndStop("brazil");
            }
         }
         if(Tracker.currentCity == "usa")
         {
            Controller.level.map.airport.gotoAndStop("usa");
            if(Tracker.currentDestination == "russia")
            {
               this.map = [[0,"grass","waterbg"],[-60,"water","waterbg"],[-540,"grass","treesbg"],[-609,"trees","treesbg"],[-689,"grass","treesbg"],[-719,"trees","treesbg"]];
               Controller.level.map.destinationPort.x = Math.round(Tracker.russiaDis * 220);
               Controller.level.map.destinationPort.gotoAndStop("russia");
            }
            else if(Tracker.currentDestination == "japan")
            {
               this.map = [[0,"grass","waterbg"],[60,"water","waterbg"],[380,"water","mountainsbg"],[417,"grass","treesbg"],[447,"grass","waterbg"],[500,"water","waterbg"]];
               Controller.level.map.destinationPort.x = Math.round(Tracker.japanDis * 220);
               Controller.level.map.destinationPort.gotoAndStop("japan");
            }
            else if(Tracker.currentDestination == "uk")
            {
               this.map = [[0,"grass","waterbg"],[-60,"water","waterbg"],[-460,"water","treesbg"],[-509,"grass","treesbg"],[-539,"trees","treesbg"],[-550,"water","waterbg"]];
               Controller.level.map.destinationPort.x = Math.round(Tracker.ukDis * 220);
               Controller.level.map.destinationPort.gotoAndStop("uk");
            }
            else if(Tracker.currentDestination == "brazil")
            {
               this.map = [[0,"grass","waterbg"],[-70,"water","waterbg"],[-150,"water","mountainsbg"],[-200,"mountains","mountainsbg"],[-253,"grass","mountainsbg"],[-283,"mountains","mountainsbg"]];
               Controller.level.map.destinationPort.x = Math.round(Tracker.brazilDis * 220);
               Controller.level.map.destinationPort.gotoAndStop("brazil");
            }
            else if(Tracker.currentDestination == "australia")
            {
               this.map = [[0,"grass","waterbg"],[60,"water","waterbg"],[370,"water","treesbg"],[383,"grass","treesbg"],[413,"trees","treesbg"],[500,"water","waterbg"]];
               Controller.level.map.destinationPort.x = Math.round(Tracker.australiaDis * 220);
               Controller.level.map.destinationPort.gotoAndStop("australia");
            }
         }
         if(Tracker.currentCity == "japan")
         {
            Controller.level.map.airport.gotoAndStop("japan");
            if(Tracker.currentDestination == "russia")
            {
               this.map = [[0,"grass","waterbg"],[40,"water","waterbg"],[140,"mountains","mountainsbg"],[220,"trees","treesbg"],[650,"grass","treesbg"],[680,"trees","treesbg"]];
               Controller.level.map.destinationPort.x = Math.round(Tracker.russiaDis * 220);
               Controller.level.map.destinationPort.gotoAndStop("russia");
            }
            else if(Tracker.currentDestination == "australia")
            {
               this.map = [[0,"grass","waterbg"],[-60,"water","waterbg"],[-150,"mountains","treesbg"],[-174,"grass","treesbg"],[-204,"water","waterbg"],[-300,"water","waterbg"]];
               Controller.level.map.destinationPort.x = Math.round(Tracker.australiaDis * 220);
               Controller.level.map.destinationPort.gotoAndStop("australia");
            }
            else if(Tracker.currentDestination == "usa")
            {
               this.map = [[0,"grass","waterbg"],[-40,"water","waterbg"],[-380,"mountains","mountainsbg"],[-417,"grass","treesbg"],[-447,"mountains","treesbg"],[-300,"mountains","treesbg"]];
               Controller.level.map.destinationPort.x = Math.round(Tracker.usaDis * 220);
               Controller.level.map.destinationPort.gotoAndStop("usa");
            }
            else if(Tracker.currentDestination == "brazil")
            {
               this.map = [[0,"grass","waterbg"],[-15,"mountains","treesbg"],[-300,"water","waterbg"],[-400,"mountains","mountainsbg"],[-705,"grass","mountainsbg"],[-735,"mountains","mountainsbg"]];
               Controller.level.map.destinationPort.x = Math.round(Tracker.brazilDis * 220);
               Controller.level.map.destinationPort.gotoAndStop("brazil");
            }
         }
         if(Tracker.currentCity == "brazil")
         {
            Controller.level.map.airport.gotoAndStop("brazil");
            if(Tracker.currentDestination == "uk")
            {
               this.map = [[0,"grass","mountainsbg"],[-15,"mountains","mountainsbg"],[-60,"water","waterbg"],[-580,"trees","treesbg"],[-615,"grass","treesbg"],[-645,"trees","treesbg"]];
               Controller.level.map.destinationPort.x = Math.round(Tracker.ukDis * 220);
               Controller.level.map.destinationPort.gotoAndStop("uk");
            }
            else if(Tracker.currentDestination == "australia")
            {
               this.map = [[0,"grass","mountainsbg"],[15,"mountains","mountainsbg"],[90,"water","waterbg"],[408,"grass","waterbg"],[438,"trees","waterbg"],[500,"water","waterbg"]];
               Controller.level.map.destinationPort.x = Math.round(Tracker.australiaDis * 220);
               Controller.level.map.destinationPort.gotoAndStop("australia");
            }
            else if(Tracker.currentDestination == "usa")
            {
               this.map = [[0,"grass","mountainsbg"],[-15,"mountains","mountainsbg"],[-50,"water","waterbg"],[-108,"grass","treesbg"],[-253,"grass","treesbg"],[-283,"trees","waterbg"]];
               Controller.level.map.destinationPort.x = Math.round(Tracker.usaDis * 220);
               Controller.level.map.destinationPort.gotoAndStop("usa");
            }
            else if(Tracker.currentDestination == "japan")
            {
               this.map = [[0,"grass","mountainsbg"],[15,"mountains","mountainsbg"],[150,"water","waterbg"],[705,"grass","treesbg"],[735,"grass","treesbg"],[800,"water","waterbg"]];
               Controller.level.map.destinationPort.x = Math.round(Tracker.japanDis * 220);
               Controller.level.map.destinationPort.gotoAndStop("japan");
            }
         }
         if(Tracker.currentCity == "australia")
         {
            Controller.level.map.airport.gotoAndStop("australia");
            if(Tracker.currentDestination == "brazil")
            {
               this.map = [[0,"grass","waterbg"],[-25,"water","waterbg"],[-380,"mountains","mountainsbg"],[-408,"mountains","mountainsbg"],[-438,"mountains","mountainsbg"],[-450,"water","waterbg"]];
               Controller.level.map.destinationPort.x = Math.round(Tracker.brazilDis * 220);
               Controller.level.map.destinationPort.gotoAndStop("brazil");
            }
            else if(Tracker.currentDestination == "russia")
            {
               this.map = [[0,"grass","waterbg"],[50,"water","waterbg"],[130,"mountains","waterbg"],[408,"trees","treesbg"],[748,"grass","treesbg"],[778,"trees","treesbg"]];
               Controller.level.map.destinationPort.x = Math.round(Tracker.russiaDis * 220);
               Controller.level.map.destinationPort.gotoAndStop("russia");
            }
            else if(Tracker.currentDestination == "usa")
            {
               this.map = [[0,"grass","waterbg"],[-25,"water","waterbg"],[-360,"mountains","treesbg"],[-383,"grass","treesbg"],[-413,"mountains","treesbg"],[-450,"mountains","treesbg"]];
               Controller.level.map.destinationPort.x = Math.round(Tracker.usaDis * 220);
               Controller.level.map.destinationPort.gotoAndStop("usa");
            }
            else if(Tracker.currentDestination == "japan")
            {
               this.map = [[0,"grass","waterbg"],[25,"water","waterbg"],[174,"grass","treesbg"],[204,"trees","waterbg"],[220,"water","waterbg"],[800,"water","waterbg"]];
               Controller.level.map.destinationPort.x = Math.round(Tracker.japanDis * 220);
               Controller.level.map.destinationPort.gotoAndStop("japan");
            }
         }
      }
      
      internal function frame10() : *
      {
         this.gotoAndStop(Math.round(Math.random() * 4 + currentFrame));
         gotoAndStop(Math.random() * 5 + 10);
      }
      
      internal function frame20() : *
      {
         this.gotoAndStop(Math.round(Math.random() * 4 + currentFrame));
      }
      
      override public function changeFrame(param1:int = 0) : void
      {
      }
   }
}
