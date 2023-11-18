package TU_fla
{
   import adobe.utils.*;
   import com.pavelzuk.components.Transition;
   import com.pavelzuk.planegame.Controller;
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
   
   public dynamic class MainTimeline extends MovieClip
   {
       
      
      public var salaryUk:Number;
      
      public var loader:MovieClip;
      
      public var armorBtn:SimpleButton;
      
      public var welcomeToRandom:Array;
      
      public var salaryRussia:Number;
      
      public var transition:Transition;
      
      public var salaryBrazil:Number;
      
      public var win:MovieClip;
      
      public var salaryAustralia:Number;
      
      public var lpc:TextField;
      
      public var over:MovieClip;
      
      public var salaryUsa:Number;
      
      public var salaryJapan:Number;
      
      public var animations:MovieClip;
      
      public var newsPaper:MovieClip;
      
      public function MainTimeline()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,5,this.frame6,8,this.frame9,9,this.frame10,14,this.frame15,29,this.frame30,30,this.frame31);
      }
      
      public function toMapF(param1:MouseEvent) : void
      {
         if(this.animations.currentFrame == 275 || this.animations.currentFrame == 276)
         {
            this.animations.gotoAndPlay("toMapLabel");
            this.animations.map.bcBtn.addEventListener(MouseEvent.CLICK,this.backFromMapF);
         }
      }
      
      public function firstWindowF() : void
      {
         var payforInjuries:* = undefined;
         var expences:* = undefined;
         var moneyPlus:* = undefined;
         var okayStatsF:Function = null;
         okayStatsF = function(param1:MouseEvent):void
         {
            if(animations.currentFrame == 1)
            {
               animations.gotoAndPlay(225);
               animations.quickStats.okayBtn.removeEventListener(MouseEvent.CLICK,okayStatsF);
            }
         };
         this.animations.quickStats.welcometo.text = String(this.welcomeToRandom[int(Math.random() * this.welcomeToRandom.length)]);
         this.animations.quickStats.salaryTxt.text = String("$ " + Tracker.salary);
         this.animations.quickStats.passengersArrivedTxt.text = String(Tracker.passengersArriving);
         if(Tracker.continueGameFromMenu == false && Tracker.abandon == false && Tracker.died == false && Tracker.didntLandButDidntDie == false && Tracker.explodeFromFire == false && Tracker.emLand == false)
         {
            Tracker.totalPassengersDelivered += Tracker.passengersArriving;
         }
         if(Tracker.passengersInjured > Tracker.passengersArriving)
         {
            Tracker.passengersInjured = Tracker.passengersArriving;
         }
         if(Tracker.continueGameFromMenu == false && Tracker.abandon == false && Tracker.died == false && Tracker.didntLandButDidntDie == false && Tracker.explodeFromFire == false && Tracker.emLand == false)
         {
            Tracker.totalPassengersInjured += Tracker.passengersInjured;
         }
         payforInjuries = Tracker.passengersInjured * 150;
         if(Tracker.passengersInjured > 0)
         {
            this.animations.quickStats.passengersInjuredTxt.text = String(Tracker.passengersInjured + " ( - $ " + payforInjuries + " )");
         }
         else
         {
            this.animations.quickStats.passengersInjuredTxt.text = String(Tracker.passengersInjured);
         }
         trace(Tracker.destinationNumFix * 2);
         expences = Math.round(Tracker.brokenGear + Math.abs(Tracker.destinationNumFix) * 2 + payforInjuries + Math.random() * Tracker.expencesNum);
         Tracker.brokenGear = 0;
         moneyPlus = Tracker.salary - expences;
         if(Tracker.continueGameFromMenu == false && Tracker.abandon == false && Tracker.died == false && Tracker.didntLandButDidntDie == false && Tracker.explodeFromFire == false && Tracker.emLand == false)
         {
            Tracker.totalCash += moneyPlus;
         }
         this.animations.quickStats.expencesTxt.text = String("$ " + expences);
         this.animations.quickStats.totalCash.text = String("$ " + Tracker.totalCash);
         this.animations.quickStats.okayBtn.addEventListener(MouseEvent.CLICK,okayStatsF);
      }
      
      public function armorBtnF2(param1:MouseEvent) : void
      {
         navigateToURL(new URLRequest("http://www.armorgames.com/"),"_blank");
      }
      
      public function australiaBtnF(param1:MouseEvent) : void
      {
         Tracker.salary = this.salaryAustralia;
         this.animations.map.confirm.x = 0;
         this.animations.map.confirm.y = 0;
         this.animations.map.confirm.miles.text = String(Math.abs(Tracker.australiaDis));
         Tracker.destinationNumFix = Tracker.australiaDis;
         this.animations.map.confirm.salary.text = String(Tracker.salary);
         Tracker.currentDestination = "australia";
         this.animations.map.confirm.passengers.text = String(Tracker.passengersAustralia);
         Tracker.passengersArriving = Tracker.passengersAustralia;
      }
      
      internal function frame31() : *
      {
         this.newsPaper.paper.delivered.text = String(Tracker.totalPassengersDelivered);
         this.newsPaper.paper.injured.text = String(Tracker.totalPassengersInjured);
         this.newsPaper.paper.killed.text = String(Tracker.totalPassengersKilled);
         this.newsPaper.paper.okayBtn.addEventListener(MouseEvent.CLICK,this.newsOkayF2);
      }
      
      public function confirmDestBtnF(param1:MouseEvent) : void
      {
         this.removeListeners();
         GameController.transition.playTween("game");
         this.animations.map.confirm.confirmBtn.removeEventListener(MouseEvent.CLICK,this.confirmDestBtnF);
      }
      
      public function usaBtnF(param1:MouseEvent) : void
      {
         Tracker.salary = this.salaryUsa;
         this.animations.map.confirm.x = 0;
         this.animations.map.confirm.y = 0;
         this.animations.map.confirm.miles.text = String(Math.abs(Tracker.usaDis));
         Tracker.destinationNumFix = Tracker.usaDis;
         this.animations.map.confirm.salary.text = String(Tracker.salary);
         Tracker.currentDestination = "usa";
         this.animations.map.confirm.passengers.text = String(Tracker.passengersUsa);
         Tracker.passengersArriving = Tracker.passengersUsa;
      }
      
      public function saveGame() : void
      {
         var _loc1_:SharedObject = GameController.getSharedObject();
         _loc1_.data.continuePlaying = Tracker.continuePlaying;
         _loc1_.data.totalCash = Tracker.totalCash;
         _loc1_.data.totalPassengersDelivered = Tracker.totalPassengersDelivered;
         _loc1_.data.totalPassengersInjured = Tracker.totalPassengersInjured;
         _loc1_.data.totalPassengersKilled = Tracker.totalPassengersKilled;
         _loc1_.data.planesRemaining = Tracker.planesRemaining;
         _loc1_.data.maxPassengers = Tracker.maxPassengers;
         _loc1_.data.passengersInjured = Tracker.passengersInjured;
         _loc1_.data.passengersArriving = Tracker.passengersArriving;
         _loc1_.data.salary = Tracker.salary;
         _loc1_.data.expencesNum = Tracker.expencesNum;
         _loc1_.data.howFastInjured = Tracker.howFastInjured;
         _loc1_.data.howEasyJammFlaps = Tracker.howEasyJammFlaps;
         _loc1_.data.howEasyJammGear = Tracker.howEasyJammGear;
         _loc1_.data.overHeatUpgrader = Tracker.overHeatUpgrader;
         _loc1_.data.extinguishers = Tracker.extinguishers;
         _loc1_.data.minimumSalary = Tracker.minimumSalary;
         _loc1_.data.engineOffRandomNum = Tracker.engineOffRandomNum;
         _loc1_.data.ukDis = Tracker.ukDis;
         _loc1_.data.russiaDis = Tracker.russiaDis;
         _loc1_.data.usaDis = Tracker.usaDis;
         _loc1_.data.japanDis = Tracker.japanDis;
         _loc1_.data.brazilDis = Tracker.brazilDis;
         _loc1_.data.australiaDis = Tracker.australiaDis;
         _loc1_.data.salaryNum = Tracker.salaryNum;
         _loc1_.data.currentCity = Tracker.currentCity;
         _loc1_.data.currentDestination = Tracker.currentDestination;
         _loc1_.data.destinationNumFix = Tracker.destinationNumFix;
         _loc1_.data.salaryUk = Tracker.salaryUk;
         _loc1_.data.salaryUsa = Tracker.salaryUsa;
         _loc1_.data.salaryJapan = Tracker.salaryJapan;
         _loc1_.data.salaryRussia = Tracker.salaryRussia;
         _loc1_.data.salaryBrazil = Tracker.salaryBrazil;
         _loc1_.data.salaryAustralia = Tracker.salaryAustralia;
         _loc1_.data.passengersUk = Tracker.passengersUk;
         _loc1_.data.passengersUsa = Tracker.passengersUsa;
         _loc1_.data.passengersRussia = Tracker.passengersRussia;
         _loc1_.data.passengersJapan = Tracker.passengersJapan;
         _loc1_.data.passengersBrazil = Tracker.passengersBrazil;
         _loc1_.data.passengersAustralia = Tracker.passengersAustralia;
         _loc1_.data.company1delivered = Tracker.company1delivered;
         _loc1_.data.company1injured = Tracker.company1injured;
         _loc1_.data.company1killed = Tracker.company1killed;
         _loc1_.data.company1planes = Tracker.company1planes;
         _loc1_.data.company1points = Tracker.company1points;
         _loc1_.data.company2delivered = Tracker.company2delivered;
         _loc1_.data.company2injured = Tracker.company2injured;
         _loc1_.data.company2killed = Tracker.company2killed;
         _loc1_.data.company2planes = Tracker.company2planes;
         _loc1_.data.company2points = Tracker.company2points;
         _loc1_.data.company3delivered = Tracker.company3delivered;
         _loc1_.data.company3injured = Tracker.company3injured;
         _loc1_.data.company3killed = Tracker.company3killed;
         _loc1_.data.company3planes = Tracker.company3planes;
         _loc1_.data.company3points = Tracker.company3points;
         _loc1_.data.company4delivered = Tracker.company4delivered;
         _loc1_.data.company4injured = Tracker.company4injured;
         _loc1_.data.company4killed = Tracker.company4killed;
         _loc1_.data.company4planes = Tracker.company4planes;
         _loc1_.data.company4points = Tracker.company4points;
         _loc1_.data.company5delivered = Tracker.company5delivered;
         _loc1_.data.company5injured = Tracker.company5injured;
         _loc1_.data.company5killed = Tracker.company5killed;
         _loc1_.data.company5planes = Tracker.company5planes;
         _loc1_.data.company5points = Tracker.company5points;
         _loc1_.data.upgrade1 = Tracker.upgrade1;
         _loc1_.data.upgrade1price = Tracker.upgrade1price;
         _loc1_.data.upgrade2 = Tracker.upgrade2;
         _loc1_.data.upgrade2price = Tracker.upgrade2price;
         _loc1_.data.upgrade3 = Tracker.upgrade3;
         _loc1_.data.upgrade3price = Tracker.upgrade3price;
         _loc1_.data.upgrade4 = Tracker.upgrade4;
         _loc1_.data.upgrade4price = Tracker.upgrade4price;
         _loc1_.data.upgrade5 = Tracker.upgrade5;
         _loc1_.data.upgrade5price = Tracker.upgrade5price;
         _loc1_.data.upgrade6 = Tracker.upgrade6;
         _loc1_.data.upgrade6price = Tracker.upgrade6price;
         _loc1_.data.ach1 = Tracker.ach1;
         _loc1_.data.ach2 = Tracker.ach2;
         _loc1_.data.ach3 = Tracker.ach3;
         _loc1_.data.ach4 = Tracker.ach4;
         _loc1_.data.ach5 = Tracker.ach5;
         _loc1_.data.ach6 = Tracker.ach6;
         _loc1_.data.ach7 = Tracker.ach7;
         _loc1_.data.ach8 = Tracker.ach8;
         _loc1_.data.ach9 = Tracker.ach9;
         _loc1_.data.ach10 = Tracker.ach10;
         _loc1_.data.ach11 = Tracker.ach11;
         _loc1_.data.ach12 = Tracker.ach12;
         _loc1_.close();
      }
      
      public function japanBtnF(param1:MouseEvent) : void
      {
         Tracker.salary = this.salaryJapan;
         this.animations.map.confirm.x = 0;
         this.animations.map.confirm.y = 0;
         this.animations.map.confirm.miles.text = String(Math.abs(Tracker.japanDis));
         Tracker.destinationNumFix = Tracker.japanDis;
         this.animations.map.confirm.salary.text = String(Tracker.salary);
         Tracker.currentDestination = "japan";
         this.animations.map.confirm.passengers.text = String(Tracker.passengersJapan);
         Tracker.passengersArriving = Tracker.passengersJapan;
      }
      
      internal function frame30() : *
      {
         this.over.mouseEnabled = false;
         if(Tracker.continueGameFromMenu == false && Tracker.abandon == false && Tracker.died == false && Tracker.didntLandButDidntDie == false && Tracker.explodeFromFire == false && Tracker.emLand == false)
         {
            Tracker.currentCity = Tracker.currentDestination;
         }
         this.newsPaperF();
         this.saveGame();
         this.animations.armorBtn.addEventListener(MouseEvent.CLICK,this.armorBtnF2);
         if(Tracker.currentDestination == "russia")
         {
            this.welcomeToRandom = ["St.Petersburg","Moscow","Sochi","Vladivostok","Novosibirsk","Yekaterinburg","Nizhny Novgorod","Samara","Kazan","Omsk","Chelyabinsk","Rostov-on-Don","Ufa","Volgograd"];
         }
         else if(Tracker.currentDestination == "usa")
         {
            this.welcomeToRandom = ["New York","Los Angeles","Chicago","Dallas","Philadelphia","Houston","Washington, D.C.","Miami","Atlanta","Boston"];
         }
         else if(Tracker.currentDestination == "uk")
         {
            this.welcomeToRandom = ["London","Birmingham","Glasgow","Liverpool","Leeds","Sheffield","Edinburgh","Bristol","Manchester","Leicester"];
         }
         else if(Tracker.currentDestination == "japan")
         {
            this.welcomeToRandom = ["Tokyo","Yokohama","Osaka","Nagoya","Sapporo","Kōbe","Kyōto","Fukuoka","Kawasaki","Saitama","Hiroshima","Sendai","Kitakyūshū","Chiba","Sakai"];
         }
         else if(Tracker.currentDestination == "brazil")
         {
            this.welcomeToRandom = ["São Paulo","Rio de Janeiro","Salvador","Brasília","Fortaleza","Belo Horizonte","Manaus","Curitiba","Recife","Porto Alegre","Belém","Goiânia","Guarulhos","Campinas","São Luís"];
         }
         else if(Tracker.currentDestination == "australia")
         {
            this.welcomeToRandom = ["Sydney","Melbourne","Brisbane","Perth","Newcastle"];
         }
         this.salaryUk = 0;
         this.salaryUsa = 0;
         this.salaryJapan = 0;
         this.salaryRussia = 0;
         this.salaryBrazil = 0;
         this.salaryAustralia = 0;
         this.newsPaper.paper.okayBtn.addEventListener(MouseEvent.CLICK,this.newsOkayF);
         if(Tracker.abandon == false)
         {
            this.firstWindowF();
         }
         else if(Tracker.died == false)
         {
            this.firstWindowF();
         }
         this.animations.threeBtns.mapBtn.addEventListener(MouseEvent.CLICK,this.toMapF);
         this.animations.threeBtns.statsBtn.addEventListener(MouseEvent.CLICK,this.toStatsF);
         this.animations.threeBtns.shopBtn.addEventListener(MouseEvent.CLICK,this.toShopF);
         if(Tracker.abandon == true)
         {
            Tracker.totalCash -= 1000;
            this.animations.gotoAndStop(275);
            Tracker.abandon = false;
         }
         else if(Tracker.died == true || Tracker.explodeFromFire == true)
         {
            if(Tracker.planesRemaining > 0)
            {
               --Tracker.planesRemaining;
               Tracker.totalPassengersKilled += Tracker.passengersArriving;
               Tracker.totalCash -= 1000;
               this.animations.gotoAndStop(275);
               Tracker.died = false;
            }
            else
            {
               gotoAndStop("looseGameLabel");
            }
         }
         else if(Tracker.didntLandButDidntDie == true)
         {
            Tracker.totalCash -= 1000;
            this.animations.gotoAndStop(275);
            Tracker.didntLandButDidntDie = false;
         }
         else if(Tracker.continueGameFromMenu == true)
         {
            this.animations.gotoAndStop(275);
            this.newsPaper.gotoAndStop(1);
            this.newsPaper.paper.okayBtn.removeEventListener(MouseEvent.CLICK,this.newsOkayF);
            Tracker.continueGameFromMenu = false;
         }
      }
      
      public function siteLock() : void
      {
         var _loc1_:String = String(stage.loaderInfo.url);
         var _loc2_:Number = _loc1_.indexOf("://") + 3;
         var _loc3_:Number = Number(_loc1_.indexOf("/",_loc2_));
         var _loc4_:String;
         var _loc5_:Number = (_loc4_ = String(_loc1_.substring(_loc2_,_loc3_))).lastIndexOf(".") - 1;
         var _loc6_:Number = _loc4_.lastIndexOf(".",_loc5_) + 1;
         if((_loc4_ = String(_loc4_.substring(_loc6_,_loc4_.length))) != "armorgames.com")
         {
            gotoAndStop(9);
         }
         else
         {
            gotoAndStop(9);
         }
      }
      
      public function pmgBtnF(param1:MouseEvent) : void
      {
         navigateToURL(new URLRequest("http://armorgames.com"),"_blank");
      }
      
      public function backFromStatsF(param1:MouseEvent) : void
      {
         this.animations.gotoAndPlay("backfromStatsLabel");
         this.animations.map.bcBtn.removeEventListener(MouseEvent.CLICK,this.backFromStatsF);
      }
      
      public function removeListeners() : *
      {
         this.animations.threeBtns.mapBtn.removeEventListener(MouseEvent.CLICK,this.toMapF);
         this.animations.threeBtns.statsBtn.removeEventListener(MouseEvent.CLICK,this.toStatsF);
         this.animations.map.confirm.cancelBtn.removeEventListener(MouseEvent.CLICK,this.cancelDestBtnF);
         this.animations.map.russiaBtn.removeEventListener(MouseEvent.CLICK,this.russiaBtnF);
         this.animations.map.usaBtn.removeEventListener(MouseEvent.CLICK,this.usaBtnF);
         this.animations.map.ukBtn.removeEventListener(MouseEvent.CLICK,this.ukBtnF);
         this.animations.map.japanBtn.removeEventListener(MouseEvent.CLICK,this.japanBtnF);
         this.animations.map.brazilBtn.removeEventListener(MouseEvent.CLICK,this.brazilBtnF);
         this.animations.map.australiaBtn.removeEventListener(MouseEvent.CLICK,this.australiaBtnF);
         this.animations.armorBtn.removeEventListener(MouseEvent.CLICK,this.armorBtnF2);
      }
      
      public function newsOkayF(param1:MouseEvent) : void
      {
         if(this.newsPaper.currentFrame == 60)
         {
            this.newsPaper.gotoAndPlay(61);
            this.checkWin();
         }
      }
      
      public function ukBtnF(param1:MouseEvent) : void
      {
         Tracker.salary = this.salaryUk;
         this.animations.map.confirm.x = 0;
         this.animations.map.confirm.y = 0;
         this.animations.map.confirm.miles.text = String(Math.abs(Tracker.ukDis));
         Tracker.destinationNumFix = Tracker.ukDis;
         this.animations.map.confirm.salary.text = String(Tracker.salary);
         Tracker.currentDestination = "uk";
         this.animations.map.confirm.passengers.text = String(Tracker.passengersUk);
         Tracker.passengersArriving = Tracker.passengersUk;
      }
      
      public function mapFunctions() : void
      {
         this.statsFunctions();
         this.shopFunctions();
         this.animations.map.confirm.cancelBtn.addEventListener(MouseEvent.CLICK,this.cancelDestBtnF);
         this.animations.map.confirm.confirmBtn.addEventListener(MouseEvent.CLICK,this.confirmDestBtnF);
         this.animations.map.confirm.weather.text = String(Tracker.weatherArr[int(Math.random() * Tracker.weatherArr.length)]);
         Tracker.weatherRandomized = this.animations.map.confirm.weather.text;
         Tracker.passengersUk = Math.random() * Tracker.maxPassengers + 20;
         if(Tracker.passengersUk > Tracker.maxPassengers)
         {
            Tracker.passengersUk = Tracker.maxPassengers;
         }
         Tracker.passengersUsa = Math.random() * Tracker.maxPassengers + 20;
         if(Tracker.passengersUsa > Tracker.maxPassengers)
         {
            Tracker.passengersUsa = Tracker.maxPassengers;
         }
         Tracker.passengersRussia = Math.random() * Tracker.maxPassengers + 20;
         if(Tracker.passengersRussia > Tracker.maxPassengers)
         {
            Tracker.passengersRussia = Tracker.maxPassengers;
         }
         Tracker.passengersJapan = Math.random() * Tracker.maxPassengers + 20;
         if(Tracker.passengersJapan > Tracker.maxPassengers)
         {
            Tracker.passengersJapan = Tracker.maxPassengers;
         }
         Tracker.passengersBrazil = Math.random() * Tracker.maxPassengers + 20;
         if(Tracker.passengersBrazil > Tracker.maxPassengers)
         {
            Tracker.passengersBrazil = Tracker.maxPassengers;
         }
         Tracker.passengersAustralia = Math.random() * Tracker.maxPassengers + 20;
         if(Tracker.passengersAustralia > Tracker.maxPassengers)
         {
            Tracker.passengersAustralia = Tracker.maxPassengers;
         }
         if(Tracker.currentCity == "russia")
         {
            this.animations.map.usaBtn.addEventListener(MouseEvent.CLICK,this.usaBtnF);
            this.animations.map.ukBtn.addEventListener(MouseEvent.CLICK,this.ukBtnF);
            this.animations.map.japanBtn.addEventListener(MouseEvent.CLICK,this.japanBtnF);
            this.animations.map.australiaBtn.addEventListener(MouseEvent.CLICK,this.australiaBtnF);
            this.animations.map.brazilBtn.addEventListener(MouseEvent.CLICK,this.toofarF);
            Tracker.ukDis = -213;
            Tracker.usaDis = -704;
            Tracker.japanDis = 665;
            Tracker.australiaDis = 763;
            this.animations.map.uk.country.text = String("U.K. - " + Math.abs(Tracker.ukDis) + " Miles");
            this.animations.map.russia.country.text = String("Russia");
            this.animations.map.usa.country.text = String("U.S.A. - " + Math.abs(Tracker.usaDis) + " Miles");
            this.animations.map.japan.country.text = String("Japan - " + Math.abs(Tracker.japanDis) + " Miles");
            this.animations.map.brazil.country.text = String("Brazil - Too Far");
            this.animations.map.australia.country.text = String("Australia - " + Math.abs(Tracker.australiaDis) + " Miles");
            this.animations.map.russia.man.gotoAndStop(2);
            this.animations.map.russia.stars.gotoAndStop("youHereLabel");
            this.animations.map.russia.offer.text = String(" ");
            this.salaryUk = Math.floor(Math.random() * Tracker.salaryNum + Tracker.minimumSalary + 500 + Tracker.passengersUk * 100);
            this.salaryUsa = Math.floor(Math.random() * Tracker.salaryNum + Tracker.minimumSalary + 700 + Tracker.passengersUsa * 100);
            this.salaryJapan = Math.floor(Math.random() * Tracker.salaryNum + Tracker.minimumSalary + 1200 + Tracker.passengersJapan * 100);
            this.salaryAustralia = Math.floor(Math.random() * Tracker.salaryNum + Tracker.minimumSalary + 700 + Tracker.passengersAustralia * 100);
            this.animations.map.uk.offer.text = String("offering - $ " + this.salaryUk);
            this.animations.map.usa.offer.text = String("offering - $ " + this.salaryUsa);
            this.animations.map.japan.offer.text = String("offering - $ " + this.salaryJapan);
            this.animations.map.brazil.offer.text = String(" ");
            this.animations.map.australia.offer.text = String("offering - $ " + this.salaryAustralia);
            if(this.salaryUk > 7000)
            {
               this.animations.map.uk.stars.gotoAndStop(1);
            }
            else if(this.salaryUk > 3000)
            {
               this.animations.map.uk.stars.gotoAndStop(2);
            }
            else if(this.salaryUk > 1)
            {
               this.animations.map.uk.stars.gotoAndStop(3);
            }
            if(this.salaryUsa > 9000)
            {
               this.animations.map.usa.stars.gotoAndStop(1);
            }
            else if(this.salaryUsa > 5000)
            {
               this.animations.map.usa.stars.gotoAndStop(2);
            }
            else if(this.salaryUsa > 1)
            {
               this.animations.map.usa.stars.gotoAndStop(3);
            }
            if(this.salaryJapan > 11000)
            {
               this.animations.map.japan.stars.gotoAndStop(1);
            }
            else if(this.salaryJapan > 6000)
            {
               this.animations.map.japan.stars.gotoAndStop(2);
            }
            else if(this.salaryJapan > 1)
            {
               this.animations.map.japan.stars.gotoAndStop(3);
            }
            if(this.salaryAustralia > 9000)
            {
               this.animations.map.australia.stars.gotoAndStop(1);
            }
            else if(this.salaryAustralia > 6000)
            {
               this.animations.map.australia.stars.gotoAndStop(2);
            }
            else if(this.salaryAustralia > 1)
            {
               this.animations.map.australia.stars.gotoAndStop(3);
            }
            this.animations.map.brazil.stars.gotoAndStop("none");
         }
         else if(Tracker.currentCity == "uk")
         {
            this.animations.map.russiaBtn.addEventListener(MouseEvent.CLICK,this.russiaBtnF);
            this.animations.map.usaBtn.addEventListener(MouseEvent.CLICK,this.usaBtnF);
            this.animations.map.ukBtn.addEventListener(MouseEvent.CLICK,this.ukBtnF);
            this.animations.map.japanBtn.addEventListener(MouseEvent.CLICK,this.japanBtnF);
            this.animations.map.brazilBtn.addEventListener(MouseEvent.CLICK,this.brazilBtnF);
            this.animations.map.australiaBtn.addEventListener(MouseEvent.CLICK,this.toofarF);
            trace(Tracker.russiaDis);
            Tracker.russiaDis = 213;
            Tracker.usaDis = -524;
            Tracker.japanDis = 865;
            Tracker.brazilDis = -630;
            this.animations.map.uk.country.text = String("U.K.");
            this.animations.map.russia.country.text = String("Russia - " + Math.abs(Tracker.russiaDis) + " Miles");
            this.animations.map.usa.country.text = String("U.S.A. - " + Math.abs(Tracker.usaDis) + " Miles");
            this.animations.map.japan.country.text = String("Japan - " + Math.abs(Tracker.japanDis) + " Miles");
            this.animations.map.brazil.country.text = String("Brazil - " + Math.abs(Tracker.brazilDis) + " Miles");
            this.animations.map.australia.country.text = String("Australia - Too Far");
            this.animations.map.uk.man.gotoAndStop(2);
            this.animations.map.uk.stars.gotoAndStop("youHereLabel");
            this.animations.map.uk.offer.text = String(" ");
            this.salaryRussia = Math.floor(Math.random() * Tracker.salaryNum + Tracker.minimumSalary + 500 + Tracker.passengersRussia * 100);
            this.salaryUsa = Math.floor(Math.random() * Tracker.salaryNum + Tracker.minimumSalary + 700 + Tracker.passengersUsa * 100);
            this.salaryJapan = Math.floor(Math.random() * Tracker.salaryNum + Tracker.minimumSalary + 1200 + Tracker.passengersJapan * 100);
            this.salaryBrazil = Math.floor(Math.random() * Tracker.salaryNum + Tracker.minimumSalary + 700 + Tracker.passengersBrazil * 100);
            this.animations.map.russia.offer.text = String("offering - $ " + this.salaryRussia);
            this.animations.map.usa.offer.text = String("offering - $ " + this.salaryUsa);
            this.animations.map.japan.offer.text = String("offering - $ " + this.salaryJapan);
            this.animations.map.brazil.offer.text = String("offering - $ " + this.salaryBrazil);
            this.animations.map.australia.offer.text = String(" ");
            if(this.salaryRussia > 7000)
            {
               this.animations.map.russia.stars.gotoAndStop(1);
            }
            else if(this.salaryRussia > 3000)
            {
               this.animations.map.russia.stars.gotoAndStop(2);
            }
            else if(this.salaryRussia > 1)
            {
               this.animations.map.russia.stars.gotoAndStop(3);
            }
            if(this.salaryUsa > 9000)
            {
               this.animations.map.usa.stars.gotoAndStop(1);
            }
            else if(this.salaryUsa > 5000)
            {
               this.animations.map.usa.stars.gotoAndStop(2);
            }
            else if(this.salaryUsa > 1)
            {
               this.animations.map.usa.stars.gotoAndStop(3);
            }
            if(this.salaryJapan > 11000)
            {
               this.animations.map.japan.stars.gotoAndStop(1);
            }
            else if(this.salaryJapan > 6000)
            {
               this.animations.map.japan.stars.gotoAndStop(2);
            }
            else if(this.salaryJapan > 1)
            {
               this.animations.map.japan.stars.gotoAndStop(3);
            }
            if(this.salaryBrazil > 9000)
            {
               this.animations.map.brazil.stars.gotoAndStop(1);
            }
            else if(this.salaryBrazil > 6000)
            {
               this.animations.map.brazil.stars.gotoAndStop(2);
            }
            else if(this.salaryBrazil > 1)
            {
               this.animations.map.brazil.stars.gotoAndStop(3);
            }
            this.animations.map.australia.stars.gotoAndStop("none");
         }
         else if(Tracker.currentCity == "japan")
         {
            this.animations.map.russiaBtn.addEventListener(MouseEvent.CLICK,this.russiaBtnF);
            this.animations.map.usaBtn.addEventListener(MouseEvent.CLICK,this.usaBtnF);
            this.animations.map.brazilBtn.addEventListener(MouseEvent.CLICK,this.brazilBtnF);
            this.animations.map.australiaBtn.addEventListener(MouseEvent.CLICK,this.australiaBtnF);
            this.animations.map.ukBtn.addEventListener(MouseEvent.CLICK,this.toofarF);
            Tracker.russiaDis = -665;
            Tracker.usaDis = 432;
            Tracker.australiaDis = 189;
            Tracker.brazilDis = 720;
            this.animations.map.uk.country.text = String("U.K. - Too Far");
            this.animations.map.russia.country.text = String("Russia - " + Math.abs(Tracker.russiaDis) + " Miles");
            this.animations.map.usa.country.text = String("U.S.A. - " + Math.abs(Tracker.usaDis) + " Miles");
            this.animations.map.japan.country.text = String("Japan");
            this.animations.map.brazil.country.text = String("Brazil - " + Math.abs(Tracker.brazilDis) + " Miles");
            this.animations.map.australia.country.text = String("Australia - " + Math.abs(Tracker.australiaDis) + " Miles");
            this.animations.map.japan.man.gotoAndStop(2);
            this.animations.map.japan.stars.gotoAndStop("youHereLabel");
            this.animations.map.japan.offer.text = String(" ");
            this.salaryRussia = Math.floor(Math.random() * Tracker.salaryNum + Tracker.minimumSalary + 1200 + Tracker.passengersRussia * 100);
            this.salaryUsa = Math.floor(Math.random() * Tracker.salaryNum + Tracker.minimumSalary + 700 + Tracker.passengersUsa * 100);
            this.salaryAustralia = Math.floor(Math.random() * Tracker.salaryNum + Tracker.minimumSalary + 500 + Tracker.passengersAustralia * 100);
            this.salaryBrazil = Math.floor(Math.random() * Tracker.salaryNum + Tracker.minimumSalary + 800 + Tracker.passengersBrazil * 100);
            this.animations.map.russia.offer.text = String("offering - $ " + this.salaryRussia);
            this.animations.map.usa.offer.text = String("offering - $ " + this.salaryUsa);
            this.animations.map.uk.offer.text = String(" ");
            this.animations.map.brazil.offer.text = String("offering - $ " + this.salaryBrazil);
            this.animations.map.australia.offer.text = String("offering - $ " + this.salaryAustralia);
            if(this.salaryRussia > 10000)
            {
               this.animations.map.russia.stars.gotoAndStop(1);
            }
            else if(this.salaryRussia > 3000)
            {
               this.animations.map.russia.stars.gotoAndStop(2);
            }
            else if(this.salaryRussia > 1)
            {
               this.animations.map.russia.stars.gotoAndStop(3);
            }
            if(this.salaryUsa > 9000)
            {
               this.animations.map.usa.stars.gotoAndStop(1);
            }
            else if(this.salaryUsa > 5000)
            {
               this.animations.map.usa.stars.gotoAndStop(2);
            }
            else if(this.salaryUsa > 1)
            {
               this.animations.map.usa.stars.gotoAndStop(3);
            }
            if(this.salaryAustralia > 5000)
            {
               this.animations.map.australia.stars.gotoAndStop(1);
            }
            else if(this.salaryAustralia > 2000)
            {
               this.animations.map.australia.stars.gotoAndStop(2);
            }
            else if(this.salaryAustralia > 1)
            {
               this.animations.map.australia.stars.gotoAndStop(3);
            }
            if(this.salaryBrazil > 9000)
            {
               this.animations.map.brazil.stars.gotoAndStop(1);
            }
            else if(this.salaryBrazil > 7000)
            {
               this.animations.map.brazil.stars.gotoAndStop(2);
            }
            else if(this.salaryBrazil > 1)
            {
               this.animations.map.brazil.stars.gotoAndStop(3);
            }
            this.animations.map.uk.stars.gotoAndStop("none");
         }
         else if(Tracker.currentCity == "brazil")
         {
            this.animations.map.japanBtn.addEventListener(MouseEvent.CLICK,this.japanBtnF);
            this.animations.map.usaBtn.addEventListener(MouseEvent.CLICK,this.usaBtnF);
            this.animations.map.australiaBtn.addEventListener(MouseEvent.CLICK,this.australiaBtnF);
            this.animations.map.ukBtn.addEventListener(MouseEvent.CLICK,this.ukBtnF);
            this.animations.map.russiaBtn.addEventListener(MouseEvent.CLICK,this.toofarF);
            Tracker.ukDis = 630;
            Tracker.usaDis = 268;
            Tracker.australiaDis = -423;
            Tracker.japanDis = -720;
            this.animations.map.uk.country.text = String("U.K. - " + Math.abs(Tracker.ukDis) + " Miles");
            this.animations.map.russia.country.text = String("Russia - Too Far");
            this.animations.map.usa.country.text = String("U.S.A. - " + Math.abs(Tracker.usaDis) + " Miles");
            this.animations.map.japan.country.text = String("Japan - " + Math.abs(Tracker.japanDis) + " Miles");
            this.animations.map.brazil.country.text = String("Brazil");
            this.animations.map.australia.country.text = String("Australia - " + Math.abs(Tracker.australiaDis) + " Miles");
            this.animations.map.brazil.man.gotoAndStop(2);
            this.animations.map.brazil.stars.gotoAndStop("youHereLabel");
            this.animations.map.brazil.offer.text = String(" ");
            this.salaryUk = Math.floor(Math.random() * Tracker.salaryNum + Tracker.minimumSalary + 1200 + Tracker.passengersUk * 100);
            this.salaryUsa = Math.floor(Math.random() * Tracker.salaryNum + Tracker.minimumSalary + 900 + Tracker.passengersUsa * 100);
            this.salaryAustralia = Math.floor(Math.random() * Tracker.salaryNum + Tracker.minimumSalary + 200 + Tracker.passengersAustralia * 100);
            this.salaryJapan = Math.floor(Math.random() * Tracker.salaryNum + Tracker.minimumSalary + 800 + Tracker.passengersJapan * 100);
            this.animations.map.russia.offer.text = String(" ");
            this.animations.map.uk.offer.text = String("offering - $ " + this.salaryUk);
            this.animations.map.usa.offer.text = String("offering - $ " + this.salaryUsa);
            this.animations.map.japan.offer.text = String("offering - $ " + this.salaryJapan);
            this.animations.map.australia.offer.text = String("offering - $ " + this.salaryAustralia);
            this.animations.map.russia.stars.gotoAndStop("none");
            if(this.salaryUk > 10000)
            {
               this.animations.map.uk.stars.gotoAndStop(1);
            }
            else if(this.salaryUk > 5000)
            {
               this.animations.map.uk.stars.gotoAndStop(2);
            }
            else if(this.salaryUk > 1)
            {
               this.animations.map.uk.stars.gotoAndStop(3);
            }
            if(this.salaryUsa > 9000)
            {
               this.animations.map.usa.stars.gotoAndStop(1);
            }
            else if(this.salaryUsa > 5000)
            {
               this.animations.map.usa.stars.gotoAndStop(2);
            }
            else if(this.salaryUsa > 1)
            {
               this.animations.map.usa.stars.gotoAndStop(3);
            }
            if(this.salaryAustralia > 3000)
            {
               this.animations.map.australia.stars.gotoAndStop(1);
            }
            else if(this.salaryAustralia > 1000)
            {
               this.animations.map.australia.stars.gotoAndStop(2);
            }
            else if(this.salaryAustralia > 1)
            {
               this.animations.map.australia.stars.gotoAndStop(3);
            }
            if(this.salaryJapan > 9000)
            {
               this.animations.map.japan.stars.gotoAndStop(1);
            }
            else if(this.salaryJapan > 6000)
            {
               this.animations.map.japan.stars.gotoAndStop(2);
            }
            else if(this.salaryJapan > 1)
            {
               this.animations.map.japan.stars.gotoAndStop(3);
            }
         }
         else if(Tracker.currentCity == "usa")
         {
            this.animations.map.japanBtn.addEventListener(MouseEvent.CLICK,this.japanBtnF);
            this.animations.map.brazilBtn.addEventListener(MouseEvent.CLICK,this.brazilBtnF);
            this.animations.map.australiaBtn.addEventListener(MouseEvent.CLICK,this.australiaBtnF);
            this.animations.map.ukBtn.addEventListener(MouseEvent.CLICK,this.ukBtnF);
            this.animations.map.russiaBtn.addEventListener(MouseEvent.CLICK,this.russiaBtnF);
            Tracker.ukDis = 524;
            Tracker.russiaDis = 704;
            Tracker.australiaDis = -398;
            Tracker.japanDis = -432;
            Tracker.brazilDis = 268;
            this.animations.map.uk.country.text = String("U.K. - " + Math.abs(Tracker.ukDis) + " Miles");
            this.animations.map.russia.country.text = String("Russia - " + Math.abs(Tracker.russiaDis) + " Miles");
            this.animations.map.usa.country.text = String("U.S.A.");
            this.animations.map.japan.country.text = String("Japan - " + Math.abs(Tracker.japanDis) + " Miles");
            this.animations.map.brazil.country.text = String("Brazil - " + Math.abs(Tracker.brazilDis) + " Miles");
            this.animations.map.australia.country.text = String("Australia - " + Math.abs(Tracker.australiaDis) + " Miles");
            this.animations.map.usa.man.gotoAndStop(2);
            this.animations.map.usa.stars.gotoAndStop("youHereLabel");
            this.animations.map.usa.offer.text = String(" ");
            this.salaryUk = Math.floor(Math.random() * Tracker.salaryNum + Tracker.minimumSalary + 1200 + Tracker.passengersUk * 100);
            this.salaryAustralia = Math.floor(Math.random() * Tracker.salaryNum + Tracker.minimumSalary + 500 + Tracker.passengersAustralia * 100);
            this.salaryJapan = Math.floor(Math.random() * Tracker.salaryNum + Tracker.minimumSalary + 600 + Tracker.passengersJapan * 100);
            this.salaryRussia = Math.floor(Math.random() * Tracker.salaryNum + Tracker.minimumSalary + 1000 + Tracker.passengersRussia * 100);
            this.salaryBrazil = Math.floor(Math.random() * Tracker.salaryNum + Tracker.minimumSalary + 500 + Tracker.passengersBrazil * 100);
            this.animations.map.russia.offer.text = String("offering - $ " + this.salaryRussia);
            this.animations.map.uk.offer.text = String("offering - $ " + this.salaryUk);
            this.animations.map.japan.offer.text = String("offering - $ " + this.salaryJapan);
            this.animations.map.australia.offer.text = String("offering - $ " + this.salaryAustralia);
            this.animations.map.brazil.offer.text = String("offering - $ " + this.salaryBrazil);
            if(this.salaryUk > 10000)
            {
               this.animations.map.uk.stars.gotoAndStop(1);
            }
            else if(this.salaryUk > 5000)
            {
               this.animations.map.uk.stars.gotoAndStop(2);
            }
            else if(this.salaryUk > 1)
            {
               this.animations.map.uk.stars.gotoAndStop(3);
            }
            if(this.salaryAustralia > 5000)
            {
               this.animations.map.australia.stars.gotoAndStop(1);
            }
            else if(this.salaryAustralia > 3000)
            {
               this.animations.map.australia.stars.gotoAndStop(2);
            }
            else if(this.salaryAustralia > 1)
            {
               this.animations.map.australia.stars.gotoAndStop(3);
            }
            if(this.salaryJapan > 10000)
            {
               this.animations.map.japan.stars.gotoAndStop(1);
            }
            else if(this.salaryJapan > 5000)
            {
               this.animations.map.japan.stars.gotoAndStop(2);
            }
            else if(this.salaryJapan > 1)
            {
               this.animations.map.japan.stars.gotoAndStop(3);
            }
            if(this.salaryBrazil > 5000)
            {
               this.animations.map.brazil.stars.gotoAndStop(1);
            }
            else if(this.salaryBrazil > 3000)
            {
               this.animations.map.brazil.stars.gotoAndStop(2);
            }
            else if(this.salaryBrazil > 1)
            {
               this.animations.map.brazil.stars.gotoAndStop(3);
            }
            if(this.salaryRussia > 10000)
            {
               this.animations.map.russia.stars.gotoAndStop(1);
            }
            else if(this.salaryRussia > 5000)
            {
               this.animations.map.russia.stars.gotoAndStop(2);
            }
            else if(this.salaryRussia > 1)
            {
               this.animations.map.russia.stars.gotoAndStop(3);
            }
         }
         else if(Tracker.currentCity == "australia")
         {
            this.animations.map.japanBtn.addEventListener(MouseEvent.CLICK,this.japanBtnF);
            this.animations.map.usaBtn.addEventListener(MouseEvent.CLICK,this.usaBtnF);
            this.animations.map.brazilBtn.addEventListener(MouseEvent.CLICK,this.brazilBtnF);
            this.animations.map.ukBtn.addEventListener(MouseEvent.CLICK,this.toofarF);
            this.animations.map.russiaBtn.addEventListener(MouseEvent.CLICK,this.russiaBtnF);
            Tracker.russiaDis = -763;
            Tracker.usaDis = -398;
            Tracker.japanDis = -189;
            Tracker.brazilDis = 423;
            this.animations.map.uk.country.text = String("U.K. - Too Far");
            this.animations.map.russia.country.text = String("Russia - " + Math.abs(Tracker.russiaDis) + " Miles");
            this.animations.map.usa.country.text = String("U.S.A. - " + Math.abs(Tracker.usaDis) + " Miles");
            this.animations.map.japan.country.text = String("Japan - " + Math.abs(Tracker.japanDis) + " Miles");
            this.animations.map.brazil.country.text = String("Brazil - " + Math.abs(Tracker.brazilDis) + " Miles");
            this.animations.map.australia.country.text = String("Australia");
            this.animations.map.australia.man.gotoAndStop(2);
            this.animations.map.australia.stars.gotoAndStop("youHereLabel");
            this.animations.map.australia.offer.text = String(" ");
            this.salaryUsa = Math.floor(Math.random() * Tracker.salaryNum + Tracker.minimumSalary + 900 + Tracker.passengersUsa * 100);
            this.salaryJapan = Math.floor(Math.random() * Tracker.salaryNum + Tracker.minimumSalary + 600 + Tracker.passengersJapan * 100);
            this.salaryRussia = Math.floor(Math.random() * Tracker.salaryNum + Tracker.minimumSalary + 1000 + Tracker.passengersRussia * 100);
            this.salaryBrazil = Math.floor(Math.random() * Tracker.salaryNum + Tracker.minimumSalary + 500 + Tracker.passengersBrazil * 100);
            this.animations.map.russia.offer.text = String("offering - $ " + this.salaryRussia);
            this.animations.map.usa.offer.text = String("offering - $ " + this.salaryUsa);
            this.animations.map.japan.offer.text = String("offering - $ " + this.salaryJapan);
            this.animations.map.brazil.offer.text = String("offering - $ " + this.salaryBrazil);
            this.animations.map.uk.offer.text = String(" ");
            this.animations.map.uk.stars.gotoAndStop("none");
            if(this.salaryUsa > 7000)
            {
               this.animations.map.usa.stars.gotoAndStop(1);
            }
            else if(this.salaryUsa > 4000)
            {
               this.animations.map.usa.stars.gotoAndStop(2);
            }
            else if(this.salaryUsa > 1)
            {
               this.animations.map.usa.stars.gotoAndStop(3);
            }
            if(this.salaryJapan > 5000)
            {
               this.animations.map.japan.stars.gotoAndStop(1);
            }
            else if(this.salaryJapan > 3000)
            {
               this.animations.map.japan.stars.gotoAndStop(2);
            }
            else if(this.salaryJapan > 1)
            {
               this.animations.map.japan.stars.gotoAndStop(3);
            }
            if(this.salaryBrazil > 7000)
            {
               this.animations.map.brazil.stars.gotoAndStop(1);
            }
            else if(this.salaryBrazil > 4000)
            {
               this.animations.map.brazil.stars.gotoAndStop(2);
            }
            else if(this.salaryBrazil > 1)
            {
               this.animations.map.brazil.stars.gotoAndStop(3);
            }
            if(this.salaryRussia > 10000)
            {
               this.animations.map.russia.stars.gotoAndStop(1);
            }
            else if(this.salaryRussia > 6000)
            {
               this.animations.map.russia.stars.gotoAndStop(2);
            }
            else if(this.salaryRussia > 1)
            {
               this.animations.map.russia.stars.gotoAndStop(3);
            }
         }
      }
      
      public function continueBtnF(param1:MouseEvent) : void
      {
         if(this.win.currentFrame == 30)
         {
            this.win.gotoAndPlay(31);
            this.win.win.continueBtn.removeEventListener(MouseEvent.CLICK,this.continueBtnF);
            this.win.win.exitBtn.removeEventListener(MouseEvent.CLICK,this.quitBtnF);
            Tracker.continuePlaying = true;
         }
      }
      
      public function checkWin() : void
      {
         if(Tracker.continuePlaying == false && this.animations.stats.stats1.company.text !== null && this.animations.stats.stats2.company.text !== null && this.animations.stats.stats3.company.text !== null && this.animations.stats.stats4.company.text !== null && this.animations.stats.stats5.company.text !== null && this.animations.stats.stats6.company.text !== null)
         {
            if(this.animations.stats.stats2.company.text == String("---") && this.animations.stats.stats3.company.text == String("---") && this.animations.stats.stats4.company.text == String("---") && this.animations.stats.stats5.company.text == String("---") && this.animations.stats.stats6.company.text == String("---"))
            {
               trace("win the whole game");
               this.win.x = 340;
               this.win.y = 340;
               this.win.win.continueBtn.addEventListener(MouseEvent.CLICK,this.continueBtnF);
               this.win.win.exitBtn.addEventListener(MouseEvent.CLICK,this.quitBtnF);
               this.win.play();
            }
         }
      }
      
      public function backFromMapF(param1:MouseEvent) : void
      {
         this.animations.gotoAndPlay("backFromMapLabel");
         this.animations.map.bcBtn.removeEventListener(MouseEvent.CLICK,this.backFromMapF);
      }
      
      public function statsFunctions() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         Tracker.company1delivered += Math.abs(Math.random() * Tracker.passengersArriving + Math.random() * Tracker.maxPassengers - Math.random() * 100 + Math.random() * 100);
         Tracker.company2delivered += Math.abs(Math.random() * Tracker.passengersArriving + Math.random() * Tracker.maxPassengers - Math.random() * 100 + Math.random() * 80);
         Tracker.company3delivered += Math.abs(Math.random() * Tracker.passengersArriving + Math.random() * Tracker.maxPassengers - Math.random() * 100 + Math.random() * 70);
         Tracker.company4delivered += Math.abs(Math.random() * Tracker.passengersArriving + Math.random() * Tracker.maxPassengers - Math.random() * 100 + Math.random() * 120);
         Tracker.company5delivered += Math.abs(Math.random() * Tracker.passengersArriving + Math.random() * Tracker.maxPassengers - Math.random() * 100 + Math.random() * 60);
         Tracker.company1injured += Math.abs(Math.random() * 3 - 1);
         Tracker.company2injured += Math.abs(Math.random() * 4 - 1);
         Tracker.company3injured += Math.abs(Math.random() * 10 - 1);
         Tracker.company4injured += Math.abs(Math.random() * 20 - 1);
         Tracker.company5injured += Math.abs(Math.random() * 10 - 1);
         _loc1_ = 6;
         _loc2_ = 6;
         _loc3_ = 6;
         _loc4_ = 6;
         _loc5_ = 6;
         _loc6_ = 6;
         Tracker.playerPoints = Tracker.totalPassengersDelivered - Tracker.totalPassengersInjured - Tracker.totalPassengersKilled + Math.random() * 2;
         if(Tracker.company1planes >= 1)
         {
            Tracker.company1points = Tracker.company1delivered - Tracker.company1injured - Tracker.company1killed + Math.random() * 2;
         }
         else
         {
            Tracker.company1points = -11111;
         }
         if(Tracker.company2planes >= 1)
         {
            Tracker.company2points = Tracker.company2delivered - Tracker.company2injured - Tracker.company2killed + Math.random() * 2;
         }
         else
         {
            Tracker.company2points = -22222;
         }
         if(Tracker.company3planes >= 1)
         {
            Tracker.company3points = Tracker.company3delivered - Tracker.company3injured - Tracker.company3killed + Math.random() * 2;
         }
         else
         {
            Tracker.company3points = -33333;
         }
         if(Tracker.company4planes >= 1)
         {
            Tracker.company4points = Tracker.company4delivered - Tracker.company4injured - Tracker.company4killed + Math.random() * 2;
         }
         else
         {
            Tracker.company4points = -44444;
         }
         if(Tracker.company5planes >= 1)
         {
            Tracker.company5points = Tracker.company5delivered - Tracker.company5injured - Tracker.company5killed + Math.random() * 2;
         }
         else
         {
            Tracker.company5points = -55555;
         }
         if(Tracker.playerPoints > Tracker.company1points)
         {
            _loc1_--;
         }
         if(Tracker.playerPoints > Tracker.company2points)
         {
            _loc1_--;
         }
         if(Tracker.playerPoints > Tracker.company3points)
         {
            _loc1_--;
         }
         if(Tracker.playerPoints > Tracker.company4points)
         {
            _loc1_--;
         }
         if(Tracker.playerPoints > Tracker.company5points)
         {
            _loc1_--;
         }
         if(Tracker.company1points > Tracker.playerPoints)
         {
            _loc2_--;
         }
         if(Tracker.company1points > Tracker.company2points)
         {
            _loc2_--;
         }
         if(Tracker.company1points > Tracker.company3points)
         {
            _loc2_--;
         }
         if(Tracker.company1points > Tracker.company4points)
         {
            _loc2_--;
         }
         if(Tracker.company1points > Tracker.company5points)
         {
            _loc2_--;
         }
         if(Tracker.company2points > Tracker.playerPoints)
         {
            _loc3_--;
         }
         if(Tracker.company2points > Tracker.company1points)
         {
            _loc3_--;
         }
         if(Tracker.company2points > Tracker.company3points)
         {
            _loc3_--;
         }
         if(Tracker.company2points > Tracker.company4points)
         {
            _loc3_--;
         }
         if(Tracker.company2points > Tracker.company5points)
         {
            _loc3_--;
         }
         if(Tracker.company3points > Tracker.playerPoints)
         {
            _loc4_--;
         }
         if(Tracker.company3points > Tracker.company1points)
         {
            _loc4_--;
         }
         if(Tracker.company3points > Tracker.company2points)
         {
            _loc4_--;
         }
         if(Tracker.company3points > Tracker.company4points)
         {
            _loc4_--;
         }
         if(Tracker.company3points > Tracker.company5points)
         {
            _loc4_--;
         }
         if(Tracker.company4points > Tracker.playerPoints)
         {
            _loc5_--;
         }
         if(Tracker.company4points > Tracker.company1points)
         {
            _loc5_--;
         }
         if(Tracker.company4points > Tracker.company2points)
         {
            _loc5_--;
         }
         if(Tracker.company4points > Tracker.company3points)
         {
            _loc5_--;
         }
         if(Tracker.company4points > Tracker.company5points)
         {
            _loc5_--;
         }
         if(Tracker.company5points > Tracker.playerPoints)
         {
            _loc6_--;
         }
         if(Tracker.company5points > Tracker.company1points)
         {
            _loc6_--;
         }
         if(Tracker.company5points > Tracker.company2points)
         {
            _loc6_--;
         }
         if(Tracker.company5points > Tracker.company3points)
         {
            _loc6_--;
         }
         if(Tracker.company5points > Tracker.company4points)
         {
            _loc6_--;
         }
         if(_loc1_ == 1)
         {
            this.animations.stats.num1.gotoAndStop(2);
            this.animations.stats.stats1.gotoAndStop(2);
            this.animations.stats.stats1.company.text = String(Tracker.companyPlayer);
            this.animations.stats.stats1.passengersDelivered.text = String(Tracker.totalPassengersDelivered);
            this.animations.stats.stats1.passengersInjured.text = String(Tracker.totalPassengersInjured);
            this.animations.stats.stats1.remaining.text = String(Tracker.planesRemaining);
            this.animations.stats.stats1.passengersKilled.text = String(Tracker.totalPassengersKilled);
         }
         else if(_loc1_ == 2)
         {
            this.animations.stats.num2.gotoAndStop(2);
            this.animations.stats.stats2.gotoAndStop(2);
            this.animations.stats.stats2.company.text = String(Tracker.companyPlayer);
            this.animations.stats.stats2.passengersDelivered.text = String(Tracker.totalPassengersDelivered);
            this.animations.stats.stats2.passengersInjured.text = String(Tracker.totalPassengersInjured);
            this.animations.stats.stats2.remaining.text = String(Tracker.planesRemaining);
            this.animations.stats.stats2.passengersKilled.text = String(Tracker.totalPassengersKilled);
         }
         else if(_loc1_ == 3)
         {
            this.animations.stats.num3.gotoAndStop(2);
            this.animations.stats.stats3.gotoAndStop(2);
            this.animations.stats.stats3.company.text = String(Tracker.companyPlayer);
            this.animations.stats.stats3.passengersDelivered.text = String(Tracker.totalPassengersDelivered);
            this.animations.stats.stats3.passengersInjured.text = String(Tracker.totalPassengersInjured);
            this.animations.stats.stats3.remaining.text = String(Tracker.planesRemaining);
            this.animations.stats.stats3.passengersKilled.text = String(Tracker.totalPassengersKilled);
         }
         else if(_loc1_ == 4)
         {
            this.animations.stats.num4.gotoAndStop(2);
            this.animations.stats.stats4.gotoAndStop(2);
            this.animations.stats.stats4.company.text = String(Tracker.companyPlayer);
            this.animations.stats.stats4.passengersDelivered.text = String(Tracker.totalPassengersDelivered);
            this.animations.stats.stats4.passengersInjured.text = String(Tracker.totalPassengersInjured);
            this.animations.stats.stats4.remaining.text = String(Tracker.planesRemaining);
            this.animations.stats.stats4.passengersKilled.text = String(Tracker.totalPassengersKilled);
         }
         else if(_loc1_ == 5)
         {
            this.animations.stats.num5.gotoAndStop(2);
            this.animations.stats.stats5.gotoAndStop(2);
            this.animations.stats.stats5.company.text = String(Tracker.companyPlayer);
            this.animations.stats.stats5.passengersDelivered.text = String(Tracker.totalPassengersDelivered);
            this.animations.stats.stats5.passengersInjured.text = String(Tracker.totalPassengersInjured);
            this.animations.stats.stats5.remaining.text = String(Tracker.planesRemaining);
            this.animations.stats.stats5.passengersKilled.text = String(Tracker.totalPassengersKilled);
         }
         else if(_loc1_ == 6)
         {
            this.animations.stats.num6.gotoAndStop(2);
            this.animations.stats.stats6.gotoAndStop(2);
            this.animations.stats.stats6.company.text = String(Tracker.companyPlayer);
            this.animations.stats.stats6.passengersDelivered.text = String(Tracker.totalPassengersDelivered);
            this.animations.stats.stats6.passengersInjured.text = String(Tracker.totalPassengersInjured);
            this.animations.stats.stats6.remaining.text = String(Tracker.planesRemaining);
            this.animations.stats.stats6.passengersKilled.text = String(Tracker.totalPassengersKilled);
         }
         if(_loc2_ == 1)
         {
            if(Tracker.company1planes >= 1)
            {
               this.animations.stats.stats1.company.text = String(Tracker.company1);
               this.animations.stats.stats1.passengersDelivered.text = String(Tracker.company1delivered);
               this.animations.stats.stats1.passengersInjured.text = String(Tracker.company1injured);
               this.animations.stats.stats1.remaining.text = String(Tracker.company1planes);
               this.animations.stats.stats1.passengersKilled.text = String(Tracker.company1killed);
            }
            else
            {
               this.animations.stats.stats1.company.text = String("---");
               this.animations.stats.stats1.passengersDelivered.text = String("---");
               this.animations.stats.stats1.passengersInjured.text = String("---");
               this.animations.stats.stats1.remaining.text = String("---");
               this.animations.stats.stats1.passengersKilled.text = String("---");
               Tracker.company1delivered = 0;
               Tracker.company1planes = 0;
            }
         }
         else if(_loc2_ == 2)
         {
            if(Tracker.company1planes >= 1)
            {
               this.animations.stats.stats2.company.text = String(Tracker.company1);
               this.animations.stats.stats2.passengersDelivered.text = String(Tracker.company1delivered);
               this.animations.stats.stats2.passengersInjured.text = String(Tracker.company1injured);
               this.animations.stats.stats2.remaining.text = String(Tracker.company1planes);
               this.animations.stats.stats2.passengersKilled.text = String(Tracker.company1killed);
            }
            else
            {
               this.animations.stats.stats2.company.text = String("---");
               this.animations.stats.stats2.passengersDelivered.text = String("---");
               this.animations.stats.stats2.passengersInjured.text = String("---");
               this.animations.stats.stats2.remaining.text = String("---");
               this.animations.stats.stats2.passengersKilled.text = String("---");
               Tracker.company1delivered = 0;
               Tracker.company1planes = 0;
            }
         }
         else if(_loc2_ == 3)
         {
            if(Tracker.company1planes >= 1)
            {
               this.animations.stats.stats3.company.text = String(Tracker.company1);
               this.animations.stats.stats3.passengersDelivered.text = String(Tracker.company1delivered);
               this.animations.stats.stats3.passengersInjured.text = String(Tracker.company1injured);
               this.animations.stats.stats3.remaining.text = String(Tracker.company1planes);
               this.animations.stats.stats3.passengersKilled.text = String(Tracker.company1killed);
            }
            else
            {
               this.animations.stats.stats3.company.text = String("---");
               this.animations.stats.stats3.passengersDelivered.text = String("---");
               this.animations.stats.stats3.passengersInjured.text = String("---");
               this.animations.stats.stats3.remaining.text = String("---");
               this.animations.stats.stats3.passengersKilled.text = String("---");
               Tracker.company1delivered = 0;
               Tracker.company1planes = 0;
            }
         }
         else if(_loc2_ == 4)
         {
            if(Tracker.company1planes >= 1)
            {
               this.animations.stats.stats4.company.text = String(Tracker.company1);
               this.animations.stats.stats4.passengersDelivered.text = String(Tracker.company1delivered);
               this.animations.stats.stats4.passengersInjured.text = String(Tracker.company1injured);
               this.animations.stats.stats4.remaining.text = String(Tracker.company1planes);
               this.animations.stats.stats4.passengersKilled.text = String(Tracker.company1killed);
            }
            else
            {
               this.animations.stats.stats4.company.text = String("---");
               this.animations.stats.stats4.passengersDelivered.text = String("---");
               this.animations.stats.stats4.passengersInjured.text = String("---");
               this.animations.stats.stats4.remaining.text = String("---");
               this.animations.stats.stats4.passengersKilled.text = String("---");
               Tracker.company1delivered = 0;
               Tracker.company1planes = 0;
            }
         }
         else if(_loc2_ == 5)
         {
            if(Tracker.company1planes >= 1)
            {
               this.animations.stats.stats5.company.text = String(Tracker.company1);
               this.animations.stats.stats5.passengersDelivered.text = String(Tracker.company1delivered);
               this.animations.stats.stats5.passengersInjured.text = String(Tracker.company1injured);
               this.animations.stats.stats5.remaining.text = String(Tracker.company1planes);
               this.animations.stats.stats5.passengersKilled.text = String(Tracker.company1killed);
            }
            else
            {
               this.animations.stats.stats5.company.text = String("---");
               this.animations.stats.stats5.passengersDelivered.text = String("---");
               this.animations.stats.stats5.passengersInjured.text = String("---");
               this.animations.stats.stats5.remaining.text = String("---");
               this.animations.stats.stats5.passengersKilled.text = String("---");
               Tracker.company1delivered = 0;
               Tracker.company1planes = 0;
            }
         }
         else if(_loc2_ == 6)
         {
            if(Tracker.company1planes >= 1)
            {
               this.animations.stats.stats6.company.text = String(Tracker.company1);
               this.animations.stats.stats6.passengersDelivered.text = String(Tracker.company1delivered);
               this.animations.stats.stats6.passengersInjured.text = String(Tracker.company1injured);
               this.animations.stats.stats6.remaining.text = String(Tracker.company1planes);
               this.animations.stats.stats6.passengersKilled.text = String(Tracker.company1killed);
            }
            else
            {
               this.animations.stats.stats6.company.text = String("---");
               this.animations.stats.stats6.passengersDelivered.text = String("---");
               this.animations.stats.stats6.passengersInjured.text = String("---");
               this.animations.stats.stats6.remaining.text = String("---");
               this.animations.stats.stats6.passengersKilled.text = String("---");
               Tracker.company1delivered = 0;
               Tracker.company1planes = 0;
            }
         }
         if(_loc3_ == 1)
         {
            if(Tracker.company2planes >= 1)
            {
               this.animations.stats.stats1.company.text = String(Tracker.company2);
               this.animations.stats.stats1.passengersDelivered.text = String(Tracker.company2delivered);
               this.animations.stats.stats1.passengersInjured.text = String(Tracker.company2injured);
               this.animations.stats.stats1.remaining.text = String(Tracker.company2planes);
               this.animations.stats.stats1.passengersKilled.text = String(Tracker.company2killed);
            }
            else
            {
               this.animations.stats.stats1.company.text = String("---");
               this.animations.stats.stats1.passengersDelivered.text = String("---");
               this.animations.stats.stats1.passengersInjured.text = String("---");
               this.animations.stats.stats1.remaining.text = String("---");
               this.animations.stats.stats1.passengersKilled.text = String("---");
               Tracker.company2delivered = 0;
            }
         }
         else if(_loc3_ == 2)
         {
            if(Tracker.company2planes >= 1)
            {
               this.animations.stats.stats2.company.text = String(Tracker.company2);
               this.animations.stats.stats2.passengersDelivered.text = String(Tracker.company2delivered);
               this.animations.stats.stats2.passengersInjured.text = String(Tracker.company2injured);
               this.animations.stats.stats2.remaining.text = String(Tracker.company2planes);
               this.animations.stats.stats2.passengersKilled.text = String(Tracker.company2killed);
            }
            else
            {
               this.animations.stats.stats2.company.text = String("---");
               this.animations.stats.stats2.passengersDelivered.text = String("---");
               this.animations.stats.stats2.passengersInjured.text = String("---");
               this.animations.stats.stats2.remaining.text = String("---");
               this.animations.stats.stats2.passengersKilled.text = String("---");
               Tracker.company2delivered = 0;
            }
         }
         else if(_loc3_ == 3)
         {
            if(Tracker.company2planes >= 1)
            {
               this.animations.stats.stats3.company.text = String(Tracker.company2);
               this.animations.stats.stats3.passengersDelivered.text = String(Tracker.company2delivered);
               this.animations.stats.stats3.passengersInjured.text = String(Tracker.company2injured);
               this.animations.stats.stats3.remaining.text = String(Tracker.company2planes);
               this.animations.stats.stats3.passengersKilled.text = String(Tracker.company2killed);
            }
            else
            {
               this.animations.stats.stats3.company.text = String("---");
               this.animations.stats.stats3.passengersDelivered.text = String("---");
               this.animations.stats.stats3.passengersInjured.text = String("---");
               this.animations.stats.stats3.remaining.text = String("---");
               this.animations.stats.stats3.passengersKilled.text = String("---");
               Tracker.company2delivered = 0;
            }
         }
         else if(_loc3_ == 4)
         {
            if(Tracker.company2planes >= 1)
            {
               this.animations.stats.stats4.company.text = String(Tracker.company2);
               this.animations.stats.stats4.passengersDelivered.text = String(Tracker.company2delivered);
               this.animations.stats.stats4.passengersInjured.text = String(Tracker.company2injured);
               this.animations.stats.stats4.remaining.text = String(Tracker.company2planes);
               this.animations.stats.stats4.passengersKilled.text = String(Tracker.company2killed);
            }
            else
            {
               this.animations.stats.stats4.company.text = String("---");
               this.animations.stats.stats4.passengersDelivered.text = String("---");
               this.animations.stats.stats4.passengersInjured.text = String("---");
               this.animations.stats.stats4.remaining.text = String("---");
               this.animations.stats.stats4.passengersKilled.text = String("---");
               Tracker.company2delivered = 0;
            }
         }
         else if(_loc3_ == 5)
         {
            if(Tracker.company2planes >= 1)
            {
               this.animations.stats.stats5.company.text = String(Tracker.company2);
               this.animations.stats.stats5.passengersDelivered.text = String(Tracker.company2delivered);
               this.animations.stats.stats5.passengersInjured.text = String(Tracker.company2injured);
               this.animations.stats.stats5.remaining.text = String(Tracker.company2planes);
               this.animations.stats.stats5.passengersKilled.text = String(Tracker.company2killed);
            }
            else
            {
               this.animations.stats.stats5.company.text = String("---");
               this.animations.stats.stats5.passengersDelivered.text = String("---");
               this.animations.stats.stats5.passengersInjured.text = String("---");
               this.animations.stats.stats5.remaining.text = String("---");
               this.animations.stats.stats5.passengersKilled.text = String("---");
               Tracker.company2delivered = 0;
            }
         }
         else if(_loc3_ == 6)
         {
            if(Tracker.company2planes >= 1)
            {
               this.animations.stats.stats6.company.text = String(Tracker.company2);
               this.animations.stats.stats6.passengersDelivered.text = String(Tracker.company2delivered);
               this.animations.stats.stats6.passengersInjured.text = String(Tracker.company2injured);
               this.animations.stats.stats6.remaining.text = String(Tracker.company2planes);
               this.animations.stats.stats6.passengersKilled.text = String(Tracker.company2killed);
            }
            else
            {
               this.animations.stats.stats6.company.text = String("---");
               this.animations.stats.stats6.passengersDelivered.text = String("---");
               this.animations.stats.stats6.passengersInjured.text = String("---");
               this.animations.stats.stats6.remaining.text = String("---");
               this.animations.stats.stats6.passengersKilled.text = String("---");
               Tracker.company2delivered = 0;
            }
         }
         if(_loc4_ == 1)
         {
            if(Tracker.company3planes >= 1)
            {
               this.animations.stats.stats1.company.text = String(Tracker.company3);
               this.animations.stats.stats1.passengersDelivered.text = String(Tracker.company3delivered);
               this.animations.stats.stats1.passengersInjured.text = String(Tracker.company3injured);
               this.animations.stats.stats1.remaining.text = String(Tracker.company3planes);
               this.animations.stats.stats1.passengersKilled.text = String(Tracker.company3killed);
            }
            else
            {
               this.animations.stats.stats1.company.text = String("---");
               this.animations.stats.stats1.passengersDelivered.text = String("---");
               this.animations.stats.stats1.passengersInjured.text = String("---");
               this.animations.stats.stats1.remaining.text = String("---");
               this.animations.stats.stats1.passengersKilled.text = String("---");
               Tracker.company3delivered = 0;
            }
         }
         else if(_loc4_ == 2)
         {
            if(Tracker.company3planes >= 1)
            {
               this.animations.stats.stats2.company.text = String(Tracker.company3);
               this.animations.stats.stats2.passengersDelivered.text = String(Tracker.company3delivered);
               this.animations.stats.stats2.passengersInjured.text = String(Tracker.company3injured);
               this.animations.stats.stats2.remaining.text = String(Tracker.company3planes);
               this.animations.stats.stats2.passengersKilled.text = String(Tracker.company3killed);
            }
            else
            {
               this.animations.stats.stats2.company.text = String("---");
               this.animations.stats.stats2.passengersDelivered.text = String("---");
               this.animations.stats.stats2.passengersInjured.text = String("---");
               this.animations.stats.stats2.remaining.text = String("---");
               this.animations.stats.stats2.passengersKilled.text = String("---");
               Tracker.company3delivered = 0;
            }
         }
         else if(_loc4_ == 3)
         {
            if(Tracker.company3planes >= 1)
            {
               this.animations.stats.stats3.company.text = String(Tracker.company3);
               this.animations.stats.stats3.passengersDelivered.text = String(Tracker.company3delivered);
               this.animations.stats.stats3.passengersInjured.text = String(Tracker.company3injured);
               this.animations.stats.stats3.remaining.text = String(Tracker.company3planes);
               this.animations.stats.stats3.passengersKilled.text = String(Tracker.company3killed);
            }
            else
            {
               this.animations.stats.stats3.company.text = String("---");
               this.animations.stats.stats3.passengersDelivered.text = String("---");
               this.animations.stats.stats3.passengersInjured.text = String("---");
               this.animations.stats.stats3.remaining.text = String("---");
               this.animations.stats.stats3.passengersKilled.text = String("---");
               Tracker.company3delivered = 0;
            }
         }
         else if(_loc4_ == 4)
         {
            if(Tracker.company3planes >= 1)
            {
               this.animations.stats.stats4.company.text = String(Tracker.company3);
               this.animations.stats.stats4.passengersDelivered.text = String(Tracker.company3delivered);
               this.animations.stats.stats4.passengersInjured.text = String(Tracker.company3injured);
               this.animations.stats.stats4.remaining.text = String(Tracker.company3planes);
               this.animations.stats.stats4.passengersKilled.text = String(Tracker.company3killed);
            }
            else
            {
               this.animations.stats.stats4.company.text = String("---");
               this.animations.stats.stats4.passengersDelivered.text = String("---");
               this.animations.stats.stats4.passengersInjured.text = String("---");
               this.animations.stats.stats4.remaining.text = String("---");
               this.animations.stats.stats4.passengersKilled.text = String("---");
               Tracker.company3delivered = 0;
            }
         }
         else if(_loc4_ == 5)
         {
            if(Tracker.company3planes >= 1)
            {
               this.animations.stats.stats5.company.text = String(Tracker.company3);
               this.animations.stats.stats5.passengersDelivered.text = String(Tracker.company3delivered);
               this.animations.stats.stats5.passengersInjured.text = String(Tracker.company3injured);
               this.animations.stats.stats5.remaining.text = String(Tracker.company3planes);
               this.animations.stats.stats5.passengersKilled.text = String(Tracker.company3killed);
            }
            else
            {
               this.animations.stats.stats5.company.text = String("---");
               this.animations.stats.stats5.passengersDelivered.text = String("---");
               this.animations.stats.stats5.passengersInjured.text = String("---");
               this.animations.stats.stats5.remaining.text = String("---");
               this.animations.stats.stats5.passengersKilled.text = String("---");
               Tracker.company3delivered = 0;
            }
         }
         else if(_loc4_ == 6)
         {
            if(Tracker.company3planes >= 1)
            {
               this.animations.stats.stats6.company.text = String(Tracker.company3);
               this.animations.stats.stats6.passengersDelivered.text = String(Tracker.company3delivered);
               this.animations.stats.stats6.passengersInjured.text = String(Tracker.company3injured);
               this.animations.stats.stats6.remaining.text = String(Tracker.company3planes);
               this.animations.stats.stats6.passengersKilled.text = String(Tracker.company3killed);
            }
            else
            {
               this.animations.stats.stats6.company.text = String("---");
               this.animations.stats.stats6.passengersDelivered.text = String("---");
               this.animations.stats.stats6.passengersInjured.text = String("---");
               this.animations.stats.stats6.remaining.text = String("---");
               this.animations.stats.stats6.passengersKilled.text = String("---");
               Tracker.company3delivered = 0;
            }
         }
         if(_loc5_ == 1)
         {
            if(Tracker.company4planes >= 1)
            {
               this.animations.stats.stats1.company.text = String(Tracker.company4);
               this.animations.stats.stats1.passengersDelivered.text = String(Tracker.company4delivered);
               this.animations.stats.stats1.passengersInjured.text = String(Tracker.company4injured);
               this.animations.stats.stats1.remaining.text = String(Tracker.company4planes);
               this.animations.stats.stats1.passengersKilled.text = String(Tracker.company4killed);
            }
            else
            {
               this.animations.stats.stats1.company.text = String("---");
               this.animations.stats.stats1.passengersDelivered.text = String("---");
               this.animations.stats.stats1.passengersInjured.text = String("---");
               this.animations.stats.stats1.remaining.text = String("---");
               this.animations.stats.stats1.passengersKilled.text = String("---");
               Tracker.company4delivered = 0;
            }
         }
         else if(_loc5_ == 2)
         {
            if(Tracker.company4planes >= 1)
            {
               this.animations.stats.stats2.company.text = String(Tracker.company4);
               this.animations.stats.stats2.passengersDelivered.text = String(Tracker.company4delivered);
               this.animations.stats.stats2.passengersInjured.text = String(Tracker.company4injured);
               this.animations.stats.stats2.remaining.text = String(Tracker.company4planes);
               this.animations.stats.stats2.passengersKilled.text = String(Tracker.company4killed);
            }
            else
            {
               this.animations.stats.stats2.company.text = String("---");
               this.animations.stats.stats2.passengersDelivered.text = String("---");
               this.animations.stats.stats2.passengersInjured.text = String("---");
               this.animations.stats.stats2.remaining.text = String("---");
               this.animations.stats.stats2.passengersKilled.text = String("---");
               Tracker.company4delivered = 0;
            }
         }
         else if(_loc5_ == 3)
         {
            if(Tracker.company4planes >= 1)
            {
               this.animations.stats.stats3.company.text = String(Tracker.company4);
               this.animations.stats.stats3.passengersDelivered.text = String(Tracker.company4delivered);
               this.animations.stats.stats3.passengersInjured.text = String(Tracker.company4injured);
               this.animations.stats.stats3.remaining.text = String(Tracker.company4planes);
               this.animations.stats.stats3.passengersKilled.text = String(Tracker.company4killed);
            }
            else
            {
               this.animations.stats.stats3.company.text = String("---");
               this.animations.stats.stats3.passengersDelivered.text = String("---");
               this.animations.stats.stats3.passengersInjured.text = String("---");
               this.animations.stats.stats3.remaining.text = String("---");
               this.animations.stats.stats3.passengersKilled.text = String("---");
               Tracker.company4delivered = 0;
            }
         }
         else if(_loc5_ == 4)
         {
            if(Tracker.company4planes >= 1)
            {
               this.animations.stats.stats4.company.text = String(Tracker.company4);
               this.animations.stats.stats4.passengersDelivered.text = String(Tracker.company4delivered);
               this.animations.stats.stats4.passengersInjured.text = String(Tracker.company4injured);
               this.animations.stats.stats4.remaining.text = String(Tracker.company4planes);
               this.animations.stats.stats4.passengersKilled.text = String(Tracker.company4killed);
            }
            else
            {
               this.animations.stats.stats4.company.text = String("---");
               this.animations.stats.stats4.passengersDelivered.text = String("---");
               this.animations.stats.stats4.passengersInjured.text = String("---");
               this.animations.stats.stats4.remaining.text = String("---");
               this.animations.stats.stats4.passengersKilled.text = String("---");
               Tracker.company4delivered = 0;
            }
         }
         else if(_loc5_ == 5)
         {
            if(Tracker.company4planes >= 1)
            {
               this.animations.stats.stats5.company.text = String(Tracker.company4);
               this.animations.stats.stats5.passengersDelivered.text = String(Tracker.company4delivered);
               this.animations.stats.stats5.passengersInjured.text = String(Tracker.company4injured);
               this.animations.stats.stats5.remaining.text = String(Tracker.company4planes);
               this.animations.stats.stats5.passengersKilled.text = String(Tracker.company4killed);
            }
            else
            {
               this.animations.stats.stats5.company.text = String("---");
               this.animations.stats.stats5.passengersDelivered.text = String("---");
               this.animations.stats.stats5.passengersInjured.text = String("---");
               this.animations.stats.stats5.remaining.text = String("---");
               this.animations.stats.stats5.passengersKilled.text = String("---");
               Tracker.company4delivered = 0;
            }
         }
         else if(_loc5_ == 6)
         {
            if(Tracker.company4planes >= 1)
            {
               this.animations.stats.stats6.company.text = String(Tracker.company4);
               this.animations.stats.stats6.passengersDelivered.text = String(Tracker.company4delivered);
               this.animations.stats.stats6.passengersInjured.text = String(Tracker.company4injured);
               this.animations.stats.stats6.remaining.text = String(Tracker.company4planes);
               this.animations.stats.stats6.passengersKilled.text = String(Tracker.company4killed);
            }
            else
            {
               this.animations.stats.stats6.company.text = String("---");
               this.animations.stats.stats6.passengersDelivered.text = String("---");
               this.animations.stats.stats6.passengersInjured.text = String("---");
               this.animations.stats.stats6.remaining.text = String("---");
               this.animations.stats.stats6.passengersKilled.text = String("---");
               Tracker.company4delivered = 0;
            }
         }
         if(_loc6_ == 1)
         {
            if(Tracker.company5planes >= 1)
            {
               this.animations.stats.stats1.company.text = String(Tracker.company5);
               this.animations.stats.stats1.passengersDelivered.text = String(Tracker.company5delivered);
               this.animations.stats.stats1.passengersInjured.text = String(Tracker.company5injured);
               this.animations.stats.stats1.remaining.text = String(Tracker.company5planes);
               this.animations.stats.stats1.passengersKilled.text = String(Tracker.company5killed);
            }
            else
            {
               this.animations.stats.stats1.company.text = String("---");
               this.animations.stats.stats1.passengersDelivered.text = String("---");
               this.animations.stats.stats1.passengersInjured.text = String("---");
               this.animations.stats.stats1.remaining.text = String("---");
               this.animations.stats.stats1.passengersKilled.text = String("---");
               Tracker.company5delivered = 0;
            }
         }
         else if(_loc6_ == 2)
         {
            if(Tracker.company5planes >= 1)
            {
               this.animations.stats.stats2.company.text = String(Tracker.company5);
               this.animations.stats.stats2.passengersDelivered.text = String(Tracker.company5delivered);
               this.animations.stats.stats2.passengersInjured.text = String(Tracker.company5injured);
               this.animations.stats.stats2.remaining.text = String(Tracker.company5planes);
               this.animations.stats.stats2.passengersKilled.text = String(Tracker.company5killed);
            }
            else
            {
               this.animations.stats.stats2.company.text = String("---");
               this.animations.stats.stats2.passengersDelivered.text = String("---");
               this.animations.stats.stats2.passengersInjured.text = String("---");
               this.animations.stats.stats2.remaining.text = String("---");
               this.animations.stats.stats2.passengersKilled.text = String("---");
               Tracker.company5delivered = 0;
            }
         }
         else if(_loc6_ == 3)
         {
            if(Tracker.company5planes >= 1)
            {
               this.animations.stats.stats3.company.text = String(Tracker.company5);
               this.animations.stats.stats3.passengersDelivered.text = String(Tracker.company5delivered);
               this.animations.stats.stats3.passengersInjured.text = String(Tracker.company4injured);
               this.animations.stats.stats3.remaining.text = String(Tracker.company5planes);
               this.animations.stats.stats3.passengersKilled.text = String(Tracker.company5killed);
            }
            else
            {
               this.animations.stats.stats3.company.text = String("---");
               this.animations.stats.stats3.passengersDelivered.text = String("---");
               this.animations.stats.stats3.passengersInjured.text = String("---");
               this.animations.stats.stats3.remaining.text = String("---");
               this.animations.stats.stats3.passengersKilled.text = String("---");
               Tracker.company5delivered = 0;
            }
         }
         else if(_loc6_ == 4)
         {
            if(Tracker.company5planes >= 1)
            {
               this.animations.stats.stats4.company.text = String(Tracker.company5);
               this.animations.stats.stats4.passengersDelivered.text = String(Tracker.company5delivered);
               this.animations.stats.stats4.passengersInjured.text = String(Tracker.company5injured);
               this.animations.stats.stats4.remaining.text = String(Tracker.company5planes);
               this.animations.stats.stats4.passengersKilled.text = String(Tracker.company5killed);
            }
            else
            {
               this.animations.stats.stats4.company.text = String("---");
               this.animations.stats.stats4.passengersDelivered.text = String("---");
               this.animations.stats.stats4.passengersInjured.text = String("---");
               this.animations.stats.stats4.remaining.text = String("---");
               this.animations.stats.stats4.passengersKilled.text = String("---");
               Tracker.company5delivered = 0;
            }
         }
         else if(_loc6_ == 5)
         {
            if(Tracker.company5planes >= 1)
            {
               this.animations.stats.stats5.company.text = String(Tracker.company5);
               this.animations.stats.stats5.passengersDelivered.text = String(Tracker.company5delivered);
               this.animations.stats.stats5.passengersInjured.text = String(Tracker.company5injured);
               this.animations.stats.stats5.remaining.text = String(Tracker.company5planes);
               this.animations.stats.stats5.passengersKilled.text = String(Tracker.company5killed);
            }
            else
            {
               this.animations.stats.stats5.company.text = String("---");
               this.animations.stats.stats5.passengersDelivered.text = String("---");
               this.animations.stats.stats5.passengersInjured.text = String("---");
               this.animations.stats.stats5.remaining.text = String("---");
               this.animations.stats.stats5.passengersKilled.text = String("---");
               Tracker.company5delivered = 0;
            }
         }
         else if(_loc6_ == 6)
         {
            if(Tracker.company5planes >= 1)
            {
               this.animations.stats.stats6.company.text = String(Tracker.company5);
               this.animations.stats.stats6.passengersDelivered.text = String(Tracker.company5delivered);
               this.animations.stats.stats6.passengersInjured.text = String(Tracker.company5injured);
               this.animations.stats.stats6.remaining.text = String(Tracker.company5planes);
               this.animations.stats.stats6.passengersKilled.text = String(Tracker.company5killed);
            }
            else
            {
               this.animations.stats.stats6.company.text = String("---");
               this.animations.stats.stats6.passengersDelivered.text = String("---");
               this.animations.stats.stats6.passengersInjured.text = String("---");
               this.animations.stats.stats6.remaining.text = String("---");
               this.animations.stats.stats6.passengersKilled.text = String("---");
               Tracker.company5delivered = 0;
            }
         }
      }
      
      public function howtoBackF(param1:MouseEvent) : void
      {
         if(this.animations.howto.currentFrame == 1)
         {
            this.animations.play();
         }
         else
         {
            this.animations.howto.gotoAndStop(this.animations.howto.currentFrame - 1);
         }
      }
      
      public function russiaBtnF(param1:MouseEvent) : void
      {
         Tracker.salary = this.salaryRussia;
         this.animations.map.confirm.x = 0;
         this.animations.map.confirm.y = 0;
         this.animations.map.confirm.miles.text = String(Math.abs(Tracker.russiaDis));
         Tracker.destinationNumFix = Tracker.russiaDis;
         this.animations.map.confirm.salary.text = String(Tracker.salary);
         Tracker.currentDestination = "russia";
         this.animations.map.confirm.passengers.text = String(Tracker.passengersRussia);
         Tracker.passengersArriving = Tracker.passengersRussia;
      }
      
      public function fbBtnF(param1:MouseEvent) : void
      {
         navigateToURL(new URLRequest("http://www.facebook.com/ArmorGames"),"_blank");
      }
      
      public function armorBtnF(param1:MouseEvent) : void
      {
         navigateToURL(new URLRequest("http://www.armorgames.com/"),"_blank");
      }
      
      public function shopFunctions() : void
      {
         var upgrade1F:Function = null;
         var upgrade2F:Function = null;
         var upgrade3F:Function = null;
         var upgrade4F:Function = null;
         var upgrade5F:Function = null;
         var upgrade6F:Function = null;
         upgrade1F = function(param1:MouseEvent):void
         {
            if(Tracker.upgrade1 == 1)
            {
               if(Tracker.totalCash >= Tracker.upgrade1price)
               {
                  if(Tracker.mute == false)
                  {
                     GameController.playSound("clickSound");
                  }
                  Tracker.upgrade1 += 1;
                  Tracker.totalCash -= Tracker.upgrade1price;
                  Tracker.upgrade1price = 3300;
                  animations.shop.totalCashTxt.text = String("$ " + Tracker.totalCash);
                  animations.shop.stars1.gotoAndStop(Tracker.upgrade1);
                  animations.shop.upgrade1priceTxt.text = String("$ " + Tracker.upgrade1price);
                  Tracker.minimumSalary += 500;
               }
               else
               {
                  animations.shop.notEnough.gotoAndPlay(2);
               }
            }
            else if(Tracker.upgrade1 == 2)
            {
               if(Tracker.totalCash >= Tracker.upgrade1price)
               {
                  if(Tracker.mute == false)
                  {
                     GameController.playSound("clickSound");
                  }
                  Tracker.upgrade1 += 1;
                  Tracker.upgrade1price = 7000;
                  Tracker.totalCash -= Tracker.upgrade1price;
                  animations.shop.totalCashTxt.text = String("$ " + Tracker.totalCash);
                  animations.shop.stars1.gotoAndStop(Tracker.upgrade1);
                  animations.shop.upgrade1priceTxt.text = String("$ " + Tracker.upgrade1price);
                  Tracker.minimumSalary += 500;
               }
               else
               {
                  animations.shop.notEnough.gotoAndPlay(2);
               }
            }
            else if(Tracker.upgrade1 == 3)
            {
               if(Tracker.totalCash >= Tracker.upgrade1price)
               {
                  if(Tracker.mute == false)
                  {
                     GameController.playSound("clickSound");
                  }
                  Tracker.upgrade1 += 1;
                  Tracker.totalCash -= Tracker.upgrade1price;
                  Tracker.upgrade1price = 13000;
                  animations.shop.totalCashTxt.text = String("$ " + Tracker.totalCash);
                  animations.shop.stars1.gotoAndStop(Tracker.upgrade1);
                  animations.shop.upgrade1priceTxt.text = String("$ " + Tracker.upgrade1price);
                  Tracker.minimumSalary += 600;
               }
               else
               {
                  animations.shop.notEnough.gotoAndPlay(2);
               }
            }
            else if(Tracker.upgrade1 == 4)
            {
               if(Tracker.totalCash >= Tracker.upgrade1price)
               {
                  if(Tracker.mute == false)
                  {
                     GameController.playSound("clickSound");
                  }
                  Tracker.upgrade1 += 1;
                  Tracker.totalCash -= Tracker.upgrade1price;
                  Tracker.upgrade1price = 23500;
                  animations.shop.totalCashTxt.text = String("$ " + Tracker.totalCash);
                  animations.shop.stars1.gotoAndStop(Tracker.upgrade1);
                  animations.shop.upgrade1priceTxt.text = String("$ " + Tracker.upgrade1price);
                  Tracker.minimumSalary += 1000;
               }
               else
               {
                  animations.shop.notEnough.gotoAndPlay(2);
               }
            }
            else if(Tracker.upgrade1 == 5)
            {
               if(Tracker.totalCash >= Tracker.upgrade1price)
               {
                  if(Tracker.mute == false)
                  {
                     GameController.playSound("clickSound");
                  }
                  Tracker.totalCash -= Tracker.upgrade1price;
                  Tracker.upgrade1 += 1;
                  animations.shop.totalCashTxt.text = String("$ " + Tracker.totalCash);
                  animations.shop.stars1.gotoAndStop(Tracker.upgrade1);
                  animations.shop.upgrade1priceTxt.text = String("---");
                  Tracker.minimumSalary += 500;
               }
               else
               {
                  animations.shop.notEnough.gotoAndPlay(2);
               }
            }
            else if(Tracker.upgrade1 == 6)
            {
               animations.shop.fullyUpgraded.gotoAndPlay(2);
            }
         };
         upgrade2F = function(param1:MouseEvent):void
         {
            if(Tracker.upgrade2 == 1)
            {
               if(Tracker.totalCash >= Tracker.upgrade2price)
               {
                  if(Tracker.mute == false)
                  {
                     GameController.playSound("clickSound");
                  }
                  Tracker.upgrade2 += 1;
                  Tracker.totalCash -= Tracker.upgrade2price;
                  Tracker.upgrade2price = 2800;
                  animations.shop.totalCashTxt.text = String("$ " + Tracker.totalCash);
                  animations.shop.stars2.gotoAndStop(Tracker.upgrade2);
                  animations.shop.upgrade2priceTxt.text = String("$ " + Tracker.upgrade2price);
                  Tracker.expencesNum -= 200;
               }
               else
               {
                  animations.shop.notEnough.gotoAndPlay(2);
               }
            }
            else if(Tracker.upgrade2 == 2)
            {
               if(Tracker.totalCash >= Tracker.upgrade2price)
               {
                  if(Tracker.mute == false)
                  {
                     GameController.playSound("clickSound");
                  }
                  Tracker.upgrade2 += 1;
                  Tracker.totalCash -= Tracker.upgrade2price;
                  Tracker.upgrade2price = 5250;
                  animations.shop.totalCashTxt.text = String("$ " + Tracker.totalCash);
                  animations.shop.stars2.gotoAndStop(Tracker.upgrade2);
                  animations.shop.upgrade2priceTxt.text = String("$ " + Tracker.upgrade2price);
                  Tracker.expencesNum -= 200;
               }
               else
               {
                  animations.shop.notEnough.gotoAndPlay(2);
               }
            }
            else if(Tracker.upgrade2 == 3)
            {
               if(Tracker.totalCash >= Tracker.upgrade2price)
               {
                  if(Tracker.mute == false)
                  {
                     GameController.playSound("clickSound");
                  }
                  Tracker.upgrade2 += 1;
                  Tracker.totalCash -= Tracker.upgrade2price;
                  Tracker.upgrade2price = 9500;
                  animations.shop.totalCashTxt.text = String("$ " + Tracker.totalCash);
                  animations.shop.stars2.gotoAndStop(Tracker.upgrade2);
                  animations.shop.upgrade2priceTxt.text = String("$ " + Tracker.upgrade2price);
                  Tracker.expencesNum -= 200;
               }
               else
               {
                  animations.shop.notEnough.gotoAndPlay(2);
               }
            }
            else if(Tracker.upgrade2 == 4)
            {
               if(Tracker.totalCash >= Tracker.upgrade2price)
               {
                  if(Tracker.mute == false)
                  {
                     GameController.playSound("clickSound");
                  }
                  Tracker.upgrade2 += 1;
                  Tracker.totalCash -= Tracker.upgrade2price;
                  Tracker.upgrade2price = 12000;
                  animations.shop.totalCashTxt.text = String("$ " + Tracker.totalCash);
                  animations.shop.stars2.gotoAndStop(Tracker.upgrade2);
                  animations.shop.upgrade2priceTxt.text = String("$ " + Tracker.upgrade2price);
                  Tracker.expencesNum -= 200;
               }
               else
               {
                  animations.shop.notEnough.gotoAndPlay(2);
               }
            }
            else if(Tracker.upgrade2 == 5)
            {
               if(Tracker.totalCash >= Tracker.upgrade2price)
               {
                  if(Tracker.mute == false)
                  {
                     GameController.playSound("clickSound");
                  }
                  Tracker.totalCash -= Tracker.upgrade2price;
                  Tracker.upgrade2 += 1;
                  animations.shop.totalCashTxt.text = String("$ " + Tracker.totalCash);
                  animations.shop.stars2.gotoAndStop(Tracker.upgrade2);
                  animations.shop.upgrade2priceTxt.text = String("---");
                  Tracker.expencesNum -= 500;
               }
               else
               {
                  animations.shop.notEnough.gotoAndPlay(2);
               }
            }
            else if(Tracker.upgrade3 == 6)
            {
               animations.shop.fullyUpgraded.gotoAndPlay(2);
            }
         };
         upgrade3F = function(param1:MouseEvent):void
         {
            if(Tracker.upgrade3 == 1)
            {
               if(Tracker.totalCash >= Tracker.upgrade3price)
               {
                  if(Tracker.mute == false)
                  {
                     GameController.playSound("clickSound");
                  }
                  Tracker.upgrade3 += 1;
                  Tracker.totalCash -= Tracker.upgrade3price;
                  Tracker.upgrade3price = 3500;
                  animations.shop.totalCashTxt.text = String("$ " + Tracker.totalCash);
                  animations.shop.stars3.gotoAndStop(Tracker.upgrade3);
                  animations.shop.upgrade3priceTxt.text = String("$ " + Tracker.upgrade3price);
                  Tracker.howFastInjured += 3;
               }
               else
               {
                  animations.shop.notEnough.gotoAndPlay(2);
               }
            }
            else if(Tracker.upgrade3 == 2)
            {
               if(Tracker.totalCash >= Tracker.upgrade3price)
               {
                  if(Tracker.mute == false)
                  {
                     GameController.playSound("clickSound");
                  }
                  Tracker.upgrade3 += 1;
                  Tracker.totalCash -= Tracker.upgrade3price;
                  Tracker.upgrade3price = 6200;
                  animations.shop.totalCashTxt.text = String("$ " + Tracker.totalCash);
                  animations.shop.stars3.gotoAndStop(Tracker.upgrade3);
                  animations.shop.upgrade3priceTxt.text = String("$ " + Tracker.upgrade3price);
                  Tracker.howFastInjured += 3;
               }
               else
               {
                  animations.shop.notEnough.gotoAndPlay(2);
               }
            }
            else if(Tracker.upgrade3 == 3)
            {
               if(Tracker.totalCash >= Tracker.upgrade3price)
               {
                  if(Tracker.mute == false)
                  {
                     GameController.playSound("clickSound");
                  }
                  Tracker.upgrade3 += 1;
                  Tracker.totalCash -= Tracker.upgrade3price;
                  Tracker.upgrade3price = 8650;
                  animations.shop.totalCashTxt.text = String("$ " + Tracker.totalCash);
                  animations.shop.stars3.gotoAndStop(Tracker.upgrade3);
                  animations.shop.upgrade3priceTxt.text = String("$ " + Tracker.upgrade3price);
                  Tracker.howFastInjured += 3;
               }
               else
               {
                  animations.shop.notEnough.gotoAndPlay(2);
               }
            }
            else if(Tracker.upgrade3 == 4)
            {
               if(Tracker.totalCash >= Tracker.upgrade3price)
               {
                  if(Tracker.mute == false)
                  {
                     GameController.playSound("clickSound");
                  }
                  Tracker.upgrade3 += 1;
                  Tracker.totalCash -= Tracker.upgrade3price;
                  Tracker.upgrade3price = 9800;
                  animations.shop.totalCashTxt.text = String("$ " + Tracker.totalCash);
                  animations.shop.stars3.gotoAndStop(Tracker.upgrade3);
                  animations.shop.upgrade3priceTxt.text = String("$ " + Tracker.upgrade3price);
                  Tracker.howFastInjured += 3;
               }
               else
               {
                  animations.shop.notEnough.gotoAndPlay(2);
               }
            }
            else if(Tracker.upgrade3 == 5)
            {
               if(Tracker.totalCash >= Tracker.upgrade3price)
               {
                  if(Tracker.mute == false)
                  {
                     GameController.playSound("clickSound");
                  }
                  Tracker.totalCash -= Tracker.upgrade3price;
                  Tracker.upgrade3 += 1;
                  animations.shop.totalCashTxt.text = String("$ " + Tracker.totalCash);
                  animations.shop.stars3.gotoAndStop(Tracker.upgrade3);
                  animations.shop.upgrade3priceTxt.text = String("---");
                  Tracker.howFastInjured += 5;
               }
               else
               {
                  animations.shop.notEnough.gotoAndPlay(2);
               }
            }
            else if(Tracker.upgrade3 == 6)
            {
               animations.shop.fullyUpgraded.gotoAndPlay(2);
            }
         };
         upgrade4F = function(param1:MouseEvent):void
         {
            if(Tracker.upgrade4 == 1)
            {
               if(Tracker.totalCash >= Tracker.upgrade4price)
               {
                  if(Tracker.mute == false)
                  {
                     GameController.playSound("clickSound");
                  }
                  Tracker.upgrade4 += 1;
                  Tracker.totalCash -= Tracker.upgrade4price;
                  Tracker.upgrade4price = 4250;
                  animations.shop.totalCashTxt.text = String("$ " + Tracker.totalCash);
                  animations.shop.stars4.gotoAndStop(Tracker.upgrade4);
                  animations.shop.upgrade4priceTxt.text = String("$ " + Tracker.upgrade4price);
                  Tracker.maxPassengers = 70;
               }
               else
               {
                  animations.shop.notEnough.gotoAndPlay(2);
               }
            }
            else if(Tracker.upgrade4 == 2)
            {
               if(Tracker.totalCash >= Tracker.upgrade4price)
               {
                  if(Tracker.mute == false)
                  {
                     GameController.playSound("clickSound");
                  }
                  Tracker.upgrade4 += 1;
                  Tracker.totalCash -= Tracker.upgrade4price;
                  Tracker.upgrade4price = 7000;
                  animations.shop.totalCashTxt.text = String("$ " + Tracker.totalCash);
                  animations.shop.stars4.gotoAndStop(Tracker.upgrade4);
                  animations.shop.upgrade4priceTxt.text = String("$ " + Tracker.upgrade4price);
                  Tracker.maxPassengers = 80;
               }
               else
               {
                  animations.shop.notEnough.gotoAndPlay(2);
               }
            }
            else if(Tracker.upgrade4 == 3)
            {
               if(Tracker.totalCash >= Tracker.upgrade4price)
               {
                  if(Tracker.mute == false)
                  {
                     GameController.playSound("clickSound");
                  }
                  Tracker.upgrade4 += 1;
                  Tracker.totalCash -= Tracker.upgrade4price;
                  Tracker.upgrade4price = 9000;
                  animations.shop.totalCashTxt.text = String("$ " + Tracker.totalCash);
                  animations.shop.stars4.gotoAndStop(Tracker.upgrade4);
                  animations.shop.upgrade4priceTxt.text = String("$ " + Tracker.upgrade4price);
                  Tracker.maxPassengers = 90;
               }
               else
               {
                  animations.shop.notEnough.gotoAndPlay(2);
               }
            }
            else if(Tracker.upgrade4 == 4)
            {
               if(Tracker.totalCash >= Tracker.upgrade4price)
               {
                  if(Tracker.mute == false)
                  {
                     GameController.playSound("clickSound");
                  }
                  Tracker.upgrade4 += 1;
                  Tracker.totalCash -= Tracker.upgrade4price;
                  Tracker.upgrade4price = 18000;
                  animations.shop.totalCashTxt.text = String("$ " + Tracker.totalCash);
                  animations.shop.stars4.gotoAndStop(Tracker.upgrade4);
                  animations.shop.upgrade4priceTxt.text = String("$ " + Tracker.upgrade4price);
                  Tracker.maxPassengers = 100;
               }
               else
               {
                  animations.shop.notEnough.gotoAndPlay(2);
               }
            }
            else if(Tracker.upgrade4 == 5)
            {
               if(Tracker.totalCash >= Tracker.upgrade4price)
               {
                  if(Tracker.mute == false)
                  {
                     GameController.playSound("clickSound");
                  }
                  Tracker.totalCash -= Tracker.upgrade4price;
                  Tracker.upgrade4 += 1;
                  animations.shop.totalCashTxt.text = String("$ " + Tracker.totalCash);
                  animations.shop.stars4.gotoAndStop(Tracker.upgrade4);
                  animations.shop.upgrade4priceTxt.text = String("---");
                  Tracker.maxPassengers = 120;
               }
               else
               {
                  animations.shop.notEnough.gotoAndPlay(2);
               }
            }
            else if(Tracker.upgrade4 == 6)
            {
               animations.shop.fullyUpgraded.gotoAndPlay(2);
            }
         };
         upgrade5F = function(param1:MouseEvent):void
         {
            if(Tracker.upgrade5 == 1)
            {
               if(Tracker.totalCash >= Tracker.upgrade5price)
               {
                  if(Tracker.mute == false)
                  {
                     GameController.playSound("clickSound");
                  }
                  Tracker.totalCash -= Tracker.upgrade5price;
                  Tracker.upgrade5 += 1;
                  Tracker.upgrade5price = 2200;
                  animations.shop.totalCashTxt.text = String("$ " + Tracker.totalCash);
                  animations.shop.stars5.gotoAndStop(Tracker.upgrade5);
                  animations.shop.upgrade5priceTxt.text = String("$ " + Tracker.upgrade5price);
                  Tracker.howEasyJammFlaps += 5;
                  Tracker.howEasyJammGear += 1;
                  Tracker.engineOffRandomNum += 3000;
               }
               else
               {
                  animations.shop.notEnough.gotoAndPlay(2);
               }
            }
            else if(Tracker.upgrade5 == 2)
            {
               if(Tracker.totalCash >= Tracker.upgrade5price)
               {
                  if(Tracker.mute == false)
                  {
                     GameController.playSound("clickSound");
                  }
                  Tracker.totalCash -= Tracker.upgrade5price;
                  Tracker.upgrade5 += 1;
                  Tracker.upgrade5price = 4500;
                  animations.shop.totalCashTxt.text = String("$ " + Tracker.totalCash);
                  animations.shop.stars5.gotoAndStop(Tracker.upgrade5);
                  animations.shop.upgrade5priceTxt.text = String("$ " + Tracker.upgrade5price);
                  Tracker.howEasyJammFlaps += 5;
                  Tracker.howEasyJammGear += 1;
                  Tracker.engineOffRandomNum += 1000;
               }
               else
               {
                  animations.shop.notEnough.gotoAndPlay(2);
               }
            }
            else if(Tracker.upgrade5 == 3)
            {
               if(Tracker.totalCash >= Tracker.upgrade5price)
               {
                  if(Tracker.mute == false)
                  {
                     GameController.playSound("clickSound");
                  }
                  Tracker.totalCash -= Tracker.upgrade5price;
                  Tracker.upgrade5 += 1;
                  Tracker.upgrade5price = 8000;
                  animations.shop.totalCashTxt.text = String("$ " + Tracker.totalCash);
                  animations.shop.stars5.gotoAndStop(Tracker.upgrade5);
                  animations.shop.upgrade5priceTxt.text = String("$ " + Tracker.upgrade5price);
                  Tracker.howEasyJammFlaps += 10;
                  Tracker.howEasyJammGear += 1;
                  Tracker.engineOffRandomNum += 2000;
               }
               else
               {
                  animations.shop.notEnough.gotoAndPlay(2);
               }
            }
            else if(Tracker.upgrade5 == 4)
            {
               if(Tracker.totalCash >= Tracker.upgrade5price)
               {
                  if(Tracker.mute == false)
                  {
                     GameController.playSound("clickSound");
                  }
                  Tracker.totalCash -= Tracker.upgrade5price;
                  Tracker.upgrade5 += 1;
                  Tracker.upgrade5price = 12500;
                  animations.shop.totalCashTxt.text = String("$ " + Tracker.totalCash);
                  animations.shop.stars5.gotoAndStop(Tracker.upgrade5);
                  animations.shop.upgrade5priceTxt.text = String("$ " + Tracker.upgrade5price);
                  Tracker.howEasyJammFlaps += 20;
                  Tracker.howEasyJammGear += 5;
                  Tracker.engineOffRandomNum += 2000;
               }
               else
               {
                  animations.shop.notEnough.gotoAndPlay(2);
               }
            }
            else if(Tracker.upgrade5 == 5)
            {
               if(Tracker.totalCash >= Tracker.upgrade5price)
               {
                  if(Tracker.mute == false)
                  {
                     GameController.playSound("clickSound");
                  }
                  Tracker.totalCash -= Tracker.upgrade5price;
                  Tracker.upgrade5 += 1;
                  animations.shop.totalCashTxt.text = String("$ " + Tracker.totalCash);
                  animations.shop.stars5.gotoAndStop(Tracker.upgrade5);
                  animations.shop.upgrade5priceTxt.text = String("---");
                  Tracker.howEasyJammFlaps += 50;
                  Tracker.howEasyJammGear += 10;
                  Tracker.engineOffRandomNum += 10000;
               }
               else
               {
                  animations.shop.notEnough.gotoAndPlay(2);
               }
            }
            else if(Tracker.upgrade5 == 6)
            {
               animations.shop.fullyUpgraded.gotoAndPlay(2);
            }
         };
         upgrade6F = function(param1:MouseEvent):void
         {
            if(Tracker.upgrade6 == 1)
            {
               if(Tracker.totalCash >= Tracker.upgrade6price)
               {
                  if(Tracker.mute == false)
                  {
                     GameController.playSound("clickSound");
                  }
                  Tracker.totalCash -= Tracker.upgrade6price;
                  Tracker.upgrade6 += 1;
                  Tracker.upgrade6price = 1500;
                  animations.shop.totalCashTxt.text = String("$ " + Tracker.totalCash);
                  animations.shop.stars6.gotoAndStop(Tracker.upgrade6);
                  animations.shop.upgrade6priceTxt.text = String("$ " + Tracker.upgrade6price);
                  Tracker.overHeatUpgrader += 100;
               }
               else
               {
                  animations.shop.notEnough.gotoAndPlay(2);
               }
            }
            else if(Tracker.upgrade6 == 2)
            {
               if(Tracker.totalCash >= Tracker.upgrade6price)
               {
                  if(Tracker.mute == false)
                  {
                     GameController.playSound("clickSound");
                  }
                  Tracker.totalCash -= Tracker.upgrade6price;
                  Tracker.upgrade6 += 1;
                  Tracker.upgrade6price = 3800;
                  animations.shop.totalCashTxt.text = String("$ " + Tracker.totalCash);
                  animations.shop.stars6.gotoAndStop(Tracker.upgrade6);
                  animations.shop.upgrade6priceTxt.text = String("$ " + Tracker.upgrade6price);
                  Tracker.overHeatUpgrader += 100;
               }
               else
               {
                  animations.shop.notEnough.gotoAndPlay(2);
               }
            }
            else if(Tracker.upgrade6 == 3)
            {
               if(Tracker.totalCash >= Tracker.upgrade6price)
               {
                  if(Tracker.mute == false)
                  {
                     GameController.playSound("clickSound");
                  }
                  Tracker.totalCash -= Tracker.upgrade6price;
                  Tracker.upgrade6 += 1;
                  Tracker.upgrade6price = 5750;
                  animations.shop.totalCashTxt.text = String("$ " + Tracker.totalCash);
                  animations.shop.stars6.gotoAndStop(Tracker.upgrade6);
                  animations.shop.upgrade6priceTxt.text = String("$ " + Tracker.upgrade6price);
                  Tracker.overHeatUpgrader += 200;
                  Tracker.extinguishers = 1;
               }
               else
               {
                  animations.shop.notEnough.gotoAndPlay(2);
               }
            }
            else if(Tracker.upgrade6 == 4)
            {
               if(Tracker.totalCash >= Tracker.upgrade6price)
               {
                  if(Tracker.mute == false)
                  {
                     GameController.playSound("clickSound");
                  }
                  Tracker.totalCash -= Tracker.upgrade6price;
                  Tracker.upgrade6 += 1;
                  Tracker.upgrade6price = 8300;
                  animations.shop.totalCashTxt.text = String("$ " + Tracker.totalCash);
                  animations.shop.stars6.gotoAndStop(Tracker.upgrade6);
                  animations.shop.upgrade6priceTxt.text = String("$ " + Tracker.upgrade6price);
                  Tracker.overHeatUpgrader += 300;
               }
               else
               {
                  animations.shop.notEnough.gotoAndPlay(2);
               }
            }
            else if(Tracker.upgrade6 == 5)
            {
               if(Tracker.totalCash >= Tracker.upgrade6price)
               {
                  if(Tracker.mute == false)
                  {
                     GameController.playSound("clickSound");
                  }
                  Tracker.totalCash -= Tracker.upgrade6price;
                  Tracker.upgrade6 += 1;
                  animations.shop.totalCashTxt.text = String("$ " + Tracker.totalCash);
                  animations.shop.stars6.gotoAndStop(Tracker.upgrade6);
                  animations.shop.upgrade6priceTxt.text = String("---");
                  Tracker.overHeatUpgrader += 500;
               }
               else
               {
                  animations.shop.notEnough.gotoAndPlay(2);
               }
            }
            else if(Tracker.upgrade6 == 6)
            {
               animations.shop.fullyUpgraded.gotoAndPlay(2);
            }
         };
         this.animations.shop.totalCashTxt.text = String("$ " + Tracker.totalCash);
         this.animations.shop.upgrade1priceTxt.text = String("$ " + Tracker.upgrade1price);
         if(Tracker.upgrade1 == 6)
         {
            this.animations.shop.upgrade1priceTxt.text = String("---");
         }
         this.animations.shop.upgrade2priceTxt.text = String("$ " + Tracker.upgrade2price);
         if(Tracker.upgrade2 == 6)
         {
            this.animations.shop.upgrade2priceTxt.text = String("---");
         }
         this.animations.shop.upgrade3priceTxt.text = String("$ " + Tracker.upgrade3price);
         if(Tracker.upgrade3 == 6)
         {
            this.animations.shop.upgrade3priceTxt.text = String("---");
         }
         this.animations.shop.upgrade4priceTxt.text = String("$ " + Tracker.upgrade4price);
         if(Tracker.upgrade4 == 6)
         {
            this.animations.shop.upgrade4priceTxt.text = String("---");
         }
         this.animations.shop.upgrade5priceTxt.text = String("$ " + Tracker.upgrade5price);
         if(Tracker.upgrade5 == 6)
         {
            this.animations.shop.upgrade5priceTxt.text = String("---");
         }
         this.animations.shop.upgrade6priceTxt.text = String("$ " + Tracker.upgrade6price);
         if(Tracker.upgrade6 == 6)
         {
            this.animations.shop.upgrade6priceTxt.text = String("---");
         }
         this.animations.shop.stars1.gotoAndStop(Tracker.upgrade1);
         this.animations.shop.stars2.gotoAndStop(Tracker.upgrade2);
         this.animations.shop.stars3.gotoAndStop(Tracker.upgrade3);
         this.animations.shop.stars4.gotoAndStop(Tracker.upgrade4);
         this.animations.shop.stars5.gotoAndStop(Tracker.upgrade5);
         this.animations.shop.stars6.gotoAndStop(Tracker.upgrade6);
         this.animations.shop.upgrade1Btn.addEventListener(MouseEvent.CLICK,upgrade1F);
         this.animations.shop.upgrade2Btn.addEventListener(MouseEvent.CLICK,upgrade2F);
         this.animations.shop.upgrade3Btn.addEventListener(MouseEvent.CLICK,upgrade3F);
         this.animations.shop.upgrade4Btn.addEventListener(MouseEvent.CLICK,upgrade4F);
         this.animations.shop.upgrade5Btn.addEventListener(MouseEvent.CLICK,upgrade5F);
         this.animations.shop.upgrade6Btn.addEventListener(MouseEvent.CLICK,upgrade6F);
      }
      
      public function cancelDestBtnF(param1:MouseEvent) : void
      {
         this.animations.map.confirm.x = 800;
         this.animations.map.confirm.y = 0;
      }
      
      public function loadGameF() : void
      {
         var _loc1_:SharedObject = GameController.getSharedObject();
         if(_loc1_ != null)
         {
            if(_loc1_.data.continuePlaying != null)
            {
               Tracker.continuePlaying = _loc1_.data.continuePlaying;
            }
            if(_loc1_.data.totalCash != null)
            {
               Tracker.totalCash = _loc1_.data.totalCash;
            }
            if(_loc1_.data.totalPassengersDelivered != null)
            {
               Tracker.totalPassengersDelivered = _loc1_.data.totalPassengersDelivered;
            }
            if(_loc1_.data.totalPassengersInjured != null)
            {
               Tracker.totalPassengersInjured = _loc1_.data.totalPassengersInjured;
            }
            if(_loc1_.data.totalPassengersKilled != null)
            {
               Tracker.totalPassengersKilled = _loc1_.data.totalPassengersKilled;
            }
            if(_loc1_.data.planesRemaining != null)
            {
               Tracker.planesRemaining = _loc1_.data.planesRemaining;
            }
            if(_loc1_.data.maxPassengers != null)
            {
               Tracker.maxPassengers = _loc1_.data.maxPassengers;
            }
            if(_loc1_.data.passengersInjured != null)
            {
               Tracker.passengersInjured = _loc1_.data.passengersInjured;
            }
            if(_loc1_.data.passengersArriving != null)
            {
               Tracker.passengersArriving = _loc1_.data.passengersArriving;
            }
            if(_loc1_.data.salary != null)
            {
               Tracker.salary = _loc1_.data.salary;
            }
            if(_loc1_.data.expencesNum != null)
            {
               Tracker.expencesNum = _loc1_.data.expencesNum;
            }
            if(_loc1_.data.howFastInjured != null)
            {
               Tracker.howFastInjured = _loc1_.data.howFastInjured;
            }
            if(_loc1_.data.howEasyJammFlaps != null)
            {
               Tracker.howEasyJammFlaps = _loc1_.data.howEasyJammFlaps;
            }
            if(_loc1_.data.howEasyJammGear != null)
            {
               Tracker.howEasyJammGear = _loc1_.data.howEasyJammGear;
            }
            if(_loc1_.data.overHeatUpgrader != null)
            {
               Tracker.overHeatUpgrader = _loc1_.data.overHeatUpgrader;
            }
            if(_loc1_.data.extinguishers != null)
            {
               Tracker.extinguishers = _loc1_.data.extinguishers;
            }
            if(_loc1_.data.minimumSalary != null)
            {
               Tracker.minimumSalary = _loc1_.data.minimumSalary;
            }
            if(_loc1_.data.engineOffRandomNum != null)
            {
               Tracker.engineOffRandomNum = _loc1_.data.engineOffRandomNum;
            }
            if(_loc1_.data.ukDis != null)
            {
               Tracker.ukDis = _loc1_.data.ukDis;
            }
            if(_loc1_.data.russiaDis != null)
            {
               Tracker.russiaDis = _loc1_.data.russiaDis;
            }
            if(_loc1_.data.usaDis != null)
            {
               Tracker.usaDis = _loc1_.data.usaDis;
            }
            if(_loc1_.data.japanDis != null)
            {
               Tracker.japanDis = _loc1_.data.japanDis;
            }
            if(_loc1_.data.brazilDis != null)
            {
               Tracker.brazilDis = _loc1_.data.brazilDis;
            }
            if(_loc1_.data.australiaDis != null)
            {
               Tracker.australiaDis = _loc1_.data.australiaDis;
            }
            if(_loc1_.data.salaryNum != null)
            {
               Tracker.salaryNum = _loc1_.data.salaryNum;
            }
            if(_loc1_.data.currentCity != null)
            {
               Tracker.currentCity = _loc1_.data.currentCity;
            }
            if(_loc1_.data.currentDestination != null)
            {
               Tracker.currentDestination = _loc1_.data.currentDestination;
            }
            if(_loc1_.data.destinationNumFix != null)
            {
               Tracker.destinationNumFix = _loc1_.data.destinationNumFix;
            }
            if(_loc1_.data.salaryUk != null)
            {
               Tracker.salaryUk = _loc1_.data.salaryUk;
            }
            if(_loc1_.data.salaryUsa != null)
            {
               Tracker.salaryUsa = _loc1_.data.salaryUsa;
            }
            if(_loc1_.data.salaryJapan != null)
            {
               Tracker.salaryJapan = _loc1_.data.salaryJapan;
            }
            if(_loc1_.data.salaryRussia != null)
            {
               Tracker.salaryRussia = _loc1_.data.salaryRussia;
            }
            if(_loc1_.data.salaryBrazil != null)
            {
               Tracker.salaryBrazil = _loc1_.data.salaryBrazil;
            }
            if(_loc1_.data.salaryAustralia != null)
            {
               Tracker.salaryAustralia = _loc1_.data.salaryAustralia;
            }
            if(_loc1_.data.passengersUk != null)
            {
               Tracker.passengersUk = _loc1_.data.passengersUk;
            }
            if(_loc1_.data.passengersUsa != null)
            {
               Tracker.passengersUsa = _loc1_.data.passengersUsa;
            }
            if(_loc1_.data.passengersRussia != null)
            {
               Tracker.passengersRussia = _loc1_.data.passengersRussia;
            }
            if(_loc1_.data.passengersJapan != null)
            {
               Tracker.passengersJapan = _loc1_.data.passengersJapan;
            }
            if(_loc1_.data.passengersBrazil != null)
            {
               Tracker.passengersBrazil = _loc1_.data.passengersBrazil;
            }
            if(_loc1_.data.passengersAustralia != null)
            {
               Tracker.passengersAustralia = _loc1_.data.passengersAustralia;
            }
            if(_loc1_.data.company1delivered != null)
            {
               Tracker.company1delivered = _loc1_.data.company1delivered;
            }
            if(_loc1_.data.company1injured != null)
            {
               Tracker.company1injured = _loc1_.data.company1injured;
            }
            if(_loc1_.data.company1killed != null)
            {
               Tracker.company1killed = _loc1_.data.company1killed;
            }
            if(_loc1_.data.company1planes != null)
            {
               Tracker.company1planes = _loc1_.data.company1planes;
            }
            if(_loc1_.data.company1points != null)
            {
               Tracker.company1points = _loc1_.data.company1points;
            }
            if(_loc1_.data.company2delivered != null)
            {
               Tracker.company2delivered = _loc1_.data.company2delivered;
            }
            if(_loc1_.data.company2injured != null)
            {
               Tracker.company2injured = _loc1_.data.company2injured;
            }
            if(_loc1_.data.company2killed != null)
            {
               Tracker.company2killed = _loc1_.data.company2killed;
            }
            if(_loc1_.data.company2planes != null)
            {
               Tracker.company2planes = _loc1_.data.company2planes;
            }
            if(_loc1_.data.company2points != null)
            {
               Tracker.company2points = _loc1_.data.company2points;
            }
            if(_loc1_.data.company3delivered != null)
            {
               Tracker.company3delivered = _loc1_.data.company3delivered;
            }
            if(_loc1_.data.company3injured != null)
            {
               Tracker.company3injured = _loc1_.data.company3injured;
            }
            if(_loc1_.data.company3killed != null)
            {
               Tracker.company3killed = _loc1_.data.company3killed;
            }
            if(_loc1_.data.company3planes != null)
            {
               Tracker.company3planes = _loc1_.data.company3planes;
            }
            if(_loc1_.data.company3points != null)
            {
               Tracker.company3points = _loc1_.data.company3points;
            }
            if(_loc1_.data.company4delivered != null)
            {
               Tracker.company4delivered = _loc1_.data.company4delivered;
            }
            if(_loc1_.data.company4injured != null)
            {
               Tracker.company4injured = _loc1_.data.company4injured;
            }
            if(_loc1_.data.company4killed != null)
            {
               Tracker.company4killed = _loc1_.data.company4killed;
            }
            if(_loc1_.data.company4planes != null)
            {
               Tracker.company4planes = _loc1_.data.company4planes;
            }
            if(_loc1_.data.company4points != null)
            {
               Tracker.company4points = _loc1_.data.company4points;
            }
            if(_loc1_.data.company5delivered != null)
            {
               Tracker.company5delivered = _loc1_.data.company5delivered;
            }
            if(_loc1_.data.company5injured != null)
            {
               Tracker.company5injured = _loc1_.data.company5injured;
            }
            if(_loc1_.data.company5killed != null)
            {
               Tracker.company5killed = _loc1_.data.company5killed;
            }
            if(_loc1_.data.company5planes != null)
            {
               Tracker.company5planes = _loc1_.data.company5planes;
            }
            if(_loc1_.data.company5points != null)
            {
               Tracker.company5points = _loc1_.data.company5points;
            }
            if(_loc1_.data.upgrade1 != null)
            {
               Tracker.upgrade1 = _loc1_.data.upgrade1;
            }
            if(_loc1_.data.upgrade1price != null)
            {
               Tracker.upgrade1price = _loc1_.data.upgrade1price;
            }
            if(_loc1_.data.upgrade2 != null)
            {
               Tracker.upgrade2 = _loc1_.data.upgrade2;
            }
            if(_loc1_.data.upgrade2price != null)
            {
               Tracker.upgrade2price = _loc1_.data.upgrade2price;
            }
            if(_loc1_.data.upgrade3 != null)
            {
               Tracker.upgrade3 = _loc1_.data.upgrade3;
            }
            if(_loc1_.data.upgrade3price != null)
            {
               Tracker.upgrade3price = _loc1_.data.upgrade3price;
            }
            if(_loc1_.data.upgrade4 != null)
            {
               Tracker.upgrade4 = _loc1_.data.upgrade4;
            }
            if(_loc1_.data.upgrade4price != null)
            {
               Tracker.upgrade4price = _loc1_.data.upgrade4price;
            }
            if(_loc1_.data.upgrade5 != null)
            {
               Tracker.upgrade5 = _loc1_.data.upgrade5;
            }
            if(_loc1_.data.upgrade5price != null)
            {
               Tracker.upgrade5price = _loc1_.data.upgrade5price;
            }
            if(_loc1_.data.upgrade6 != null)
            {
               Tracker.upgrade6 = _loc1_.data.upgrade6;
            }
            if(_loc1_.data.upgrade6price != null)
            {
               Tracker.upgrade6price = _loc1_.data.upgrade6price;
            }
            if(_loc1_.data.ach1 != null)
            {
               Tracker.ach1 = _loc1_.data.ach1;
            }
            if(_loc1_.data.ach2 != null)
            {
               Tracker.ach2 = _loc1_.data.ach2;
            }
            if(_loc1_.data.ach3 != null)
            {
               Tracker.ach3 = _loc1_.data.ach3;
            }
            if(_loc1_.data.ach4 != null)
            {
               Tracker.ach4 = _loc1_.data.ach4;
            }
            if(_loc1_.data.ach5 != null)
            {
               Tracker.ach5 = _loc1_.data.ach5;
            }
            if(_loc1_.data.ach6 != null)
            {
               Tracker.ach6 = _loc1_.data.ach6;
            }
            if(_loc1_.data.ach7 != null)
            {
               Tracker.ach7 = _loc1_.data.ach7;
            }
            if(_loc1_.data.ach8 != null)
            {
               Tracker.ach8 = _loc1_.data.ach8;
            }
            if(_loc1_.data.ach9 != null)
            {
               Tracker.ach9 = _loc1_.data.ach9;
            }
            if(_loc1_.data.ach10 != null)
            {
               Tracker.ach10 = _loc1_.data.ach10;
            }
            if(_loc1_.data.ach11 != null)
            {
               Tracker.ach11 = _loc1_.data.ach11;
            }
            if(_loc1_.data.ach12 != null)
            {
               Tracker.ach12 = _loc1_.data.ach12;
            }
         }
         _loc1_.close();
      }
      
      internal function frame15() : *
      {
         Controller.gameOver = false;
         Controller.startGame(stage);
      }
      
      internal function frame10() : *
      {
         stop();
         trace(Tracker.totalCash);
         this.armorBtn.addEventListener(MouseEvent.CLICK,this.armorBtnF);
         this.over.mouseEnabled = false;
         this.animations.mm.newGameBtn.addEventListener(MouseEvent.CLICK,this.newGameF);
         this.animations.mm.continueBtn.addEventListener(MouseEvent.CLICK,this.continueF);
         this.animations.howto.continueBtn.addEventListener(MouseEvent.CLICK,this.howtoContinueF);
         this.animations.howto.backBtn.addEventListener(MouseEvent.CLICK,this.howtoBackF);
         this.animations.mm.pmgBtn.addEventListener(MouseEvent.CLICK,this.pmgBtnF);
         this.animations.mm.fbBtn.addEventListener(MouseEvent.CLICK,this.fbBtnF);
         this.animations.mm.twtBtn.addEventListener(MouseEvent.CLICK,this.twtBtnF);
      }
      
      public function newGameF(param1:MouseEvent) : void
      {
         this.animations.gotoAndPlay("howtoplayLabel");
      }
      
      public function PL_LOADING(param1:ProgressEvent) : void
      {
         var _loc2_:Number = param1.bytesLoaded / param1.bytesTotal * 100;
         this.loader.lbar.scaleX = _loc2_ / 100;
         this.lpc.text = int(_loc2_) + "%";
         if(_loc2_ == 100)
         {
            this.gotoAndStop(2);
         }
      }
      
      public function twtBtnF(param1:MouseEvent) : void
      {
         navigateToURL(new URLRequest("http://twitter.com/armorgames"),"_blank");
      }
      
      public function quitBtnF(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         if(this.win.currentFrame == 30)
         {
            this.win.gotoAndPlay(31);
            GameController.transition.playTween(function():*
            {
               GameController.timeline.gotoAndStop(10);
            });
            this.win.win.continueBtn.removeEventListener(MouseEvent.CLICK,this.continueBtnF);
            this.win.win.exitBtn.removeEventListener(MouseEvent.CLICK,this.quitBtnF);
         }
      }
      
      public function toStatsF(param1:MouseEvent) : void
      {
         if(this.animations.currentFrame == 275 || this.animations.currentFrame == 276)
         {
            this.animations.gotoAndPlay("statsLabel");
            this.animations.stats.bcBtn.addEventListener(MouseEvent.CLICK,this.backFromStatsF);
         }
      }
      
      public function toShopF(param1:MouseEvent) : void
      {
         if(this.animations.currentFrame == 275 || this.animations.currentFrame == 276)
         {
            this.animations.gotoAndPlay("shopLabel");
            this.animations.shop.bcBtn.addEventListener(MouseEvent.CLICK,this.backFromShopF);
         }
      }
      
      internal function frame2() : *
      {
         this.siteLock();
      }
      
      public function backFromShopF(param1:MouseEvent) : void
      {
         this.animations.gotoAndPlay("backFromShopLabel");
         this.saveGame();
         this.animations.map.bcBtn.removeEventListener(MouseEvent.CLICK,this.backFromShopF);
      }
      
      internal function frame6() : *
      {
         gotoAndStop("lockedLabel");
      }
      
      public function toofarF(param1:MouseEvent) : void
      {
         this.animations.map.toofar.x = 0;
         this.animations.map.toofar.y = 0;
         this.animations.map.toofar.gotoAndPlay(2);
      }
      
      internal function frame9() : *
      {
         GameController.setup(this,stage,this.transition);
      }
      
      public function newsPaperF() : void
      {
         if(Tracker.died == true && Tracker.planesRemaining == 1)
         {
            this.newsPaper.paper.gotoAndStop(52);
         }
         else if(Tracker.died == true && Tracker.planesRemaining <= 19 && Tracker.planesRemaining > 1)
         {
            this.newsPaper.paper.gotoAndStop(51);
         }
         else if(Tracker.died == true && Tracker.planesRemaining <= 20 && Tracker.planesRemaining > 19)
         {
            this.newsPaper.paper.gotoAndStop(50);
         }
         else if(Tracker.emLand == true)
         {
            this.newsPaper.paper.gotoAndStop(55);
         }
         else if(Tracker.explodeFromFire == true)
         {
            this.newsPaper.paper.gotoAndStop(56);
         }
         else if(Tracker.ach1 == false && Tracker.currentCity == "russia")
         {
            this.newsPaper.paper.gotoAndStop(1);
            Tracker.ach1 = true;
         }
         else if(Tracker.ach2 == false && Tracker.currentCity == "usa" && Tracker.destinationNumFix == -524 || Tracker.ach2 == false && Tracker.currentCity == "brazil" && Tracker.destinationNumFix == -630 || Tracker.ach2 == false && Tracker.currentCity == "uk" && Tracker.destinationNumFix == 524 || Tracker.ach2 == false && Tracker.currentCity == "uk" && Tracker.destinationNumFix == 630)
         {
            this.newsPaper.paper.gotoAndStop(2);
            Tracker.ach2 = true;
         }
         else if(Tracker.ach3 == false && Tracker.currentCity == "usa" && Tracker.destinationNumFix == 432 || Tracker.ach3 == false && Tracker.currentCity == "japan" && Tracker.destinationNumFix == -432 || Tracker.ach3 == false && Tracker.currentCity == "usa" && Tracker.destinationNumFix == -398 || Tracker.ach3 == false && Tracker.currentCity == "australia" && Tracker.destinationNumFix == -398)
         {
            this.newsPaper.paper.gotoAndStop(3);
            Tracker.ach3 = true;
         }
         else if(Tracker.ach4 == false && Tracker.totalPassengersDelivered >= 50)
         {
            this.newsPaper.paper.gotoAndStop(20);
            Tracker.ach4 = true;
         }
         else if(Tracker.ach5 == false && Tracker.totalPassengersDelivered >= 200)
         {
            this.newsPaper.paper.gotoAndStop(21);
            Tracker.ach5 = true;
         }
         else if(Tracker.ach6 == false && Tracker.totalPassengersDelivered >= 500)
         {
            this.newsPaper.paper.gotoAndStop(22);
            Tracker.ach6 = true;
         }
         else if(Tracker.ach7 == false && Tracker.totalPassengersDelivered >= 1000)
         {
            this.newsPaper.paper.gotoAndStop(23);
            Tracker.ach7 = true;
         }
         else if(Tracker.ach8 == false && Tracker.totalPassengersDelivered >= 2000)
         {
            this.newsPaper.paper.gotoAndStop(24);
            Tracker.ach8 = true;
         }
         else if(Tracker.ach9 == false && Tracker.totalPassengersInjured >= 50)
         {
            this.newsPaper.paper.gotoAndStop(40);
            Tracker.ach9 = true;
         }
         else if(Tracker.ach10 == false && Tracker.totalPassengersInjured >= 200)
         {
            this.newsPaper.paper.gotoAndStop(41);
            Tracker.ach10 = true;
         }
         else if(Tracker.ach11 == false && Tracker.totalPassengersInjured >= 500)
         {
            this.newsPaper.paper.gotoAndStop(42);
            Tracker.ach11 = true;
         }
         else if(Tracker.ach12 == false && Tracker.totalPassengersInjured >= 1000)
         {
            this.newsPaper.paper.gotoAndStop(43);
            Tracker.ach12 = true;
         }
         else
         {
            this.newsPaper.paper.gotoAndStop(80);
         }
      }
      
      public function newsOkayF2(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         if(this.newsPaper.currentFrame == 60)
         {
            this.newsPaper.gotoAndPlay(61);
            GameController.transition.playTween(function():*
            {
               GameController.timeline.gotoAndStop(10);
            });
         }
         this.newsPaper.paper.okayBtn.removeEventListener(MouseEvent.CLICK,this.newsOkayF2);
         Tracker.currentCity = "tupolev";
         Tracker.currentDestination = "russia";
         Tracker.destinationNumFix = 152;
      }
      
      public function howtoContinueF(param1:MouseEvent) : void
      {
         if(this.animations.howto.currentFrame == 26)
         {
            if(this.animations.currentFrame == 100)
            {
               this.animations.gotoAndPlay("startGameLabel");
            }
            this.animations.mm.newGameBtn.removeEventListener(MouseEvent.CLICK,this.newGameF);
            this.animations.mm.continueBtn.removeEventListener(MouseEvent.CLICK,this.continueF);
            this.animations.howto.continueBtn.removeEventListener(MouseEvent.CLICK,this.howtoContinueF);
            this.animations.howto.backBtn.removeEventListener(MouseEvent.CLICK,this.howtoBackF);
            this.animations.mm.pmgBtn.addEventListener(MouseEvent.CLICK,this.pmgBtnF);
            this.animations.mm.fbBtn.addEventListener(MouseEvent.CLICK,this.fbBtnF);
            this.animations.mm.twtBtn.addEventListener(MouseEvent.CLICK,this.twtBtnF);
            this.armorBtn.removeEventListener(MouseEvent.CLICK,this.armorBtnF);
         }
         else
         {
            this.animations.howto.gotoAndStop(this.animations.howto.currentFrame + 1);
         }
      }
      
      public function brazilBtnF(param1:MouseEvent) : void
      {
         Tracker.salary = this.salaryBrazil;
         this.animations.map.confirm.x = 0;
         this.animations.map.confirm.y = 0;
         this.animations.map.confirm.miles.text = String(Math.abs(Tracker.brazilDis));
         Tracker.destinationNumFix = Tracker.brazilDis;
         this.animations.map.confirm.salary.text = String(Tracker.salary);
         Tracker.currentDestination = "brazil";
         this.animations.map.confirm.passengers.text = String(Tracker.passengersBrazil);
         Tracker.passengersArriving = Tracker.passengersBrazil;
      }
      
      internal function frame1() : *
      {
         this.stop();
         this.loaderInfo.addEventListener(ProgressEvent.PROGRESS,this.PL_LOADING);
      }
      
      public function continueF(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         var so:SharedObject = GameController.getSharedObject();
         if(so.data.currentCity != "tupolev" && so.data != null)
         {
            GameController.transition.playTween(function():*
            {
               Tracker.continueGameFromMenu = true;
               loadGameF();
               trace(Tracker.totalCash);
               GameController.timeline.gotoAndStop(30);
            });
         }
         so.close();
      }
   }
}
