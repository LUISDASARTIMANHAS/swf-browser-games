package PlazaMall_fla
{
   import adobe.utils.*;
   import flash.accessibility.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.Game_523")]
   public dynamic class Game_523 extends MovieClip
   {
       
      
      public var disableFloor:*;
      
      public var disableBar:*;
      
      public var promoteCost1:TextField;
      
      public var promoteCost2:TextField;
      
      public var promoteCost3:TextField;
      
      public var promoteCost4:TextField;
      
      public var promoteCost5:TextField;
      
      public var promoteCost6:TextField;
      
      public var promoteCost8:TextField;
      
      public var workStatus1:TextField;
      
      public var workStatus3:TextField;
      
      public var workStatus4:TextField;
      
      public var workStatus5:TextField;
      
      public var workStatus6:TextField;
      
      public var workStatus7:TextField;
      
      public var workStatus8:TextField;
      
      public var workStatus2:TextField;
      
      public var promoteCost7:TextField;
      
      public var i:*;
      
      public var workStatus:*;
      
      public var page:*;
      
      public var btnNextPage:SimpleButton;
      
      public var disableFloor1:MovieClip;
      
      public var disableFloor2:MovieClip;
      
      public var lvSymbol1:MovieClip;
      
      public var lvSymbol2:MovieClip;
      
      public var lvSymbol3:MovieClip;
      
      public var disableFloor7:MovieClip;
      
      public var lvSymbol7:MovieClip;
      
      public var disableFloor4:MovieClip;
      
      public var pageNumber:TextField;
      
      public var disableFloor6:MovieClip;
      
      public var lvSymbol5:MovieClip;
      
      public var lvSymbol6:MovieClip;
      
      public var lvSymbol8:MovieClip;
      
      public var disableFloor3:MovieClip;
      
      public var lvSymbol4:MovieClip;
      
      public var disableFloor8:MovieClip;
      
      public var disableFloor5:MovieClip;
      
      public var floorChange1:MovieClip;
      
      public var floorChange2:MovieClip;
      
      public var floorChange3:MovieClip;
      
      public var floorChange4:MovieClip;
      
      public var floorChange5:MovieClip;
      
      public var floorChange6:MovieClip;
      
      public var floorChange7:MovieClip;
      
      public var floorChange8:MovieClip;
      
      public var btnPromote1:SimpleButton;
      
      public var btnPromote2:SimpleButton;
      
      public var btnPromote3:SimpleButton;
      
      public var btnPromote5:SimpleButton;
      
      public var btnPromote7:SimpleButton;
      
      public var btnPromote4:SimpleButton;
      
      public var btnPromote8:SimpleButton;
      
      public var btnClose:SimpleButton;
      
      public var btnPromote6:SimpleButton;
      
      public var floorChange:*;
      
      public var disablePromote1:MovieClip;
      
      public var disablePromote2:MovieClip;
      
      public var disablePromote3:MovieClip;
      
      public var disablePromote4:MovieClip;
      
      public var disablePromote5:MovieClip;
      
      public var disablePromote7:MovieClip;
      
      public var disablePromote6:MovieClip;
      
      public var disablePromote8:MovieClip;
      
      public var disableBar4:MovieClip;
      
      public var disableBar6:MovieClip;
      
      public var disableBar5:MovieClip;
      
      public var disableBar1:MovieClip;
      
      public var disableBar3:MovieClip;
      
      public var disableBar7:MovieClip;
      
      public var disableBar8:MovieClip;
      
      public var disableBar2:MovieClip;
      
      public var crewList:*;
      
      public var promoteCost:*;
      
      public var cs1:MovieClip;
      
      public var cs2:MovieClip;
      
      public var cs3:MovieClip;
      
      public var cs5:MovieClip;
      
      public var cs8:MovieClip;
      
      public var lvSymbol:*;
      
      public var deactiveBar:MovieClip;
      
      public var cs6:MovieClip;
      
      public var cs7:MovieClip;
      
      public var cs4:MovieClip;
      
      public var btnPrevPage:SimpleButton;
      
      public var head:*;
      
      public var btnPromote:*;
      
      public var disablePromote:*;
      
      public function Game_523()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function nextPage(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc2_ = new SE_Close();
         _loc2_.play(0,0,head.seTransform);
         _loc3_ = this.parent;
         ++page;
         _loc3_.setCrewList();
      }
      
      public function changeFloor(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         _loc2_ = param1.currentTarget;
         _loc3_ = _loc2_.parent;
         _loc4_ = floorChange.indexOf(_loc3_);
         _loc5_ = this.parent;
         (_loc6_ = new SE_Select()).play(0,0,head.seTransform);
         if(_loc2_.name == "btnUpFloor")
         {
            ++crewList[_loc4_].relation.shiftFloor;
            if(crewList[_loc4_].relation.shiftFloor >= head.floorList.length - 1)
            {
               crewList[_loc4_].relation.shiftFloor = -1;
            }
         }
         else if(_loc2_.name == "btnDownFloor")
         {
            --crewList[_loc4_].relation.shiftFloor;
            if(crewList[_loc4_].relation.shiftFloor < -1)
            {
               crewList[_loc4_].relation.shiftFloor = head.floorList.length - 2;
            }
         }
         _loc5_.setCrewList();
      }
      
      internal function frame1() : *
      {
         head = root;
         deactiveBar.jobDesk.text = "Technician";
         page = 1;
         disableBar = new Array();
         disableBar.push(disableBar1);
         disableBar.push(disableBar2);
         disableBar.push(disableBar3);
         disableBar.push(disableBar4);
         disableBar.push(disableBar5);
         disableBar.push(disableBar6);
         disableBar.push(disableBar7);
         disableBar.push(disableBar8);
         disableFloor = new Array();
         disableFloor.push(disableFloor1);
         disableFloor.push(disableFloor2);
         disableFloor.push(disableFloor3);
         disableFloor.push(disableFloor4);
         disableFloor.push(disableFloor5);
         disableFloor.push(disableFloor6);
         disableFloor.push(disableFloor7);
         disableFloor.push(disableFloor8);
         crewList = new Array();
         crewList.push(cs1);
         crewList.push(cs2);
         crewList.push(cs3);
         crewList.push(cs4);
         crewList.push(cs5);
         crewList.push(cs6);
         crewList.push(cs7);
         crewList.push(cs8);
         lvSymbol = new Array();
         lvSymbol.push(lvSymbol1);
         lvSymbol.push(lvSymbol2);
         lvSymbol.push(lvSymbol3);
         lvSymbol.push(lvSymbol4);
         lvSymbol.push(lvSymbol5);
         lvSymbol.push(lvSymbol6);
         lvSymbol.push(lvSymbol7);
         lvSymbol.push(lvSymbol8);
         btnPromote = new Array();
         btnPromote.push(btnPromote1);
         btnPromote.push(btnPromote2);
         btnPromote.push(btnPromote3);
         btnPromote.push(btnPromote4);
         btnPromote.push(btnPromote5);
         btnPromote.push(btnPromote6);
         btnPromote.push(btnPromote7);
         btnPromote.push(btnPromote8);
         disablePromote = new Array();
         disablePromote.push(disablePromote1);
         disablePromote.push(disablePromote2);
         disablePromote.push(disablePromote3);
         disablePromote.push(disablePromote4);
         disablePromote.push(disablePromote5);
         disablePromote.push(disablePromote6);
         disablePromote.push(disablePromote7);
         disablePromote.push(disablePromote8);
         promoteCost = new Array();
         promoteCost.push(promoteCost1);
         promoteCost.push(promoteCost2);
         promoteCost.push(promoteCost3);
         promoteCost.push(promoteCost4);
         promoteCost.push(promoteCost5);
         promoteCost.push(promoteCost6);
         promoteCost.push(promoteCost7);
         promoteCost.push(promoteCost8);
         workStatus = new Array();
         workStatus.push(workStatus1);
         workStatus.push(workStatus2);
         workStatus.push(workStatus3);
         workStatus.push(workStatus4);
         workStatus.push(workStatus5);
         workStatus.push(workStatus6);
         workStatus.push(workStatus7);
         workStatus.push(workStatus8);
         floorChange = new Array();
         floorChange.push(floorChange1);
         floorChange.push(floorChange2);
         floorChange.push(floorChange3);
         floorChange.push(floorChange4);
         floorChange.push(floorChange5);
         floorChange.push(floorChange6);
         floorChange.push(floorChange7);
         floorChange.push(floorChange8);
         i = 0;
         while(i < crewList.length)
         {
            crewList[i].colorMod = -1;
            ++i;
         }
         i = 0;
         while(i < btnPromote.length)
         {
            btnPromote[i].addEventListener(MouseEvent.CLICK,promoteEmployee);
            ++i;
         }
         i = 0;
         while(i < disableBar.length)
         {
            disableBar[i].addEventListener(MouseEvent.CLICK,searchEmployee);
            ++i;
         }
         i = 0;
         while(i < floorChange.length)
         {
            floorChange[i].btnUpFloor.addEventListener(MouseEvent.CLICK,changeFloor);
            floorChange[i].btnDownFloor.addEventListener(MouseEvent.CLICK,changeFloor);
            ++i;
         }
         btnPrevPage.addEventListener(MouseEvent.CLICK,prevPage);
         btnNextPage.addEventListener(MouseEvent.CLICK,nextPage);
         btnClose.addEventListener(MouseEvent.CLICK,closeList);
      }
      
      public function searchEmployee(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:BitmapFilter = null;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         _loc2_ = param1.currentTarget;
         if(_loc2_.buttonMode)
         {
            _loc3_ = new SE_Select();
            _loc3_.play(0,0,head.seTransform);
            if(head.visitorFocus != null)
            {
               head.visitorFocus.filters = [];
            }
            if(head.menuParent.numChildren > 0)
            {
               (_loc8_ = head.menuParent.getChildAt(0)).closeMenu();
            }
            (_loc4_ = new UI_EmployeeInformation()).x = head.menuX;
            _loc4_.y = head.menuY;
            head.menuParent.addChild(_loc4_);
            _loc5_ = disableBar.indexOf(_loc2_);
            head.visitorFocus = crewList[_loc5_].relation;
            _loc6_ = new GlowFilter(16746496,0.9,5,5,2);
            (_loc7_ = new Array()).push(_loc6_);
            head.visitorFocus.filters = _loc7_;
            this.parent.visible = false;
         }
      }
      
      public function promoteEmployee(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         _loc2_ = param1.currentTarget;
         _loc3_ = btnPromote.indexOf(_loc2_);
         if(head.cash - head.purchase + head.recive >= crewList[_loc3_].relation.UPGRADE_COST)
         {
            (_loc4_ = new SE_Popularity()).play(0,0,head.seTransform);
            _loc5_ = 0;
            while(_loc5_ < disableBar.length)
            {
               disableBar[_loc5_].buttonMode = false;
               _loc5_++;
            }
            _loc6_ = this.parent;
            (_loc7_ = new fx_upgrade_crew()).name = "upgrade";
            btnPromote[_loc3_].visible = false;
            disablePromote[_loc3_].visible = true;
            crewList[_loc3_].relation.addChild(_loc7_);
            crewList[_loc3_].relation.addEventListener(Event.ENTER_FRAME,_loc6_.promoteEmployee);
            head.addCashUpdate(crewList[_loc3_].relation.UPGRADE_COST,crewList[_loc3_].relation.worldX,crewList[_loc3_].relation.worldY - crewList[_loc3_].relation.height,false);
         }
         else
         {
            head.addNotification("Not enough cash");
         }
      }
      
      public function closeList(param1:MouseEvent) : void
      {
         this.parent.visible = false;
      }
      
      public function prevPage(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc2_ = new SE_Close();
         _loc2_.play(0,0,head.seTransform);
         _loc3_ = this.parent;
         --page;
         _loc3_.setCrewList();
      }
      
      public function crewUpdate(param1:Event) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         _loc2_ = param1.currentTarget;
         _loc3_ = crewList.indexOf(_loc2_);
         if(Boolean(_loc2_.visible) && _loc2_.relation != null)
         {
            _loc2_.work.visible = _loc2_.relation.isRepairing;
            _loc2_.workSymbol.visible = _loc2_.relation.isRepairing;
            _loc2_.walk.visible = !_loc2_.relation.isRepairing && _loc2_.relation.dx != 0;
            _loc2_.stanby.visible = _loc2_.relation.dx == 0 || _loc2_.relation.isRepairing;
            _loc2_.scaleX = _loc2_.relation.scaleX;
            if(_loc2_.relation.getChildByName("upgrade") != null)
            {
               _loc4_ = _loc2_.relation.getChildByName("upgrade");
               if(_loc2_.getChildByName("upgrade") == null)
               {
                  (_loc5_ = new fx_upgrade_crew()).name = "upgrade";
                  _loc5_.gotoAndPlay(_loc4_.currentFrame);
                  _loc2_.addChild(_loc5_);
               }
            }
            _loc2_.transform.colorTransform = new ColorTransform(1,1,1,1,_loc2_.relation.transform.colorTransform.redOffset,_loc2_.relation.transform.colorTransform.greenOffset,_loc2_.relation.transform.colorTransform.blueOffset,0);
            if(_loc2_.relation.goHome)
            {
               if(_loc2_.relation.worldX >= 0 && _loc2_.relation.worldX <= head.MAX_WIDTH)
               {
                  if(workStatus[_loc3_].text.toUpperCase() != "Leaving".toUpperCase())
                  {
                     (_loc6_ = workStatus[_loc3_].defaultTextFormat).color = 16746496;
                     workStatus[_loc3_].defaultTextFormat = _loc6_;
                     workStatus[_loc3_].text = "Leaving";
                  }
               }
               else if(workStatus[_loc3_].text.toUpperCase() != "Out of duty".toUpperCase())
               {
                  (_loc6_ = workStatus[_loc3_].defaultTextFormat).color = 16711680;
                  workStatus[_loc3_].defaultTextFormat = _loc6_;
                  workStatus[_loc3_].text = "Out of duty";
               }
            }
            else if(workStatus[_loc3_].text.toUpperCase() != "Working".toUpperCase())
            {
               (_loc6_ = workStatus[_loc3_].defaultTextFormat).color = 65280;
               workStatus[_loc3_].defaultTextFormat = _loc6_;
               workStatus[_loc3_].text = "Working";
            }
            if(_loc2_.currentFrame != _loc2_.relation.cLevel)
            {
               _loc2_.gotoAndStop(_loc2_.relation.cLevel);
            }
         }
      }
   }
}
