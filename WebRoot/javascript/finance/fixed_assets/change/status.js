/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
function search_suggest1(id){//根据输入内容快速查询固定资产编号写入下拉层
var keyword=document.getElementById(id).value;
if(keyword!=''){
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
var cla=document.getElementById('search_suggest1');
cla.innerHTML='';
if(parseInt(xmlhttp3.responseText)==179206725){
	document.getElementById('search_suggest1').style.display='none';
	}else{
var options =xmlhttp3.responseText.split('\n');
var conter='';
for (var i = 0; i < options.length-1; i++) {
var suggest = '<div onmouseover="style.backgroundColor=\'#E8F2FE\'" onmouseout="style.backgroundColor=\'\'"';
suggest += 'onclick=\"javascript:setSearch(this.innerHTML,\''+id+'\');\" ';
suggest += '>' + options[i] + '</div>';
conter += suggest;
}
cla.innerHTML = null;
cla.innerHTML = '';
cla.innerHTML = conter;
loadDiv2(document.getElementById(id));
cla.style.display = 'block';
if(document.attachEvent) document.attachEvent('onmousedown',closeResult1,event);
	}
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "status_search.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('keyword='+encodeURI(keyword)+'&tag=0');
}
}
}

function closeResult1(event){
	var scrollTop=parseInt(getScrollTop());
	var port_X=parseInt(event.clientX);
	var port_Y=parseInt(event.clientY)+scrollTop;
	if(document.getElementById('search_suggest1').style.display=='block'){
	var div=document.getElementById('search_suggest1');
	var div_w=parseInt(div.style.width);
	var div_h=parseInt(getRStyle(div,'height','height'));
	var div_l=parseInt(div.style.left);
	var div_t=parseInt(div.style.top);
	if(port_X<div_l||port_X>(div_l+div_w)||port_Y<div_t||port_Y>(div_t+div_h)){
		div.innerHTML = '';
		div.style.display='none';
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

function loadDiv2(obj1){//动态生成下拉层
    var w = obj1.offsetWidth;
    var h = obj1.offsetHeight-2;  

    var   x   =   obj1.offsetLeft,   y   =   obj1.offsetTop;   
    while(obj1=obj1.offsetParent) 
    { 
       x   +=   obj1.offsetLeft;   
       y   +=   obj1.offsetTop;
    } 
var obj=document.getElementById('search_suggest1');
obj.style.width=w;
obj.style.height='100px';
obj.style.background='yellow';
obj.style.position='absolute';
obj.style.top=y+h;
obj.style.left=x;
}

function setSearch(obj1,obj2){//关闭下拉层后,给录入框赋原值
	document.getElementById(obj2).value=obj1;
	document.getElementById('search_suggest1').style.display='none';
	var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
var options =xmlhttp3.responseText.split('⊙');
	document.getElementById('file_name').value=options[0];
	document.getElementById('start_time').value=options[1];
	document.getElementById('specification').value=options[2];
	document.getElementById('cb_status').value=options[3];
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "status_search.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('keyword='+encodeURI(obj1)+'&tag=1');
}
}

function not_choose(obj){//判断手工录入固定资产编号是否合法
	document.getElementById('search_suggest1').style.display='none';
	if(document.getElementById('file_id').value==''){
		document.getElementById('file_id').focus();
		alert('请先正确填写固定资产编号');
		return false;
	}
	var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
if(parseInt(xmlhttp3.responseText)!=179206725){
var options =xmlhttp3.responseText.split('⊙');
	document.getElementById('file_name').value=options[0];
	document.getElementById('start_time').value=options[1];
	document.getElementById('specification').value=options[2];
	document.getElementById('cb_status').value=options[3];
	}else{
		document.getElementById('file_id').focus();
		alert('该固定资产编号有误');
		return false;
	}
}else{
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "status_search.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('keyword='+encodeURI(document.getElementById('file_id').value)+'&tag=1');
}
}


function status_ok(){//提交数据库
var file_id=document.getElementById('file_id').value;
if(file_id==''){
	alert('固定资产编号不能为空');
	return false;
}
var file_name=document.getElementById('file_name').value;
var start_time=document.getElementById('start_time').value;
var specification=document.getElementById('specification').value;
var cb_status=document.getElementById('cb_status').value;
var ca_status=document.getElementById('ca_status').value;
var change_reason=document.getElementById('change_reason').value;
var change_date=document.getElementById('change_date').value;
var changer=document.getElementById('changer').value;

var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
	alert(xmlhttp3.responseText);
	window.location.reload();
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "../../../finance_fixed_assets_change_status_ok", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('file_id='+file_id+'&file_name='+encodeURI(file_name)+'&start_time='+start_time+'&specification='+encodeURI(specification)+'&cb_status='+cb_status+'&ca_status='+encodeURI(ca_status)+'&change_reason='+encodeURI(change_reason)+'&change_date='+change_date+'&changer='+encodeURI(changer));
}
}