package  {
	import flash.display.Sprite;
	import canshu;
	import Math;
	import gongju;
	import flash.events.KeyboardEvent;//引用键盘事件
	import flash.ui.Keyboard ;//引用键盘事件监听器
	import flash.utils.Timer;//引用计时器【控制蛇的运动速度】
	import flash.events.TimerEvent;//引用计时器事件监听器
	
	public class she extends Sprite{
		var morensudu = 88;
		var jiasusudu = 30;
		var t = new Timer(morensudu);//蛇运动计时器
		var cs = 0;
		var gj = new gongju();
		var dead = 0;  // 死亡状态【默认没死】
		var fangxiangx = -1;//控制蛇初始方向X【左右】
		var fangxiangy = 0 ;//控制蛇初始方向Y【上下】
		var fangxiangsz = [[fangxiangx, fangxiangy]];//蛇的方向控制的缓冲区数组【解决】
		var yundongfx = [];  // 控制蛇每一块运动的方向的数组
		
		var shechangdu = 5;  //蛇初始长度
		var cswz_h = 10;  //蛇头的初始位置【横】
        var cswz_s = 2;  //蛇头的初始位置【竖】
		var dt1 = 0;

		public function she(quanjucs, dt, st) {
			cs = quanjucs;
			dt1 = dt;
			huashe();
			t.addEventListener(TimerEvent.TIMER, yundong);
			st.addEventListener(KeyboardEvent.KEY_DOWN, fangxiang);
			st.addEventListener(KeyboardEvent.KEY_UP, songkai);
		}
		
		
		public function chishiwu(){  // 吃食物*
			var x1 = cs.shiwu.x;//食物的X
			var y1 = cs.shiwu.y;//食物的Y
			var shesztoux = cs.shesz[0].x;//蛇头的X
			var shesztouy = cs.shesz[0].y;//蛇头的Y
			if((shesztoux - x1 == cs.bc) && (shesztouy==y1) && (gj.szxiangdeng(yundongfx[0], [-1, 0]))||
			   (x1 - shesztoux == cs.bc) && (shesztouy==y1) && (gj.szxiangdeng(yundongfx[0], [1, 0]))||
			   (shesztouy - y1 == cs.bc) && (shesztoux==x1) && (gj.szxiangdeng(yundongfx[0], [0, -1]))||
			   (y1 - shesztouy == cs.bc) && (shesztoux==x1) && (gj.szxiangdeng(yundongfx[0], [0, 1]))){//从右往左吃
				// 尾巴向下，食物补上边；尾巴向左，食物补右边，尾巴向右，食物补左边，尾巴向上，食物补下边
				var wbfx_x = yundongfx[yundongfx.length-1][0];
				//获取蛇尾水平运动方向
				var wbfx_y = yundongfx[yundongfx.length-1][1];
				//获取蛇尾竖直运动方向
				var wbwz_x = cs.shesz[cs.shesz.length-1].x;//获取蛇尾实际水平坐标
				var wbwz_y = cs.shesz[cs.shesz.length-1].y;//获取蛇尾实际竖直坐标      
				cs.shiwu.x = wbwz_x  - wbfx_x * cs.bc;//定位食物的X
				cs.shiwu.y = wbwz_y  - wbfx_y * cs.bc;//定位食物的Y
				yundongfx.push([wbfx_x, wbfx_y]);//同步食物和蛇的方向坐标
				cs.shiwu.shezhixk(cs.morenxk);//设置食物线宽
				cs.shesz.push(cs.shiwu);//把食物放进蛇数组
				cs.chidao = 1;//食物状态【吃到】
				cs.fenshu = cs.fenshu + 1;
				dt1.xianshi("得分："+cs.fenshu);
				dt1.huashiwu();//画食物 
			}
		}
		
		
		public function songkai(shijian){
			if(shijian.keyCode == Keyboard.SHIFT && dead != 1){
				t.removeEventListener(TimerEvent.TIMER, yundong);
				t = new Timer(morensudu);//创建新的计时器
				t.start();//启动新的计时器
				t.addEventListener(TimerEvent.TIMER, yundong);
				//把运动函数绑定到新计时器上
			}
		}

		public function huashe(){   // 画蛇
			var i=0;//循环变量
			var f1;//方块
			var chushix = cs.zsh_x + cswz_h * cs.bc - cs.bc;//控制蛇初始位置X
			var chushiy = cs.zsh_y + cswz_s * cs.bc - cs.bc;//控制蛇初始位置Y
			for(i=0;i<shechangdu;i=i+1){//循环【画蛇身】
				f1 = new fk(gj.suijishu(0, Math.pow(14, 6)), cs.bc, cs.morenxk);//设置颜色大小
				this.addChild(f1);//把实物对象（方块）追加到舞台上
				cs.shesz.push(f1);//蛇向尾部追加一个方块
				yundongfx.push([fangxiangx, fangxiangy]);//追加每块蛇身的方向
			}
			
			for(i=0;i<cs.shesz.length;i=i+1){//循环【控制蛇身排列】（水平方向）
				cs.shesz[i].x = chushix + cs.bc * i;
				cs.shesz[i].y = chushiy;
			}
		}
		
		public function fangxiang(shijian){//方向+移动
			if(shijian.keyCode == Keyboard.SPACE){//控制开始
				if(dead == 0){
					//huashiwu(); // 画食物
					t.start();
					dt1.t1.start();
				}
			}
			if(shijian.keyCode == Keyboard.Q){//控制暂停
				t.stop();
				dt1.t1.stop();
			}
			if(shijian.keyCode == Keyboard.SHIFT){
				t.removeEventListener(TimerEvent.TIMER, yundong);
				if(dead == 0){
					t = new Timer(jiasusudu);//创建新的计时器
					t.start();//启动新的计时器
					t.addEventListener(TimerEvent.TIMER, yundong);
					//把运动函数绑定到新计时器上
				}
			}
			if(shijian.keyCode == Keyboard.UP){//移动【上】
				if(fangxiangsz[fangxiangsz.length-1][0] != 0){
					//方向数组最后一个元素的Y       二维数组的X
					fangxiangsz.push([0, -1]);//方向数组向右追加一个数组
				}
			}
			if(shijian.keyCode == Keyboard.DOWN){//移动【下】
				if(fangxiangsz[fangxiangsz.length-1][0] != 0){
					//方向数组最后一个元素的Y       二维数组X
					fangxiangsz.push([0, 1]);//方向数组向右追加一个数组
				}
			}
			if(shijian.keyCode == Keyboard.LEFT){//移动【右】
				if(fangxiangsz[fangxiangsz.length-1][1] != 0){
					//方向数组最后一个元素的Y      二维数组的Y
					fangxiangsz.push([-1, 0]);//方向数组向右追加一个数组
				}
			}
			if(shijian.keyCode == Keyboard.RIGHT){//移动【左】
				if(fangxiangsz[fangxiangsz.length-1][1] != 0){
					//方向数组最后一个元素的Y       二维数组的Y
					fangxiangsz.push([1, 0]);//方向数组向右追加一个数组
				}
			}
		}
		
		public function yundong(shijian){//运动
			var j = 0;
			if(fangxiangsz.length>1){//判断数组元素个数
			//括号内；如果数组元素等于一保持当前方向
			//否则删除已执行的方向数组
				fangxiangsz.shift();//左减少
			}
			fangxiangx = fangxiangsz[0][0];//取方向数组（蛇头）的X
			fangxiangy = fangxiangsz[0][1];//取方向数组（蛇头）的Y
			yundongfx.shift();//去掉蛇头初始方向
			yundongfx.unshift([fangxiangx, fangxiangy]);//给定蛇头新方向 
			if(gameover()){//判断游戏结束
				t.stop();//计时器停止
				dt1.t1.stop();
				dt1.showover();
			}
			else{
				chishiwu();//【吃食物】此函数放在这里是为了解决食物吃的问题，先检测蛇头方向再判断吃食物
				var i=0;//创建i变量，用于构造循环变量
				for(i=0;i<cs.shesz.length;i=i+1){//循环蛇每一块的移动位置
					cs.shesz[i].x = cs.shesz[i].x + yundongfx[i][0] * cs.bc;//蛇每一块移动位置X
					cs.shesz[i].y = cs.shesz[i].y + yundongfx[i][1] * cs.bc;//蛇每一块移动位置Y
					if(cs.shesz[i].x < cs.zsh_x){
						cs.shesz[i].x = cs.shesz[i].x + cs.hgzs * cs.bc;
					}
					if(cs.shesz[i].x > cs.zsh_x + cs.hgzs * cs.bc - cs.bc){
						cs.shesz[i].x = cs.shesz[i].x - cs.hgzs * cs.bc;
					}
					if(cs.shesz[i].y < cs.zsh_y){
						cs.shesz[i].y = cs.shesz[i].y + cs.sgzs * cs.bc;
					}
					if(cs.shesz[i].y > cs.zsh_y + cs.sgzs * cs.bc - cs.bc){
						cs.shesz[i].y = cs.shesz[i].y - cs.sgzs * cs.bc; 
					}
					for(j=0;j<cs.csm.length;j=j+1){//循环穿过传送门
						if(cs.shesz[i].x == cs.zsh_x + cs.csm[j][0][0] * cs.bc - cs.bc &&
						   cs.shesz[i].y == cs.zsh_y + cs.csm[j][0][1] * cs.bc - cs.bc){
							cs.shesz[i].x = cs.zsh_x + cs.csm[j][1][0] * cs.bc - cs.bc;
							cs.shesz[i].y = cs.zsh_y + cs.csm[j][1][1] * cs.bc - cs.bc;
						}
						else if(cs.shesz[i].x == cs.zsh_x + cs.csm[j][1][0] * cs.bc - cs.bc &&
						   cs.shesz[i].y == cs.zsh_y + cs.csm[j][1][1] * cs.bc - cs.bc){
							cs.shesz[i].x = cs.zsh_x + cs.csm[j][0][0] * cs.bc - cs.bc;
							cs.shesz[i].y = cs.zsh_y + cs.csm[j][0][1] * cs.bc - cs.bc;
						}
					}
				}
				fangxiangchuandao();//方向传导
			}
		}

		public function fangxiangchuandao(){//方向传导
			yundongfx.pop();//运动方向向右减少（去除末尾的XY）
			yundongfx.unshift(yundongfx[0]);//运动方向向左追加（替换第一组元素）
		}

		public function gameover(){ // 检查游戏结束
			var m=0;
			var xstart = 0;
			var xend = 0;
			var ystart = 0;
			var yend = 0;
			var a=0;
			var b=0;
			for(m=0;m<cs.zhaw.length;m=m+1){
				xstart = cs.zhaw[m][0][0];
				ystart = cs.zhaw[m][0][1];
				xend = cs.zhaw[m][1][0];
				yend = cs.zhaw[m][1][1];;
				for(a=xstart; a<=xend; a=a+1){
					for(b=ystart; b<=yend; b=b+1){
						if((cs.shesz[0].x == cs.zsh_x + a * cs.bc - cs.bc) && (cs.shesz[0].y == cs.zsh_y + b * cs.bc - cs.bc)){
							dead = 1;
							return true;
						}
					}
				}
			}
			
			var i=0;//辅助判断
			for(i=1;i<cs.shesz.length;i=i+1){
				if((cs.shesz[0].x == (cs.shesz[i].x + cs.bc))&&(cs.shesz[0].y == cs.shesz[i].y) && (gj.szxiangdeng(yundongfx[0], [-1, 0]))){
					dead = 1;
					return true;
				}//左撞自己
				if((cs.shesz[0].x == (cs.shesz[i].x - cs.bc))&&(cs.shesz[0].y == cs.shesz[i].y) && (gj.szxiangdeng(yundongfx[0], [1, 0]))){
					dead = 1;
					return true;
				}//右撞自己
				if((cs.shesz[0].y == (cs.shesz[i].y + cs.bc))&&(cs.shesz[0].x == cs.shesz[i].x) &&  (gj.szxiangdeng(yundongfx[0], [0, -1]))){
					dead = 1;
					return true;
				}//上撞自己
				if((cs.shesz[0].y == (cs.shesz[i].y - cs.bc))&&(cs.shesz[0].x == cs.shesz[i].x) &&  (gj.szxiangdeng(yundongfx[0], [0, 1]))){
					dead = 1;
					return true;
				}//下撞墙
			}
		}
	}
}
