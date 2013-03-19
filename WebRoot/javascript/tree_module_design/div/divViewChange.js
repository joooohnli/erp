var tag=0;
var port_X1;
var port_Y1;
var left1;
var top1;
var port_X;
var port_Y;
var nseerZindex=0;
var nn6=document.getElementById&&!document.all; 
var isdrag=false; 
var oDragObj; 
function moveMouse(e) {//根据鼠标点下时给tag赋的不同值对当前层进行不同操作
if (isdrag==true&&max_tag==0){
//min_tag=0;
//max_tag=0;

e=e||window.event;
var x12=parseInt(getStyle(oDragObj,"left","left"))+parseInt(getStyle(oDragObj,"width","width"));
var y12=parseInt(getStyle(oDragObj,"top","top"))+parseInt(getStyle(oDragObj,"height","height"));
if(tag==0){
port_X=e.clientX;
port_Y=e.clientY;
document.body.scrollTop=0;
document.body.scrollLeft=0;
left1=parseInt(getStyle(oDragObj,"left","left"));
top1=parseInt(getStyle(oDragObj,"top","top"));
}
if(tag==1){
port_X=e.clientX;
port_Y=e.clientY;
document.body.scrollTop=0;
document.body.scrollLeft=0;
if(port_X>0&&port_X>parseInt(left1)) oDragObj.style.width=port_X-parseInt(left1)+2;
}
if(tag==8){
port_X=e.clientX;
port_Y=e.clientY;
document.body.scrollTop=0;
document.body.scrollLeft=0;
if(port_X>0&&port_X<x12){
oDragObj.style.left=port_X-2;
oDragObj.style.width=x12-port_X+2;
}
}
if(tag==2){
port_X=e.clientX;
port_Y=e.clientY;
document.body.scrollTop=0;
document.body.scrollLeft=0;


if(port_Y>0&&port_Y>parseInt(top1)) oDragObj.style.height=port_Y-parseInt(top1);
}
if(tag==6){
port_X=e.clientX;
port_Y=e.clientY;
document.body.scrollTop=0;
document.body.scrollLeft=0;
if(port_Y>0&&port_Y<y12){
oDragObj.style.top=port_Y-2;
oDragObj.style.height=y12-port_Y+2;
}
}
if(tag==3){
port_X=e.clientX;
port_Y=e.clientY;
document.body.scrollTop=0;
document.body.scrollLeft=0;
if(port_X>0&&port_Y>0&&port_X>parseInt(left1)&&port_Y>parseInt(top1)){
oDragObj.style.width=port_X-parseInt(left1);
oDragObj.style.height=port_Y-parseInt(top1);
}
}
if(tag==5){
port_X=e.clientX;
port_Y=e.clientY;
document.body.scrollTop=0;
document.body.scrollLeft=0;
if(port_X>0&&port_Y>0&&port_X>parseInt(left1)&&port_Y<y12){
oDragObj.style.top=port_Y-2;
oDragObj.style.width=port_X-parseInt(left1)+2;
oDragObj.style.height=y12-port_Y+2;
}
}
if(tag==7){
port_X=e.clientX;
port_Y=e.clientY;
document.body.scrollTop=0;
document.body.scrollLeft=0;
if(port_X>0&&port_Y>0&&port_X<x12&&port_Y<y12){
oDragObj.style.top=port_Y-2;
oDragObj.style.left=port_X-2;
oDragObj.style.width=x12-port_X+2;
oDragObj.style.height=y12-port_Y+2;
}
}
if(tag==9){
port_X=e.clientX;
port_Y=e.clientY;
document.body.scrollTop=0;
document.body.scrollLeft=0;
if(port_X>0&&port_Y>0&&port_Y>parseInt(top1)&&port_X<x12){
oDragObj.style.left=port_X-2;
oDragObj.style.width=x12-port_X+2;
oDragObj.style.height=port_Y-top1+2;
}
}
if(tag==4){
port_X=e.clientX;
port_Y=e.clientY;
document.body.scrollTop=0;
document.body.scrollLeft=0;
//oDragObj.style.left=left1+port_X-port_X1+'px';
oDragObj.style.left=(left1+port_X-port_X1)<0?"0px":left1+port_X-port_X1+"px";
oDragObj.style.top=(top1+port_Y-port_Y1)<0?"0px":top1+port_Y-port_Y1+'px';
if(document.body.scrollWidth>document.body.clientWidth){
oDragObj.style.left=document.body.clientWidth-parseInt(getStyle(oDragObj,"width","width"));
}
if((document.body.clientHeight-parseInt(getStyle(oDragObj,"height","height")))<parseInt(getStyle(oDragObj,"top","top"))){
oDragObj.style.top=document.body.clientHeight-parseInt(getStyle(oDragObj,"height","height"));
}
}
return false; 
} 
} 
function initDrag(e) { //初始层
mouse_tag=1;
var oDragHandle = nn6 ? e.target : event.srcElement; 
var topElement = "HTML"; 
while (oDragHandle.tagName != topElement && oDragHandle.getAttribute("nseerDef") != "dragAble") {
 oDragHandle = nn6 ? oDragHandle.parentNode : oDragHandle.parentElement; //
} 
if (oDragHandle.getAttribute("nseerDef")=="dragAble") { //在ie和firfox都可以使用getAttribute获取自定义属性
 isdrag = true;
 oDragObj = oDragHandle; 
//*********************************************
nseerZindex++;
oDragObj.style.zIndex=nseerZindex;
oDragObj.style.overflow='hidden';
//alert(oDragObj.style.left);
//alert(getStyle(obj,"left","left"));//style属性如果写在css样式里,不能直接得到，所以改成如此方式获得属性值
e=e||window.event;//区分ie和firefox的event
port_X1=e.clientX;
port_Y1=e.clientY;
var x12=parseInt(getStyle(oDragObj,"left","left"))+parseInt(getStyle(oDragObj,"width","width"));
var y12=parseInt(getStyle(oDragObj,"top","top"))+parseInt(getStyle(oDragObj,"height","height"));
left1=parseInt(getStyle(oDragObj,"left","left"));
top1=parseInt(getStyle(oDragObj,"top","top"));
/*
var x12=parseInt(oDragObj.style.left)+parseInt(oDragObj.style.width);
var y12=parseInt(oDragObj.style.top)+parseInt(oDragObj.style.height);
left1=parseInt(oDragObj.style.left);
top1=parseInt(oDragObj.style.top);
*/
loadDiv(oDragObj,0,e);
//*****************************
 document.onmousemove=moveMouse;
 return false;
 }
} 

document.onmousedown=initDrag; 
document.onmouseup=dragimg;
function dragimg(e){
mouse_tag=0;
nseerZindex++;
if(oDragObj!=null){
oDragObj.style.zIndex=nseerZindex;
}
isdrag=false; 
}
var mouse_tag=0;
function mouseStyle(e){
if(mouse_tag==0){
var x12;
var y12;
var port_X;
var port_Y;
var oDragHandle1 = nn6?e.target : event.srcElement;
var topElement = "HTML";
while (oDragHandle1.tagName != topElement && oDragHandle1.getAttribute("nseerDef") != "dragAble") {
	oDragHandle1 = nn6?oDragHandle1.parentNode:oDragHandle1.parentElement;
}
if (oDragHandle1.getAttribute("nseerDef")=="dragAble"){
oDragHandle1.ondblclick=doubleClickDiv;
e=e||window.event;
x12=parseInt(getStyle(oDragHandle1,"left","left"))+parseInt(getStyle(oDragHandle1,"width","width"));
y12=parseInt(getStyle(oDragHandle1,"top","top"))+parseInt(getStyle(oDragHandle1,"height","height"));
port_X=e.clientX;
port_Y=e.clientY;
top1=parseInt(getStyle(oDragHandle1,"top","top"));
left1=parseInt(getStyle(oDragHandle1,"left","left"));

}
loadDiv(oDragHandle1,1,e);
}
}
function mmcMouseStyle(obj){
	obj.style.cursor='hand';
}
function loadDiv(obj,t,evt){

evt=evt||window.event;

var nseer_r=obj;
    var w = obj.offsetWidth;
    var h = obj.offsetHeight;  

    var   x   =   obj.offsetLeft;
	var    y   =   obj.offsetTop;   
    while(obj=obj.offsetParent) 
    { 
       x   +=   obj.offsetLeft;   
       y   +=   obj.offsetTop;
    } 
     
if(parseInt(evt.clientX)>parseInt(x)&&parseInt(evt.clientX)<parseInt(x)+10&&parseInt(evt.clientY)<parseInt(y)+h-15&&parseInt(evt.clientY)>parseInt(y)+15){//左侧边界
if(t!=0){
nseer_r.style.cursor='e-resize';
}else{
tag=8;//左侧边界

}
}else if(parseInt(evt.clientX)<parseInt(x)+15&&parseInt(evt.clientY)<parseInt(y)+15){
if(t!=0){ 
nseer_r.style.cursor='nw-resize';//左上角
}else{
tag=7;//左上角

}
}
else  if(parseInt(evt.clientX)<parseInt(x)+w&&parseInt(evt.clientX)>parseInt(x)+w-10&&parseInt(evt.clientY)<parseInt(y)+h-15&&parseInt(evt.clientY)>parseInt(y)+15){//右侧边界
if(t!=0){ 
    
nseer_r.style.cursor='e-resize';
}else{
tag=1;//右侧边界

}
}
else if(parseInt(evt.clientX)>parseInt(x)+w-15&&parseInt(evt.clientY)<parseInt(y)+15){
if(t!=0){ 

nseer_r.style.cursor='ne-resize';//右上角
}else{
tag=5;//右上角

}
}
else if(parseInt(evt.clientY)<parseInt(y)+5&&parseInt(evt.clientX)<parseInt(x)+w-15&&parseInt(evt.clientX)>parseInt(x)+15){
if(t!=0){ 

nseer_r.style.cursor='s-resize';////上侧边界
}else{
tag=6;//上侧边界

}
}
else if(parseInt(evt.clientX)<parseInt(x)+15&&parseInt(evt.clientY)>parseInt(y)+h-15){
if(t!=0){ 

nseer_r.style.cursor='ne-resize';//左下角
}else{
tag=9;//左下角

}
}
   
else  if(parseInt(evt.clientY)>parseInt(y)+h-10&&parseInt(evt.clientX)<parseInt(x)+w-15&&parseInt(evt.clientX)>parseInt(x)+15){
if(t!=0){ 
   
nseer_r.style.cursor='s-resize';//下边界
}else{
tag=2;//下侧边界

}

}
else if(parseInt(evt.clientX)>parseInt(x)+w-15&&parseInt(evt.clientY)>parseInt(y)+h-15){
if(t!=0){ 

nseer_r.style.cursor='nw-resize';//右下角
}else{
tag=3;//右下角
}
}

else if(parseInt(evt.clientY)>parseInt(y)+5&&parseInt(evt.clientY)<parseInt(y)+20&&parseInt(evt.clientX)<parseInt(x)+w-10&&parseInt(evt.clientX)>parseInt(x)+10){
if(t!=0){ 

nseer_r.style.cursor='move';//移动区域
}else{
tag=4;
}

}

else{ 
if(t!=0){ 

nseer_r.style.cursor='default';//中间区域
}else{
tag=0;

}

}

}
var data=new Array;
var v=0;
function maxDiv(){//得初始时的坐标,宽度,高度.
max_tag=1;
if(min_tag==0){



var t=getStyle(oDragObj,"top","top");
var l=getStyle(oDragObj,"left","left");
var w=getStyle(oDragObj,"width","width");
var h=getStyle(oDragObj,"height","height");
var string_data=t+'#'+l+'#'+w+'#'+h;
oDragObj.def=v;
data[v]=string_data;
v++;
}
oDragObj.style.top='0px';//最大化
oDragObj.style.left='0px';
oDragObj.style.width=document.body.clientWidth;
oDragObj.style.height=document.body.clientHeight;
//********************************************************
//alert(getStyle('expand','backgroundImage','background-image'));
//alert(oDragObj.getElementById('expand').id);
var oDragObj_childNodes=oDragObj.getElementsByTagName('div');
for(var i=0;i<oDragObj_childNodes.length;i++){
	if(oDragObj_childNodes[i].id=='expand'){
		oDragObj_childNodes[i].style.backgroundImage='url(/erp/javascript/include/div/images/return.gif)';
		oDragObj_childNodes[i].onclick=returnDiv;
	}
	if(oDragObj_childNodes[i].id=='collapse'){
		
oDragObj_childNodes[i].style.backgroundImage='url(/erp/javascript/include/div/images/collapse.gif)';
oDragObj_childNodes[i].onclick=minDiv;
	}
}
//img_change('Img','return.gif');
//document['Img'].onclick=returnDiv;
//img_change('Img1','collapse.gif');
//document['Img1'].onclick=minDiv;
}
function returnDiv(){
min_tag=0;
max_tag=0;
var s=oDragObj.def;
var da=data[s].split('#');
oDragObj.style.top=da[0];
oDragObj.style.left=da[1];
oDragObj.style.width=da[2];
oDragObj.style.height=da[3];
var oDragObj_childNodes=oDragObj.getElementsByTagName('div');
for(var i=0;i<oDragObj_childNodes.length;i++){
	if(oDragObj_childNodes[i].id=='expand'){
		oDragObj_childNodes[i].style.backgroundImage='url(/erp/javascript/include/div/images/expand.gif)';
		oDragObj_childNodes[i].onclick=maxDiv;
	}
}
//img_change('Img','expand.gif');
//document['Img'].onclick=maxDiv;
}
function returnDiv1(){//点击最小化后点击还原时执行
min_tag=0;
max_tag=0;
var s=oDragObj.def;
var da=data[s].split('#');
oDragObj.style.top=da[0];
oDragObj.style.left=da[1];
oDragObj.style.width=da[2];
oDragObj.style.height=da[3];
var oDragObj_childNodes=oDragObj.getElementsByTagName('div');
for(var i=0;i<oDragObj_childNodes.length;i++){
	if(oDragObj_childNodes[i].id=='collapse'){
		oDragObj_childNodes[i].style.backgroundImage='url(/erp/javascript/include/div/images/collapse.gif)';
		oDragObj_childNodes[i].onclick=minDiv;
	}
}
//img_change('Img1','collapse.gif');
//document['Img1'].onclick=minDiv;
}
var min_tag=0;
var max_tag=0;
function minDiv(s){
min_tag=1;
var ss=s||20;
if(max_tag==0){
var t=getStyle(oDragObj,"top","top");
var l=getStyle(oDragObj,"left","left");
var w=getStyle(oDragObj,"width","width");
var h=getStyle(oDragObj,"height","height");
var string_data=t+'#'+l+'#'+w+'#'+h;
oDragObj.def=v;
data[v]=string_data;
v++;
}
oDragObj.style.height=ss+'px';
oDragObj.style.overflow='hidden';
oDragObj.style.width=ss*10+'px';
var oDragObj_childNodes=oDragObj.getElementsByTagName('div');
for(var i=0;i<oDragObj_childNodes.length;i++){
	if(oDragObj_childNodes[i].id=='collapse'){
		oDragObj_childNodes[i].style.backgroundImage='url(/erp/javascript/include/div/images/return.gif)';
		oDragObj_childNodes[i].onclick=returnDiv1;
	}
	if(oDragObj_childNodes[i].id=='expand'){
		oDragObj_childNodes[i].style.backgroundImage='url(/erp/javascript/include/div/images/expand.gif)';
		oDragObj_childNodes[i].onclick=maxDiv;
	}
}
//img_change('Img1','return.gif');
//document['Img1'].onclick=returnDiv1;
//img_change('Img','expand.gif');
//document['Img'].onclick=maxDiv;
}
function closeDiv(closeType){//关闭该层
	if(closeType=='remove'){document.body.removeChild(document.getElementById(oDragObj.id));}
	else if(closeType=='hidden'){oDragObj.style.display='none';}
	else if(closeType=='reconfirm'){}	
}
function doubleClickDiv(e){//双击层顶部特殊区域最大化和最小化
e=e||window.event;
var t=parseInt(getStyle(oDragObj,"top","top"));
var l=parseInt(getStyle(oDragObj,"left","left"));
var w=parseInt(getStyle(oDragObj,"width","width"));
var h=parseInt(getStyle(oDragObj,"height","height"));
var port_X1=e.clientX;
var port_Y1=e.clientY;
var x12=l+w;
if(port_Y1>(t+5)&&port_Y1<(t+25)&&port_X1>(l+5)&&port_X1<(x12-5)){
if(db_max_return==0){
	maxDiv();
	db_max_return=1;
}else if(db_max_return==1){
	returnDiv();
	db_max_return=0;
}
}
}
var db_max_return=0;
/*
new_img = new Image(15,15);
new_img.src = "/erp/javascript/include/div/images/";
function img_change(img_name,img){
	document[img_name].src = new_img.src+img;
} 
*/
function getStyle(elem,IE,FF){//获取定义在css文件里的样式属性值
return navigator.appName=="Microsoft Internet Explorer"?elem.currentStyle[IE]:document.defaultView.getComputedStyle(elem, "").getPropertyValue(FF);
}
document.body.onmousemove=mouseStyle;