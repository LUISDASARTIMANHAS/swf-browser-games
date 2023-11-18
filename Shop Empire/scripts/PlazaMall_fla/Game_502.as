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
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.Game_502")]
   public dynamic class Game_502 extends MovieClip
   {
       
      
      public var btnList:*;
      
      public var btnSushi:MovieClip;
      
      public var amtSushi:MovieClip;
      
      public var btnIceCream:MovieClip;
      
      public var amtCake:MovieClip;
      
      public var btnCafe:MovieClip;
      
      public var amtBurger:MovieClip;
      
      public var i:*;
      
      public var btnSteak:MovieClip;
      
      public var amtSteak:MovieClip;
      
      public var myParent:*;
      
      public var priceList:*;
      
      public var amtList:*;
      
      public var amtCafe:MovieClip;
      
      public var amtIceCream:MovieClip;
      
      public var commentList:*;
      
      public var btnCake:MovieClip;
      
      public var head:*;
      
      public var btnBurger:MovieClip;
      
      public function Game_502()
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
         btnList.push(btnCake);
         btnList.push(btnIceCream);
         btnList.push(btnBurger);
         btnList.push(btnSteak);
         btnList.push(btnSushi);
         btnList.push(btnCafe);
         amtList = new Array();
         amtList.push(amtCake);
         amtList.push(amtIceCream);
         amtList.push(amtBurger);
         amtList.push(amtSteak);
         amtList.push(amtSushi);
         amtList.push(amtCafe);
         commentList = new Array();
         commentList.push("Build Cake Shop");
         commentList.push("Build Ice Cream Counter");
         commentList.push("Build Burger Store");
         commentList.push("Build Steak \'n\' Grill");
         commentList.push("Build Sushi Bar");
         commentList.push("Build Cafe");
         priceList = new Array();
         i = 0;
         while(i < head.FOOD_PRICE.length)
         {
            priceList.push(head.FOOD_PRICE[i]);
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
