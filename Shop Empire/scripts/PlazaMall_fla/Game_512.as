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
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.Game_512")]
   public dynamic class Game_512 extends MovieClip
   {
       
      
      public var amtToyStore:MovieClip;
      
      public var btnList:*;
      
      public var btnDrugStore:MovieClip;
      
      public var btnBarberShop:MovieClip;
      
      public var amtDrugStore:MovieClip;
      
      public var amtBoutique:MovieClip;
      
      public var btnBoutiqueB:MovieClip;
      
      public var amtSalon:MovieClip;
      
      public var btnBoutiqueA:MovieClip;
      
      public var myParent:*;
      
      public var btnBabyShop:MovieClip;
      
      public var btnSupermarket:MovieClip;
      
      public var btnBookStore:MovieClip;
      
      public var priceList:*;
      
      public var amtBookStore:MovieClip;
      
      public var amtList:*;
      
      public var amtClothingStore:MovieClip;
      
      public var commentList:*;
      
      public var btnToyStore:MovieClip;
      
      public var amtSupermarket:MovieClip;
      
      public var i:*;
      
      public var btnJewelry:MovieClip;
      
      public var amtBabyShop:MovieClip;
      
      public var head:*;
      
      public var amtJewelry:MovieClip;
      
      public function Game_512()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function btnCommentAppear(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         _loc2_ = param1.currentTarget;
         if(_loc2_.btnTog.buttonMode)
         {
            _loc3_ = this.parent.parent;
            _loc4_ = btnList.indexOf(param1.currentTarget);
            _loc3_.legend = new LegendWideBox();
            _loc3_.legend.alignment = "Left";
            if(_loc4_ >= 0)
            {
               _loc5_ = _loc3_.myParent.MoneySplit(priceList[_loc4_]);
               _loc3_.legend.commentText = commentList[_loc4_] + " ($ " + _loc5_ + ".-)";
            }
            head.noticeParent.addChild(_loc3_.legend);
         }
      }
      
      public function DisableButton(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = 0;
         while(_loc2_ < btnList.length)
         {
            if(btnList[_loc2_] != param1.currentTarget)
            {
               btnList[_loc2_].btnTog.tog = false;
            }
            _loc2_++;
         }
      }
      
      public function disableAllButton() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = 0;
         while(_loc1_ < btnList.length)
         {
            btnList[_loc1_].btnTog.tog = false;
            _loc1_++;
         }
      }
      
      internal function frame1() : *
      {
         head = root;
         btnList = new Array();
         btnList.push(btnDrugStore);
         btnList.push(btnBabyShop);
         btnList.push(btnBookStore);
         btnList.push(btnBoutiqueA);
         btnList.push(btnBoutiqueB);
         btnList.push(btnToyStore);
         btnList.push(btnBarberShop);
         btnList.push(btnJewelry);
         btnList.push(btnSupermarket);
         amtList = new Array();
         amtList.push(amtDrugStore);
         amtList.push(amtBabyShop);
         amtList.push(amtBookStore);
         amtList.push(amtBoutique);
         amtList.push(amtClothingStore);
         amtList.push(amtToyStore);
         amtList.push(amtSalon);
         amtList.push(amtJewelry);
         amtList.push(amtSupermarket);
         commentList = new Array();
         commentList.push("Build Drug Store");
         commentList.push("Build Baby Shop");
         commentList.push("Build Book Store");
         commentList.push("Build Boutique");
         commentList.push("Build Clothing Store");
         commentList.push("Build Toy Store");
         commentList.push("Build Beauty Salon");
         commentList.push("Build Jewelry");
         commentList.push("Build Supermarket");
         priceList = new Array();
         i = 0;
         while(i < head.GENERAL_PRICE.length)
         {
            priceList.push(head.GENERAL_PRICE[i]);
            ++i;
         }
         i = 0;
         while(i < btnList.length)
         {
            myParent = this.parent.parent;
            btnList[i].addEventListener(MouseEvent.CLICK,DisableButton);
            btnList[i].addEventListener(MouseEvent.MOUSE_OVER,btnCommentAppear);
            btnList[i].addEventListener(MouseEvent.MOUSE_OUT,myParent.btnCommentDisappear);
            ++i;
         }
         InitButton();
      }
      
      public function InitButton() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc1_ = 0;
         while(_loc1_ < btnList.length)
         {
            _loc2_ = btnList[_loc1_];
            amtList[_loc1_].relation = btnList[_loc1_];
            _loc3_ = false;
            _loc3_ = head.totalTenantCanBuild.indexOf(_loc2_.name) >= 0;
            if(!_loc3_)
            {
               _loc2_.visible = false;
               amtList[_loc1_].visible = false;
            }
            else
            {
               amtList[_loc1_].amount.text = head.checkBuildLevel(_loc2_.name) + "";
            }
            _loc1_++;
         }
      }
   }
}
