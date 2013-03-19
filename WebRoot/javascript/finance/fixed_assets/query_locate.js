/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
var temp_time='';
function search_suggest1(id){//根据输入内容快速查询固定资产编号写入下拉层
alert('ddd');
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
cla.style.display = 'block';
	}
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "query_search.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('keyword='+encodeURI(keyword)+'&tag=0');
}
}
}

function setSearch(obj1,obj2){//关闭下拉层后,给录入框赋原值
	document.getElementById(obj2).value=obj1;
	document.getElementById('search_suggest').style.display='none';
}

function id_link(id){//根据固定资产编号查询finance_fa_file表
if(document.getElementById('file_details').style.display!='none'){
return false;
}
var keyword=id;
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
	//alert(xmlhttp3.responseText);
	var options =xmlhttp3.responseText.split('⊙');
	if(options[29]=='1800-01-01 00:00:00.0'){
		options[29]='没有变更';
	}
	document.getElementById('type_name').innerHTML=options[1];
	document.getElementById('file_id').innerHTML=options[2];
	document.getElementById('file_name').innerHTML=options[3];
	document.getElementById('addway').innerHTML=options[5];
	document.getElementById('department').innerHTML=options[7];
	document.getElementById('specification').innerHTML=options[8];
	document.getElementById('deposit_place').innerHTML=options[9];
	document.getElementById('status').innerHTML=options[10];
	document.getElementById('start_time').innerHTML=options[11];
	document.getElementById('calway').innerHTML=options[12];
	document.getElementById('life_cycle').innerHTML=options[13];
	document.getElementById('currency').innerHTML=options[14];
	document.getElementById('original_value').innerHTML=options[15];
	document.getElementById('remnant_value_rate').innerHTML=parseFloat(options[16])*100+'%';
	document.getElementById('remnant_value').innerHTML=options[17];
	document.getElementById('caled_month').innerHTML=options[18];
	document.getElementById('caled_sum').innerHTML=options[19];	
	document.getElementById('caled_subtotal').innerHTML=options[20];
	document.getElementById('net_value').innerHTML=options[22];
	document.getElementById('cal_file_name').innerHTML=options[24];
	document.getElementById('lately_change_time').innerHTML='<span id=\"last_change_time\" style=\"width:100%;height:100%;cursor:hand;color:blue;\" onClick=\"history1(\''+options[2]+'\',\''+options[29]+'\')\">'+options[29]+'</span>';
	document.getElementById('change_amount').innerHTML='<span id=\"change_count\" style=\"width:100%;height:100%;cursor:hand;color:blue;\" onClick=\"history1(\''+options[2]+'\',\''+options[29]+'\')\">'+options[30]+'</span>';
	if(options[25]!=''){
		var tr=document.getElementById('theObjTable').insertRow(11);
	 tr.height='20px';
	var tr1 = document.getElementById('theObjTable').insertRow(12);
	 tr1.height='20px';
	td=tr.insertCell(-1);
	td.innerHTML='工作总量';
	td.id='work_total';
	td.background='../../images/line7.gif';
	tr.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[25]+'</div>';
	td1=tr.insertCell(-1);
	td1.background='../../images/line7.gif';
	td1.innerHTML='累计工作量';
	tr.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[26]
+' </div>';
		
	td2=tr1.insertCell(-1);
	td2.innerHTML='工作量单位';
	td2.background='../../images/line7.gif';
	tr1.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[27]+'</div>';
	td3=tr1.insertCell(-1);
	td3.background='../../images/line7.gif';
	td3.innerHTML='单位折旧';
	tr1.insertCell(-1).innerHTML='<span style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[28]+'</div>';
	}else{
		var sta=document.getElementById('theObjTable');
		var tr=sta.getElementsByTagName('tr')[11];
	tr.getElementsByTagName('td')[0].innerHTML='月折旧率';
	tr.getElementsByTagName('td')[1].innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[21]+'</div>';	
	}

	$('#file_details').Grow(500);
	return false;
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "query_search.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('keyword='+keyword+'&tag=1');
}
}

function close_clear(){
var sta=document.getElementById('theObjTable').rows.length;
   if(document.getElementById('work_total')!=undefined){
   for(var i=11;i<sta-3;i++){
   document.getElementById('theObjTable').deleteRow(11);
   }
   }else{
   		var sta=document.getElementById('theObjTable');
		var tr=sta.getElementsByTagName('tr')[11];
	tr.getElementsByTagName('td')[0].innerHTML='';
	tr.getElementsByTagName('td')[1].innerHTML='';
   }
   $('#file_details').Shrink(200);
	return false;
}

function history1(file_id,change_time1){//查询固定资产的所有变动记录
var change_time=change_time1;
if(temp_time!='') change_time=temp_time;
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200){
		
	if(xmlhttp3.responseText=='179206725'){
		return false;
	}
		$('#file_details').Shrink(200);
		var sta=document.getElementById('theObjTable').rows.length;
	if(document.getElementById('work_total')!=undefined){
   for(var i=11;i<sta-3;i++){
   document.getElementById('theObjTable').deleteRow(11);
   }
   }
	var options =xmlhttp3.responseText.split('⊙');	
	if(options[29]=='1800-01-01 00:00:00.0') options[29]='没有变更';

	document.getElementById('type_name').innerHTML=options[1];
	document.getElementById('file_id').innerHTML=options[2];
	document.getElementById('file_name').innerHTML=options[3];
	document.getElementById('addway').innerHTML=options[5];
	document.getElementById('department').innerHTML=options[7];
	document.getElementById('specification').innerHTML=options[8];
	document.getElementById('deposit_place').innerHTML=options[9];
	document.getElementById('status').innerHTML=options[10];
	document.getElementById('start_time').innerHTML=options[11];
	document.getElementById('calway').innerHTML=options[12];
	document.getElementById('life_cycle').innerHTML=options[13];
	document.getElementById('currency').innerHTML=options[14];
	document.getElementById('original_value').innerHTML=options[15];
	document.getElementById('remnant_value_rate').innerHTML=options[16]+'%';
	document.getElementById('remnant_value').innerHTML=options[17];
	document.getElementById('caled_month').innerHTML=options[18];
	document.getElementById('caled_sum').innerHTML=options[19];	
	document.getElementById('caled_subtotal').innerHTML=options[20];
	document.getElementById('net_value').innerHTML=options[22];
	document.getElementById('cal_file_name').innerHTML=options[24];
	document.getElementById('last_change_time').innerHTML=options[29];
	temp_time=options[29];
	if(parseInt(document.getElementById('change_count').innerHTML)=='0'){
		document.getElementById('change_count').innerHTML='0';
	}else{
		document.getElementById('change_count').innerHTML=parseInt(document.getElementById('change_count').innerHTML)-1;
	}
	if(options[25]!=''){
		var tr=document.getElementById('theObjTable').insertRow(11);
	 tr.height='20px';
	var tr1 = document.getElementById('theObjTable').insertRow(12);
	 tr1.height='20px';
	td=tr.insertCell(-1);
	td.innerHTML='工作总量';
	td.id='work_total';
	td.background='../../images/line7.gif';
	tr.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[25]+'</div>';
	td1=tr.insertCell(-1);
	td1.background='../../images/line7.gif';
	td1.innerHTML='累计工作量';
	tr.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[26]
+' </div>';
		
	td2=tr1.insertCell(-1);
	td2.innerHTML='工作量单位';
	td2.background='../../images/line7.gif';
	tr1.insertCell(-1).innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[27]+'</div>';
	td3=tr1.insertCell(-1);
	td3.background='../../images/line7.gif';
	td3.innerHTML='单位折旧';
	tr1.insertCell(-1).innerHTML='<span style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[28]+'</div>';
	}else{
		var sta=document.getElementById('theObjTable');
		var tr=sta.getElementsByTagName('tr')[11];
	tr.getElementsByTagName('td')[0].innerHTML='月折旧率';
	tr.getElementsByTagName('td')[1].innerHTML='<div style=\"height:100%; width:100%; background:#EEEEEE;\">'+options[21]+'</div>';	
	}

	$('#file_details').Grow(500);
	return false;

}else{
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "query_search.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('keyword='+file_id+'&change_time='+change_time+'&tag=2');
}
}