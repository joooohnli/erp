/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
var timer=0;
var Magnifying='';
function showKind(treeDiv,obj,openTreeFunc){
if(document.getElementById('showTree_div')) document.body.removeChild(document.getElementById('showTree_div'));
var u=window.location.href.split('://')[1].split('/');
var url='';
for(var i=0;i<u.length-3;i++){url+='../';}
		var dup_div=document.createElement('div');
		dup_div.id='showTree_div';
		dup_div.style.position='absolute';
		dup_div.style.width=18;
		dup_div.style.hidden=30;
		dup_div.style.paddingTop=4;
		dup_div.style.cursor='hand';
		dup_div.style.backgroundImage='url('+url+'images/finance/search.gif)';
		dup_div.onclick=function (){document.body.removeChild(dup_div); open_tree(treeDiv,dup_div,openTreeFunc);};
		dup_div.style.display='block';
		document.body.appendChild(dup_div);
     	loadMirror(obj,dup_div.id);
     	Magnifying=obj.id;
if(document.attachEvent) document.attachEvent('onmousedown',closeResult);
if(document.addEventListener) document.addEventListener('mousedown',closeResult);	
}

var timei2=0;
function doFuncDelay(s,func,div){
var tree_name=func.toString().split('initMyTree')[1];
tree_name=tree_name.substring(0,tree_name.indexOf(';')).replace(/(^\s*)|(\s*$)/g, "");
tree_name=tree_name.substring(1,tree_name.length-1);
if(eval(tree_name)=='undefined'||typeof(eval(tree_name))=='object'){document.getElementById(div).style.display='block';return;}
if(timei2++ <s){setTimeout("doFuncDelay("+s+","+func+",\""+div+"\");",1000);inWaiting();}else{timei2=0;
	if(typeof(eval(func))=='function'){func();
	document.getElementById(div).style.display='block';
	}else{
	document.getElementById(div).style.display='block';
	}
}
}
function open_tree(tree_div,obj,func){
loadCover(tree_div);
obj.style.display='none';
if(document.getElementById('search_suggest')){
document.getElementById('search_suggest').innerHTML = '';
document.getElementById('search_suggest').style.display='none';
}
doFuncDelay(1,func,tree_div);
}
function loadDiv1(obj1){//动态生成下拉层
    var w = obj1.offsetWidth;
    var h = obj1.offsetHeight-2;  

    var   x   =   obj1.offsetLeft,   y   =   obj1.offsetTop;   
    while(obj1=obj1.offsetParent) 
    { 
       x   +=   obj1.offsetLeft;   
       y   +=   obj1.offsetTop;
    } 
var obj=document.getElementById('search_suggest');
obj.style.width=w;
obj.style.height='100px';
obj.style.background='yellow';
obj.style.position='absolute';
obj.style.top=y+h;
obj.style.left=x;
}
function loadMirror(obj1,div_id){//动态定位放大镜
    var w = obj1.offsetWidth;
    var h = obj1.offsetHeight;  

    var   x   =   obj1.offsetLeft,   y   =   obj1.offsetTop;   
    while(obj1=obj1.offsetParent) 
    { 
       x   +=   obj1.offsetLeft;   
       y   +=   obj1.offsetTop;
    } 
var obj=document.getElementById(div_id);
obj.style.top=y+1;
obj.style.left=x+w-20;
}

function search_suggest(obj){//根据输入内容快速查询摘要写入下拉层
var keyword=document.getElementById(obj).value;
var table_name=document.getElementById(obj+'_table').value;
var u=window.location.href.split('://')[1].split('/');
var url='';
for(var i=0;i<u.length-3;i++){url+='../';}

if(keyword!=''){
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
if(!document.getElementById('search_suggest')){
var search_suggest=document.createElement('div');
	search_suggest.id='search_suggest';
	search_suggest.style.position='absolute';
	search_suggest.style.background='#FFFFFF';
	search_suggest.style.overflowY='auto';
	search_suggest.style.overflowX='auto';
	document.body.appendChild(search_suggest);
}
var cla=document.getElementById('search_suggest');
if(xmlhttp3.responseText=='⊙'){
	if(document.getElementById('fileKind_chain')) document.getElementById('fileKind_chain').value='';
	if(document.getElementById(obj))document.getElementById(obj).value='';
	document.getElementById('search_suggest').style.display='none';
	HideOverSels_1('search_suggest');
	}else{
var options =xmlhttp3.responseText.split("\n");
var conter='';
for (var i = 0; i < options.length; i++) {
var suggest = '<div style="text-align:left" onmouseover="style.backgroundColor=\'#E8F2FE\'" onmouseout="style.backgroundColor=\'\'"';
suggest += 'onclick=\"javascript:setSearch(this.innerHTML,\''+obj+'\');\" ';
suggest += '>' + options[i] + '</div>';
conter += suggest;
}
cla.innerHTML = '';
cla.innerHTML = conter;
loadDiv1(document.getElementById(obj));
cla.style.display='block';
if(document.attachEvent) document.attachEvent('onmousedown',closeResult,event);
HideOverSels_1(cla.id);
if(document.getElementById('showTree_div')) document.body.removeChild(document.getElementById('showTree_div'));
	}
	
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", url+"include/kind_ajax.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('keyword='+encodeURI(keyword)+'&table_name='+table_name);
}
}else{
	if(document.getElementById('search_suggest')){
		document.getElementById('search_suggest').innerHTML = '';
		document.getElementById('search_suggest').style.display='none';
		HideOverSels_1('search_suggest');
		}
}
}

function setSearch(obj,obj1){
	if(document.getElementById('showTree_div')) document.body.removeChild(document.getElementById('showTree_div'));
	document.getElementById(obj1).value=obj;
	document.getElementById('search_suggest').style.display='none';
	HideOverSels_1('search_suggest');
	document.getElementById('search_suggest').innerHTML='';
}

function closeResult(){
	var scrollTop=parseInt(getScrollTop());
	var port_X=parseInt(event.clientX);
	var port_Y=parseInt(event.clientY)+scrollTop;
	if(document.getElementById('search_suggest')&&document.getElementById('search_suggest').style.display=='block'){
	var div=document.getElementById('search_suggest');
	var div_w=parseInt(div.style.width);
	var div_h=parseInt(getRStyle(div,'height','height'));
	var div_l=parseInt(div.style.left);
	var div_t=parseInt(div.style.top);
	if(port_X<div_l||port_X>(div_l+div_w)||port_Y<div_t||port_Y>(div_t+div_h)){
		if(document.getElementById('showTree_div')) document.body.removeChild(document.getElementById('showTree_div'));
	if(div.style.display=='block'){
	if(document.getElementById('fileKind_chain')) document.getElementById('fileKind_chain').value='';
	}
		div.innerHTML = '';
		div.style.display='none';
		HideOverSels_1('search_suggest');	
		}
		relieving();
	}else if(document.getElementById('showTree_div')&&document.getElementById('showTree_div').style.display=='block'){
	//alert(Magnifying);
	var div=document.getElementById(Magnifying);
	var div_w=div.offsetWidth;
	var div_h=div.offsetHeight;
 	var div_l=div.offsetLeft;
 	var div_t=div.offsetTop;   
    while(div=div.offsetParent) 
    { 
       div_l+=div.offsetLeft;   
       div_t+=div.offsetTop;
    } 
	if(port_X<div_l||port_X>(div_l+div_w)||port_Y<div_t||port_Y>(div_t+div_h)){
	document.body.removeChild(document.getElementById('showTree_div'));
	}
	relieving();
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

function HideOverSels_1(objID){
var sels = document.getElementsByTagName('select'); 
    for (var i = 0; i < sels.length; i++){
		if (Obj1OverObj2_1(document.all[objID], sels[i])){

			if(sels[i].id!='print_type'){
				sels[i].style.visibility = 'hidden';
			} 
		}else{
			if(sels[i].id!='print_type'){
				sels[i].style.visibility = 'visible';
			} 
		}
	}
}

function Obj1OverObj2_1(obj1, obj2){
  var pos1 = getPosition_1(obj1) 
  var pos2 = getPosition_1(obj2) 
  var result = true; 
  var obj1Left = pos1.left - window.document.body.scrollLeft; 
  var obj1Top = pos1.top - window.document.body.scrollTop; 
  var obj1Right = obj1Left + obj1.offsetWidth; 
  var obj1Bottom = obj1Top + obj1.offsetHeight;
  var obj2Left = pos2.left - window.document.body.scrollLeft; 
  var obj2Top = pos2.top - window.document.body.scrollTop; 
  var obj2Right = obj2Left + obj2.offsetWidth; 
  var obj2Bottom = obj2Top + obj2.offsetHeight;
  if (obj1Right <= obj2Left || obj1Bottom <= obj2Top || 
      obj1Left >= obj2Right || obj1Top >= obj2Bottom) 
    result = false; 
  return result; 
}

function getPosition_1(Obj){
for (var sumTop=0,sumLeft=0;Obj!=window.document.body;sumTop+=Obj.offsetTop,sumLeft+=Obj.offsetLeft, Obj=Obj.offsetParent);
return {left:sumLeft,top:sumTop}
}

 function relieving(){
         document.detachEvent('onmousedown',closeResult);
     }