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
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.Game_522")]
   public dynamic class Game_522 extends MovieClip
   {
       
      
      public var securityList:MovieClip;
      
      public var technicianList:MovieClip;
      
      public var cleaningList:MovieClip;
      
      public var crewList:*;
      
      public var head:*;
      
      public function Game_522()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function setButtonMode() : void
      {
         var i:* = undefined;
         var temp:* = undefined;
         var j:* = undefined;
         i = 0;
         while(i < numChildren)
         {
            temp = getChildAt(i);
            if(i < numChildren - 1)
            {
               temp.buttonMode = true;
               temp.deactiveBar.visible = true;
               j = 0;
               while(j < 8)
               {
                  with(temp)
                  {
                     
                     disableFloor[j].visible = false;
                     crewList[j].visible = false;
                     crewList[j].removeEventListener(Event.ENTER_FRAME,crewUpdate);
                     lvSymbol[j].visible = false;
                     btnPromote[j].visible = false;
                     disablePromote[j].visible = false;
                     promoteCost[j].visible = false;
                     workStatus[j].visible = false;
                     floorChange[j].visible = false;
                  }
                  j++;
               }
            }
            else
            {
               temp.buttonMode = false;
               temp.deactiveBar.visible = false;
               j = 0;
               while(j < temp.crewList.length)
               {
                  temp.crewList[j].addEventListener(Event.ENTER_FRAME,temp.crewUpdate);
                  j++;
               }
            }
            i++;
         }
      }
      
      public function setCrewList() : void
      {
         var temp:* = undefined;
         var i:* = undefined;
         var pgNum:* = undefined;
         crewList = new Array();
         temp = getChildAt(numChildren - 1);
         if(temp.name == "cleaningList")
         {
            crewList = getCleaningList();
         }
         else if(temp.name == "technicianList")
         {
            crewList = getTechnicianList();
         }
         else if(temp.name == "securityList")
         {
            crewList = getSecurityList();
         }
         try
         {
            pgNum = Math.ceil(crewList.length / 8);
            if(pgNum < 1)
            {
               pgNum = 1;
            }
            if(temp.page > pgNum)
            {
               temp.page = 1;
            }
            if(temp.page < 1)
            {
               temp.page = pgNum;
            }
            temp.btnPrevPage.visible = pgNum > 1;
            temp.btnNextPage.visible = pgNum > 1;
            temp.pageNumber.text = temp.page + "/" + pgNum;
         }
         catch(e:Error)
         {
         }
         i = 0;
         while(i < temp.crewList.length)
         {
            temp.crewList[i].relation = crewList[i + (temp.page - 1) * 8];
            if(temp.crewList[i].relation != null)
            {
               temp.crewList[i].visible = true;
               temp.disableBar[i].alpha = 0;
               temp.disableBar[i].buttonMode = true;
               temp.disableFloor[i].visible = false;
               temp.lvSymbol[i].visible = true;
               temp.lvSymbol[i].updateLevel(temp.crewList[i].relation.cLevel);
               temp.workStatus[i].visible = true;
               temp.promoteCost[i].visible = true;
               if(temp.crewList[i].relation.nextUpgrade)
               {
                  temp.btnPromote[i].visible = true;
                  temp.disablePromote[i].visible = false;
                  temp.promoteCost[i].text = "Promote: $" + head.MoneySplit(temp.crewList[i].relation.UPGRADE_COST);
               }
               else
               {
                  temp.btnPromote[i].visible = false;
                  temp.disablePromote[i].visible = true;
                  temp.promoteCost[i].text = "Max Promotion";
               }
               temp.floorChange[i].visible = true;
               if(temp.crewList[i].relation.shiftFloor == -1)
               {
                  temp.floorChange[i].floorList.text = "All";
               }
               else if(temp.crewList[i].relation.shiftFloor == 0)
               {
                  temp.floorChange[i].floorList.text = "Ground";
               }
               else
               {
                  temp.floorChange[i].floorList.text = "Floor " + temp.crewList[i].relation.shiftFloor;
               }
            }
            else
            {
               temp.crewList[i].visible = false;
               temp.lvSymbol[i].visible = false;
               temp.workStatus[i].visible = false;
               temp.promoteCost[i].visible = false;
               temp.disableBar[i].alpha = 1;
               temp.disableBar[i].buttonMode = false;
               temp.disableFloor[i].visible = true;
               temp.btnPromote[i].visible = false;
               temp.disablePromote[i].visible = false;
               temp.floorChange[i].visible = false;
            }
            i++;
         }
      }
      
      internal function frame1() : *
      {
         crewList = new Array();
         head = root;
         this.addChildAt(cleaningList,numChildren - 1);
         cleaningList.addEventListener(MouseEvent.CLICK,listClicked);
         technicianList.addEventListener(MouseEvent.CLICK,listClicked);
         securityList.addEventListener(MouseEvent.CLICK,listClicked);
         setButtonMode();
      }
      
      public function getTechnicianList() : Array
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         _loc1_ = new Array();
         _loc2_ = 0;
         while(_loc2_ < head.crewList.length)
         {
            if(head.crewList[_loc2_] is CrewTechnicianlv1 || head.crewList[_loc2_] is CrewTechnicianlv2 || head.crewList[_loc2_] is CrewTechnicianlv3)
            {
               _loc1_.push(head.crewList[_loc2_]);
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getSecurityList() : Array
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         _loc1_ = new Array();
         _loc2_ = 0;
         while(_loc2_ < head.crewList.length)
         {
            if(head.crewList[_loc2_] is CrewSecuritylv1 || head.crewList[_loc2_] is CrewSecuritylv2 || head.crewList[_loc2_] is CrewSecuritylv3)
            {
               _loc1_.push(head.crewList[_loc2_]);
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function promoteEmployee(param1:Event) : void
      {
         var target:* = undefined;
         var clip:* = undefined;
         var rgbR:* = undefined;
         var rgbG:* = undefined;
         var rgbB:* = undefined;
         var ancestor:* = undefined;
         var temp:* = undefined;
         var cIndex:* = undefined;
         var tParent:* = undefined;
         var pIndex:* = undefined;
         var elevatorTemp:* = undefined;
         var eIndex:* = undefined;
         var event:Event = param1;
         target = event.currentTarget;
         clip = target.getChildByName("upgrade");
         if(clip != null)
         {
            rgbR = target.transform.colorTransform.redOffset / 255;
            rgbG = target.transform.colorTransform.greenOffset / 255;
            rgbB = target.transform.colorTransform.blueOffset / 255;
            if(clip.currentFrame <= 5)
            {
               rgbR += 1 / 5;
               rgbG += 1 / 5;
               rgbB += 1 / 5;
            }
            else
            {
               rgbR -= 1 / 10;
               rgbG -= 1 / 10;
               rgbB -= 1 / 10;
            }
            if(rgbR < 0)
            {
               rgbR = 0;
            }
            if(rgbG < 0)
            {
               rgbG = 0;
            }
            if(rgbB < 0)
            {
               rgbB = 0;
            }
            if(clip.currentFrame == 5)
            {
               ancestor = target;
               temp = new target.nextUpgrade();
               temp.ancestor = ancestor;
               temp.shiftFloor = ancestor.shiftFloor;
               temp.alpha = ancestor.alpha;
               temp.scaleX = ancestor.scaleX;
               temp.filters = ancestor.filters;
               temp.addChild(clip);
               clip.gotoAndPlay(clip.currentFrame + 1);
               temp.x = ancestor.x;
               temp.y = ancestor.y;
               cIndex = head.crewList.indexOf(ancestor);
               head.crewList[cIndex] = temp;
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
               checkAllBandit(temp,ancestor);
               ancestor.removeEventListener(Event.ENTER_FRAME,ancestor.Animation);
               ancestor.removeEventListener(Event.ENTER_FRAME,ancestor.Behavior);
               ancestor.removeEventListener(Event.ENTER_FRAME,ancestor.BackToWork);
               ancestor.removeEventListener(MouseEvent.CLICK,head.EmployeeOnClick);
               ancestor.removeEventListener(MouseEvent.MOUSE_OVER,head.VisitorOnOver);
               ancestor.removeEventListener(MouseEvent.MOUSE_OUT,head.VisitorOnOut);
               temp.addEventListener(MouseEvent.CLICK,head.EmployeeOnClick);
               temp.addEventListener(MouseEvent.MOUSE_OVER,head.VisitorOnOver);
               temp.addEventListener(MouseEvent.MOUSE_OUT,head.VisitorOnOut);
               tParent = ancestor.parent;
               pIndex = tParent.getChildIndex(ancestor);
               tParent.addChildAt(temp,pIndex);
               tParent.removeChild(ancestor);
               target.removeEventListener(Event.ENTER_FRAME,promoteEmployee);
               target = temp;
               target.addEventListener(Event.ENTER_FRAME,promoteEmployee);
               setCrewList();
            }
            target.transform.colorTransform = new ColorTransform(1,1,1,1,rgbR * 255,rgbG * 255,rgbB * 255);
         }
         else
         {
            setCrewList();
            target.removeEventListener(Event.ENTER_FRAME,promoteEmployee);
         }
      }
      
      public function listClicked(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc2_ = param1.currentTarget;
         if(_loc2_.buttonMode)
         {
            _loc3_ = new SE_Select();
            _loc3_.play(0,0,head.seTransform);
            this.addChild(_loc2_);
            setButtonMode();
            setCrewList();
         }
      }
      
      public function getCleaningList() : Array
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         _loc1_ = new Array();
         _loc2_ = 0;
         while(_loc2_ < head.crewList.length)
         {
            if(head.crewList[_loc2_] is CrewCleaningServicelv1 || head.crewList[_loc2_] is CrewCleaningServicelv2 || head.crewList[_loc2_] is CrewCleaningServicelv3)
            {
               _loc1_.push(head.crewList[_loc2_]);
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function checkAllBandit(param1:MovieClip, param2:MovieClip) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         _loc3_ = 0;
         while(_loc3_ < head.banditList.length)
         {
            _loc4_ = head.banditList[_loc3_];
            _loc5_ = 0;
            while(_loc5_ < _loc4_.securityDetected.length)
            {
               if(_loc4_.securityDetected[_loc5_] == param2)
               {
                  _loc4_.securityDetected[_loc5_] = param1;
               }
               _loc5_++;
            }
            _loc5_ = 0;
            while(_loc5_ < _loc4_.pursuer.length)
            {
               if(_loc4_.pursuer[_loc5_] == param2)
               {
                  _loc4_.pursuer[_loc5_] = param1;
               }
               _loc5_++;
            }
            _loc3_++;
         }
      }
   }
}
