/*
  *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
var apply_num='';
var gather_id='';
function showBill(num){
	apply_num=num;
	document.getElementById('bill_div').style.display='block';
	document.getElementById('div_product_id').value=document.getElementById('product_id'+num).innerHTML;
	document.getElementById('div_product_name').value=document.getElementById('product_name'+num).innerHTML;
	document.getElementById('div_amount_unit').value=document.getElementById('amount_unit_hidden').value;
	document.getElementById('div_demand_amount').value=document.getElementById('demand_amount').value;
	document.getElementById('div_label').value=num.length==1?'0'+num:num;	
}
function registerOk(form_id){
	var form=document.getElementById(form_id);
	form.action='../../qcs_qcs_manufactureProduct_register_ok';
	form.submit();
}
function showApplyOk(id){
	var amount=parseInt(document.getElementById('product_amount').value);
	for(var i=1;i<=amount;i++){
		if(document.getElementById('qcs_way'+i).value.split('/')[0]!='03'&&document.getElementById('qcsApply_tag'+i).value=='0'){
			var alert_sentence='该入库单中有非免检产品，请完成质检申请';
			multiLangValidate.dwrGetLang("erp",alert_sentence,{callback:function(msg){alert(msg);}});
			return false;
		}
	}
	gather_id=id;
	readXml('../../css/include/nseer_cookie/xml-css.css','../../xml/qcs/qcs/apply_ok.xml','0');
}
function applyOk(){
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200){
window.location='manufactureProduct_register_ok.jsp?finished_tag=0';
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "../../qcs_qcs_manufactureProduct_apply_ok", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('gather_id='+encodeURI(gather_id));
}
}