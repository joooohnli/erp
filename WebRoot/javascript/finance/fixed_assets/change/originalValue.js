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
xmlhttp3.open("POST", "originalValue_search.jsp", true);
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
	document.getElementById('currency').value=options[3];
	document.getElementById('cb_original_value').value=options[4];
	document.getElementById('cb_remnant_value').value=options[5];
	options[6]=parseFloat(options[6])*100;
	document.getElementById('cremnant_value_rate').value=options[6]+'%';
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "originalValue_search.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('keyword='+encodeURI(obj1)+'&tag=1');
}
}

function not_choose(){//判断手工录入固定资产编号是否合法
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
	document.getElementById('currency').value=options[3];
	document.getElementById('cb_original_value').value=options[4];
	document.getElementById('cb_remnant_value').value=options[5];
	options[6]=parseFloat(options[6])*100;
	document.getElementById('cremnant_value_rate').value=options[6]+'%';
	}else{
		document.getElementById('file_id').focus();
		alert('该固定资产编号有误');
		return false;
	}
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "originalValue_search.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('keyword='+encodeURI(document.getElementById('file_id').value)+'&tag=1');
}
}

function change_amount1(obj){//输入变动金额开始计算
	if(document.getElementById('cb_original_value').value==''){
		obj.value='';
		alert('请先正确填写固定资产编号');
		document.getElementById('file_id').focus();
		return false;
	}
	var change_type=document.getElementById('change_type').value;
	if(obj.value==''){
	if(change_type==0){
		document.getElementById('ca_original_value').value=document.getElementById('cb_original_value').value;
	}else{
		document.getElementById('ca_original_value').value=document.getElementById('cb_original_value').value;
	}
	}else{
	if(change_type==0){
		document.getElementById('ca_original_value').value=parseFloat(document.getElementById('cb_original_value').value)+parseFloat(decimalControl(obj.id));
	}else{
		document.getElementById('ca_original_value').value=parseFloat(document.getElementById('cb_original_value').value)-parseFloat(obj.value);
	}
	document.getElementById('ca_remnant_value').value=parseFloat(document.getElementById('ca_original_value').value)*parseFloat(document.getElementById('cremnant_value_rate').value.substring(0,document.getElementById('cremnant_value_rate').value.length-1))/100;
	if(change_type==0){
	document.getElementById('cremnant_value').value=FormatNumberPoint(parseFloat(document.getElementById('ca_remnant_value').value)-parseFloat(document.getElementById('cb_remnant_value').value),2);
	}else{
	document.getElementById('cremnant_value').value=FormatNumberPoint(parseFloat(document.getElementById('cb_remnant_value').value)-parseFloat(document.getElementById('ca_remnant_value').value),2);
	}
	
	}
	
}

function decimalControl(input_id){//金额类录入框输入控制  
  var input=document.getElementById(input_id);
     input.value = input.value.replace(/[^-0123456789.$]/g,'');
    if(input.value.indexOf('0')==0)  input.value=input.value.substring(1);
    if(input.value.indexOf('-')==0) {
    input.value='-'+input.value.replace(/-/g,'');
    }else{
    input.value=input.value.replace(/-/g,'');
    }
	if(input.value.indexOf('.')!=-1) input.value=input.value.substring(0,input.value.indexOf('.')+1)+input.value.substring(input.value.indexOf('.')+1).replace(/\./g,'');
	if(input.value.indexOf('.')==0) input.value=input.value.substring(1);
	if(input.value==''){
	return 0;
	}else{
	return input.value;
	}
}  

function type_change(){//变动类型的改变清空已录入和页面计算的值
	document.getElementById('change_amount').value='';
	document.getElementById('cremnant_value').value='';
	document.getElementById('ca_original_value').value='';
	document.getElementById('ca_remnant_value').value='';
}

function amount_blur(obj){//变动金额录入框失焦后作判断
	var change_type=document.getElementById('change_type').value;
	if(change_type=='1'){
		if(decimalControl(obj.id)>=parseFloat(document.getElementById('cb_original_value').value)){
		alert('变动金额不能大于变动前原值');
		obj.focus();
		}
	}
}

function originalValue_ok(formId,fileName,validateXml){//提交数据库
	if(doValidate(validateXml,formId)){
var file_id=document.getElementById('file_id').value;
var file_name=document.getElementById('file_name').value;
var start_time=document.getElementById('start_time').value;
var change_type=document.getElementById('change_type').value;
var specification=document.getElementById('specification').value;
var change_amount=document.getElementById('change_amount').value;
var currency=document.getElementById('currency').value;
var currency_rate=document.getElementById('currency_rate').value;
var cremnant_value_rate=document.getElementById('cremnant_value_rate').value;
var cremnant_value=document.getElementById('cremnant_value').value;
var cb_original_value=document.getElementById('cb_original_value').value;
var ca_original_value=document.getElementById('ca_original_value').value;
var cb_remnant_value=document.getElementById('cb_remnant_value').value;
var ca_remnant_value=document.getElementById('ca_remnant_value').value;
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
xmlhttp3.open("POST", fileName, true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('file_id='+file_id+'&file_name='+encodeURI(file_name)+'&start_time='+start_time+'&change_type='+encodeURI(change_type)+'&specification='+encodeURI(specification)+'&change_amount='+change_amount+'&currency='+encodeURI(currency)+'&currency_rate='+currency_rate+'&cremnant_value_rate='+encodeURI(cremnant_value_rate)+'&cremnant_value='+cremnant_value+'&cb_original_value='+cb_original_value+'&ca_original_value='+ca_original_value+'&cb_remnant_value='+cb_remnant_value+'&ca_remnant_value='+ca_remnant_value+'&change_reason='+encodeURI(change_reason)+'&change_date='+change_date+'&changer='+encodeURI(changer));
}
}
}

function FormatNumberPoint(srcStr,nAfterDot){//格式化显示数字，小数点后保存nAfterDot位小数
var   srcStr;
var nAfterDot;   
var   resultStr,nTen;   
srcStr   =   ""+srcStr+"";   
strLen   =   srcStr.length;   
dotPos   =   srcStr.indexOf('.',0); 
if(dotPos   ==   -1){
resultStr   =   srcStr+'.';   
for(i=0;i<nAfterDot;i++){
resultStr = resultStr+'0';   
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