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
if(!document.getElementById('search_suggest')){
var search_suggest=document.createElement('div');
	search_suggest.id='search_suggest';
	search_suggest.style.position='absolute';
	search_suggest.style.background='yellow';
	search_suggest.style.filter='alpha(opacity=60)';
	search_suggest.style.overflowY='auto';
	search_suggest.style.overflowX='hidden';
	document.body.appendChild(search_suggest);
}
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
loadDiv1(document.getElementById(id));
cla.style.display='block';
if(document.attachEvent) document.attachEvent('onmousedown',closeResult,event);
	}
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "registerWork_search.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('keyword='+encodeURI(keyword));
}
}
}

function setSearch(obj1,obj2){//关闭下拉层后,给录入框赋原值
	document.getElementById(obj2).value=obj1;
	document.getElementById('search_suggest').style.display='none';
}

function send() {//将有关行数据保存至数据库
	var work_month='';
	var sta=document.getElementById('theObjTable');
	if(sta.rows.length==1){
		alert('请正确填写明细');
		return false;
	}
	for(var i=1;i<sta.rows.length;i++){	 		
		work_month+=sta.getElementsByTagName('tr')[i].getElementsByTagName('input')[0].value+'⊙'+sta.getElementsByTagName('tr')[i].getElementsByTagName('input')[1].value+'◎';
	}
	work_month=work_month.substring(0,work_month.length-1);
	var xmlhttp3;
        if (window.XMLHttpRequest) {
            xmlhttp3 = new XMLHttpRequest();
        } else {
            if (window.ActiveXObject) {
                xmlhttp3 = new ActiveXObject("Microsoft.XMLHTTP");
            }
        }
        if (xmlhttp3) {
            xmlhttp3.onreadystatechange = function(){
               if(xmlhttp3.readyState == 4){try {
               if (xmlhttp3.status == 200) {
               alert(xmlhttp3.responseText);
               window.location.reload();                     
				}else{alert(xmlhttp3.status + "=" + xmlhttp3.statusText);}}catch(exception){alert(exception);}}};
            xmlhttp3.open("POST", "../../finance_fixed_assets_registerWork_ok", true);
            xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xmlhttp3.send("work_month="+encodeURI(work_month));
        }
}

function work_month1(input_id){//判断本月工作量的输入
	var rows=input_id.substring(10);
	if(parseFloat(document.getElementById(input_id).value)>parseFloat(document.getElementById("surplus"+rows).value)){
		alert('本月工作量不能大于剩余工作量');
		document.getElementById(input_id).focus();
	}
}