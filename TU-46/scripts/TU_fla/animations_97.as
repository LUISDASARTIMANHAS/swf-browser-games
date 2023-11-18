package TU_fla
{
   import adobe.utils.*;
   import com.pavelzuk.planegame.Tracker;
   import flash.accessibility.*;
   import flash.desktop.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.sampler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.text.engine.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   
   [Embed(source="/_assets/assets.swf", symbol="TU_fla.animations_97")]
   public dynamic class animations_97 extends MovieClip
   {
       
      
      public var mm:MovieClip;
      
      public var howto:MovieClip;
      
      public function animations_97()
      {
         super();
         addFrameScript(44,this.frame45,99,this.frame100,135,this.frame136,170,this.frame171);
      }
      
      internal function frame100() : *
      {
         stop();
      }
      
      internal function frame171() : *
      {
         stop();
         GameController.transition.playTween(30);
         GameController.transition.playTween(function():*
         {
            var _loc1_:SharedObject = GameController.getSharedObject();
            GameController.timeline.gotoAndStop("game");
            _loc1_.clear();
            _loc1_.data.currentCity = "tupolev";
            _loc1_.close();
         });
         Tracker.continuePlaying = false;
         Tracker.continueGameFromMenu = false;
         Tracker.companyPlayer = "TU AIR";
         Tracker.totalCash = 1000;
         Tracker.totalPassengersDelivered = 0;
         Tracker.totalPassengersInjured = 0;
         Tracker.totalPassengersKilled = 0;
         Tracker.planesRemaining = 15;
         Tracker.playerPoints = 0;
         Tracker.brokenGear = 0;
         Tracker.maxPassengers = 60;
         Tracker.passengersInjured = 0;
         Tracker.passengersArriving = 3;
         Tracker.salary = 2000;
         Tracker.expencesNum = 3000;
         Tracker.howFastInjured = 10;
         Tracker.howEasyJammFlaps = 15;
         Tracker.howEasyJammGear = 6;
         Tracker.overHeatUpgrader = 1000;
         Tracker.extinguishers = 0;
         Tracker.minimumSalary = 0;
         Tracker.engineOffRandomNum = 6000;
         Tracker.ukDis = 0;
         Tracker.russiaDis = 0;
         Tracker.usaDis = 0;
         Tracker.japanDis = 0;
         Tracker.brazilDis = 0;
         Tracker.australiaDis = 0;
         Tracker.salaryNum = 3000;
         Tracker.currentCity = "tupolev";
         Tracker.currentDestination = "russia";
         Tracker.destinationNumFix = 186;
         Tracker.salaryUk = 0;
         Tracker.salaryUsa = 0;
         Tracker.salaryJapan = 0;
         Tracker.salaryRussia = 0;
         Tracker.salaryBrazil = 0;
         Tracker.salaryAustralia = 0;
         Tracker.passengersUk = 0;
         Tracker.passengersUsa = 0;
         Tracker.passengersRussia = 0;
         Tracker.passengersJapan = 0;
         Tracker.passengersBrazil = 0;
         Tracker.passengersAustralia = 0;
         Tracker.company1 = "United Air";
         Tracker.company1delivered = 0;
         Tracker.company1injured = 0;
         Tracker.company1killed = 0;
         Tracker.company1planes = 10;
         Tracker.company1points = 0;
         Tracker.company2 = "Britair";
         Tracker.company2delivered = 0;
         Tracker.company2injured = 0;
         Tracker.company2killed = 0;
         Tracker.company2planes = 10;
         Tracker.company2points = 0;
         Tracker.company3 = "Asia Air";
         Tracker.company3delivered = 0;
         Tracker.company3injured = 0;
         Tracker.company3killed = 0;
         Tracker.company3planes = 10;
         Tracker.company3points = 0;
         Tracker.company4 = "Brasil Air";
         Tracker.company4delivered = 0;
         Tracker.company4injured = 0;
         Tracker.company4killed = 0;
         Tracker.company4planes = 10;
         Tracker.company4points = 0;
         Tracker.company5 = "Australines";
         Tracker.company5delivered = 0;
         Tracker.company5injured = 0;
         Tracker.company5killed = 0;
         Tracker.company5planes = 10;
         Tracker.company5points = 0;
         Tracker.upgrade1 = 1;
         Tracker.upgrade1price = 1500;
         Tracker.upgrade2 = 1;
         Tracker.upgrade2price = 1200;
         Tracker.upgrade3 = 1;
         Tracker.upgrade3price = 2100;
         Tracker.upgrade4 = 1;
         Tracker.upgrade4price = 2400;
         Tracker.upgrade5 = 1;
         Tracker.upgrade5price = 1300;
         Tracker.upgrade6 = 1;
         Tracker.upgrade6price = 500;
         Tracker.ach1 = false;
         Tracker.ach2 = false;
         Tracker.ach3 = false;
         Tracker.ach4 = false;
         Tracker.ach5 = false;
         Tracker.ach6 = false;
         Tracker.ach7 = false;
         Tracker.ach8 = false;
         Tracker.ach9 = false;
         Tracker.ach10 = false;
         Tracker.ach11 = false;
         Tracker.ach12 = false;
      }
      
      internal function frame45() : *
      {
         stop();
      }
      
      internal function frame136() : *
      {
         gotoAndStop(45);
      }
   }
}
