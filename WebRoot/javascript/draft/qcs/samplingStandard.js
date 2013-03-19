/*
  *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
var row_id1='';
var row_id2='';
function addRow(table_id) {//动态添加行
    var table_obj = document.getElementById(table_id);
    var td_array=table_obj.rows[0].getElementsByTagName('td');
    var row_num = table_obj.rows.length;
    var tr = table_obj.insertRow(table_obj.rows.length);
    tr.height = '25';
    tr.id = row_num;
    row_id1 = row_num;
    for(var i=0;i<td_array.length;i++){
    var td=tr.insertCell(-1);
		td.innerHTML = '<input name=\"'+td_array[i].id+'\" id=\"'+td_array[i].id+row_num+'\" type=\"text\" style=\"width: 100%; height: 100%;\" onkeyup=\"decimalControl(this.id);\" onFocus=\"fo(this.id,\''+td_array[i].id+'\')\">';
    }
    var td_value=document.getElementById('method_id').value;
    if(td_value=='02/公式计算'||td_value=='03/自定义'){
    var sampling_obj=document.getElementById(td_array[1].id+row_num);
    var formula_obj=document.getElementById(td_array[2].id+row_num);
    if(td_value=='02/公式计算'){
    sampling_obj.onfocus=function(){sampling_obj.blur();};
    }
    formula_obj.onfocus=function(){formula_obj.blur();};
    } 
}
function fo(this_id,td_id){
	row_id2=this_id.substring(td_id.length);
}

function deleteSelect(table_id) {//删除选定的行，并对所有行和相关层重新排序
     var table_obj = document.getElementById(table_id);
	 if (row_id2 != ''){
	 	table_obj.deleteRow(row_id2);
     	var td0_array=table_obj.rows[0].getElementsByTagName('td');
     	var row_num = table_obj.rows.length;
     	for(var i=1;i<row_num;i++){
     		var td_array=table_obj.rows[i].getElementsByTagName('td');     		
     		for(var j=0;j<td_array.length;j++){
     		var input_array=td_array[j].getElementsByTagName('input');
     		input_array[0].id=td0_array[j].id+i;
     		var fo_temp='fo(\''+input_array[0].id+'\',\''+td0_array[j].id+'\')';
     		td_array[j].onfocus=function(){eval(fo_temp);};
     		}
     	}
	  } else {
        alert('\u8bf7\u9009\u62e9\u8981\u5220\u9664\u7684\u884c\uff01');
    }
    row_id2 = '';
}
function addAqlRow(obj,table_id,table_id1) {//抽样方法的onchange事件
    var table_obj = document.getElementById(table_id);
    var row_length=table_obj.rows.length;
    if(table_obj.rows.length>2){
    for(var i=2;i<row_length;i++){
    table_obj.deleteRow(2);
    }
    }
    var table_obj1=document.getElementById(table_id1);
    var row_length1=table_obj1.rows.length;
    if(row_length1>1){
    for(var i=1;i<row_length1;i++){
    table_obj1.deleteRow(1);
    }
    }
    if(table_obj1.rows[0].cells.length<5){
    table_obj1.rows[0].insertCell(2);
    }
    var td_array=table_obj1.rows[0].getElementsByTagName('td');
    td_array[0].id='batch';
    td_array[1].id='sample';
    td_array[2].id='formula';
    td_array[3].id='accept';
    td_array[4].id='reject';
    td_array[0].innerHTML='批量数';
    td_array[1].innerHTML='样本数';
    td_array[2].innerHTML='抽样公式';
    td_array[3].innerHTML='允收数';
    td_array[4].innerHTML='拒收数';
    
    document.getElementById('add_button').disabled=false;
	document.getElementById('del_button').disabled=false;
	document.getElementById('formula_button').disabled=true;
    if(obj.value=='03/自定义'||obj.value=='04/国标'){
    initBillHead(obj.id,table_id,table_id1);
	
	if(obj.value=='04/国标'){		
		var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
var batch_amount_array=xmlhttp3.responseText.split('⊙');
for(var i=0;i<batch_amount_array.length;i++){
	addRow(table_id1);
	var bill_body=document.getElementById(table_id1);
	var max_input=document.getElementById('batch'+(i+1));
	max_input.value=batch_amount_array[i];
	max_input.onfocus=function(){this.blur();};
	var accept_input=document.getElementById('accept'+(i+1));
	var reject_input=document.getElementById('reject'+(i+1));
	var sample_input=document.getElementById('sample'+(i+1));
	accept_input.onfocus=function(){this.blur();};
	reject_input.onfocus=function(){this.blur();};
	sample_input.onfocus=function(){this.blur();};
}


}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "samplingStandard_search.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('search_tag=1');
}
	}	
	}
	if(obj.value=='01/固定数量'){
		document.getElementById('add_button').disabled=true;
		document.getElementById('del_button').disabled=true;
		document.getElementById('formula_button').disabled=true;
		table_obj1.rows[0].deleteCell(2);
		addRow(table_id1);
		var batch_amount_obj=document.getElementById(table_obj1.rows[0].cells[0].id+'1');
		batch_amount_obj.value='∞';
		batch_amount_obj.onfocus=function(){batch_amount_obj.blur();};
	}
	if(obj.value=='02/公式计算'){
	document.getElementById('formula_button').disabled=false;
	}
}

function loadDiv(input_id,div_id,kind){//弹出ajax动态查询数据库层
if(document.getElementById('result_div')=='undefined'||document.getElementById('result_div')==null){
var div=document.createElement('div');
div.style.cssText='position:absolute;display:none;background:yellow;height:80px; filter:alpha(opacity=80); overflow-y: auto; overflow-x: hidden;';
div.id='result_div';
div.style.display='none';
document.body.appendChild(div);
}
if(input_id!='level_id'&&(document.getElementById('level_id').value==''||document.getElementById('level_id').value==null)){
alert('请选择质检水平!');
return false;
}else if(input_id=='aql_id'&&(document.getElementById('class_id').value==''||document.getElementById('class_id').value==null)){
alert('请选择严格度!');
return false;
}
var obj1=document.getElementById(input_id);
    var w = obj1.offsetWidth;
    var h = obj1.offsetHeight;  

    var   x   =   obj1.offsetLeft,   y   =   obj1.offsetTop;   
    while(obj1=obj1.offsetParent) 
    { 
       x   +=   obj1.offsetLeft;   
       y   +=   obj1.offsetTop;
    } 
var obj=document.getElementById(div_id);
var t=y+19,l=x;
obj.style.top=t+'px';
obj.style.left=l+'px';
obj.style.width=w;
obj.style.display='block';
search_suggest(input_id,obj,kind);
if(document.attachEvent) document.attachEvent('onmousedown',closeResult,event);
}

function search_suggest(input_id,obj,kind){//根据输入内容快速查询摘要写入下拉层
if(kind!=''){
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
obj.innerHTML='';
if(parseInt(xmlhttp3.responseText)==179206725){
	obj.style.display='none';
	}else{
var div_options =xmlhttp3.responseText.split("\n");
var conter='';
for (var i = 0; i < div_options.length; i++) {
var suggest = '<div  onmouseover="style.backgroundColor=\'#E8F2FE\'" onmouseout="style.backgroundColor=\'\'"';
suggest += 'onclick=\"javascript:setSearch(this.innerHTML,\''+input_id+'\',\''+obj.id+'\');\" ';
suggest += '>' + div_options[i] + '</div>';
conter += suggest;
}
obj.innerHTML = null;
obj.innerHTML = '';
obj.innerHTML = conter;
	}

}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "samplingStandard_search.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('kind='+encodeURI(kind)+'&&search_tag=0');
}
}
}


function setSearch(obj,obj1,obj2){
	document.getElementById(obj1).value=obj;
	document.getElementById(obj2).style.display='none';
	if(document.getElementById('method_id').value=='04/国标'){
	if(obj1=='level_id'){
	var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {

var batch_amount_array=xmlhttp3.responseText.split('⊙');
for(var i=0;i<batch_amount_array.length;i++){
	var bill_body=document.getElementById('bill_body');
	var max_input=document.getElementById('sample_max'+(i+1));
	max_input.value=batch_amount_array[i];
	max_input.onfocus=function(){this.blur();};
}


}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "samplingStandard_search.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('type_name='+encodeURI(obj)+'&&search_tag=2');
}
	}else if((obj1=='aql_id'||obj1=='class_id')&&document.getElementById('aql_id').value!=''){
var bill_body=document.getElementById('bill_body');	
for(var i=1;i<bill_body.rows.length;i++){
document.getElementById('sample'+i).value='';
document.getElementById('accept'+i).value='';
document.getElementById('reject'+i).value='';
}
	
	var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
var s_array=xmlhttp3.responseText.split('◎');
for(var i=1;i<bill_body.rows.length;i++){
var max_input=document.getElementById('sample_max'+i);
for(var j=0;j<s_array.length;j++){
if(max_input.value==s_array[j].split('⊙')[0]){
document.getElementById('sample'+i).value=s_array[j].split('⊙')[1];
document.getElementById('accept'+i).value=s_array[j].split('⊙')[2];
document.getElementById('reject'+i).value=s_array[j].split('⊙')[3];
}
}
}
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "samplingStandard_search.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('type_name='+encodeURI(document.getElementById('class_id').value)+'&&aql='+encodeURI(document.getElementById('aql_id').value)+'&&search_tag=3');
}
	
	
	}
	}
}
function decimalControl(input_id){//金额类录入框输入控制(负数除外)  
	var input=document.getElementById(input_id);
    input.value = input.value.replace(/[^0123456789.$]/g,'');
    if(input.value.indexOf("0")==0&&input.value.indexOf("0.")!=0) input.value=input.value.substring(0,1);  
	if(input.value.indexOf(".")!=-1) input.value=input.value.substring(0,input.value.indexOf(".")+1)+input.value.substring(input.value.indexOf(".")+1).replace(/\./g,'');
	if(input.value.indexOf(".")==0) input.value=input.value.substring(1);
	if(input.value==''){
		return 0;
	}else{
		return input.value;	
	}
}
function showFormulaDiv(div_id){
if(row_id2!=''){
document.getElementById('formula_div').style.display='block';
document.getElementById('formula_id').value=document.getElementById('formula'+row_id2).value;
}
}
function writeIn(value){
var formula_value = document.getElementById('formula_id').value;
document.getElementById('formula_id').value=formula_value+value;

}
function formulaOk(){
var batch_amount;
var user_formula;
	if(row_id2==''){
		alert('请选择当前行');
	}else{
	    
		user_formula=document.getElementById('formula_id').value;
		batch_amount=document.getElementById('batch'+row_id2).value;
		if(user_formula==''){
		document.getElementById('sample'+row_id2).value='';
		}else{
		document.getElementById('sample'+row_id2).value=eval(user_formula.replace(/批量数/g,batch_amount));
		}
		document.getElementById('formula'+row_id2).value=user_formula;
		document.getElementById('formula_div').style.display='none';
	}
}


function searchByAjax(url,params,fun){
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
var xml_return=xmlhttp3.responseText;
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "samplingStandard_search.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('kind='+encodeURI(kind));
}
}
function registerOk(){
var form = document.getElementById('mutiValidation');
form.action='../../qcs_sampling_standard_register_ok';
if (doValidate('../../xml/qcs/qcs_sampling_standard.xml', 'mutiValidation')){
	form.submit();
}
}

function initBillHead(obj_id,table_id,table_id1){
var table_obj = document.getElementById(table_id);
var table_obj1 = document.getElementById(table_id1);
var obj = document.getElementById(obj_id);
if(obj.value=='03/自定义'||obj.value=='04/国标'){
    var tr = table_obj.insertRow(table_obj.rows.length);
    var td1=tr.insertCell(-1);
    td1.align='right';
	td1.innerHTML = '质检水平：';
	var td2=tr.insertCell(-1);
	td2.innerHTML = '<input class="INPUT_STYLE3" id="level_id" name="level_id" type="text" value="" onfocus=\"loadDiv(\'level_id\',\'result_div\',\'质检水平\');this.blur();\" /><div style=\"background-image:url(/erp/images/selectArrow.gif);cursor:hand;padding-top:3px;left:402px;width:15px;position:absolute;" id="level_id_div" onclick=\"loadDiv(\'level_id\',\'result_div\',\'质检水平\')\"></div>';
	var td3=tr.insertCell(-1);
	td3.align='right';
	td3.innerHTML = '严格度：';
	var td4=tr.insertCell(-1);
	td4.innerHTML = '<input class="INPUT_STYLE3" id="class_id" name="class_id" type="text" value="" onfocus=\"loadDiv(\'class_id\',\'result_div\',\'严格度\');this.blur();\"/><div style=\"background-image:url(/erp/images/selectArrow.gif);cursor:hand;padding-top:3px;left:785px;width:15px;position:absolute;" id="class_id_div" onclick=\"loadDiv(\'class_id\',\'result_div\',\'严格度\')\"></div>';
	var tr1 = table_obj.insertRow(table_obj.rows.length);
	var td5=tr1.insertCell(-1);
	td5.align='right';
	td5.innerHTML = 'AQL：';
	var td6=tr1.insertCell(-1);
	td6.innerHTML = '<input class="INPUT_STYLE3" id="aql_id" name="aql_id" type="text" value="" onfocus=\"loadDiv(\'aql_id\',\'result_div\',\'AQL\');this.blur();\" /><div style=\"background-image:url(/erp/images/selectArrow.gif);cursor:hand;padding-top:3px;left:402px;width:15px;position:absolute;" id="aql_id_div"  onclick=\"loadDiv(\'aql_id\',\'result_div\',\'AQL\')\"></div>';
	if(obj.value=='04/国标'){
		table_obj1.rows[0].cells[1].innerHTML='样本大小字码';
		table_obj1.rows[0].cells[1].id='sample_max';
		table_obj1.rows[0].cells[2].innerHTML='样本数';
		table_obj1.rows[0].cells[2].id='sample';
	}
	}else if(obj.value=='01/固定数量'){
		document.getElementById('add_button').disabled=true;
		document.getElementById('del_button').disabled=true;
		document.getElementById('formula_button').disabled=true;
		table_obj1.rows[0].deleteCell(2);
		}
		locateSelectDiv();
}

function locateSelectDiv(){
var divs=document.getElementsByTagName('div');
	for(var i=0;i<divs.length;i++){
		if(document.getElementById(divs[i].id.substring(0,divs[i].id.length-4))){
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
obj.style.top=y;
obj.style.left=x+w-15;
}

function closeResult(event){
	var scrollTop=parseInt(getScrollTop());
	var port_X=parseInt(event.clientX);
	var port_Y=parseInt(event.clientY)+scrollTop;
	if(document.getElementById('result_div')!=undefined){
	var div=document.getElementById('result_div');
	var div_w=parseInt(div.style.width);
	var div_h=parseInt(getRStyle(div,'height','height'));
	var div_l=parseInt(div.style.left);
	var div_t=parseInt(div.style.top);
	if(port_X<div_l||port_X>(div_l+div_w)||port_Y<div_t||port_Y>(div_t+div_h)){
		document.getElementById('result_div').innerHTML='';
		document.getElementById('result_div').style.display='none';
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