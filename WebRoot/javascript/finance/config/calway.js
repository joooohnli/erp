/*
  *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
 var input_id='';
 function showSelect(id){
    input_id=id;
    document.getElementById('item').style.display='block';
 }
 
 function register(){
 	document.getElementById('tag').value='0';
    document.getElementById('register').style.display='block';
    document.getElementById('name').value='';
 	document.getElementById('rate_formula').value='';
 	document.getElementById('formula').value='';
 }
 
 function writein(obj){
 	document.getElementById(input_id).value+=obj;
 }
 
 function clear_up(){
 	document.getElementById(input_id).value='';
 }
 
function send(){
 	var name=document.getElementById('name').value;
 	var rate_formula=document.getElementById('rate_formula').value;
 	var formula=document.getElementById('formula').value;
 	var id=document.getElementById('id').value;
    var tag=document.getElementById('tag').value;
 	if(name==''){
 	alert('折旧方法名称不能为空');
 	return false;
 	}
 	if(rate_formula==''||formula==''){
 	alert('公式不能定义为空');
 	return false;
 	}
 	if(rate_formula.indexOf('月折旧额')==-1&&formula.indexOf('月折旧率')==-1||rate_formula.indexOf('月折旧率')!=-1||formula.indexOf('月折旧额')!=-1||rate_formula.indexOf('月折旧额')!=-1&&formula.indexOf('月折旧率')!=-1){
 	alert('月折旧率和月折旧额必须关联');
 	return false;
 	}	
 	if(!control(rate_formula)) return false;
 	if(!control(formula)) return false;
 		rate_formula=document.getElementById('rate_formula').value.replace(/\+/g,'⊙');
 		formula=document.getElementById('formula').value.replace(/\+/g,'⊙');
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {		
	if(parseInt(xmlhttp3.responseText)==0){
	alert('保存成功');
	document.getElementById('register').style.display='none';
	document.getElementById('item').style.display='none';
	window.location.reload();
	}else if(parseInt(xmlhttp3.responseText)==1){
	alert('名称重复！');
	}else{
	alert('变更成功！');
	document.getElementById('register').style.display='none';
	document.getElementById('item').style.display='none';
	window.location.reload();
	}
	
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "../../../finance_config_fixed_assets_calWay_register_ok", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('name='+encodeURI(name)+'&rate_formula='+encodeURI(rate_formula)+'&formula='+encodeURI(formula)+'&tag='+tag+'&id='+id);
}
}
 
function control(obj){//验证公式
if(obj!=''&&obj!=null){//验证字符不为空
obj=obj.replace(/[\+\-\*\/]/g,'☆');
if(obj.indexOf('☆')==0||obj.lastIndexOf('☆')==obj.length-1){	
alert('公式错误，无正确运算');
return false;
}	
		var count1=obj.length-obj.replace(/\(/g,'').length;
		var count2=obj.length-obj.replace(/\)/g,'').length;
if(parseInt(count1)==parseInt(count2)){
if(obj.indexOf('☆')!=0&&obj.indexOf('☆')!=obj.length-1&&obj.indexOf('☆☆')==-1){//不需带有运算符，且位置不在首尾。
var op=obj.split('☆');//根据运算符切分
var op1='';
var a=0;
var b=0;
	for(var i=0;i<op.length;i++){
	
		if(op[i].indexOf('(')!=-1&&op[i].indexOf(')')!=-1){
		alert('折旧率公式定义错误');
		return false; 
		}
		
		if(op[i].indexOf('(')!=-1){
		var temp=op[i].replace(/\(/g,'');
		var count=op[i].length-temp.length;
		if(op[i].substring(count).indexOf('(')!=-1){
		alert('折旧率公式定义错误');
		return false; 
		}	
		}
		
		if(op[i].indexOf(')')!=-1){
		var temp=op[i].replace(/\)/g,'');
		var count=op[i].length-temp.length;
		if(op[i].substring(0,op[i].length-count).indexOf(')')!=-1){
		alert('折旧率公式定义错误');
		return false; 
		}	
		}
		
		op1=op[i].replace(/[\(\)]/g,'');
			for(var v=0;v<op1.length;v++){ //判断该字符串是数字还是其他字符。
				if('.0123456789'.indexOf(op1.substring(v,v+1))!=-1){
				a++;
				}else{
				b++;
				}
			}
			if(a!=0&&b!=0){//包含数字和其他字符，该字符串不合法。
			alert(op1+'不属于可选项目');
			return false; 
			}else if(a==0&&b!=0){//无数字和"."，表示属于字符串类，到数据库验证是否符合标准。
			    op1='⊙'+op1+'⊙';
				if(document.getElementById("item_group").value.indexOf(op1)==-1){
				alert(op1+'不属于可选项目');
				return false; 
				}				
				}else if(a!=0&&b==0){//纯数字，判断"."的位置和个数，
				if(op1.indexOf('.')==0||op1.indexOf('.')==op1.length-1||op1.indexOf('.')!=op1.lastIndexOf('.')){
				alert(op1+'不合法');
				return false; 
				}
			}
			a=0;
			b=0;
		}
	
}else{
alert('公式错误，无正确运算');
return false; 
}
}else{
alert('公式错误，无正确运算');
return false; 
}
}else{
alert('公式不能定义为空');
return false; 
}
return true;
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
	xmlhttp3.open("POST", "../../../finance_config_fixed_assets_calWay_delete_ok", true);
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
       document.getElementById('formula').value=op[1];
       document.getElementById('rate_formula').value=op[2];
       document.getElementById('tag').value='1';
       document.getElementById('id').value=id;
       document.getElementById('register').style.display='block';
	}else{
	alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
	xmlhttp3.open("POST", "calWay_change_getpara.jsp", true);
	xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xmlhttp3.send('id='+id);
	}
}