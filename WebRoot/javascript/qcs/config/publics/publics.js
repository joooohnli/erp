var xmlfile='';
function addDiv(xml){
	xmlfile=xml;
readXml('../../../css/include/nseer_cookie/xml-css.css','../../../xml/qcs/config/publics/'+xml,'0');
}
function deleteDiv(xml){
	xmlfile=xml;
readXml('../../../css/qcs/config/config.css','../../../xml/qcs/config/publics/'+xml,'0');
}
function send(div_id){
var type_id=document.getElementById('type_id').value;
var type_name=document.getElementById('type_name').value;
var kind_id=document.getElementById('kind_id').value;
var kind=document.getElementById('kind').value;
setParentNodeId(kind);
if(!doValidate('../../../xml/qcs/config/publics/validation-config-value.xml',div_id)){
return false;
}
//ajax
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3){xmlhttp3.onreadystatechange = function(){
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200){	
	if(parseInt(xmlhttp3.responseText)==2){
		window.location.reload();
	}
}else {alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "../../../qcs_config_publics_register_ok", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('type_id='+encodeURI(type_id)+'&&type_name='+encodeURI(type_name)+'&&kind='+encodeURI(kind)+'&&kind_id='+encodeURI(kind_id));}
//ajax
}

function del(){
n_D.closeDiv('remove');
var inputs_array=document.getElementsByTagName('input');
var ids_str;
for(var i=0;i<inputs_array.length;i++){
if(inputs_array[i].type=='checkbox'&&inputs_array[i].checked==true){
ids_str+='◎'+inputs_array[i].value;
}
}
if(typeof(ids_str)=='undefined'){
	var alert_sentence='请您选择要删除的纪录!';
	multiLangValidate.dwrGetLang("erp",alert_sentence,{callback:function(msg){alert(msg);}});
	return false;
	}
ids_str=ids_str.substring(1);
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3){xmlhttp3.onreadystatechange = function(){
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200){
alert(xmlhttp3.responseText);
window.location.reload();
}else{alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "../../../qcs_config_publics_delete_ok", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('ids_str='+encodeURI(ids_str));}
}