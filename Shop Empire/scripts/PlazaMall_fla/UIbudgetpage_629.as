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
   
   [Embed(source="/_assets/assets.swf", symbol="PlazaMall_fla.UIbudgetpage_629")]
   public dynamic class UIbudgetpage_629 extends MovieClip
   {
       
      
      public var diff:*;
      
      public var scrollBar:MovieClip;
      
      public var outcomeList:MovieClip;
      
      public var totalEarning:TextField;
      
      public var difference:TextField;
      
      public var visitorComeList:MovieClip;
      
      public var closeBtn:SimpleButton;
      
      public var discription:MovieClip;
      
      public var appear:*;
      
      public var gainList:MovieClip;
      
      public var statisticTimer:*;
      
      public var incomeList:MovieClip;
      
      public function UIbudgetpage_629()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function UpdatePosition(param1:Event) : void
      {
         if(scrollBar.visible)
         {
            discription.textList.y = 5 - diff * scrollBar.getPosition();
            visitorComeList.textList.y = 5 - diff * scrollBar.getPosition();
            incomeList.textList.y = 5 - diff * scrollBar.getPosition();
            outcomeList.textList.y = 5 - diff * scrollBar.getPosition();
            gainList.textList.y = 5 - diff * scrollBar.getPosition();
         }
      }
      
      public function CloseMenu(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         this.appear = false;
         statisticTimer = 0;
         _loc2_ = root;
         _loc2_.userinterface.btnStatistic.btnDefault.tog = false;
      }
      
      internal function frame1() : *
      {
         appear = false;
         statisticTimer = 0;
         alpha = 0;
         diff = 0;
         checkHeight();
         closeBtn.addEventListener(MouseEvent.CLICK,CloseMenu);
         addEventListener(Event.ENTER_FRAME,Appearance);
         addEventListener(Event.ENTER_FRAME,UpdatePosition);
      }
      
      public function checkHeight() : void
      {
         if(discription.textList.height > discription.writeArea.height - 10)
         {
            scrollBar.visible = true;
            diff = discription.textList.height - (discription.writeArea.height - 10);
         }
         else
         {
            scrollBar.visible = false;
            diff = 0;
         }
         scrollBar.btnScroll.y = scrollBar.line.y;
      }
      
      public function Appearance(param1:Event) : void
      {
         if(alpha <= 0)
         {
            this.visible = false;
         }
         else
         {
            this.visible = true;
         }
         if(appear || statisticTimer > 0)
         {
            if(alpha < 1)
            {
               alpha += 0.1;
            }
         }
         else if(alpha > 0)
         {
            alpha -= 0.1;
         }
         if(statisticTimer > 0)
         {
            --statisticTimer;
         }
      }
   }
}
