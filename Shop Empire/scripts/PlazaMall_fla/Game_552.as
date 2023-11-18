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
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.Game_552")]
   public dynamic class Game_552 extends MovieClip
   {
       
      
      public var btnList:*;
      
      public var btnGameCenter:MovieClip;
      
      public var i:*;
      
      public var btnCinema:MovieClip;
      
      public var myParent:*;
      
      public var priceList:*;
      
      public var amtList:*;
      
      public var commentList:*;
      
      public var btnHall:MovieClip;
      
      public var amtGameCenter:MovieClip;
      
      public var amtCinema:MovieClip;
      
      public var head:*;
      
      public function Game_552()
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
         _loc3_ = this.parent.parent;
         if(_loc2_.btnTog.buttonMode)
         {
            if(_loc2_.btnTog.canClick)
            {
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
            else if(_loc2_.name == "btnHall")
            {
               _loc3_.legend = new LegendWideBox();
               _loc3_.legend.alignment = "Left";
               _loc3_.legend.commentText = "Booth already exist";
               head.noticeParent.addChild(_loc3_.legend);
            }
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
         btnList.push(btnCinema);
         btnList.push(btnGameCenter);
         btnList.push(btnHall);
         amtList = new Array();
         amtList.push(amtCinema);
         amtList.push(amtGameCenter);
         commentList = new Array();
         commentList.push("Build Movie Cinema");
         commentList.push("Build Game Center");
         commentList.push("Build Hall. Limited one");
         priceList = new Array();
         i = 0;
         while(i < head.ENTERTAINMENT_PRICE.length)
         {
            priceList.push(head.ENTERTAINMENT_PRICE[i]);
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
            _loc3_ = false;
            _loc3_ = head.totalTenantCanBuild.indexOf(_loc2_.name) >= 0;
            if(!_loc3_)
            {
               _loc2_.visible = false;
            }
            if(_loc1_ in amtList)
            {
               if(!_loc3_)
               {
                  amtList[_loc1_].visible = false;
               }
               else
               {
                  amtList[_loc1_].amount.text = head.checkBuildLevel(_loc2_.name) + "";
               }
               amtList[_loc1_].relation = btnList[_loc1_];
            }
            _loc1_++;
         }
      }
   }
}
