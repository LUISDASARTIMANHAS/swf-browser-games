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
   
   [Embed(source="/_assets/assets.swf", symbol="UI_HallInformation")]
   public dynamic class UI_HallInformation extends MovieClip
   {
       
      
      public var dayNumber:TextField;
      
      public var maxUpgrade:MovieClip;
      
      public var btnUpgrade:SimpleButton;
      
      public var prevEvent:SimpleButton;
      
      public var upgradeNote:*;
      
      public var levelSymbol:*;
      
      public var eventList:TextField;
      
      public var tCost:Number;
      
      public var firstSymbol:MovieClip;
      
      public var i:*;
      
      public var tenantName:TextField;
      
      public var btnUpgradeDisable:MovieClip;
      
      public var btnStartEvent:SimpleButton;
      
      public var buildingRelation:*;
      
      public var upgradeList:MovieClip;
      
      public var btnClose:SimpleButton;
      
      public var tenantType:TextField;
      
      public var secondSymbol:MovieClip;
      
      public var totalCost:TextField;
      
      public var nextEvent:SimpleButton;
      
      public var myParent:*;
      
      public var isDrag:*;
      
      public var eventCost:TextField;
      
      public var upgradeClip:*;
      
      public var day:Number;
      
      public var ticketPrice:TextField;
      
      public var dragDropSymbol:MovieClip;
      
      public var tenantNote:TextField;
      
      public var extraSymbol:MovieClip;
      
      public var cost:Number;
      
      public var dayBtnUp:SimpleButton;
      
      public var thirdSymbol:MovieClip;
      
      public var dayBtnDown:SimpleButton;
      
      public var difX:*;
      
      public var btnDestroy:SimpleButton;
      
      public var difY:*;
      
      public function UI_HallInformation()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function PrevEvent(param1:MouseEvent) : void
      {
         if(myParent.eventSelection > 0)
         {
            --myParent.eventSelection;
         }
         else if(myParent.city < myParent.EVENT_LIST.length - 1)
         {
            myParent.eventSelection = myParent.city;
         }
         else
         {
            myParent.eventSelection = myParent.EVENT_LIST.length - 1;
         }
         eventList.text = myParent.EVENT_LIST[myParent.eventSelection];
         updateNote();
      }
      
      public function DecreaseDay(param1:MouseEvent) : void
      {
         if(day > 1)
         {
            --day;
         }
         updateNote();
      }
      
      public function Draging(param1:MouseEvent) : void
      {
         isDrag = !isDrag;
         difX = param1.stageX - this.x;
         difY = param1.stageY - this.y;
      }
      
      public function updateNote() : void
      {
         ticketPrice.text = ":$" + myParent.MoneySplit(buildingRelation.PRICE[buildingRelation.tLevel - 1]);
         cost = buildingRelation.EVENT_PRICE[buildingRelation.tLevel - 1] + 5000 * myParent.eventSelection;
         eventCost.text = ":$" + myParent.MoneySplit(cost);
         if(day > 1)
         {
            dayNumber.text = day + " days";
         }
         else
         {
            dayNumber.text = day + " day";
         }
         tCost = cost;
         if(day > 1)
         {
            tCost += Math.round(cost * 0.75) * (day - 1);
         }
         totalCost.text = ":$" + myParent.MoneySplit(tCost);
         upgradeNote.visible = true;
         if(upgradeNote != maxUpgrade)
         {
            upgradeNote.ticketPrice.text = ":$" + myParent.MoneySplit(buildingRelation.PRICE[buildingRelation.tLevel]);
            upgradeNote.eventPrice.text = ":-$" + myParent.MoneySplit(buildingRelation.EVENT_PRICE[buildingRelation.tLevel - 1] - buildingRelation.EVENT_PRICE[buildingRelation.tLevel]);
            upgradeNote.upgradeCost.text = ":$" + myParent.MoneySplit(buildingRelation.UPGRADE_COST[buildingRelation.tLevel - 1]);
         }
      }
      
      internal function frame1() : *
      {
         tenantType.autoSize = TextFieldAutoSize.CENTER;
         tenantName.autoSize = TextFieldAutoSize.LEFT;
         tenantNote.autoSize = TextFieldAutoSize.LEFT;
         eventList.autoSize = TextFieldAutoSize.CENTER;
         eventCost.autoSize = TextFieldAutoSize.LEFT;
         dayNumber.autoSize = TextFieldAutoSize.RIGHT;
         totalCost.autoSize = TextFieldAutoSize.LEFT;
         ticketPrice.autoSize = TextFieldAutoSize.LEFT;
         myParent = root;
         btnStartEvent.visible = myParent.nowEvent < 0 && myParent.bookedEvent < 0;
         prevEvent.visible = btnStartEvent.visible;
         nextEvent.visible = btnStartEvent.visible;
         dayBtnUp.visible = btnStartEvent.visible;
         dayBtnDown.visible = btnStartEvent.visible;
         levelSymbol = new Array();
         if(buildingRelation.MAX_LEVEL > 3)
         {
            levelSymbol.push(extraSymbol);
         }
         else
         {
            extraSymbol.visible = false;
         }
         levelSymbol.push(firstSymbol);
         levelSymbol.push(secondSymbol);
         levelSymbol.push(thirdSymbol);
         btnStartEvent.addEventListener(MouseEvent.CLICK,StartEvent);
         prevEvent.addEventListener(MouseEvent.CLICK,PrevEvent);
         nextEvent.addEventListener(MouseEvent.CLICK,NextEvent);
         i = 0;
         while(i < levelSymbol.length)
         {
            if(i < buildingRelation.tLevel)
            {
               levelSymbol[i].gotoAndPlay(2);
            }
            else
            {
               levelSymbol[i].gotoAndPlay(1);
            }
            eventList.text = myParent.EVENT_LIST[myParent.eventSelection];
            ++i;
         }
         btnUpgradeDisable.visible = buildingRelation.tLevel >= buildingRelation.MAX_LEVEL;
         btnUpgrade.visible = buildingRelation.tLevel < buildingRelation.MAX_LEVEL;
         btnClose.addEventListener(MouseEvent.CLICK,Closing);
         tenantType.text = buildingRelation.TENANT_TYPE.toUpperCase();
         tenantName.text = "Hall";
         tenantNote.text = buildingRelation.TENANT_NOTE;
         eventList.text = myParent.EVENT_LIST[myParent.eventSelection];
         upgradeList.visible = false;
         maxUpgrade.visible = false;
         if(buildingRelation.tLevel < buildingRelation.MAX_LEVEL)
         {
            upgradeNote = upgradeList;
         }
         else
         {
            upgradeNote = maxUpgrade;
         }
         if(myParent.nowEvent < 0 && myParent.bookedEvent < 0)
         {
            day = 1;
         }
         else
         {
            day = myParent.eventTime;
         }
         updateNote();
         dayBtnUp.addEventListener(MouseEvent.CLICK,IncreaseDay);
         dayBtnDown.addEventListener(MouseEvent.CLICK,DecreaseDay);
         btnUpgrade.addEventListener(MouseEvent.CLICK,UpgradeBuilding);
         btnDestroy.addEventListener(MouseEvent.CLICK,DestroyBuilding);
         stage.addEventListener(KeyboardEvent.KEY_UP,CloseWithKey);
         dragDropSymbol.addEventListener(MouseEvent.MOUSE_DOWN,Draging);
         dragDropSymbol.addEventListener(MouseEvent.MOUSE_UP,Droping);
         stage.addEventListener(MouseEvent.MOUSE_MOVE,Moving);
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
      
      public function UpgradeCheck(param1:Event) : void
      {
         var event:Event = param1;
         try
         {
            buildingRelation.getChildIndex(upgradeClip);
            levelSymbol[buildingRelation.tLevel - 1].rotation += 30;
         }
         catch(e:Error)
         {
            try
            {
               buildingRelation.transform.colorTransform = new ColorTransform(0.7,0.7,0,1,0,0,0,0);
               myParent.menuParent.getChildIndex(this);
            }
            catch(e:Error)
            {
               buildingRelation.transform.colorTransform = new ColorTransform(1,1,1,1,0,0,0,0);
            }
            levelSymbol[buildingRelation.tLevel - 1].rotation = 0;
            levelSymbol[buildingRelation.tLevel - 1].gotoAndPlay(2);
            removeEventListener(Event.ENTER_FRAME,UpgradeCheck);
            if(buildingRelation.tLevel < buildingRelation.MAX_LEVEL)
            {
               btnUpgrade.visible = true;
               btnUpgradeDisable.visible = false;
            }
            else
            {
               upgradeNote.visible = false;
               upgradeNote = maxUpgrade;
            }
            updateNote();
         }
      }
      
      public function Closing(param1:MouseEvent) : void
      {
         closeMenu();
      }
      
      public function CheckEvent(param1:Event) : void
      {
         if(btnStartEvent.visible)
         {
            removeEventListener(Event.ENTER_FRAME,CheckEvent);
         }
         if(myParent.nowEvent < 0 && myParent.bookedEvent < 0)
         {
            btnStartEvent.visible = true;
         }
         else
         {
            day = myParent.eventTime;
            if(day > 1)
            {
               dayNumber.text = day + " days";
            }
            else
            {
               dayNumber.text = day + " day";
            }
         }
         prevEvent.visible = btnStartEvent.visible;
         nextEvent.visible = btnStartEvent.visible;
         dayBtnUp.visible = btnStartEvent.visible;
         dayBtnDown.visible = btnStartEvent.visible;
      }
      
      public function Droping(param1:MouseEvent) : void
      {
         isDrag = false;
      }
      
      public function DestroyBuilding(param1:MouseEvent) : void
      {
         var newSE:* = undefined;
         var grid:* = undefined;
         var i:* = undefined;
         var index:* = undefined;
         var temp:* = undefined;
         var event:MouseEvent = param1;
         if(myParent.nowEvent < 0 && myParent.bookedEvent < 0)
         {
            newSE = new SE_Destroy();
            newSE.play(0,0,myParent.seTransform);
            grid = (buildingRelation.width - buildingRelation.width % 12) / 12;
            i = 0;
            while(i < grid)
            {
               temp = new TenantEmptySpace();
               temp.worldX = buildingRelation.worldX + i * 12;
               temp.worldY = buildingRelation.worldY;
               myParent.emptyParent.addChild(temp);
               i++;
            }
            if(buildingRelation is TenantHall)
            {
               myParent.hall = null;
            }
            closeMenu();
            updatePopularity(buildingRelation);
            index = myParent.tenantList.indexOf(buildingRelation);
            if(index >= 0)
            {
               myParent.tenantList.splice(index,1);
            }
            index = myParent.elevatorList.indexOf(buildingRelation);
            if(index >= 0)
            {
               myParent.elevatorList.splice(index,1);
            }
            index = myParent.restroomList.indexOf(buildingRelation);
            if(index >= 0)
            {
               myParent.restroomList.splice(index,1);
            }
            try
            {
               index = buildingRelation.ground.tenantList.indexOf(buildingRelation);
               if(index >= 0)
               {
                  buildingRelation.ground.tenantList.splice(index,1);
               }
            }
            catch(e:Error)
            {
            }
            buildingRelation.parent.removeChild(buildingRelation);
         }
         else
         {
            myParent.addNotification("Please wait until there is no event");
         }
      }
      
      public function CloseWithKey(param1:KeyboardEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc2_ = param1.keyCode;
         if(_loc2_ == Keyboard.ESCAPE)
         {
            _loc3_ = new SE_Close();
            _loc3_.play(0,0,myParent.seTransform);
            closeMenu();
         }
      }
      
      public function updatePopularity(param1:MovieClip) : void
      {
         var tenant:MovieClip = param1;
         if(!(tenant is SupportElevator || tenant is SupportRestroom))
         {
            myParent.popularity -= 5;
         }
         try
         {
            tenant.restoreRelation();
         }
         catch(e:Error)
         {
         }
         trace("Now Popularity is " + myParent.popularity);
      }
      
      public function UpgradeBuilding(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc2_ = buildingRelation.UPGRADE_COST[buildingRelation.tLevel - 1];
         if(myParent.cash - myParent.purchase + myParent.recive >= _loc2_)
         {
            _loc3_ = new SE_Popularity();
            _loc3_.play(0,0,myParent.seTransform);
            if(buildingRelation.tLevel < buildingRelation.MAX_LEVEL)
            {
               ++buildingRelation.tLevel;
            }
            if(buildingRelation.width <= 150)
            {
               upgradeClip = new fx_upgrade_small();
            }
            else if(buildingRelation.width <= 300)
            {
               upgradeClip = new fx_upgrade_medium();
            }
            else
            {
               upgradeClip = new fx_upgrade_large();
            }
            buildingRelation.addChild(upgradeClip);
            buildingRelation.transform.colorTransform = new ColorTransform(1,1,1,1,0,0,0,0);
            addEventListener(Event.ENTER_FRAME,UpgradeCheck);
            btnUpgrade.visible = false;
            btnUpgradeDisable.visible = true;
            myParent.addCashUpdate(_loc2_,buildingRelation.worldX + buildingRelation.width / 2,buildingRelation.worldY + buildingRelation.height / 2,false);
            buildingRelation.outcome += _loc2_;
         }
         else
         {
            myParent.addNotification("Not enough cash");
         }
      }
      
      public function NextEvent(param1:MouseEvent) : void
      {
         if(myParent.eventSelection < myParent.EVENT_LIST.length - 1 && myParent.eventSelection < myParent.city)
         {
            ++myParent.eventSelection;
         }
         else
         {
            myParent.eventSelection = 0;
         }
         eventList.text = myParent.EVENT_LIST[myParent.eventSelection];
         updateNote();
      }
      
      public function closeMenu() : void
      {
         stage.focus = stage;
         btnClose.removeEventListener(MouseEvent.CLICK,Closing);
         btnUpgrade.removeEventListener(MouseEvent.CLICK,UpgradeBuilding);
         btnDestroy.removeEventListener(MouseEvent.CLICK,DestroyBuilding);
         stage.removeEventListener(KeyboardEvent.KEY_UP,CloseWithKey);
         buildingRelation.transform.colorTransform = new ColorTransform(1,1,1,1,0,0,0,0);
         this.parent.removeChild(this);
      }
      
      public function StartEvent(param1:MouseEvent) : void
      {
         if(myParent.cash - myParent.purchase + myParent.recive >= tCost)
         {
            if(myParent.dayTime >= 15)
            {
               myParent.addNotification("Too late to begin event today. Event will start Tommorrow.");
               myParent.bookedEvent = myParent.EVENT_LIST.indexOf(eventList.text);
            }
            else
            {
               myParent.addNotification("The event starts soon");
               myParent.nowEvent = myParent.EVENT_LIST.indexOf(eventList.text);
            }
            myParent.eventTime = day;
            btnStartEvent.visible = false;
            addEventListener(Event.ENTER_FRAME,CheckEvent);
            myParent.addCashUpdate(tCost,buildingRelation.worldX + buildingRelation.width / 2,buildingRelation.worldY + buildingRelation.height / 2,false);
            buildingRelation.outcome += tCost;
         }
         else
         {
            myParent.addNotification("Not Enough Cash");
         }
      }
      
      public function IncreaseDay(param1:MouseEvent) : void
      {
         if(day < 7)
         {
            ++day;
         }
         updateNote();
      }
   }
}
