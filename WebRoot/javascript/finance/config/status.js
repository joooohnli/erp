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
 multiLangValidate.dwrGetLang("erp",'使用状态添加',{callback:function(msg){document.getElementById('title_span').innerHTML=msg;}});
    document.getElementById('tag').value='0';
    document.getElementById('register').style.display='block';
    document.getElementById('name').value='';
 	document.getElementById('yes').checked=true;
 	document.getElementById('used_tag').options[0].selected=true;
 }
 function send(){
    var id=document.getElementById('id').value;
    var tag=document.getElementById('tag').value;
 	var name=document.getElementById('name').value;
 	var if_cal='';
 	if(document.getElementById('yes').checked){
 	if_cal=document.getElementById('yes').value;
 	}else{
 	if_cal=document.getElementById('no').value;
 	}
 	var used_tag=document.getElementById('used_tag').value;
 	if(name==''){
 	alert('状态名称不能为空！');
 	return false;
 	}
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
    if(parseInt(xmlhttp3.responseText)==0){
	alert('保存成功');
	document.getElementById('register').style.display='none';
	window.location.reload();
	}else if(parseInt(xmlhttp3.responseText)==1){
	alert('状态名称重复！');
	}else{
	alert('变更成功！');
	document.getElementById('register').style.display='none';
	window.location.reload();
	}
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "../../../finance_config_fixed_assets_status_register_ok", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('name='+encodeURI(name)+'&if_cal='+encodeURI(if_cal)+'&used_tag='+encodeURI(used_tag)+'&tag='+tag+'&id='+id);
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
	xmlhttp3.open("POST", "../../../finance_config_fixed_assets_status_delete_ok", true);
	xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xmlhttp3.send('id_group='+id_group);
	}
}

function change(id){
	var xmlhttp3;
	if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
	xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
       var value=xmlhttp3.responseText.substring(0,xmlhttp3.responseText.length-2);
       var op=value.split('⊙');
       document.getElementById('name').value=op[0];
       if(op[1]=='是'){
       document.getElementById('yes').checked=true;
       }else{
       document.getElementById('no').checked=true;
       }
       for(var i=0;i<document.getElementById('used_tag').options.length;i++){
       if(document.getElementById('used_tag').options[i].value==op[2]){
       
       document.getElementById('used_tag').options[i].selected=true;
       }
       }
       document.getElementById('tag').value='1';
       document.getElementById('id').value=id;
       document.getElementById('register').style.display='block';
       multiLangValidate.dwrGetLang("erp",'使用状态变更',{callback:function(msg){document.getElementById('title_span').innerHTML=msg;}});
	}else{
	alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
	xmlhttp3.open("POST", "status_change_getpara.jsp", true);
	xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xmlhttp3.send('id='+id);
	}
}