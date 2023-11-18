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
   
   [Embed(source="/_assets/assets.swf", symbol="UI_VisitorInformation")]
   public dynamic class UI_VisitorInformation extends MovieClip
   {
       
      
      public var difX:*;
      
      public var btnClose:SimpleButton;
      
      public var difY:*;
      
      public var tRandomText:*;
      
      public var visitorName:TextField;
      
      public var favoriteList:TextField;
      
      public var newList:*;
      
      public var i:*;
      
      public var favList:*;
      
      public var randomText:*;
      
      public var myParent:*;
      
      public var commentList:TextField;
      
      public var tString:String;
      
      public var isDrag:*;
      
      public var dragDropSymbol:MovieClip;
      
      public var temp:*;
      
      public var randomElevatorText:*;
      
      public var index:*;
      
      public var conditionStatus:MovieClip;
      
      public var randomToiletText:*;
      
      public function UI_VisitorInformation()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function Draging(param1:MouseEvent) : void
      {
         isDrag = !isDrag;
         difX = param1.stageX - this.x;
         difY = param1.stageY - this.y;
      }
      
      public function MouseOverEvent(param1:MouseEvent) : void
      {
         myParent.menuOver = true;
      }
      
      internal function frame1() : *
      {
         visitorName.autoSize = TextFieldAutoSize.CENTER;
         commentList.autoSize = TextFieldAutoSize.LEFT;
         myParent = root;
         addEventListener(MouseEvent.MOUSE_OVER,MouseOverEvent);
         addEventListener(MouseEvent.MOUSE_OUT,MouseOutEvent);
         addEventListener(Event.ENTER_FRAME,Update);
         favList = new Array();
         i = 0;
         while(i < myParent.visitorFocus.interestList.length)
         {
            temp = myParent.visitorFocus.interestList[i];
            if(temp != "Other")
            {
               index = myParent.userinterface.btnArr.indexOf(temp);
               newList = myParent.TENANT_TEXT[index];
               if(favList.indexOf(newList) < 0)
               {
                  favList.push(newList);
               }
            }
            ++i;
         }
         if(myParent.visitorFocus.visitorName)
         {
            visitorName.text = myParent.visitorFocus.visitorName;
         }
         else
         {
            visitorName.text = "";
         }
         favoriteList.autoSize = TextFieldAutoSize.CENTER;
         tString = "";
         i = 0;
         while(i < favList.length)
         {
            tString += favList[i] + "\n";
            ++i;
         }
         favoriteList.text = tString;
         btnClose.addEventListener(MouseEvent.CLICK,Closing);
         randomText = -1;
         tRandomText = Math.floor(Math.random() * myParent.commentList[myParent.visitorFocus.interest].length);
         if(myParent.hall != null && myParent.visitorFocus.destination == myParent.hall)
         {
            tRandomText = Math.floor(Math.random() * myParent.eventCommentList[myParent.nowEvent].length);
         }
         randomToiletText = -1;
         randomElevatorText = -1;
         stage.addEventListener(KeyboardEvent.KEY_UP,CloseWithKey);
         dragDropSymbol.addEventListener(MouseEvent.MOUSE_DOWN,Draging);
         dragDropSymbol.addEventListener(MouseEvent.MOUSE_UP,Droping);
         stage.addEventListener(MouseEvent.MOUSE_MOVE,Moving);
      }
      
      public function Moving(param1:MouseEvent) : void
      {
         if(isDrag)
         {
            this.x = param1.stageX - difX;
            this.y = param1.stageY - difY;
            myParent.menuX = this.x;
            myParent.menuY = this.y;
         }
      }
      
      public function MouseOutEvent(param1:MouseEvent) : void
      {
         myParent.menuOver = false;
      }
      
      public function Closing(param1:MouseEvent) : void
      {
         closeMenu();
      }
      
      public function closeMenu() : void
      {
         stage.focus = stage;
         myParent.visitorFocus.filters = [];
         myParent.visitorFocus = null;
         btnClose.removeEventListener(MouseEvent.CLICK,Closing);
         stage.removeEventListener(KeyboardEvent.KEY_UP,CloseWithKey);
         removeEventListener(Event.ENTER_FRAME,Update);
         this.parent.removeChild(this);
      }
      
      public function CloseWithKey(param1:KeyboardEvent) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = param1.keyCode;
         if(_loc2_ == Keyboard.ESCAPE)
         {
            closeMenu();
         }
      }
      
      public function Droping(param1:MouseEvent) : void
      {
         isDrag = false;
      }
      
      public function Update(param1:Event) : void
      {
         var frameIndex:* = undefined;
         var tString:String = null;
         var temp:* = undefined;
         var textIndex:* = undefined;
         var event:Event = param1;
         frameIndex = Math.ceil(myParent.visitorFocus.mood / 25);
         if(frameIndex > conditionStatus.totalFrames)
         {
            frameIndex = conditionStatus.totalFrames;
         }
         conditionStatus.gotoAndPlay(frameIndex);
         tString = "";
         if(!myParent.visitorFocus.goHome)
         {
            if(myParent.visitorFocus.lastDestination == null || myParent.visitorFocus.destination != myParent.visitorFocus.lastDestination)
            {
               if(myParent.hall == null || myParent.visitorFocus.destination != myParent.hall)
               {
                  temp = myParent.commentList[myParent.visitorFocus.interest];
                  if(!myParent.visitorFocus.visiting)
                  {
                     if(randomText < 0 || randomText >= temp.length)
                     {
                        textIndex = Math.floor(Math.random() * temp.length);
                        randomText = textIndex;
                        tRandomText = textIndex;
                     }
                  }
                  else
                  {
                     randomText = -1;
                  }
                  tString = String(temp[tRandomText]);
                  if(myParent.visitorFocus.gender)
                  {
                     if(tString == "Need gown for tonight")
                     {
                        tString = "Need tuxedo for tonight";
                     }
                     else if(tString == "Victoria\'s dress looks beautiful")
                     {
                        tString = "I think my girlfriend looks for new dress";
                     }
                     else if(tString == "I want to buy a golden necklace")
                     {
                        tString = "I will looks more cool with a golden necklace";
                     }
                  }
                  else if(tString == "I\'m searching for a pair of earrings for her gift")
                  {
                     tString = "I\'m searching for a pair of earrings";
                  }
                  else if(tString == "Need a diamond ring to propose her")
                  {
                     tString = "I will be more elegant with new diamond ring";
                  }
               }
               else
               {
                  temp = myParent.eventCommentList[myParent.nowEvent];
                  if(!myParent.visitorFocus.visiting)
                  {
                     if(randomText < 0 || randomText >= temp.length)
                     {
                        textIndex = Math.floor(Math.random() * temp.length);
                        randomText = textIndex;
                        tRandomText = textIndex;
                     }
                  }
                  else
                  {
                     randomText = -1;
                  }
                  tString = String(temp[tRandomText]);
               }
            }
            else
            {
               tString = "Maybe I\'ll just walking around before visit my next destination";
            }
            if(myParent.visitorFocus.toiletTarget != null)
            {
               if(randomToiletText < 0 || randomToiletText >= myParent.supportComment[0].length)
               {
                  textIndex = Math.floor(Math.random() * myParent.supportComment[0].length);
                  randomToiletText = textIndex;
               }
               tString = String(myParent.supportComment[0][randomToiletText]);
            }
            else
            {
               randomToiletText = -1;
            }
         }
         else
         {
            with(myParent)
            {
               
               if(visitorFocus.mood > 75)
               {
                  tString = "It\'s a great place";
               }
               else if(visitorFocus.mood > 50)
               {
                  tString = "It\'s enough for today";
               }
               else if(visitorFocus.mood > 25)
               {
                  tString = "This mall is sucks";
               }
               else
               {
                  tString = "Worst place that I ever visited";
               }
               if(visitorFocus.toiletTrouble)
               {
                  if(visitorFocus.mood > 75)
                  {
                     tString += " but why no restroom here";
                  }
                  else if(visitorFocus.mood > 50)
                  {
                     tString += " because no toilet here";
                  }
                  else
                  {
                     tString += " even toilet is not exist";
                  }
               }
            }
         }
         if(myParent.visitorFocus.elevatorTrouble)
         {
            if(randomElevatorText < 0 || randomElevatorText >= myParent.supportComment[1].length)
            {
               textIndex = Math.floor(Math.random() * myParent.supportComment[1].length);
               randomElevatorText = textIndex;
            }
            tString = String(myParent.supportComment[1][randomElevatorText]);
         }
         else
         {
            randomElevatorText = -1;
         }
         commentList.text = tString;
      }
   }
}
