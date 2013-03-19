var fields_arr=new Array();
function dynamicSubmit(xml_url,form_id){
	var form=document.getElementById(form_id);
	form.submit();
}
function validateDupli(fields,this_obj){
	if(this_obj.value!==''){
if(fields_arr.length==0){
	for(var i=0;i<document.getElementsByName(fields).length;i++){
		fields_arr[i]=document.getElementsByName(fields)[i].value;
	}
}
var a=0;
for(var i=0;i<fields_arr.length;i++){
if(fields_arr[i].toLowerCase()==this_obj.value.toLowerCase()){
/*DWREngine.setAsync(false);
multiLangValidate.dwrGetLang("erp","重复",{callback:function(msg){alert(this_obj.value+msg);}});
DWREngine.setAsync(true);*/
a++;
break;
}
}

if(a==0){
	fields_arr[fields_arr.length]=this_obj.value;
}
}
}
function validateNull(this_obj,field,i){
	var obj=this_obj;
	var d=document.getElementById&&!document.all;
	while(obj.tagName.toLowerCase()!='tr'){
	obj=d?obj.parentNode:obj.parentElement;
	}
	if(obj.getElementsByTagName('input')[i].value==''||obj.getElementsByTagName('input')[i].value==null){
	DWREngine.setAsync(false);
	multiLangValidate.dwrGetLang("erp","不能为空",{callback:function(msg){alert(field+msg);this_obj.value='';}});
	DWREngine.setAsync(true);
	}
}

function validateType(this_obj){
}


function del_cols(xmlurl,form_id,span_name){
	var fields='';
	var checkboxs=document.getElementsByName("checkbox");
	for(var i=0;i<checkboxs.length;i++){
		if(checkboxs[i].checked){
			fields+='⊙'+checkboxs[i].value;
		}
	}
	var action=document.getElementById(form_id).action;
	if(action.indexOf('?')!=-1){
	document.getElementById(form_id).action=action+'&&'+span_name+'='+fields.substring(1);
	}else{
	document.getElementById(form_id).action=action+'?'+span_name+'='+fields.substring(1);
	}
	dynamicSubmit(xmlurl,form_id);
}