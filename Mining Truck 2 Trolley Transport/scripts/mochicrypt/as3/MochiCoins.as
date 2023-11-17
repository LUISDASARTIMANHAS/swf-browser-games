package mochicrypt.as3
{
   public class MochiCoins
   {
      
      public static const STORE_HIDE:String = "StoreHide";
      
      public static const LOGGED_IN:String = "LoggedIn";
      
      public static const NO_USER:String = "NoUser";
      
      public static const PROPERTIES_SIZE:String = "PropertiesSize";
      
      public static const IO_ERROR:String = "IOError";
      
      public static const STORE_ITEMS:String = "StoreItems";
      
      public static var _user_info:Object = null;
      
      public static const USER_INFO:String = "UserInfo";
      
      public static const LOGIN_SHOW:String = "LoginShow";
      
      public static const PROFILE_HIDE:String = "ProfileHide";
      
      public static const STORE_SHOW:String = "StoreShow";
      
      private static var _dispatcher:MochiEventDispatcher = new MochiEventDispatcher();
      
      public static const ITEM_NEW:String = "ItemNew";
      
      public static const ITEM_OWNED:String = "ItemOwned";
      
      public static const PROPERTIES_SAVED:String = "PropertySaved";
      
      public static const WIDGET_LOADED:String = "WidgetLoaded";
      
      public static const ERROR:String = "Error";
      
      public static const LOGGED_OUT:String = "LoggedOut";
      
      public static const PROFILE_SHOW:String = "ProfileShow";
      
      public static const LOGIN_HIDE:String = "LoginHide";
      
      public static const LOGIN_SHOWN:String = "LoginShown";
       
      
      public function MochiCoins()
      {
         super();
      }
      
      public static function getUserInfo() : void
      {
         MochiServices.send("coins_getUserInfo");
      }
      
      public static function showItem(param1:Object = null) : void
      {
         if(!param1 || typeof param1.item != "string")
         {
            trace("ERROR: showItem call must pass an Object with an item key");
            return;
         }
         MochiServices.bringToTop();
         MochiServices.send("coins_showItem",{"options":param1},null,null);
      }
      
      public static function getVersion() : String
      {
         return MochiServices.getVersion();
      }
      
      public static function saveUserProperties(param1:Object) : void
      {
         MochiServices.send("coins_saveUserProperties",param1);
      }
      
      public static function triggerEvent(param1:String, param2:Object) : void
      {
         if(param1 == LOGGED_IN)
         {
            _user_info = param2;
         }
         else if(param1 == LOGGED_OUT)
         {
            _user_info = null;
         }
         _dispatcher.triggerEvent(param1,param2);
      }
      
      public static function removeEventListener(param1:String, param2:Function) : void
      {
         _dispatcher.removeEventListener(param1,param2);
      }
      
      public static function getStoreItems() : void
      {
         MochiServices.send("coins_getStoreItems");
      }
      
      public static function showLoginWidget(param1:Object = null) : void
      {
         MochiServices.setContainer();
         MochiServices.bringToTop();
         MochiServices.send("coins_showLoginWidget",{"options":param1});
      }
      
      public static function addEventListener(param1:String, param2:Function) : void
      {
         _dispatcher.addEventListener(param1,param2);
      }
      
      public static function showStore(param1:Object = null) : void
      {
         MochiServices.bringToTop();
         MochiServices.send("coins_showStore",{"options":param1},null,null);
      }
      
      public static function hideLoginWidget() : void
      {
         MochiServices.send("coins_hideLoginWidget");
      }
      
      public static function getAPIURL() : String
      {
         if(!_user_info)
         {
            return null;
         }
         return _user_info.api_url;
      }
      
      public static function getAPIToken() : String
      {
         if(!_user_info)
         {
            return null;
         }
         return _user_info.api_token;
      }
      
      public static function showVideo(param1:Object = null) : void
      {
         if(!param1 || typeof param1.item != "string")
         {
            trace("ERROR: showVideo call must pass an Object with an item key");
            return;
         }
         MochiServices.bringToTop();
         MochiServices.send("coins_showVideo",{"options":param1},null,null);
      }
   }
}
