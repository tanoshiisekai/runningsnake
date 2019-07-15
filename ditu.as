package {
	import flash.display.Sprite;
	import fk;
	import gongju;
	import flash.events.KeyboardEvent;//引用键盘事件
	import flash.ui.Keyboard ;//引用键盘事件监听器
	import flash.utils.Timer;//引用计时器【控制蛇的运动速度】
	import flash.events.TimerEvent;//引用计时器事件监听器
	import Math;//引用数学工具【产生随机数】
	import flash.display.StageAlign;//舞台对齐方式
	import flash.events.Event;//事件处理集合【改变大小】
	import flash.system.fscommand;
	
	import flash.text.TextField;   // 文本框
	import flash.text.TextFormat;   // 文本格式
	
	import canshu;
	import flash.text.engine.TextBaseline;
	
	
	public class ditu extends Sprite{
		
		var cs = 0;
		var tf = new TextField();
		var tf1 = new TextField();
		var gj = new gongju();
		var t1 = new Timer(8000); //食物消失计时器
		var st1 = 0;
		var tf2 = new TextField();
		
		public function ditu(quanjucs, st){
			cs = quanjucs;
			huawangge();//画网格
			huawaiqiang(); // 画外墙
			huachuansongmen(); // 画传送门
			huazhangaiwu(); // 画障碍物
			xianshi("得分：0");
			bangzhu("空格键开始，方向键控制方向，按住Shift键加速，\n撞红色的墙或自己结束游戏，没有外墙限制，相同颜色成对方块是传送门");
			huashiwu();
			st1 = st;
		}
		
		public function showover(){
			var i=0;
			while(st1.numChildren>0){
				st1.removeChild(st1.getChildAt(st1.numChildren-1));
			}
			tf2.text = "最终得分："+cs.fenshu+"分\n\n按 回车键 重新开始\n\n按 ESC键 退出游戏\n";
			st1.addChild(tf2);
			tf2.x = cs.zsh_x;//文本框的位置X
			tf2.y = cs.zsh_y - 2 * cs.bc;//文本框的位置Y
			tf2.width = cs.bc * cs.hgzs;//文本框大小【可以不被填满】
			tf2.height = 300;
			tf2.textColor = 0xFF0000;//文本颜色
			var tft = new TextFormat();//文本样式
			tft.size = 32;//文字字号
			tft.align = "center";//对齐方式【居中】
			tf2.setTextFormat(tft);
			st1.addEventListener(KeyboardEvent.KEY_DOWN, restart);
		}
		
		
		public function restart(shijian){
			if(shijian.keyCode==Keyboard.ENTER){
				st1.removeEventListener(KeyboardEvent.KEY_DOWN, restart);
				st1.removeChild(tf2);
				st1.align = StageAlign.TOP_LEFT;
				st1.addEventListener(Event.RESIZE, zishiying);
				st1.dispatchEvent(new Event(Event.RESIZE));
			}
			if(shijian.keyCode==Keyboard.ESCAPE){
				fscommand("quit");
			}
		}
		
		public function zishiying(shijian){//自适应
			gj.kaishi(st1);
			fscommand("fullscreen", "true");
			st1.removeEventListener(Event.RESIZE, zishiying);//关闭自适应
		}
		
		public function huawaiqiang(){//画外墙
			graphics.lineStyle(1, 0x999999, 0.5);
			graphics.moveTo(cs.zsh_x, cs.zsh_y);
			graphics.lineTo(cs.zsh_x + cs.hgzs*cs.bc, cs.zsh_y);
			graphics.lineTo(cs.zsh_x + cs.hgzs*cs.bc, cs.zsh_y + cs.sgzs*cs.bc);
			graphics.lineTo(cs.zsh_x, cs.zsh_y + cs.sgzs*cs.bc);
			graphics.lineTo(cs.zsh_x, cs.zsh_y);
		}
		
		public function huawangge(){   //网格
			var hx_y=0;
			var sx_x=0;
			graphics.lineStyle(1,0x999999,0.5);
		    for(hx_y=0;hx_y<=cs.sgzs;hx_y=hx_y+1){
				graphics.moveTo(cs.zsh_x, cs.zsh_y + hx_y*cs.bc);
				graphics.lineTo(cs.zsh_x + cs.hgzs*cs.bc, cs.zsh_y + hx_y*cs.bc);
			}
			for(sx_x=0;sx_x<=cs.hgzs;sx_x=sx_x+1){
				graphics.moveTo(cs.zsh_x + sx_x*cs.bc, cs.zsh_y);
				graphics.lineTo(cs.zsh_x + sx_x*cs.bc, cs.zsh_y + cs.sgzs*cs.bc);
			}
		}
		
		public function huachuansongmen(){ //画传送门
			var i = 0;//创建变量【传送门数组X元素】
			var j = 0;//穿件变量【传送门数组Y元素】
			var csmfk; //穿件变量【传送门数组元素总值】
			for(i=0;i<cs.csm.length;i=i+1){//循环有多少对传送门
				for(j=0;j<2;j=j+1){//循环画每对传送门
					csmfk = new fk(cs.csm[i][2], cs.bc, cs.morenxk);//把传送门方块实例化
					this.addChild(csmfk);//添加到舞台上
					csmfk.x = cs.zsh_x + cs.csm[i][j][0] * cs.bc - cs.bc;//定位X
					csmfk.y = cs.zsh_y + cs.csm[i][j][1] * cs.bc - cs.bc;//定位Y
				}
			}
		}
		
		public function huazhangaiwu(){//画障碍物
			var i=0; //创建变量【映射数组元素】
			var zhawfk=0; //创建障碍物方块变量
			for(i=0;i<cs.zhaw.length;i=i+1){//循环每一堵墙的起点和终点
				var m=0; //创建变量【替代数组中X元素】
				var n=0; //创建空间【替代数组中y元素】
				for(m=cs.zhaw[i][0][0];m<=cs.zhaw[i][1][0];m=m+1){//循环填充方块【横】
					for(n=cs.zhaw[i][0][1];n<=cs.zhaw[i][1][1];n=n+1){//循环填充方块【列】
						zhawfk = new fk(cs.zhaw[i][2], cs.bc, cs.morenxk);//把障碍方块实例化
						this.addChild(zhawfk);//添加到舞台上
						zhawfk.x = cs.zsh_x + m * cs.bc - cs.bc;//定位X
						zhawfk.y = cs.zsh_y + n * cs.bc - cs.bc;//定位Y
					}
				}
			}
		}
		
		
		
		public function xianshi(str){  //显示文字
			this.addChild(tf);//把文本框添加到舞台上
			tf.text = str;//设置文本框【填充文字】
			tf.x = cs.zsh_x;//文本框的位置X
			tf.y = cs.zsh_y - 2 * cs.bc;//文本框的位置Y
			tf.width = cs.bc * cs.hgzs;//文本框大小【可以不被填满】
			tf.textColor = 0x0000FF;//文本颜色
			var tft = new TextFormat();//文本样式
			tft.size = 26;//文字字号
			tft.align = "center";//对齐方式【居中】
			tf.setTextFormat(tft);
		}
		
		public function bangzhu(str){  //显示文字
			this.addChild(tf1);//把文本框添加到舞台上
			tf1.text = str;//设置文本框【填充文字】
			tf1.x = cs.zsh_x;//文本框的位置X
			tf1.y = cs.zsh_y + cs.sgzs * cs.bc + cs.bc;//文本框的位置Y
			tf1.width = cs.bc * cs.hgzs;//文本框大小【可以不被填满】
			tf1.textColor = 0x0000FF;//文本颜色
			var tft1 = new TextFormat();//文本样式
			tft1.size = 26;//文字字号
			tft1.align = "center";//对齐方式【居中】
			tf1.setTextFormat(tft1);//把样式作用在文本框内
		}
		
		public function huashiwu(){  // 画食物
			if(cs.dead==1){
				return true;
			}
			if(cs.shiwu && cs.chidao != 1){//判断食物状态
				this.removeChild(cs.shiwu);//删除食物
			}
			cs.chidao = 0;//恢复食物状态
			cs.shiwu = new fk(gj.suijishu(0, Math.pow(10, 6)), cs.bc, 6);//控制食物颜色，大小
			this.addChild(cs.shiwu);//把实物对象（食物）追加到舞台上
			for(;;){
				cs.shiwu.x = cs.zsh_x + gj.suijishu(0, cs.hgzs-1) * cs.bc;//食物X的随机位置
				cs.shiwu.y = cs.zsh_y + gj.suijishu(0, cs.sgzs-1) * cs.bc;//食物Y的随机位置
				if(jianchaweizhi()){
					break;
				}
			}
			t1.addEventListener(TimerEvent.TIMER, chonghuashiwu);//计时器事件
			t1.start();//计时器开始
		}
		
		public function chonghuashiwu(shijian){//重画食物
			huashiwu();//引用画食物
		}
		
		public function jianchaweizhi(){   // 检查食物位置
			var i=0;
			var j=0;
			for(i=0;i<cs.shesz.length;i=i+1){
				if(cs.shesz[i].x == cs.shiwu.x && cs.shesz[i].y == cs.shiwu.y){//判断食物是否与蛇重合
					return false;
				}
			}
			for(i=0;i<cs.zhaw.length;i=i+1){//循环每一堵墙的起点和终点
				var m=0; //创建变量【替代数组中X元素】
				var n=0; //创建空间【替代数组中y元素】
				for(m=cs.zhaw[i][0][0];m<=cs.zhaw[i][1][0];m=m+1){//循环填充方块【横】
					for(n=cs.zhaw[i][0][1];n<=cs.zhaw[i][1][1];n=n+1){//循环填充方块【列】
						if((cs.shiwu.x == cs.zsh_x + m * cs.bc - cs.bc)&&(cs.shiwu.y == cs.zsh_y + n * cs.bc - cs.bc)){
							return false;
						}
					}
				}
			}
			for(i=0;i<cs.csm.length;i=i+1){
				for(j=0;j<2;j=j+1){//循环画每对传送门
					if((cs.shiwu.x == cs.zsh_x + cs.csm[i][j][0] * cs.bc - cs.bc)&&
					   (cs.shiwu.y == cs.zsh_y + cs.csm[i][j][1] * cs.bc - cs.bc)){
							return false;
					}
				}
			}
			return true;
		}

	}
	
}
