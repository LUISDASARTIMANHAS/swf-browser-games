package PlazaMall_fla
{
   import adobe.utils.*;
   import com.newgrounds.API;
   import com.newgrounds.components.APIConnector;
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
   
   public dynamic class MainTimeline extends MovieClip
   {
       
      
      public var seVolume:*;
      
      public var eventSelection:*;
      
      public const CAMERA_WIDTH:* = 640;
      
      public const TipsList:Array = ["Promoting your employees are better than hire a new one.","Use A, S, W, D keys or arrow keys to scroll the screen","Click on your employees and pinpoint their work area.","Click on visitors to see what they want","Increase your income by upgrading the booth.","Special visitors increase your popularity.","Hire employees, Hold down CTRL key to set a specific floor as work area.","Arranging events in the hall increase popularity and improves the mood of your customers.","Hold SHIFT key when building or hiring staff to quickly duplicate repeat the action.","Not every booth is compatible with another. Carefully plan your layout to gain the best popularity for your shopping mall.","Save your cash to pay your employees every night.","Pay attention and fulfill the missions to earn extra cash.","You will lose the game, if your stays below zero for two days on a row.","Press the ESC key to close build and hire mode. ESC will also close certain popup windows"];
      
      public var night:MovieClip;
      
      public var mallWidth:*;
      
      public var alarmTransform:*;
      
      public var aT:*;
      
      public var banditCaptured:*;
      
      public var flyingTextParent:*;
      
      public const MAX_Y_POSITION:* = 100;
      
      public var bgmEnvironment:*;
      
      public const SCROLL_SPEED:* = 15;
      
      public var cleaningServiceOutcome:*;
      
      public var achivementPosition:MovieClip;
      
      public var lastPosX:Number;
      
      public var lastPosY:Number;
      
      public var hall:*;
      
      public var mallLeft:*;
      
      public var sch:*;
      
      public var tipsRegion:MovieClip;
      
      public var emptyParent:MovieClip;
      
      public const EMPLOYEE_PRICE:Array = [800,1000,1200];
      
      public const MAX_VISITOR:* = 250;
      
      public var __setPropDict:Dictionary;
      
      public var tenantList:*;
      
      public var i:*;
      
      public var __id0_:APIConnector;
      
      public var floorAverage:Number;
      
      public var cloudList:*;
      
      public var pillarParent:MovieClip;
      
      public var canBuild:Boolean;
      
      public const MAX_HEIGHT:* = 1500;
      
      public var eventTime:*;
      
      public var dayTime:Number;
      
      public var backroundLayer:MovieClip;
      
      public const SUPPORT_PRICE:Array = [4000,2000];
      
      public const BANDIT_APPEAR:* = 15;
      
      public var handCursor:MovieClip;
      
      public var mouse:*;
      
      public var gameDelay:*;
      
      public var visitorCanAppear:*;
      
      public var buildParent:MovieClip;
      
      public var eventCommentList:*;
      
      public var mouseInUI:Boolean;
      
      public var fi:*;
      
      public var bgm:Sound;
      
      public var dayMinute:Number;
      
      public var dirtyDelay:*;
      
      public var otherIncome:*;
      
      public const employeeArr:Array = [CrewCleaningServicelv1,CrewTechnicianlv1,CrewSecuritylv1];
      
      public var numberVisitor:*;
      
      public var startCity:*;
      
      public var firstBandit:*;
      
      public var robedBooth:*;
      
      public var purchase:*;
      
      public var scrollDown1:*;
      
      public var finishMissionNotification:*;
      
      public const MAX_POPULARITY:* = 100;
      
      public var visitorFocus:*;
      
      public var playerName:String;
      
      public var scrollDown2:*;
      
      public var lastDayTime:*;
      
      public var sky:MovieClip;
      
      public var popularityModifier:*;
      
      public var seTransform:SoundTransform;
      
      public var firstBanditStealing:*;
      
      public var technicianOutcome:*;
      
      public var bgParent:MovieClip;
      
      public const tenantArr:Array = [TenantDrugStore,TenantBabyShop,TenantBookStore,TenantBoutiqueA,TenantBoutiqueB,TenantToyStore,TenantSalon,TenantJewelry,TenantSupermarket,TenantCake,TenantIceCream,TenantBurger,TenantSteak,TenantSushi,TenantCafe,TenantCinema,TenantGameCenter];
      
      public var nowEvent:*;
      
      public var city:*;
      
      public var gamesfreeSplash:MovieClip;
      
      public var specialVisitor:*;
      
      public var finishMission:*;
      
      public var ground:MovieClip;
      
      public var dayTemp:Number;
      
      public const ENTERTAINMENT_PRICE:Array = [40000,37500,75000];
      
      public var mission:*;
      
      public var noteRegion:MovieClip;
      
      public const MIN_BUILD_X:* = 100;
      
      public var variables2:URLVariables;
      
      public var crewList:Array;
      
      public var noticeParent:MovieClip;
      
      public var lastNumberUpset:*;
      
      public var tutorialParent:*;
      
      public var visitorDelay:Number;
      
      public var lastEarning:*;
      
      public var dayPass:Number;
      
      public var userinterface:MovieClip;
      
      public var cameraY:Number;
      
      public var bgAccParent:MovieClip;
      
      public var cameraX:Number;
      
      public const BGM_LIST:Array = [BGMParis,BGMTokyo,BGMNewYork];
      
      public const VISITOR_LIST:Array = [VisitorBlondie,VisitorStranger,VisitorBeard,VisitorAfro,VisitorNiggaFemale,VisitorNerd,VisitorMacho,VisitorWenart,VisitorReggae,VisitorCheer,VisitorNiggaMale,VisitorPunk];
      
      public var mouseIsDown:Boolean;
      
      public var tenantParent:MovieClip;
      
      public var AutoSaveGame:SharedObject;
      
      public var bgmVolume:*;
      
      public const FOOD_PRICE:Array = [5000,5000,8000,20000,15000,20000];
      
      public var preloaderIcon:MovieClip;
      
      public var numberUpset:*;
      
      public var tutorialMode:*;
      
      public var otherOutcome:*;
      
      public var alarmTrigger:*;
      
      public var bottom:*;
      
      public var visitorList:*;
      
      public var bookedEvent:*;
      
      public var securityStep:*;
      
      public var tipsHistory:Array;
      
      public var scrollLeft2:*;
      
      public var recive:*;
      
      public var scrollLeft1:*;
      
      public var seChannel:SoundChannel;
      
      public var visitorOver:*;
      
      public var maxVisitor:Number;
      
      public var expandElevatorTutor:*;
      
      public var loader2:URLLoader;
      
      public var shiftKey:*;
      
      public var defaultCityY:*;
      
      public var sunset:MovieClip;
      
      public var gameLoaded:*;
      
      public const cityName:Array = ["Paris","Tokyo","New York"];
      
      public var MAX_BUILD_X:Number;
      
      public const VISITOR_APPEAR:* = 10;
      
      public var elevatorList:*;
      
      public var brokenDelay:*;
      
      public var visitorParent:MovieClip;
      
      public var scrollRight1:*;
      
      public var scrollRight2:*;
      
      public var floorList:Array;
      
      public var menuOver:*;
      
      public var menuX:*;
      
      public var menuY:*;
      
      public var banditList:*;
      
      public var bgCity2:MovieClip;
      
      public var menuParent:MovieClip;
      
      public var MAX_WIDTH:Number;
      
      public var mainMenuBGM:*;
      
      public var mass:Number;
      
      public const GENERAL_PRICE:Array = [4000,4000,7500,9000,10000,15000,10000,20000,35000];
      
      public var scrollUp1:*;
      
      public var Achivement:SharedObject;
      
      public var drawParent:MovieClip;
      
      public var legendParent:MovieClip;
      
      public var bgmChannel:SoundChannel;
      
      public var dirtyParent:MovieClip;
      
      public var scrollUp2:*;
      
      public var cash:*;
      
      public var popularity:*;
      
      public var landmark:MovieClip;
      
      public var noteParent:*;
      
      public const EVENT_LIST:Array = ["Art Exhibition","Electronic Expo","Live Concert"];
      
      public var budget:MovieClip;
      
      public var tenantCanBuild:*;
      
      public var bgCity:MovieClip;
      
      public var banditDelay:*;
      
      public var tutorialStep:*;
      
      public const BANDIT_LIST:Array = [Bandit,Ninja,FlyingBandit];
      
      public var lastSpeed:*;
      
      public var gameSpeed:Number;
      
      public var SaveGameData:Array;
      
      public var tutorialShow:MovieClip;
      
      public var customContextMenu:ContextMenu;
      
      public var banditTrigger:*;
      
      public const CAMERA_HEIGHT:* = 440;
      
      public var request2:URLRequest;
      
      public var bgmTransform:SoundTransform;
      
      public var supportComment:*;
      
      public var canClick:*;
      
      public var commentList:*;
      
      public var alarmTimer:*;
      
      public const TENANT_TEXT:Array = ["Drug Store","Baby Shop","Book Store","Boutique","Clothing Store","Toy Store","Beauty Salon","Jewelry","Supermarket","Cake Shop","Ice Cream","Burger Store","Steak \'n\' Grill","Sushi Bar","Cafe","Movie Cinema","Game Center"];
      
      public var missionActive:*;
      
      public var totalTenantCanBuild:*;
      
      public var tBgm:*;
      
      public var swapDelay:*;
      
      public var IntroClip:MovieClip;
      
      public var nextDayPopularity:*;
      
      public var tutorialArrowParent:*;
      
      public var canGameOver:*;
      
      public var missionReward:*;
      
      public const SPECIAL_VISITOR_LIST:Array = [VisitorJustinBieber,VisitorLadyGaga,VisitorParisHilton,VisitorRihana,VisitorJustinBieber,VisitorLadyGaga,VisitorParisHilton,VisitorRihana,VisitorObama];
      
      public var securityTutor:*;
      
      public var restroomList:*;
      
      public var drawArea:MovieClip;
      
      public var securityOutcome:*;
      
      public var mainMenuBGMChannel:SoundChannel;
      
      public function MainTimeline()
      {
         __setPropDict = new Dictionary(true);
         super();
         addFrameScript(0,frame1,2,frame3,3,frame4,4,frame5,5,frame6,6,frame7,7,frame8,8,frame9,9,frame10);
      }
      
      public function FloorDetection(param1:Event) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = param1.currentTarget;
         _loc2_.ground.tenantList.push(_loc2_);
         _loc2_.removeEventListener(Event.ENTER_FRAME,FloorDetection);
      }
      
      public function MouseDownEvent(param1:MouseEvent) : void
      {
         if(!mouseInUI)
         {
            mouseIsDown = true;
            lastPosX = param1.stageX;
            lastPosY = param1.stageY;
         }
      }
      
      public function countHappyVisitor() : Number
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc1_ = 0;
         _loc2_ = 0;
         while(_loc2_ < visitorList.length)
         {
            _loc3_ = visitorList[_loc2_];
            if(_loc3_.mood > 75)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function createStreet() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc2_ = new BGStreet();
            _loc2_.worldX = _loc1_ * _loc2_.width;
            _loc2_.worldY = MAX_HEIGHT;
            _loc2_.x = _loc2_.worldX - cameraX;
            _loc2_.y = _loc2_.worldY - cameraY;
            if(city == 1)
            {
               _loc2_.removeChild(_loc2_.tree1);
               _loc2_.removeChild(_loc2_.tree2);
            }
            else
            {
               _loc2_.removeChild(_loc2_.sakura1);
               _loc2_.removeChild(_loc2_.sakura2);
            }
            bgParent.addChild(_loc2_);
            _loc1_++;
         }
         MAX_WIDTH = _loc1_ * _loc2_.width;
         MAX_BUILD_X = MAX_WIDTH - 100;
         cameraX = MAX_WIDTH / 2 - CAMERA_WIDTH / 2;
         ground.worldY = MAX_HEIGHT;
         sky.worldY = 0;
         mallLeft = MAX_WIDTH;
      }
      
      public function ScrollingWithKey(param1:Event) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = SCROLL_SPEED;
         if(shiftKey)
         {
            _loc2_ = 1;
         }
         if(scrollLeft1)
         {
            cameraX -= _loc2_;
         }
         if(scrollLeft2)
         {
            cameraX -= _loc2_;
         }
         if(scrollRight1)
         {
            cameraX += _loc2_;
         }
         if(scrollRight2)
         {
            cameraX += _loc2_;
         }
         if(cameraX <= 0)
         {
            cameraX = 0;
         }
         if(cameraX + CAMERA_WIDTH >= MAX_WIDTH)
         {
            cameraX = MAX_WIDTH - CAMERA_WIDTH;
         }
         if(scrollUp1)
         {
            cameraY -= _loc2_;
         }
         if(scrollUp2)
         {
            cameraY -= _loc2_;
         }
         if(scrollDown1)
         {
            cameraY += _loc2_;
         }
         if(scrollDown2)
         {
            cameraY += _loc2_;
         }
         if(cameraY <= 0)
         {
            cameraY = 0;
         }
         if(cameraY + CAMERA_HEIGHT >= MAX_HEIGHT)
         {
            cameraY = MAX_HEIGHT - CAMERA_HEIGHT;
         }
      }
      
      public function EmployeeOnClick(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:BitmapFilter = null;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         if(userinterface.getButtonActive() != 0 && canClick < 7 && param1.currentTarget != visitorFocus)
         {
            if(visitorFocus != null)
            {
               visitorFocus.filters = [];
            }
            if(menuParent.numChildren > 0)
            {
               (_loc5_ = menuParent.getChildAt(0)).closeMenu();
            }
            _loc2_ = new UI_EmployeeInformation();
            _loc2_.x = menuX;
            _loc2_.y = menuY;
            menuParent.addChild(_loc2_);
            visitorFocus = param1.currentTarget;
            _loc3_ = new GlowFilter(16746496,0.9,5,5,2);
            (_loc4_ = new Array()).push(_loc3_);
            visitorFocus.filters = _loc4_;
         }
      }
      
      public function addNotification(param1:String, param2:Number = 1) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         _loc3_ = new UI_Notification();
         _loc3_.note.info.text = param1;
         _loc3_.x = noteRegion.x;
         _loc3_.y = noteRegion.y;
         _loc3_.alpha = param2;
         noteParent.addChild(_loc3_);
         (_loc4_ = new SE_Notification()).play(0,0,seTransform);
      }
      
      public function TenantClicking(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         if(userinterface.getButtonActive() != 0 && canClick < 7)
         {
            if(menuParent.numChildren > 0)
            {
               _loc2_ = menuParent.getChildAt(0);
               _loc2_.closeMenu();
            }
            if(param1.currentTarget is TenantHall)
            {
               _loc3_ = new UI_HallInformation();
            }
            else
            {
               _loc3_ = new UI_TenantInformation();
            }
            _loc3_.x = menuX;
            _loc3_.y = menuY;
            _loc3_.buildingRelation = param1.currentTarget;
            param1.currentTarget.transform.colorTransform = new ColorTransform(0.7,0.7,0,1,0,0,0,0);
            menuParent.addChild(_loc3_);
         }
      }
      
      public function MouseClickEvent(param1:MouseEvent) : void
      {
         var temp:* = undefined;
         var event:MouseEvent = param1;
         if(!visitorOver && !menuOver && visitorFocus != null)
         {
            if(menuParent.numChildren > 0)
            {
               try
               {
                  temp = menuParent.getChildAt(0);
                  temp.closeMenu();
               }
               catch(e:Error)
               {
               }
            }
         }
      }
      
      internal function frame1() : *
      {
         if(__setPropDict[__id0_] == undefined || int(__setPropDict[__id0_]) != 1)
         {
            __setPropDict[__id0_] = currentFrame;
            __setProp___id0__Scene1_Main_1();
         }
         stop();
         if(!bgmVolume)
         {
            bgmVolume = 1;
         }
         if(!seVolume)
         {
            seVolume = 1;
         }
         customContextMenu = new ContextMenu();
         playerName = "";
         customContextMenu.hideBuiltInItems();
         contextMenu = customContextMenu;
         stage.showDefaultContextMenu = false;
         this.loaderInfo.addEventListener(ProgressEvent.PROGRESS,loading);
         this.loaderInfo.addEventListener(Event.COMPLETE,completes);
         if(loaderInfo.url.substring(0,4) != "file")
         {
            Security.allowDomain("*");
            Security.loadPolicyFile("http://track.g-bot.net/crossdomain.xml");
            variables2 = new URLVariables();
            variables2.id = "shopempire";
            variables2.ui = loaderInfo.url;
            request2 = new URLRequest("http://track.g-bot.net/track.php");
            request2.method = "POST";
            request2.data = variables2;
            loader2 = new URLLoader();
            loader2.load(request2);
         }
      }
      
      public function savingTrash() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         AutoSaveGame.data.trashWorldX = new Array();
         AutoSaveGame.data.trashWorldY = new Array();
         AutoSaveGame.data.trashLevel = new Array();
         AutoSaveGame.data.trashGround = new Array();
         _loc1_ = 0;
         while(_loc1_ < dirtyParent.numChildren)
         {
            _loc2_ = dirtyParent.getChildAt(_loc1_);
            AutoSaveGame.data.trashWorldX.push(_loc2_.worldX);
            AutoSaveGame.data.trashWorldY.push(_loc2_.worldY);
            AutoSaveGame.data.trashLevel.push(_loc2_.trashLevel);
            AutoSaveGame.data.trashGround.push(floorList.indexOf(_loc2_.ground));
            _loc1_++;
         }
      }
      
      public function RemoveTutorialText(param1:MovieClip) : void
      {
         var _loc2_:* = undefined;
         if(param1.numChildren > 0)
         {
            _loc2_ = param1.getChildAt(0);
            stage.removeEventListener(MouseEvent.CLICK,_loc2_.SkipTextAnimation);
            stage.removeEventListener(KeyboardEvent.KEY_UP,_loc2_.SkipTextWithKey);
            _loc2_.removeEventListener(Event.ENTER_FRAME,_loc2_.TextAnimation);
            _loc2_.removeEventListener(MouseEvent.MOUSE_OVER,_loc2_.MouseOverEvent);
            _loc2_.removeEventListener(MouseEvent.MOUSE_OUT,_loc2_.MouseOutEvent);
            param1.removeChild(_loc2_);
         }
      }
      
      public function createFloor(param1:Number, param2:Number, param3:*) : void
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         var _loc15_:* = undefined;
         (_loc4_ = new Floor()).worldX = param1;
         _loc4_.worldY = param2;
         _loc4_.center.width = param3;
         _loc4_.rightSide.x = _loc4_.center.width;
         _loc5_ = false;
         _loc4_.x = _loc4_.worldX - cameraX;
         _loc4_.y = _loc4_.worldY - cameraY;
         _loc7_ = false;
         _loc8_ = 0;
         while(_loc8_ < pillarParent.numChildren)
         {
            if((_loc10_ = pillarParent.getChildAt(_loc8_)) is Floor && _loc10_.y == _loc4_.y)
            {
               _loc5_ = true;
               _loc6_ = _loc10_;
               if(!_loc10_.hitTestObject(_loc4_))
               {
                  _loc7_ = true;
               }
            }
            _loc8_++;
         }
         if(!_loc5_)
         {
            if((_loc11_ = floorList.pop()).worldY > _loc4_.worldY)
            {
               floorList.push(_loc11_);
               floorList.push(_loc4_);
            }
            else
            {
               floorList.push(_loc4_);
               floorList.push(_loc11_);
            }
            if(mallWidth < _loc4_.width)
            {
               mallWidth = _loc4_.width;
            }
            if(mallLeft > _loc4_.worldX)
            {
               mallLeft = _loc4_.worldX;
            }
            pillarParent.addChild(_loc4_);
         }
         else
         {
            _loc12_ = param3;
            if(_loc7_)
            {
               _loc13_ = 0;
               _loc14_ = 0;
               if(_loc6_.worldX > param1)
               {
                  _loc13_ = Math.round((_loc6_.worldX - (param1 + _loc12_)) / 12);
                  _loc14_ = param1 + _loc12_;
               }
               else
               {
                  _loc13_ = Math.round((param1 - (_loc6_.worldX + _loc6_.center.width)) / 12);
                  _loc14_ = _loc6_.worldX + _loc6_.center.width;
               }
               _loc8_ = 0;
               while(_loc8_ < _loc13_)
               {
                  (_loc15_ = new TenantEmptySpace()).worldX = _loc14_ + _loc8_ * 12;
                  _loc15_.worldY = param2 + 12;
                  emptyParent.addChild(_loc15_);
                  _loc8_++;
               }
            }
            if(_loc6_.worldX > param1)
            {
               _loc12_ = _loc6_.worldX - param1 + _loc6_.center.width;
               _loc6_.worldX = param1;
               if(_loc12_ < _loc4_.center.width)
               {
                  _loc12_ = _loc4_.center.width;
               }
            }
            else
            {
               _loc12_ = param1 - _loc6_.worldX + _loc12_;
            }
            if(_loc6_.center.width < _loc12_)
            {
               _loc6_.center.width = _loc12_;
               _loc6_.rightSide.x = _loc6_.center.width;
            }
            _loc6_.x = _loc6_.worldX - cameraX;
            _loc6_.y = _loc6_.worldY - cameraY;
            if(mallWidth < _loc6_.width)
            {
               mallWidth = _loc6_.width;
            }
            if(mallLeft > _loc6_.worldX)
            {
               mallLeft = _loc6_.worldX;
            }
            pillarParent.addChild(_loc6_);
         }
         _loc9_ = 0;
         _loc8_ = 0;
         while(_loc8_ < floorList.length)
         {
            if(floorList[_loc8_] is Floor)
            {
               _loc9_ += Math.floor(floorList[_loc8_].width / 60);
            }
            _loc8_++;
         }
         if(floorList.length - 1 > 0)
         {
            floorAverage = Math.floor(_loc9_ / (floorList.length - 1));
         }
         else
         {
            floorAverage = 0;
         }
      }
      
      public function AlarmLoop(param1:Event) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = new SEAlarm();
         seChannel = _loc2_.play(0,0,seTransform);
         seChannel.addEventListener(Event.SOUND_COMPLETE,AlarmLoop);
      }
      
      internal function frame5() : *
      {
         bgmTransform = new SoundTransform(bgmVolume);
         seTransform = new SoundTransform(seVolume);
         Achivement = SharedObject.getLocal("Achivement");
         AutoSaveGame = SharedObject.getLocal("AutoSave");
         SaveGameData = new Array(3);
         gameLoaded = -1;
         startCity = 0;
         tipsHistory = new Array();
         i = 0;
         while(i < SaveGameData.length)
         {
            SaveGameData[i] = SharedObject.getLocal("SaveData" + i);
            ++i;
         }
         if(!Achivement.data.trophyList)
         {
            Achivement.data.trophyList = new Array(21);
            i = 0;
            while(i < Achivement.data.trophyList.length)
            {
               Achivement.data.trophyList[i] = false;
               ++i;
            }
         }
         mainMenuBGM = new BGMMenu();
         mainMenuBGMChannel = mainMenuBGM.play(0,0,bgmTransform);
         mainMenuBGMChannel.addEventListener(Event.SOUND_COMPLETE,BGMMenuLoop);
         stop();
      }
      
      internal function frame8() : *
      {
         stop();
      }
      
      internal function frame9() : *
      {
         stop();
      }
      
      internal function frame3() : *
      {
         gamesfreeSplash.stop();
         gamesfreeSplash.buttonMode = true;
         gamesfreeSplash.addEventListener(MouseEvent.CLICK,GamesFreeURL);
         stop();
      }
      
      internal function frame6() : *
      {
         stop();
      }
      
      public function MouseUpEvent(param1:MouseEvent) : void
      {
         mouseIsDown = false;
      }
      
      internal function frame7() : *
      {
         stop();
      }
      
      public function addTutorialArrow(param1:Number, param2:Number, param3:Number = 0) : void
      {
         var _loc4_:* = undefined;
         (_loc4_ = new TutorialArrow()).x = param1;
         _loc4_.y = param2;
         _loc4_.rotation = param3;
         tutorialArrowParent.addChild(_loc4_);
      }
      
      public function getArrowPosition(param1:MovieClip) : Number
      {
         var _loc2_:* = undefined;
         return param1.currentFrame;
      }
      
      internal function frame4() : *
      {
         IntroClip.vol = seVolume;
         IntroClip.buttonMode = true;
         stop();
         IntroClip.addEventListener(MouseEvent.CLICK,LittleGiantURL);
      }
      
      internal function frame10() : *
      {
         stop();
         mouse = Mouse;
         handCursor.visible = false;
         userinterface.btnNextCity.visible = false;
         userinterface.nextTownWarning.visible = false;
         userinterface.legendHelp.visible = false;
         gameSpeed = 1;
         floorAverage = 0;
         dayPass = 1;
         cameraX = 0;
         cameraY = 1060;
         drawParent = new MovieClip();
         bgParent = new MovieClip();
         defaultCityY = bgCity.y;
         landmark = null;
         bgAccParent = new MovieClip();
         mouseIsDown = false;
         mouseInUI = false;
         emptyParent = new MovieClip();
         buildParent = new MovieClip();
         pillarParent = new MovieClip();
         tenantParent = new MovieClip();
         tenantList = new Array();
         floorList = new Array();
         alarmTrigger = false;
         elevatorList = new Array();
         restroomList = new Array();
         hall = null;
         menuParent = new MovieClip();
         menuX = stage.stageWidth / 2;
         menuY = stage.stageHeight / 2;
         menuOver = false;
         maxVisitor = 0;
         visitorParent = new MovieClip();
         banditTrigger = null;
         legendParent = new MovieClip();
         visitorFocus = null;
         visitorList = new Array();
         specialVisitor = new Array();
         crewList = new Array();
         dirtyParent = new MovieClip();
         noticeParent = new MovieClip();
         eventSelection = 0;
         nowEvent = -1;
         bookedEvent = -1;
         eventTime = 0;
         numberVisitor = 0;
         mallWidth = 0;
         popularity = 0;
         canClick = 0;
         popularityModifier = 10;
         nextDayPopularity = 0;
         noteParent = new MovieClip();
         flyingTextParent = new MovieClip();
         banditCaptured = 0;
         numberUpset = 0;
         canGameOver = false;
         firstBanditStealing = false;
         cash = 20000;
         sch = 0;
         while(sch < startCity)
         {
            cash += 10000 * (sch + 1);
            ++sch;
         }
         purchase = 0;
         recive = 0;
         missionReward = 0;
         otherIncome = 0;
         otherOutcome = 0;
         cleaningServiceOutcome = 0;
         technicianOutcome = 0;
         securityOutcome = 0;
         lastEarning = 0;
         bgmEnvironment = 1;
         tenantCanBuild = new Array(3);
         tenantCanBuild[0] = new Array("btnBarberShop","btnJewelry","btnBoutiqueA","btnBoutiqueB","btnDrugStore","btnBurger","btnCafe","btnBabyShop","btnIceCream","btnBookStore","btnHall");
         tenantCanBuild[1] = new Array("btnSushi","btnGameCenter","btnToyStore","btnCake");
         tenantCanBuild[2] = new Array("btnCinema","btnSupermarket","btnSteak");
         visitorCanAppear = new Array(3);
         visitorCanAppear[0] = new Array(0,1,2,8);
         visitorCanAppear[1] = new Array(0,1,2,5,6,7,8,11);
         visitorCanAppear[2] = new Array(0,1,2,3,4,5,6,7,8,9,10,11);
         mission = new Array(3);
         mission[0] = new Array("Build a burger store","Earn your first profit","Hire a cleaning staff member","Build a restroom","Have at least 3 visitors visit your mall","Hire a technician","Build 4 booths","Build an elevator","Build at least one booth at 2nd floor","Build a beauty salon","Hire a security agent","Catch a bandit","Make 10 visitor happy for a day","Promote 1 cleaning staff member","Promote 1 technician","Promote 1 security","Upgrade 1 booth","Earn $15,000 profits for a day","Upgrade 4 booths","Have more than 50 visitors visit your mall","Build mall with 4 floors","Earn $25,000 profits for a day","Build a hall","Run Event Art Exhibition at least one day","Earn $100,000 profits for a day","Your cash reach $350,000");
         mission[1] = new Array("Build a Toy Store","Hire 2 employees","Build 4 booths","Have at least 20 visitors visit your mall","Build a sushi bar","Hire 4 employees","Upgrade an elevator to level 3","Build a game center","Build mall with 3 floors","Hire 8 employees","Have more than 50 visitors visit your mall","Catch 5 bandits in a day","Make 20 visitors happy for a day","Promote at least 10 employees to level 2","Run Event Electronic Expo at least one day","Have more than 70 visitors visit your mall","Build mall with 6 floors","Build 5 restroom","Make 50 visitors happy for a day","Earn $50,000 profits for a day","Hire 20 employee","Earn $100,000 profits for a day","Earn $200,000 profits for a day","Your cash reach $750,000");
         mission[2] = new Array("Build a Steak n Grill","Have at least 10 visitors visit your mall","Hire 4 employees","Build 5 booths","Build 2 restroom","Build mall with 3 floors","Build 2 elevators","Hire 10 employees","Hire 4 security agents","Build 12 booths","Upgrade 5 booths","Hire 8 cleaning staff members","Upgrade 8 booths","Build a supermarket","Build a cinema","Build mall with 6 floors","Hire 8 security agents","Hire 20 employees","Have more than 50 visitors visit your mall","Catch 5 bandits in a day","Make 25 visitors happy for a day","Make 50 visitors happy for a day","Promote at least 12 employees to max level","Promote at least 20 employees to max level","Run Event Live Concert at least one day","Have more than 100 visitors visit your mall","Upgrade 10 buildings to max level","Have full upgrade hall","Make 75 visitors happy for a day","Upgrade 2 elevators to max level","Catch 10 bandits in a day","Earn $150,000 profits for a day","Earn $250,000 profits for a day","Your cash reach $1,500,000");
         finishMission = false;
         finishMissionNotification = false;
         missionActive = -1;
         city = startCity;
         totalTenantCanBuild = new Array();
         tutorialMode = true;
         tutorialStep = 0;
         tutorialParent = new MovieClip();
         tutorialArrowParent = new MovieClip();
         cloudList = new Array();
         addEventListener(Event.ENTER_FRAME,MedalStarter);
         addEventListener(Event.ENTER_FRAME,MedalContractor);
         addEventListener(Event.ENTER_FRAME,MedalHunter);
         addEventListener(Event.ENTER_FRAME,MedalMillionaire);
         expandElevatorTutor = false;
         securityTutor = false;
         securityStep = 0;
         firstBandit = null;
         lastSpeed = 0;
         commentList = new Array(TENANT_TEXT.length);
         fi = 0;
         while(fi < commentList.length)
         {
            commentList[fi] = new Array();
            ++fi;
         }
         commentList[0] = ["I think I got cold","I need lots of pills","I have to buy antibiotics for my niece","*coughing*","*sneezing*"];
         commentList[1] = ["New cloth for my chlid will be nice","I want to buy pacifier","My baby diapers are running out"];
         commentList[2] = ["Going to be a book-o-holic today","On the mood of reading romance story","Got to buy cooking magazines"];
         commentList[3] = ["Need gown for tonight","Victoria\'s dress looks beautiful","My suit have just torn"];
         commentList[4] = ["I need new shirt","Where can I get jeans?","I plan to buy a cap"];
         commentList[5] = ["My daughter wants a teddy bear","Need new toys for my son","New robot models have been launched"];
         commentList[6] = ["Need a haircut immediately!","My nails need some treatment","Desperately want to dye my hair"];
         commentList[7] = ["I want to buy a golden necklace","I\'m searching for a pair of earrings for her gift","Need a diamond ring to propose her","New bracelet will look good on me"];
         commentList[8] = ["Where\'s the market?","I want to buy fruits","I need spices","Today\'s menu is salad"];
         commentList[9] = ["Strawberry cupcake sounds yummy","My sister loves cupcakes"];
         commentList[10] = ["I want a cup of vanilla sundae","Gelato ice cream...hmm","Where can I get ice cream?"];
         commentList[11] = ["A bite of delicious burger..hmmm","Cheese burger wanted!","I miss american hotdog","I want french fries"];
         commentList[12] = ["Need to satisfy my stomach with some meat","grill ribs sounds good","Black pepper steak wanted!","Steak..steak..steak..."];
         commentList[13] = ["Japanese food sounds good","I want a sushi!!!","Salmon sushi looks tasty"];
         commentList[14] = ["Hmm..suddenly want some caramel macchiato","Time to hang out..and a cup of capuccino","I\'ll just enjoy a glass of frapuccino"];
         commentList[15] = ["Tom Crush is starring on James Blonde","Hairy Potter is on the cinema","Where\'s the movie theatre?"];
         commentList[16] = ["I want to play all day","Play a shooting game sounds great","Heard that they\'ve opened a new arcade machine"];
         supportComment = new Array(2);
         supportComment[0] = new Array();
         supportComment[1] = new Array();
         supportComment[0] = ["I need to wash my hand","Where\'s the restroom?"];
         supportComment[1] = ["Oh,c\'mon..can\'t this mall build more elevators?","I think the elevator will arrive in this floor by tomorrow"];
         eventCommentList = new Array(3);
         eventCommentList[0] = ["I want to see inspirational pieces of art","I heard that Da Cinvi\'s work were being displayed today"];
         eventCommentList[1] = ["I heard that there is electronic sale here","The New Oh Pad5 has been released. We should check it on the exhibition"];
         eventCommentList[2] = ["I hope I can make it to the live concert","\"30 Centuries to Venus\" is on stage, man!"];
         swapDelay = 72;
         visitorDelay = 0;
         visitorOver = false;
         banditDelay = 0;
         banditList = new Array();
         gameDelay = 0;
         addEventListener(Event.ENTER_FRAME,ClosingProgress);
         brokenDelay = 6;
         dirtyDelay = 48;
         scrollLeft1 = false;
         scrollLeft2 = false;
         scrollRight1 = false;
         scrollRight2 = false;
         scrollUp1 = false;
         scrollUp2 = false;
         scrollDown1 = false;
         scrollDown2 = false;
         shiftKey = false;
         alarmTransform = 1;
         aT = -0.1;
         alarmTimer = 168;
         robedBooth = null;
         Initialize();
      }
      
      public function MedalContractor(param1:Event) : void
      {
         var _loc2_:* = undefined;
         if(elevatorList.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < elevatorList.length)
            {
               if(elevatorList[_loc2_].tLevel >= elevatorList[_loc2_].MAX_LEVEL)
               {
                  API.unlockMedal("Contractor");
                  removeEventListener(Event.ENTER_FRAME,MedalContractor);
                  break;
               }
               _loc2_++;
            }
         }
      }
      
      public function countAllBooth(param1:Number = 0) : Number
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc2_ = 0;
         _loc3_ = 0;
         while(_loc3_ < tenantList.length)
         {
            if(tenantList[_loc3_].tLevel >= param1)
            {
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function UpdateMission(param1:Event) : void
      {
         var _loc2_:* = undefined;
         if(missionActive in mission[city])
         {
            if(!userinterface.objective.declareMission)
            {
               userinterface.objective.objectiveInfo.text = mission[city][missionActive];
               userinterface.objective.declareMission = true;
            }
         }
         else
         {
            if(!userinterface.objective.declareMission)
            {
               if(missionActive >= mission[city].length)
               {
                  if(city < 2)
                  {
                     userinterface.objective.objectiveInfo.text = "Go to next city";
                  }
                  else
                  {
                     userinterface.objective.objectiveInfo.text = "Thank you for playing";
                  }
               }
               userinterface.objective.declareMission = true;
            }
            if(!finishMissionNotification)
            {
               if(missionActive >= mission[city].length)
               {
                  _loc2_ = "Well Done!\nYou have completed all mission in <font color=\'#007A03\'>" + cityName[city] + "</font>\n";
                  if(city + 1 in cityName)
                  {
                     _loc2_ += "Let\'s go to <font color=\'#007A03\'>" + cityName[city + 1] + "</font> and\n build your mall there.";
                  }
                  addTutorialNotification(_loc2_,true);
                  lastSpeed = gameSpeed;
                  gameSpeed = 0;
                  userinterface.deactiveAllButton();
                  finishMissionNotification = true;
               }
            }
            else if(tutorialParent.numChildren > 0)
            {
               gameSpeed = 0;
            }
            else if(!finishMission)
            {
               finishMission = true;
               userinterface.activeAllButton();
               gameSpeed = lastSpeed;
               if(city + 1 in cityName)
               {
                  userinterface.btnNextCity.visible = true;
                  userinterface.btnNextCity.addEventListener(MouseEvent.CLICK,ChangeCity);
               }
            }
         }
      }
      
      public function CancelToNextCity(param1:MouseEvent) : void
      {
         userinterface.btnNextCity.visible = true;
         userinterface.btnNextCity.addEventListener(MouseEvent.CLICK,ChangeCity);
         userinterface.nextTownWarning.visible = false;
         userinterface.nextTownWarning.btnYes.removeEventListener(MouseEvent.CLICK,GoToNextCity);
         userinterface.nextTownWarning.btnNo.removeEventListener(MouseEvent.CLICK,CancelToNextCity);
         gameSpeed = lastSpeed;
      }
      
      public function countEmployee(param1:Number) : Number
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         _loc2_ = 0;
         _loc3_ = 0;
         while(_loc3_ < crewList.length)
         {
            _loc4_ = crewList[_loc3_];
            if(param1 == 0)
            {
               if(_loc4_ is CrewCleaningServicelv1 || _loc4_ is CrewCleaningServicelv2 || _loc4_ is CrewCleaningServicelv3)
               {
                  _loc2_++;
               }
            }
            else if(param1 == 1)
            {
               if(_loc4_ is CrewTechnicianlv1 || _loc4_ is CrewTechnicianlv2 || _loc4_ is CrewTechnicianlv3)
               {
                  _loc2_++;
               }
            }
            else if(param1 == 2)
            {
               if(_loc4_ is CrewSecuritylv1 || _loc4_ is CrewSecuritylv2 || _loc4_ is CrewSecuritylv3)
               {
                  _loc2_++;
               }
            }
            else if(param1 == 3)
            {
               if(_loc4_ is CrewCleaningServicelv2 || _loc4_ is CrewCleaningServicelv3)
               {
                  _loc2_++;
               }
            }
            else if(param1 == 4)
            {
               if(_loc4_ is CrewTechnicianlv2 || _loc4_ is CrewTechnicianlv3)
               {
                  _loc2_++;
               }
            }
            else if(param1 == 5)
            {
               if(_loc4_ is CrewSecuritylv2 || _loc4_ is CrewSecuritylv3)
               {
                  _loc2_++;
               }
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function checkBuildLevel(param1:String = null, param2:Number = 0) : Number
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         _loc3_ = 0;
         _loc4_ = 0;
         while(_loc4_ < tenantParent.numChildren)
         {
            _loc5_ = tenantParent.getChildAt(_loc4_);
            if(param1 == null || _loc5_.name == param1)
            {
               if(_loc5_.tLevel >= param2)
               {
                  _loc3_++;
               }
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function AccsoryManagement(param1:Event) : void
      {
         var _loc2_:* = undefined;
         if(cloudList.length < 10)
         {
            _loc2_ = new cloudGame();
            _loc2_.speed = Math.random() * 2 + 0.5;
            _loc2_.normal.gotoAndStop(Math.ceil(Math.random() * _loc2_.normal.totalFrames));
            _loc2_.sunset.gotoAndStop(_loc2_.normal.currentFrame);
            _loc2_.x = stage.stageWidth + _loc2_.width;
            _loc2_.y = Math.random() * stage.stageHeight;
            _loc2_.normal.alpha = 1 - sunset.alpha;
            _loc2_.sunset.alpha = sunset.alpha;
            _loc2_.alpha = 1 - night.alpha;
            bgAccParent.addChild(_loc2_);
            cloudList.push(_loc2_);
            _loc2_.addEventListener(Event.ENTER_FRAME,CloudMove);
         }
      }
      
      public function updatePopularity(param1:MovieClip) : void
      {
         var adding:* = undefined;
         var newFText:* = undefined;
         var newTenant:MovieClip = param1;
         if(!(newTenant is SupportElevator) && !(newTenant is SupportRestroom))
         {
            popularity += 5;
         }
         adding = 0;
         try
         {
            adding += newTenant.testBuildRelation();
         }
         catch(e:Error)
         {
         }
         popularity += adding;
         if(adding > 0)
         {
            newFText = new suitabilityplus();
            newFText.worldX = newTenant.worldX + newTenant.width / 2;
            newFText.worldY = newTenant.worldY + newTenant.height / 2;
            flyingTextParent.addChild(newFText);
         }
         else if(adding < 0)
         {
            newFText = new suitabilityminus();
            newFText.worldX = newTenant.worldX + newTenant.width / 2;
            newFText.worldY = newTenant.worldY + newTenant.height / 2;
            flyingTextParent.addChild(newFText);
         }
      }
      
      public function StartBuilding(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         var _loc15_:* = undefined;
         if(!mouseInUI)
         {
            if(buildParent.numChildren > 0)
            {
               canClick = 7;
               _loc2_ = buildParent.getChildAt(0);
               canBuild = checkCollition(_loc2_);
               if(!canBuild)
               {
                  addNotification("Cannot build here");
               }
               if(canBuild)
               {
                  if(cash - purchase + recive >= _loc2_.price)
                  {
                     _loc3_ = false;
                     _loc4_ = 0;
                     while(_loc4_ < userinterface.hireArr.length)
                     {
                        if(_loc2_ is userinterface.hireArr[_loc4_])
                        {
                           _loc3_ = true;
                        }
                        _loc4_++;
                     }
                     if(!_loc3_)
                     {
                        _loc5_ = false;
                        _loc6_ = false;
                        if(_loc2_ is BuildHall)
                        {
                           _loc5_ = true;
                           (_loc7_ = new TenantHall()).worldX = _loc2_.x + cameraX;
                           _loc7_.worldY = _loc2_.y + cameraY;
                           _loc7_.x = _loc2_.x;
                           _loc7_.y = _loc2_.y;
                           _loc7_.name = "Hall";
                           _loc7_.ground = bottom;
                           _loc7_.addEventListener(MouseEvent.CLICK,TenantClicking);
                           tenantParent.addChild(_loc7_);
                           tenantList.push(_loc7_);
                           _loc7_.ground.tenantList.push(_loc7_);
                           updatePopularity(_loc7_);
                           hall = _loc7_;
                           _loc7_.tLevel = 1;
                           _loc7_.income = 0;
                           _loc7_.outcome = _loc2_.price;
                           _loc7_.visitorCome = 0;
                        }
                        else if(!(_loc2_ is BuildElevator) && !(_loc2_ is BuildRestroom))
                        {
                           if((_loc8_ = userinterface.btnArr.indexOf(_loc2_.name)) >= 0)
                           {
                              _loc5_ = true;
                              (_loc7_ = new tenantArr[_loc8_]()).worldX = _loc2_.x + cameraX;
                              _loc7_.worldY = _loc2_.y + cameraY;
                              _loc7_.x = _loc2_.x;
                              _loc7_.y = _loc2_.y;
                              _loc7_.name = _loc2_.name;
                              _loc7_.ground = bottom;
                              _loc7_.addEventListener(MouseEvent.CLICK,TenantClicking);
                              tenantParent.addChild(_loc7_);
                              tenantList.push(_loc7_);
                              _loc7_.ground.tenantList.push(_loc7_);
                              updatePopularity(_loc7_);
                              _loc7_.tLevel = 1;
                              _loc7_.brokenLevel = 0;
                              _loc7_.income = 0;
                              _loc7_.outcome = _loc2_.price;
                              _loc7_.visitorCome = 0;
                           }
                        }
                        else if(_loc2_ is BuildElevator)
                        {
                           _loc5_ = true;
                           _loc6_ = true;
                           (_loc7_ = new SupportElevator()).worldX = _loc2_.x + cameraX;
                           _loc7_.worldY = _loc2_.y + cameraY;
                           _loc7_.x = _loc2_.x;
                           _loc7_.y = _loc2_.y;
                           _loc7_.name = _loc2_.name;
                           _loc7_.floorList = new Array();
                           _loc7_.elevatorList = new Array();
                           _loc7_.tLevel = 1;
                           (_loc9_ = new ElevatorBody()).y = -84;
                           _loc7_.addChild(_loc9_);
                           _loc7_.addEventListener(MouseEvent.CLICK,TenantClicking);
                           tenantParent.addChild(_loc7_);
                           elevatorList.push(_loc7_);
                           otherOutcome += _loc2_.price;
                        }
                        else
                        {
                           _loc5_ = true;
                           (_loc7_ = new SupportRestroom()).worldX = _loc2_.x + cameraX;
                           _loc7_.worldY = _loc2_.y + cameraY;
                           _loc7_.x = _loc2_.x;
                           _loc7_.y = _loc2_.y;
                           _loc7_.name = _loc2_.name;
                           _loc7_.ground = bottom;
                           _loc7_.tLevel = 1;
                           _loc7_.addEventListener(MouseEvent.CLICK,TenantClicking);
                           _loc7_.ground.toiletList.push(_loc7_);
                           tenantParent.addChild(_loc7_);
                           restroomList.push(_loc7_);
                           updatePopularity(_loc7_);
                           otherOutcome += _loc2_.price;
                        }
                        if(_loc5_)
                        {
                           _loc10_ = 0;
                           while(_loc10_ < emptyParent.numChildren)
                           {
                              if((_loc11_ = emptyParent.getChildAt(_loc10_)).hitTestObject(_loc7_))
                              {
                                 emptyParent.removeChild(_loc11_);
                                 _loc10_--;
                              }
                              _loc10_++;
                           }
                           _loc10_ = 0;
                           while(_loc10_ < pillarParent.numChildren)
                           {
                              if((_loc12_ = pillarParent.getChildAt(_loc10_)) is Pillar && Boolean(_loc12_.hitTestObject(_loc7_)))
                              {
                                 pillarParent.removeChild(_loc12_);
                                 _loc10_--;
                              }
                              _loc10_++;
                           }
                           if(!param1.shiftKey || _loc2_ is BuildHall)
                           {
                              buildParent.removeChild(_loc2_);
                              _loc10_ = 0;
                              while(_loc10_ < userinterface.buttonList.length)
                              {
                                 userinterface.buttonList[_loc10_].btnDefault.tog = false;
                                 _loc10_++;
                              }
                              userinterface.disableAllSector();
                           }
                           if(_loc6_)
                           {
                              createPillar(_loc7_.worldX - 12,_loc7_.worldY - 86);
                              createPillar(_loc7_.worldX + _loc7_.width - _loc7_.width % 12,_loc7_.worldY - 86);
                              createFloor(_loc7_.worldX - 12,_loc7_.worldY - 96,_loc7_.width - _loc7_.width % 12 + 24);
                           }
                           createPillar(_loc7_.worldX - 12,_loc7_.worldY - 2);
                           createPillar(_loc7_.worldX + _loc7_.width - _loc7_.width % 12,_loc7_.worldY - 2);
                           createFloor(_loc7_.worldX - 12,_loc7_.worldY - 12,_loc7_.width - _loc7_.width % 12 + 24);
                        }
                        if(_loc6_)
                        {
                           _loc10_ = 0;
                           while(_loc10_ < _loc7_.numChildren)
                           {
                              if((_loc9_ = _loc7_.getChildAt(_loc10_)) is ElevatorBody)
                              {
                                 _loc13_ = 0;
                                 while(_loc13_ < floorList.length)
                                 {
                                    if((_loc14_ = floorList[_loc13_]) is Floor)
                                    {
                                       if(Boolean(_loc9_.hitTestObject(_loc14_)) && _loc7_.y + _loc9_.y < _loc14_.y)
                                       {
                                          _loc7_.elevatorList.push(_loc9_);
                                          _loc7_.floorList.push(_loc14_);
                                       }
                                    }
                                    else if(Boolean(_loc9_.hitTestObject(_loc14_)) && _loc7_.y + _loc9_.y <= _loc14_.y - _loc14_.height)
                                    {
                                       _loc7_.elevatorList.push(_loc9_);
                                       _loc7_.floorList.push(_loc14_);
                                    }
                                    _loc13_++;
                                 }
                              }
                              _loc10_++;
                           }
                        }
                     }
                     else
                     {
                        _loc8_ = userinterface.btnEmployeeArr.indexOf(_loc2_.stat);
                        (_loc15_ = new employeeArr[_loc8_]()).worldX = _loc2_.x + cameraX;
                        _loc15_.worldY = _loc2_.y + cameraY;
                        _loc15_.x = _loc15_.worldX - cameraX;
                        _loc15_.y = _loc15_.worldY - cameraY;
                        _loc15_.floorPos = bottom;
                        _loc15_.homePos = Math.floor(Math.random() * 2) * MAX_WIDTH;
                        crewList.push(_loc15_);
                        visitorParent.addChild(_loc15_);
                        _loc15_.addEventListener(MouseEvent.CLICK,EmployeeOnClick);
                        _loc15_.addEventListener(MouseEvent.MOUSE_OVER,VisitorOnOver);
                        _loc15_.addEventListener(MouseEvent.MOUSE_OUT,VisitorOnOut);
                        if(_loc2_ is HireCleaningService)
                        {
                           cleaningServiceOutcome += _loc2_.price;
                        }
                        else if(_loc2_ is HireTechnician)
                        {
                           technicianOutcome += _loc2_.price;
                        }
                        else if(_loc2_ is HireSecurity)
                        {
                           securityOutcome += _loc2_.price;
                        }
                        if(!param1.shiftKey)
                        {
                           buildParent.removeChild(_loc2_);
                           _loc10_ = 0;
                           while(_loc10_ < userinterface.buttonList.length)
                           {
                              userinterface.buttonList[_loc10_].btnDefault.tog = false;
                              _loc10_++;
                           }
                           userinterface.disableAllSector();
                        }
                        if(param1.ctrlKey)
                        {
                           _loc15_.shiftFloor = floorList.indexOf(_loc15_.floorPos);
                        }
                        else
                        {
                           _loc15_.shiftFloor = -1;
                        }
                        if(userinterface.employeeList.visible)
                        {
                           userinterface.employeeList.setCrewList();
                        }
                     }
                     if(_loc3_)
                     {
                        addCashUpdate(_loc2_.price,_loc2_.x + cameraX,_loc2_.y + cameraY,false);
                     }
                     else if(_loc6_)
                     {
                        addCashUpdate(_loc2_.price,_loc2_.x + cameraX + _loc2_.width / 2,_loc2_.y + cameraY,false);
                        if(!expandElevatorTutor)
                        {
                           addEventListener(Event.ENTER_FRAME,ExpandElevatorTutor);
                        }
                     }
                     else
                     {
                        addCashUpdate(_loc2_.price,_loc2_.x + cameraX + _loc2_.width / 2,_loc2_.y + cameraY + _loc2_.height / 2,false);
                     }
                     userinterface.updateSector();
                  }
                  else
                  {
                     addNotification("Not enough cash");
                  }
               }
            }
         }
      }
      
      public function loadTenant(param1:SharedObject) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         _loc2_ = 0;
         while(_loc2_ < param1.data.tenantName.length)
         {
            _loc3_ = userinterface.btnArr.indexOf(param1.data.tenantName[_loc2_]);
            if(_loc3_ >= 0)
            {
               (_loc4_ = new tenantArr[_loc3_]()).worldX = param1.data.tenantWorldX[_loc2_];
               _loc4_.worldY = param1.data.tenantWorldY[_loc2_];
               _loc4_.x = _loc4_.worldX - cameraX;
               _loc4_.y = _loc4_.worldY - cameraY;
               _loc4_.name = param1.data.tenantName[_loc2_];
               _loc4_.ground = floorList[param1.data.tenantGround[_loc2_]];
               _loc4_.addEventListener(MouseEvent.CLICK,TenantClicking);
               tenantParent.addChild(_loc4_);
               tenantList.push(_loc4_);
               _loc4_.addEventListener(Event.ENTER_FRAME,FloorDetection);
               _loc4_.tLevel = param1.data.tenantLevel[_loc2_];
               _loc4_.brokenLevel = param1.data.tenantBrokenLevel[_loc2_];
               _loc4_.income = param1.data.tenantIncome[_loc2_];
               _loc4_.outcome = param1.data.tenantOutcome[_loc2_];
               _loc4_.visitorCome = 0;
            }
            else if(param1.data.tenantName[_loc2_] == "Hall")
            {
               (_loc4_ = new TenantHall()).worldX = param1.data.tenantWorldX[_loc2_];
               _loc4_.worldY = param1.data.tenantWorldY[_loc2_];
               _loc4_.x = _loc4_.worldX - cameraX;
               _loc4_.y = _loc4_.worldY - cameraY;
               _loc4_.name = param1.data.tenantName[_loc2_];
               _loc4_.ground = floorList[param1.data.tenantGround[_loc2_]];
               _loc4_.addEventListener(MouseEvent.CLICK,TenantClicking);
               tenantParent.addChild(_loc4_);
               tenantList.push(_loc4_);
               _loc4_.addEventListener(Event.ENTER_FRAME,FloorDetection);
               _loc4_.tLevel = param1.data.tenantLevel[_loc2_];
               _loc4_.income = param1.data.tenantIncome[_loc2_];
               _loc4_.outcome = param1.data.tenantOutcome[_loc2_];
               _loc4_.visitorCome = 0;
               hall = _loc4_;
            }
            _loc2_++;
         }
      }
      
      public function savingFloor() : void
      {
         var _loc1_:* = undefined;
         AutoSaveGame.data.floorWorldX = new Array();
         AutoSaveGame.data.floorWorldY = new Array();
         AutoSaveGame.data.floorWidth = new Array();
         _loc1_ = 0;
         while(_loc1_ < floorList.length)
         {
            if(floorList[_loc1_] is Floor)
            {
               AutoSaveGame.data.floorWorldX.push(floorList[_loc1_].worldX);
               AutoSaveGame.data.floorWorldY.push(floorList[_loc1_].worldY);
               AutoSaveGame.data.floorWidth.push(floorList[_loc1_].width);
            }
            _loc1_++;
         }
      }
      
      public function loading(param1:ProgressEvent) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         _loc2_ = Number(param1.bytesLoaded);
         _loc3_ = Number(param1.bytesTotal);
         _loc4_ = _loc2_ / _loc3_ * 100;
         preloaderIcon.done = _loc4_;
      }
      
      public function MedalHunter(param1:Event) : void
      {
         if(banditCaptured >= 10)
         {
            API.unlockMedal("Hunter");
            removeEventListener(Event.ENTER_FRAME,MedalHunter);
         }
      }
      
      public function loadEmptySpace(param1:SharedObject) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc2_ = 0;
         while(_loc2_ < param1.data.emptyWorldX.length)
         {
            _loc3_ = new TenantEmptySpace();
            _loc3_.worldX = param1.data.emptyWorldX[_loc2_];
            _loc3_.worldY = param1.data.emptyWorldY[_loc2_];
            emptyParent.addChild(_loc3_);
            _loc2_++;
         }
      }
      
      public function VisitorOnOver(param1:MouseEvent) : void
      {
         visitorOver = true;
      }
      
      public function BrokenProgress(param1:Event) : void
      {
         var sp:* = undefined;
         var i:* = undefined;
         var temp:* = undefined;
         var rndBroken:* = undefined;
         var j:* = undefined;
         var brokenAgain:* = undefined;
         var event:Event = param1;
         sp = 0;
         while(sp < gameSpeed)
         {
            if(brokenDelay > 0)
            {
               --brokenDelay;
            }
            else
            {
               i = 0;
               for(; i < tenantList.length; i++)
               {
                  try
                  {
                     temp = tenantList[i];
                     if(!(temp is TenantHall) && !temp.isClose)
                     {
                        if(temp.brokenLevel <= 100)
                        {
                           rndBroken = Math.random() * 15;
                           if(rndBroken > 7)
                           {
                              temp.brokenLevel += rndBroken / 100 / temp.tLevel;
                              j = 0;
                              while(j < temp.visitorList.length)
                              {
                                 brokenAgain = Math.random() * 5 / 100;
                                 temp.brokenLevel += brokenAgain / temp.tLevel;
                                 j++;
                              }
                           }
                        }
                        if(temp.brokenLevel < 80)
                        {
                           temp.isBroken = false;
                        }
                        else
                        {
                           temp.isBroken = true;
                        }
                     }
                  }
                  catch(e:Error)
                  {
                  }
               }
               brokenDelay = 6;
            }
            sp++;
         }
      }
      
      public function VisitorOnOut(param1:MouseEvent) : void
      {
         visitorOver = false;
      }
      
      public function ChangeCity(param1:MouseEvent) : void
      {
         userinterface.btnNextCity.visible = false;
         userinterface.btnNextCity.removeEventListener(MouseEvent.CLICK,ChangeCity);
         userinterface.nextTownWarning.visible = true;
         userinterface.nextTownWarning.btnYes.addEventListener(MouseEvent.CLICK,GoToNextCity);
         userinterface.nextTownWarning.btnNo.addEventListener(MouseEvent.CLICK,CancelToNextCity);
         lastSpeed = gameSpeed;
         gameSpeed = 0;
      }
      
      public function addCashUpdate(param1:Number, param2:Number, param3:Number, param4:Boolean, param5:Number = 0, param6:Boolean = false) : void
      {
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         if(param4)
         {
            recive += param1 + param5;
            (_loc8_ = new UI_CashUpdateRecive()).clip.cashList.text = "+$" + MoneySplit(param1);
            if(param5 > 0)
            {
               _loc8_.clip.cashList.text += "+$" + MoneySplit(param5);
            }
            _loc8_.worldX = param2;
            _loc8_.worldY = param3;
            _loc8_.staticPosition = param6;
            if(param6)
            {
               addChild(_loc8_);
            }
            else
            {
               flyingTextParent.addChild(_loc8_);
            }
         }
         else
         {
            purchase += param1;
            (_loc8_ = new UI_CashUpdatePurchase()).clip.cashList.text = "-$" + MoneySplit(param1);
            _loc8_.worldX = param2;
            _loc8_.worldY = param3;
            flyingTextParent.addChild(_loc8_);
         }
         (_loc7_ = new SE_Coin()).play(0,0,seTransform);
      }
      
      internal function __setProp___id0__Scene1_Main_1() : *
      {
         try
         {
            __id0_["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         __id0_.movieId = "19213:ZWLMaWws";
         __id0_.debugMode = true;
         __id0_.encryptionKey = "xQugU2k6lC6eMvEJOqT4SyAYJRTwtJbP";
         __id0_.movieVersion = "1";
         __id0_.showConnectingPopup = true;
         __id0_.useErrorPopup = true;
         __id0_.useMedalPopup = true;
         __id0_.useFakeSession = true;
         try
         {
            __id0_["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      public function BGMMenuLoop(param1:Event) : void
      {
         mainMenuBGMChannel = mainMenuBGM.play(0,0,bgmTransform);
         mainMenuBGMChannel.addEventListener(Event.SOUND_COMPLETE,BGMMenuLoop);
      }
      
      public function updateBudget() : void
      {
         var tList:* = undefined;
         var iList:* = undefined;
         var oList:* = undefined;
         var vList:* = undefined;
         var i:* = undefined;
         var discription:* = undefined;
         var incomeList:* = undefined;
         var outcomeList:* = undefined;
         var visitorComeList:* = undefined;
         var gainList:* = undefined;
         var gList:* = undefined;
         var totalEarning:* = undefined;
         var difference:* = undefined;
         var tIndex:* = undefined;
         var tString:* = undefined;
         var j:* = undefined;
         var temp:* = undefined;
         var gainWord:* = undefined;
         tList = new Array();
         iList = new Array();
         oList = new Array();
         vList = new Array();
         i = 0;
         while(i < tenantList.length)
         {
            if(tenantList[i] is TenantHall)
            {
               tList.push("Hall");
               iList.push(tenantList[i].income);
               oList.push(tenantList[i].outcome);
               vList.push(tenantList[i].visitorCome);
            }
            else
            {
               tIndex = userinterface.btnArr.indexOf(tenantList[i].name);
               tString = TENANT_TEXT[tIndex];
               tList.push(tString);
               iList.push(tenantList[i].income);
               oList.push(tenantList[i].outcome);
               vList.push(tenantList[i].visitorCome);
            }
            tenantList[i].income = 0;
            tenantList[i].outcome = 0;
            tenantList[i].visitorCome = 0;
            i++;
         }
         i = 0;
         while(i < tList.length)
         {
            j = i + 1;
            while(j < tList.length)
            {
               if(tList[i] > tList[j])
               {
                  temp = tList[i];
                  tList[i] = tList[j];
                  tList[j] = temp;
                  temp = iList[i];
                  iList[i] = iList[j];
                  iList[j] = temp;
                  temp = oList[i];
                  oList[i] = oList[j];
                  oList[j] = temp;
                  temp = vList[i];
                  vList[i] = vList[j];
                  vList[j] = temp;
               }
               j++;
            }
            i++;
         }
         tList.push("C.Service");
         iList.push(0);
         oList.push(cleaningServiceOutcome);
         vList.push("-");
         tList.push("Technician");
         iList.push(0);
         oList.push(technicianOutcome);
         vList.push("-");
         tList.push("Security");
         iList.push(0);
         oList.push(securityOutcome);
         vList.push("-");
         tList.push("M.Reward");
         iList.push(missionReward);
         oList.push(0);
         vList.push("-");
         tList.push("Misc");
         iList.push(otherIncome);
         oList.push(otherOutcome);
         vList.push("-");
         cleaningServiceOutcome = 0;
         technicianOutcome = 0;
         securityOutcome = 0;
         missionReward = 0;
         otherIncome = 0;
         otherOutcome = 0;
         discription = "";
         incomeList = "";
         outcomeList = "";
         visitorComeList = "";
         gainList = "";
         totalEarning = 0;
         i = 0;
         while(i < tList.length)
         {
            gList = iList[i] - oList[i];
            totalEarning += gList;
            gainWord = "$" + MoneySplit(Math.abs(gList));
            if(gList < 0)
            {
               gainWord = "<font color=\'#FF0000\'>-" + gainWord + "</font>";
            }
            else
            {
               gainWord = "<font color=\'#007A03\'>+" + gainWord + "</font>";
            }
            if(i == 0)
            {
               discription = tList[i];
               visitorComeList = vList[i];
               if(iList[i] != 0)
               {
                  incomeList = "$" + MoneySplit(iList[i]);
               }
               else
               {
                  incomeList = "-";
               }
               if(oList[i] != 0)
               {
                  outcomeList = "$" + MoneySplit(oList[i]);
               }
               else
               {
                  outcomeList = "-";
               }
               if(gList != 0)
               {
                  gainList = gainWord;
               }
               else
               {
                  gainList = "-";
               }
            }
            else
            {
               discription += "\n" + tList[i];
               visitorComeList += "\n" + vList[i];
               if(iList[i] != 0)
               {
                  incomeList += "\n$" + MoneySplit(iList[i]);
               }
               else
               {
                  incomeList += "\n-";
               }
               if(oList[i] != 0)
               {
                  outcomeList += "\n$" + MoneySplit(oList[i]);
               }
               else
               {
                  outcomeList += "\n-";
               }
               if(gList != 0)
               {
                  gainList += "\n" + gainWord;
               }
               else
               {
                  gainList += "\n-";
               }
            }
            i++;
         }
         budget.discription.textList.text = discription;
         budget.incomeList.textList.text = incomeList;
         budget.outcomeList.textList.text = outcomeList;
         budget.visitorComeList.textList.text = visitorComeList;
         budget.gainList.textList.htmlText = gainList;
         if(totalEarning < 0)
         {
            budget.totalEarning.htmlText = "<font color=\'#FF0000\'>-$" + MoneySplit(Math.abs(totalEarning)) + "</font>";
         }
         else if(totalEarning > 0)
         {
            budget.totalEarning.htmlText = "<font color=\'#007A03\'>+$" + MoneySplit(Math.abs(totalEarning)) + "</font>";
         }
         else
         {
            budget.totalEarning.htmlText = "+$" + MoneySplit(Math.abs(totalEarning));
         }
         difference = totalEarning - lastEarning;
         if(difference < 0)
         {
            budget.difference.htmlText = "<font color=\'#FF0000\'>Your profit decrease $" + MoneySplit(Math.abs(difference)) + " from last day</font>";
         }
         else if(difference > 0)
         {
            budget.difference.htmlText = "<font color=\'#007A03\'>Your profit increase $" + MoneySplit(Math.abs(difference)) + " from last day</font>";
         }
         else
         {
            budget.difference.htmlText = "Earning rate has no change from last day";
         }
         lastEarning = totalEarning;
         budget.checkHeight();
         i = 0;
         while(i < userinterface.buttonList.length)
         {
            userinterface.buttonList[i].btnDefault.tog = false;
            i++;
         }
         if(!budget.appear)
         {
            with(userinterface)
            {
               
               disableAllSector();
               disableBuilding();
            }
            budget.statisticTimer = 240;
         }
      }
      
      public function MedalMillionaire(param1:Event) : void
      {
         if(cash - purchase + recive >= 2000000)
         {
            API.unlockMedal("Millionaire");
            removeEventListener(Event.ENTER_FRAME,MedalMillionaire);
         }
      }
      
      public function GamesFreeURL(param1:MouseEvent) : void
      {
         var _loc2_:URLRequest = null;
         _loc2_ = new URLRequest("http://www.gamesfree.com");
         navigateToURL(_loc2_,"_blank");
      }
      
      public function DayTimeChange(param1:Event) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         stage.focus = stage;
         this.userinterface.dayTime = dayTime;
         this.userinterface.dayMinute = dayMinute;
         if(gameSpeed > 0)
         {
            if(gameDelay > 3 + gameSpeed)
            {
               gameDelay -= gameSpeed;
            }
            else
            {
               gameDelay = 9;
               ++dayMinute;
               if(dayMinute >= 60)
               {
                  ++dayTime;
                  dayMinute -= 60;
                  if(dayTime >= 24)
                  {
                     dayTime = 0;
                  }
               }
               if(dayTime >= 10 && dayTime < 21)
               {
                  if(dayTime >= 12 && dayTime < 3)
                  {
                     mass = 3;
                  }
                  else if(dayTime >= 18 && dayTime < 19)
                  {
                     mass = 4;
                  }
                  else if(dayTime >= 19 && dayTime < 21)
                  {
                     mass = 2;
                  }
                  else
                  {
                     mass = 1;
                  }
               }
               else
               {
                  mass = 0;
               }
            }
         }
         else
         {
            gameDelay = 0;
         }
         if(dayTime >= 19 || dayTime < 4)
         {
            night.alpha = 1;
         }
         else if(dayTime >= 18)
         {
            night.alpha = 0.5 + dayMinute / 120;
         }
         else if(dayTime >= 17)
         {
            night.alpha = dayMinute / 120;
         }
         else if(dayTime < 5)
         {
            night.alpha = 1 - dayMinute / 120;
         }
         else if(dayTime < 6)
         {
            night.alpha = 0.5 - dayMinute / 120;
         }
         else
         {
            night.alpha = 0;
         }
         if(dayTime >= 16 && dayTime < 19)
         {
            sunset.alpha = 1;
         }
         else if(dayTime >= 15)
         {
            sunset.alpha = dayMinute / 60;
         }
         else if(dayTime >= 18)
         {
            sunset.alpha = 1 - dayMinute / 60;
         }
         else
         {
            sunset.alpha = 0;
         }
         if(dayTime == 0 && lastDayTime != dayTime)
         {
            ++dayPass;
            payAllEmployee();
            updateBudget();
            lastNumberUpset = numberUpset;
            numberUpset = 0;
            popularityModifier += nextDayPopularity;
            nextDayPopularity = 0;
            if(nowEvent >= 0)
            {
               --eventTime;
               if(eventTime <= 0)
               {
                  nowEvent = -1;
               }
            }
            else
            {
               nowEvent = bookedEvent;
               bookedEvent = -1;
            }
         }
         userinterface.dayPass.text = "DAY " + dayPass;
         if(!tutorialMode)
         {
            if((dayTime == 9 || dayTime == 12 || dayTime == 15 || dayTime == 18 || dayTime == 21 || dayTime == 3) && lastDayTime != dayTime)
            {
               _loc2_ = Math.floor(Math.random() * TipsList.length);
               addTips("Tips:\n" + TipsList[_loc2_]);
               if(tipsHistory.indexOf(TipsList[_loc2_]) < 0)
               {
                  tipsHistory.unshift(TipsList[_loc2_]);
                  userinterface.tipsHistory.updateText(tipsHistory);
                  if(!userinterface.tipsHistory.visible)
                  {
                     _loc3_ = new GlowFilter(16746496);
                     userinterface.btnMailBox.filters = [_loc3_];
                     if(userinterface.currentLabel == "reveal")
                     {
                        userinterface.tipsHistory.checkHeight();
                     }
                  }
               }
            }
            if(dayTime == 9 && lastDayTime != dayTime)
            {
               banditCaptured = 0;
               autoSaveData();
            }
            lastDayTime = dayTime;
         }
      }
      
      public function savingTenant() : void
      {
         var _loc1_:* = undefined;
         AutoSaveGame.data.tenantName = new Array();
         AutoSaveGame.data.tenantWorldX = new Array();
         AutoSaveGame.data.tenantWorldY = new Array();
         AutoSaveGame.data.tenantBrokenLevel = new Array();
         AutoSaveGame.data.tenantLevel = new Array();
         AutoSaveGame.data.tenantGround = new Array();
         AutoSaveGame.data.tenantIncome = new Array();
         AutoSaveGame.data.tenantOutcome = new Array();
         _loc1_ = 0;
         while(_loc1_ < tenantList.length)
         {
            AutoSaveGame.data.tenantName.push(tenantList[_loc1_].name);
            AutoSaveGame.data.tenantWorldX.push(tenantList[_loc1_].worldX);
            AutoSaveGame.data.tenantWorldY.push(tenantList[_loc1_].worldY);
            AutoSaveGame.data.tenantBrokenLevel.push(tenantList[_loc1_].brokenLevel);
            AutoSaveGame.data.tenantLevel.push(tenantList[_loc1_].tLevel);
            AutoSaveGame.data.tenantGround.push(floorList.indexOf(tenantList[_loc1_].ground));
            AutoSaveGame.data.tenantIncome.push(tenantList[_loc1_].income);
            AutoSaveGame.data.tenantOutcome.push(tenantList[_loc1_].outcome);
            _loc1_++;
         }
      }
      
      public function addNewAchivement(param1:Number) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         if(getChildByName("Achivement") == null)
         {
            _loc2_ = new SE_Achievement();
            _loc2_.play(0,0,seTransform);
            _loc3_ = new AchivementNotification();
            _loc3_.x = achivementPosition.x;
            _loc3_.y = achivementPosition.y;
            _loc3_.name = "Achivement";
            _loc3_.body.iconPosition = param1 + 1;
            addChild(_loc3_);
            Achivement.data.trophyList[param1] = true;
            if((_loc4_ = getChildByName("userinterface")) != null)
            {
               if((_loc5_ = _loc4_.getChildByName("AchievementScreen")) != null)
               {
                  _loc5_.UpdateAchievement(param1);
               }
            }
         }
      }
      
      public function autoSaveData() : void
      {
         var _loc1_:* = undefined;
         AutoSaveGame.data.playerName = playerName;
         savingPillar();
         savingEmptySpace();
         savingFloor();
         savingTenant();
         savingRestroom();
         savingElevator();
         savingEmployee();
         savingTrash();
         AutoSaveGame.data.discription = budget.discription.textList.htmlText;
         AutoSaveGame.data.visitorComeList = budget.visitorComeList.textList.htmlText;
         AutoSaveGame.data.incomeList = budget.incomeList.textList.htmlText;
         AutoSaveGame.data.outcomeList = budget.outcomeList.textList.htmlText;
         AutoSaveGame.data.gainList = budget.gainList.textList.htmlText;
         AutoSaveGame.data.totalEarning = budget.totalEarning.htmlText;
         AutoSaveGame.data.difference = budget.difference.htmlText;
         AutoSaveGame.data.lastEarning = lastEarning;
         AutoSaveGame.data.dayPass = dayPass;
         AutoSaveGame.data.currentCash = cash - purchase + recive;
         AutoSaveGame.data.popularity = popularity;
         AutoSaveGame.data.popularityModifier = popularityModifier;
         AutoSaveGame.data.nextDayPopularity = nextDayPopularity;
         AutoSaveGame.data.otherIncome = otherIncome;
         AutoSaveGame.data.otherOutcome = otherOutcome;
         AutoSaveGame.data.cleaningServiceOutcome = cleaningServiceOutcome;
         AutoSaveGame.data.technicianOutcome = technicianOutcome;
         AutoSaveGame.data.securityOutcome = securityOutcome;
         AutoSaveGame.data.nowEvent = nowEvent;
         AutoSaveGame.data.bookedEvent = bookedEvent;
         AutoSaveGame.data.eventTime = eventTime;
         AutoSaveGame.data.city = city;
         AutoSaveGame.data.missionActive = missionActive;
         AutoSaveGame.data.expandElevatorTutor = expandElevatorTutor;
         AutoSaveGame.data.securityTutor = securityTutor;
         AutoSaveGame.data.canGameOver = canGameOver;
         AutoSaveGame.flush();
         _loc1_ = new UI_GameSavedAnimation();
         _loc1_.x = userinterface.autoSavePosition.x;
         _loc1_.y = userinterface.autoSavePosition.y;
         addChild(_loc1_);
      }
      
      public function KeyUpEvent(param1:KeyboardEvent) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = param1.keyCode;
         if(_loc2_ == 65)
         {
            scrollLeft1 = false;
         }
         if(_loc2_ == Keyboard.LEFT)
         {
            scrollLeft2 = false;
         }
         if(_loc2_ == 68)
         {
            scrollRight1 = false;
         }
         if(_loc2_ == Keyboard.RIGHT)
         {
            scrollRight2 = false;
         }
         if(_loc2_ == 87)
         {
            scrollUp1 = false;
         }
         if(_loc2_ == Keyboard.UP)
         {
            scrollUp2 = false;
         }
         if(_loc2_ == 83)
         {
            scrollDown1 = false;
         }
         if(_loc2_ == Keyboard.DOWN)
         {
            scrollDown2 = false;
         }
         if(_loc2_ == Keyboard.SHIFT)
         {
            shiftKey = false;
         }
         if(_loc2_ == Keyboard.ESCAPE)
         {
            userinterface.disableAllSector();
            userinterface.disableBuilding();
         }
      }
      
      public function payAllEmployee() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         _loc1_ = 0;
         while(_loc1_ < crewList.length)
         {
            _loc2_ = crewList[_loc1_];
            if(_loc2_ is CrewCleaningServicelv1 || _loc2_ is CrewCleaningServicelv2 || _loc2_ is CrewCleaningServicelv3)
            {
               cleaningServiceOutcome += _loc2_.salary;
            }
            else if(_loc2_ is CrewTechnicianlv1 || _loc2_ is CrewTechnicianlv2 || _loc2_ is CrewTechnicianlv3)
            {
               technicianOutcome += _loc2_.salary;
            }
            else if(_loc2_ is CrewSecuritylv1 || _loc2_ is CrewSecuritylv2 || _loc2_ is CrewSecuritylv3)
            {
               securityOutcome += _loc2_.salary;
            }
            addCashUpdate(_loc2_.salary,_loc2_.worldX,_loc2_.worldY - _loc2_.height,false);
            _loc1_++;
         }
         if(cash - purchase + recive < 0)
         {
            if(!canGameOver)
            {
               addNotification("Your cash is run out. Do not let your cash below zero at the next day");
               canGameOver = true;
            }
            else
            {
               gameSpeed = 0;
               userinterface.deactiveAllButton();
               addEventListener(MouseEvent.CLICK,GameOverSkip);
               addEventListener(KeyboardEvent.KEY_UP,GameOverSkip);
            }
         }
         else
         {
            canGameOver = false;
         }
      }
      
      public function addTutorialNotification(param1:String, param2:Boolean = false, param3:Point = null) : void
      {
         var _loc4_:* = undefined;
         (_loc4_ = new TutorialNotification()).noteText.htmlText = param1;
         if(param3 == null)
         {
            _loc4_.x = stage.stageWidth / 2;
            _loc4_.y = stage.stageHeight / 2;
         }
         else
         {
            _loc4_.x = param3.x;
            _loc4_.y = param3.y;
         }
         _loc4_.hasNextButton = param2;
         tutorialParent.addChild(_loc4_);
      }
      
      public function loadEmployee(param1:SharedObject) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         _loc2_ = 0;
         while(_loc2_ < param1.data.employeeName.length)
         {
            if(param1.data.employeeName[_loc2_] == "CleaningService")
            {
               _loc4_ = new CrewCleaningServicelv1();
            }
            else if(param1.data.employeeName[_loc2_] == "Technician")
            {
               _loc4_ = new CrewTechnicianlv1();
            }
            else if(param1.data.employeeName[_loc2_] == "Security")
            {
               _loc4_ = new CrewSecuritylv1();
            }
            _loc4_.worldX = param1.data.employeeWorldX[_loc2_];
            _loc4_.worldY = param1.data.employeeWorldY[_loc2_];
            _loc4_.shiftFloor = param1.data.employeeShiftFloor[_loc2_];
            _loc4_.floorPos = floorList[param1.data.employeeFloorPos[_loc2_]];
            _loc4_.homePos = param1.data.employeeHome[_loc2_];
            _loc4_.goHome = param1.data.employeeGoHome[_loc2_];
            _loc3_ = 0;
            while(_loc3_ < param1.data.employeeLevel[_loc2_] - 1)
            {
               (_loc4_ = new _loc5_ = _loc4_.nextUpgrade()).ancestor = _loc5_;
               _loc3_++;
            }
            _loc4_.addEventListener(MouseEvent.CLICK,EmployeeOnClick);
            _loc4_.addEventListener(MouseEvent.MOUSE_OVER,VisitorOnOver);
            _loc4_.addEventListener(MouseEvent.MOUSE_OUT,VisitorOnOut);
            visitorParent.addChild(_loc4_);
            crewList.push(_loc4_);
            _loc2_++;
         }
      }
      
      public function clearArrow() : void
      {
         var _loc1_:* = undefined;
         while(tutorialArrowParent.numChildren > 0)
         {
            _loc1_ = tutorialArrowParent.getChildAt(0);
            tutorialArrowParent.removeChild(_loc1_);
         }
      }
      
      public function BanditTutorial(param1:Event) : void
      {
         if(!securityTutor && firstBandit != null)
         {
            if(securityStep == 0)
            {
               if(firstBandit.worldX >= 200 && firstBandit.worldX <= MAX_WIDTH - 200)
               {
                  userinterface.deactiveAllButton();
                  lastSpeed = gameSpeed;
                  gameSpeed = 0;
                  cameraX = firstBandit.worldX - CAMERA_WIDTH / 2;
                  cameraY = firstBandit.worldY - CAMERA_HEIGHT + 120;
                  addTutorialNotification("Look at the bandit, he\'s going to\n<font color=\'#FF0000\'>rob your mall and take your money.</font>\nThey often hang around at night.",true);
                  ++securityStep;
               }
            }
            else if(securityStep == 1)
            {
               if(tutorialParent.numChildren > 0)
               {
                  gameSpeed = 0;
               }
               else
               {
                  addTutorialNotification("You have to <font color=\'#007A03\'>hire security</font> to catch those bandits\nbut only when they stay visible.",true);
                  ++securityStep;
               }
            }
            else if(tutorialParent.numChildren > 0)
            {
               gameSpeed = 0;
            }
            else
            {
               gameSpeed = lastSpeed;
               securityTutor = true;
               userinterface.activeAllButton();
               removeEventListener(Event.ENTER_FRAME,BanditTutorial);
            }
         }
      }
      
      public function GoToNextCity(param1:MouseEvent) : void
      {
         userinterface.nextTownWarning.visible = false;
         userinterface.nextTownWarning.btnYes.removeEventListener(MouseEvent.CLICK,GoToNextCity);
         userinterface.nextTownWarning.btnNo.removeEventListener(MouseEvent.CLICK,CancelToNextCity);
         cleanAllObject();
         if(city == 0)
         {
            bgm = new BGMTransition();
            bgm.play(0,0,bgmTransform);
            gotoAndPlay("Transition Tokyo");
         }
         else if(city == 1)
         {
            bgm = new BGMTransition();
            bgm.play(0,0,bgmTransform);
            gotoAndPlay("Transition New York");
         }
      }
      
      public function MedalStarter(param1:Event) : void
      {
         if(tenantList.length > 0)
         {
            API.unlockMedal("Starter");
            removeEventListener(Event.ENTER_FRAME,MedalStarter);
         }
      }
      
      public function loadRestroom(param1:SharedObject) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc2_ = 0;
         while(_loc2_ < param1.data.restroomName.length)
         {
            _loc3_ = new SupportRestroom();
            _loc3_.worldX = param1.data.restroomWorldX[_loc2_];
            _loc3_.worldY = param1.data.restroomWorldY[_loc2_];
            _loc3_.x = _loc3_.worldX - cameraX;
            _loc3_.y = _loc3_.worldY - cameraY;
            _loc3_.name = param1.data.restroomName[_loc2_];
            _loc3_.ground = floorList[param1.data.restroomGround[_loc2_]];
            _loc3_.addEventListener(MouseEvent.CLICK,TenantClicking);
            tenantParent.addChild(_loc3_);
            restroomList.push(_loc3_);
            _loc3_.tLevel = param1.data.restroomLevel[_loc2_];
            _loc2_++;
         }
      }
      
      public function DrawObject(param1:MovieClip) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc2_ = 0;
         while(_loc2_ < param1.numChildren)
         {
            _loc3_ = param1.getChildAt(_loc2_);
            _loc3_.x = _loc3_.worldX - cameraX;
            _loc3_.y = _loc3_.worldY - cameraY;
            _loc3_.visible = drawArea.hitTestObject(_loc3_) && _loc3_.alpha > 0;
            _loc2_++;
         }
      }
      
      public function LoadFromAutoSave() : void
      {
         lastDayTime = 9;
         tutorialMode = false;
         if(AutoSaveGame.data.playerName)
         {
            playerName = AutoSaveGame.data.playerName;
            loadPillar(AutoSaveGame);
            loadEmptySpace(AutoSaveGame);
            loadFloor(AutoSaveGame);
            loadTenant(AutoSaveGame);
            loadRestroom(AutoSaveGame);
            loadElevator(AutoSaveGame);
            loadEmployee(AutoSaveGame);
            loadTrash(AutoSaveGame);
            budget.discription.textList.htmlText = AutoSaveGame.data.discription;
            budget.visitorComeList.textList.htmlText = AutoSaveGame.data.visitorComeList;
            budget.incomeList.textList.htmlText = AutoSaveGame.data.incomeList;
            budget.outcomeList.textList.htmlText = AutoSaveGame.data.outcomeList;
            budget.gainList.textList.htmlText = AutoSaveGame.data.gainList;
            budget.totalEarning.htmlText = AutoSaveGame.data.totalEarning;
            budget.difference.htmlText = AutoSaveGame.data.difference;
            lastEarning = AutoSaveGame.data.lastEarning;
            budget.checkHeight();
            dayPass = AutoSaveGame.data.dayPass;
            cash = AutoSaveGame.data.currentCash;
            popularity = AutoSaveGame.data.popularity;
            popularityModifier = AutoSaveGame.data.popularityModifier;
            nextDayPopularity = AutoSaveGame.data.nextDayPopularity;
            otherIncome = AutoSaveGame.data.otherIncome;
            otherOutcome = AutoSaveGame.data.otherOutcome;
            cleaningServiceOutcome = AutoSaveGame.data.cleaningServiceOutcome;
            technicianOutcome = AutoSaveGame.data.technicianOutcome;
            securityOutcome = AutoSaveGame.data.securityOutcome;
            nowEvent = AutoSaveGame.data.nowEvent;
            bookedEvent = AutoSaveGame.data.bookedEvent;
            eventTime = AutoSaveGame.data.eventTime;
            city = AutoSaveGame.data.city;
            missionActive = AutoSaveGame.data.missionActive;
            expandElevatorTutor = AutoSaveGame.data.expandElevatorTutor;
            securityTutor = AutoSaveGame.data.securityTutor;
            if(AutoSaveGame.data.canGameOver)
            {
               canGameOver = AutoSaveGame.data.canGameOver;
            }
         }
      }
      
      public function ClosingProgress(param1:Event) : void
      {
         var i:* = undefined;
         var temp:* = undefined;
         var rnd:* = undefined;
         var rndChance:* = undefined;
         var event:Event = param1;
         i = 0;
         for(; i < tenantParent.numChildren; i++)
         {
            temp = tenantParent.getChildAt(i);
            try
            {
               if(!(temp is SupportElevator) && !(temp is SupportRestroom) && !(temp is TenantHall))
               {
                  if(dayTime >= 10 && dayTime < 22)
                  {
                     temp.isClose = false;
                  }
                  else if(dayTime >= 9 && dayTime < 22)
                  {
                     if(dayTime >= 9)
                     {
                        if(temp.isClose)
                        {
                           if(gameDelay >= 9)
                           {
                              rnd = Math.random() * 100;
                              rndChance = Math.random() * 20;
                              temp.isClose = rnd >= rndChance;
                           }
                        }
                     }
                  }
                  else
                  {
                     temp.isClose = temp.visitorList.length <= 0;
                  }
               }
            }
            catch(e:Error)
            {
            }
         }
      }
      
      public function UIOverEvent(param1:MouseEvent) : void
      {
         if(!mouseIsDown)
         {
            mouseInUI = true;
         }
      }
      
      public function loadGame() : void
      {
         if(gameLoaded >= 0)
         {
            if(gameLoaded < SaveGameData.length)
            {
               LoadFromSlot(gameLoaded);
            }
            else
            {
               LoadFromAutoSave();
            }
         }
      }
      
      public function loadTrash(param1:SharedObject) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc2_ = 0;
         while(_loc2_ < param1.data.trashWorldX.length)
         {
            _loc3_ = new fx_trash();
            _loc3_.worldX = param1.data.trashWorldX[_loc2_];
            _loc3_.worldY = param1.data.trashWorldY[_loc2_];
            _loc3_.trashLevel = param1.data.trashLevel[_loc2_];
            _loc3_.ground = floorList[param1.data.trashGround[_loc2_]];
            _loc2_++;
         }
      }
      
      public function soundInitialize() : void
      {
         bgm = new BGM_LIST[city]();
         bgmChannel = bgm.play(0,0,bgmTransform);
      }
      
      public function addBandit() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         if((dayTime >= 22 || dayTime < 5) && !alarmTrigger)
         {
            ++banditDelay;
            if(banditDelay >= BANDIT_APPEAR)
            {
               banditDelay = 0;
               _loc1_ = Math.random() * 100;
               _loc2_ = 30 + city * 20;
               if(10 + 5 * dayPass < _loc2_)
               {
                  _loc2_ = 30 + 10 * dayPass;
               }
               if(_loc1_ < _loc2_)
               {
                  _loc3_ = Math.floor(Math.random() * (city + 1));
                  if((_loc4_ = new BANDIT_LIST[_loc3_]()) is Bandit || _loc4_ is Ninja)
                  {
                     _loc4_.floorPos = ground;
                  }
                  else
                  {
                     _loc5_ = Math.floor(Math.random() * floorList.length - 1);
                     _loc4_.floorPos = floorList[_loc5_];
                  }
                  _loc4_.homePos = Math.floor(Math.random() * 2) * MAX_WIDTH;
                  _loc4_.worldX = _loc4_.homePos;
                  banditList.push(_loc4_);
                  visitorParent.addChild(_loc4_);
                  if(!securityTutor && firstBandit == null)
                  {
                     firstBandit = _loc4_;
                     addEventListener(Event.ENTER_FRAME,BanditTutorial);
                  }
               }
            }
         }
      }
      
      public function savingElevator() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         AutoSaveGame.data.elevatorName = new Array();
         AutoSaveGame.data.elevatorWorldX = new Array();
         AutoSaveGame.data.elevatorWorldY = new Array();
         AutoSaveGame.data.elevatorLevel = new Array();
         AutoSaveGame.data.elevatorBodyListY = new Array();
         AutoSaveGame.data.elevatorFloorList = new Array();
         _loc1_ = 0;
         while(_loc1_ < elevatorList.length)
         {
            AutoSaveGame.data.elevatorName.push(elevatorList[_loc1_].name);
            AutoSaveGame.data.elevatorWorldX.push(elevatorList[_loc1_].worldX);
            AutoSaveGame.data.elevatorWorldY.push(elevatorList[_loc1_].worldY);
            AutoSaveGame.data.elevatorLevel.push(elevatorList[_loc1_].tLevel);
            _loc2_ = new Array();
            _loc3_ = new Array();
            _loc4_ = 0;
            while(_loc4_ < elevatorList[_loc1_].elevatorList.length)
            {
               _loc2_.push(elevatorList[_loc1_].elevatorList[_loc4_].y);
               _loc3_.push(floorList.indexOf(elevatorList[_loc1_].floorList[_loc4_]));
               _loc4_++;
            }
            AutoSaveGame.data.elevatorBodyListY.push(_loc2_);
            AutoSaveGame.data.elevatorFloorList.push(_loc3_);
            _loc1_++;
         }
      }
      
      public function MouseMoveEvent(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         if(mouseIsDown && userinterface.getButtonActive() == 0)
         {
            _loc2_ = param1.stageX;
            _loc3_ = param1.stageY;
            _loc4_ = _loc2_ - lastPosX;
            lastPosX = _loc2_;
            cameraX -= _loc4_;
            if(cameraX <= 0)
            {
               cameraX = 0;
            }
            if(cameraX + CAMERA_WIDTH >= MAX_WIDTH)
            {
               cameraX = MAX_WIDTH - CAMERA_WIDTH;
            }
            _loc5_ = _loc3_ - lastPosY;
            lastPosY = _loc3_;
            cameraY -= _loc5_;
            if(cameraY <= 0)
            {
               cameraY = 0;
            }
            if(cameraY + CAMERA_HEIGHT >= MAX_HEIGHT)
            {
               cameraY = MAX_HEIGHT - CAMERA_HEIGHT;
            }
            if(tutorialMode && tutorialStep == 4 && (_loc4_ >= 5 || _loc5_ >= 5))
            {
               RemoveTutorialText(tutorialParent);
            }
         }
         if(!mouseInUI && userinterface.getButtonActive() == 0)
         {
            mouse.hide();
            handCursor.visible = true;
            handCursor.x = mouseX;
            handCursor.y = mouseY;
         }
         else
         {
            mouse.show();
            handCursor.visible = false;
         }
         noticeParent.x = mouseX;
         noticeParent.y = mouseY;
      }
      
      public function savingEmptySpace() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         AutoSaveGame.data.emptyWorldX = new Array();
         AutoSaveGame.data.emptyWorldY = new Array();
         _loc1_ = 0;
         while(_loc1_ < emptyParent.numChildren)
         {
            _loc2_ = emptyParent.getChildAt(_loc1_);
            AutoSaveGame.data.emptyWorldX.push(_loc2_.worldX);
            AutoSaveGame.data.emptyWorldY.push(_loc2_.worldY);
            _loc1_++;
         }
      }
      
      public function ExpandElevatorTutor(param1:Event) : void
      {
         if(!expandElevatorTutor && elevatorList.length > 0)
         {
            lastSpeed = gameSpeed;
            cameraX = elevatorList[0].worldX + elevatorList[0].width / 2 - CAMERA_WIDTH / 2;
            cameraY = elevatorList[0].worldY + elevatorList[0].height - CAMERA_HEIGHT + 120;
            addTutorialNotification("Elevator can be expanded to reach higher floor.\nTo expand elevator <font color=\'#007A03\'>hold left mouse button</font> then\ndrag it as high as you want. But remember,\nexpanding elevator will <font color=\'#FF0000\'>take some cost</font>.",true);
            userinterface.deactiveAllButton();
            expandElevatorTutor = true;
         }
         else if(tutorialParent.numChildren > 0)
         {
            gameSpeed = 0;
         }
         else
         {
            gameSpeed = lastSpeed;
            userinterface.activeAllButton();
            removeEventListener(Event.ENTER_FRAME,ExpandElevatorTutor);
         }
      }
      
      public function completes(param1:Event) : void
      {
         gotoAndPlay("Gamesfree");
         this.loaderInfo.removeEventListener(ProgressEvent.PROGRESS,loading);
         this.loaderInfo.removeEventListener(Event.COMPLETE,completes);
      }
      
      public function tutorialArrowRelation(param1:MovieClip, param2:MovieClip, param3:* = 1, param4:* = 0) : void
      {
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         _loc5_ = param2.rotation * Math.PI / 180;
         _loc6_ = param2.x - param2.height * Math.sin(_loc5_);
         _loc7_ = param2.y + param2.height * Math.cos(_loc5_);
         param1.x = _loc6_ + param1.width / 2 * param3;
         param1.y = _loc7_ + param1.height / 2 * param4;
      }
      
      public function MoneySplit(param1:Number) : String
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         _loc2_ = "";
         if(Math.abs(param1) >= 1000)
         {
            _loc3_ = Math.floor(param1 / 1000);
            _loc4_ = Math.abs(param1) % 1000;
            _loc5_ = MoneySplit(_loc3_);
            _loc6_ = _loc4_ + "";
            while(_loc6_.length < 3)
            {
               _loc6_ = "0" + _loc6_;
            }
            _loc2_ = _loc5_ + "," + _loc6_;
         }
         else
         {
            _loc2_ = param1 + "";
         }
         return _loc2_;
      }
      
      public function moneyToNumber(param1:String) : Number
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         _loc2_ = 0;
         while(param1.length > 0)
         {
            _loc3_ = param1.charAt(0);
            param1 = String(param1.substring(1));
            if(_loc3_ >= "0" && _loc3_ <= "9")
            {
               _loc4_ = Number(_loc3_);
               _loc2_ = _loc2_ * 10 + _loc4_;
            }
         }
         return _loc2_;
      }
      
      public function DrawStreet(param1:Event) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         _loc2_ = 0;
         while(_loc2_ < bgParent.numChildren)
         {
            _loc4_ = bgParent.getChildAt(_loc2_);
            _loc4_.x = _loc4_.worldX - cameraX;
            _loc4_.y = _loc4_.worldY - cameraY;
            _loc4_.visible = drawArea.hitTestObject(_loc4_);
            _loc2_++;
         }
         _loc3_ = bgCity.width / MAX_WIDTH;
         bgCity.x = -cameraX * _loc3_;
         bgCity2.x = bgCity.width - cameraX * _loc3_;
         bgCity.y = defaultCityY + (MAX_HEIGHT - (cameraY + CAMERA_HEIGHT));
         bgCity2.y = defaultCityY + (MAX_HEIGHT - (cameraY + CAMERA_HEIGHT));
         if(landmark != null)
         {
            landmark.x = stage.stageWidth / 2 + (MAX_WIDTH / 2 - (cameraX + CAMERA_WIDTH / 2)) * _loc3_;
            landmark.y = defaultCityY - 100 + (MAX_HEIGHT - (cameraY + CAMERA_HEIGHT));
         }
         ground.y = ground.worldY - cameraY;
         sky.y = sky.worldY - cameraY;
      }
      
      public function SoundManagement(param1:Event) : void
      {
         var _loc2_:* = undefined;
         if(dayTime >= 22 || dayTime < 9)
         {
            if(!(bgm is BGMNight || bgm is BGMSpoted))
            {
               if(bgmEnvironment > 0)
               {
                  bgmEnvironment -= 0.01;
                  bgmTransform.volume = bgmEnvironment * bgmVolume;
               }
               else
               {
                  if(bgmChannel != null)
                  {
                     bgmChannel.stop();
                  }
                  bgm = new BGMNight();
                  bgmEnvironment = 1;
                  bgmTransform.volume = bgmEnvironment * bgmVolume;
                  bgmChannel = bgm.play(0,0,bgmTransform);
                  bgmChannel.addEventListener(Event.SOUND_COMPLETE,BGMLoop);
               }
               if(bgmChannel != null)
               {
                  bgmChannel.soundTransform = bgmTransform;
               }
            }
         }
         else
         {
            if(bgm is BGMNight)
            {
               if(bgmEnvironment > 0)
               {
                  bgmEnvironment -= 0.01;
                  bgmTransform.volume = bgmEnvironment * bgmVolume;
               }
               else
               {
                  if(bgmChannel != null)
                  {
                     bgmChannel.stop();
                  }
                  bgm = new BGM_LIST[city]();
                  bgmEnvironment = 1;
                  bgmTransform.volume = bgmEnvironment * bgmVolume;
                  bgmChannel = bgm.play(0,0,bgmTransform);
                  bgmChannel.addEventListener(Event.SOUND_COMPLETE,BGMLoop);
               }
               if(bgmChannel != null)
               {
                  bgmChannel.soundTransform = bgmTransform;
               }
            }
            if(dayTime >= 12 && dayTime < 22)
            {
               if(nowEvent == 0)
               {
                  if(!(bgm is BGM_Event_Art))
                  {
                     if(bgmEnvironment > 0)
                     {
                        bgmEnvironment -= 0.01;
                        bgmTransform.volume = bgmEnvironment * bgmVolume;
                     }
                     else
                     {
                        if(bgmChannel != null)
                        {
                           bgmChannel.stop();
                        }
                        bgm = new BGM_Event_Art();
                        bgmEnvironment = 1;
                        bgmTransform.volume = bgmEnvironment * bgmVolume;
                        bgmChannel = bgm.play(0,0,bgmTransform);
                        bgmChannel.addEventListener(Event.SOUND_COMPLETE,BGMLoop);
                     }
                     if(bgmChannel != null)
                     {
                        bgmChannel.soundTransform = bgmTransform;
                     }
                  }
               }
               else if(nowEvent == 1)
               {
                  if(!(bgm is BGM_Event_Electro))
                  {
                     if(bgmEnvironment > 0)
                     {
                        bgmEnvironment -= 0.01;
                        bgmTransform.volume = bgmEnvironment * bgmVolume;
                     }
                     else
                     {
                        if(bgmChannel != null)
                        {
                           bgmChannel.stop();
                        }
                        bgm = new BGM_Event_Electro();
                        bgmEnvironment = 1;
                        bgmTransform.volume = bgmEnvironment * bgmVolume;
                        bgmChannel = bgm.play(0,0,bgmTransform);
                        bgmChannel.addEventListener(Event.SOUND_COMPLETE,BGMLoop);
                     }
                     if(bgmChannel != null)
                     {
                        bgmChannel.soundTransform = bgmTransform;
                     }
                  }
               }
               else if(nowEvent == 2)
               {
                  if(!(bgm is BGM_Event_Concert))
                  {
                     if(bgmEnvironment > 0)
                     {
                        bgmEnvironment -= 0.1;
                        bgmTransform.volume = bgmEnvironment * bgmVolume;
                     }
                     else
                     {
                        if(bgmChannel != null)
                        {
                           bgmChannel.stop();
                        }
                        bgm = new BGM_Event_Concert();
                        bgmEnvironment = 1;
                        bgmTransform.volume = bgmEnvironment * bgmVolume;
                        bgmChannel = bgm.play(0,0,bgmTransform);
                        bgmChannel.addEventListener(Event.SOUND_COMPLETE,BGMLoop);
                     }
                     if(bgmChannel != null)
                     {
                        bgmChannel.soundTransform = bgmTransform;
                     }
                  }
                  else if(dayTime >= 21 && dayMinute >= 30)
                  {
                     if(bgmEnvironment > 0)
                     {
                        bgmEnvironment -= 0.01;
                        bgmTransform.volume = bgmEnvironment * bgmVolume;
                     }
                     bgmChannel.soundTransform = bgmTransform;
                  }
               }
            }
         }
         if(alarmTrigger)
         {
            if(!(bgm is BGMSpoted))
            {
               bgmChannel.stop();
               tBgm = bgm;
               bgm = new BGMSpoted();
               bgmEnvironment = 1;
               bgmTransform.volume = bgmEnvironment * bgmVolume;
               bgmChannel = bgm.play(0,0,bgmTransform);
               bgmChannel.addEventListener(Event.SOUND_COMPLETE,BGMLoop);
            }
            if(seChannel == null)
            {
               _loc2_ = new SEAlarm();
               seChannel = _loc2_.play(0,0,seTransform);
               seChannel.addEventListener(Event.SOUND_COMPLETE,AlarmLoop);
            }
         }
         else
         {
            if(bgm is BGMSpoted)
            {
               bgmChannel.stop();
               bgm = tBgm;
               bgm = new BGMNight();
               bgmChannel = bgm.play(0,0,bgmTransform);
               bgmChannel.addEventListener(Event.SOUND_COMPLETE,BGMLoop);
            }
            if(seChannel != null)
            {
               seChannel.stop();
               seChannel = null;
            }
         }
      }
      
      public function GameOverSkip(param1:Event) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = new GameOverScreen();
         this.addChild(_loc2_);
         removeEventListener(MouseEvent.CLICK,GameOverSkip);
         removeEventListener(KeyboardEvent.KEY_UP,GameOverSkip);
      }
      
      public function BuildingMode(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         if(buildParent.numChildren > 0)
         {
            _loc2_ = buildParent.getChildAt(0);
            _loc3_ = false;
            _loc4_ = 0;
            while(_loc4_ < userinterface.hireArr.length)
            {
               if(_loc2_ is userinterface.hireArr[_loc4_])
               {
                  _loc3_ = true;
               }
               _loc4_++;
            }
            if(!_loc3_)
            {
               _loc7_ = param1.stageX - _loc2_.width / 2;
               if(_loc2_ is BuildElevator)
               {
                  _loc8_ = param1.stageY;
               }
               else
               {
                  _loc8_ = param1.stageY - _loc2_.height / 2;
               }
            }
            else
            {
               _loc7_ = param1.stageX;
               _loc8_ = _loc2_.y;
            }
            _loc5_ = _loc7_ + cameraX;
            _loc6_ = _loc8_ + cameraY;
            _loc5_ = Math.round(_loc5_ / 12) * 12;
            _loc6_ = Math.round(_loc6_ / 12) * 12;
            _loc2_.x = _loc5_ - cameraX;
            _loc2_.y = _loc6_ - cameraY;
         }
      }
      
      public function LittleGiantURL(param1:MouseEvent) : void
      {
         var _loc2_:URLRequest = null;
         _loc2_ = new URLRequest("http://www.littlegiantworld.com");
         navigateToURL(_loc2_,"_blank");
      }
      
      public function UIOutEvent(param1:MouseEvent) : void
      {
         mouseInUI = false;
      }
      
      public function VisitorUpdate(param1:Event) : void
      {
         var _loc2_:* = undefined;
         DrawObject(visitorParent);
         if(gameDelay >= 9)
         {
            maxVisitor = floorAverage * (floorList.length - 1) * mass;
            if(maxVisitor > MAX_VISITOR)
            {
               maxVisitor = MAX_VISITOR;
            }
            addRandomVisitor();
            addBandit();
            --swapDelay;
            if(swapDelay <= 0)
            {
               if(visitorParent.numChildren > 0)
               {
                  _loc2_ = visitorParent.getChildAt(0);
                  visitorParent.addChild(_loc2_);
               }
               swapDelay = 72;
            }
         }
         userinterface.visitorNumber.text = visitorList.length;
         userinterface.crewNumber.text = crewList.length;
         userinterface.tenantNumber.text = tenantList.length;
      }
      
      public function BackToMainMenu() : void
      {
         cleanAllObject();
         gotoAndPlay("Main Menu");
      }
      
      public function VisitorOnClick(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:BitmapFilter = null;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         if(userinterface.getButtonActive() != 0 && canClick < 7 && param1.currentTarget != visitorFocus)
         {
            if(visitorFocus != null)
            {
               visitorFocus.filters = [];
            }
            if(menuParent.numChildren > 0)
            {
               (_loc5_ = menuParent.getChildAt(0)).closeMenu();
            }
            _loc2_ = new UI_VisitorInformation();
            _loc2_.x = menuX;
            _loc2_.y = menuY;
            menuParent.addChild(_loc2_);
            visitorFocus = param1.currentTarget;
            _loc3_ = new GlowFilter(16746496,0.9,5,5,2);
            (_loc4_ = new Array()).push(_loc3_);
            visitorFocus.filters = _loc4_;
         }
      }
      
      public function savingPillar() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         AutoSaveGame.data.pillarWorldX = new Array();
         AutoSaveGame.data.pillarWorldY = new Array();
         _loc1_ = 0;
         while(_loc1_ < pillarParent.numChildren)
         {
            _loc2_ = pillarParent.getChildAt(_loc1_);
            if(_loc2_ is Pillar)
            {
               AutoSaveGame.data.pillarWorldX.push(_loc2_.worldX);
               AutoSaveGame.data.pillarWorldY.push(_loc2_.worldY);
            }
            _loc1_++;
         }
      }
      
      public function loadFloor(param1:SharedObject) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = 0;
         while(_loc2_ < param1.data.floorWorldX.length)
         {
            createFloor(param1.data.floorWorldX[_loc2_],param1.data.floorWorldY[_loc2_],param1.data.floorWidth[_loc2_]);
            _loc2_++;
         }
      }
      
      public function countAllEmployee(param1:Number = 0) : Number
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc2_ = 0;
         _loc3_ = 0;
         while(_loc3_ < crewList.length)
         {
            if(crewList[_loc3_].cLevel >= param1)
            {
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function InitCloud() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc2_ = new cloudGame();
            _loc2_.speed = Math.random() * 2 + 1;
            _loc2_.normal.gotoAndStop(Math.ceil(Math.random() * _loc2_.normal.totalFrames));
            _loc2_.sunset.gotoAndStop(_loc2_.normal.currentFrame);
            _loc2_.x = Math.random() * stage.stageWidth;
            _loc2_.y = Math.random() * stage.stageHeight;
            _loc2_.normal.alpha = 1 - sunset.alpha;
            _loc2_.sunset.alpha = sunset.alpha;
            _loc2_.alpha = 1 - night.alpha;
            cloudList.push(_loc2_);
            bgAccParent.addChild(_loc2_);
            _loc2_.addEventListener(Event.ENTER_FRAME,CloudMove);
            _loc1_++;
         }
      }
      
      public function addRandomVisitor() : void
      {
         var isSpecial:* = undefined;
         var appearance:* = undefined;
         var chanceOut:* = undefined;
         var rnd:* = undefined;
         var si:* = undefined;
         var sRnd:* = undefined;
         var newVisitor:* = undefined;
         var i:* = undefined;
         var randomAppear:* = undefined;
         var rndIndex:* = undefined;
         var vIndex:* = undefined;
         ++visitorDelay;
         if(visitorDelay > VISITOR_APPEAR)
         {
            visitorDelay = 0;
            if(missionActive in mission[city] && mission[city][missionActive].toUpperCase() == "Earn your first profit".toUpperCase() && tenantList.length > 0 && visitorList.length == 0 && dayTime >= 10 && dayTime < 22)
            {
               newVisitor = new VisitorStranger();
               newVisitor.floorPos = ground;
               newVisitor.homePos = Math.floor(Math.random() * 2) * MAX_WIDTH;
               newVisitor.worldX = newVisitor.homePos;
               newVisitor.speedX = 2;
               visitorList.push(newVisitor);
               visitorParent.addChild(newVisitor);
               newVisitor.interest = userinterface.btnArr.indexOf(tenantList[0].name);
               newVisitor.destination = tenantList[0];
               newVisitor.addEventListener(MouseEvent.MOUSE_OVER,VisitorOnOver);
               newVisitor.addEventListener(MouseEvent.MOUSE_OUT,VisitorOnOut);
               newVisitor.addEventListener(MouseEvent.CLICK,VisitorOnClick);
            }
            else if(visitorList.length < maxVisitor)
            {
               if(popularity < 10)
               {
                  appearance = 1;
               }
               else
               {
                  appearance = Math.round(popularity / 10);
               }
               if(tenantList.length > 0)
               {
                  chanceOut = popularity + popularityModifier / 2;
                  if(hall != null && nowEvent >= 0 && !hall.isClose)
                  {
                     chanceOut += chanceOut * (hall.tLevel * (0.1 * (nowEvent + 1)));
                  }
                  if(chanceOut < 10)
                  {
                     chanceOut = 10;
                  }
               }
               else
               {
                  chanceOut = 0;
               }
               isSpecial = false;
               if(chanceOut > 80 + 40 * specialVisitor.length)
               {
                  try
                  {
                     rnd = Math.random() * 100;
                     if(rnd < chanceOut - (80 + 40 * specialVisitor.length))
                     {
                        if(city < 2)
                        {
                           sRnd = Math.floor(Math.random() * SPECIAL_VISITOR_LIST.length - 1);
                        }
                        else
                        {
                           sRnd = Math.floor(Math.random() * SPECIAL_VISITOR_LIST.length);
                        }
                        isSpecial = true;
                        si = 0;
                        while(si < specialVisitor.length)
                        {
                           if(specialVisitor[si] is SPECIAL_VISITOR_LIST[sRnd])
                           {
                              isSpecial = false;
                              break;
                           }
                           si++;
                        }
                     }
                  }
                  catch(e:Error)
                  {
                     isSpecial = false;
                  }
               }
               if(isSpecial)
               {
                  newVisitor = new SPECIAL_VISITOR_LIST[sRnd]();
                  newVisitor.floorPos = ground;
                  newVisitor.homePos = Math.floor(Math.random() * 2) * MAX_WIDTH;
                  newVisitor.worldX = newVisitor.homePos;
                  newVisitor.worldY = ground.worldY - ground.height;
                  visitorList.push(newVisitor);
                  visitorParent.addChild(newVisitor);
                  newVisitor.addEventListener(MouseEvent.MOUSE_OVER,VisitorOnOver);
                  newVisitor.addEventListener(MouseEvent.MOUSE_OUT,VisitorOnOut);
                  newVisitor.addEventListener(MouseEvent.CLICK,VisitorOnClick);
                  specialVisitor.push(newVisitor);
                  addNotification(newVisitor.visitorName + " is coming");
                  if(newVisitor is VisitorObama)
                  {
                     if(!Achivement.data.trophyList[18])
                     {
                        addNewAchivement(18);
                     }
                  }
               }
               else
               {
                  i = 0;
                  while(i < appearance)
                  {
                     randomAppear = Math.random() * 100;
                     if(randomAppear <= chanceOut + 2 * specialVisitor.length)
                     {
                        rndIndex = Math.floor(Math.random() * visitorCanAppear[city].length);
                        vIndex = visitorCanAppear[city][rndIndex];
                        newVisitor = new VISITOR_LIST[vIndex]();
                        newVisitor.floorPos = ground;
                        newVisitor.homePos = Math.floor(Math.random() * 2) * MAX_WIDTH;
                        newVisitor.worldX = newVisitor.homePos;
                        newVisitor.speedX = Math.ceil(Math.random() * 3);
                        visitorList.push(newVisitor);
                        visitorParent.addChild(newVisitor);
                        newVisitor.addEventListener(MouseEvent.MOUSE_OVER,VisitorOnOver);
                        newVisitor.addEventListener(MouseEvent.MOUSE_OUT,VisitorOnOut);
                        newVisitor.addEventListener(MouseEvent.CLICK,VisitorOnClick);
                     }
                     i++;
                  }
               }
            }
         }
      }
      
      public function saveGame(param1:Number) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         _loc2_ = true;
         if(_loc2_)
         {
            SaveGameData[param1].data.playerName = AutoSaveGame.data.playerName;
            SaveGameData[param1].data.saveDate = new Date();
            SaveGameData[param1].data.pillarWorldX = AutoSaveGame.data.pillarWorldX.concat();
            SaveGameData[param1].data.pillarWorldY = AutoSaveGame.data.pillarWorldY.concat();
            SaveGameData[param1].data.emptyWorldX = AutoSaveGame.data.emptyWorldX.concat();
            SaveGameData[param1].data.emptyWorldY = AutoSaveGame.data.emptyWorldY.concat();
            SaveGameData[param1].data.floorWorldX = AutoSaveGame.data.floorWorldX.concat();
            SaveGameData[param1].data.floorWorldY = AutoSaveGame.data.floorWorldY.concat();
            SaveGameData[param1].data.floorWidth = AutoSaveGame.data.floorWidth.concat();
            SaveGameData[param1].data.tenantName = AutoSaveGame.data.tenantName.concat();
            SaveGameData[param1].data.tenantWorldX = AutoSaveGame.data.tenantWorldX.concat();
            SaveGameData[param1].data.tenantWorldY = AutoSaveGame.data.tenantWorldY.concat();
            SaveGameData[param1].data.tenantBrokenLevel = AutoSaveGame.data.tenantBrokenLevel.concat();
            SaveGameData[param1].data.tenantLevel = AutoSaveGame.data.tenantLevel.concat();
            SaveGameData[param1].data.tenantGround = AutoSaveGame.data.tenantGround.concat();
            SaveGameData[param1].data.tenantIncome = AutoSaveGame.data.tenantIncome.concat();
            SaveGameData[param1].data.tenantOutcome = AutoSaveGame.data.tenantOutcome.concat();
            SaveGameData[param1].data.restroomName = AutoSaveGame.data.restroomName.concat();
            SaveGameData[param1].data.restroomWorldX = AutoSaveGame.data.restroomWorldX.concat();
            SaveGameData[param1].data.restroomWorldY = AutoSaveGame.data.restroomWorldY.concat();
            SaveGameData[param1].data.restroomLevel = AutoSaveGame.data.restroomLevel.concat();
            SaveGameData[param1].data.restroomGround = AutoSaveGame.data.restroomGround.concat();
            SaveGameData[param1].data.elevatorName = AutoSaveGame.data.elevatorName.concat();
            SaveGameData[param1].data.elevatorWorldX = AutoSaveGame.data.elevatorWorldX.concat();
            SaveGameData[param1].data.elevatorWorldY = AutoSaveGame.data.elevatorWorldY.concat();
            SaveGameData[param1].data.elevatorLevel = AutoSaveGame.data.elevatorLevel.concat();
            SaveGameData[param1].data.elevatorBodyListY = new Array(AutoSaveGame.data.elevatorBodyListY);
            SaveGameData[param1].data.elevatorFloorList = new Array(AutoSaveGame.data.elevatorFloorList);
            _loc3_ = 0;
            while(_loc3_ < AutoSaveGame.data.elevatorBodyListY.length)
            {
               SaveGameData[param1].data.elevatorBodyListY[_loc3_] = AutoSaveGame.data.elevatorBodyListY[_loc3_].concat();
               SaveGameData[param1].data.elevatorFloorList[_loc3_] = AutoSaveGame.data.elevatorFloorList[_loc3_].concat();
               _loc3_++;
            }
            SaveGameData[param1].data.employeeName = AutoSaveGame.data.employeeName.concat();
            SaveGameData[param1].data.employeeWorldX = AutoSaveGame.data.employeeWorldX.concat();
            SaveGameData[param1].data.employeeWorldY = AutoSaveGame.data.employeeWorldY.concat();
            SaveGameData[param1].data.employeeLevel = AutoSaveGame.data.employeeLevel.concat();
            SaveGameData[param1].data.employeeShiftFloor = AutoSaveGame.data.employeeShiftFloor.concat();
            SaveGameData[param1].data.employeeFloorPos = AutoSaveGame.data.employeeFloorPos.concat();
            SaveGameData[param1].data.employeeHome = AutoSaveGame.data.employeeHome.concat();
            SaveGameData[param1].data.employeeGoHome = AutoSaveGame.data.employeeGoHome.concat();
            SaveGameData[param1].data.trashWorldX = AutoSaveGame.data.trashWorldX.concat();
            SaveGameData[param1].data.trashWorldY = AutoSaveGame.data.trashWorldY.concat();
            SaveGameData[param1].data.trashLevel = AutoSaveGame.data.trashLevel.concat();
            SaveGameData[param1].data.trashGround = AutoSaveGame.data.trashGround.concat();
            SaveGameData[param1].data.discription = AutoSaveGame.data.discription;
            SaveGameData[param1].data.visitorComeList = AutoSaveGame.data.visitorComeList;
            SaveGameData[param1].data.incomeList = AutoSaveGame.data.incomeList;
            SaveGameData[param1].data.outcomeList = AutoSaveGame.data.outcomeList;
            SaveGameData[param1].data.gainList = AutoSaveGame.data.gainList;
            SaveGameData[param1].data.totalEarning = AutoSaveGame.data.totalEarning;
            SaveGameData[param1].data.difference = AutoSaveGame.data.difference;
            SaveGameData[param1].data.lastEarning = AutoSaveGame.data.lastEarning;
            SaveGameData[param1].data.dayPass = AutoSaveGame.data.dayPass;
            SaveGameData[param1].data.currentCash = AutoSaveGame.data.currentCash;
            SaveGameData[param1].data.popularity = AutoSaveGame.data.popularity;
            SaveGameData[param1].data.popularityModifier = AutoSaveGame.data.popularityModifier;
            SaveGameData[param1].data.nextDayPopularity = AutoSaveGame.data.nextDayPopularity;
            SaveGameData[param1].data.otherIncome = AutoSaveGame.data.otherIncome;
            SaveGameData[param1].data.otherOutcome = AutoSaveGame.data.otherOutcome;
            SaveGameData[param1].data.cleaningServiceOutcome = AutoSaveGame.data.cleaningServiceOutcome;
            SaveGameData[param1].data.technicianOutcome = AutoSaveGame.data.technicianOutcome;
            SaveGameData[param1].data.securityOutcome = AutoSaveGame.data.securityOutcome;
            SaveGameData[param1].data.nowEvent = AutoSaveGame.data.nowEvent;
            SaveGameData[param1].data.bookedEvent = AutoSaveGame.data.bookedEvent;
            SaveGameData[param1].data.eventTime = AutoSaveGame.data.eventTime;
            SaveGameData[param1].data.city = AutoSaveGame.data.city;
            SaveGameData[param1].data.missionActive = AutoSaveGame.data.missionActive;
            SaveGameData[param1].data.expandElevatorTutor = AutoSaveGame.data.expandElevatorTutor;
            SaveGameData[param1].data.securityTutor = AutoSaveGame.data.securityTutor;
            SaveGameData[param1].data.canGameOver = AutoSaveGame.data.canGameOver;
            SaveGameData[param1].flush();
            (_loc4_ = new UI_ManualGameSavedAnimation()).x = userinterface.autoSavePosition.x;
            _loc4_.y = userinterface.autoSavePosition.y;
            addChild(_loc4_);
         }
      }
      
      public function BuildingCollition(param1:Event) : void
      {
         var _loc2_:* = undefined;
         if(buildParent.numChildren > 0)
         {
            _loc2_ = buildParent.getChildAt(0);
            canBuild = checkCollition(_loc2_);
            if(canBuild)
            {
               _loc2_.transform.colorTransform = new ColorTransform(1,1,1,0.3,0,0,0,0);
            }
            else
            {
               _loc2_.transform.colorTransform = new ColorTransform(1,0,0,0.3,0,0,0,0);
            }
         }
      }
      
      public function DrawTenant(param1:Event) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         DrawObject(tenantParent);
         DrawObject(pillarParent);
         DrawObject(emptyParent);
         DrawObject(legendParent);
         _loc2_ = 0;
         while(_loc2_ < dirtyParent.numChildren)
         {
            _loc3_ = dirtyParent.getChildAt(_loc2_);
            _loc3_.x = _loc3_.worldX - cameraX;
            _loc3_.y = _loc3_.worldY - cameraY;
            _loc3_.visible = drawArea.hitTestObject(_loc3_) && _loc3_.bundle;
            _loc2_++;
         }
      }
      
      public function setArrowPosition(param1:MovieClip, param2:Number) : void
      {
         if(param2 > param1.totalFrames)
         {
            param1.gotoAndPlay(1);
         }
         else
         {
            param1.gotoAndPlay(param2);
         }
      }
      
      public function createPillar(param1:Number, param2:Number) : void
      {
         var _loc3_:* = undefined;
         _loc3_ = new Pillar();
         _loc3_.worldX = param1;
         _loc3_.worldY = param2;
         _loc3_.x = _loc3_.worldX - cameraX;
         _loc3_.y = _loc3_.worldY - cameraY;
         pillarParent.addChild(_loc3_);
      }
      
      public function StartGame(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = param1.currentTarget;
         gameSpeed = 1;
         tutorialMode = false;
         ++missionActive;
         userinterface.activeAllButton();
         addEventListener(Event.ENTER_FRAME,VisitorUpdate);
         stage.addEventListener(MouseEvent.MOUSE_MOVE,BuildingMode);
         addEventListener(Event.ENTER_FRAME,BuildingCollition);
         stage.addEventListener(MouseEvent.MOUSE_DOWN,MouseDownEvent);
         stage.addEventListener(MouseEvent.MOUSE_UP,MouseUpEvent);
         stage.addEventListener(MouseEvent.CLICK,MouseClickEvent);
         stage.addEventListener(MouseEvent.MOUSE_MOVE,MouseMoveEvent);
         stage.addEventListener(MouseEvent.MOUSE_UP,StartBuilding);
         stage.addEventListener(KeyboardEvent.KEY_DOWN,KeyDownEvent);
         stage.addEventListener(KeyboardEvent.KEY_UP,KeyUpEvent);
         stage.addEventListener(Event.ENTER_FRAME,ScrollingWithKey);
         addEventListener(Event.ENTER_FRAME,TriggerAlarm);
         addEventListener(Event.ENTER_FRAME,UpdateMission);
         addEventListener(Event.ENTER_FRAME,CheckMission);
         removeEventListener(Event.ENTER_FRAME,OtherCheck);
         addEventListener(Event.ENTER_FRAME,OtherCheck);
         _loc2_.removeEventListener(MouseEvent.CLICK,StartGame);
      }
      
      public function checkCollition(param1:MovieClip) : Boolean
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         var _loc13_:* = undefined;
         _loc2_ = false;
         _loc3_ = false;
         _loc4_ = 0;
         while(_loc4_ < userinterface.hireArr.length)
         {
            if(param1 is userinterface.hireArr[_loc4_])
            {
               _loc3_ = true;
            }
            _loc4_++;
         }
         _loc5_ = param1.x + cameraX;
         _loc6_ = param1.y + cameraY;
         if(_loc5_ < MIN_BUILD_X || _loc5_ + param1.width > MAX_BUILD_X || Boolean(param1.hitTestObject(sky)))
         {
            _loc2_ = false;
         }
         else
         {
            _loc7_ = false;
            if(!_loc3_)
            {
               _loc8_ = 0;
               while(_loc8_ < tenantParent.numChildren)
               {
                  if((_loc9_ = tenantParent.getChildAt(_loc8_)).body != null)
                  {
                     if(!(_loc9_ is SupportElevator))
                     {
                        _loc10_ = _loc9_.body;
                     }
                     else
                     {
                        _loc10_ = _loc9_;
                     }
                  }
                  else
                  {
                     _loc10_ = _loc9_;
                  }
                  if(param1.body.hitTestObject(_loc10_))
                  {
                     _loc7_ = true;
                  }
                  if(param1 is BuildElevator && Boolean(param1.body2.hitTestObject(_loc10_)))
                  {
                     _loc7_ = true;
                  }
                  _loc8_++;
               }
            }
            else
            {
               _loc8_ = 0;
               while(_loc8_ < floorList.length)
               {
                  if(!((_loc11_ = floorList[_loc8_]) is Floor))
                  {
                     param1.y = _loc11_.y - _loc11_.height;
                  }
                  else if(param1.y > _loc11_.y && (param1.x > _loc11_.x && param1.x < _loc11_.x + _loc11_.width) && mouseY <= _loc11_.y && _loc8_ != floorList.length - 1)
                  {
                     param1.y = _loc11_.y;
                  }
                  _loc8_++;
               }
            }
            if(_loc7_)
            {
               _loc2_ = false;
            }
            else
            {
               _loc12_ = false;
               _loc8_ = 0;
               while(_loc8_ < floorList.length)
               {
                  if((_loc9_ = floorList[_loc8_]) is Floor && Boolean(param1.body.hitTestObject(_loc9_)))
                  {
                     if(param1.y <= _loc9_.y)
                     {
                        _loc12_ = true;
                        _loc13_ = _loc9_;
                     }
                  }
                  _loc8_++;
               }
               if(_loc12_)
               {
                  if(!_loc3_)
                  {
                     _loc2_ = param1.y + param1.body.height - 2 == _loc13_.y && param1.x - 12 >= _loc13_.x && param1.x + param1.width - 12 <= _loc13_.x + _loc13_.width;
                  }
                  else
                  {
                     _loc2_ = param1.y == _loc13_.y && param1.x - param1.width / 2 >= _loc13_.x && param1.x + param1.width / 2 <= _loc13_.x + _loc13_.width;
                  }
                  bottom = _loc13_;
               }
               else if(param1.body.hitTestObject(ground))
               {
                  if(_loc3_)
                  {
                     if(param1.y == ground.y - ground.height)
                     {
                        _loc2_ = true;
                        bottom = ground;
                     }
                     else
                     {
                        _loc2_ = false;
                     }
                  }
                  else if(param1.y + param1.body.height - 2 == ground.y - ground.height)
                  {
                     _loc2_ = true;
                     bottom = ground;
                  }
                  else
                  {
                     _loc2_ = false;
                  }
               }
               else
               {
                  _loc2_ = false;
               }
            }
         }
         return _loc2_;
      }
      
      public function tutorialNext(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = param1.currentTarget;
         if(tutorialParent.numChildren > 0)
         {
            clearArrow();
            RemoveTutorialText(tutorialParent);
            _loc2_.removeEventListener(MouseEvent.CLICK,tutorialNext);
         }
      }
      
      public function BGMLoop(param1:Event) : void
      {
         bgmChannel = bgm.play(0,0,bgmTransform);
         bgmChannel.addEventListener(Event.SOUND_COMPLETE,BGMLoop);
      }
      
      public function addTips(param1:String) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = new TipsNote();
         _loc2_.note.infoList.text = param1;
         _loc2_.x = tipsRegion.x;
         _loc2_.y = tipsRegion.y;
         addChild(_loc2_);
      }
      
      public function CloudMove(param1:Event) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc2_ = param1.currentTarget;
         _loc2_.alpha = 1 - night.alpha;
         _loc2_.normal.alpha = 1 - sunset.alpha;
         _loc2_.sunset.alpha = sunset.alpha;
         _loc2_.x -= _loc2_.speed;
         _loc3_ = cloudList.indexOf(_loc2_);
         if(_loc3_ >= 0 && _loc2_.x <= 0)
         {
            cloudList.splice(_loc3_,1);
         }
         if(_loc2_.x + _loc2_.width <= 0)
         {
            _loc2_.removeEventListener(Event.ENTER_FRAME,CloudMove);
            bgAccParent.removeChild(_loc2_);
         }
      }
      
      public function CheckMission(param1:Event) : void
      {
         var missionString:* = undefined;
         var floorWithBooth:* = undefined;
         var i:* = undefined;
         var floorAmount:* = undefined;
         var buildAmount:* = undefined;
         var buildType:* = undefined;
         var buildNum:* = undefined;
         var upgradeAmount:* = undefined;
         var upgradeType:* = undefined;
         var upgradeModeLast:* = undefined;
         var buildList:* = undefined;
         var upgradeNum:* = undefined;
         var upgradeMode:* = undefined;
         var upgradeLevel:* = undefined;
         var numUpgraded:* = undefined;
         var upgradeLevelNum:* = undefined;
         var earningAmount:* = undefined;
         var earningNum:* = undefined;
         var employeeAmount:* = undefined;
         var employeeType:* = undefined;
         var employeeNum:* = undefined;
         var promoteAmount:* = undefined;
         var promoteType:* = undefined;
         var promoteNum:* = undefined;
         var numPromoted:* = undefined;
         var promoteModeLast:* = undefined;
         var promoteLevel:* = undefined;
         var promoteLevelNum:* = undefined;
         var visitorAmount:* = undefined;
         var visitorCondition:* = undefined;
         var visitorNum:* = undefined;
         var banditAmount:* = undefined;
         var banditNum:* = undefined;
         var cashAmount:* = undefined;
         var cashNum:* = undefined;
         var event:Event = param1;
         if(userinterface.objective.objectiveInfo.text == mission[city][missionActive])
         {
            missionString = mission[city][missionActive];
            if(missionString == "Build the first booth")
            {
               if(tenantList.length >= 1)
               {
                  userinterface.objective.success = true;
                  ++missionActive;
               }
            }
            else if(missionString == "Build at least one booth at 2nd floor")
            {
               if(floorList.length - 1 >= 2)
               {
                  floorWithBooth = 0;
                  i = 0;
                  while(i < floorList.length)
                  {
                     if(floorList[i].tenantList.length >= 1)
                     {
                        floorWithBooth++;
                     }
                     i++;
                  }
                  if(floorWithBooth >= 2)
                  {
                     userinterface.objective.success = true;
                     ++missionActive;
                  }
               }
            }
            else if(missionString.toUpperCase() == "Build a hall".toUpperCase())
            {
               if(hall != null)
               {
                  userinterface.objective.success = true;
                  ++missionActive;
               }
            }
            else if(missionString.toUpperCase() == "Have full upgrade hall".toUpperCase())
            {
               if(hall != null && hall.tLevel >= hall.MAX_LEVEL)
               {
                  userinterface.objective.success = true;
                  ++missionActive;
               }
            }
            else if(missionString.substr(0,"Build mall with".length) == "Build mall with")
            {
               floorAmount = Number(getSubstring(missionString,"Build mall with"));
               try
               {
                  if(floorList.length - 1 >= floorAmount)
                  {
                     floorWithBooth = 0;
                     i = 0;
                     while(i < floorList.length)
                     {
                        if(floorList[i].tenantList.length + floorList[i].toiletList.length >= 1)
                        {
                           floorWithBooth++;
                        }
                        i++;
                     }
                     if(floorWithBooth >= floorAmount)
                     {
                        userinterface.objective.success = true;
                        ++missionActive;
                     }
                  }
               }
               catch(e:Error)
               {
               }
            }
            else if(missionString.substr(0,"Build".length) == "Build")
            {
               buildAmount = getSubstring(missionString,"Build");
               buildType = missionString.substr(("Build " + buildAmount).length + 1);
               if(buildAmount.toUpperCase() == "A" || buildAmount.toUpperCase() == "AN")
               {
                  buildNum = 1;
               }
               else
               {
                  buildNum = Number(buildAmount);
               }
               if(buildType.toUpperCase() == "BOOTH" || buildType.toUpperCase() == "BOOTHS")
               {
                  if(tenantList.length >= buildNum)
                  {
                     userinterface.objective.success = true;
                     ++missionActive;
                  }
               }
               else if(buildType.toUpperCase() == "RESTROOM" || buildType.toUpperCase() == "RESTROOMS")
               {
                  if(restroomList.length >= buildNum)
                  {
                     userinterface.objective.success = true;
                     ++missionActive;
                  }
               }
               else if(buildType.toUpperCase() == "ELEVATOR" || buildType.toUpperCase() == "ELEVATORS")
               {
                  if(elevatorList.length >= buildNum)
                  {
                     userinterface.objective.success = true;
                     ++missionActive;
                  }
               }
               else if(buildType.toUpperCase() == "Burger Store".toUpperCase())
               {
                  if(checkBuildLevel("btnBurger") >= buildNum)
                  {
                     userinterface.objective.success = true;
                     ++missionActive;
                  }
               }
               else if(buildType.toUpperCase() == "Beauty Salon".toUpperCase())
               {
                  if(checkBuildLevel("btnBarberShop") >= buildNum)
                  {
                     userinterface.objective.success = true;
                     ++missionActive;
                  }
               }
               else if(buildType.toUpperCase() == "Toy Store".toUpperCase())
               {
                  if(checkBuildLevel("btnToyStore") >= buildNum)
                  {
                     userinterface.objective.success = true;
                     ++missionActive;
                  }
               }
               else if(buildType.toUpperCase() == "Sushi Bar".toUpperCase())
               {
                  if(checkBuildLevel("btnSushi") >= buildNum)
                  {
                     userinterface.objective.success = true;
                     ++missionActive;
                  }
               }
               else if(buildType.toUpperCase() == "Game Center".toUpperCase())
               {
                  if(checkBuildLevel("btnGameCenter") >= buildNum)
                  {
                     userinterface.objective.success = true;
                     ++missionActive;
                  }
               }
               else if(buildType.toUpperCase() == "Steak n Grill".toUpperCase())
               {
                  if(checkBuildLevel("btnSteak") >= buildNum)
                  {
                     userinterface.objective.success = true;
                     ++missionActive;
                  }
               }
               else if(buildType.toUpperCase() == "Supermarket".toUpperCase())
               {
                  if(checkBuildLevel("btnSupermarket") >= buildNum)
                  {
                     userinterface.objective.success = true;
                     ++missionActive;
                  }
               }
               else if(buildType.toUpperCase() == "Cinema".toUpperCase())
               {
                  if(checkBuildLevel("btnCinema") >= buildNum)
                  {
                     userinterface.objective.success = true;
                     ++missionActive;
                  }
               }
            }
            else if(missionString.substr(0,"Upgrade".length) == "Upgrade")
            {
               upgradeAmount = getSubstring(missionString,"Upgrade");
               upgradeType = missionString.substr(("Upgrade " + upgradeAmount).length + 1);
               if(upgradeAmount.toUpperCase() == "A" || upgradeAmount.toUpperCase() == "AN")
               {
                  upgradeNum = 1;
               }
               else
               {
                  upgradeNum = Number(upgradeAmount);
               }
               upgradeModeLast = upgradeType.indexOf(" ");
               if(upgradeModeLast < 0)
               {
                  upgradeMode = upgradeType;
                  upgradeLevel = "";
               }
               else
               {
                  upgradeMode = upgradeType.substring(0,upgradeModeLast);
                  upgradeLevel = upgradeType.substring(upgradeModeLast + 1);
               }
               buildList = new Array();
               if(upgradeMode.toUpperCase() == "BOOTH" || upgradeMode.toUpperCase() == "BOOTHS")
               {
                  buildList = tenantList;
               }
               else if(upgradeMode.toUpperCase() == "ELEVATOR" || upgradeMode.toUpperCase() == "ELEVATORS")
               {
                  buildList = elevatorList;
               }
               else if(upgradeMode.toUpperCase() == "BUILDING" || upgradeMode.toUpperCase() == "BUILDINGS")
               {
                  i = 0;
                  while(i < tenantParent.numChildren)
                  {
                     buildList.push(tenantParent.getChildAt(i));
                     i++;
                  }
               }
               if(upgradeLevel.toUpperCase() == "TO MAX LEVEL")
               {
                  numUpgraded = 0;
                  i = 0;
                  while(i < buildList.length)
                  {
                     if(buildList[i].tLevel >= buildList[i].MAX_LEVEL)
                     {
                        numUpgraded++;
                     }
                     i++;
                  }
                  if(numUpgraded >= upgradeNum)
                  {
                     userinterface.objective.success = true;
                     ++missionActive;
                  }
               }
               else
               {
                  if(upgradeLevel == "")
                  {
                     upgradeLevelNum = 2;
                  }
                  else
                  {
                     upgradeLevelNum = Number(upgradeLevel.substring("to level".length + 1));
                  }
                  if(buildList.length >= upgradeNum)
                  {
                     numUpgraded = 0;
                     i = 0;
                     while(i < buildList.length)
                     {
                        if(buildList[i].tLevel >= upgradeLevelNum)
                        {
                           numUpgraded++;
                        }
                        i++;
                     }
                     if(numUpgraded >= upgradeNum)
                     {
                        userinterface.objective.success = true;
                        ++missionActive;
                     }
                  }
               }
            }
            else if(missionString == "Earn your first profit")
            {
               if(recive > 0)
               {
                  userinterface.objective.success = true;
                  ++missionActive;
               }
            }
            else if(missionString.substr(0,"Earn".length) == "Earn")
            {
               earningAmount = getSubstring(missionString,"Earn");
               earningNum = moneyToNumber(earningAmount);
               if(lastEarning >= earningNum)
               {
                  userinterface.objective.success = true;
                  ++missionActive;
               }
            }
            else if(missionString.substr(0,"Hire".length) == "Hire")
            {
               employeeAmount = getSubstring(missionString,"Hire");
               employeeType = missionString.substr(("Hire " + employeeAmount).length + 1);
               if(employeeAmount.toUpperCase() == "A" || employeeAmount.toUpperCase() == "AN")
               {
                  employeeNum = 1;
               }
               else
               {
                  employeeNum = Number(employeeAmount);
               }
               if(employeeType.toUpperCase() == "CLEANING STAFF MEMBER" || employeeType.toUpperCase() == "CLEANING STAFF MEMBERS")
               {
                  if(countEmployee(0) >= employeeNum)
                  {
                     userinterface.objective.success = true;
                     ++missionActive;
                  }
               }
               else if(employeeType.toUpperCase() == "TECHNICIAN" || employeeType.toUpperCase() == "TECHNICIANS")
               {
                  if(countEmployee(1) >= employeeNum)
                  {
                     userinterface.objective.success = true;
                     ++missionActive;
                  }
               }
               else if(employeeType.toUpperCase() == "SECURITY AGENT" || employeeType.toUpperCase() == "SECURITY AGENTS")
               {
                  if(countEmployee(2) >= employeeNum)
                  {
                     userinterface.objective.success = true;
                     ++missionActive;
                  }
               }
               else if(employeeType.toUpperCase() == "EMPLOYEE" || employeeType.toUpperCase() == "EMPLOYEES")
               {
                  if(crewList.length >= employeeNum)
                  {
                     userinterface.objective.success = true;
                     ++missionActive;
                  }
               }
            }
            else if(missionString.toUpperCase() == "Promote 1 Cleaning Staff Member".toUpperCase())
            {
               if(countEmployee(3) >= 1)
               {
                  userinterface.objective.success = true;
                  ++missionActive;
               }
            }
            else if(missionString.toUpperCase() == "Promote 1 Technician".toUpperCase())
            {
               if(countEmployee(4) >= 1)
               {
                  userinterface.objective.success = true;
                  ++missionActive;
               }
            }
            else if(missionString.toUpperCase() == "Promote 1 Security".toUpperCase())
            {
               if(countEmployee(5) >= 1)
               {
                  userinterface.objective.success = true;
                  ++missionActive;
               }
            }
            else if(missionString.substr(0,"Promote at least".length).toUpperCase() == "Promote at least".toUpperCase())
            {
               promoteAmount = getSubstring(missionString,"Promote at least");
               promoteType = missionString.substr(("Promote at least " + promoteAmount).length + 1);
               promoteNum = Number(promoteAmount);
               if(promoteType.toUpperCase() == "Employees to max level".toUpperCase())
               {
                  numPromoted = 0;
                  i = 0;
                  while(i < crewList.length)
                  {
                     if(!crewList[i].nextUpgrade)
                     {
                        numPromoted++;
                     }
                     i++;
                  }
                  if(numPromoted >= promoteNum)
                  {
                     userinterface.objective.success = true;
                     ++missionActive;
                  }
               }
               else
               {
                  promoteModeLast = promoteType.indexOf(" ");
                  promoteLevel = promoteType.substring(promoteModeLast + 1);
                  if(promoteLevel == "")
                  {
                     promoteLevelNum = 2;
                  }
                  else
                  {
                     promoteLevelNum = Number(promoteLevel.substring("to level".length + 1));
                  }
                  if(crewList.length >= promoteNum)
                  {
                     numPromoted = 0;
                     i = 0;
                     while(i < crewList.length)
                     {
                        if(crewList[i].cLevel >= promoteLevelNum)
                        {
                           numPromoted++;
                        }
                        i++;
                     }
                     if(numPromoted >= promoteNum)
                     {
                        userinterface.objective.success = true;
                        ++missionActive;
                     }
                  }
               }
            }
            else if(missionString.substr(0,"Have at least".length) == "Have at least")
            {
               visitorAmount = getSubstring(missionString,"Have at least");
               visitorCondition = missionString.substr(("Have at least " + visitorAmount + " visitors").length + 1);
               visitorNum = Number(visitorAmount);
               if(visitorCondition.toUpperCase() == "VISIT YOUR MALL")
               {
                  if(visitorList.length >= visitorNum)
                  {
                     userinterface.objective.success = true;
                     ++missionActive;
                  }
               }
               else if(visitorCondition.toUpperCase() == "HAPPY FOR A DAY")
               {
               }
               if(countHappyVisitor() >= visitorNum)
               {
                  userinterface.objective.success = true;
                  ++missionActive;
               }
            }
            else if(missionString.substr(0,"Make".length) == "Make")
            {
               visitorAmount = getSubstring(missionString,"Make");
               visitorCondition = missionString.substr(("Make " + visitorAmount + " visitors").length + 1);
               visitorNum = Number(visitorAmount);
               if(visitorCondition.toUpperCase() == "VISIT YOUR MALL")
               {
                  if(visitorList.length >= visitorNum)
                  {
                     userinterface.objective.success = true;
                     ++missionActive;
                  }
               }
               else if(visitorCondition.toUpperCase() == "HAPPY FOR A DAY")
               {
               }
               if(countHappyVisitor() >= visitorNum)
               {
                  userinterface.objective.success = true;
                  ++missionActive;
               }
            }
            else if(missionString.substr(0,"Have more than".length) == "Have more than")
            {
               visitorNum = Number(getSubstring(missionString,"Have more than"));
               if(visitorList.length > visitorNum)
               {
                  userinterface.objective.success = true;
                  ++missionActive;
               }
            }
            else if(missionString.substr(0,"Catch".length) == "Catch")
            {
               banditAmount = getSubstring(missionString,"Catch");
               if(banditAmount.toUpperCase() == "A")
               {
                  banditNum = 1;
               }
               else
               {
                  banditNum = Number(banditAmount);
               }
               if(banditCaptured >= banditNum)
               {
                  userinterface.objective.success = true;
                  ++missionActive;
               }
            }
            else if(missionString.toUpperCase() == "Run Event Art Exhibition at least one day".toUpperCase())
            {
               if(nowEvent == 0 && !hall.isClose)
               {
                  userinterface.objective.success = true;
                  ++missionActive;
               }
            }
            else if(missionString.toUpperCase() == "Run Event Electronic Expo at least one day".toUpperCase())
            {
               if(nowEvent == 1 && !hall.isClose)
               {
                  userinterface.objective.success = true;
                  ++missionActive;
               }
            }
            else if(missionString.toUpperCase() == "Run Event Live Concert at least one day".toUpperCase())
            {
               if(nowEvent == 2 && !hall.isClose)
               {
                  userinterface.objective.success = true;
                  ++missionActive;
               }
            }
            else if(missionString.substr(0,"Your cash reach".length).toUpperCase() == "Your cash reach".toUpperCase())
            {
               cashAmount = getSubstring(missionString,"Your cash reach");
               cashNum = moneyToNumber(cashAmount);
               if(cash + recive - purchase >= cashNum)
               {
                  userinterface.objective.success = true;
                  ++missionActive;
               }
            }
         }
      }
      
      public function KeyDownEvent(param1:KeyboardEvent) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = param1.keyCode;
         if(_loc2_ == 65)
         {
            scrollLeft1 = true;
         }
         if(_loc2_ == Keyboard.LEFT)
         {
            scrollLeft2 = true;
         }
         if(_loc2_ == 68)
         {
            scrollRight1 = true;
         }
         if(_loc2_ == Keyboard.RIGHT)
         {
            scrollRight2 = true;
         }
         if(_loc2_ == 87)
         {
            scrollUp1 = true;
         }
         if(_loc2_ == Keyboard.UP)
         {
            scrollUp2 = true;
         }
         if(_loc2_ == 83)
         {
            scrollDown1 = true;
         }
         if(_loc2_ == Keyboard.DOWN)
         {
            scrollDown2 = true;
         }
         if(_loc2_ == Keyboard.SHIFT)
         {
            shiftKey = true;
         }
      }
      
      public function getSubstring(param1:Object, param2:*) : String
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         _loc3_ = param2.length + 1;
         if((_loc4_ = param1.indexOf(" ",_loc3_)) >= 0)
         {
            _loc5_ = param1.substring(_loc3_,_loc4_);
         }
         else
         {
            _loc5_ = param1.substring(_loc3_);
         }
         return _loc5_;
      }
      
      public function TriggerAlarm(param1:Event) : void
      {
         if(robedBooth != null)
         {
            robedBooth.transform.colorTransform = new ColorTransform(1,alarmTransform,alarmTransform,1,0,0,0,0);
         }
         if(alarmTrigger)
         {
            if(alarmTimer > 0)
            {
               alarmTimer -= gameSpeed;
            }
            if(alarmTransform >= 1)
            {
               aT = -0.1;
            }
            if(alarmTransform <= 0.5)
            {
               aT = 0.1;
            }
            alarmTransform += aT;
            alarmTrigger = banditList.length > 0 && alarmTimer > 0;
            if(banditTrigger == null && banditList.length > 0)
            {
               banditTrigger = banditList[0];
            }
         }
         else
         {
            banditTrigger = null;
            if(robedBooth != null)
            {
               robedBooth.transform.colorTransform = new ColorTransform(1,1,1,1,0,0,0,0);
               robedBooth = null;
            }
            alarmTransform = 1;
            alarmTimer = 168;
         }
      }
      
      public function Initialize() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         budget.visible = false;
         dayTime = 9;
         dayMinute = 0;
         createStreet();
         if(city == 0)
         {
            landmark = new LandmarkParis();
         }
         else if(city == 2)
         {
            landmark = new LandmarkNewYork();
            API.unlockMedal("I Love NY");
         }
         _loc1_ = 0;
         while(_loc1_ < city + 1)
         {
            _loc2_ = 0;
            while(_loc2_ < tenantCanBuild[_loc1_].length)
            {
               totalTenantCanBuild.push(tenantCanBuild[_loc1_][_loc2_]);
               _loc2_++;
            }
            _loc1_++;
         }
         addChild(drawParent);
         drawParent.mask = drawArea;
         drawParent.addChild(bgAccParent);
         if(landmark != null)
         {
            drawParent.addChild(landmark);
         }
         drawParent.addChild(bgCity);
         drawParent.addChild(bgCity2);
         drawParent.addChild(bgParent);
         drawParent.addChild(emptyParent);
         drawParent.addChild(tenantParent);
         drawParent.addChild(pillarParent);
         drawParent.addChild(dirtyParent);
         drawParent.addChild(visitorParent);
         drawParent.addChild(legendParent);
         drawParent.addChild(buildParent);
         drawParent.addChild(flyingTextParent);
         drawParent.addChild(noteParent);
         addChild(userinterface);
         addChild(menuParent);
         addChild(budget);
         addChild(noticeParent);
         addChild(tutorialParent);
         addChild(tutorialArrowParent);
         addChild(tutorialShow);
         addChild(handCursor);
         handCursor.mouseChildren = false;
         handCursor.mouseEnabled = false;
         floorList.push(ground);
         InitCloud();
         loadGame();
         if(playerName.toLocaleUpperCase().charAt(playerName.length - 1) == "S")
         {
            userinterface.playerName.text = playerName + "\' Mall";
         }
         else
         {
            userinterface.playerName.text = playerName + "\'s Mall";
         }
         addEventListener(Event.ENTER_FRAME,DrawStreet);
         addEventListener(Event.ENTER_FRAME,DayTimeChange);
         userinterface.addEventListener(MouseEvent.MOUSE_OVER,UIOverEvent);
         userinterface.addEventListener(MouseEvent.MOUSE_OUT,UIOutEvent);
         addEventListener(Event.ENTER_FRAME,DrawTenant);
         addEventListener(Event.ENTER_FRAME,DirtyProgress);
         addEventListener(Event.ENTER_FRAME,BrokenProgress);
         addEventListener(Event.ENTER_FRAME,AchivementUpdate);
         addEventListener(Event.ENTER_FRAME,AccsoryManagement);
         if(!tutorialMode)
         {
            gameSpeed = 1;
            addEventListener(Event.ENTER_FRAME,VisitorUpdate);
            stage.addEventListener(MouseEvent.MOUSE_MOVE,BuildingMode);
            addEventListener(Event.ENTER_FRAME,BuildingCollition);
            stage.addEventListener(MouseEvent.MOUSE_DOWN,MouseDownEvent);
            stage.addEventListener(MouseEvent.MOUSE_UP,MouseUpEvent);
            stage.addEventListener(MouseEvent.CLICK,MouseClickEvent);
            stage.addEventListener(MouseEvent.MOUSE_MOVE,MouseMoveEvent);
            stage.addEventListener(MouseEvent.MOUSE_UP,StartBuilding);
            stage.addEventListener(KeyboardEvent.KEY_DOWN,KeyDownEvent);
            stage.addEventListener(KeyboardEvent.KEY_UP,KeyUpEvent);
            stage.addEventListener(Event.ENTER_FRAME,ScrollingWithKey);
            addEventListener(Event.ENTER_FRAME,TriggerAlarm);
            addEventListener(Event.ENTER_FRAME,UpdateMission);
            addEventListener(Event.ENTER_FRAME,CheckMission);
         }
         else
         {
            if(city == 0)
            {
               _loc3_ = new BeginingTutorial();
               addChild(_loc3_);
            }
            else if(city == 1)
            {
               _loc3_ = new TokyoBoothAvailable();
               securityTutor = true;
               expandElevatorTutor = true;
               addChild(_loc3_);
            }
            else
            {
               _loc3_ = new NewYorkBoothAvailable();
               securityTutor = true;
               expandElevatorTutor = true;
               addChild(_loc3_);
            }
            gameSpeed = 0;
         }
         addEventListener(Event.ENTER_FRAME,OtherCheck);
         addEventListener(Event.ENTER_FRAME,SoundManagement);
         soundInitialize();
         bgmChannel.addEventListener(Event.SOUND_COMPLETE,BGMLoop);
      }
      
      public function loadPillar(param1:SharedObject) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = 0;
         while(_loc2_ < param1.data.pillarWorldX.length)
         {
            createPillar(param1.data.pillarWorldX[_loc2_],param1.data.pillarWorldY[_loc2_]);
            _loc2_++;
         }
      }
      
      public function savingEmployee() : void
      {
         var _loc1_:* = undefined;
         AutoSaveGame.data.employeeName = new Array();
         AutoSaveGame.data.employeeWorldX = new Array();
         AutoSaveGame.data.employeeWorldY = new Array();
         AutoSaveGame.data.employeeLevel = new Array();
         AutoSaveGame.data.employeeShiftFloor = new Array();
         AutoSaveGame.data.employeeFloorPos = new Array();
         AutoSaveGame.data.employeeHome = new Array();
         AutoSaveGame.data.employeeGoHome = new Array();
         _loc1_ = 0;
         while(_loc1_ < crewList.length)
         {
            if(crewList[_loc1_] is CrewCleaningServicelv1 || crewList[_loc1_] is CrewCleaningServicelv2 || crewList[_loc1_] is CrewCleaningServicelv3)
            {
               AutoSaveGame.data.employeeName.push("CleaningService");
            }
            else if(crewList[_loc1_] is CrewTechnicianlv1 || crewList[_loc1_] is CrewTechnicianlv2 || crewList[_loc1_] is CrewTechnicianlv3)
            {
               AutoSaveGame.data.employeeName.push("Technician");
            }
            else if(crewList[_loc1_] is CrewSecuritylv1 || crewList[_loc1_] is CrewSecuritylv2 || crewList[_loc1_] is CrewSecuritylv3)
            {
               AutoSaveGame.data.employeeName.push("Security");
            }
            AutoSaveGame.data.employeeWorldX.push(crewList[_loc1_].worldX);
            AutoSaveGame.data.employeeWorldY.push(crewList[_loc1_].worldY);
            AutoSaveGame.data.employeeLevel.push(crewList[_loc1_].cLevel);
            AutoSaveGame.data.employeeShiftFloor.push(crewList[_loc1_].shiftFloor);
            AutoSaveGame.data.employeeFloorPos.push(floorList.indexOf(crewList[_loc1_].floorPos));
            AutoSaveGame.data.employeeHome.push(crewList[_loc1_].homePos);
            AutoSaveGame.data.employeeGoHome.push(crewList[_loc1_].goHome);
            _loc1_++;
         }
      }
      
      public function savingRestroom() : void
      {
         var _loc1_:* = undefined;
         AutoSaveGame.data.restroomName = new Array();
         AutoSaveGame.data.restroomWorldX = new Array();
         AutoSaveGame.data.restroomWorldY = new Array();
         AutoSaveGame.data.restroomLevel = new Array();
         AutoSaveGame.data.restroomGround = new Array();
         _loc1_ = 0;
         while(_loc1_ < restroomList.length)
         {
            AutoSaveGame.data.restroomName.push(restroomList[_loc1_].name);
            AutoSaveGame.data.restroomWorldX.push(restroomList[_loc1_].worldX);
            AutoSaveGame.data.restroomWorldY.push(restroomList[_loc1_].worldY);
            AutoSaveGame.data.restroomLevel.push(restroomList[_loc1_].tLevel);
            AutoSaveGame.data.restroomGround.push(floorList.indexOf(restroomList[_loc1_].ground));
            _loc1_++;
         }
      }
      
      public function addFlyingText(param1:String, param2:Number, param3:Number, param4:Boolean = false) : void
      {
         var _loc5_:* = undefined;
         if(!param4)
         {
            (_loc5_ = new UI_GoodNote()).clip.cashList.text = param1;
            _loc5_.worldX = param2;
            _loc5_.worldY = param3;
            flyingTextParent.addChild(_loc5_);
         }
      }
      
      public function LoadFromSlot(param1:Number) : void
      {
         tutorialMode = false;
         lastDayTime = 9;
         if(SaveGameData[param1].data.playerName)
         {
            playerName = SaveGameData[param1].data.playerName;
            loadPillar(SaveGameData[param1]);
            loadEmptySpace(SaveGameData[param1]);
            loadFloor(SaveGameData[param1]);
            loadTenant(SaveGameData[param1]);
            loadRestroom(SaveGameData[param1]);
            loadElevator(SaveGameData[param1]);
            loadEmployee(SaveGameData[param1]);
            loadTrash(SaveGameData[param1]);
            budget.discription.textList.htmlText = SaveGameData[param1].data.discription;
            budget.visitorComeList.textList.htmlText = SaveGameData[param1].data.visitorComeList;
            budget.incomeList.textList.htmlText = SaveGameData[param1].data.incomeList;
            budget.outcomeList.textList.htmlText = SaveGameData[param1].data.outcomeList;
            budget.gainList.textList.htmlText = SaveGameData[param1].data.gainList;
            budget.totalEarning.htmlText = SaveGameData[param1].data.totalEarning;
            budget.difference.htmlText = SaveGameData[param1].data.difference;
            lastEarning = SaveGameData[param1].data.lastEarning;
            budget.checkHeight();
            dayPass = SaveGameData[param1].data.dayPass;
            cash = SaveGameData[param1].data.currentCash;
            popularity = SaveGameData[param1].data.popularity;
            popularityModifier = SaveGameData[param1].data.popularityModifier;
            nextDayPopularity = SaveGameData[param1].data.nextDayPopularity;
            otherIncome = SaveGameData[param1].data.otherIncome;
            otherOutcome = SaveGameData[param1].data.otherOutcome;
            cleaningServiceOutcome = SaveGameData[param1].data.cleaningServiceOutcome;
            technicianOutcome = SaveGameData[param1].data.technicianOutcome;
            securityOutcome = SaveGameData[param1].data.securityOutcome;
            nowEvent = SaveGameData[param1].data.nowEvent;
            bookedEvent = SaveGameData[param1].data.bookedEvent;
            eventTime = SaveGameData[param1].data.eventTime;
            city = SaveGameData[param1].data.city;
            missionActive = SaveGameData[param1].data.missionActive;
            expandElevatorTutor = SaveGameData[param1].data.expandElevatorTutor;
            securityTutor = SaveGameData[param1].data.securityTutor;
            if(SaveGameData[param1].data.canGameOver)
            {
               canGameOver = SaveGameData[param1].data.canGameOver;
            }
         }
      }
      
      public function loadElevator(param1:SharedObject) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         _loc2_ = 0;
         while(_loc2_ < param1.data.elevatorName.length)
         {
            _loc3_ = new SupportElevator();
            _loc3_.worldX = param1.data.elevatorWorldX[_loc2_];
            _loc3_.worldY = param1.data.elevatorWorldY[_loc2_];
            _loc3_.x = _loc3_.worldX - cameraX;
            _loc3_.y = _loc3_.worldY - cameraY;
            _loc3_.name = param1.data.elevatorName[_loc2_];
            _loc3_.tLevel = param1.data.elevatorLevel[_loc2_];
            _loc3_.floorList = new Array();
            _loc3_.elevatorList = new Array();
            _loc3_.addEventListener(MouseEvent.CLICK,TenantClicking);
            tenantParent.addChild(_loc3_);
            elevatorList.push(_loc3_);
            _loc4_ = 0;
            while(_loc4_ < param1.data.elevatorBodyListY[_loc2_].length)
            {
               if(_loc3_.tLevel < 3)
               {
                  _loc5_ = new ElevatorBody();
               }
               else
               {
                  _loc5_ = new ElevatorUpgrade();
               }
               _loc5_.y = param1.data.elevatorBodyListY[_loc2_][_loc4_];
               _loc3_.elevatorList.push(_loc5_);
               _loc3_.floorList.push(floorList[param1.data.elevatorFloorList[_loc2_][_loc4_]]);
               _loc3_.addChild(_loc5_);
               _loc4_++;
            }
            _loc3_.body.door.stop();
            _loc3_.removeChild(_loc3_.getChildByName("body"));
            _loc2_++;
         }
      }
      
      public function cleanAllObject() : void
      {
         var _loc1_:* = undefined;
         if(bgmChannel != null)
         {
            bgmChannel.stop();
         }
         if(seChannel != null)
         {
            bgmChannel.stop();
         }
         lastDayTime = 8;
         i = 0;
         while(i < tenantList.length)
         {
            tenantList[i].removeEventListener(Event.ENTER_FRAME,tenantList[i].Animate);
            if(tenantList[i] is TenantIceCream)
            {
               tenantList[i].removeEventListener(Event.ENTER_FRAME,tenantList[i].VisitorQueue);
            }
            ++i;
         }
         i = 0;
         while(i < restroomList.length)
         {
            restroomList[i].removeEventListener(Event.ENTER_FRAME,restroomList[i].Animate);
            ++i;
         }
         i = 0;
         while(i < elevatorList.length)
         {
            elevatorList[i].removeEventListener(Event.ENTER_FRAME,elevatorList[i].Animate);
            elevatorList[i].removeEventListener(MouseEvent.MOUSE_DOWN,elevatorList[i].HoldElevator);
            elevatorList[i].removeEventListener(MouseEvent.MOUSE_OVER,elevatorList[i].NoticeToExpand);
            elevatorList[i].removeEventListener(MouseEvent.MOUSE_OUT,elevatorList[i].NoticeDisappear);
            ++i;
         }
         i = 0;
         while(i < visitorList.length)
         {
            visitorList[i].removeAllListener();
            ++i;
         }
         i = 0;
         while(i < crewList.length)
         {
            crewList[i].removeEventListener(Event.ENTER_FRAME,crewList[i].Animation);
            crewList[i].removeEventListener(Event.ENTER_FRAME,crewList[i].Behavior);
            crewList[i].removeEventListener(Event.ENTER_FRAME,crewList[i].BackToWork);
            ++i;
         }
         i = 0;
         while(i < banditList.length)
         {
            banditList[i].removeEventListener(Event.ENTER_FRAME,banditList[i].Animation);
            banditList[i].removeEventListener(Event.ENTER_FRAME,banditList[i].Behavior);
            banditList[i].removeEventListener(Event.ENTER_FRAME,banditList[i].Arrested);
            ++i;
         }
         i = 0;
         while(i < cloudList.length)
         {
            cloudList[i].removeEventListener(Event.ENTER_FRAME,CloudMove);
            cloudList[i].parent.removeChild(cloudList[i]);
            ++i;
         }
         while(visitorParent.numChildren > 0)
         {
            visitorParent.removeChild(visitorParent.getChildAt(0));
         }
         removeEventListener(Event.ENTER_FRAME,DrawStreet);
         removeEventListener(Event.ENTER_FRAME,DayTimeChange);
         userinterface.removeEventListener(MouseEvent.MOUSE_OVER,UIOverEvent);
         userinterface.removeEventListener(MouseEvent.MOUSE_OUT,UIOutEvent);
         userinterface.removeAllListener();
         removeEventListener(Event.ENTER_FRAME,DrawTenant);
         removeEventListener(Event.ENTER_FRAME,VisitorUpdate);
         stage.removeEventListener(MouseEvent.MOUSE_MOVE,BuildingMode);
         removeEventListener(Event.ENTER_FRAME,BuildingCollition);
         removeEventListener(Event.ENTER_FRAME,DirtyProgress);
         removeEventListener(Event.ENTER_FRAME,BrokenProgress);
         removeEventListener(Event.ENTER_FRAME,AchivementUpdate);
         stage.removeEventListener(MouseEvent.MOUSE_DOWN,MouseDownEvent);
         stage.removeEventListener(MouseEvent.MOUSE_UP,MouseUpEvent);
         stage.removeEventListener(MouseEvent.CLICK,MouseClickEvent);
         stage.removeEventListener(MouseEvent.MOUSE_MOVE,MouseMoveEvent);
         stage.removeEventListener(MouseEvent.MOUSE_UP,StartBuilding);
         stage.removeEventListener(KeyboardEvent.KEY_DOWN,KeyDownEvent);
         stage.removeEventListener(KeyboardEvent.KEY_UP,KeyUpEvent);
         stage.removeEventListener(Event.ENTER_FRAME,ScrollingWithKey);
         removeEventListener(Event.ENTER_FRAME,TriggerAlarm);
         removeEventListener(Event.ENTER_FRAME,UpdateMission);
         removeEventListener(Event.ENTER_FRAME,CheckMission);
         removeEventListener(Event.ENTER_FRAME,OtherCheck);
         removeEventListener(Event.ENTER_FRAME,SoundManagement);
         removeEventListener(Event.ENTER_FRAME,AccsoryManagement);
         i = 0;
         while(i < legendParent.numChildren)
         {
            _loc1_ = legendParent.getChildAt(i);
            _loc1_.stop();
            _loc1_.removeEventListener(Event.ENTER_FRAME,_loc1_.ChangePosition);
            ++i;
         }
         while(drawParent.numChildren > 0)
         {
            drawParent.removeChild(drawParent.getChildAt(0));
         }
         handCursor.visible = false;
         removeChild(drawParent);
         removeChild(handCursor);
         removeChild(userinterface);
         removeChild(menuParent);
         removeChild(budget);
         removeChild(noticeParent);
         removeChild(tutorialParent);
         removeChild(tutorialArrowParent);
         hall = null;
         while(numChildren > 0)
         {
            _loc1_ = getChildAt(0);
            _loc1_.stop();
            removeChild(_loc1_);
         }
      }
      
      public function OtherCheck(param1:Event) : void
      {
         var event:Event = param1;
         if(tutorialMode)
         {
            userinterface.deactiveAllButton();
         }
         if(mouseIsDown)
         {
            if(canClick < 7)
            {
               ++canClick;
            }
         }
         else
         {
            canClick = 0;
         }
         if(visitorFocus != null)
         {
            if(!visitorFocus.rideElevator)
            {
               cameraX = visitorFocus.worldX - CAMERA_WIDTH / 2;
               cameraY = visitorFocus.worldY - CAMERA_HEIGHT + 120;
            }
            else
            {
               with(visitorFocus.elevatorTarget)
               {
                  
                  cameraX = worldX + eRoom.x + visitorFocus.x - CAMERA_WIDTH / 2;
                  cameraY = worldY + eRoom.y + visitorFocus.y - CAMERA_HEIGHT + 120;
               }
            }
         }
         if(purchase > 1000)
         {
            cash -= 1000;
            purchase -= 1000;
         }
         if(purchase > 100)
         {
            cash -= 100;
            purchase -= 100;
         }
         if(purchase > 10)
         {
            cash -= 10;
            purchase -= 10;
         }
         if(purchase > 0)
         {
            --cash;
            --purchase;
         }
         if(recive > 1000)
         {
            cash += 1000;
            recive -= 1000;
         }
         if(recive > 100)
         {
            cash += 100;
            recive -= 100;
         }
         if(recive > 10)
         {
            cash += 10;
            recive -= 10;
         }
         if(recive > 0)
         {
            ++cash;
            --recive;
         }
         userinterface.cashInfo.text = MoneySplit(cash) + ".-";
         if(userinterface.nextTownWarning.visible)
         {
            gameSpeed = 0;
         }
      }
      
      public function AchivementUpdate(param1:Event) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         if(Achivement.data.trophyList)
         {
            if(!Achivement.data.trophyList[0])
            {
               if(countHappyVisitor() >= 25)
               {
                  addNewAchivement(0);
               }
            }
            if(!Achivement.data.trophyList[1])
            {
               if(countHappyVisitor() >= 50)
               {
                  addNewAchivement(1);
               }
            }
            if(!Achivement.data.trophyList[2])
            {
               if(countHappyVisitor() >= 75)
               {
                  addNewAchivement(2);
               }
            }
            if(!Achivement.data.trophyList[4])
            {
               if(lastEarning >= 50000)
               {
                  addNewAchivement(4);
               }
            }
            if(!Achivement.data.trophyList[5])
            {
               if(lastEarning >= 100000)
               {
                  addNewAchivement(5);
               }
            }
            if(!Achivement.data.trophyList[6])
            {
               if(lastEarning >= 200000)
               {
                  addNewAchivement(6);
               }
            }
            if(!Achivement.data.trophyList[7])
            {
               if(lastEarning >= 300000)
               {
                  addNewAchivement(7);
               }
            }
            if(!Achivement.data.trophyList[8])
            {
               if(tenantParent.numChildren >= 10)
               {
                  _loc2_ = true;
                  _loc3_ = 0;
                  while(_loc3_ < tenantParent.numChildren)
                  {
                     if((_loc4_ = tenantParent.getChildAt(_loc3_)).tLevel <= 1)
                     {
                        _loc2_ = false;
                     }
                     _loc3_++;
                  }
                  if(_loc2_)
                  {
                     addNewAchivement(8);
                  }
               }
            }
            if(!Achivement.data.trophyList[9])
            {
               if(tenantParent.numChildren >= 10)
               {
                  _loc2_ = true;
                  _loc3_ = 0;
                  while(_loc3_ < tenantParent.numChildren)
                  {
                     if((_loc4_ = tenantParent.getChildAt(_loc3_)).tLevel < _loc4_.MAX_LEVEL)
                     {
                        _loc2_ = false;
                     }
                     _loc3_++;
                  }
                  if(_loc2_)
                  {
                     addNewAchivement(9);
                  }
               }
            }
            if(!Achivement.data.trophyList[10])
            {
               _loc5_ = true;
               _loc6_ = 0;
               _loc3_ = 0;
               while(_loc3_ < crewList.length)
               {
                  if(crewList[_loc3_] is CrewSecuritylv1 || crewList[_loc3_] is CrewSecuritylv2)
                  {
                     _loc5_ = false;
                     break;
                  }
                  if(crewList[_loc3_] is CrewSecuritylv3)
                  {
                     _loc6_++;
                  }
                  _loc3_++;
               }
               if(_loc6_ >= 5 && _loc5_)
               {
                  addNewAchivement(10);
               }
            }
            if(!Achivement.data.trophyList[11])
            {
               _loc5_ = true;
               _loc6_ = 0;
               _loc3_ = 0;
               while(_loc3_ < crewList.length)
               {
                  if(crewList[_loc3_] is CrewTechnicianlv1 || crewList[_loc3_] is CrewTechnicianlv2)
                  {
                     _loc5_ = false;
                     break;
                  }
                  if(crewList[_loc3_] is CrewTechnicianlv3)
                  {
                     _loc6_++;
                  }
                  _loc3_++;
               }
               if(_loc6_ >= 5 && _loc5_)
               {
                  addNewAchivement(11);
               }
            }
            if(!Achivement.data.trophyList[12])
            {
               _loc5_ = true;
               _loc6_ = 0;
               _loc3_ = 0;
               while(_loc3_ < crewList.length)
               {
                  if(crewList[_loc3_] is CrewCleaningServicelv1 || crewList[_loc3_] is CrewCleaningServicelv2)
                  {
                     _loc5_ = false;
                     break;
                  }
                  if(crewList[_loc3_] is CrewCleaningServicelv3)
                  {
                     _loc6_++;
                  }
                  _loc3_++;
               }
               if(_loc6_ >= 5 && _loc5_)
               {
                  addNewAchivement(12);
               }
            }
            if(!Achivement.data.trophyList[13])
            {
               if(crewList.length >= 12)
               {
                  _loc5_ = true;
                  _loc3_ = 0;
                  while(_loc3_ < crewList.length)
                  {
                     if(crewList[_loc3_].nextUpgrade)
                     {
                        _loc5_ = false;
                        break;
                     }
                     _loc3_++;
                  }
                  if(_loc5_)
                  {
                     addNewAchivement(13);
                  }
               }
            }
            if(!Achivement.data.trophyList[14])
            {
               _loc7_ = 0;
               _loc3_ = 0;
               while(_loc3_ < tenantList.length)
               {
                  if(userinterface.btnArr.indexOf(tenantList[_loc3_].name) >= 0 && userinterface.btnArr.indexOf(tenantList[_loc3_].name) < 9)
                  {
                     _loc7_++;
                  }
                  _loc3_++;
               }
               if(_loc7_ >= 5)
               {
                  addNewAchivement(14);
               }
            }
            if(!Achivement.data.trophyList[15])
            {
               if(restroomList.length >= 5)
               {
                  addNewAchivement(15);
               }
            }
            if(!Achivement.data.trophyList[16])
            {
               _loc7_ = 0;
               _loc3_ = 0;
               while(_loc3_ < tenantList.length)
               {
                  if(userinterface.btnArr.indexOf(tenantList[_loc3_].name) >= 9 && userinterface.btnArr.indexOf(tenantList[_loc3_].name) < 15)
                  {
                     _loc7_++;
                  }
                  _loc3_++;
               }
               if(_loc7_ >= 5)
               {
                  addNewAchivement(16);
               }
            }
            if(!Achivement.data.trophyList[17])
            {
               _loc8_ = new Array();
               _loc3_ = 0;
               while(_loc3_ < tenantList.length)
               {
                  if(userinterface.btnArr.indexOf(tenantList[_loc3_].name) >= 0)
                  {
                     if(_loc8_.indexOf(tenantList[_loc3_].name) < 0)
                     {
                        _loc8_.push(tenantList[_loc3_].name);
                     }
                  }
                  _loc3_++;
               }
               if(hall != null && _loc8_.length >= userinterface.btnArr.length)
               {
                  addNewAchivement(17);
               }
            }
            if(!Achivement.data.trophyList[19])
            {
               if(numberUpset >= 10)
               {
                  addNewAchivement(19);
               }
            }
            if(!Achivement.data.trophyList[20])
            {
               _loc9_ = 0;
               _loc3_ = 0;
               while(_loc3_ < tenantList.length)
               {
                  if(tenantList[_loc3_].isBroken)
                  {
                     _loc9_++;
                  }
                  _loc3_++;
               }
               if(_loc9_ >= 3)
               {
                  addNewAchivement(20);
               }
            }
         }
      }
      
      public function DirtyProgress(param1:Event) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         _loc2_ = 0;
         while(_loc2_ < gameSpeed)
         {
            --dirtyDelay;
            if(dirtyDelay <= 0)
            {
               dirtyDelay = 24;
               _loc3_ = 0;
               while(_loc3_ < visitorParent.numChildren)
               {
                  _loc4_ = visitorParent.getChildAt(_loc3_);
                  if(crewList.indexOf(_loc4_) < 0 && banditList.indexOf(_loc4_) < 0 && !_loc4_.visiting)
                  {
                     if(_loc4_.floorPos == ground && _loc4_.worldX > mallLeft + 35 && _loc4_.worldX < mallLeft + mallWidth - 35 || _loc4_.floorPos != ground)
                     {
                        _loc5_ = Math.random() * 10;
                        if((_loc6_ = Math.random() * 100) < _loc5_)
                        {
                           (_loc7_ = new fx_trash()).trashLevel = Math.random() * 2 + 2;
                           _loc7_.ground = _loc4_.floorPos;
                           _loc7_.worldX = _loc4_.worldX;
                           if(_loc7_.ground == ground)
                           {
                              _loc7_.worldY = _loc7_.ground.worldY - _loc7_.ground.height;
                           }
                           else
                           {
                              _loc7_.worldY = _loc7_.ground.worldY;
                           }
                           _loc7_.x = _loc7_.worldX - cameraX;
                           _loc7_.y = _loc7_.worldY - cameraY;
                           dirtyParent.addChild(_loc7_);
                           _loc8_ = 0;
                           _loc9_ = false;
                           while(_loc8_ < dirtyParent.numChildren && !_loc9_)
                           {
                              if((_loc10_ = dirtyParent.getChildAt(_loc8_)) != _loc7_)
                              {
                                 if(_loc7_.hitTestObject(_loc10_))
                                 {
                                    if(_loc10_.trashLevel < 100)
                                    {
                                       _loc10_.trashLevel += _loc7_.trashLevel;
                                    }
                                    if(_loc10_.trashLevel > 100)
                                    {
                                       _loc10_.trashLevel = 100;
                                    }
                                    _loc9_ = true;
                                 }
                              }
                              _loc8_++;
                           }
                           if(_loc9_)
                           {
                              dirtyParent.removeChild(_loc7_);
                           }
                        }
                     }
                  }
                  _loc3_++;
               }
            }
            _loc2_++;
         }
      }
   }
}
