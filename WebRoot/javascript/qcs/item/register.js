/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
function loadAjaxDiv(input_id,kind,event){//弹出ajax动态查询数据库层
if(document.getElementById('result_div')!=null){document.body.removeChild(document.getElementById('result_div'));}
var obj1=document.getElementById(input_id);
    var w = obj1.offsetWidth;
    var h = obj1.offsetHeight;
    var   x   =   obj1.offsetLeft,   y   =   obj1.offsetTop;   
    while(obj1=obj1.offsetParent) 
    { 
       x   +=   obj1.offsetLeft;   
       y   +=   obj1.offsetTop;
    } 

var result_div=document.createElement('div');
	result_div.id='result_div';
	result_div.className='result_div1';
	if(input_id.indexOf('quality_result')!=-1||input_id.indexOf('unqualified_reason')!=-1){x=x-750;y=y+5;}
	result_div.style.top=y+18;
	result_div.style.left=x;
	result_div.style.width=w;
	document.body.appendChild(result_div);
	search_suggest(input_id,result_div,kind);
	if(document.attachEvent) document.attachEvent('onmousedown',closeResult,event);
	if(document.addEventListener) document.addEventListener('mousedown',closeResult,event);	
	
}

function search_suggest(input_id,div_obj,kind){//根据输入内容快速查询下拉层
if(kind!=''){
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200){
div_obj.innerHTML='';
if(parseInt(xmlhttp3.responseText)==179206725){
	div_obj.style.display='none';
	}else{
var div_options =xmlhttp3.responseText.split("\n");
var conter='';
for (var i = 0; i < div_options.length; i++) {
var suggest = '<div  onmouseover="style.backgroundColor=\'#E8F2FE\'" onmouseout="style.backgroundColor=\'\'"';
suggest += 'onclick=\"javascript:setSearch(this.innerHTML,\''+input_id+'\',\''+div_obj.id+'\');\" ';
suggest += '>' + div_options[i] + '</div>';
conter += suggest;
}
div_obj.innerHTML = null;
div_obj.innerHTML = '';
div_obj.innerHTML = conter;
}
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "register_search.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('kind='+encodeURI(kind)+'&&search_tag=0');
}
}
}
function setSearch(input_value,input_id,div_id){
	document.getElementById('QV_button').disabled=true;
	document.getElementById(input_id).value=input_value;
	document.getElementById(div_id).style.display='none';
	if(document.getElementById('analyse_method').value=='定性分析'){
	document.getElementById('QV_button').disabled=false;
	}
}
var row_id2='';
function addRow(table_id,query_tag,event) {//动态添加行
    var table_obj = document.getElementById(table_id);
    var td_array=table_obj.rows[0].getElementsByTagName('td');
    var row_num = table_obj.rows.length;
    var tr = table_obj.insertRow(table_obj.rows.length);
    tr.height = '25';
    tr.id = row_num;
    row_id1 = row_num;
    for(var i=0;i<td_array.length;i++){
    var td=tr.insertCell(-1);
    if(query_tag==0){
    td.innerHTML = '<input name=\"'+td_array[i].id+'\" id=\"'+td_array[i].id+row_num+'\" type=\"text\" style=\"width: 100%; height: 100%;\" onkeydown=\"return false;\" onFocus=\"fo(this.id,\''+td_array[i].id+'\');loadAjaxDiv(\''+td_array[i].id+row_num+'\',\'质检值\',event);\"><div class="select_div_r" id="defect_class_div"  onclick="loadAjaxDiv(\''+td_array[i].id+row_num+'\',\'质检值\',event)"></div>';
    }else{
    td.innerHTML = '<input name=\"'+td_array[i].id+'\" id=\"'+td_array[i].id+row_num+'\" type=\"text\" style=\"width: 100%; height: 100%;\" onkeydown=\"return false;\" onFocus=\"fo(this.id,\''+td_array[i].id+'\')\" readonly />';
    }
		
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


function setQV(qv_id,table_id){
var table_obj=document.getElementById(table_id);
var qv='';
for(var i=1;i<table_obj.rows.length;i++){
var qv_temp=document.getElementById(table_obj.rows[0].cells[0].id+i).value;
if(qv_temp!=''){
qv+='⊙'+qv_temp;
}
}
document.getElementById(qv_id).value=qv.substring(1);
document.getElementById('QV_div').style.display='none';
}

function showQVDiv(qv_id,table_id,query_tag,tag,event){
if(tag=='register'){
readXml('../../css/include/nseer_cookie/xml-css.css','../../xml/qcs/item/quality_value.xml','0');
}
var qv=document.getElementById(qv_id).value;
if(qv!=''){
var table_obj=document.getElementById(table_id);
var row_num=table_obj.rows.length;
for(var m=1;m<row_num;m++){table_obj.deleteRow(1);}
var qv_array=qv.split('⊙');
for(var i=0;i<qv_array.length;i++){
addRow(table_id,query_tag,event);
document.getElementById(table_obj.rows[0].cells[0].id+(i+1)).value=qv_array[i];
}
}
document.getElementById('QV_div').style.display='block';
}

function registerOk(){
document.getElementById('mutiValidation').action='../../qcs_item_register_ok';
if (doValidate('../../xml/qcs/qcs_item.xml','mutiValidation')){
document.getElementById('mutiValidation').submit();
}
}
function deleteOk(){
document.getElementById('mutiValidation').action='../../qcs_item_check_delete_ok';
document.getElementById('mutiValidation').submit();
}
