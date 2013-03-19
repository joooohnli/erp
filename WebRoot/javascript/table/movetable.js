//实现表格宽度的随意拖动，引用时不能定义表格总宽度和单元格高度，不能有center、caption定义
var dragenable=0;
var x;//横向轴，网页中的绝对坐标
var y;//纵向轴
var w;//鼠标所在的单元格的宽度
var h;
var obj;
function init() {//鼠标按下左键
  x=(event.clientX+document.body.scrollLeft);//event.clientX:鼠标事件在屏幕的X轴坐标+document.body.scrollLeft:滑动条滑过的距离
  obj=event.srcElement;
  w=event.srcElement.offsetWidth;
  obj.setCapture();
  if(x>event.srcElement.offsetLeft+w-8 && x<event.srcElement.offsetLeft+w) {
    dragenable=1;//在左侧拉动，缩小或合并，合并后不能继续向左
    obj.style.cursor='e-resize';
  } else if(x>=event.srcElement.offsetLeft && x<event.srcElement.offsetLeft+10) {
     //下面语句返回值是字符串类型！！！
     w=obj.parentNode.parentNode.rows[0].cells[obj.cellIndex-1].width;
    dragenable=2;//在右侧拉动，放大，可一直变宽并撑开网页
    obj.style.cursor='w-resize';
  }
 }

function drag() {//鼠标移动
  //下面语句的返回值是字符串！！！
  var pos=(event.clientX+document.body.scrollLeft);
  if(pos>event.srcElement.offsetLeft+event.srcElement.offsetWidth-8 &&
      pos<event.srcElement.offsetLeft+event.srcElement.offsetWidth) {
     event.srcElement.style.cursor='e-resize';//鼠标形状
  } else if(pos>event.srcElement.offsetLeft &&
            pos<event.srcElement.offsetLeft+8) {
    event.srcElement.style.cursor='w-resize';
  } else {
    event.srcElement.style.cursor='default';//鼠标默认状态，无反应
  }
  if(dragenable==1) {
    if(parseInt(pos)-x+parseInt(w)>0) {//pos为鼠标当前相对网页的坐标值，x为鼠标选中时相对网页的坐标值
	var i=obj.cellIndex;
	var j;
	for(j=0;j<obj.parentNode.parentNode.rows.length;j++) {//当鼠标拖动时，当前列的所有行一起动作
	  obj.parentNode.parentNode.rows[j].cells[i].width=pos-x+w;
	}
    } else {
      var i=obj.cellIndex;
      var j;
      for(j=0;j<obj.parentNode.parentNode.rows.length;j++) {
        obj.parentNode.parentNode.rows[j].cells[i].width=1;//nseer:当拖动到单元格两条列线距离是1时，拖动禁止。如果欲做到合并后是一条线并可拉开，优化本段代码
      }
    }

  } else if(dragenable==2) {
     var i=obj.cellIndex;
     if(i>0) { 
     if(parseInt(pos)-x+parseInt(w)>0) {
 	 var j;
	 for(j=0;j<obj.parentNode.parentNode.rows.length;j++) {
          obj.parentNode.parentNode.rows[j].cells[i-1].width=parseInt(pos)-x+parseInt(w);
	 }
      } else {
        var j;
        for(j=0;j<obj.parentNode.parentNode.rows.length;j++) {
          obj.parentNode.parentNode.rows[j].cells[i-1].width=1;
        }
      }
      }
  }
}

function end() {//鼠标松开左键
  dragenable=false;
  obj.releaseCapture();//释放捕捉
  obj.style.cursor='default';
}
