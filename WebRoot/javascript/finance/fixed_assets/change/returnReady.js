/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
var cb_sum_re_presub=0;
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
xmlhttp3.open("POST", "returnReady_search.jsp", true);
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
	var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
var options =xmlhttp3.responseText.split('⊙');
	document.getElementById('file_name').value=options[0];
	document.getElementById('start_time').value=options[1];
	document.getElementById('specification').value=options[2];
	document.getElementById('currency').value=options[3];
	document.getElementById('original_value').value=options[4];
	document.getElementById('caled_sum').value=options[5];
	document.getElementById('sum_presub').value=options[6];
	document.getElementById('sum_re_presub').value=options[7];
	cb_sum_re_presub=options[7];//赋全局	
	document.getElementById('remnant_value').value=options[8];
	document.getElementById('ca_net_value').value=options[9];
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "returnReady_search.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('keyword='+encodeURI(obj1)+'&tag=1');
}
}

function not_choose(obj){//判断手工录入固定资产编号是否合法
	document.getElementById('search_suggest').style.display='none';
	if(document.getElementById('file_id').value==''){
		document.getElementById('file_id').focus();
		alert('请先正确填写固定资产编号');
		return false;
	}
	if(document.getElementById('file_name').value!=''){
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
	document.getElementById('currency').value=options[3];
	document.getElementById('original_value').value=options[4];
	document.getElementById('caled_sum').value=options[5];
	document.getElementById('sum_presub').value=options[6];
	document.getElementById('sum_re_presub').value=options[7];	
	cb_sum_re_presub=options[7];//赋全局
	document.getElementById('remnant_value').value=options[8];
	document.getElementById('ca_net_value').value=options[9];
	}else{
		document.getElementById('file_id').focus();
		alert('该固定资产编号有误');
		return false;
	}
}else{
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "returnReady_search.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('keyword='+encodeURI(document.getElementById('file_id').value)+'&tag=1');
}
}

function decimalControl(input_id){//金额类录入框输入控制(负数除外)  
	var input=document.getElementById(input_id);
    input.value = input.value.replace(/[^0123456789.$]/g,'');
    if(input.value.indexOf('0')==0&&input.value.indexOf('0.')!=0) input.value=input.value.substring(0,1);  
	if(input.value.indexOf('.')!=-1) input.value=input.value.substring(0,input.value.indexOf('.')+1)+input.value.substring(input.value.indexOf('.')+1).replace(/\./g,'');
	if(input.value.indexOf('.')==0) input.value=input.value.substring(1);
	if(input.value==''){
		return 0;
	}else{
		return input.value;	
	}
}

function pre_sub1(input_id){//减值准备金额框调用的计算方法
	var input_value=decimalControl(input_id);
	document.getElementById('sum_re_presub').value=FormatNumberPoint(parseFloat(input_value)+parseFloat(cb_sum_re_presub),2);
	if(input_value=='') document.getElementById('sum_re_presub').value=FormatNumberPoint(parseFloat(cb_sum_re_presub),2);
	document.getElementById('ca_net_value').value=FormatNumberPoint(parseFloat(document.getElementById('original_value').value)-parseFloat(document.getElementById('caled_sum').value)-parseFloat(document.getElementById('sum_presub').value)+parseFloat(document.getElementById('sum_re_presub').value),2);
} 

function pre_sub2(obj){//验证减值准备金额数据的合法性
	if(parseFloat(document.getElementById('sum_re_presub').value)>parseFloat(document.getElementById('sum_presub').value)){
	alert('累计转回准备金额不能大于累计减值准备金额');
	obj.focus();
	return false;
	}
	if(parseFloat(document.getElementById('ca_net_value').value)<parseFloat(document.getElementById('remnant_value').value)){
	alert('可回收市值不能小于净残值');
	obj.focus();
	}
}

function FormatNumberPoint(srcStr,nAfterDot){//格式化显示数字，小数点后保存nAfterDot位小数
var   srcStr;
var nAfterDot;   
var   resultStr,nTen;   
srcStr   =   ""+srcStr+"";   
strLen   =   srcStr.length;   
dotPos   =   srcStr.indexOf(".",0); 
if(dotPos   ==   -1){
resultStr   =   srcStr+".";   
for(i=0;i<nAfterDot;i++){
resultStr = resultStr+"0";   
}   
return  resultStr;   
}   
else{   
if((strLen-dotPos-1)>=nAfterDot){
nTen=1;   
for(j=0;j<nAfterDot;j++){   
nTen=nTen*10;   
}   
resultStr =Math.round(parseFloat(srcStr)*nTen)/nTen;
resultStr   =   ""+resultStr+""; 
strLen   =   resultStr.length;   
dotPos   =   resultStr.indexOf(".",0);
for (i=0;i<(nAfterDot-strLen+dotPos+1);i++){   
resultStr=resultStr+"0";   
}
return   resultStr;   
}   
else{
resultStr=srcStr;   
for (i=0;i<(nAfterDot-strLen+dotPos+1);i++){   
resultStr=resultStr+"0";   
}   
return   resultStr;   
}   
}   
}

function returnReady_ok(){//提交数据库
var file_id=document.getElementById('file_id').value;
if(file_id==''){
	alert('固定资产编号不能为空');
	return false;
}
var file_name=document.getElementById('file_name').value;
var start_time=document.getElementById('start_time').value;
var specification=document.getElementById('specification').value;
var currency=document.getElementById('currency').value;
var currency_rate=document.getElementById('currency_rate').value;
var original_value=document.getElementById('original_value').value;
var caled_sum=document.getElementById('caled_sum').value;
var sum_presub=document.getElementById('sum_presub').value;
var sum_re_presub=document.getElementById('sum_re_presub').value;
var ca_net_value=document.getElementById('ca_net_value').value;
var re_pre_sub=document.getElementById('re_pre_sub').value;
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
xmlhttp3.open("POST", "../../../finance_fixed_assets_change_returnReady_ok", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('file_id='+file_id+'&file_name='+encodeURI(file_name)+'&start_time='+start_time+'&specification='+encodeURI(specification)+'&currency='+encodeURI(currency)+'&currency_rate='+currency_rate+'&original_value='+original_value+'&caled_sum='+caled_sum+'&sum_presub='+sum_presub+'&sum_re_presub='+sum_re_presub+'&ca_net_value='+ca_net_value+'&re_pre_sub='+re_pre_sub+'&change_reason='+encodeURI(change_reason)+'&change_date='+change_date+'&changer='+encodeURI(changer));
}
}