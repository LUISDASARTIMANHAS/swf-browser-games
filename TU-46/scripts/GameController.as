package
{
   import com.pavelzuk.components.Transition;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Stage;
   import flash.events.ContextMenuEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   import flash.net.SharedObject;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.ui.ContextMenu;
   import flash.ui.ContextMenuItem;
   import flash.utils.getDefinitionByName;
   
   public class GameController
   {
      
      public static var timeline:MovieClip;
      
      public static var musicTransform:SoundTransform;
      
      public static var allowedSite:String = "armorgames.com";
      
      public static var transition:Transition;
      
      public static var mute:Boolean = false;
      
      public static var soundTransform:SoundTransform;
      
      public static var gameName:String = "planegame";
      
      public static var musicChannel:SoundChannel;
      
      public static var myContextMenu:ContextMenu;
      
      public static var local:Boolean = true;
      
      public static var soundChannel:SoundChannel;
      
      public static var stage:Stage;
       
      
      public function GameController()
      {
         super();
      }
      
      public static function playMusic(param1:String) : void
      {
         musicChannel.stop();
         var _loc2_:Class = getDefinitionByName(param1) as Class;
         var _loc3_:Sound = new _loc2_();
         musicChannel = _loc3_.play(0,int.MAX_VALUE);
         if(mute)
         {
            setMusicVolume(0);
         }
      }
      
      public static function getSharedObject() : SharedObject
      {
         return SharedObject.getLocal("so_tu46");
      }
      
      public static function isLocked() : Boolean
      {
         var _loc3_:Bitmap = null;
         var _loc4_:TextFormat = null;
         var _loc5_:TextField = null;
         if(local)
         {
            return false;
         }
         var _loc1_:Boolean = false;
         var _loc2_:String = String(timeline.loaderInfo.url.split("/")[2]);
         if(_loc2_.indexOf(allowedSite) == _loc2_.length - allowedSite.length)
         {
            _loc1_ = false;
         }
         else if(_loc2_.indexOf(allowedSite) != _loc2_.length - allowedSite.length)
         {
            _loc1_ = true;
         }
         if(_loc1_)
         {
            _loc3_ = new Bitmap(new BitmapData(stage.stageWidth,stage.stageHeight,false,0));
            stage.addChild(_loc3_);
            (_loc4_ = new TextFormat()).font = "Verdana";
            _loc4_.size = 17;
            _loc4_.color = 16777215;
            _loc4_.align = TextFormatAlign.CENTER;
            _loc4_.bold = true;
            (_loc5_ = new TextField()).defaultTextFormat = _loc4_;
            _loc5_.text = String("GAME LOCKED \n www." + allowedSite);
            _loc5_.width = stage.stageWidth;
            _loc5_.x = 0;
            _loc5_.y = stage.stageHeight / 2;
            _loc5_.selectable = false;
            stage.addChild(_loc5_);
            return true;
         }
         return false;
      }
      
      public static function stopAllSounds() : void
      {
         SoundMixer.stopAll();
      }
      
      public static function setContextMenu(param1:DisplayObjectContainer) : void
      {
         myContextMenu = new ContextMenu();
         myContextMenu.hideBuiltInItems();
         var _loc2_:ContextMenuItem = new ContextMenuItem("Play More Games");
         var _loc3_:ContextMenuItem = new ContextMenuItem("TU - 46 © 2011",true,false);
         myContextMenu.customItems.push(_loc2_,_loc3_);
         _loc2_.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,gameBy);
         param1.contextMenu = myContextMenu;
      }
      
      public static function gameBy(param1:ContextMenuEvent) : void
      {
         navigateToURL(new URLRequest("http://www.armorgames.com/"),"_blank");
      }
      
      public static function setMusicVolume(param1:Number) : void
      {
         musicTransform.volume = param1;
         musicChannel.soundTransform = musicTransform;
      }
      
      public static function playSound(param1:String) : void
      {
         if(mute)
         {
            return;
         }
         var _loc2_:Class = getDefinitionByName(param1) as Class;
         var _loc3_:Sound = new _loc2_();
         soundChannel = _loc3_.play();
      }
      
      public static function setup(param1:MovieClip, param2:Stage, param3:Transition) : *
      {
         timeline = param1;
         stage = param2;
         transition = param3;
         soundChannel = new SoundChannel();
         soundTransform = new SoundTransform();
         musicChannel = new SoundChannel();
         musicTransform = new SoundTransform();
         setContextMenu(timeline);
      }
   }
}
