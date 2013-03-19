/*
  *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
function loadAjaxDiv(input_id,product_id,event){//弹出ajax动态查询数据库层
if(document.getElementById('result_div')!=null){document.body.removeChild(document.getElementById('result_div'));}
var obj1=document.getElementById(input_id);
    var w = obj1.offsetWidth;
    var h = obj1.offsetHeight;
    var   x   =   obj1.offsetLeft,   y   =   obj1.offsetTop;   
    while(obj1=obj1.offsetParent){ 
       x+=obj1.offsetLeft;   
       y+=obj1.offsetTop;
    }
	var result_div=document.createElement('div');
	result_div.id='result_div';
	result_div.className='result_div1';
	if(input_id.indexOf('quality_result')!=-1||input_id.indexOf('unqualified_reason')!=-1){
		var sleft=document.getElementById('bill_body').offsetParent.scrollLeft;
		var stop=document.getElementById('bill_body').offsetParent.scrollTop;
		x=x-sleft;
		y=y+6+stop;
	}
	result_div.style.top=y+18;
	result_div.style.left=x;
	result_div.style.width=w;
	document.body.appendChild(result_div);
	search_suggest(input_id,result_div,product_id);
	if(document.attachEvent) document.attachEvent('onmousedown',closeResult,event);
	if(document.addEventListener) document.addEventListener('mousedown',closeResult,event);	
}

function search_suggest(input_id,div_obj,param1){//根据输入内容快速查询下拉层
	var search_tag=0;
	if (input_id == 'sampling_standard') {
		search_tag = 2;
	}else if(input_id == 'qcs_result'){
		search_tag = 4;
	}else if(input_id.indexOf('quality_result')!=-1){
		search_tag = 5;
	}else if(input_id.indexOf('unqualified_reason')!=-1){
		search_tag = 6;
	}
	if (param1==''||param1==null){
		return false;
	}
	
		var xmlhttp;
		if(window.XMLHttpRequest){xmlhttp=new XMLHttpRequest();}else if (window.ActiveXObject){xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp) {xmlhttp.onreadystatechange = function() {
			if(xmlhttp.readyState==4){try {if(xmlhttp.status==200){
				//alert(xmlhttp.responseText);
				if(search_tag==5||search_tag==6){
					if(parseInt(xmlhttp.responseText)==0){document.getElementById(input_id).value='';return false;}
				}
				div_obj.innerHTML='';
				if(parseInt(xmlhttp.responseText)==0){
				document.body.removeChild(document.getElementById(div_obj.id));
				if(input_id == 'quality_solution'){alert('该产品未制定质检方案!');}
				}else{
				var div_options =xmlhttp.responseText.split("\n");
				var conter='';
				for (var i = 0; i < div_options.length; i++) {
				var suggest = '<div  onmouseover="style.backgroundColor=\'#E8F2FE\'" onmouseout="style.backgroundColor=\'\'"';
				suggest += 'onclick=\"javascript:setSearch(this.innerHTML,\''+input_id+'\',\''+div_obj.id+'\',\''+param1+'\');\" ';
				suggest += '>' + div_options[i] + '</div>';
				conter += suggest;
				}
				div_obj.innerHTML = null;
				div_obj.innerHTML = '';
				div_obj.innerHTML = conter;
				}
			}else {alert( xmlhttp.status + '=' + xmlhttp.statusText);}} catch(exception) {alert(exception);}}};
			xmlhttp.open("POST", "register_search.jsp", true);
			xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			xmlhttp.send('param1='+encodeURI(param1)+'&search_tag='+encodeURI(search_tag));
		}
	
}
function setSearch(input_value,input_id,div_id,param1){
	document.getElementById(input_id).value = input_value;
	document.body.removeChild(document.getElementById(div_id));
	if(input_value.indexOf('/')!=-1&&input_id=='quality_solution'){
	var solution_id=input_value.split('/')[0];
	var xmlhttp;
	if(window.XMLHttpRequest){xmlhttp=new XMLHttpRequest();}else if (window.ActiveXObject){xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp) {xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState==4){try {if(xmlhttp.status==200){
			if(parseInt(xmlhttp.responseText)==0){return false;}
			var tr_array=xmlhttp.responseText.split("\n");			
			var table_obj = document.getElementById('bill_body');
			var rows_num=table_obj.rows.length;
			for(var j=1;j<rows_num;j++){
				table_obj.deleteRow(1);
			}	
			for(var i=0;i<tr_array.length;i++){
				var td_values=tr_array[i].split('⊙');
				addRow('bill_body');
    			var td_array=table_obj.rows[0].cells;
    			document.getElementById(table_obj.rows[0].cells[0].id+(i+1)).value=td_values[0];
    			document.getElementById(table_obj.rows[0].cells[1].id+(i+1)).value=td_values[1];
    			document.getElementById(table_obj.rows[0].cells[2].id+(i+1)).value=td_values[2];
    			document.getElementById(table_obj.rows[0].cells[3].id+(i+1)).value=td_values[3];
    			document.getElementById(table_obj.rows[0].cells[4].id+(i+1)).value=td_values[4];
    			document.getElementById(table_obj.rows[0].cells[5].id+(i+1)).value=td_values[5];
    			document.getElementById(table_obj.rows[0].cells[6].id+(i+1)).value=td_values[6];
    			document.getElementById(table_obj.rows[0].cells[7].id+(i+1)).value=td_values[7];
			}
		}else{alert( xmlhttp.status + '=' + xmlhttp.statusText);}} catch(exception) {alert(exception);}}};
		xmlhttp.open("POST", "register_search.jsp", true);
		xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		xmlhttp.send('solution_id='+encodeURI(solution_id)+'&search_tag=1');}
		
	}else if(input_value.indexOf('/')!=-1&&input_id=='sampling_standard'){
	var standard_id=input_value.split('/')[0];
	var xmlhttp;
	if(window.XMLHttpRequest){xmlhttp=new XMLHttpRequest();}else if (window.ActiveXObject){xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp) {xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState==4){try {if(xmlhttp.status==200){
			if(parseInt(xmlhttp.responseText)==0){alert('您的质检数量不在该抽样标准范围内!');return false;}
			document.getElementById('sampling_amount').value=eval(xmlhttp.responseText.split('⊙')[0]);
			document.getElementById('accept').value=xmlhttp.responseText.split('⊙')[1];
			document.getElementById('reject').value=xmlhttp.responseText.split('⊙')[2];
		}else{alert( xmlhttp.status + '=' + xmlhttp.statusText);}} catch(exception) {alert(exception);}}};
		xmlhttp.open("POST", "register_search.jsp", true);
		xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		xmlhttp.send('standard_id='+encodeURI(standard_id)+'&quality_amount='+encodeURI(param1)+'&search_tag=3');}
	}
}

function addRow(table_id) {//动态添加行
    var table_obj = document.getElementById(table_id);
    var td_array=table_obj.rows[0].cells;
    var row_num = table_obj.rows.length;
    var tr = table_obj.insertRow(table_obj.rows.length);
    tr.height = '25';
    for(var i=0;i<td_array.length;i++){
    	var td=tr.insertCell(-1);
		td.innerHTML = '<input name=\"'+td_array[i].id+'\" id=\"'+td_array[i].id+row_num+'\" type=\"text\" style=\"width: 100%; height: 100%;\">';
		if(i<8){			
			td.innerHTML = '<input name=\"'+td_array[i].id+'\" id=\"'+td_array[i].id+row_num+'\" type=\"text\" style=\"width: 100%; height: 100%;\" onkeydown=\"return false;\">';
		}
		if(i==12||i==13){			
			td.innerHTML = '<input name=\"'+td_array[i].id+'\" id=\"'+td_array[i].id+row_num+'\" type=\"text\" style=\"width: 100%; height: 100%;\" onkeyup=\"search(\''+td_array[i].id+row_num+'\');\">';
		}
    }        
}
function search(input_id){
	var input_value=document.getElementById(input_id).value;
	loadAjaxDiv(input_id,input_value);
}
var action_tag='';
function formSubmit(){
	var form;
	var form_id;
	if (action_tag == 'register') {
	    form_id='purchase_register';
		form = document.getElementById('purchase_register');
		form.action = '../../qcs_purchase_register_ok';
	}else if (action_tag == 'change') {
	    form_id='purchase_change';
		form = document.getElementById('purchase_change');
		form.action = '../../qcs_purchase_change_ok';
	}else if (action_tag == 'dealwith') {
	    form_id='purchase_dealwith';
		form = document.getElementById('purchase_dealwith');
		form.action = '../../qcs_purchase_dealwith_ok';
		if(document.getElementsByName('dealwith_tag')[1].checked){
		document.getElementById('price_percent').value=parseFloat(document.getElementById('div_price_percent').value)/100;	
		}
	}
	if (doValidate('../../xml/qcs/qcs_purchase.xml',form_id)){
	form.submit();
	}
}
function showFormSubmit(this_tag){
	action_tag=this_tag;
	
	if(action_tag == 'dealwith'){
		if(document.getElementsByName('dealwith_tag')[1].checked){readXml('../../css/include/nseer_cookie/xml-css.css','../../xml/qcs/purchase/dealwith_ok.xml','0');}
		else if(document.getElementsByName('dealwith_tag')[2].checked&&document.getElementById('quality_way').value.split('/')[0]!='02'){readXml('../../css/include/nseer_cookie/xml-css.css','../../xml/qcs/purchase/dealwith_ok1.xml','0');}
		else if(!document.getElementsByName('dealwith_tag')[2].checked&&document.getElementById('limit_tag').value=='1'){readXml('../../css/include/nseer_cookie/xml-css.css','../../xml/qcs/purchase/dealwith_ok2.xml','0');
		}else{
			if(parseInt(document.getElementById('unqualified').value)>parseInt(document.getElementById('reject').value)&&document.getElementById('qcs_result').value.split('/')[0]=='01'){
		readXml('../../css/include/nseer_cookie/xml-css.css','../../xml/qcs/purchase/register_ok.xml','0');
	}else{
			formSubmit();}
		}
	}
	else if(parseInt(document.getElementById('unqualified').value)>parseInt(document.getElementById('reject').value)&&document.getElementById('qcs_result').value.split('/')[0]=='01'){
		readXml('../../css/include/nseer_cookie/xml-css.css','../../xml/qcs/purchase/register_ok.xml','0');
	}
	else{
		formSubmit();
	}
}
