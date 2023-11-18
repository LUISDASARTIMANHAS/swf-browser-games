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
   
   [Embed(source="/_assets/assets.swf", symbol="TU_fla.randomcomputerFails_136")]
   public dynamic class randomcomputerFails_136 extends MovieClip
   {
       
      
      public function randomcomputerFails_136()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,2,this.frame3,3,this.frame4,4,this.frame5,5,this.frame6,6,this.frame7,7,this.frame8,8,this.frame9,9,this.frame10,10,this.frame11,11,this.frame12,12,this.frame13,13,this.frame14,14,this.frame15,15,this.frame16,16,this.frame17,17,this.frame18,18,this.frame19,19,this.frame20,20,this.frame21,21,this.frame22,22,this.frame23,23,this.frame24,24,this.frame25,25,this.frame26,26,this.frame27,27,this.frame28,28,this.frame29,29,this.frame30,30,this.frame31,31,this.frame32,32,this.frame33,33,this.frame34,34,this.frame35,35,this.frame36,36,this.frame37,37,this.frame38,38,this.frame39,39,this.frame40,40,this.frame41,41,this.frame42,42,this.frame43,43,this.frame44,44,this.frame45,45,this.frame46,46,this.frame47,47,this.frame48,48,this.frame49,49,this.frame50,50,this.frame51,51,this.frame52,52,this.frame53,53,this.frame54,54,this.frame55,55,this.frame56,56,this.frame57,57,this.frame58,58,this.frame59,59,this.frame60,60,this.frame61,61,this.frame62,62,this.frame63,63,this.frame64,64,this.frame65,65,this.frame66,66,this.frame67,67,this.frame68,68,this.frame69,69,this.frame70,70,this.frame71,79,this.frame80,80,this.frame81,81,this.frame82,82,this.frame83,83,this.frame84,84,this.frame85,85,this.frame86,86,this.frame87,87,this.frame88,88,this.frame89,89,this.frame90);
      }
      
      internal function frame63() : *
      {
         if(Tracker.company5planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
         if(Tracker.company5killed < 300)
         {
            gotoAndStop(68);
         }
      }
      
      internal function frame64() : *
      {
         if(Tracker.company1planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
         if(Tracker.company1killed < 300)
         {
            gotoAndStop(69);
         }
      }
      
      internal function frame70() : *
      {
         if(Tracker.company2planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
         if(Tracker.totalPassengersDelivered < 500)
         {
            gotoAndStop("Useless");
            return;
         }
         if(Tracker.company5planes >= 1)
         {
            Tracker.company2killed += Math.random() * Tracker.maxPassengers + 15;
            --Tracker.company2planes;
         }
         else
         {
            gotoAndStop(Math.round(Math.random() * 90));
         }
      }
      
      internal function frame71() : *
      {
         if(Tracker.company3planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
         if(Tracker.totalPassengersDelivered < 200)
         {
            gotoAndStop("Useless");
            return;
         }
         if(Tracker.company5planes >= 1)
         {
            Tracker.company3killed += Math.random() * Tracker.maxPassengers + 15;
            --Tracker.company3planes;
         }
         else
         {
            gotoAndStop(Math.round(Math.random() * 90));
         }
      }
      
      internal function frame30() : *
      {
         if(Tracker.company3planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
         if(Tracker.totalPassengersDelivered < 800)
         {
            gotoAndStop("Useless");
            return;
         }
      }
      
      internal function frame31() : *
      {
         if(Tracker.company3planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
         if(Tracker.totalPassengersDelivered < 800)
         {
            gotoAndStop("Useless");
            return;
         }
      }
      
      internal function frame32() : *
      {
         if(Tracker.company3planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
      }
      
      internal function frame33() : *
      {
         if(Tracker.company3planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
         Tracker.company3injured += 20;
      }
      
      internal function frame34() : *
      {
         if(Tracker.company3planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
         Tracker.company3injured += 60;
      }
      
      internal function frame35() : *
      {
         if(Tracker.company3planes >= 1)
         {
            Tracker.company3killed += Math.random() * Tracker.maxPassengers + 15;
            --Tracker.company3planes;
         }
         else
         {
            gotoAndStop(Math.round(Math.random() * 90));
         }
      }
      
      internal function frame36() : *
      {
         if(Tracker.company3planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
      }
      
      internal function frame37() : *
      {
         if(Tracker.company3planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
      }
      
      internal function frame38() : *
      {
         if(Tracker.totalPassengersDelivered < 200)
         {
            gotoAndStop("Useless");
            return;
         }
         if(Tracker.company4planes >= 1)
         {
            Tracker.company4killed += Math.random() * Tracker.maxPassengers + 15;
            --Tracker.company4planes;
         }
         else
         {
            gotoAndStop(Math.round(Math.random() * 90));
         }
      }
      
      internal function frame39() : *
      {
         if(Tracker.totalPassengersDelivered < 200)
         {
            gotoAndStop("Useless");
            return;
         }
         if(Tracker.company4planes >= 1)
         {
            Tracker.company4killed += Math.random() * Tracker.maxPassengers + 15;
            --Tracker.company4planes;
         }
         else
         {
            gotoAndStop(Math.round(Math.random() * 90));
         }
      }
      
      internal function frame80() : *
      {
         MovieClip(parent.parent).gotoAndStop(1);
         MovieClip(root).newsPaper.paper.okayBtn.removeEventListener(MouseEvent.CLICK,MovieClip(root).newsOkayF);
      }
      
      internal function frame81() : *
      {
         MovieClip(parent.parent).gotoAndStop(1);
         MovieClip(root).newsPaper.paper.okayBtn.removeEventListener(MouseEvent.CLICK,MovieClip(root).newsOkayF);
      }
      
      internal function frame82() : *
      {
         MovieClip(parent.parent).gotoAndStop(1);
         MovieClip(root).newsPaper.paper.okayBtn.removeEventListener(MouseEvent.CLICK,MovieClip(root).newsOkayF);
      }
      
      internal function frame83() : *
      {
         MovieClip(parent.parent).gotoAndStop(1);
         MovieClip(root).newsPaper.paper.okayBtn.removeEventListener(MouseEvent.CLICK,MovieClip(root).newsOkayF);
      }
      
      internal function frame40() : *
      {
         if(Tracker.totalPassengersDelivered < 200)
         {
            gotoAndStop("Useless");
            return;
         }
         if(Tracker.company4planes >= 1)
         {
            Tracker.company4killed += Math.random() * Tracker.maxPassengers + 15;
            --Tracker.company4planes;
         }
         else
         {
            gotoAndStop(Math.round(Math.random() * 90));
         }
      }
      
      internal function frame41() : *
      {
         if(Tracker.company4planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
      }
      
      internal function frame42() : *
      {
         if(Tracker.company4planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
         if(Tracker.totalPassengersDelivered < 800)
         {
            gotoAndStop("Useless");
            return;
         }
      }
      
      internal function frame43() : *
      {
         if(Tracker.company4planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
         if(Tracker.totalPassengersDelivered < 800)
         {
            gotoAndStop("Useless");
            return;
         }
      }
      
      internal function frame44() : *
      {
         if(Tracker.company4planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
      }
      
      internal function frame45() : *
      {
         if(Tracker.company4planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
         Tracker.company4injured += 20;
      }
      
      internal function frame46() : *
      {
         if(Tracker.company4planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
         Tracker.company4injured += 60;
      }
      
      internal function frame47() : *
      {
         if(Tracker.company4planes >= 1)
         {
            Tracker.company4killed += Math.random() * Tracker.maxPassengers + 15;
            --Tracker.company4planes;
         }
         else
         {
            gotoAndStop(Math.round(Math.random() * 90));
         }
      }
      
      internal function frame48() : *
      {
         if(Tracker.company4planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
      }
      
      internal function frame49() : *
      {
         if(Tracker.company4planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
      }
      
      internal function frame87() : *
      {
         MovieClip(parent.parent).gotoAndStop(1);
         MovieClip(root).newsPaper.paper.okayBtn.removeEventListener(MouseEvent.CLICK,MovieClip(root).newsOkayF);
      }
      
      internal function frame88() : *
      {
         MovieClip(parent.parent).gotoAndStop(1);
         MovieClip(root).newsPaper.paper.okayBtn.removeEventListener(MouseEvent.CLICK,MovieClip(root).newsOkayF);
      }
      
      internal function frame89() : *
      {
         MovieClip(parent.parent).gotoAndStop(1);
         MovieClip(root).newsPaper.paper.okayBtn.removeEventListener(MouseEvent.CLICK,MovieClip(root).newsOkayF);
      }
      
      internal function frame84() : *
      {
         MovieClip(parent.parent).gotoAndStop(1);
         MovieClip(root).newsPaper.paper.okayBtn.removeEventListener(MouseEvent.CLICK,MovieClip(root).newsOkayF);
      }
      
      internal function frame85() : *
      {
         MovieClip(parent.parent).gotoAndStop(1);
         MovieClip(root).newsPaper.paper.okayBtn.removeEventListener(MouseEvent.CLICK,MovieClip(root).newsOkayF);
      }
      
      internal function frame86() : *
      {
         MovieClip(parent.parent).gotoAndStop(1);
         MovieClip(root).newsPaper.paper.okayBtn.removeEventListener(MouseEvent.CLICK,MovieClip(root).newsOkayF);
      }
      
      internal function frame90() : *
      {
         MovieClip(parent.parent).gotoAndStop(1);
         MovieClip(root).newsPaper.paper.okayBtn.removeEventListener(MouseEvent.CLICK,MovieClip(root).newsOkayF);
      }
      
      internal function frame50() : *
      {
         if(Tracker.totalPassengersDelivered < 800)
         {
            gotoAndStop("Useless");
            return;
         }
         if(Tracker.company5planes >= 1)
         {
            Tracker.company5killed += Math.random() * Tracker.maxPassengers + 15;
            --Tracker.company5planes;
         }
         else
         {
            gotoAndStop(Math.round(Math.random() * 90));
         }
      }
      
      internal function frame51() : *
      {
         if(Tracker.totalPassengersDelivered < 800)
         {
            gotoAndStop("Useless");
            return;
         }
         if(Tracker.company5planes >= 1)
         {
            Tracker.company5killed += Math.random() * Tracker.maxPassengers + 15;
            --Tracker.company5planes;
         }
         else
         {
            gotoAndStop(Math.round(Math.random() * 90));
         }
      }
      
      internal function frame52() : *
      {
         if(Tracker.totalPassengersDelivered < 800)
         {
            gotoAndStop("Useless");
            return;
         }
         if(Tracker.company5planes >= 1)
         {
            Tracker.company5killed += Math.random() * Tracker.maxPassengers + 15;
            --Tracker.company5planes;
         }
         else
         {
            gotoAndStop(Math.round(Math.random() * 90));
         }
      }
      
      internal function frame53() : *
      {
         if(Tracker.company5planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
      }
      
      internal function frame10() : *
      {
         if(Tracker.company1planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
         Tracker.company1injured += 60;
      }
      
      internal function frame11() : *
      {
         if(Tracker.totalPassengersDelivered < 500)
         {
            gotoAndStop("Useless");
            return;
         }
         if(Tracker.company1planes >= 1)
         {
            Tracker.company1killed += Math.random() * Tracker.maxPassengers + 15;
            --Tracker.company1planes;
         }
         else
         {
            gotoAndStop(Math.round(Math.random() * 90));
         }
      }
      
      internal function frame12() : *
      {
         if(Tracker.company1planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
         }
      }
      
      internal function frame13() : *
      {
         if(Tracker.company1planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
         }
      }
      
      internal function frame14() : *
      {
         if(Tracker.totalPassengersDelivered < 500)
         {
            gotoAndStop("Useless");
            return;
         }
         if(Tracker.company2planes >= 1)
         {
            Tracker.company2killed += Math.random() * Tracker.maxPassengers + 15;
            --Tracker.company2planes;
         }
         else
         {
            gotoAndStop(Math.round(Math.random() * 90));
         }
      }
      
      internal function frame15() : *
      {
         if(Tracker.totalPassengersDelivered < 500)
         {
            gotoAndStop("Useless");
            return;
         }
         if(Tracker.company2planes >= 1)
         {
            Tracker.company2killed += Math.random() * Tracker.maxPassengers + 15;
            --Tracker.company2planes;
         }
         else
         {
            gotoAndStop(Math.round(Math.random() * 90));
         }
      }
      
      internal function frame16() : *
      {
         if(Tracker.totalPassengersDelivered < 500)
         {
            gotoAndStop("Useless");
            return;
         }
         if(Tracker.company2planes >= 1)
         {
            Tracker.company2killed += Math.random() * Tracker.maxPassengers + 15;
            --Tracker.company2planes;
         }
         else
         {
            gotoAndStop(Math.round(Math.random() * 90));
         }
      }
      
      internal function frame17() : *
      {
         if(Tracker.company2planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
      }
      
      internal function frame18() : *
      {
         if(Tracker.company2planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
         if(Tracker.totalPassengersDelivered < 500)
         {
            gotoAndStop("Useless");
         }
      }
      
      internal function frame19() : *
      {
         if(Tracker.company2planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
         if(Tracker.totalPassengersDelivered < 500)
         {
            gotoAndStop("Useless");
         }
      }
      
      internal function frame57() : *
      {
         if(Tracker.company5planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
         Tracker.company5injured += 20;
      }
      
      internal function frame58() : *
      {
         if(Tracker.company5planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
         Tracker.company5injured += 60;
      }
      
      internal function frame59() : *
      {
         if(Tracker.company5planes >= 1)
         {
            Tracker.company5killed += Math.random() * Tracker.maxPassengers + 15;
            --Tracker.company5planes;
         }
         else
         {
            gotoAndStop(Math.round(Math.random() * 90));
         }
      }
      
      internal function frame54() : *
      {
         if(Tracker.company5planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
      }
      
      internal function frame55() : *
      {
         if(Tracker.company5planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
         if(Tracker.totalPassengersDelivered < 800)
         {
            gotoAndStop("Useless");
            return;
         }
      }
      
      internal function frame56() : *
      {
         if(Tracker.company5planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
         if(Tracker.totalPassengersDelivered < 800)
         {
            gotoAndStop("Useless");
            return;
         }
      }
      
      internal function frame1() : *
      {
         gotoAndStop(Math.round(Math.random() * 90));
      }
      
      internal function frame2() : *
      {
         if(Tracker.company1planes >= 1)
         {
            Tracker.company1killed += Math.random() * Tracker.maxPassengers + 15;
            --Tracker.company1planes;
         }
         else
         {
            gotoAndStop(Math.round(Math.random() * 90));
         }
      }
      
      internal function frame3() : *
      {
         if(Tracker.totalPassengersDelivered < 500)
         {
            gotoAndStop("Useless");
            return;
         }
         if(Tracker.company1planes >= 1)
         {
            Tracker.company1killed += Math.random() * Tracker.maxPassengers + 15;
            --Tracker.company1planes;
         }
         else
         {
            gotoAndStop(Math.round(Math.random() * 90));
         }
      }
      
      internal function frame4() : *
      {
         if(Tracker.totalPassengersDelivered < 500)
         {
            gotoAndStop("Useless");
            return;
         }
         if(Tracker.company1planes >= 1)
         {
            Tracker.company1killed += Math.random() * Tracker.maxPassengers + 15;
            --Tracker.company1planes;
         }
         else
         {
            gotoAndStop(Math.round(Math.random() * 90));
         }
      }
      
      internal function frame5() : *
      {
         if(Tracker.company1planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
      }
      
      internal function frame6() : *
      {
         if(Tracker.company1planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
      }
      
      internal function frame7() : *
      {
         if(Tracker.company1planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
         if(Tracker.totalPassengersDelivered < 500)
         {
            gotoAndStop("Useless");
            return;
         }
      }
      
      internal function frame20() : *
      {
         if(Tracker.company2planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
         }
      }
      
      internal function frame9() : *
      {
         if(Tracker.company1planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
         Tracker.company1injured += 20;
      }
      
      internal function frame22() : *
      {
         if(Tracker.company2planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
         Tracker.company2injured += 60;
      }
      
      internal function frame23() : *
      {
         if(Tracker.totalPassengersDelivered < 500)
         {
            gotoAndStop("Useless");
            return;
         }
         if(Tracker.company2planes >= 1)
         {
            Tracker.company2killed += Math.random() * Tracker.maxPassengers + 15;
            --Tracker.company2planes;
         }
         else
         {
            gotoAndStop(Math.round(Math.random() * 90));
         }
      }
      
      internal function frame24() : *
      {
         if(Tracker.company2planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
      }
      
      internal function frame25() : *
      {
         if(Tracker.company2planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
      }
      
      internal function frame26() : *
      {
         if(Tracker.totalPassengersDelivered < 200)
         {
            gotoAndStop("Useless");
            return;
         }
         if(Tracker.company3planes >= 1)
         {
            Tracker.company3killed += Math.random() * Tracker.maxPassengers + 15;
            --Tracker.company3planes;
         }
         else
         {
            gotoAndStop(Math.round(Math.random() * 90));
         }
      }
      
      internal function frame8() : *
      {
         if(Tracker.company1planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
         if(Tracker.totalPassengersDelivered < 500)
         {
            gotoAndStop("Useless");
         }
      }
      
      internal function frame21() : *
      {
         if(Tracker.company2planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
         Tracker.company2injured += 20;
      }
      
      internal function frame29() : *
      {
         if(Tracker.company3planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
      }
      
      internal function frame67() : *
      {
         if(Tracker.company4planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
         if(Tracker.totalPassengersDelivered < 200)
         {
            gotoAndStop("Useless");
            return;
         }
         if(Tracker.company5planes >= 1)
         {
            Tracker.company4killed += Math.random() * Tracker.maxPassengers + 15;
            --Tracker.company4planes;
         }
         else
         {
            gotoAndStop(Math.round(Math.random() * 90));
         }
      }
      
      internal function frame60() : *
      {
         if(Tracker.company5planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
      }
      
      internal function frame61() : *
      {
         if(Tracker.company5planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
      }
      
      internal function frame62() : *
      {
         if(Tracker.company4planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
         if(Tracker.company4killed < 300)
         {
            gotoAndStop(67);
         }
      }
      
      internal function frame27() : *
      {
         if(Tracker.totalPassengersDelivered < 200)
         {
            gotoAndStop("Useless");
            return;
         }
         if(Tracker.company3planes >= 1)
         {
            Tracker.company3killed += Math.random() * Tracker.maxPassengers + 15;
            --Tracker.company3planes;
         }
         else
         {
            gotoAndStop(Math.round(Math.random() * 90));
         }
      }
      
      internal function frame28() : *
      {
         if(Tracker.totalPassengersDelivered < 200)
         {
            gotoAndStop("Useless");
            return;
         }
         if(Tracker.company3planes >= 1)
         {
            Tracker.company3killed += Math.random() * Tracker.maxPassengers + 15;
            --Tracker.company3planes;
         }
         else
         {
            gotoAndStop(Math.round(Math.random() * 90));
         }
      }
      
      internal function frame65() : *
      {
         if(Tracker.company2planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
         if(Tracker.company2killed < 300)
         {
            gotoAndStop(70);
         }
      }
      
      internal function frame66() : *
      {
         if(Tracker.company3planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
         if(Tracker.company3killed < 300)
         {
            gotoAndStop(71);
         }
      }
      
      internal function frame68() : *
      {
         if(Tracker.company5planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
         if(Tracker.totalPassengersDelivered < 800)
         {
            gotoAndStop("Useless");
            return;
         }
         if(Tracker.company5planes >= 1)
         {
            Tracker.company5killed += Math.random() * Tracker.maxPassengers + 15;
            --Tracker.company5planes;
         }
         else
         {
            gotoAndStop(Math.round(Math.random() * 90));
         }
      }
      
      internal function frame69() : *
      {
         if(Tracker.company1planes < 1)
         {
            gotoAndStop(Math.round(Math.random() * 90));
            return;
         }
         if(Tracker.totalPassengersDelivered < 500)
         {
            gotoAndStop("Useless");
            return;
         }
         if(Tracker.company5planes >= 1)
         {
            Tracker.company1killed += Math.random() * Tracker.maxPassengers + 15;
            --Tracker.company1planes;
         }
         else
         {
            gotoAndStop(Math.round(Math.random() * 90));
         }
      }
   }
}
