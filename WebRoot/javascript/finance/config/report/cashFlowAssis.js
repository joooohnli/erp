/*
  *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
 function register(){
    document.getElementById('register').style.display='block';
 }
 function inputControl(input_id){
	 var input=document.getElementById(input_id);
     input.value = input.value.replace(/[^0123456789$]/g,'');
 }
 function register_ok(){
var number_in_cash1_table=document.getElementById('number_in_cash1_table').value;
var first_kind_name=document.getElementById('first_kind_name').value;
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
    if(parseInt(xmlhttp3.responseText)==0){
	alert('保存成功');
	document.getElementById('register').style.display='none';
	window.location.reload();
	}else if(parseInt(xmlhttp3.responseText)==1){
	alert('项目行次或项目名称重复');
	}
}else{
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "../../../finance_config_report_cashFlowAssis_register_ok", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('number_in_cash1_table='+encodeURI(number_in_cash1_table)+'&first_kind_name='+encodeURI(first_kind_name));
}
}

function del(num){
var id_group='';

	for(var i=1;i<num;i++){
	if(document.getElementById(i).checked) id_group+=document.getElementById(i).value+'⊙';
	}
	
	if(id_group==''){
	document.getElementById('reconfirm').style.display='none';
	return false;
	} 
	id_group=id_group.substring(0,id_group.length-1);
	var xmlhttp3;
	if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
	xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
       if(parseInt(xmlhttp3.responseText)==0){alert('全部删除成功');}
       if(parseInt(xmlhttp3.responseText)==1){alert('部分删除成功');}
       if(parseInt(xmlhttp3.responseText)==2){alert('全部正在使用不能删除');}
       if(parseInt(xmlhttp3.responseText)==3){alert('请选择要删除的行!');}
       document.getElementById('reconfirm').style.display='none';
       window.location.reload();
	}else{
	alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
	xmlhttp3.open("POST", "../../../finance_config_report_cashFlowAssis_delete_ok", true);
	xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xmlhttp3.send('id_group='+id_group);
	}
}
