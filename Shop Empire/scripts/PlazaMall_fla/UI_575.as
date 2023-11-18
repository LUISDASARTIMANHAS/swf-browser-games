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
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.UI_575")]
   public dynamic class UI_575 extends MovieClip
   {
       
      
      public var statisfied:MovieClip;
      
      public var angry:MovieClip;
      
      public var head:*;
      
      public var normal:MovieClip;
      
      public var upset:MovieClip;
      
      public function UI_575()
      {
         super();
         addFrameScript(0,frame1,1,frame2,2,frame3,3,frame4,10,frame11,11,frame12,20,frame21);
      }
      
      public function SearchHappyVisitor(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         if(head.visitorFocus == null || head.visitorList.indexOf(head.visitorFocus) < 0)
         {
            if(head.visitorList.length > 0)
            {
               _loc2_ = Math.floor(Math.random() * head.visitorList.length);
               _loc3_ = -1;
               _loc4_ = head.visitorList[_loc2_];
               while(_loc4_.mood <= 75 && _loc2_ != _loc3_)
               {
                  if(_loc3_ == -1)
                  {
                     _loc3_ = _loc2_;
                  }
                  _loc2_++;
                  if(_loc2_ >= head.visitorList.length)
                  {
                     _loc2_ = 0;
                  }
                  _loc4_ = head.visitorList[_loc2_];
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
                  selectVisitor(_loc4_);
               }
               else
               {
                  head.addNotification("No happy visitor found");
               }
            }
            else
            {
               head.addNotification("No visitor found");
            }
         }
         else
         {
            _loc6_ = head.visitorList.indexOf(head.visitorFocus);
            _loc7_ = head.visitorFocus.mood > 75;
            _loc3_ = _loc6_;
            if(++_loc6_ >= head.visitorList.length)
            {
               _loc6_ = 0;
            }
            _loc4_ = head.visitorList[_loc6_];
            while(_loc4_.mood <= 75 && _loc6_ != _loc3_)
            {
               if(++_loc6_ >= head.visitorList.length)
               {
                  _loc6_ = 0;
               }
               _loc4_ = head.visitorList[_loc6_];
            }
            head.visitorFocus.filters = [];
            if(head.menuParent.numChildren > 0)
            {
               (_loc5_ = head.menuParent.getChildAt(0)).closeMenu();
            }
            if(_loc6_ != _loc3_ || _loc7_)
            {
               selectVisitor(_loc4_);
            }
            else
            {
               head.addNotification("No happy visitor found");
            }
         }
      }
      
      internal function frame3() : *
      {
         normal.iconSymbol.gotoAndStop("normal");
         normal.Note.text = "Neutral visitor";
      }
      
      internal function frame1() : *
      {
         angry.iconSymbol.gotoAndStop("angry");
         angry.Note.text = "Very angry visitor";
      }
      
      internal function frame12() : *
      {
         statisfied.removeEventListener(MouseEvent.CLICK,SearchHappyVisitor);
         normal.removeEventListener(MouseEvent.CLICK,SearchNeutralVisitor);
         upset.removeEventListener(MouseEvent.CLICK,SearchUpsetVisitor);
         angry.removeEventListener(MouseEvent.CLICK,SearchAngryVisitor);
      }
      
      public function SearchAngryVisitor(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         if(head.visitorFocus == null || head.visitorList.indexOf(head.visitorFocus) < 0)
         {
            if(head.visitorList.length > 0)
            {
               _loc2_ = Math.floor(Math.random() * head.visitorList.length);
               _loc3_ = -1;
               _loc4_ = head.visitorList[_loc2_];
               while(_loc4_.mood > 25 && _loc2_ != _loc3_)
               {
                  if(_loc3_ == -1)
                  {
                     _loc3_ = _loc2_;
                  }
                  _loc2_++;
                  if(_loc2_ >= head.visitorList.length)
                  {
                     _loc2_ = 0;
                  }
                  _loc4_ = head.visitorList[_loc2_];
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
                  selectVisitor(_loc4_);
               }
               else
               {
                  head.addNotification("No angry visitor found");
               }
            }
            else
            {
               head.addNotification("No visitor found");
            }
         }
         else
         {
            _loc6_ = head.visitorList.indexOf(head.visitorFocus);
            _loc7_ = head.visitorFocus.mood <= 25;
            _loc3_ = _loc6_;
            if(++_loc6_ >= head.visitorList.length)
            {
               _loc6_ = 0;
            }
            _loc4_ = head.visitorList[_loc6_];
            while(_loc4_.mood > 25 && _loc6_ != _loc3_)
            {
               if(++_loc6_ >= head.visitorList.length)
               {
                  _loc6_ = 0;
               }
               _loc4_ = head.visitorList[_loc6_];
            }
            head.visitorFocus.filters = [];
            if(head.menuParent.numChildren > 0)
            {
               (_loc5_ = head.menuParent.getChildAt(0)).closeMenu();
            }
            if(_loc6_ != _loc3_ || _loc7_)
            {
               selectVisitor(_loc4_);
            }
            else
            {
               head.addNotification("No angry visitor found");
            }
         }
      }
      
      public function SearchUpsetVisitor(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         if(head.visitorFocus == null || head.visitorList.indexOf(head.visitorFocus) < 0)
         {
            if(head.visitorList.length > 0)
            {
               _loc2_ = Math.floor(Math.random() * head.visitorList.length);
               _loc3_ = -1;
               _loc4_ = head.visitorList[_loc2_];
               while((_loc4_.mood <= 25 || _loc4_.mood > 50) && _loc2_ != _loc3_)
               {
                  if(_loc3_ == -1)
                  {
                     _loc3_ = _loc2_;
                  }
                  _loc2_++;
                  if(_loc2_ >= head.visitorList.length)
                  {
                     _loc2_ = 0;
                  }
                  _loc4_ = head.visitorList[_loc2_];
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
                  selectVisitor(_loc4_);
               }
               else
               {
                  head.addNotification("No upset visitor found");
               }
            }
            else
            {
               head.addNotification("No visitor found");
            }
         }
         else
         {
            _loc6_ = head.visitorList.indexOf(head.visitorFocus);
            _loc7_ = head.visitorFocus.mood > 25 && head.visitorFocus.mood <= 50;
            _loc3_ = _loc6_;
            if(++_loc6_ >= head.visitorList.length)
            {
               _loc6_ = 0;
            }
            _loc4_ = head.visitorList[_loc6_];
            while((_loc4_.mood <= 25 || _loc4_.mood > 50) && _loc6_ != _loc3_)
            {
               if(++_loc6_ >= head.visitorList.length)
               {
                  _loc6_ = 0;
               }
               _loc4_ = head.visitorList[_loc6_];
            }
            head.visitorFocus.filters = [];
            if(head.menuParent.numChildren > 0)
            {
               (_loc5_ = head.menuParent.getChildAt(0)).closeMenu();
            }
            if(_loc6_ != _loc3_ || _loc7_)
            {
               selectVisitor(_loc4_);
            }
            else
            {
               head.addNotification("No upset visitor found");
            }
         }
      }
      
      internal function frame4() : *
      {
         statisfied.iconSymbol.gotoAndStop("happy");
         statisfied.Note.text = "Happy visitor";
      }
      
      internal function frame21() : *
      {
         this.visible = false;
      }
      
      internal function frame2() : *
      {
         upset.iconSymbol.gotoAndStop("upset");
         upset.Note.text = "Upset visitor";
      }
      
      public function SearchNeutralVisitor(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         if(head.visitorFocus == null || head.visitorList.indexOf(head.visitorFocus) < 0)
         {
            if(head.visitorList.length > 0)
            {
               _loc2_ = Math.floor(Math.random() * head.visitorList.length);
               _loc3_ = -1;
               _loc4_ = head.visitorList[_loc2_];
               while((_loc4_.mood <= 50 || _loc4_.mood > 75) && _loc2_ != _loc3_)
               {
                  if(_loc3_ == -1)
                  {
                     _loc3_ = _loc2_;
                  }
                  _loc2_++;
                  if(_loc2_ >= head.visitorList.length)
                  {
                     _loc2_ = 0;
                  }
                  _loc4_ = head.visitorList[_loc2_];
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
                  selectVisitor(_loc4_);
               }
               else
               {
                  head.addNotification("No neutral visitor found");
               }
            }
            else
            {
               head.addNotification("No visitor found");
            }
         }
         else
         {
            _loc6_ = head.visitorList.indexOf(head.visitorFocus);
            _loc7_ = head.visitorFocus.mood > 50 && head.visitorFocus.mood <= 75;
            _loc3_ = _loc6_;
            if(++_loc6_ >= head.visitorList.length)
            {
               _loc6_ = 0;
            }
            _loc4_ = head.visitorList[_loc6_];
            while((_loc4_.mood <= 50 || _loc4_.mood > 75) && _loc6_ != _loc3_)
            {
               if(++_loc6_ >= head.visitorList.length)
               {
                  _loc6_ = 0;
               }
               _loc4_ = head.visitorList[_loc6_];
            }
            head.visitorFocus.filters = [];
            if(head.menuParent.numChildren > 0)
            {
               (_loc5_ = head.menuParent.getChildAt(0)).closeMenu();
            }
            if(_loc6_ != _loc3_ || _loc7_)
            {
               selectVisitor(_loc4_);
            }
            else
            {
               head.addNotification("No neutral visitor found");
            }
         }
      }
      
      internal function frame11() : *
      {
         head = root;
         statisfied.addEventListener(MouseEvent.CLICK,SearchHappyVisitor);
         normal.addEventListener(MouseEvent.CLICK,SearchNeutralVisitor);
         upset.addEventListener(MouseEvent.CLICK,SearchUpsetVisitor);
         angry.addEventListener(MouseEvent.CLICK,SearchAngryVisitor);
         stop();
      }
      
      public function selectVisitor(param1:MovieClip) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:BitmapFilter = null;
         var _loc4_:* = undefined;
         _loc2_ = new UI_VisitorInformation();
         _loc2_.x = head.menuX;
         _loc2_.y = head.menuY;
         head.menuParent.addChild(_loc2_);
         head.visitorFocus = param1;
         _loc3_ = new GlowFilter(16746496,0.9,5,5,2);
         (_loc4_ = new Array()).push(_loc3_);
         head.visitorFocus.filters = _loc4_;
      }
   }
}
