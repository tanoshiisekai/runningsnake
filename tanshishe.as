package  {
	import flash.display.Sprite;
    import fk;
	import canshu;
	import ditu;
	import gongju;

	import flash.events.KeyboardEvent;//引用键盘事件
	import flash.ui.Keyboard ;//引用键盘事件监听器
	import flash.utils.Timer;//引用计时器【控制蛇的运动速度】
	import flash.events.TimerEvent;//引用计时器事件监听器
	import Math;//引用数学工具【产生随机数】
	import flash.display.StageAlign;//舞台对齐方式
	import flash.events.Event;//事件处理集合【改变大小】
	
	import flash.text.TextField;   // 文本框
	import flash.text.TextFormat;   // 文本格式
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.FullScreenEvent;
	
	import flash.system.fscommand;
	
    public class tanshishe extends Sprite{
		var cs = new canshu();
		var gj = new gongju();
		
		public function tanshishe() {
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.RESIZE, zishiying);
			stage.dispatchEvent(new Event(Event.RESIZE));
		}
		
		public function zishiying(event){//自适应
			gj.kaishi(stage);
			fscommand("fullscreen", "true");
            fscommand("allowscale", "false");
			stage.removeEventListener(Event.RESIZE, zishiying);//关闭自适应
		}
   }	
}
