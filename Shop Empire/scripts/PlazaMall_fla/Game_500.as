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
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.Game_500")]
   public dynamic class Game_500 extends MovieClip
   {
       
      
      public var pauseScreen:MovieClip;
      
      public var crewNumber:TextField;
      
      public var legend:*;
      
      public var spdButton3x:SimpleButton;
      
      public var vHappy:*;
      
      public var BtnVisitorActive:MovieClip;
      
      public var tipsHistory:MovieClip;
      
      public var dayNightToggle:MovieClip;
      
      public var btnStatistic:MovieClip;
      
      public var nowBlur:*;
      
      public var BoothActive:MovieClip;
      
      public var food:*;
      
      public var gameMenu:MovieClip;
      
      public var employeeList:MovieClip;
      
      public const btnArr:Array = ["btnDrugStore","btnBabyShop","btnBookStore","btnBoutiqueA","btnBoutiqueB","btnToyStore","btnBarberShop","btnJewelry","btnSupermarket","btnCake","btnIceCream","btnBurger","btnSteak","btnSushi","btnCafe","btnCinema","btnGameCenter"];
      
      public const objBtnArr:Array = [BuildDrugStore,BuildBabyShop,BuildBookStore,BuildBoutiqueA,BuildBoutiqueB,BuildToyStore,BuildSalon,BuildJewelry,BuildSupermarket,BuildCake,BuildIceCream,BuildBurger,BuildSteak,BuildSushi,BuildCafe,BuildCinema,BuildGameCenter];
      
      public var boothParam:MovieClip;
      
      public var employeeParam:MovieClip;
      
      public var BtnBoothActive:MovieClip;
      
      public var cashInfo:TextField;
      
      public var spdOffPause:MovieClip;
      
      public var tcNum:*;
      
      public var btnMailBox:MovieClip;
      
      public var tenantNumber:TextField;
      
      public var btnEntertainment:MovieClip;
      
      public var dayTime:Number;
      
      public var spdOffResume:MovieClip;
      
      public var btnSelect:MovieClip;
      
      public var i:*;
      
      public var BtnEmployeeActive:MovieClip;
      
      public var addBlur:*;
      
      public var visitorParam:MovieClip;
      
      public var btnParameter:*;
      
      public var vAngry:*;
      
      public const hireArr:Array = [HireCleaningService,HireTechnician,HireSecurity];
      
      public var dayMinute:Number;
      
      public var tempSpeed:Number;
      
      public const btnEmployeeArr:Array = ["btnCleaningService","btnTechnician","btnSecurity"];
      
      public var btnFood:MovieClip;
      
      public var legendHelp:MovieClip;
      
      public var general:*;
      
      public var isPause:*;
      
      public var csNum:*;
      
      public var vNormal:*;
      
      public var buttonList:*;
      
      public var VisitorActive:MovieClip;
      
      public var sectorConnection:*;
      
      public var entertainmentSector:MovieClip;
      
      public var playerName:TextField;
      
      public var autoSavePosition:MovieClip;
      
      public var scNum:*;
      
      public var vUpset:*;
      
      public var btnEmployee:MovieClip;
      
      public var sectorList:*;
      
      public var pauseSymbol:MovieClip;
      
      public var btnAchievement:MovieClip;
      
      public var allButtonDisable:Boolean;
      
      public var objective:MovieClip;
      
      public var parameterShown:*;
      
      public var spdButtonResume:SimpleButton;
      
      public var btnRestRoom:MovieClip;
      
      public var visitorNumber:TextField;
      
      public var foodSector:MovieClip;
      
      public var btnElevator:MovieClip;
      
      public var btnShop:MovieClip;
      
      public var myParent:*;
      
      public var EmployeeActive:MovieClip;
      
      public var btnNextCity:SimpleButton;
      
      public var btnLegend:MovieClip;
      
      public var entertainment:*;
      
      public var commentList:*;
      
      public var speedActive1:MovieClip;
      
      public var speedActive3:MovieClip;
      
      public var speedActive2:MovieClip;
      
      public var btnDrag:MovieClip;
      
      public var employeeSector:MovieClip;
      
      public var nextTownWarning:MovieClip;
      
      public var btnHelp:SimpleButton;
      
      public var spdButtonPause:SimpleButton;
      
      public var dayPass:TextField;
      
      public var btnMenu:MovieClip;
      
      public var spdButton1x:SimpleButton;
      
      public var parameterList:*;
      
      public var shopSector:MovieClip;
      
      public var spdButton2x:SimpleButton;
      
      public function Game_500()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function buttonMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc2_ = param1.currentTarget;
         if(_loc2_.btnDefault.buttonMode)
         {
            _loc3_ = buttonList.indexOf(_loc2_);
            legend = new LegendWideBox();
            legend.alignment = "Left";
            if(_loc3_ >= 0)
            {
               legend.commentText = commentList[_loc3_];
            }
            myParent.noticeParent.addChild(legend);
         }
      }
      
      public function sectorBtnClick(param1:MouseEvent) : void
      {
         var target:* = undefined;
         var bParent:* = undefined;
         var sIndex:* = undefined;
         var newSE:* = undefined;
         var temp:* = undefined;
         var index:* = undefined;
         var eIndex:* = undefined;
         var event:MouseEvent = param1;
         target = event.currentTarget;
         disableBuilding();
         bParent = target.parent;
         sIndex = bParent.btnList.indexOf(target);
         if(myParent.cash - myParent.purchase + myParent.recive + myParent.recive >= bParent.priceList[sIndex])
         {
            with(target)
            {
               
               if(btnTog.canClick)
               {
                  newSE = new SE_Select();
                  newSE.play(0,0,myParent.seTransform);
                  if(name == "btnHall")
                  {
                     temp = new BuildHall();
                     temp.x = event.stageX - temp.width / 2;
                     temp.y = event.stageY - temp.height / 2;
                     temp.alpha = 0.3;
                     myParent.buildParent.addChild(temp);
                  }
                  else
                  {
                     index = btnArr.indexOf(name);
                     if(index >= 0)
                     {
                        if(target.btnTog.tog)
                        {
                           temp = new objBtnArr[index]();
                           temp.name = btnArr[index];
                           temp.x = event.stageX - temp.width / 2;
                           temp.y = event.stageY - temp.height / 2;
                           temp.alpha = 0.3;
                           myParent.buildParent.addChild(temp);
                        }
                     }
                     else
                     {
                        eIndex = btnEmployeeArr.indexOf(name);
                        if(eIndex >= 0)
                        {
                           if(target.btnTog.tog)
                           {
                              temp = new hireArr[eIndex]();
                              temp.stat = btnEmployeeArr[eIndex];
                              temp.x = event.stageX;
                              temp.y = event.stageY + temp.height / 2;
                              temp.alpha = 0.3;
                              myParent.buildParent.addChild(temp);
                           }
                        }
                     }
                  }
               }
               else
               {
                  newSE = new SE_SelectUnable();
                  newSE.play(0,0,myParent.seTransform);
               }
            }
         }
         else if(target.btnTog.canClick)
         {
            target.btnTog.tog = false;
            myParent.addNotification("Not enough cash");
         }
      }
      
      public function countBooth() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         general = 0;
         food = 0;
         entertainment = 0;
         _loc1_ = 0;
         while(_loc1_ < myParent.tenantList.length)
         {
            _loc2_ = myParent.tenantList[_loc1_];
            _loc3_ = btnArr.indexOf(_loc2_.name);
            if(_loc3_ > 14)
            {
               ++entertainment;
            }
            else if(_loc3_ > 8)
            {
               ++food;
            }
            else if(_loc3_ >= 0)
            {
               ++general;
            }
            else if(_loc2_ is TenantHall)
            {
               ++entertainment;
            }
            _loc1_++;
         }
      }
      
      public function LegendAppear(param1:MouseEvent) : void
      {
         legendHelp.visible = !legendHelp.visible;
      }
      
      public function editFilter(param1:Event) : void
      {
         var _loc2_:GlowFilter = null;
         if(btnMailBox.filters.length > 0)
         {
            if(btnMailBox.filters[0] is GlowFilter)
            {
               _loc2_ = btnMailBox.filters[0];
               _loc2_.blurX = nowBlur;
               _loc2_.blurY = nowBlur;
               btnMailBox.filters = [_loc2_];
               if(nowBlur >= 15)
               {
                  addBlur = -2;
               }
               else if(nowBlur < 3)
               {
                  addBlur = 1;
               }
               nowBlur += addBlur;
            }
         }
         if(btnMailBox.btnDefault.tog)
         {
            if(tipsHistory.currentLabel == "all hide")
            {
               tipsHistory.gotoAndPlay("begin reveal");
            }
         }
         else if(tipsHistory.currentLabel == "reveal")
         {
            tipsHistory.removeEventListener(Event.ENTER_FRAME,tipsHistory.UpdatePosition);
            tipsHistory.gotoAndPlay("begin hide");
         }
      }
      
      public function CreateElevator(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         disableBuilding();
         if(myParent.cash - myParent.purchase + myParent.recive >= myParent.SUPPORT_PRICE[0])
         {
            if(btnElevator.btnDefault.tog)
            {
               _loc2_ = new BuildElevator();
               _loc2_.name = "btnElevator";
               _loc2_.x = param1.stageX - _loc2_.width / 2;
               _loc2_.y = param1.stageY;
               _loc2_.alpha = 0.3;
               myParent.buildParent.addChild(_loc2_);
            }
         }
         else
         {
            btnElevator.btnDefault.tog = false;
            myParent.addNotification("Not enough cash");
         }
      }
      
      public function removeAllListener() : void
      {
         removeEventListener(Event.ENTER_FRAME,changeDayTime);
         removeEventListener(Event.ENTER_FRAME,sectorUpdate);
         removeEventListener(Event.ENTER_FRAME,buttonUpdate);
         removeEventListener(Event.ENTER_FRAME,CheckParameter);
         tipsHistory.removeEventListener(Event.ENTER_FRAME,tipsHistory.UpdatePosition);
      }
      
      public function disableAllSector() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc1_ = 0;
         while(_loc1_ < sectorList.length)
         {
            _loc2_ = sectorList[_loc1_].sectorList;
            _loc3_ = 0;
            while(_loc3_ < _loc2_.btnList.length)
            {
               _loc2_.btnList[_loc3_].btnTog.tog = false;
               _loc3_++;
            }
            _loc1_++;
         }
      }
      
      public function HideParameter(param1:Number = -1) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = 0;
         while(_loc2_ < parameterList.length)
         {
            if(_loc2_ != param1)
            {
               parameterList[_loc2_].visible = false;
            }
            else
            {
               parameterList[_loc2_].visible = !parameterList[_loc2_].visible;
            }
            _loc2_++;
         }
      }
      
      internal function frame1() : *
      {
         isPause = false;
         dayPass.autoSize = TextFieldAutoSize.CENTER;
         myParent = root;
         parameterList = new Array();
         parameterList.push(VisitorActive);
         parameterList.push(EmployeeActive);
         parameterList.push(BoothActive);
         HideParameter();
         gameMenu.visible = false;
         allButtonDisable = true;
         addEventListener(Event.ENTER_FRAME,changeDayTime);
         buttonList = new Array();
         buttonList.push(btnDrag);
         buttonList.push(btnShop);
         buttonList.push(btnFood);
         buttonList.push(btnEntertainment);
         buttonList.push(btnRestRoom);
         buttonList.push(btnElevator);
         buttonList.push(btnEmployee);
         buttonList.push(btnStatistic);
         commentList = new Array();
         commentList.push("Use for scroll screen with mouse");
         commentList.push("Build Shop Center");
         commentList.push("Build Food Center");
         commentList.push("Build Entertainment");
         commentList.push("Restroom ($ " + myParent.MoneySplit(myParent.SUPPORT_PRICE[1]) + ".-)");
         commentList.push("Elevator ($ " + myParent.MoneySplit(myParent.SUPPORT_PRICE[0]) + ".-)");
         commentList.push("Hire Employee");
         commentList.push("View the Statistic");
         btnRestRoom.addEventListener(MouseEvent.CLICK,CreateRestroom);
         btnElevator.addEventListener(MouseEvent.CLICK,CreateElevator);
         btnStatistic.addEventListener(MouseEvent.CLICK,ShowStatistic);
         sectorList = new Array();
         sectorList.push(shopSector);
         sectorList.push(foodSector);
         sectorList.push(entertainmentSector);
         sectorList.push(employeeSector);
         sectorConnection = new Array();
         sectorConnection.push(btnShop);
         sectorConnection.push(btnFood);
         sectorConnection.push(btnEntertainment);
         sectorConnection.push(btnEmployee);
         i = 0;
         while(i < buttonList.length)
         {
            buttonList[i].addEventListener(MouseEvent.CLICK,deactiveAll);
            buttonList[i].addEventListener(MouseEvent.MOUSE_OVER,buttonMouseOver);
            buttonList[i].addEventListener(MouseEvent.MOUSE_OUT,btnCommentDisappear);
            ++i;
         }
         i = 0;
         while(i < sectorList.length)
         {
            sectorList[i].visible = false;
            ++i;
         }
         addEventListener(Event.ENTER_FRAME,sectorUpdate);
         addEventListener(Event.ENTER_FRAME,buttonUpdate);
         SectorButtonActive();
         tempSpeed = -1;
         btnMenu.addEventListener(MouseEvent.CLICK,MenuAppear);
         btnLegend.addEventListener(MouseEvent.CLICK,LegendAppear);
         btnAchievement.addEventListener(MouseEvent.CLICK,AchievementAppear);
         btnSelect.addEventListener(MouseEvent.CLICK,btnSelectClicked);
         btnSelect.addEventListener(MouseEvent.MOUSE_OVER,btnCommentAppear);
         btnSelect.addEventListener(MouseEvent.MOUSE_OUT,btnCommentDisappear);
         spdButtonPause.addEventListener(MouseEvent.CLICK,frezze);
         spdButtonResume.addEventListener(MouseEvent.CLICK,normalSpeed);
         spdButton1x.addEventListener(MouseEvent.CLICK,normalSpeed);
         spdButton2x.addEventListener(MouseEvent.CLICK,fastSpeed);
         spdButton3x.addEventListener(MouseEvent.CLICK,topSpeed);
         btnParameter = new Array();
         btnParameter.push(BtnVisitorActive);
         btnParameter.push(BtnEmployeeActive);
         btnParameter.push(BtnBoothActive);
         i = 0;
         while(i < btnParameter.length)
         {
            btnParameter[i].buttonMode = true;
            btnParameter[i].addEventListener(MouseEvent.CLICK,ParameterOnClick);
            ++i;
         }
         employeeList.visible = false;
         parameterShown = null;
         visitorParam.visible = false;
         employeeParam.visible = false;
         boothParam.visible = false;
         addEventListener(Event.ENTER_FRAME,CheckParameter);
         tipsHistory.visible = false;
         btnMailBox.addEventListener(MouseEvent.CLICK,showHideTips);
         btnMailBox.addEventListener(MouseEvent.CLICK,deactiveAll);
         nowBlur = 2;
         addBlur = 10;
         addEventListener(Event.ENTER_FRAME,editFilter);
         myParent.tutorialShow.visible = false;
         myParent.tutorialShow.mouseChildren = false;
         myParent.tutorialShow.mouseEnabled = false;
         btnHelp.addEventListener(MouseEvent.CLICK,ToggleHelp);
      }
      
      public function btnSelectClicked(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc2_ = new SE_Select();
         _loc2_.play(0,0,myParent.seTransform);
         disableAllSector();
         _loc3_ = 0;
         while(_loc3_ < buttonList.length)
         {
            buttonList[_loc3_].btnDefault.tog = false;
            _loc3_++;
         }
         btnMailBox.btnDefault.tog = false;
         disableBuilding();
      }
      
      public function btnCommentDisappear(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         try
         {
            myParent.noticeParent.removeChild(legend);
         }
         catch(e:Error)
         {
         }
      }
      
      public function ShowStatistic(param1:MouseEvent) : void
      {
         disableBuilding();
         if(btnStatistic.btnDefault.tog)
         {
            myParent.budget.appear = true;
         }
      }
      
      public function changeDayTime(param1:Event) : void
      {
         if(dayTime >= 6 && dayTime < 18)
         {
            dayNightToggle.gotoAndPlay("Day");
         }
         else
         {
            dayNightToggle.gotoAndPlay("Night");
         }
         dayNightToggle.longClock.rotation = dayMinute * 6;
         dayNightToggle.shortClock.rotation = dayTime % 12 * 30 + dayMinute / 2;
         spdButtonPause.visible = !gameMenu.visible && myParent.gameSpeed > 0;
         spdButtonResume.visible = !gameMenu.visible && myParent.gameSpeed == 0;
         spdButton1x.visible = !(Boolean(gameMenu.visible) || myParent.gameSpeed == 1);
         spdButton2x.visible = !(Boolean(gameMenu.visible) || myParent.gameSpeed == 2);
         spdButton3x.visible = !(Boolean(gameMenu.visible) || myParent.gameSpeed == 3);
         speedActive1.visible = myParent.gameSpeed != 0;
         speedActive2.visible = myParent.gameSpeed != 0;
         speedActive3.visible = myParent.gameSpeed != 0;
         spdOffPause.visible = tempSpeed > 0;
         spdOffResume.visible = tempSpeed == 0;
         pauseScreen.visible = myParent.gameSpeed <= 0;
         pauseSymbol.visible = isPause;
      }
      
      public function buttonUpdate(param1:Event) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc2_ = false;
         _loc3_ = 0;
         while(_loc3_ < buttonList.length)
         {
            if(buttonList[_loc3_].btnDefault.tog)
            {
               _loc2_ = true;
            }
            _loc3_++;
         }
         allButtonDisable = !_loc2_ && !btnMailBox.btnDefault.tog;
         if(allButtonDisable)
         {
            btnSelect.btnDefault.tog = true;
         }
         else
         {
            btnSelect.btnDefault.tog = false;
         }
      }
      
      public function ToggleHelp(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = new SE_Select();
         _loc2_.play(0,0,myParent.seTransform);
         myParent.tutorialShow.visible = !myParent.tutorialShow.visible;
      }
      
      public function deactiveButton() : void
      {
         var _loc1_:* = undefined;
         btnSelect.btnDefault.buttonMode = false;
         btnSelect.removeEventListener(MouseEvent.CLICK,btnSelectClicked);
         _loc1_ = 0;
         while(_loc1_ < buttonList.length)
         {
            buttonList[_loc1_].btnDefault.buttonMode = false;
            buttonList[_loc1_].removeEventListener(MouseEvent.CLICK,deactiveAll);
            _loc1_++;
         }
         SectorButtonDeactive();
      }
      
      public function countEmployee() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         csNum = 0;
         tcNum = 0;
         scNum = 0;
         _loc1_ = 0;
         while(_loc1_ < myParent.crewList.length)
         {
            _loc2_ = myParent.crewList[_loc1_];
            if(_loc2_ is CrewCleaningServicelv1 || _loc2_ is CrewCleaningServicelv2 || _loc2_ is CrewCleaningServicelv3)
            {
               ++csNum;
            }
            else if(_loc2_ is CrewTechnicianlv1 || _loc2_ is CrewTechnicianlv2 || _loc2_ is CrewTechnicianlv3)
            {
               ++tcNum;
            }
            else if(_loc2_ is CrewSecuritylv1 || _loc2_ is CrewSecuritylv2 || _loc2_ is CrewSecuritylv3)
            {
               ++scNum;
            }
            _loc1_++;
         }
      }
      
      public function ParameterOnClick(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc2_ = new SE_Select();
         _loc2_.play(0,0,myParent.seTransform);
         _loc3_ = param1.currentTarget;
         if(_loc3_.name != "BtnEmployeeActive")
         {
            HideParameter(btnParameter.indexOf(_loc3_));
            employeeList.visible = false;
         }
         else
         {
            HideParameter();
            employeeList.visible = !employeeList.visible;
            if(employeeList.visible)
            {
               employeeList.setCrewList();
            }
         }
      }
      
      public function deactiveAllButton() : void
      {
         with(btnMenu)
         {
            buttonMode = false;
            gotoAndStop(2);
            removeEventListener(MouseEvent.MOUSE_OVER,mouseOverEvent);
            removeEventListener(MouseEvent.MOUSE_OUT,mouseOutEvent);
            removeEventListener(MouseEvent.MOUSE_DOWN,mouseDownEvent);
            removeEventListener(MouseEvent.MOUSE_UP,mouseUpEvent);
         }
         deactiveButton();
      }
      
      public function SectorButtonDeactive() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         i = 0;
         while(i < sectorList.length)
         {
            _loc1_ = sectorList[i].sectorList;
            _loc2_ = 0;
            while(_loc2_ < _loc1_.btnList.length)
            {
               _loc1_.btnList[_loc2_].btnTog.buttonMode = false;
               _loc1_.btnList[_loc2_].removeEventListener(MouseEvent.CLICK,sectorBtnClick);
               _loc2_++;
            }
            ++i;
         }
      }
      
      public function getButtonActive() : Number
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         _loc1_ = -1;
         _loc2_ = 0;
         while(_loc2_ < buttonList.length)
         {
            if(buttonList[_loc2_].btnDefault.tog)
            {
               _loc1_ = _loc2_;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function deactiveAll(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc2_ = new SE_Select();
         _loc2_.play(0,0,myParent.seTransform);
         _loc3_ = 0;
         while(_loc3_ < buttonList.length)
         {
            if(buttonList[_loc3_] != param1.currentTarget)
            {
               buttonList[_loc3_].btnDefault.tog = false;
            }
            _loc3_++;
         }
         if(param1.currentTarget.name != "btnRestRoom" && param1.currentTarget.name != "btnElevator")
         {
            disableBuilding();
         }
         if(param1.currentTarget.name != "btnMailBox")
         {
            btnMailBox.btnDefault.tog = false;
         }
      }
      
      public function fastSpeed(param1:MouseEvent) : void
      {
         myParent.gameSpeed = 2;
         isPause = false;
      }
      
      public function frezze(param1:MouseEvent) : void
      {
         myParent.gameSpeed = 0;
         isPause = true;
      }
      
      public function AchievementAppear(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = new AchievementList();
         _loc2_.name = "AchievementScreen";
         this.addChild(_loc2_);
      }
      
      public function updateSector() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         _loc1_ = 0;
         while(_loc1_ < sectorList.length)
         {
            _loc2_ = sectorList[_loc1_].sectorList;
            _loc3_ = 0;
            while(_loc3_ < _loc2_.amtList.length)
            {
               _loc4_ = _loc2_.amtList[_loc3_];
               if(sectorList[_loc1_].name == "employeeSector")
               {
                  _loc4_.amount.text = myParent.countEmployee(_loc3_);
               }
               else
               {
                  _loc4_.amount.text = myParent.checkBuildLevel(_loc4_.relation.name);
               }
               _loc3_++;
            }
            _loc1_++;
         }
      }
      
      public function normalSpeed(param1:MouseEvent) : void
      {
         myParent.gameSpeed = 1;
         isPause = false;
      }
      
      public function CheckParameter(param1:Event) : void
      {
         if(VisitorActive.visible)
         {
            if(!visitorParam.visible && parameterShown == null)
            {
               visitorParam.gotoAndPlay("appear");
               visitorParam.visible = true;
               parameterShown = visitorParam;
            }
         }
         else if(visitorParam.currentLabel == "shown")
         {
            visitorParam.gotoAndPlay("disappear");
         }
         EmployeeActive.visible = employeeList.visible;
         if(BoothActive.visible)
         {
            if(!boothParam.visible && parameterShown == null)
            {
               boothParam.gotoAndPlay("appear");
               boothParam.visible = true;
               parameterShown = boothParam;
            }
         }
         else if(boothParam.currentLabel == "shown")
         {
            boothParam.gotoAndPlay("disappear");
         }
         if(parameterShown == visitorParam)
         {
            countVisitorMood();
            if(visitorParam.statisfied != null)
            {
               visitorParam.statisfied.Amount.text = vHappy;
            }
            if(visitorParam.normal != null)
            {
               visitorParam.normal.Amount.text = vNormal;
            }
            if(visitorParam.upset != null)
            {
               visitorParam.upset.Amount.text = vUpset;
            }
            if(visitorParam.angry != null)
            {
               visitorParam.angry.Amount.text = vAngry;
            }
         }
         else if(parameterShown == employeeParam)
         {
            countEmployee();
            if(employeeParam.clnService != null)
            {
               employeeParam.clnService.Amount.text = csNum;
            }
            if(employeeParam.technician != null)
            {
               employeeParam.technician.Amount.text = tcNum;
            }
            if(employeeParam.security != null)
            {
               employeeParam.security.Amount.text = scNum;
            }
         }
         else if(parameterShown == boothParam)
         {
            countBooth();
            if(boothParam.general != null)
            {
               boothParam.general.Amount.text = general;
            }
            if(boothParam.food != null)
            {
               boothParam.food.Amount.text = food;
            }
            if(boothParam.entertainment != null)
            {
               boothParam.entertainment.Amount.text = entertainment;
            }
         }
         if(parameterShown != null && parameterShown.currentLabel == "hide")
         {
            parameterShown = null;
         }
      }
      
      public function disableBuilding() : void
      {
         with(myParent)
         {
            if(buildParent.numChildren > 0)
            {
               buildParent.removeChild(buildParent.getChildAt(0));
            }
            canBuild = false;
            if(!btnStatistic.btnDefault.tog)
            {
               budget.appear = false;
            }
         }
      }
      
      public function showHideTips(param1:MouseEvent) : void
      {
         btnMailBox.filters = [];
      }
      
      public function sectorUpdate(param1:Event) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = 0;
         while(_loc2_ < sectorList.length)
         {
            if(!sectorList[_loc2_].visible)
            {
               sectorList[_loc2_].gotoAndPlay(0);
            }
            if(sectorList[_loc2_].currentFrame <= 1)
            {
               sectorList[_loc2_].visible = sectorConnection[_loc2_].btnDefault.tog;
            }
            else if(!sectorConnection[_loc2_].btnDefault.tog && sectorList[_loc2_].currentFrame == 6)
            {
               sectorList[_loc2_].gotoAndPlay(sectorList[_loc2_].currentFrame + 1);
            }
            _loc2_++;
         }
         if(myParent.hall != null)
         {
            entertainmentSector.sectorList.btnHall.btnTog.deactiveButton();
         }
         else
         {
            entertainmentSector.sectorList.btnHall.btnTog.activeButton();
         }
      }
      
      public function SectorButtonActive() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         i = 0;
         while(i < sectorList.length)
         {
            _loc1_ = sectorList[i].sectorList;
            _loc2_ = 0;
            while(_loc2_ < _loc1_.btnList.length)
            {
               _loc1_.btnList[_loc2_].btnTog.buttonMode = true;
               _loc1_.btnList[_loc2_].addEventListener(MouseEvent.CLICK,sectorBtnClick);
               _loc2_++;
            }
            ++i;
         }
      }
      
      public function activeAllButton() : void
      {
         with(btnMenu)
         {
            buttonMode = true;
            addEventListener(MouseEvent.MOUSE_OVER,mouseOverEvent);
            addEventListener(MouseEvent.MOUSE_OUT,mouseOutEvent);
            addEventListener(MouseEvent.MOUSE_DOWN,mouseDownEvent);
            addEventListener(MouseEvent.MOUSE_UP,mouseUpEvent);
         }
         activeButton();
      }
      
      public function CreateRestroom(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         disableBuilding();
         if(myParent.cash - myParent.purchase + myParent.recive >= myParent.SUPPORT_PRICE[1])
         {
            if(btnRestRoom.btnDefault.tog)
            {
               _loc2_ = new BuildRestroom();
               _loc2_.name = "btnRestRoom";
               _loc2_.x = param1.stageX - _loc2_.width / 2;
               _loc2_.y = param1.stageY - _loc2_.height / 2;
               _loc2_.alpha = 0.3;
               myParent.buildParent.addChild(_loc2_);
            }
         }
         else
         {
            btnRestRoom.btnDefault.tog = false;
            myParent.addNotification("Not enough cash");
         }
      }
      
      public function activeButton() : void
      {
         var _loc1_:* = undefined;
         btnSelect.btnDefault.buttonMode = true;
         btnSelect.addEventListener(MouseEvent.CLICK,btnSelectClicked);
         _loc1_ = 0;
         while(_loc1_ < buttonList.length)
         {
            buttonList[_loc1_].btnDefault.buttonMode = true;
            buttonList[_loc1_].addEventListener(MouseEvent.CLICK,deactiveAll);
            _loc1_++;
         }
         SectorButtonActive();
      }
      
      public function topSpeed(param1:MouseEvent) : void
      {
         myParent.gameSpeed = 3;
         isPause = false;
      }
      
      public function MenuAppear(param1:MouseEvent) : void
      {
         if(tempSpeed == -1)
         {
            tempSpeed = myParent.gameSpeed;
            myParent.gameSpeed = 0;
            gameMenu.visible = true;
            deactiveAllButton();
         }
      }
      
      public function btnCommentAppear(param1:MouseEvent) : void
      {
         if(btnSelect.btnDefault.buttonMode)
         {
            legend = new LegendWideBox();
            legend.alignment = "Left";
            legend.commentText = "Select arrow";
            myParent.noticeParent.addChild(legend);
         }
      }
      
      public function countVisitorMood() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         vHappy = 0;
         vNormal = 0;
         vUpset = 0;
         vAngry = 0;
         _loc1_ = 0;
         while(_loc1_ < myParent.visitorList.length)
         {
            _loc2_ = myParent.visitorList[_loc1_];
            if(_loc2_.mood > 75)
            {
               ++vHappy;
            }
            else if(_loc2_.mood > 50)
            {
               ++vNormal;
            }
            else if(_loc2_.mood > 25)
            {
               ++vUpset;
            }
            else
            {
               ++vAngry;
            }
            _loc1_++;
         }
      }
   }
}
