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
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.Game_547")]
   public dynamic class Game_547 extends MovieClip
   {
       
      
      public var btnList:*;
      
      public var amtTechnician:MovieClip;
      
      public var i:*;
      
      public var myParent:*;
      
      public var amtSecurity:MovieClip;
      
      public var btnCleaningService:MovieClip;
      
      public var amtList:*;
      
      public var commentList:*;
      
      public var priceList:*;
      
      public var amtCService:MovieClip;
      
      public var btnSecurity:MovieClip;
      
      public var btnTechnician:MovieClip;
      
      public var head:*;
      
      public function Game_547()
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
         btnList.push(btnCleaningService);
         btnList.push(btnTechnician);
         btnList.push(btnSecurity);
         amtList = new Array();
         amtList.push(amtCService);
         amtList.push(amtTechnician);
         amtList.push(amtSecurity);
         commentList = new Array();
         commentList.push("Hire Cleaning staff");
         commentList.push("Hire Technician");
         commentList.push("Hire Security agent");
         priceList = new Array();
         i = 0;
         while(i < head.EMPLOYEE_PRICE.length)
         {
            priceList.push(head.EMPLOYEE_PRICE[i]);
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
         _loc1_ = 0;
         while(_loc1_ < btnList.length)
         {
            _loc2_ = btnList[_loc1_];
            amtList[_loc1_].relation = _loc2_;
            amtList[_loc1_].amount.text = head.countEmployee(_loc1_);
            _loc1_++;
         }
      }
   }
}
