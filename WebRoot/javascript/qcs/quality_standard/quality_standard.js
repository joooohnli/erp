/*
  *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
var row_id2='';
function addRow(table_id) {//动态添加行
    var table_obj = document.getElementById(table_id);
    var td_array=table_obj.rows[0].getElementsByTagName('td');
    var row_num = table_obj.rows.length;
    var tr = table_obj.insertRow(table_obj.rows.length);
    tr.height = '25';
    tr.id = row_num;
    for(var i=0;i<td_array.length;i++){
    var td=tr.insertCell(-1);
    td.innerHTML = '<input name=\"'+td_array[i].id+'\" id=\"'+td_array[i].id+row_num+'\" type=\"text\" style=\"width: 100%; height: 100%;\" onkeyup=\"return searchQV(this,\''+td_array[i].id+'\');\" onFocus=\"fo(this.id,\''+td_array[i].id+'\');\">';
    if(i==td_array.length-1){td.innerHTML+='<input type=\"hidden\" id=\"id_hidden_'+row_num+'\" name=\"item_id\">';}
    }   
}
function fo(this_id,td_id){
	row_id2=this_id.substring(td_id.length);
	showMSdiv(this_id,td_id);
}
function deleteSelect(table_id) {//删除选定的行，并对所有行和相关层重新排序
     var table_obj = document.getElementById(table_id);
	 if (row_id2 != ''){
     	var item_id=document.getElementById('id_hidden_'+row_id2).value;
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
    document.getElementById('m_div').style.display='none';
    row_id2 = '';
}
function showMSdiv(input_id,td_id){
	var obj1=document.getElementById(input_id);
    var w = obj1.offsetWidth;
    var h = obj1.offsetHeight;
    var x=obj1.offsetLeft,y=obj1.offsetTop;   
    while(obj1=obj1.offsetParent){ 
       x+=obj1.offsetLeft;   
       y+=obj1.offsetTop;
    }
    var m_obj=document.getElementById('m_div');    	
    m_obj.style.display='none';
    if(td_id=='item'){	
		m_obj.style.top=y+3;
		m_obj.style.left=x+w-19;
		m_obj.style.width='18px';
		m_obj.style.display='block';
		m_obj.onclick=showItemDiv;
    }
}
function searchQV(input_obj,td_id){
	if(td_id=='standard_value'||td_id=='standard_max'||td_id=='standard_min'){
		loadDiv(input_obj);
	}else{
		input_obj.value='';
		return false;
	}
}
function showItemDiv(){
	document.getElementById('item_div').style.display='block';
}
function selectIn(tr_obj,item_id){
	var item_arry=document.getElementsByName('item_id');
	for(var i=0;i<item_arry.length;i++){
	if(item_arry[i].value==item_id){alert('已选择!');return;}
	}
	document.getElementById('item'+row_id2).value=tr_obj.cells[0].innerHTML;	
	document.getElementById('analyse_method'+row_id2).value=tr_obj.cells[1].innerHTML;
	document.getElementById('default_basis'+row_id2).value=tr_obj.cells[2].innerHTML;
	document.getElementById('ready_basis'+row_id2).value=tr_obj.cells[3].innerHTML;
	document.getElementById('quality_method'+row_id2).value=tr_obj.cells[4].innerHTML;
	document.getElementById('item_div').style.display='none';
	document.getElementsByName('item_id')[row_id2-1].value=item_id;
}
function loadDiv(input_obj){//弹出ajax动态查询数据库层
	var input_obj_temp=input_obj;
    var w = input_obj.offsetWidth;
    var h = input_obj.offsetHeight;
    var x=input_obj.offsetLeft,y=input_obj.offsetTop;   
    while(input_obj=input_obj.offsetParent){
       x+=input_obj.offsetLeft;
       y+=input_obj.offsetTop;
    }
	var obj=document.getElementById('result_div');
	obj.style.top=y+24;
	obj.style.left=x;
	obj.style.width=w;	
	search_suggest(input_obj_temp,obj);
}

function search_suggest(input_obj,obj){//根据输入内容快速查询摘要写入下拉层
if(input_obj.value!=''){
var kind='质检值';
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
obj.innerHTML='';
if(parseInt(xmlhttp3.responseText)==179206725){
	input_obj.value='';
	obj.style.display='none';
	}else{
var div_options =xmlhttp3.responseText.split("\n");
var conter='';
for (var i = 0; i < div_options.length; i++) {
var suggest = '<div  onmouseover="style.backgroundColor=\'#E8F2FE\'" onmouseout="style.backgroundColor=\'\'"';
suggest += 'onclick=\"javascript:setSearch(this.innerHTML,\''+input_obj.id+'\',\''+obj.id+'\');\" ';
suggest += '>' + div_options[i] + '</div>';
conter += suggest;
}
obj.innerHTML = null;
obj.innerHTML = '';
obj.innerHTML = conter;
obj.style.display='block';
}
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "register_search.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('kind='+encodeURI(kind)+'&&keyword='+encodeURI(input_obj.value));
}
}else{
obj.style.display='none';	
}
}

function setSearch(input_value,input_id,div_id){
	document.getElementById(input_id).value=input_value;
	document.getElementById(div_id).style.display='none';	
}
function registerOk(form_id){
	var form=document.getElementById(form_id);
	form.action='../../qcs_quality_standard_register_ok';
if (doValidate('../../xml/qcs/qcs_quality_standard.xml',form_id)){
	form.submit();
}
}
function changeOk(form_id){
	var form =document.getElementById(form_id);
	form.action='../../qcs_quality_standard_change_ok';
if (doValidate('../../xml/qcs/qcs_quality_standard.xml',form_id)){	
	form.submit();
}
}
function registerKeyOk(form_id){
	var form=document.getElementById(form_id);
	form.action='../../qcs_quality_standard_register_key_ok';
	form.submit();
}