package
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
   
   [Embed(source="/_assets/assets.swf", symbol="UI_EmployeeInformation")]
   public dynamic class UI_EmployeeInformation extends MovieClip
   {
       
      
      public var salaryText:*;
      
      public var maxUpgrade:MovieClip;
      
      public var upgradeNote:*;
      
      public var btnUpFloor:SimpleButton;
      
      public var crewType:TextField;
      
      public var levelSymbol:*;
      
      public var starLevel:*;
      
      public var standartNote:MovieClip;
      
      public var i:*;
      
      public var visitorRelation:*;
      
      public var colorMod:*;
      
      public var btnPrevCrew:SimpleButton;
      
      public var shiftFloor:TextField;
      
      public var btnFire:SimpleButton;
      
      public var upgradeEffect:*;
      
      public var crewNote:TextField;
      
      public var btnClose:SimpleButton;
      
      public var btnNextCrew:SimpleButton;
      
      public var myParent:*;
      
      public var isDrag:*;
      
      public var lSymbol2:MovieClip;
      
      public var justUpgrade:*;
      
      public var btnDownFloor:SimpleButton;
      
      public var floorTextList:*;
      
      public var lSymbol1:MovieClip;
      
      public var lSymbol3:MovieClip;
      
      public var salaryList:TextField;
      
      public var dragDropSymbol:MovieClip;
      
      public var salary:*;
      
      public var disablePromote:MovieClip;
      
      public var btnPromote:SimpleButton;
      
      public var temp:*;
      
      public var ancestor:*;
      
      public var difX:*;
      
      public var difY:*;
      
      public function UI_EmployeeInformation()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function SearchPrevTechnician() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         _loc1_ = myParent.crewList.indexOf(myParent.visitorFocus);
         _loc2_ = myParent.visitorFocus is CrewCleaningServicelv1 || myParent.visitorFocus is CrewCleaningServicelv2 || myParent.visitorFocus is CrewCleaningServicelv3;
         _loc3_ = _loc1_;
         _loc1_--;
         if(_loc1_ < 0)
         {
            _loc1_ = myParent.crewList.length - 1;
         }
         _loc4_ = myParent.crewList[_loc1_];
         while(!(_loc4_ is CrewTechnicianlv1 || _loc4_ is CrewTechnicianlv2 || _loc4_ is CrewTechnicianlv3) && _loc1_ != _loc3_)
         {
            _loc1_--;
            if(_loc1_ < 0)
            {
               _loc1_ = myParent.crewList.length - 1;
            }
            _loc4_ = myParent.crewList[_loc1_];
         }
         myParent.visitorFocus.filters = [];
         if(myParent.menuParent.numChildren > 0)
         {
            (_loc5_ = myParent.menuParent.getChildAt(0)).closeMenu();
            selectCrew(_loc4_);
         }
      }
      
      public function Draging(param1:MouseEvent) : void
      {
         isDrag = !isDrag;
         difX = param1.stageX - this.x;
         difY = param1.stageY - this.y;
      }
      
      public function SearchPrevCrew(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = new SE_Select();
         _loc2_.play(0,0,myParent.seTransform);
         if(myParent.visitorFocus is CrewCleaningServicelv1 || myParent.visitorFocus is CrewCleaningServicelv2 || myParent.visitorFocus is CrewCleaningServicelv3)
         {
            SearchPrevCleaningService();
         }
         else if(myParent.visitorFocus is CrewTechnicianlv1 || myParent.visitorFocus is CrewTechnicianlv2 || myParent.visitorFocus is CrewTechnicianlv3)
         {
            SearchPrevTechnician();
         }
         else if(myParent.visitorFocus is CrewSecuritylv1 || myParent.visitorFocus is CrewSecuritylv2 || myParent.visitorFocus is CrewSecuritylv3)
         {
            SearchPrevSecurity();
         }
      }
      
      internal function frame1() : *
      {
         crewType.autoSize = TextFieldAutoSize.CENTER;
         salaryList.autoSize = TextFieldAutoSize.LEFT;
         shiftFloor.autoSize = TextFieldAutoSize.RIGHT;
         crewNote.autoSize = TextFieldAutoSize.LEFT;
         levelSymbol = new Array();
         levelSymbol.push(lSymbol1);
         levelSymbol.push(lSymbol2);
         levelSymbol.push(lSymbol3);
         floorTextList = new Array();
         floorTextList.push("All");
         myParent = root;
         addEventListener(MouseEvent.MOUSE_OVER,MouseOverEvent);
         addEventListener(MouseEvent.MOUSE_OUT,MouseOutEvent);
         visitorRelation = myParent.visitorFocus;
         checkCanPromote();
         crewType.text = "STAFF: " + myParent.visitorFocus.nameType;
         i = 0;
         while(i < levelSymbol.length)
         {
            if(i < myParent.visitorFocus.cLevel)
            {
               levelSymbol[i].gotoAndPlay(2);
            }
            else
            {
               levelSymbol[i].gotoAndPlay(1);
            }
            ++i;
         }
         i = 0;
         while(i < myParent.floorList.length)
         {
            temp = myParent.floorList[i];
            if(temp == myParent.ground)
            {
               floorTextList.push("Ground");
            }
            else if(i < myParent.floorList.length - 1)
            {
               floorTextList.push("Floor " + i);
            }
            ++i;
         }
         salaryText = "";
         salary = myParent.visitorFocus.salary;
         salaryText = salarySplit(salary);
         salaryList.text = ":$" + salaryText + ".-";
         shiftFloor.text = floorTextList[myParent.visitorFocus.shiftFloor + 1];
         crewNote.text = myParent.visitorFocus.crewNote;
         btnUpFloor.addEventListener(MouseEvent.CLICK,FloorUp);
         btnDownFloor.addEventListener(MouseEvent.CLICK,FloorDown);
         btnClose.addEventListener(MouseEvent.CLICK,Closing);
         btnFire.addEventListener(MouseEvent.CLICK,Fired);
         btnPromote.addEventListener(MouseEvent.CLICK,Promote);
         justUpgrade = false;
         colorMod = 0;
         stage.addEventListener(KeyboardEvent.KEY_UP,CloseWithKey);
         dragDropSymbol.addEventListener(MouseEvent.MOUSE_DOWN,Draging);
         dragDropSymbol.addEventListener(MouseEvent.MOUSE_UP,Droping);
         stage.addEventListener(MouseEvent.MOUSE_MOVE,Moving);
         if(myParent.visitorFocus is CrewCleaningServicelv1 || myParent.visitorFocus is CrewCleaningServicelv2 || myParent.visitorFocus is CrewCleaningServicelv3)
         {
            btnPrevCrew.visible = myParent.countEmployee(0) > 1;
            btnNextCrew.visible = myParent.countEmployee(0) > 1;
         }
         else if(myParent.visitorFocus is CrewTechnicianlv1 || myParent.visitorFocus is CrewTechnicianlv2 || myParent.visitorFocus is CrewTechnicianlv3)
         {
            btnPrevCrew.visible = myParent.countEmployee(1) > 1;
            btnNextCrew.visible = myParent.countEmployee(1) > 1;
         }
         else if(myParent.visitorFocus is CrewSecuritylv1 || myParent.visitorFocus is CrewSecuritylv2 || myParent.visitorFocus is CrewSecuritylv3)
         {
            btnPrevCrew.visible = myParent.countEmployee(2) > 1;
            btnNextCrew.visible = myParent.countEmployee(2) > 1;
         }
         btnPrevCrew.addEventListener(MouseEvent.CLICK,SearchPrevCrew);
         btnNextCrew.addEventListener(MouseEvent.CLICK,SearchNextCrew);
         stop();
      }
      
      public function Moving(param1:MouseEvent) : void
      {
         if(isDrag)
         {
            this.x = param1.stageX - difX;
            this.y = param1.stageY - difY;
            myParent.menuX = this.x;
            myParent.menuY = this.y;
         }
      }
      
      public function Droping(param1:MouseEvent) : void
      {
         isDrag = false;
      }
      
      public function SearchPrevSecurity() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         _loc1_ = myParent.crewList.indexOf(myParent.visitorFocus);
         _loc2_ = myParent.visitorFocus is CrewSecuritylv1 || myParent.visitorFocus is CrewSecuritylv2 || myParent.visitorFocus is CrewSecuritylv3;
         _loc3_ = _loc1_;
         _loc1_--;
         if(_loc1_ < 0)
         {
            _loc1_ = myParent.crewList.length - 1;
         }
         _loc4_ = myParent.crewList[_loc1_];
         while(!(_loc4_ is CrewSecuritylv1 || _loc4_ is CrewSecuritylv2 || _loc4_ is CrewSecuritylv3) && _loc1_ != _loc3_)
         {
            _loc1_--;
            if(_loc1_ < 0)
            {
               _loc1_ = myParent.crewList.length - 1;
            }
            _loc4_ = myParent.crewList[_loc1_];
         }
         myParent.visitorFocus.filters = [];
         if(myParent.menuParent.numChildren > 0)
         {
            (_loc5_ = myParent.menuParent.getChildAt(0)).closeMenu();
            selectCrew(_loc4_);
         }
      }
      
      public function selectCrew(param1:MovieClip) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:BitmapFilter = null;
         var _loc4_:* = undefined;
         _loc2_ = new UI_EmployeeInformation();
         _loc2_.x = myParent.menuX;
         _loc2_.y = myParent.menuY;
         myParent.menuParent.addChild(_loc2_);
         myParent.visitorFocus = param1;
         _loc3_ = new GlowFilter(16746496,0.9,5,5,2);
         (_loc4_ = new Array()).push(_loc3_);
         myParent.visitorFocus.filters = _loc4_;
      }
      
      public function Closing(param1:MouseEvent) : void
      {
         closeMenu();
      }
      
      public function SearchNextTechnician() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         _loc1_ = myParent.crewList.indexOf(myParent.visitorFocus);
         _loc2_ = myParent.visitorFocus is CrewTechnicianlv1 || myParent.visitorFocus is CrewTechnicianlv2 || myParent.visitorFocus is CrewTechnicianlv3;
         _loc3_ = _loc1_;
         _loc1_++;
         if(_loc1_ >= myParent.crewList.length)
         {
            _loc1_ = 0;
         }
         _loc4_ = myParent.crewList[_loc1_];
         while(!(_loc4_ is CrewTechnicianlv1 || _loc4_ is CrewTechnicianlv2 || _loc4_ is CrewTechnicianlv3) && _loc1_ != _loc3_)
         {
            _loc1_++;
            if(_loc1_ >= myParent.crewList.length)
            {
               _loc1_ = 0;
            }
            _loc4_ = myParent.crewList[_loc1_];
         }
         myParent.visitorFocus.filters = [];
         if(myParent.menuParent.numChildren > 0)
         {
            (_loc5_ = myParent.menuParent.getChildAt(0)).closeMenu();
            selectCrew(_loc4_);
         }
      }
      
      public function FloorDown(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc2_ = new SE_Select();
         _loc2_.play(0,0,myParent.seTransform);
         _loc3_ = floorTextList.indexOf(shiftFloor.text);
         _loc3_--;
         if(_loc3_ < 0)
         {
            _loc3_ = floorTextList.length - 1;
         }
         myParent.visitorFocus.shiftFloor = _loc3_ - 1;
         shiftFloor.text = floorTextList[_loc3_];
      }
      
      public function CloseWithKey(param1:KeyboardEvent) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = param1.keyCode;
         if(_loc2_ == Keyboard.ESCAPE)
         {
            closeMenu();
         }
      }
      
      public function Fired(param1:MouseEvent) : void
      {
         var index:* = undefined;
         var newSE:* = undefined;
         var vi:* = undefined;
         var event:MouseEvent = param1;
         index = myParent.crewList.indexOf(myParent.visitorFocus);
         if(index >= 0)
         {
            newSE = new SE_Close();
            newSE.play(0,0,myParent.seTransform);
            if(myParent.visitorFocus.destination != null)
            {
               myParent.visitorFocus.destination.worker = null;
            }
            if(myParent.visitorFocus.elevatorTarget != null)
            {
               vi = myParent.visitorFocus.elevatorTarget.visitorList.indexOf(myParent.visitorFocus);
               if(vi >= 0)
               {
                  myParent.visitorFocus.elevatorTarget.visitorList.splice(vi,1);
                  myParent.visitorFocus.elevatorTarget.elevatorTargetList.splice(vi,1);
               }
               vi = myParent.visitorFocus.elevatorTarget.visitorWaiting.indexOf(myParent.visitorFocus);
               if(vi >= 0)
               {
                  myParent.visitorFocus.elevatorTarget.visitorWaiting.splice(vi,1);
                  if(myParent.visitorFocus.elevatorTarget.visitorWaiting.length <= 0)
                  {
                     myParent.visitorFocus.elevatorTarget.isStart = false;
                  }
               }
            }
            with(myParent.visitorFocus)
            {
               
               removeEventListener(Event.ENTER_FRAME,Animation);
               removeEventListener(Event.ENTER_FRAME,Behavior);
               removeEventListener(Event.ENTER_FRAME,BackToWork);
               removeEventListener(MouseEvent.CLICK,myParent.EmployeeOnClick);
               removeEventListener(MouseEvent.MOUSE_OVER,myParent.VisitorOnOver);
               removeEventListener(MouseEvent.MOUSE_OUT,myParent.VisitorOnOut);
            }
            myParent.crewList.splice(index,1);
            myParent.visitorFocus.parent.removeChild(myParent.visitorFocus);
            myParent.userinterface.updateSector();
         }
         closeMenu();
      }
      
      public function Update(param1:Event) : void
      {
         var head:* = undefined;
         var clip:* = undefined;
         var temp:* = undefined;
         var cIndex:* = undefined;
         var tParent:* = undefined;
         var pIndex:* = undefined;
         var elevatorTemp:* = undefined;
         var eIndex:* = undefined;
         var event:Event = param1;
         head = root;
         clip = visitorRelation.getChildByName("upgrade");
         if(clip != null)
         {
            if(clip.currentFrame <= 5)
            {
               colorMod += 1 / 5;
            }
            else
            {
               colorMod -= 1 / 10;
            }
            if(clip.currentFrame == 5 && justUpgrade)
            {
               temp = new ancestor.nextUpgrade();
               temp.ancestor = ancestor;
               temp.alpha = ancestor.alpha;
               temp.scaleX = ancestor.scaleX;
               temp.filters = ancestor.filters;
               temp.addChild(clip);
               temp.x = ancestor.x;
               temp.y = ancestor.y;
               cIndex = myParent.crewList.indexOf(ancestor);
               myParent.crewList[cIndex] = temp;
               if(ancestor.elevatorTarget != null)
               {
                  elevatorTemp = ancestor.elevatorTarget;
                  eIndex = elevatorTemp.visitorWaiting.indexOf(ancestor);
                  if(eIndex >= 0)
                  {
                     elevatorTemp.visitorWaiting[eIndex] = temp;
                  }
                  eIndex = elevatorTemp.visitorList.indexOf(ancestor);
                  if(eIndex >= 0)
                  {
                     elevatorTemp.visitorList[eIndex] = temp;
                  }
               }
               try
               {
                  if(ancestor.destination != null && ancestor.destination.worker == ancestor)
                  {
                     ancestor.destination.worker = temp;
                  }
               }
               catch(e:Error)
               {
               }
               checkAllBandit(temp);
               ancestor.removeEventListener(Event.ENTER_FRAME,ancestor.Animation);
               ancestor.removeEventListener(Event.ENTER_FRAME,ancestor.Behavior);
               ancestor.removeEventListener(Event.ENTER_FRAME,ancestor.BackToWork);
               ancestor.removeEventListener(MouseEvent.CLICK,myParent.EmployeeOnClick);
               ancestor.removeEventListener(MouseEvent.MOUSE_OVER,myParent.VisitorOnOver);
               ancestor.removeEventListener(MouseEvent.MOUSE_OUT,myParent.VisitorOnOut);
               temp.addEventListener(MouseEvent.CLICK,myParent.EmployeeOnClick);
               temp.addEventListener(MouseEvent.MOUSE_OVER,myParent.VisitorOnOver);
               temp.addEventListener(MouseEvent.MOUSE_OUT,myParent.VisitorOnOut);
               tParent = ancestor.parent;
               pIndex = tParent.getChildIndex(ancestor);
               tParent.addChildAt(temp,pIndex);
               tParent.removeChild(ancestor);
               visitorRelation = temp;
               if(myParent.visitorFocus != null && myParent.visitorFocus == ancestor)
               {
                  myParent.visitorFocus = visitorRelation;
               }
               justUpgrade = false;
               if(head.userinterface.employeeList.visible)
               {
                  head.userinterface.employeeList.setCrewList();
               }
            }
            visitorRelation.transform.colorTransform = new ColorTransform(1,1,1,visitorRelation.alpha,255 * colorMod,255 * colorMod,255 * colorMod,0);
            levelSymbol[starLevel].rotation += 30;
         }
         else
         {
            if(head.userinterface.employeeList.visible)
            {
               head.userinterface.employeeList.setCrewList();
            }
            levelSymbol[starLevel].rotation = 0;
            levelSymbol[starLevel].gotoAndPlay(2);
            visitorRelation.transform.colorTransform = new ColorTransform(1,1,1,visitorRelation.alpha,0,0,0,0);
            salaryList.text = ":$" + salarySplit(visitorRelation.salary);
            checkCanPromote();
            removeEventListener(Event.ENTER_FRAME,Update);
         }
      }
      
      public function SearchNextCrew(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = new SE_Select();
         _loc2_.play(0,0,myParent.seTransform);
         if(myParent.visitorFocus is CrewCleaningServicelv1 || myParent.visitorFocus is CrewCleaningServicelv2 || myParent.visitorFocus is CrewCleaningServicelv3)
         {
            SearchNextCleaningService();
         }
         else if(myParent.visitorFocus is CrewTechnicianlv1 || myParent.visitorFocus is CrewTechnicianlv2 || myParent.visitorFocus is CrewTechnicianlv3)
         {
            SearchNextTechnician();
         }
         else if(myParent.visitorFocus is CrewSecuritylv1 || myParent.visitorFocus is CrewSecuritylv2 || myParent.visitorFocus is CrewSecuritylv3)
         {
            SearchNextSecurity();
         }
      }
      
      public function checkCanPromote() : void
      {
         standartNote.visible = false;
         maxUpgrade.visible = false;
         if(visitorRelation.nextUpgrade)
         {
            upgradeNote = standartNote;
            upgradeNote.upgradeSalary.text = ":$" + salarySplit(visitorRelation.upgradeSalary);
            upgradeNote.otherNote.text = visitorRelation.upgradeEffect;
            upgradeNote.upgradeCost.text = ":$" + salarySplit(visitorRelation.UPGRADE_COST);
            btnPromote.visible = true;
            disablePromote.visible = false;
         }
         else
         {
            upgradeNote = maxUpgrade;
            btnPromote.visible = false;
            disablePromote.visible = true;
         }
         upgradeNote.visible = true;
      }
      
      public function checkAllBandit(param1:MovieClip) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         _loc2_ = 0;
         while(_loc2_ < myParent.banditList.length)
         {
            _loc3_ = myParent.banditList[_loc2_];
            _loc4_ = 0;
            while(_loc4_ < _loc3_.securityDetected.length)
            {
               if(_loc3_.securityDetected[_loc4_] == ancestor)
               {
                  _loc3_.securityDetected[_loc4_] = param1;
               }
               _loc4_++;
            }
            _loc4_ = 0;
            while(_loc4_ < _loc3_.pursuer.length)
            {
               if(_loc3_.pursuer[_loc4_] == ancestor)
               {
                  _loc3_.pursuer[_loc4_] = param1;
               }
               _loc4_++;
            }
            _loc2_++;
         }
      }
      
      public function MouseOverEvent(param1:MouseEvent) : void
      {
         myParent.menuOver = true;
      }
      
      public function SearchNextCleaningService() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         _loc1_ = myParent.crewList.indexOf(myParent.visitorFocus);
         _loc2_ = myParent.visitorFocus is CrewCleaningServicelv1 || myParent.visitorFocus is CrewCleaningServicelv2 || myParent.visitorFocus is CrewCleaningServicelv3;
         _loc3_ = _loc1_;
         _loc1_++;
         if(_loc1_ >= myParent.crewList.length)
         {
            _loc1_ = 0;
         }
         _loc4_ = myParent.crewList[_loc1_];
         while(!(_loc4_ is CrewCleaningServicelv1 || _loc4_ is CrewCleaningServicelv2 || _loc4_ is CrewCleaningServicelv3) && _loc1_ != _loc3_)
         {
            _loc1_++;
            if(_loc1_ >= myParent.crewList.length)
            {
               _loc1_ = 0;
            }
            _loc4_ = myParent.crewList[_loc1_];
         }
         myParent.visitorFocus.filters = [];
         if(myParent.menuParent.numChildren > 0)
         {
            (_loc5_ = myParent.menuParent.getChildAt(0)).closeMenu();
            selectCrew(_loc4_);
         }
      }
      
      public function SearchNextSecurity() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         _loc1_ = myParent.crewList.indexOf(myParent.visitorFocus);
         _loc2_ = myParent.visitorFocus is CrewSecuritylv1 || myParent.visitorFocus is CrewSecuritylv2 || myParent.visitorFocus is CrewSecuritylv3;
         _loc3_ = _loc1_;
         _loc1_++;
         if(_loc1_ >= myParent.crewList.length)
         {
            _loc1_ = 0;
         }
         _loc4_ = myParent.crewList[_loc1_];
         while(!(_loc4_ is CrewSecuritylv1 || _loc4_ is CrewSecuritylv2 || _loc4_ is CrewSecuritylv3) && _loc1_ != _loc3_)
         {
            _loc1_++;
            if(_loc1_ >= myParent.crewList.length)
            {
               _loc1_ = 0;
            }
            _loc4_ = myParent.crewList[_loc1_];
         }
         myParent.visitorFocus.filters = [];
         if(myParent.menuParent.numChildren > 0)
         {
            (_loc5_ = myParent.menuParent.getChildAt(0)).closeMenu();
            selectCrew(_loc4_);
         }
      }
      
      public function salarySplit(param1:Number) : String
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         _loc2_ = "";
         if(param1 >= 1000)
         {
            _loc3_ = Math.floor(param1 / 1000);
            _loc4_ = param1 % 1000;
            _loc5_ = salarySplit(_loc4_);
            while(_loc5_.length < 3)
            {
               _loc5_ = "0" + _loc5_;
            }
            _loc2_ = _loc3_ + "," + _loc5_;
         }
         else
         {
            _loc2_ = param1 + "";
         }
         return _loc2_;
      }
      
      public function MouseOutEvent(param1:MouseEvent) : void
      {
         myParent.menuOver = false;
      }
      
      public function closeMenu() : void
      {
         stage.focus = stage;
         myParent.visitorFocus.filters = [];
         myParent.visitorFocus = null;
         btnClose.removeEventListener(MouseEvent.CLICK,Closing);
         stage.removeEventListener(KeyboardEvent.KEY_UP,CloseWithKey);
         this.parent.removeChild(this);
      }
      
      public function Promote(param1:MouseEvent) : void
      {
         var spend:* = undefined;
         var newSE:* = undefined;
         var event:MouseEvent = param1;
         spend = myParent.visitorFocus.UPGRADE_COST;
         if(myParent.cash - myParent.purchase + myParent.recive >= spend)
         {
            newSE = new SE_Popularity();
            newSE.play(0,0,myParent.seTransform);
            ancestor = myParent.visitorFocus;
            starLevel = ancestor.cLevel;
            upgradeEffect = new fx_upgrade_crew();
            upgradeEffect.name = "upgrade";
            ancestor.addChild(upgradeEffect);
            addEventListener(Event.ENTER_FRAME,Update);
            btnPromote.visible = false;
            disablePromote.visible = true;
            justUpgrade = true;
            myParent.addCashUpdate(spend,myParent.visitorFocus.worldX,myParent.visitorFocus.worldY - myParent.visitorFocus.height,false);
            with(myParent)
            {
               
               if(visitorFocus is CrewCleaningServicelv1 || visitorFocus is CrewCleaningServicelv2 || visitorFocus is CrewCleaningServicelv3)
               {
                  cleaningServiceOutcome += spend;
               }
               else if(visitorFocus is CrewTechnicianlv1 || visitorFocus is CrewTechnicianlv2 || visitorFocus is CrewTechnicianlv3)
               {
                  technicianOutcome += spend;
               }
               else if(visitorFocus is CrewSecuritylv1 || visitorFocus is CrewSecuritylv2 || visitorFocus is CrewSecuritylv3)
               {
                  securityOutcome += spend;
               }
            }
         }
         else
         {
            myParent.addNotification("Not enough cash");
         }
      }
      
      public function FloorUp(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc2_ = new SE_Select();
         _loc2_.play(0,0,myParent.seTransform);
         _loc3_ = floorTextList.indexOf(shiftFloor.text);
         _loc3_++;
         if(_loc3_ >= floorTextList.length)
         {
            _loc3_ = 0;
         }
         myParent.visitorFocus.shiftFloor = _loc3_ - 1;
         shiftFloor.text = floorTextList[_loc3_];
      }
      
      public function SearchPrevCleaningService() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         _loc1_ = myParent.crewList.indexOf(myParent.visitorFocus);
         _loc2_ = myParent.visitorFocus is CrewCleaningServicelv1 || myParent.visitorFocus is CrewCleaningServicelv2 || myParent.visitorFocus is CrewCleaningServicelv3;
         _loc3_ = _loc1_;
         _loc1_--;
         if(_loc1_ < 0)
         {
            _loc1_ = myParent.crewList.length - 1;
         }
         _loc4_ = myParent.crewList[_loc1_];
         while(!(_loc4_ is CrewCleaningServicelv1 || _loc4_ is CrewCleaningServicelv2 || _loc4_ is CrewCleaningServicelv3) && _loc1_ != _loc3_)
         {
            _loc1_--;
            if(_loc1_ < 0)
            {
               _loc1_ = myParent.crewList.length - 1;
            }
            _loc4_ = myParent.crewList[_loc1_];
         }
         myParent.visitorFocus.filters = [];
         if(myParent.menuParent.numChildren > 0)
         {
            (_loc5_ = myParent.menuParent.getChildAt(0)).closeMenu();
            selectCrew(_loc4_);
         }
      }
   }
}
