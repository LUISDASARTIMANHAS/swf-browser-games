package
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Stage;
   import flash.system.Capabilities;
   import flash.system.fscommand;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class Debug
   {
      
      private static var m_asserts:Array;
      
      private static var m_sendDebugInfo:Boolean = true;
      
      private static var m_onAssertCallback:Function = null;
      
      private static const MAX_NUMBER_OF_ASSERTIONS_PER_FRAME:int = 5;
      
      private static var m_overflowLimiter:int = MAX_NUMBER_OF_ASSERTIONS_PER_FRAME;
       
      
      public function Debug()
      {
         super();
      }
      
      public static function EnableDebugInfo(param1:Boolean) : void
      {
         m_sendDebugInfo = param1;
      }
      
      public static function set onAssertCallback(param1:Function) : void
      {
         m_onAssertCallback = param1;
      }
      
      public static function Out(param1:String) : void
      {
         if(m_sendDebugInfo == true)
         {
            if(Capabilities.isDebugger == false)
            {
               fscommand("trace",param1);
            }
         }
      }
      
      public static function Assert(param1:Boolean, param2:String, param3:String = null) : Boolean
      {
         var _loc4_:* = null;
         var _loc5_:String = null;
         if(param1 != true)
         {
            if(m_overflowLimiter-- < 0)
            {
               return true;
            }
            _loc4_ = new String("");
            _loc5_ = new String("");
            _loc4_ = "***********************************************************\n " + "ASSERT FAILED!!\n " + param2 + "\n" + param3 + "\n" + GetStackTrace() + "\n" + "***********************************************************\n ";
            if(m_asserts == null)
            {
               m_asserts = new Array();
            }
            m_asserts.push(_loc4_);
            if(m_onAssertCallback != null)
            {
               m_onAssertCallback(param2,param3,GetStackTrace());
            }
            Debug.Out(_loc4_);
            return true;
         }
         return false;
      }
      
      public static function NotifyError(param1:String) : void
      {
         if(m_onAssertCallback != null)
         {
            m_onAssertCallback(param1,null,GetStackTrace(),true);
         }
      }
      
      public static function GetStackTrace() : String
      {
         if(Capabilities.isDebugger != true)
         {
            return "";
         }
         try
         {
            throw new Error();
         }
         catch(e:Error)
         {
            return FilterStackTrace(e.getStackTrace());
         }
      }
      
      public static function HasAsserts() : Boolean
      {
         return m_asserts != null;
      }
      
      public static function ClearAsserts() : void
      {
         m_asserts = null;
         m_overflowLimiter = MAX_NUMBER_OF_ASSERTIONS_PER_FRAME;
      }
      
      public static function ShowAsserts(param1:Stage) : void
      {
         var _loc2_:TextField = null;
         var _loc4_:String = null;
         if(m_onAssertCallback != null)
         {
            return;
         }
         if(m_asserts == null || m_asserts.length == 0)
         {
            if(_loc2_ != null)
            {
               _loc2_.visible = false;
            }
            return;
         }
         _loc2_ = param1.getChildByName("AssertBox") as TextField;
         if(_loc2_ == null)
         {
            _loc2_ = new TextField();
            _loc2_.autoSize = TextFieldAutoSize.LEFT;
            _loc2_.width = param1.stageWidth - 1;
            _loc2_.textColor = 16711680;
            _loc2_.backgroundColor = 0;
            _loc2_.background = true;
            _loc2_.wordWrap = true;
            _loc2_.text = "";
            _loc2_.name = "AssertBox";
            do
            {
               _loc2_.border = true;
               _loc2_.borderColor = 16711680;
            }
            while(false);
            
         }
         _loc2_.text = "";
         var _loc3_:int = 0;
         while(_loc3_ < m_asserts.length)
         {
            _loc4_ = String(m_asserts[_loc3_]);
            _loc2_.appendText(_loc4_ + "\n");
            _loc3_++;
         }
         _loc2_.visible = true;
         param1.addChild(_loc2_);
         m_overflowLimiter = MAX_NUMBER_OF_ASSERTIONS_PER_FRAME;
      }
      
      public static function FilterStackTrace(param1:String) : String
      {
         var _loc6_:String = null;
         var _loc2_:Array = param1.split("\n");
         var _loc3_:RegExp = /\w:[\\\/]([\w-]+[\\\/])*\w+.as/ig;
         var _loc4_:* = new String("\n");
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc6_ = (_loc6_ = (_loc6_ = String(_loc2_[_loc5_])).replace(_loc3_,"")).replace("[:"," [line:");
            _loc4_ = _loc4_ + _loc6_ + "\n";
            _loc5_++;
         }
         return _loc4_;
      }
      
      public static function GetNumberOfAsserts() : int
      {
         if(m_asserts == null)
         {
            return 0;
         }
         return m_asserts.length;
      }
      
      public static function GetAssertsAsString() : String
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc1_:String = "";
         if(m_asserts != null)
         {
            _loc2_ = 0;
            while(_loc2_ < m_asserts.length)
            {
               _loc3_ = String(m_asserts[_loc2_]);
               _loc1_ += _loc3_ + "\n";
               _loc2_++;
            }
         }
         return _loc1_;
      }
      
      public static function CountDisplayObjects(param1:DisplayObjectContainer, param2:Boolean = true) : int
      {
         var _loc5_:DisplayObject = null;
         var _loc3_:int = param1.numChildren;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         while(_loc6_ < _loc3_)
         {
            if((_loc5_ = param1.getChildAt(_loc6_)) is DisplayObjectContainer)
            {
               if(param2 == true)
               {
                  if(_loc5_.visible == false)
                  {
                     loop1:
                     while(true)
                     {
                        _loc6_++;
                        if(true)
                        {
                           break;
                        }
                        while(true)
                        {
                           continue loop1;
                        }
                     }
                     continue;
                     addr57:
                  }
                  else
                  {
                     addr46:
                     _loc4_ += CountDisplayObjects(_loc5_ as DisplayObjectContainer);
                     if(param2 == true)
                     {
                        if(_loc5_.visible == true)
                        {
                           _loc4_++;
                        }
                        §§goto(addr60);
                     }
                     else
                     {
                        _loc4_++;
                     }
                  }
                  while(true)
                  {
                     §§goto(addr57);
                  }
               }
            }
            §§goto(addr46);
         }
         return _loc4_;
      }
      
      public static function Encode(param1:String) : String
      {
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc2_:String = "1234567890qwertzuiopasdfghjklyxcvbnm";
         var _loc3_:* = "";
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = param1.charAt(_loc4_);
            if((_loc6_ = _loc2_.indexOf(_loc5_)) < 0)
            {
               _loc3_ += "-";
            }
            else
            {
               if(--_loc6_ < 0)
               {
                  _loc6_ = _loc2_.length - 1;
               }
               _loc3_ += _loc2_.charAt(_loc6_);
            }
            _loc4_++;
         }
         return _loc3_.toUpperCase();
      }
   }
}
