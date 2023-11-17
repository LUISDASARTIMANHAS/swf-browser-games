package
{
   import flash.display.DisplayObject;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import uk.co.kempt.translation.TranslationEngine;
   
   public class KemptTrans extends MovieClip
   {
       
      
      public function KemptTrans()
      {
         super();
         this.searchForLabels();
         this.searchForText();
      }
      
      public static function getTranslation(param1:String) : String
      {
         var pStringID:String = param1;
         try
         {
            return TranslationEngine.instance.getTranslation(pStringID);
         }
         catch(e:Error)
         {
            trace("KemptTrans> " + e.message);
         }
         return null;
      }
      
      private function searchForLabels() : void
      {
         var _loc4_:FrameLabel = null;
         var _loc5_:String = null;
         var _loc6_:FrameLabel = null;
         var _loc7_:FrameLabel = null;
         var _loc1_:int = int(currentLabels.length);
         var _loc2_:String = TranslationEngine.instance.currentLanguage;
         var _loc3_:String = "en";
         if(_loc2_)
         {
            _loc2_ = String(_loc2_.toLowerCase());
         }
         var _loc8_:int = 0;
         while(_loc8_ < _loc1_)
         {
            if((_loc5_ = String((_loc4_ = currentLabels[_loc8_]).name.toLowerCase())) == _loc2_)
            {
               _loc6_ = _loc4_;
               break;
            }
            if(_loc5_ == _loc3_)
            {
               _loc7_ = _loc4_;
            }
            _loc8_++;
         }
         if(_loc6_)
         {
            gotoAndStop(_loc6_.frame);
         }
         else if(_loc7_)
         {
            gotoAndStop(_loc7_.frame);
         }
         else
         {
            stop();
         }
      }
      
      private function searchForText() : void
      {
         var _loc2_:DisplayObject = null;
         var _loc1_:int = int(numChildren);
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = getChildAt(_loc3_);
            if(_loc2_ is TextField)
            {
               TranslationEngine.instance.translateByInstanceName(_loc2_ as TextField);
            }
            _loc3_++;
         }
      }
   }
}
