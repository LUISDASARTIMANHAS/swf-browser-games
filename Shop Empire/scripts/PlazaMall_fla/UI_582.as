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
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.UI_582")]
   public dynamic class UI_582 extends MovieClip
   {
       
      
      public var technician:MovieClip;
      
      public var security:MovieClip;
      
      public var clnService:MovieClip;
      
      public var head:*;
      
      public function UI_582()
      {
         super();
         addFrameScript(0,frame1,1,frame2,2,frame3,8,frame9,9,frame10,18,frame19);
      }
      
      public function SearchTechnician(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         if(head.visitorFocus == null || head.crewList.indexOf(head.visitorFocus) < 0)
         {
            if(head.crewList.length > 0)
            {
               _loc2_ = Math.floor(Math.random() * head.crewList.length);
               _loc3_ = -1;
               _loc4_ = head.crewList[_loc2_];
               while(!(_loc4_ is CrewTechnicianlv1 || _loc4_ is CrewTechnicianlv2 || _loc4_ is CrewTechnicianlv3) && _loc2_ != _loc3_)
               {
                  if(_loc3_ == -1)
                  {
                     _loc3_ = _loc2_;
                  }
                  _loc2_++;
                  if(_loc2_ >= head.crewList.length)
                  {
                     _loc2_ = 0;
                  }
                  _loc4_ = head.crewList[_loc2_];
               }
               if(head.visitorFocus != null)
               {
                  head.visitorFocus.filters = [];
               }
               if(head.menuParent.numChildren > 0)
               {
                  (_loc5_ = head.menuParent.getChildAt(0)).closeMenu();
               }
               if(_loc2_ != _loc3_)
               {
                  selectCrew(_loc4_);
               }
               else
               {
                  head.addNotification("No technician found");
               }
            }
            else
            {
               head.addNotification("Crew not found");
            }
         }
         else
         {
            _loc6_ = head.crewList.indexOf(head.visitorFocus);
            _loc7_ = head.visitorFocus is CrewTechnicianlv1 || head.visitorFocus is CrewTechnicianlv2 || head.visitorFocus is CrewTechnicianlv3;
            _loc3_ = _loc6_;
            if(++_loc6_ >= head.crewList.length)
            {
               _loc6_ = 0;
            }
            _loc4_ = head.crewList[_loc6_];
            while(!(_loc4_ is CrewTechnicianlv1 || _loc4_ is CrewTechnicianlv2 || _loc4_ is CrewTechnicianlv3) && _loc6_ != _loc3_)
            {
               if(++_loc6_ >= head.crewList.length)
               {
                  _loc6_ = 0;
               }
               _loc4_ = head.crewList[_loc6_];
            }
            head.visitorFocus.filters = [];
            if(head.menuParent.numChildren > 0)
            {
               (_loc5_ = head.menuParent.getChildAt(0)).closeMenu();
            }
            if(_loc6_ != _loc3_ || _loc7_)
            {
               selectCrew(_loc4_);
            }
            else
            {
               head.addNotification("No technician found");
            }
         }
      }
      
      internal function frame10() : *
      {
         clnService.removeEventListener(MouseEvent.CLICK,SearchCleaningService);
         technician.removeEventListener(MouseEvent.CLICK,SearchTechnician);
         security.removeEventListener(MouseEvent.CLICK,SearchSecurity);
      }
      
      internal function frame3() : *
      {
         clnService.iconSymbol.gotoAndStop("c.service");
         clnService.Note.text = "Cleaning Service";
      }
      
      internal function frame19() : *
      {
         this.visible = false;
      }
      
      internal function frame9() : *
      {
         head = root;
         clnService.addEventListener(MouseEvent.CLICK,SearchCleaningService);
         technician.addEventListener(MouseEvent.CLICK,SearchTechnician);
         security.addEventListener(MouseEvent.CLICK,SearchSecurity);
         stop();
      }
      
      public function SearchSecurity(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         if(head.visitorFocus == null || head.crewList.indexOf(head.visitorFocus) < 0)
         {
            if(head.crewList.length > 0)
            {
               _loc2_ = Math.floor(Math.random() * head.crewList.length);
               _loc3_ = -1;
               _loc4_ = head.crewList[_loc2_];
               while(!(_loc4_ is CrewSecuritylv1 || _loc4_ is CrewSecuritylv2 || _loc4_ is CrewSecuritylv3) && _loc2_ != _loc3_)
               {
                  if(_loc3_ == -1)
                  {
                     _loc3_ = _loc2_;
                  }
                  _loc2_++;
                  if(_loc2_ >= head.crewList.length)
                  {
                     _loc2_ = 0;
                  }
                  _loc4_ = head.crewList[_loc2_];
               }
               if(head.visitorFocus != null)
               {
                  head.visitorFocus.filters = [];
               }
               if(head.menuParent.numChildren > 0)
               {
                  (_loc5_ = head.menuParent.getChildAt(0)).closeMenu();
               }
               if(_loc2_ != _loc3_)
               {
                  selectCrew(_loc4_);
               }
               else
               {
                  head.addNotification("No security found");
               }
            }
            else
            {
               head.addNotification("Crew not found");
            }
         }
         else
         {
            _loc6_ = head.crewList.indexOf(head.visitorFocus);
            _loc7_ = head.visitorFocus is CrewSecuritylv1 || head.visitorFocus is CrewSecuritylv2 || head.visitorFocus is CrewSecuritylv3;
            _loc3_ = _loc6_;
            if(++_loc6_ >= head.crewList.length)
            {
               _loc6_ = 0;
            }
            _loc4_ = head.crewList[_loc6_];
            while(!(_loc4_ is CrewSecuritylv1 || _loc4_ is CrewSecuritylv2 || _loc4_ is CrewSecuritylv3) && _loc6_ != _loc3_)
            {
               if(++_loc6_ >= head.crewList.length)
               {
                  _loc6_ = 0;
               }
               _loc4_ = head.crewList[_loc6_];
            }
            head.visitorFocus.filters = [];
            if(head.menuParent.numChildren > 0)
            {
               (_loc5_ = head.menuParent.getChildAt(0)).closeMenu();
            }
            if(_loc6_ != _loc3_ || _loc7_)
            {
               selectCrew(_loc4_);
            }
            else
            {
               head.addNotification("No security found");
            }
         }
      }
      
      public function selectCrew(param1:MovieClip) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:BitmapFilter = null;
         var _loc4_:* = undefined;
         _loc2_ = new UI_EmployeeInformation();
         _loc2_.x = head.menuX;
         _loc2_.y = head.menuY;
         head.menuParent.addChild(_loc2_);
         head.visitorFocus = param1;
         _loc3_ = new GlowFilter(16746496,0.9,5,5,2);
         (_loc4_ = new Array()).push(_loc3_);
         head.visitorFocus.filters = _loc4_;
      }
      
      internal function frame1() : *
      {
         security.iconSymbol.gotoAndStop("security");
         security.Note.text = "Security";
      }
      
      public function SearchCleaningService(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         if(head.visitorFocus == null || head.crewList.indexOf(head.visitorFocus) < 0)
         {
            if(head.crewList.length > 0)
            {
               _loc2_ = Math.floor(Math.random() * head.crewList.length);
               _loc3_ = -1;
               _loc4_ = head.crewList[_loc2_];
               while(!(_loc4_ is CrewCleaningServicelv1 || _loc4_ is CrewCleaningServicelv2 || _loc4_ is CrewCleaningServicelv3) && _loc2_ != _loc3_)
               {
                  if(_loc3_ == -1)
                  {
                     _loc3_ = _loc2_;
                  }
                  _loc2_++;
                  if(_loc2_ >= head.crewList.length)
                  {
                     _loc2_ = 0;
                  }
                  _loc4_ = head.crewList[_loc2_];
               }
               if(head.visitorFocus != null)
               {
                  head.visitorFocus.filters = [];
               }
               if(head.menuParent.numChildren > 0)
               {
                  (_loc5_ = head.menuParent.getChildAt(0)).closeMenu();
               }
               if(_loc2_ != _loc3_)
               {
                  selectCrew(_loc4_);
               }
               else
               {
                  head.addNotification("No cleaning service found");
               }
            }
            else
            {
               head.addNotification("Crew not found");
            }
         }
         else
         {
            _loc6_ = head.crewList.indexOf(head.visitorFocus);
            _loc7_ = head.visitorFocus is CrewCleaningServicelv1 || head.visitorFocus is CrewCleaningServicelv2 || head.visitorFocus is CrewCleaningServicelv3;
            _loc3_ = _loc6_;
            if(++_loc6_ >= head.crewList.length)
            {
               _loc6_ = 0;
            }
            _loc4_ = head.crewList[_loc6_];
            while(!(_loc4_ is CrewCleaningServicelv1 || _loc4_ is CrewCleaningServicelv2 || _loc4_ is CrewCleaningServicelv3) && _loc6_ != _loc3_)
            {
               if(++_loc6_ >= head.crewList.length)
               {
                  _loc6_ = 0;
               }
               _loc4_ = head.crewList[_loc6_];
            }
            head.visitorFocus.filters = [];
            if(head.menuParent.numChildren > 0)
            {
               (_loc5_ = head.menuParent.getChildAt(0)).closeMenu();
            }
            if(_loc6_ != _loc3_ || _loc7_)
            {
               selectCrew(_loc4_);
            }
            else
            {
               head.addNotification("No cleaning service found");
            }
         }
      }
      
      internal function frame2() : *
      {
         technician.iconSymbol.gotoAndStop("technician");
         technician.Note.text = "Technician";
      }
   }
}
