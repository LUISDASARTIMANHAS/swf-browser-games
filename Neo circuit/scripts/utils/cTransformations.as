package utils
{
   public class cTransformations
   {
      
      private static var m_mat:cMatrix2D = new cMatrix2D();
       
      
      public function cTransformations()
      {
         super();
      }
      
      public static function pointToWorldSpace(param1:cVector2, param2:cVector2, param3:cVector2, param4:cVector2) : cVector2
      {
         var _loc5_:cVector2 = param1.copy();
         m_mat.set();
         m_mat.rotateVector(param2,param3);
         m_mat.translate(param4.x,param4.y);
         m_mat.transformVector(_loc5_);
         return _loc5_;
      }
      
      public static function vectorToWorldSpace(param1:cVector2, param2:cVector2, param3:cVector2) : cVector2
      {
         var _loc4_:cVector2 = param1.copy();
         m_mat.set();
         m_mat.rotateVector(param2,param3);
         m_mat.transformVector(_loc4_);
         return _loc4_;
      }
      
      public static function pointToLocalSpace(param1:cVector2, param2:cVector2, param3:cVector2, param4:cVector2) : cVector2
      {
         var _loc5_:cVector2 = param1.copy();
         var _loc6_:Number = -param4.dotOf(param2);
         var _loc7_:Number = -param4.dotOf(param3);
         m_mat.set(param2.x,param3.x,0,param2.y,param3.y,0,_loc6_,_loc7_);
         m_mat.transformVector(_loc5_);
         return _loc5_;
      }
      
      public static function vectorToLocalSpace(param1:cVector2, param2:cVector2, param3:cVector2) : cVector2
      {
         var _loc4_:cVector2 = param1.copy();
         m_mat.set(param2.x,param3.x,0,param2.y,param3.y);
         m_mat.transformVector(_loc4_);
         return _loc4_;
      }
      
      public static function rotateAroundOrigin(param1:cVector2, param2:Number) : void
      {
         m_mat.set();
         m_mat.rotate(param2);
         m_mat.transformVector(param1);
      }
      
      public static function createWhiskers(param1:int, param2:Number, param3:Number, param4:cVector2, param5:cVector2) : Array
      {
         var _loc8_:cVector2 = null;
         var _loc6_:Number = param3 / (param1 - 1);
         var _loc7_:Array = [];
         var _loc9_:Number = -param3 * 0.5;
         var _loc10_:int = param1;
         while(--_loc10_ >= 0)
         {
            _loc8_ = param4;
            cTransformations.rotateAroundOrigin(_loc8_,_loc9_);
            _loc8_.multiply(param2);
            param5.add(_loc8_);
            do
            {
               _loc7_.push(param5);
               _loc9_ += _loc6_;
            }
            while(false);
            
         }
         return _loc7_;
      }
   }
}
