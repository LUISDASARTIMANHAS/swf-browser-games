package com.pavelzuk.planegame
{
   public class Tracker
   {
      
      public static var salaryUk:Number = 0;
      
      public static var usaDis:int = 0;
      
      public static var passengersArriving:int = 3;
      
      public static var passengersInjured:int = 0;
      
      public static var company2killed:uint = 0;
      
      public static var ukDis:int = 0;
      
      public static var mute:Boolean = false;
      
      public static var planesRemaining:* = 15;
      
      public static var company4injured:uint = 0;
      
      public static var company5delivered:uint = 0;
      
      public static var company5points:Number = 0;
      
      public static var upgrade3price:int = 2100;
      
      public static var russiaDis:int = 0;
      
      public static var totalPassengersKilled:uint = 0;
      
      public static var salaryJapan:Number = 0;
      
      public static var destinationNumFix:Number = 186;
      
      public static var passengersAustralia:uint = 0;
      
      public static var ach1:Boolean = false;
      
      public static var company2injured:uint = 0;
      
      public static var passengersJapan:uint = 0;
      
      public static var ach5:Boolean = false;
      
      public static var ach6:Boolean = false;
      
      public static var ach7:Boolean = false;
      
      public static var ach8:Boolean = false;
      
      public static var ach9:Boolean = false;
      
      public static var company3planes:uint = 10;
      
      public static var howEasyJammFlaps:uint = 15;
      
      public static var engineOffRandomNum:int = 6000;
      
      public static var company2points:Number = 0;
      
      public static var expencesNum:uint = 3000;
      
      public static var abandon:Boolean = false;
      
      public static var continueGameFromMenu:Boolean = false;
      
      public static var currentCity:String = "tupolev";
      
      public static var ach3:Boolean = false;
      
      public static var ach4:Boolean = false;
      
      public static var ach2:Boolean = false;
      
      public static var company4killed:uint = 0;
      
      public static var totalCash:int = 1000;
      
      public static var salaryRussia:Number = 0;
      
      public static var japanDis:int = 0;
      
      public static var upgrade4price:int = 2400;
      
      public static var emLand:Boolean = false;
      
      public static var passengersRussia:uint = 0;
      
      public static var company2delivered:uint = 0;
      
      public static var company1killed:uint = 0;
      
      public static var upgrade1price:int = 1500;
      
      public static var currentDestination:String = "russia";
      
      public static var overHeatUpgrader:int = 1000;
      
      public static var salaryAustralia:Number = 0;
      
      public static var australiaDis:int = 0;
      
      public static var company5planes:uint = 10;
      
      public static var howFastInjured:Number = 10;
      
      public static var company4points:Number = 0;
      
      public static var explodeFromFire:Boolean = false;
      
      public static var company5injured:uint = 0;
      
      public static var brokenGear:uint = 0;
      
      public static var company4delivered:uint = 0;
      
      public static var playerPoints:Number = 0;
      
      public static var ach10:Boolean = false;
      
      public static var ach11:Boolean = false;
      
      public static var ach12:Boolean = false;
      
      public static var totalPassengersInjured:uint = 0;
      
      public static var didntLandButDidntDie:Boolean = false;
      
      public static var company2planes:uint = 10;
      
      public static var company1points:Number = 0;
      
      public static var company3injured:uint = 0;
      
      public static var company3killed:uint = 0;
      
      public static var company2:String = "Britair";
      
      public static var company3:String = "Asia Air";
      
      public static var company4:String = "Brasil Air";
      
      public static var company5:String = "Australines";
      
      public static var salaryUsa:Number = 0;
      
      public static var company1:String = "United Air";
      
      public static var salaryNum:int = 3000;
      
      public static var upgrade5price:int = 1300;
      
      public static var upgrade2price:int = 1200;
      
      public static var minimumSalary:int = 0;
      
      public static var brazilDis:int = 0;
      
      public static var continuePlaying:Boolean = false;
      
      public static var company1injured:uint = 0;
      
      public static var totalPassengersDelivered:uint = 0;
      
      public static var passengersUk:uint = 0;
      
      public static var upgrade1:int = 1;
      
      public static var upgrade2:int = 1;
      
      public static var upgrade3:int = 1;
      
      public static var upgrade4:int = 1;
      
      public static var upgrade5:int = 1;
      
      public static var upgrade6:int = 1;
      
      public static var extinguishers:int = 0;
      
      public static var maxPassengers:uint = 60;
      
      public static var company4planes:uint = 10;
      
      public static var passengersUsa:uint = 0;
      
      public static var company1delivered:uint = 0;
      
      public static var company3points:Number = 0;
      
      public static var companyPlayer:String = "TU AIR";
      
      public static var salary:int = 2000;
      
      public static var weatherArr:Array = ["Fog","Clouds","Fine","Fine","Rain","Rain","Fine","Fine"];
      
      public static var company5killed:uint = 0;
      
      public static var salaryBrazil:Number = 0;
      
      public static var howEasyJammGear:uint = 6;
      
      public static var died:Boolean = false;
      
      public static var weatherRandomized:String = "Fine";
      
      public static var company1planes:uint = 10;
      
      public static var passengersBrazil:uint = 0;
      
      public static var company3delivered:uint = 0;
      
      public static var upgrade6price:int = 500;
       
      
      public function Tracker()
      {
         super();
      }
      
      public static function saveInfo() : *
      {
         passengersInjured = Controller.level.passengersInjured;
         minimumSalary = Controller.level.minimumSalary;
      }
   }
}
