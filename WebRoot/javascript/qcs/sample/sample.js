/*
  *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
function addRow(table_id) {//动态添加行
    var table_obj = document.getElementById(table_id);
    var row_num = table_obj.rows.length;
    var td_array=table_obj.rows[0].cells;
    var tr = table_obj.insertRow(table_obj.rows.length);
    tr.height = '25';
    tr.id = row_num;
    for(var i=0;i<td_array.length;i++){
    var td=tr.insertCell(-1);
	if (i > 4) {
		td.innerHTML = '<input name=\"' + td_array[i].id + '\" id=\"' + td_array[i].id + row_num + '\" type=\"text\" style=\"width: 100%; height: 100%;\" />';
	}else{
		td.innerHTML = '<input name=\"' + td_array[i].id + '\" id=\"' + td_array[i].id + row_num + '\" type=\"text\" style=\"width: 100%; height: 100%;\" readonly>';		
	}
	}      
}
function loadDiv(input_id,event){//弹出ajax动态查询数据库层
if(document.getElementById('result_div')!=null){document.body.removeChild(document.getElementById('result_div'));}
    var input_obj=document.getElementById(input_id);
    var w = input_obj.offsetWidth;
    var h = input_obj.offsetHeight;
    var x=input_obj.offsetLeft,y=input_obj.offsetTop;   
    while(input_obj=input_obj.offsetParent){
       x+=input_obj.offsetLeft;
       y+=input_obj.offsetTop;
    }
	var result_div=document.createElement('div');
	result_div.id='result_div';
	result_div.className='result_div1';
	result_div.style.top=y+18;
	result_div.style.left=x;
	result_div.style.width=w;
	search_suggest(input_id,result_div);
	document.body.appendChild(result_div);
	if(document.attachEvent) document.attachEvent('onmousedown',closeResult,event);
	if(document.addEventListener) document.addEventListener('mousedown',closeResult,event);	
}

function search_suggest(input_id,obj){//根据输入内容快速查询摘要写入下拉层
var input_obj=document.getElementById(input_id);
var input_value=input_obj.value;
if(input_obj!=null){
var search_tag;
var send_temp=null;
if(input_obj.id=='quality_type'){
	send_temp='kind=15&&search_tag=0';
}else if(input_obj.id=='apply_id'){
	if (document.getElementById('quality_type') == null || document.getElementById('quality_type').value == '') {
		document.getElementById('apply_id').value='';
		alert('请您选择质检类型!');
		obj.style.display='none';
		return false;
	}
	var reason=document.getElementById('quality_type').value.split('/')[0];
	send_temp='reason='+encodeURI(reason)+'&&keyword='+encodeURI(input_value)+'&&search_tag=1';
}
var xmlhttp;
if(window.XMLHttpRequest){xmlhttp=new XMLHttpRequest();}else if (window.ActiveXObject){xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp) {xmlhttp.onreadystatechange = function() {
if (xmlhttp.readyState==4){try {if(xmlhttp.status==200){
obj.innerHTML='';
if(parseInt(xmlhttp.responseText)==0){
	input_obj.value='';
	obj.style.display='none';
}else{
var div_options =xmlhttp.responseText.split("\n");
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
alert( xmlhttp.status + '=' + xmlhttp.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp.open("POST", "register_search.jsp", true);
xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp.send(send_temp);
}
}else{
document.body.removeChild(document.getElementById(obj.id));
}
}
function setSearch(input_value,input_id,div_id){
	document.getElementById(input_id).value=input_value;
	document.body.removeChild(document.getElementById(div_id));	
	if(input_id=='apply_id'){
var xmlhttp;
if(window.XMLHttpRequest){xmlhttp=new XMLHttpRequest();}else if (window.ActiveXObject){xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp) {xmlhttp.onreadystatechange = function() {
	if (xmlhttp.readyState==4){try {if(xmlhttp.status==200){
		var table_obj = document.getElementById('bill_body');
    	var row_num = table_obj.rows.length;
		if(row_num>1){for(var i=1;i<row_num;i++){table_obj.deleteRow(1);}}
		if(parseInt(xmlhttp.responseText)==0){return false;}
		addRow('bill_body');
		document.getElementById('sample_lable1').value=xmlhttp.responseText.split('⊙')[0];
		document.getElementById('product_id1').value=xmlhttp.responseText.split('⊙')[1];
		document.getElementById('product_name1').value=xmlhttp.responseText.split('⊙')[2];
		document.getElementById('amount_unit1').value=xmlhttp.responseText.split('⊙')[3];
		document.getElementById('sumtotal1').value=xmlhttp.responseText.split('⊙')[4];
	}else {alert( xmlhttp.status + '=' + xmlhttp.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp.open("POST", "register_search.jsp", true);
xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp.send('apply_id='+encodeURI(input_value)+'&&search_tag=2');}
}
}
function showFormSubmit(action_tag,validiteXml,formID){
	if(doValidate(validiteXml,formID)){
	var form=null;
	var form_id;
	if(action_tag=='register'){
		form=document.getElementById('sample_register');
		form.action='../../qcs_sample_register_ok';
	}else if(action_tag=='check'){
		form=document.getElementById('sample_check');
		form.action='../../qcs_sample_check_ok';
	}else if(action_tag=='dealwith'){
		form=document.getElementById('sample_dealwith');
		form.action='../../qcs_sample_dealwith_ok';
	}
	form.submit();
	}
}
