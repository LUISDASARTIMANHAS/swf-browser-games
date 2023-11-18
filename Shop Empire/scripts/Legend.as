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
   
   [Embed(source="/_assets/assets.swf", symbol="Legend")]
   public dynamic class Legend extends MovieClip
   {
       
      
      public var worldX:*;
      
      public var worldY:*;
      
      public var newIcon:*;
      
      public var typeCode:*;
      
      public var visitor:*;
      
      public var myParent:*;
      
      public var tnt:*;
      
      public var iconPosition:MovieClip;
      
      public var moodType:*;
      
      public const ShopList:Array = ["btnDrugStore","btnBabyShop","btnBookStore","btnBoutiqueA","btnBoutiqueB","btnToyStore","btnBarberShop","btnJewelry","btnSupermarket","btnCinema","btnGameCenter"];
      
      public function Legend()
      {
         super();
         addFrameScript(0,frame1,29,frame30);
      }
      
      public function ChangePosition(param1:Event) : void
      {
         if(visitor != null)
         {
            worldX = visitor.worldX;
            worldY = visitor.worldY - visitor.height;
         }
      }
      
      internal function frame1() : *
      {
         myParent = root;
         if(moodType)
         {
            if(visitor.mood > 75)
            {
               newIcon = new legendmoodhappy();
               newIcon.x = iconPosition.x;
               newIcon.y = iconPosition.y;
               addChild(newIcon);
            }
            else if(visitor.mood > 50)
            {
               newIcon = new legendmoodnormal();
               newIcon.x = iconPosition.x;
               newIcon.y = iconPosition.y;
               addChild(newIcon);
            }
            else if(visitor.mood > 25)
            {
               newIcon = new legendmoodupset();
               newIcon.x = iconPosition.x;
               newIcon.y = iconPosition.y;
               addChild(newIcon);
            }
            else
            {
               newIcon = new legendelectricityproblem();
               newIcon.x = iconPosition.x;
               newIcon.y = iconPosition.y;
               addChild(newIcon);
            }
         }
         else if(typeCode == "ELECTRICITY")
         {
            newIcon = new legendelectricityproblem();
            newIcon.x = iconPosition.x;
            newIcon.y = iconPosition.y;
            addChild(newIcon);
         }
         else if(typeCode == "TENANT")
         {
            tnt = myParent.userinterface.btnArr[visitor.interest];
            if(ShopList.indexOf(tnt) >= 0)
            {
               newIcon = new legendneedmoreshop();
            }
            else
            {
               newIcon = new legendhungry();
            }
            newIcon.x = iconPosition.x;
            newIcon.y = iconPosition.y;
            addChild(newIcon);
         }
         else if(typeCode == "TOILET")
         {
            newIcon = new legendneedmoretoilet();
            newIcon.x = iconPosition.x;
            newIcon.y = iconPosition.y;
            addChild(newIcon);
         }
         else if(typeCode == "DIRTY")
         {
            newIcon = new legenddirty();
            newIcon.x = iconPosition.x;
            newIcon.y = iconPosition.y;
            addChild(newIcon);
         }
         else if(typeCode == "ELEVATOR")
         {
            newIcon = new legendneedmoreelevator();
            newIcon.x = iconPosition.x;
            newIcon.y = iconPosition.y;
            addChild(newIcon);
         }
         else if(typeCode == "REPAIR")
         {
            newIcon = new legendunderconstruction();
            newIcon.x = iconPosition.x;
            newIcon.y = iconPosition.y;
            addChild(newIcon);
         }
         else if(typeCode == "BANDIT")
         {
            newIcon = new legendstolen();
            newIcon.x = iconPosition.x;
            newIcon.y = iconPosition.y;
            addChild(newIcon);
         }
         try
         {
            visitor.hasALegend = true;
         }
         catch(e:Error)
         {
         }
         addEventListener(Event.ENTER_FRAME,ChangePosition);
      }
      
      internal function frame30() : *
      {
         stop();
         try
         {
            visitor.hasALegend = false;
         }
         catch(e:Error)
         {
         }
         removeEventListener(Event.ENTER_FRAME,ChangePosition);
         this.parent.removeChild(this);
      }
   }
}
