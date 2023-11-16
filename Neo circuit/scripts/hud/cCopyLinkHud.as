package hud
{
   import com.greensock.TweenLite;
   import org.flixel.FlxG;
   import org.flixel.FlxGroup;
   import org.flixel.FlxSprite;
   import org.flixel.FlxText;
   
   public class cCopyLinkHud extends FlxGroup
   {
      
      private static const FADEIN_TIME:Number = 0.25;
      
      private static const FONT_COLOR:int = 14216098;
      
      private static const FONT_SIZE:int = 16;
       
      
      private var m_textBox:FlxSprite;
      
      private var m_textField:FlxText;
      
      public function cCopyLinkHud()
      {
         super();
         this.create();
      }
      
      public function show(param1:String) : void
      {
         FlxG.mouse.reset();
         this.m_textBox.visible = true;
         this.m_textField.visible = true;
         this.m_textField.text = param1;
         this.m_textField.textField.selectable = true;
         FlxG.stage.addChild(this.m_textField.textField);
         TweenLite.to(this.m_textBox,FADEIN_TIME,{"alpha":1});
         TweenLite.to(this.m_textField.textField,FADEIN_TIME,{"alpha":1});
      }
      
      override public function update() : void
      {
         if(!visible)
         {
            return;
         }
         if(FlxG.mouse.justReleased() && !this.m_textBox.overlapsPoint(FlxG.mouse))
         {
            TweenLite.to(this.m_textBox,FADEIN_TIME,{"alpha":0});
            TweenLite.to(this.m_textField.textField,FADEIN_TIME,{
               "alpha":0,
               "onComplete":this.hide
            });
         }
         super.update();
      }
      
      public function hide() : void
      {
         if(!this.m_textBox.visible)
         {
            return;
         }
         FlxG.stage.removeChild(this.m_textField.textField);
         this.m_textBox.visible = false;
         this.m_textField.visible = false;
      }
      
      private function create() : void
      {
         this.m_textBox = new FlxSprite();
         this.m_textBox.loadGraphic(NeoCircuit.GFX.ImgTutorialGui);
         this.m_textBox.scrollFactor = cObjectManager.ZERO_FLXPOINT;
         this.m_textBox.x = FlxG.width * 0.5 - this.m_textBox.width * 0.5;
         this.m_textBox.y = FlxG.height * 0.5 - this.m_textBox.height * 0.5;
         this.m_textBox.alpha = 0;
         this.m_textBox.visible = false;
         add(this.m_textBox);
         this.m_textField = new FlxText(this.m_textBox.x,this.m_textBox.y + 60,this.m_textBox.width - 120);
         this.m_textField.setFormat("system",FONT_SIZE,FONT_COLOR,"center");
         this.m_textField.antialiasing = false;
         this.m_textField.scrollFactor = cObjectManager.ZERO_FLXPOINT;
         this.m_textField.textField.wordWrap = true;
         this.m_textField.textField.selectable = true;
         this.m_textField.textField.alpha = 0;
         this.m_textField.visible = false;
         this.m_textField.textField.x = this.m_textBox.x + 60;
         this.m_textField.textField.y = this.m_textBox.y + 100;
      }
   }
}
