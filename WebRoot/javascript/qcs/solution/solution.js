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
    td.innerHTML = '<input name=\"'+td_array[i].id+'\" id=\"'+td_array[i].id+row_num+'\" type=\"text\" style=\"width: 100%; height: 100%;\" onkeydown=\"return false;\" onFocus=\"fo(this.id,\''+td_array[i].id+'\');\">';
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

function registerOk(form_id){
	var form=document.getElementById(form_id);
	form.action='../../qcs_solution_register_ok';
	if (doValidate('../../xml/qcs/qcs_solution.xml',form_id)){
	form.submit();
	}
}
function changeOk(form_id){
	var form =document.getElementById(form_id);
	form.action='../../qcs_solution_change_ok';
	if (doValidate('../../xml/qcs/qcs_solution.xml',form_id)){
	form.submit();
	}
}
function registerKeyOk(form_id){
	var form =document.getElementById(form_id);
	form.action='../../qcs_solution_register_key_ok';
	form.submit();
}



function setDetails(standard_id){
var table_obj = document.getElementById('bill_body');
var row_length=table_obj.rows.length;
for(var i=1;i<row_length;i++){
table_obj.deleteRow(1);
}
if(standard_id==''){return false;}
	var xmlhttp3;
if (window.XMLHttpRequest){
	xmlhttp3=new XMLHttpRequest();
	}else 
	if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");
}if(xmlhttp3) 
{xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){
	try {
	if(xmlhttp3.status==200){
	if(xmlhttp3.responseText=='179206725'){return false;}
var tr_array=xmlhttp3.responseText.split('⊙');
for(var i=0;i<tr_array.length;i++){
addRow('bill_body');
}
var table_obj_temp=document.getElementById('bill_body');
for(var m=1;m<table_obj_temp.rows.length;m++){
for(var mm=0;mm<table_obj_temp.rows[0].cells.length;mm++){
document.getElementById(table_obj_temp.rows[0].cells[mm].id+m).value=tr_array[m-1].split('◎')[mm];
}
}
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);
}
} catch(exception) {
	alert(exception);
	}
}
};
xmlhttp3.open("POST", "register_search.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('standard_id='+encodeURI(standard_id));
}
}