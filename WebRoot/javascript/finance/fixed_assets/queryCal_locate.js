/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
function id_link(id){//根据固定资产编号查询finance_fa_file表
if(document.getElementById('file_details').style.display!='none'){
return false;
}
var keyword=id;
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
	var n_value =xmlhttp3.responseText.split('⊙');
	document.getElementById('file_id').innerHTML=n_value[0];
	document.getElementById('file_name').innerHTML=n_value[1];
	//document.getElementById('type_id').innerHTML=n_value[2];
	document.getElementById('type_name').innerHTML=n_value[3];
	document.getElementById('department').innerHTML=n_value[4]+n_value[5];
	document.getElementById('caled_time').innerHTML=n_value[8];
	document.getElementById('start_time').innerHTML=n_value[6];
	document.getElementById('life_cycle').innerHTML=n_value[7];
	document.getElementById('original_value').innerHTML=FormatNumberPoint(parseFloat(n_value[9]),2);
	document.getElementById('caled_sum').innerHTML=FormatNumberPoint(parseFloat(n_value[10]),2);
	if(parseFloat(n_value[11])==0){
	document.getElementById('work_subtotal').innerHTML='-';
	document.getElementById('work_sum').innerHTML='-';
	document.getElementById('work_unit').innerHTML='-';
	document.getElementById('work_month').innerHTML='-';
	}else{
	document.getElementById('work_subtotal').innerHTML=FormatNumberPoint(parseFloat(n_value[11]),2);
	document.getElementById('work_sum').innerHTML=FormatNumberPoint(parseFloat(n_value[12]),2);
	document.getElementById('work_unit').innerHTML=FormatNumberPoint(parseFloat(n_value[13]),2);
	document.getElementById('work_month').innerHTML=FormatNumberPoint(parseFloat(n_value[14]),2);
	}
	document.getElementById('cal_subtotal_month').innerHTML=FormatNumberPoint(parseFloat(n_value[15]),2);
	$('#file_details').Grow(500);
	return false;
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "queryCal_search.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('keyword='+keyword);
}
}

function close_clear(){
	document.getElementById('file_id').innerHTML='';
	document.getElementById('file_name').innerHTML='';
	//document.getElementById('type_id').innerHTML='';
	document.getElementById('type_name').innerHTML='';
	document.getElementById('department').innerHTML='';
	document.getElementById('start_time').innerHTML='';
	document.getElementById('life_cycle').innerHTML='';
	document.getElementById('caled_time').innerHTML='';
	document.getElementById('original_value').innerHTML='';
	document.getElementById('caled_sum').innerHTML='';
	document.getElementById('work_subtotal').innerHTML='';
	document.getElementById('work_sum').innerHTML='';
	document.getElementById('work_unit').innerHTML='';
	document.getElementById('work_month').innerHTML='';
	document.getElementById('cal_subtotal_month').innerHTML='';
   $('#file_details').Shrink(200);
	return false;
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
return resultStr;   
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
return resultStr;   
}   
else{
resultStr=srcStr;   
for (i=0;i<(nAfterDot-strLen+dotPos+1);i++){   
resultStr=resultStr+"0";   
}   
return resultStr;   
}   
}   
}