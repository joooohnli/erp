/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
var rate_formula="";
var formula="";
var num_tag=0;
var row_id=0;

function changeTag(){//判断使用状态，是否需要计算
if(document.getElementById('status').value.indexOf('使用中')==-1){
	if(document.getElementById('unit_cal')){
	if(!document.getElementById('unit_cal').value=='') document.getElementById('unit_cal').value='';
	}else{
	if(!document.getElementById('caled_subtotal_rate').value=='')  document.getElementById('caled_subtotal_rate').value='';
	if(!document.getElementById('caled_subtotal').value=='')  document.getElementById('caled_subtotal').value='';
	}
	}
}

function chooseIn(){//根据折旧方法查询相关公式
var calway=document.getElementById('calway').value;
if(calway=='不提折旧'){
rate_formula="";
formula="";
 changePage('Nseer');
 return false;
 }
if(calway=='年数总和法'){
 return false;
 }
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
	var value=xmlhttp3.responseText.substring(0,xmlhttp3.responseText.length-2);
       var op=value.split('⊙');
       rate_formula=op[0];//记录公式到全局变量
       formula=op[1];
       changePage(value); 
}else{
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "registerNew_getpara.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('calway='+encodeURI(calway));
}
}

function changePage(value){//根据用户所选折旧方法判断是否显示工作总量等录入框
	if(value.indexOf('工作')!=-1 && document.getElementById('work_total')==undefined){
	num_tag=1;	
	var tr=document.getElementById('theObjTable').insertRow(11); 
	var tr1 = document.getElementById('theObjTable').insertRow(12);
	td=tr.insertCell(-1);
	td.innerHTML='工作总量';
	td.background='../../images/line7.gif';
	td.align='right';
	td3=tr.insertCell(-1);
	td3.innerHTML='<input type=\"text\" style=\"width:49%\" id=\"work_total\" onkeyup=\"work_total1(this)\"><input type=\"hidden\" id=\"work_total_hidden\">';
	td3.style.background='#FFFFFF';
	td1=tr.insertCell(-1);
	td1.background='../../images/line7.gif';
	td1.align='right';
	td1.innerHTML='累计工作量';
	td4=tr.insertCell(-1);
	td4.innerHTML='<input id=\"work_sum\" type=\"text\" style=\"width:49%\" onkeyup=\"work_sum1(this);\"><input type=\"hidden\" id=\"work_sum_hidden\" value=\"0\">';
	td4.style.background='#FFFFFF';		
	td2=tr1.insertCell(-1);
	td2.background='../../images/line7.gif';
	td2.align='right';
	td2.innerHTML='工作量单位';
	td5=tr1.insertCell(-1);
	td5.innerHTML='<input type=\"text\" style=\"width:49%\" id=\"work_unit\"><input type=\"hidden\" id=\"work_unit_hidden\">';
	td5.style.background='#FFFFFF';
	tr1.insertCell(-1).background='../../images/line7.gif';
	tr1.insertCell(-1).style.background='#FFFFFF';
    document.getElementById('dynamic').innerHTML='单位折旧';
	document.getElementById('caled_subtotal_rate').id='unit_cal';
	document.getElementById('caled_subtotal_rate_hidden').id='unit_cal_hidden';
	}else if(value.indexOf('工作')==-1 && document.getElementById('work_total')!=undefined){
		num_tag=0;
	document.getElementById('theObjTable').deleteRow(11);
	document.getElementById('theObjTable').deleteRow(11);
	document.getElementById('dynamic').innerHTML='月折旧率';
	document.getElementById('unit_cal').id='caled_subtotal_rate';
	document.getElementById('unit_cal_hidden').id='caled_subtotal_rate_hidden';
	}
	if(num_tag==0){
		if(ownDefine(rate_formula)!='◎'){
			document.getElementById('caled_subtotal_rate').value=FormatNumberPoint(ownDefine(rate_formula),4);
			document.getElementById('caled_subtotal_rate_hidden').value=ownDefine(rate_formula);
		}
		if(ownDefine(formula)!='◎'){
			document.getElementById('caled_subtotal').value=FormatNumberPoint(ownDefine(formula),4);
			document.getElementById('caled_subtotal_hidden').value=ownDefine(formula);
		}
	}else{
	if(ownDefine(rate_formula)!='◎'){
	if(document.getElementById('work_total_hidden').value!=''&&document.getElementById('work_sum_hidden').value!='')
		document.getElementById('unit_cal').value=FormatNumberPoint(ownDefine(rate_formula),4);
		document.getElementById('unit_cal_hidden').value=ownDefine(rate_formula);
		}
	}
	//	document.getElementById('caled_subtotal').value=FormatNumberPoint(ownDefine(formula),2);
}

function formula_transfer(array1){//折旧项目的转换
for(var i=0;i<array1.length;i++){
if(array1[i]=='本月工作量'){
	array1[i]='√';
	}
if(array1[i]=='工作总量')	{
	if(document.getElementById('work_total_hidden').value==''){
    	array1[i]='√';
    	}else{
	 array1[i]=document.getElementById('work_total_hidden').value;
	 }
	 }
if(array1[i]=='累计工作量')  { 
	if(document.getElementById('work_sum_hidden').value==''){
		array1[i]='√';
    	}else{
		array1[i]=document.getElementById('work_sum_hidden').value;
     }
     }
if(array1[i]=='净残值率'){	
	if(document.getElementById('remnant_value_rate2_hidden').value==''){
    	array1[i]='√';
    	}else{
	array1[i]=parseFloat(document.getElementById('remnant_value_rate2_hidden').value)/100;
	}
	}
	
if(array1[i]=='使用年限'){
	if((document.getElementById('lifecycle1').value==''||document.getElementById('lifecycle1').value=='0')&&(document.getElementById('lifecycle2').value=='0'||document.getElementById('lifecycle2').value=='')){
    	array1[i]='√';
    }else{
    	var lifecycle1='';
    	var lifecycle2='';
    	if(document.getElementById('lifecycle1').value==''){
    	lifecycle1='0';
    	}else{
    	lifecycle1=document.getElementById('lifecycle1').value;
    	}
    	if(document.getElementById('lifecycle2').value==''){
    	lifecycle2='0';
    	}else{
    	lifecycle2=document.getElementById('lifecycle2').value;
    	}
		array1[i]=parseFloat(lifecycle1)*12+parseFloat(lifecycle2);
	}
}

if(array1[i]=='可使用月份'){
	if((document.getElementById('lifecycle1').value==''||document.getElementById('lifecycle1').value=='0')&&(document.getElementById('lifecycle2').value=='0'||document.getElementById('lifecycle2').value=='')){
	array1[i]='√';
	}else{
		if(document.getElementById('caled_month').value!=''){
			array1[i]=parseInt(document.getElementById('lifecycle1').value)*12+parseInt(document.getElementById('lifecycle2').value)-parseInt(document.getElementById('caled_month').value);
		}else{
			array1[i]=parseInt(document.getElementById('lifecycle1').value)*12+parseInt(document.getElementById('lifecycle2').value);
		}
	}
}
if(array1[i]=='累计折旧'){
	if(document.getElementById('caled_sum_hidden').value==''){
    	array1[i]='0';
    	}else{
	array1[i]=document.getElementById('caled_sum_hidden').value;
	}
	}
if(array1[i]=='原值'){	
	if(document.getElementById('original_value_hidden').value==''){
    	array1[i]='√';
    	}else{
	array1[i]=document.getElementById('original_value_hidden').value;
	}
	}
if(array1[i]=='已计提月份'){
	if(document.getElementById('caled_month').value==''){
    	array1[i]='√';
    	}else{
	array1[i]=document.getElementById('caled_month').value;
	}
	}
if(array1[i]=='净残值'){
	if(document.getElementById('remnant_value_hidden').value==''){
    	array1[i]='√';
    	}else{
	array1[i]=document.getElementById('remnant_value_hidden').value;
	}
	}
if(array1[i]=='累计减值准备金额'){
array1[i]='0';
}
if(array1[i]=='累计转回减值准备金额'){
	array1[i]='0';
}
if(array1[i]=='月折旧额'){
	if(document.getElementById('caled_subtotal_hidden').value==''){
    	array1[i]='0';
    	}else{
	array1[i]=document.getElementById('caled_subtotal_hidden').value;
	}
	}
	
if(array1[i]=='月折旧率'){
    if(document.getElementById('caled_subtotal_rate_hidden').value==''){
    	array1[i]='√';
    	}else{
    	array1[i]=document.getElementById('caled_subtotal_rate_hidden').value;
    	}
    }
if(array1[i]=='单位折旧'){
    if(document.getElementById('unit_cal_hidden').value==''){
    	array1[i]='√';
    	}else{
    	array1[i]=document.getElementById('unit_cal_hidden').value;
    	}
    }
    }
    return array1;
}

function ownDefine(dFormula){//实现用户自定义公式计算
//alert(dFormula);
if(document.getElementById('status').value.indexOf('使用中')!=-1&&dFormula!=''){
var expRange=new Array;
var real_value=new Array;
var exp = new RegExp('[()*+-/.0123456789]');
var a=0;
for(var i=0;i<dFormula.length;i++){
if(!exp.test(dFormula.charAt(i))){
	if(!exp.test(dFormula.charAt(i-1))){
		if(expRange[a]!=null){
			expRange[a]+=dFormula.charAt(i);
		}else{expRange[a]=dFormula.charAt(i);
		}
	}else{
			if(expRange[a]!=null){
		a++;
		}
		expRange[a]=dFormula.charAt(i);		
	}
}
}
var expRange1=new Array;
for(var i=0;i<expRange.length;i++){//需定义一新数组，以保留expRange值
expRange1[i]=expRange[i];
}
	real_value=formula_transfer(expRange1);
for(var m=0;m<real_value.length;m++){
	if(real_value[m]=='√'){
		return '◎';
	}else{
		dFormula=dFormula.replace(expRange[m],real_value[m]);
	}
}
//alert(dFormula);
return eval(dFormula);
}else{
return '◎';
}
}

function lifecycle(){//使用年限框调用的计算方法
if(ownDefine(rate_formula)!='◎'){
	if(num_tag==0) {
	document.getElementById('caled_subtotal_rate').value=FormatNumberPoint(ownDefine(rate_formula),4);
	document.getElementById('caled_subtotal_rate_hidden').value=ownDefine(rate_formula);
	}
}
if(ownDefine(formula)!='◎'){
	if(num_tag==0){
		document.getElementById('caled_subtotal').value=FormatNumberPoint(ownDefine(formula),2);
	 	document.getElementById('caled_subtotal_hidden').value=ownDefine(formula);
	 }
}
}

function work_total1(obj){//工作总量框调用的计算方法
	obj.value=obj.value.replace(/[^.0123456789$]/g,'');
	document.getElementById(obj.id+'_hidden').value=obj.value;
	if(obj.value!=''){
		if(parseFloat(obj.value)>=parseFloat(document.getElementById('work_sum_hidden').value)){
			if(ownDefine(rate_formula)!='◎'){
			document.getElementById('unit_cal').value=FormatNumberPoint(ownDefine(rate_formula),4);
			document.getElementById('unit_cal_hidden').value=ownDefine(rate_formula);			
			}
		}else{
			alert('工作总量不能小于累计工作量！');
			return false;
		}
	}
}

function work_sum1(obj){//累计工作量框调用的计算方法
	obj.value=obj.value.replace(/[^.0123456789$]/g,'');
		document.getElementById(obj.id+'_hidden').value=obj.value;
	if(parseFloat(obj.value)<=parseFloat(document.getElementById('work_total_hidden').value)){
		if(ownDefine(rate_formula)!='◎'){
		document.getElementById('unit_cal').value=FormatNumberPoint(ownDefine(rate_formula),4);
		document.getElementById('unit_cal_hidden').value=ownDefine(rate_formula);
		}
	}else{
		alert('累计工作量不能大于工作总量！');
		return false;
	}
}

function start_time2(obj){//开始使用时间为空，清空已计提月份
	if(obj.value==''){
		document.getElementById('caled_month').value='';
	}
}

function caled_month1(obj){//已记提月份框调用的计算方法
	obj.value=obj.value.replace(/[^0123456789$]/g,'');
		if(ownDefine(rate_formula)!='◎'){
		document.getElementById('caled_subtotal_rate').value=FormatNumberPoint(ownDefine(rate_formula),4);
		document.getElementById('caled_subtotal_rate_hidden').value=ownDefine(rate_formula);
		}
		if(ownDefine(formula)!='◎'){
		document.getElementById('caled_subtotal').value=FormatNumberPoint(ownDefine(formula),2);
		document.getElementById('caled_subtotal_hidden').value=ownDefine(formula);
		}
}

function judgement(obj){//判断已计提月份是否可以录入
if(document.getElementById('start_time').value==''){
	obj.value='';	
	obj.blur();
}
}

function original_value2(obj){//原值框调用的计算方法
	obj.value=obj.value.replace(/[^.0123456789$]/g,'');
		document.getElementById(obj.id+'_hidden').value=obj.value;
	var remnant_value=0;
	if(document.getElementById('caled_sum_hidden').value==''){
	document.getElementById('net_value').value=FormatNumberPoint(parseFloat(obj.value),2);
	document.getElementById('net_value_hidden').value=parseFloat(obj.value);
	}else{
	document.getElementById('net_value').value=FormatNumberPoint(parseFloat(obj.value)-parseFloat(document.getElementById('caled_sum_hidden').value),2);
	document.getElementById('net_value_hidden').value=parseFloat(obj.value)-parseFloat(document.getElementById('caled_sum_hidden').value);
	}
if(document.getElementById('remnant_value_rate2_hidden').value!=''){
	document.getElementById('remnant_value').value=FormatNumberPoint(parseFloat(obj.value)*parseFloat(document.getElementById('remnant_value_rate2_hidden').value)/100,2);
	document.getElementById('remnant_value_hidden').value=parseFloat(obj.value)*parseFloat(document.getElementById('remnant_value_rate2_hidden').value)/100;
	if(document.getElementById('caled_sum').value!=''){
		if(parseFloat(obj.value)>=parseFloat(document.getElementById('caled_sum_hidden').value)+parseFloat(document.getElementById('remnant_value_hidden').value)){
		if(ownDefine(rate_formula)!='◎'){ 
			if(num_tag==0){
			document.getElementById('caled_subtotal_rate').value=FormatNumberPoint(ownDefine(rate_formula),4);
			document.getElementById('caled_subtotal_rate_hidden').value=ownDefine(rate_formula);
			}else{
			document.getElementById('unit_cal').value=FormatNumberPoint(ownDefine(rate_formula),4);
			document.getElementById('unit_cal_hidden').value=ownDefine(rate_formula);
			}
		}
		if(ownDefine(formula)!='◎'){
		document.getElementById('caled_subtotal').value=FormatNumberPoint(ownDefine(formula),2);
		document.getElementById('caled_subtotal_hidden').value=ownDefine(formula);
		}
	}else{
		if(document.getElementById('caled_sum_hidden').value!=''){
			if(parseFloat(obj.value)<parseFloat(document.getElementById('caled_sum_hidden').value)){
				alert('原值不能小于累计折旧值！');
				obj.foucs();
				return false;
			}else{
				alert('净残值不能大于净值！');
				obj.foucs();
				return false;
			}
		}
	}
	}else{	
	if(parseFloat(obj.value)>=parseFloat(document.getElementById('remnant_value_hidden').value)){
		if(ownDefine(rate_formula)!='◎') {
		if(num_tag==0){
			document.getElementById('caled_subtotal_rate').value=FormatNumberPoint(ownDefine(rate_formula),4);
			document.getElementById('caled_subtotal_rate_hidden').value=ownDefine(rate_formula);
			}else{
			document.getElementById('unit_cal').value=FormatNumberPoint(ownDefine(rate_formula),4);
			document.getElementById('unit_cal_hidden').value=ownDefine(rate_formula);
			}
		}
		if(ownDefine(formula)!='◎') {
		document.getElementById('caled_subtotal').value=FormatNumberPoint(ownDefine(formula),2);
		document.getElementById('caled_subtotal_hidden').value=ownDefine(formula);
		}	
	}else{
		if(document.getElementById('caled_sum_hidden').value!=''){
				if(parseFloat(obj.value)<parseFloat(document.getElementById('caled_sum_hidden').value)){
					alert('原值不能小于累计折旧值！');
					return false;
				}else{
					alert('净残值不能大于净值！');
					return false;
				}
			}
		}	
	}
	}
}

function remnant_value_rate1(obj){//净残值率框调用的计算方法
	obj.value=obj.value.replace(/[^.0123456789$]/g,'');
		document.getElementById(obj.id+'_hidden').value=obj.value;
	if(parseFloat(obj.value)>0&&parseFloat(obj.value)<100){
	if(document.getElementById('original_value_hidden').value!=''){
	document.getElementById('remnant_value').value=FormatNumberPoint(parseFloat(document.getElementById('original_value').value)*parseFloat(obj.value)/100,2);
	document.getElementById('remnant_value_hidden').value=parseFloat(document.getElementById('original_value_hidden').value)*parseFloat(obj.value)/100;
	}
	if(document.getElementById('caled_subtotal_rate_hidden')!=undefined){
	if(ownDefine(rate_formula)!='◎'){
	document.getElementById('caled_subtotal_rate').value=FormatNumberPoint(ownDefine(rate_formula),4);
	document.getElementById('caled_subtotal_rate_hidden').value=ownDefine(rate_formula);
	}
	}else{
		if(ownDefine(rate_formula)!='◎'){
		document.getElementById('unit_cal').value=FormatNumberPoint(ownDefine(rate_formula),4);
		document.getElementById('unit_cal_hidden').value=ownDefine(rate_formula);
		}
	}
		if(ownDefine(formula)!='◎'){
		document.getElementById('caled_subtotal').value=FormatNumberPoint(ownDefine(formula),2);
		document.getElementById('caled_subtotal_hidden').value=ownDefine(formula);
		}
	}else{
	alert('净残值率必须大于"0"且小于"100"！');
	return false;
	}
}

function remnant_value1(obj){//净残值框调用的计算方法
	obj.value=obj.value.replace(/[^.0123456789$]/g,'');
		document.getElementById(obj.id+'_hidden').value=obj.value;
	if(document.getElementById('net_value_hidden').value!=''){
	if(parseFloat(obj.value)<=parseFloat(document.getElementById('net_value_hidden').value)){
	document.getElementById('remnant_value_rate2').value=FormatNumberPoint(parseFloat(obj.value)/parseFloat(document.getElementById('original_value').value)*100,2);
	document.getElementById('remnant_value_rate2_hidden').value=parseFloat(obj.value)/parseFloat(document.getElementById('original_value_hidden').value)*100;
		if(document.getElementById('caled_subtotal_rate_hidden')!=undefined){
			if(ownDefine(rate_formula)!='◎'){
			document.getElementById('caled_subtotal_rate').value=FormatNumberPoint(ownDefine(rate_formula),4);
			document.getElementById('caled_subtotal_rate_hidden').value=ownDefine(rate_formula);
			}
		}else{
			if(ownDefine(rate_formula)!='◎'){
			document.getElementById('unit_cal').value=FormatNumberPoint(ownDefine(rate_formula),4);
			document.getElementById('unit_cal_hidden').value=ownDefine(rate_formula);
			}
		}
		if(ownDefine(formula)!='◎'){
		document.getElementById('caled_subtotal').value=FormatNumberPoint(ownDefine(formula),2);
		document.getElementById('caled_subtotal_hidden').value=ownDefine(formula);
		}
	}else{
	alert('净残值不能大于净值');
	return false;
	}
	}
}

function caled_sum1(obj){//累计折旧框调用的计算方法
	obj.value=obj.value.replace(/[^.0123456789$]/g,'');
		document.getElementById(obj.id+'_hidden').value=obj.value;
	if(document.getElementById('original_value_hidden').value!=''){
		if(parseFloat(obj.value)<=parseFloat(document.getElementById('original_value_hidden').value)-parseFloat(document.getElementById('remnant_value_hidden').value)){	
	document.getElementById('net_value').value=FormatNumberPoint(parseFloat(document.getElementById('original_value_hidden').value)-parseFloat(obj.value),2);
	document.getElementById('net_value_hidden').value=parseFloat(document.getElementById('original_value_hidden').value)-parseFloat(obj.value);
			if(document.getElementById('unit_cal_hidden')!=undefined){
				if(ownDefine(rate_formula)!='◎'){
				document.getElementById('unit_cal').value=FormatNumberPoint(ownDefine(rate_formula),4);
				document.getElementById('unit_cal_hidden').value=ownDefine(rate_formula);
				}
			}else{
				if(ownDefine(rate_formula)!='◎'){
				document.getElementById('caled_subtotal_rate').value=FormatNumberPoint(ownDefine(rate_formula),4);
				document.getElementById('caled_subtotal_rate_hidden').value=ownDefine(rate_formula);
				}
			}
			if(ownDefine(formula)!='◎'){
			document.getElementById('caled_subtotal').value=FormatNumberPoint(ownDefine(formula),2);
			document.getElementById('caled_subtotal_hidden').value=ownDefine(formula);
			}
		}else{
			if(parseFloat(obj.value)>parseFloat(document.getElementById('original_value_hidden').value)){
		alert('累计折旧不能大于原值！');
		return false;
			}else{
		alert('净残值不能大于净值！');
		return false;
			}
		}
	}
}

function net_value1(obj){//净值框调用的计算方法
	obj.value=obj.value.replace(/[^.0123456789$]/g,'');
		document.getElementById(obj.id+'_hidden').value=obj.value;
	if(document.getElementById('original_value_hidden').value!=''){
	document.getElementById('caled_sum').value=FormatNumberPoint(parseFloat(document.getElementById('original_value_hidden').value)-parseFloat(obj.value),2);
	document.getElementById('caled_sum_hidden').value=parseFloat(document.getElementById('original_value_hidden').value)-parseFloat(obj.value);
	if(document.getElementById('unit_cal_hidden')!=undefined){
			if(ownDefine(rate_formula)!='◎'){
				document.getElementById('unit_cal').value=FormatNumberPoint(ownDefine(rate_formula),4);
				document.getElementById('unit_cal_hidden').value=ownDefine(rate_formula);
			}
		}else{
			if(ownDefine(rate_formula)!='◎'){
				document.getElementById('caled_subtotal_rate').value=FormatNumberPoint(ownDefine(rate_formula),4);
				document.getElementById('caled_subtotal_rate_hidden').value=ownDefine(rate_formula);
			}
		}
		if(ownDefine(formula)!='◎'){
		document.getElementById('caled_subtotal').value=FormatNumberPoint(ownDefine(formula),2);
		document.getElementById('caled_subtotal_hidden').value=ownDefine(formula);
		}
	}	
}

function net_validate(obj){//验证净值合法性
	if(parseFloat(obj.value)>parseFloat(document.getElementById('original_value_hidden').value)){
		alert('净值不能大于原值！');
		obj.focus();
	}else if(parseFloat(obj.value)<parseFloat(document.getElementById('remnant_value_hidden').value)){
		alert('净残值不能大于净值！');
		obj.focus();
	
	}
}

function net_validate(obj){//验证净值合法性
	if(parseFloat(obj.value)>parseFloat(document.getElementById('original_value_hidden').value)){
		alert('净值不能大于原值！');
		obj.focus();
	}else if(parseFloat(obj.value)<parseFloat(document.getElementById('remnant_value_hidden').value)){
		alert('净残值不能大于净值！');
		obj.focus();
	
	}
}

function remnant_validate(obj){//验证净残值合法性
	if(parseFloat(obj.value)>=parseFloat(document.getElementById('original_value_hidden').value)){
		alert('净残值不能大于等于原值！');
		obj.focus();
	}else if(parseFloat(obj.value)>parseFloat(document.getElementById('net_value_hidden').value)){
		alert('净残值不能大于净值！');
		obj.focus();
	}
}

function registerNew_ok(){//提交数据库
//if (doValidate("")!=false) {
var type_name=document.getElementById('type_name2').value;
var file_id=document.getElementById('file_id2').value;
var file_name=document.getElementById('file_name2').value;
var addway=document.getElementById('addway').value;
var department=document.getElementById('department').value;
var specification=document.getElementById('specification').value;
var deposit_place=document.getElementById('deposit_place').value;
var status=document.getElementById('status').value;
	status=status.split('/')[1];
var calway=document.getElementById('calway').value;

if(rate_formula.indexOf('工作')!=-1||formula.indexOf('工作')!=-1){
	var work_total=document.getElementById('work_total_hidden').value;
	var work_sum=document.getElementById('work_sum_hidden').value;
	var work_unit=document.getElementById('work_unit_hidden').value;
	var unit_cal=document.getElementById('unit_cal_hidden').value;
}else{
	var caled_subtotal_rate=document.getElementById('caled_subtotal_rate_hidden').value;
}
var start_time=document.getElementById('start_time').value;
var lifecycle1=document.getElementById('lifecycle1').value;
var lifecycle2=document.getElementById('lifecycle2').value;
var lifecycle=parseInt(lifecycle1)*12+parseInt(lifecycle2);

var currency=document.getElementById('currency').value;
var original_value=document.getElementById('original_value_hidden').value;
var remnant_value=document.getElementById('remnant_value_hidden').value;
var remnant_value_rate=parseFloat(document.getElementById('remnant_value_rate2_hidden').value)/100;
var caled_month=document.getElementById('caled_month').value;
var caled_sum=document.getElementById('caled_sum_hidden').value;
var caled_subtotal=document.getElementById('caled_subtotal_hidden').value;
var net_value=document.getElementById('net_value_hidden').value;
var cal_file_name=document.getElementById('cal_file_name').value;

var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
if(parseInt(xmlhttp3.responseText)==0){
	alert('提交成功');
	window.location.reload();
}
if(parseInt(xmlhttp3.responseText)==1){
	alert('必填项不能为空');
}
if(parseInt(xmlhttp3.responseText)==2){
	alert('固定资产编号重复');
}
if(parseInt(xmlhttp3.responseText)==3){
	alert('固定资产名称重复');
}
if(parseInt(xmlhttp3.responseText)==4){
	alert('新增资产的开始使用日期必须在本会计期间');
}
if(parseInt(xmlhttp3.responseText)==5){
	alert('原值、净残值率、净残值、已计提月份、累计折旧或净值必须为数字');
}
if(parseInt(xmlhttp3.responseText)==6){
	alert('月折旧率必须为数字');
}
if(parseInt(xmlhttp3.responseText)==7){
	alert('单位折旧必须为数字');
}

}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "../../finance_fixed_assets_registerNew_ok", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('type_name='+type_name+'&file_id='+file_id+'&file_name='+file_name+'&addway='+addway+'&department='+department+'&specification='+specification+'&deposit_place='+deposit_place+'&status='+status+'&calway='+calway+'&start_time='+start_time+'&lifecycle='+lifecycle+'&work_total='+work_total+'&work_sum='+work_sum+'&work_unit='+work_unit+'&currency='+currency+'&original_value='+original_value+'&remnant_value='+remnant_value+'&remnant_value_rate='+remnant_value_rate+'&unit_cal='+unit_cal+'&caled_month='+caled_month+'&caled_sum='+caled_sum+'&caled_subtotal='+caled_subtotal+'&caled_subtotal_rate='+caled_subtotal_rate+'&net_value='+net_value+'&cal_file_name='+cal_file_name);
}
//}
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
return  resultStr;   
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
return   resultStr;   
}   
else{
resultStr=srcStr;   
for (i=0;i<(nAfterDot-strLen+dotPos+1);i++){   
resultStr=resultStr+"0";   
}   
return   resultStr;   
}   
}   
}

function addRow(){//所在机构层的动态添加行
 var sTa=document.getElementById('tablefield2');
 var id_input=sTa.rows.length; 
     tr = document.getElementById('tablefield2').insertRow(sTa.rows.length);  
     tr.height='25';   

tr.insertCell(-1).innerHTML ="<input name='name' id='aaaaa"+id_input+"' type='text' style=\"width: 100%; height: 100%; border-bottom:  1px solid #000000;BORDER-left:  1px solid #000000;border-right:  1px solid #000000; border-top:  0px ;\" onFocus=\"fo(this.id)\">";
	
tr.insertCell(-1).innerHTML = "<input name='name' id='bbbbb"+id_input+"' type='text' style=\"width: 100%; height: 100%; border-bottom:  1px solid #000000;BORDER-left: 0px; border-right: 1px solid #000000; border-top: 0px;\" onFocus=\"fo(this.id)\">";

tr.insertCell(-1).innerHTML = "<input name='name' id='ccccc"+id_input+"' type='text' style=\"width: 100%; height: 100%; border-bottom:  1px solid #000000;BORDER-left: 0px; border-right: 1px solid #000000; border-top: 0px;\" onFocus=\"fo(this.id)\">";

tr.insertCell(-1).innerHTML = "<input name='name' id='ddddd"+id_input+"' type='text' style=\"width: 100%; height: 100%; border-style: none; border-right: 1px solid #000000; border-bottom:  1px solid #000000;\" onFocus=\"fo(this.id)\">";

for(j=0;j<sTa.rows.length;j++){	
	   sTa.getElementsByTagName('tr')[j].id=j;
	   for(var m=0;m<sTa.getElementsByTagName('tr')[j].getElementsByTagName('input').length;m++){
			if(m==0){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='aaaaa'+j;
			}else if(m==1){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='bbbbb'+j;
			}else if(m==2){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='ccccc'+j;
			}else{
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='ddddd'+j;
			}
	   }

    }
  }
  
function fo(input_id){
row_id=parseInt(input_id.substring(5));

}

function deleteRow(){//删除
if(row_id!=0){
var sTa=document.getElementById('tablefield2');
sTa.deleteRow(row_id);
for(var j=0;j<sTa.rows.length;j++)
    {	
	   sTa.getElementsByTagName('tr')[j].id=j;
	   for(var m=0;m<sTa.getElementsByTagName('tr')[j].getElementsByTagName('input').length;m++){
			if(m==0){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='aaaaa'+j;
			}else if(m==1){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='bbbbb'+j;
			}else if(m==2){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='ccccc'+j;
			}else{
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='ddddd'+j;
			}
    }
	}
 }else{
	 alert("请选择要删除的行！");
	 }
 row_id=0;
}

function closefile(tag){
if(tag=='1') document.getElementById('nseer1').style.display='none';
if(tag=='2') document.getElementById('nseer2').style.display='none';
if(tag=='3') document.getElementById('nseer3').style.display='none';
if(tag=='4') document.getElementById('nseer4').style.display='none';
document.body.removeChild(document.getElementById('treeButton'));
}

function kandEvent(){
var file_id=document.getElementById('type_name2').value.split(" ")[0];
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
	var value=xmlhttp3.responseText.substring(0,xmlhttp3.responseText.length-2)
	document.getElementById('remnant_value_rate2').value=value.split("⊙")[1];
	document.getElementById('remnant_value_rate2_hidden').value=value.split("⊙")[1];
	var lifecycle=value.split("⊙")[0];
	document.getElementById('lifecycle1').value=Math.floor(parseInt(lifecycle)/12); 
	document.getElementById('lifecycle2').value=parseInt(lifecycle)%12; 
}else{
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "registerNew_search.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('file_id='+encodeURI(file_id));
}
}

////////////////////////////////////////////////////////////////////

function search_suggest1(obj){//根据输入内容快速查询摘要写入下拉层(资产类别)
var keyword=document.getElementById(obj).value;
var table_name=document.getElementById(obj+'_table').value;

var u=window.location.href.split('://')[1].split('/');
var url='';
for(var i=0;i<u.length-3;i++){url+='../';}

if(keyword!=''){
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
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
var cla=document.getElementById('search_suggest');
if(xmlhttp3.responseText=='★'){
	return false;
	}else{
var options =xmlhttp3.responseText.split("◎");

var conter='';
for (var i = 0; i < options.length; i++) {

var suggest = '<div  onmouseover="style.backgroundColor=\'#E8F2FE\'" onmouseout="style.backgroundColor=\'\'"';
suggest += 'onclick=\"javascript:setSearch1(\''+options[i]+'\',\''+obj+'\');\" ';
suggest += '>' + options[i].split("⊙")[0]+' '+ options[i].split("⊙")[1]+ '</div>';
conter += suggest;
}
cla.innerHTML = '';
cla.innerHTML = conter;
loadDiv1(document.getElementById(obj));
cla.style.display='block';
if(document.attachEvent) document.attachEvent('onmousedown',closeResult,event);
HideOverSels_1(cla.id);
if(document.getElementById('showTree_div')) document.body.removeChild(document.getElementById('showTree_div'));
	}
	
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "register_search.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('keyword='+encodeURI(keyword)+'&table_name='+table_name);
}
}else{
	if(document.getElementById('search_suggest')){
		document.getElementById('search_suggest').innerHTML = '';
		document.getElementById('search_suggest').style.display='none';
		HideOverSels_1('search_suggest');
		}
}
}

function setSearch1(obj,obj1){
	if(document.getElementById('showTree_div')) document.body.removeChild(document.getElementById('showTree_div'));
	var values=obj.split('⊙');
	document.getElementById(obj1).value=values[0]+' '+values[1];
	document.getElementById('remnant_value_rate2').value=values[2];
	document.getElementById('remnant_value_rate2_hidden').value=values[2];
	document.getElementById('lifecycle1').value=parseInt(values[3]/12);
	document.getElementById('lifecycle2').value=parseInt(values[3])-(parseInt(values[3])/12)*12;

	document.getElementById('search_suggest').style.display='none';
	HideOverSels_1('search_suggest');
	document.getElementById('search_suggest').innerHTML='';
}