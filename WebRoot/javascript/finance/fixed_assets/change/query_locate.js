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
var cla=document.getElementById('search_suggest');
cla.innerHTML='';
if(parseInt(xmlhttp3.responseText)==179206725){
	document.getElementById('search_suggest').style.display='none';
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
xmlhttp3.open("POST", "query_search.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('keyword='+encodeURI(keyword)+'&tag=0');
}
}
}

function closeResult1(event){
	var scrollTop=parseInt(getScrollTop());
	var port_X=parseInt(event.clientX);
	var port_Y=parseInt(event.clientY)+scrollTop;
	if(document.getElementById('search_suggest').style.display=='block'){
	var div=document.getElementById('search_suggest');
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
var obj=document.getElementById('search_suggest');
obj.style.width=w;
obj.style.height='100px';
obj.style.background='yellow';
obj.style.position='absolute';
obj.style.top=y+h;
obj.style.left=x;
}

function setSearch(obj1,obj2){//关闭下拉层后,给录入框赋原值
	document.getElementById(obj2).value=obj1;
	document.getElementById('search_suggest').style.display='none';
}

function id_link(id){//根据变动单编号查询finance_fa_change表

if(document.getElementById('change_bill').style.display!='none'){
return false;
}
var keyword=id;
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
//alert(xmlhttp3.responseText);
var options =xmlhttp3.responseText.split('⊙');
	document.getElementById('title').innerHTML=options[0]+'变动单';
	document.getElementById('file_id').innerHTML=options[1];
	document.getElementById('file_name').innerHTML=options[2];
	document.getElementById('start_time').innerHTML=options[3];
	document.getElementById('specification').innerHTML=options[5];
	document.getElementById('change_reason').innerHTML=options[20];
	document.getElementById('change_date').innerHTML=options[21];
	document.getElementById('changer').innerHTML=options[22];
if(options[0]=='原值调整'){
if(options[4]==0){options[4]='原值增加';}else{options[4]='原值减少';}
	var tr=document.getElementById('theObjTable').insertRow(3);
	tr.height='20px';
	var tr1=document.getElementById('theObjTable').insertRow(4);
	tr1.height='20px';
	var tr2=document.getElementById('theObjTable').insertRow(5);
	tr2.height='20px';
	var tr3=document.getElementById('theObjTable').insertRow(6);
	tr3.height='20px';
	var tr4=document.getElementById('theObjTable').insertRow(7);
	tr4.height='20px';
	td=tr.insertCell(-1);
	td.innerHTML='变动类型';
	td.background='../../../images/line7.gif';
	tr.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[4]+'</div>';
	td1=tr.insertCell(-1);
	td1.background='../../../images/line7.gif';
	td1.innerHTML='变动金额';
	tr.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[6]+'</div>';	
	td2=tr1.insertCell(-1);
	td2.innerHTML='币种';
	td2.background='../../../images/line7.gif';
	tr1.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[7]+'</div>';
	td3=tr1.insertCell(-1);
	td3.background='../../../images/line7.gif';
	td3.innerHTML='汇率';
	tr1.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[8]+'</div>';
	td4=tr2.insertCell(-1);
	td4.innerHTML='变动的净残值率';
	td4.background='../../../images/line7.gif';
	tr2.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[10]+'</div>';
	td5=tr2.insertCell(-1);
	td5.background='../../../images/line7.gif';
	td5.innerHTML='变动的净残值';
	tr2.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[9]+'</div>';	
	td6=tr3.insertCell(-1);
	td6.innerHTML='变动前原值';
	td6.background='../../../images/line7.gif';
	tr3.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[11]+'</div>';
	td7=tr3.insertCell(-1);
	td7.background='../../../images/line7.gif';
	td7.innerHTML='变动后原值';
	tr3.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[12]+'</div>';
	td8=tr4.insertCell(-1);
	td8.innerHTML='变动前净残值';
	td8.background='../../../images/line7.gif';
	tr4.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[13]+'</div>';
	td9=tr4.insertCell(-1);
	td9.background='../../../images/line7.gif';
	td9.innerHTML='变动后净残值';
	tr4.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[32]+'</div>';
}
if(options[0]=='资产移转'){
	var tr=document.getElementById('theObjTable').insertRow(3);
	 tr.height='20px';
	var tr1 = document.getElementById('theObjTable').insertRow(4);
	 tr1.height='20px';
	td=tr.insertCell(-1);
	td.innerHTML='变动前机构';
	td.background='../../../images/line7.gif';
	tr.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[14]+' '+options[15]+'</div>';
	td1=tr.insertCell(-1);
	td1.background='../../../images/line7.gif';
	td1.innerHTML='变动后机构';
	tr.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[16]+' '+options[17]+'</div>';
		
	td2=tr1.insertCell(-1);
	td2.innerHTML='变动前存放地址';
	td2.background='../../../images/line7.gif';
	tr1.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[18]+'</div>';
	td3=tr1.insertCell(-1);
	td3.background='../../../images/line7.gif';
	td3.innerHTML='变动后存放地址';
	tr1.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[19]+'</div>';
}
if(options[0]=='使用状态变动'){
	var tr=document.getElementById('theObjTable').insertRow(3);
	tr.height='20px';
	td=tr.insertCell(-1);
	td.innerHTML='变动前使用状态';
	td.background='../../../images/line7.gif';
	tr.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[23]+'</div>';
	td1=tr.insertCell(-1);
	td1.background='../../../images/line7.gif';
	td1.innerHTML='变动后使用状态';
	tr.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[24]+'</div>';
}
if(options[0]=='折旧方法变动'){
	var tr=document.getElementById('theObjTable').insertRow(3);
	tr.height='20px';
	td=tr.insertCell(-1);
	td.innerHTML='变动前折旧方法';
	td.background='../../../images/line7.gif';
	tr.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[42]+'</div>';
	td1=tr.insertCell(-1);
	td1.background='../../../images/line7.gif';
	td1.innerHTML='变动后折旧方法';
	tr.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[43]+'</div>';
	if(options[30]!=''){
	var tr1=document.getElementById('theObjTable').insertRow(4);
	tr1.height='20px';	
	var tr2=document.getElementById('theObjTable').insertRow(5);
	tr2.height='20px';
	td2=tr1.insertCell(-1);
	td2.innerHTML='工作总量';
	td2.background='../../../images/line7.gif';
	tr1.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[30]+'</div>';
	td3=tr1.insertCell(-1);
	td3.background='../../../images/line7.gif';
	td3.innerHTML='累计工作量';
	tr1.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[44]+'</div>';

	td4=tr2.insertCell(-1);
	td4.innerHTML='工作量单位';
	td4.background='../../../images/line7.gif';
	tr2.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[45]+'</div>';
	td5=tr2.insertCell(-1);
	td5.background='../../../images/line7.gif';
	td5.innerHTML='';
	tr2.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\"></div>';
	}

}
if(options[0]=='累计折旧调整'){
	var tr=document.getElementById('theObjTable').insertRow(3);
	tr.height='20px';
	td=tr.insertCell(-1);
	td.innerHTML='变动前累计折旧';
	td.background='../../../images/line7.gif';
	tr.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[25]+'</div>';
	td1=tr.insertCell(-1);
	td1.background='../../../images/line7.gif';
	td1.innerHTML='变动后累计折旧';
	tr.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[26]+'</div>';
}
if(options[0]=='使用年限调整'){
	var tr=document.getElementById('theObjTable').insertRow(3);
	tr.height='20px';
	td=tr.insertCell(-1);
	td.innerHTML='变动前使用年限';
	td.background='../../../images/line7.gif';
	tr.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[27]+'</div>';
	td1=tr.insertCell(-1);
	td1.background='../../../images/line7.gif';
	td1.innerHTML='变动后使用年限';
	tr.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[28]+'</div>';
}
if(options[0]=='工作总量调整'){
var tr=document.getElementById('theObjTable').insertRow(3);
	tr.height='20px';
	td=tr.insertCell(-1);
	td.innerHTML='变动前工作总量';
	td.background='../../../images/line7.gif';
	tr.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[29]+'</div>';
	td1=tr.insertCell(-1);
	td1.background='../../../images/line7.gif';
	td1.innerHTML='变动后工作总量';
	tr.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[30]+'</div>';
}
if(options[0]=='净残值调整'){
var tr=document.getElementById('theObjTable').insertRow(3);
	 tr.height='20px';
	var tr1 = document.getElementById('theObjTable').insertRow(4);
	 tr1.height='20px';
	var tr2 = document.getElementById('theObjTable').insertRow(5);
	 tr2.height='20px';
	td=tr.insertCell(-1);
	td.innerHTML='原值';
	td.background='../../../images/line7.gif';
	tr.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[11]+' '+options[15]+'</div>';
	td1=tr.insertCell(-1);
	td1.background='../../../images/line7.gif';
	td1.innerHTML='净值';
	tr.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[31]+' '+options[17]+'</div>';
		
	td2=tr1.insertCell(-1);
	td2.innerHTML='变动前净残值率';
	td2.background='../../../images/line7.gif';
	tr1.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[33]+'</div>';
	td3=tr1.insertCell(-1);
	td3.background='../../../images/line7.gif';
	td3.innerHTML='变动后净残值率';
	tr1.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[34]+'</div>';

	td4=tr2.insertCell(-1);
	td4.innerHTML='变动前净残值';
	td4.background='../../../images/line7.gif';
	tr2.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[13]+'</div>';
	td5=tr2.insertCell(-1);
	td5.background='../../../images/line7.gif';
	td5.innerHTML='变动后净残值';
	tr2.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[32]+'</div>';
}
if(options[0]=='类别调整'){
var tr=document.getElementById('theObjTable').insertRow(3);
	tr.height='20px';
	td=tr.insertCell(-1);
	td.innerHTML='变动前类别';
	td.background='../../../images/line7.gif';
	tr.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[35]+'</div>';
	td1=tr.insertCell(-1);
	td1.background='../../../images/line7.gif';
	td1.innerHTML='变动后类别';
	tr.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[36]+'</div>';
}
if(options[0]=='计提减值准备'){
	var tr=document.getElementById('theObjTable').insertRow(3);
		tr.height='20px';
	var tr1 = document.getElementById('theObjTable').insertRow(4);
	 	tr1.height='20px';
	var tr2 = document.getElementById('theObjTable').insertRow(5);
	 	tr2.height='20px';
	var tr3 = document.getElementById('theObjTable').insertRow(6);
	 	tr3.height='20px';
	td=tr.insertCell(-1);
	td.innerHTML='币种';
	td.background='../../../images/line7.gif';
	tr.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[7]+'</div>';
	td1=tr.insertCell(-1);
	td1.background='../../../images/line7.gif';
	td1.innerHTML='汇率';
	tr.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[8]+'</div>';
	td2=tr1.insertCell(-1);
	td2.innerHTML='原值';
	td2.background='../../../images/line7.gif';
	tr1.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[11]+'</div>';
	td3=tr1.insertCell(-1);
	td3.background='../../../images/line7.gif';
	td3.innerHTML='累计折旧';
	tr1.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[25]+'</div>';
	td4=tr2.insertCell(-1);
	td4.innerHTML='累计减值准备金额';
	td4.background='../../../images/line7.gif';
	tr2.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[38]+'</div>';
	td5=tr2.insertCell(-1);
	td5.background='../../../images/line7.gif';
	td5.innerHTML='累计转回准备金额';
	tr2.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[39]+'</div>';
	td6=tr3.insertCell(-1);
	td6.innerHTML='可回收市值';
	td6.background='../../../images/line7.gif';
	tr3.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[37]+'</div>';
	td7=tr3.insertCell(-1);
	td7.background='../../../images/line7.gif';
	td7.innerHTML='减值准备金额';
	tr3.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[40]+'</div>';
}
if(options[0]=='转回减值准备'){
	var tr=document.getElementById('theObjTable').insertRow(3);
		tr.height='20px';
	var tr1 = document.getElementById('theObjTable').insertRow(4);
	 	tr1.height='20px';
	var tr2 = document.getElementById('theObjTable').insertRow(5);
	 	tr2.height='20px';
	var tr3 = document.getElementById('theObjTable').insertRow(6);
	 	tr3.height='20px';
	td=tr.insertCell(-1);
	td.innerHTML='币种';
	td.background='../../../images/line7.gif';
	tr.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[7]+'</div>';
	td1=tr.insertCell(-1);
	td1.background='../../../images/line7.gif';
	td1.innerHTML='汇率';
	tr.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[8]+'</div>';
	td2=tr1.insertCell(-1);
	td2.innerHTML='原值';
	td2.background='../../../images/line7.gif';
	tr1.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[11]+'</div>';
	td3=tr1.insertCell(-1);
	td3.background='../../../images/line7.gif';
	td3.innerHTML='累计折旧';
	tr1.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[25]+'</div>';
	td4=tr2.insertCell(-1);
	td4.innerHTML='累计减值准备金额';
	td4.background='../../../images/line7.gif';
	tr2.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[38]+'</div>';
	td5=tr2.insertCell(-1);
	td5.background='../../../images/line7.gif';
	td5.innerHTML='累计转回准备金额';
	tr2.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[39]+'</div>';
	td6=tr3.insertCell(-1);
	td6.innerHTML='可回收市值';
	td6.background='../../../images/line7.gif';
	tr3.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[37]+'</div>';
	td7=tr3.insertCell(-1);
	td7.background='../../../images/line7.gif';
	td7.innerHTML='转回减值准备金额';
	tr3.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[41]+'</div>';
}
	$('#change_bill').Grow(500);
	return false;
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "query_search.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('keyword='+encodeURI(keyword)+'&tag=1');
}
}

function close_clear(){
var sta=document.getElementById('theObjTable').rows.length;
   for(var i=3;i<sta-2;i++){
   document.getElementById('theObjTable').deleteRow(3);//行号从0开始，3表示第四行
   }
   $('#change_bill').Shrink(500);
	return false;
}
