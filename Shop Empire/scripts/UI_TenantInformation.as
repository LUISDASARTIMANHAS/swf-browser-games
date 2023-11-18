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
   
   [Embed(source="/_assets/assets.swf", symbol="UI_TenantInformation")]
   public dynamic class UI_TenantInformation extends MovieClip
   {
       
      
      public var tenantType:TextField;
      
      public var btnDestroy:SimpleButton;
      
      public var difX:*;
      
      public var btnClose:SimpleButton;
      
      public var difY:*;
      
      public var nIndex:*;
      
      public var secondSymbol:MovieClip;
      
      public var upgradeNote:*;
      
      public var maxUpgrade:MovieClip;
      
      public var btnUpgrade:SimpleButton;
      
      public var levelSymbol:*;
      
      public var standartUpgradeNote:MovieClip;
      
      public var standartNote:MovieClip;
      
      public var i:*;
      
      public var tenantName:TextField;
      
      public var supportNote:MovieClip;
      
      public var firstSymbol:MovieClip;
      
      public var myParent:*;
      
      public var btnUpgradeDisable:MovieClip;
      
      public var isDrag:*;
      
      public var upgradeClip:*;
      
      public var dragDropSymbol:MovieClip;
      
      public var tenantNote:TextField;
      
      public var extraSymbol:MovieClip;
      
      public var buildingRelation:*;
      
      public var thirdSymbol:MovieClip;
      
      public var noteInfo:*;
      
      public var supportUpgradeNote:MovieClip;
      
      public function UI_TenantInformation()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function Draging(param1:MouseEvent) : void
      {
         isDrag = !isDrag;
         difX = param1.stageX - this.x;
         difY = param1.stageY - this.y;
      }
      
      public function updateNote() : void
      {
         noteInfo.visible = true;
         if(buildingRelation is SupportElevator)
         {
            noteInfo.capacity.text = ":" + buildingRelation.visitorList.length + "/" + buildingRelation.capacity[buildingRelation.tLevel - 1];
         }
         else
         {
            noteInfo.capacity.text = ":" + buildingRelation.visitorList.length + "/" + buildingRelation.getCapacity();
         }
         if(noteInfo == standartNote)
         {
            if(buildingRelation is TenantCinema || buildingRelation is TenantGameCenter)
            {
               noteInfo.priceOrTicket.text = "Ticket";
            }
            noteInfo.price.text = ":$" + myParent.MoneySplit(buildingRelation.PRICE[buildingRelation.tLevel - 1]);
         }
         upgradeNote.visible = true;
         if(upgradeNote != maxUpgrade)
         {
            if(buildingRelation is SupportElevator)
            {
               upgradeNote.upgradeCapacity.text = ":" + buildingRelation.capacity[buildingRelation.tLevel];
            }
            else
            {
               upgradeNote.upgradeCapacity.text = ":" + buildingRelation.getUpgradeCapacity();
            }
            if(upgradeNote == standartUpgradeNote)
            {
               if(buildingRelation is TenantCinema || buildingRelation is TenantGameCenter)
               {
                  upgradeNote.priceOrTicket.text = "Ticket";
               }
               upgradeNote.upgradePrice.text = ":$" + myParent.MoneySplit(buildingRelation.PRICE[buildingRelation.tLevel]);
            }
            else if(buildingRelation is SupportElevator)
            {
               if(buildingRelation.tLevel >= 2)
               {
                  upgradeNote.otherNote.text = "Speed Increased.";
               }
            }
            upgradeNote.upgradeCost.text = ":$" + myParent.MoneySplit(buildingRelation.UPGRADE_COST[buildingRelation.tLevel - 1]);
         }
      }
      
      internal function frame1() : *
      {
         tenantType.autoSize = TextFieldAutoSize.CENTER;
         tenantName.autoSize = TextFieldAutoSize.LEFT;
         tenantNote.autoSize = TextFieldAutoSize.LEFT;
         myParent = root;
         levelSymbol = new Array();
         standartUpgradeNote.visible = false;
         supportUpgradeNote.visible = false;
         standartNote.visible = false;
         supportNote.visible = false;
         maxUpgrade.visible = false;
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
            ++i;
         }
         btnUpgradeDisable.visible = buildingRelation.tLevel >= buildingRelation.MAX_LEVEL;
         btnUpgrade.visible = buildingRelation.tLevel < buildingRelation.MAX_LEVEL;
         btnClose.addEventListener(MouseEvent.CLICK,Closing);
         tenantType.text = buildingRelation.TENANT_TYPE.toUpperCase();
         tenantNote.text = buildingRelation.TENANT_NOTE;
         if(buildingRelation is SupportElevator)
         {
            tenantName.text = "Elevator";
            upgradeNote = supportUpgradeNote;
            noteInfo = supportNote;
         }
         else if(buildingRelation is SupportRestroom)
         {
            tenantName.text = "Restroom";
            upgradeNote = supportUpgradeNote;
            noteInfo = supportNote;
         }
         else
         {
            nIndex = myParent.userinterface.btnArr.indexOf(buildingRelation.name);
            if(nIndex >= 0)
            {
               tenantName.text = myParent.TENANT_TEXT[nIndex];
               upgradeNote = standartUpgradeNote;
               noteInfo = standartNote;
            }
         }
         if(buildingRelation.tLevel >= buildingRelation.MAX_LEVEL)
         {
            upgradeNote = maxUpgrade;
         }
         addEventListener(Event.ENTER_FRAME,EditText);
         updateNote();
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
         var allNull:* = undefined;
         var i:* = undefined;
         var temp:* = undefined;
         var clip:* = undefined;
         var event:Event = param1;
         if(buildingRelation is SupportElevator)
         {
            allNull = true;
            i = 0;
            while(i < buildingRelation.elevatorList.length)
            {
               temp = buildingRelation.elevatorList[i];
               clip = temp.getChildByName("upgrade");
               if(clip != null)
               {
                  if(buildingRelation.tLevel == 3)
                  {
                     if(clip.currentFrame == 5)
                     {
                        buildingRelation.replaceBody(i);
                     }
                  }
                  allNull = false;
               }
               levelSymbol[buildingRelation.tLevel - 1].rotation += 30;
               i++;
            }
            if(allNull)
            {
               levelSymbol[buildingRelation.tLevel - 1].rotation = 0;
               levelSymbol[buildingRelation.tLevel - 1].gotoAndPlay(2);
               try
               {
                  buildingRelation.transform.colorTransform = new ColorTransform(0.7,0.7,0,1,0,0,0,0);
                  myParent.menuParent.getChildIndex(this);
               }
               catch(e:Error)
               {
                  buildingRelation.transform.colorTransform = new ColorTransform(1,1,1,1,0,0,0,0);
               }
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
         else
         {
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
      }
      
      public function Closing(param1:MouseEvent) : void
      {
         closeMenu();
      }
      
      public function EditText(param1:Event) : void
      {
         if(buildingRelation is SupportElevator)
         {
            noteInfo.capacity.text = ":" + buildingRelation.visitorList.length + "/" + buildingRelation.capacity[buildingRelation.tLevel - 1];
         }
         else
         {
            noteInfo.capacity.text = ":" + buildingRelation.visitorList.length + "/" + buildingRelation.getCapacity();
         }
      }
      
      public function Droping(param1:MouseEvent) : void
      {
         isDrag = false;
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
      
      public function DestroyBuilding(param1:MouseEvent) : void
      {
         var newSE:* = undefined;
         var index:* = undefined;
         var grid:* = undefined;
         var i:* = undefined;
         var temp:* = undefined;
         var ti:* = undefined;
         var type:* = undefined;
         var j:* = undefined;
         var event:MouseEvent = param1;
         if(!myParent.tutorialMode)
         {
            newSE = new SE_Destroy();
            newSE.play(0,0,myParent.seTransform);
            if(!(buildingRelation is SupportElevator))
            {
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
            }
            else
            {
               grid = (buildingRelation.width - buildingRelation.width % 12) / 12;
               ti = 0;
               i = 0;
               while(i < buildingRelation.numChildren)
               {
                  type = buildingRelation.getChildAt(i);
                  if(type is ElevatorBody || type is ElevatorUpgrade)
                  {
                     j = 0;
                     while(j < grid)
                     {
                        temp = new TenantEmptySpace();
                        temp.worldX = buildingRelation.worldX + j * 12;
                        temp.worldY = buildingRelation.worldY + type.y;
                        myParent.emptyParent.addChild(temp);
                        j++;
                     }
                     ti++;
                  }
                  i++;
               }
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
            if(buildingRelation.income)
            {
               myParent.otherIncome += buildingRelation.income;
            }
            if(buildingRelation.outcome)
            {
               myParent.otherOutcome += buildingRelation.outcome;
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
            try
            {
               index = buildingRelation.ground.toiletList.indexOf(buildingRelation);
               if(index >= 0)
               {
                  buildingRelation.ground.toiletList.splice(index,1);
               }
            }
            catch(e:Error)
            {
            }
            buildingRelation.parent.removeChild(buildingRelation);
            myParent.userinterface.updateSector();
         }
         else
         {
            myParent.addNotification("Cannot destroy during tutorial");
         }
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
      }
      
      public function UpgradeBuilding(param1:MouseEvent) : void
      {
         var spend:* = undefined;
         var newSE:* = undefined;
         var i:* = undefined;
         var event:MouseEvent = param1;
         spend = buildingRelation.UPGRADE_COST[buildingRelation.tLevel - 1];
         if(myParent.cash - myParent.purchase + myParent.recive >= spend)
         {
            newSE = new SE_Popularity();
            newSE.play(0,0,myParent.seTransform);
            if(buildingRelation is SupportElevator)
            {
               with(buildingRelation)
               {
                  
                  if(tLevel < MAX_LEVEL)
                  {
                     ++tLevel;
                  }
                  i = 0;
                  while(i < buildingRelation.elevatorList.length)
                  {
                     upgradeClip = new fx_upgrade_small();
                     upgradeClip.name = "upgrade";
                     buildingRelation.elevatorList[i].addChild(upgradeClip);
                     ++i;
                  }
               }
            }
            else
            {
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
            }
            buildingRelation.transform.colorTransform = new ColorTransform(1,1,1,1,0,0,0,0);
            addEventListener(Event.ENTER_FRAME,UpgradeCheck);
            btnUpgrade.visible = false;
            btnUpgradeDisable.visible = true;
            if(buildingRelation is SupportElevator)
            {
               myParent.addCashUpdate(spend,buildingRelation.worldX + buildingRelation.width / 2,buildingRelation.worldY + buildingRelation.maxHeight + buildingRelation.height / 2,false);
            }
            else
            {
               myParent.addCashUpdate(spend,buildingRelation.worldX + buildingRelation.width / 2,buildingRelation.worldY + buildingRelation.height / 2,false);
            }
            try
            {
               buildingRelation.outcome += spend;
            }
            catch(e:Error)
            {
               myParent.otherOutcome += spend;
            }
         }
         else
         {
            myParent.addNotification("Not enough cash");
         }
      }
   }
}
