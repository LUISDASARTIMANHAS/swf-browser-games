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
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.UI_583")]
   public dynamic class UI_583 extends MovieClip
   {
       
      
      public var food:MovieClip;
      
      public var entertainment:MovieClip;
      
      public var head:*;
      
      public var general:MovieClip;
      
      public function UI_583()
      {
         super();
         addFrameScript(0,frame1,1,frame2,2,frame3,8,frame9,9,frame10,18,frame19);
      }
      
      public function SearchFoodCenter(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         if(head.menuParent.numChildren <= 0)
         {
            _loc2_ = null;
         }
         else
         {
            _loc2_ = head.menuParent.getChildAt(0);
         }
         if(_loc2_ == null || _loc2_.buildingRelation == null)
         {
            if(head.tenantList.length > 0)
            {
               _loc3_ = Math.floor(Math.random() * head.tenantList.length);
               _loc4_ = -1;
               _loc5_ = head.tenantList[_loc3_];
               _loc6_ = head.userinterface.btnArr;
               while((_loc6_.indexOf(_loc5_.name) < 9 || _loc6_.indexOf(_loc5_.name) > 14) && _loc3_ != _loc4_)
               {
                  if(_loc4_ == -1)
                  {
                     _loc4_ = _loc3_;
                  }
                  _loc3_++;
                  if(_loc3_ >= head.tenantList.length)
                  {
                     _loc3_ = 0;
                  }
                  _loc5_ = head.tenantList[_loc3_];
               }
               if(_loc2_ != null)
               {
                  _loc2_.closeMenu();
               }
               if(_loc3_ != _loc4_)
               {
                  selectTenant(_loc5_);
               }
               else
               {
                  head.addNotification("No food center found");
               }
            }
            else
            {
               head.addNotification("Booth not found");
            }
         }
         else
         {
            _loc7_ = head.tenantList.indexOf(_loc2_.buildingRelation);
            _loc8_ = (_loc6_ = head.userinterface.btnArr).indexOf(_loc2_.buildingRelation.name) >= 9 && _loc6_.indexOf(_loc2_.buildingRelation.name) <= 14;
            _loc4_ = _loc7_;
            if(++_loc7_ >= head.tenantList.length)
            {
               _loc7_ = 0;
            }
            _loc5_ = head.tenantList[_loc7_];
            while((_loc6_.indexOf(_loc5_.name) < 9 || _loc6_.indexOf(_loc5_.name) > 14) && _loc7_ != _loc4_)
            {
               if(++_loc7_ >= head.tenantList.length)
               {
                  _loc7_ = 0;
               }
               _loc5_ = head.tenantList[_loc7_];
            }
            _loc2_.closeMenu();
            if(_loc7_ != _loc4_ || _loc8_)
            {
               selectTenant(_loc5_);
            }
            else
            {
               head.addNotification("No food center found");
            }
         }
      }
      
      internal function frame10() : *
      {
         general.removeEventListener(MouseEvent.CLICK,SearchGeneralStore);
         food.removeEventListener(MouseEvent.CLICK,SearchFoodCenter);
         entertainment.removeEventListener(MouseEvent.CLICK,SearchEntertainment);
      }
      
      internal function frame3() : *
      {
         general.iconSymbol.gotoAndStop("general");
         general.Note.text = "General Store";
      }
      
      internal function frame1() : *
      {
         entertainment.iconSymbol.gotoAndStop("entertainment");
         entertainment.Note.text = "Entertainment";
      }
      
      internal function frame19() : *
      {
         this.visible = false;
      }
      
      internal function frame9() : *
      {
         head = root;
         general.addEventListener(MouseEvent.CLICK,SearchGeneralStore);
         food.addEventListener(MouseEvent.CLICK,SearchFoodCenter);
         entertainment.addEventListener(MouseEvent.CLICK,SearchEntertainment);
         stop();
      }
      
      internal function frame2() : *
      {
         food.iconSymbol.gotoAndStop("food");
         food.Note.text = "Food and Beverages";
      }
      
      public function SearchEntertainment(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         if(head.menuParent.numChildren <= 0)
         {
            _loc2_ = null;
         }
         else
         {
            _loc2_ = head.menuParent.getChildAt(0);
         }
         if(_loc2_ == null || _loc2_.buildingRelation == null)
         {
            if(head.tenantList.length > 0)
            {
               _loc3_ = Math.floor(Math.random() * head.tenantList.length);
               _loc4_ = -1;
               _loc5_ = head.tenantList[_loc3_];
               _loc6_ = head.userinterface.btnArr;
               while(_loc6_.indexOf(_loc5_.name) < 15 && !(_loc5_ is TenantHall) && _loc3_ != _loc4_)
               {
                  if(_loc4_ == -1)
                  {
                     _loc4_ = _loc3_;
                  }
                  _loc3_++;
                  if(_loc3_ >= head.tenantList.length)
                  {
                     _loc3_ = 0;
                  }
                  _loc5_ = head.tenantList[_loc3_];
               }
               if(_loc2_ != null)
               {
                  _loc2_.closeMenu();
               }
               if(_loc3_ != _loc4_)
               {
                  selectTenant(_loc5_);
               }
               else
               {
                  head.addNotification("No entertainment found");
               }
            }
            else
            {
               head.addNotification("Booth not found");
            }
         }
         else
         {
            _loc7_ = head.tenantList.indexOf(_loc2_.buildingRelation);
            _loc8_ = (_loc6_ = head.userinterface.btnArr).indexOf(_loc2_.buildingRelation.name) >= 15 || _loc2_.buildingRelation is TenantHall;
            _loc4_ = _loc7_;
            if(++_loc7_ >= head.tenantList.length)
            {
               _loc7_ = 0;
            }
            _loc5_ = head.tenantList[_loc7_];
            while(_loc6_.indexOf(_loc5_.name) < 15 && !(_loc5_ is TenantHall) && _loc7_ != _loc4_)
            {
               if(++_loc7_ >= head.tenantList.length)
               {
                  _loc7_ = 0;
               }
               _loc5_ = head.tenantList[_loc7_];
            }
            _loc2_.closeMenu();
            if(_loc7_ != _loc4_ || _loc8_)
            {
               selectTenant(_loc5_);
            }
            else
            {
               head.addNotification("No entertainment found");
            }
         }
      }
      
      public function SearchGeneralStore(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         if(head.menuParent.numChildren <= 0)
         {
            _loc2_ = null;
         }
         else
         {
            _loc2_ = head.menuParent.getChildAt(0);
         }
         if(_loc2_ == null || _loc2_.buildingRelation == null)
         {
            if(head.tenantList.length > 0)
            {
               _loc3_ = Math.floor(Math.random() * head.tenantList.length);
               _loc4_ = -1;
               _loc5_ = head.tenantList[_loc3_];
               _loc6_ = head.userinterface.btnArr;
               while((_loc6_.indexOf(_loc5_.name) < 0 || _loc6_.indexOf(_loc5_.name) > 8) && _loc3_ != _loc4_)
               {
                  if(_loc4_ == -1)
                  {
                     _loc4_ = _loc3_;
                  }
                  _loc3_++;
                  if(_loc3_ >= head.tenantList.length)
                  {
                     _loc3_ = 0;
                  }
                  _loc5_ = head.tenantList[_loc3_];
               }
               if(_loc2_ != null)
               {
                  _loc2_.closeMenu();
               }
               if(_loc3_ != _loc4_)
               {
                  selectTenant(_loc5_);
               }
               else
               {
                  head.addNotification("No general store found");
               }
            }
            else
            {
               head.addNotification("Booth not found");
            }
         }
         else
         {
            _loc7_ = head.tenantList.indexOf(_loc2_.buildingRelation);
            _loc8_ = (_loc6_ = head.userinterface.btnArr).indexOf(_loc2_.buildingRelation.name) >= 0 && _loc6_.indexOf(_loc2_.buildingRelation.name) <= 8;
            _loc4_ = _loc7_;
            if(++_loc7_ >= head.tenantList.length)
            {
               _loc7_ = 0;
            }
            _loc5_ = head.tenantList[_loc7_];
            while((_loc6_.indexOf(_loc5_.name) < 0 || _loc6_.indexOf(_loc5_.name) > 8) && _loc7_ != _loc4_)
            {
               if(++_loc7_ >= head.tenantList.length)
               {
                  _loc7_ = 0;
               }
               _loc5_ = head.tenantList[_loc7_];
            }
            _loc2_.closeMenu();
            if(_loc7_ != _loc4_ || _loc8_)
            {
               selectTenant(_loc5_);
            }
            else
            {
               head.addNotification("No general store found");
            }
         }
      }
      
      public function selectTenant(param1:MovieClip) : void
      {
         var _loc2_:* = undefined;
         if(param1 is TenantHall)
         {
            _loc2_ = new UI_HallInformation();
         }
         else
         {
            _loc2_ = new UI_TenantInformation();
         }
         _loc2_.x = head.menuX;
         _loc2_.y = head.menuY;
         _loc2_.buildingRelation = param1;
         param1.transform.colorTransform = new ColorTransform(0.7,0.7,0,1,0,0,0,0);
         head.menuParent.addChild(_loc2_);
         head.cameraX = param1.worldX + param1.width / 2 - head.CAMERA_WIDTH / 2;
         head.cameraY = param1.worldY + param1.height / 2 - head.CAMERA_HEIGHT + 120;
      }
   }
}
