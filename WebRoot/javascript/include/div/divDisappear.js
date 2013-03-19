/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
function closeResult(event){
	var scrollTop=parseInt(getScrollTop());
	var port_X=parseInt(event.clientX);
	var port_Y=parseInt(event.clientY)+scrollTop;
	if(document.getElementById('result_div')!='undefined'&&document.getElementById('result_div')!=null){
	var div=document.getElementById('result_div');
	var div_w=parseInt(div.style.width);
	var div_h=parseInt(getRStyle(div,'height','height'));
	var div_l=parseInt(div.style.left);
	var div_t=parseInt(div.style.top);
	if(port_X<div_l||port_X>(div_l+div_w)||port_Y<div_t||port_Y>(div_t+div_h)){
		document.body.removeChild(div);
		}
	}
} 

function getScrollTop(){
var scrollTop=0;
if(document.documentElement&&document.documentElement.scrollTop){
scrollTop=document.documentElement.scrollTop;
}else if(document.body){
scrollTop=document.body.scrollTop;
}
return scrollTop;
}

function getRStyle(elem,IE,FF){//获取定义在css文件里的样式属性值
return navigator.appName=="Microsoft Internet Explorer"?elem.currentStyle[IE]:document.defaultView.getComputedStyle(elem, "").getPropertyValue(FF);
}

function locateSelectDiv(){
var divs=document.getElementsByTagName('div');
	for(var i=0;i<divs.length;i++){
		var new_id=divs[i].id.substring(0,divs[i].id.length-4);
		if(new_id!='window_id_1'&&new_id!='formula'&&new_id!='QV'&&document.getElementById(new_id)){
			loadMirror1(document.getElementById(divs[i].id.substring(0,divs[i].id.length-4)),divs[i].id);
		}
	}
}
function loadMirror1(obj1,div_id){//动态定位
    var w = obj1.offsetWidth;
    var h = obj1.offsetHeight; 

    var   x   =   obj1.offsetLeft,   y   =   obj1.offsetTop;   
    while(obj1=obj1.offsetParent) 
    { 
       x   +=   obj1.offsetLeft;   
       y   +=   obj1.offsetTop;
       
    } 
var obj=document.getElementById(div_id);
obj.style.height='17px';
obj.style.width='15px';
var t=y-49,l=x+w-25;
obj.style.top=t+'px';
obj.style.left=l+'px';
}