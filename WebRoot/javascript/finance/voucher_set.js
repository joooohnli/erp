/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
function setSearch(obj,obj1){
	document.getElementById(obj1).value=obj.split(" ")[1];
	document.getElementById('search_suggest').style.display='none';
}

function setFile(obj,obj1){//选入科目
	var arr_number=obj1.substring(3,obj1.length);
	if(obj.split('@#$')[0]=='是'){
		changeFile(file_id.substring(3));
		document.getElementById('ddd0data').style.display ='block';
		document.getElementById('quantity').value=qty[arr_number]!=''?qty[arr_number]:'';
		document.getElementById('net_price').value=netPrice[arr_number]!=''?netPrice[arr_number]:'';
		document.getElementById('tax_rate').value=tax_rate[arr_number]!=''?tax_rate[arr_number]:'';
		document.getElementById('subtotal').value=sum[arr_number]!=''?sum[arr_number]:'';		
		document.getElementById('list_price').value=netPrice[arr_number]!=''?FormatNumberPoint(parseFloat(netPrice[arr_number])*(1+parseFloat(tax_rate[arr_number])/100),2):'';
	}else if(obj.split('@#$')[4]=='1'){
	changeFile(file_id.substring(3));
	var chain_id=obj.split('@#$')[3].substring(0,obj.split('@#$')[3].indexOf(' '));
	var xmlhttp3;
		if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
		xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
		if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
			var currency=xmlhttp3.responseText.split('⊙')[0];
			var currency_rate=xmlhttp3.responseText.split('⊙')[1].substring(0,xmlhttp3.responseText.split('⊙')[1].length-2);
			document.getElementById('d_currency_name').value=currency;
			document.getElementById('d_currency_rate').value=currency_rate;
			document.getElementById('d_cash_tag').value=obj.split('@#$')[1];
			document.getElementById('page_currency_tag').value='1';
		}else {
		alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
		xmlhttp3.open("POST", "registerNew_currency.jsp", true);
		xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		xmlhttp3.send('chain_id='+chain_id);
		}
	document.getElementById('currency_div').style.display ='block';
	}else if(obj.split('@#$')[1]=='1'){
	changeFile(file_id.substring(3));
		document.getElementById('qian').style.display ='block';
		cash_sum_temp[arr_number]='0';
		document.getElementById('fileName').value=obj.split('@#$')[3];
		if(cash_item[arr_number]!=undefined&&cash_item[arr_number].split('◇')[1]!='⊙'){
			var cash_tr=cash_item[arr_number].split('◇')[1].split('□');
			for(var p=0;p<cash_tr.length;p++){
				addRow2();
				var q=parseInt(p)+1;
				document.getElementById('aaaaa'+q).value=cash_tr[p].split(',')[0];
				document.getElementById('ccccc'+q).value=cash_tr[p].split(',')[1];
				document.getElementById('cash_direct1').checked=true;
				getCashItem(cash_tr[p].split(',')[0],q);
			}
		}else if(cash_itema[arr_number]!=undefined&&cash_itema[arr_number].split('◇')[1]!='⊙'){
			var cash_tr=cash_itema[arr_number].split('◇')[1].split('□');
			for(var p=0;p<cash_tr.length;p++){
				addRow2();
				var q=parseInt(p)+1;
				document.getElementById('aaaaa'+q).value=cash_tr[p].split(',')[0];
				document.getElementById('ccccc'+q).value=cash_tr[p].split(',')[1];
				document.getElementById('cash_direct2').checked=true;
                getCashItem(cash_tr[p].split(',')[0],q);
			}
		}
	}else{
	changeFile(file_id.substring(3));
	}
	bank_tag[arr_number]=obj.split('@#$')[2];
	cash_tag[arr_number]=obj.split('@#$')[1];
	corr_stock_tag[arr_number]=obj.split('@#$')[0];
	document.getElementById(obj1).value=obj.split('@#$')[3];
	document.getElementById('search_suggest').style.display='none';
	document.getElementById('page_bank_tag').value=bank_tag[arr_number]!=undefined?bank_tag[arr_number]:'';
	document.getElementById('page_cash_tag').value=cash_tag[arr_number]!=undefined?cash_tag[arr_number]:'';
	document.getElementById('page_corr_stock_tag').value=corr_stock_tag[arr_number]!=undefined?corr_stock_tag[arr_number]:'';
	document.getElementById('cash_direct').value=cash_direct_temp[arr_number]!=undefined?cash_direct_temp[arr_number]:'';
	document.getElementById('stock_direct').value=sum_direct_temp[arr_number]!=undefined?sum_direct_temp[arr_number]:'';
	document.getElementById('cash_sum').value=cash_sum[arr_number]!=undefined?cash_sum[arr_number]:'';
	writeAssis();
	write_hidden1();
}

function setvalue(id,name){
document.getElementById('aaaaa'+row_id2).value=id;
document.getElementById('bbbbb'+row_id2).value=name;
document.getElementById('itemc').style.display='none';
document.getElementById('aaaaa_div'+row_id2).style.display='none';
}

function setCash(obj,evt){
var cash_sum_all=0;
cash_item[row_id]='';
cash_itema[row_id]='';

if(document.getElementById('cash_direct1').checked){
for(var n=1;n<document.getElementById('tablefield2').rows.length;n++){
if(document.getElementById('ccccc'+n).value=='') {
	alert('请正确填写金额');
	return false;
 }
cash_item[row_id]+=document.getElementById('aaaaa'+n).value+','+document.getElementById('ccccc'+n).value.replace(/,/g,'')+'□';
cash_sum_all+=parseFloat(document.getElementById('ccccc'+n).value.replace(/,/g,''));
}
	if(cash_item[row_id]!=''){
		cash_item[row_id]=row_id+'◇'+cash_item[row_id].substring(0,cash_item[row_id].length-1);
	}else{
		cash_item[row_id]=row_id+'◇⊙';
	}
	cash_itema[row_id]=row_id+'◇⊙';
}else{
for(var n=1;n<document.getElementById('tablefield2').rows.length;n++){
cash_itema[row_id]+=document.getElementById('aaaaa'+n).value+','+document.getElementById('ccccc'+n).value.replace(/,/g,'')+'□';
cash_sum_all+=parseFloat(document.getElementById('ccccc'+n).value.replace(/,/g,''));
}
	if(cash_itema[row_id]!=''){
		cash_itema[row_id]=row_id+'◇'+cash_itema[row_id].substring(0,cash_itema[row_id].length-1);
	}else{
		cash_itema[row_id]=row_id+'◇⊙';
	}
	cash_item[row_id]=row_id+'◇⊙';
}
cash_sum[row_id]=cash_sum_all!=0?FormatNumberPoint(cash_sum_all,2).toString().replace(/\./g,''):'';
document.getElementById('cash_sum').value=cash_sum_all!=0?FormatNumberPoint(cash_sum_all,2).toString().replace(/\./g,''):'';
write_hidden1();

var cash_direct=document.getElementById('cash_direct1').checked?'aaa'+row_id:'bbb'+row_id;
var cash_direct1=document.getElementById('cash_direct1').checked?'bbb'+row_id:'aaa'+row_id;

if(FormatNumberPoint(cash_sum_all,'2')!=FormatNumberPoint(parseFloat(document.getElementById(cash_direct).value)/100,'2')&&document.getElementById('cSum').value!='') {
divPrompt2('金额与外币金额不符');
return false;
}
document.getElementById(cash_direct).value=cash_sum_all!=0?FormatNumberPoint(cash_sum_all,2).toString().replace(/\./g,''):'';
	document.getElementById(cash_direct1).value='';
	match(cash_direct);
	
	closedata2(obj,evt);
if(bank_tag[row_id]=='1'){
	document.getElementById('attachmentId').value=attachment_id[row_id]!=undefined?attachment_id[row_id]:'';
	document.getElementById('settleWay').value=settle_way[row_id]!=undefined?settle_way[row_id]:'';
	document.getElementById('settleTime').value=settle_time[row_id]!=undefined?settle_time[row_id]:'';
	document.getElementById('settlement').style.display ='block';
}

cash_sum_temp[row_id]=document.getElementById(cash_direct).value;
cash_direct_temp[row_id]=document.getElementById('cash_direct1').checked?'0':'1';
}

function closeCurrency(tag){
if(tag==1){
document.getElementById('currency').value=document.getElementById('d_currency_name').value;
document.getElementById('currency_rate').value=document.getElementById('d_currency_rate').value;
document.getElementById('cPrice').value=document.getElementById('d_currency_amount').value;
writeAssis();
if(document.getElementById('d_sum_direct1').checked){
	document.getElementById('aaa'+file_id.substring(3)).value=document.getElementById('cSum').value.replace('.','');
	document.getElementById('bbb'+file_id.substring(3)).value='';
	match('aaa'+file_id.substring(3));
}else{
	document.getElementById('bbb'+file_id.substring(3)).value=document.getElementById('cSum').value.replace('.','');
	document.getElementById('aaa'+file_id.substring(3)).value='';
	match('bbb'+file_id.substring(3));
}
}
document.getElementById('currency_div').style.display='none';
var d_cash_tag=document.getElementById('d_cash_tag').value;
if(d_cash_tag=='1'){
	var arr_number='';
		cash_sum_temp[arr_number]='0';
	if(file_id.indexOf('file')==-1){
		document.getElementById('fileName').value=document.getElementById(file_id).value;
		arr_number=file_id.substring(3,file_id.length);
		}else{
		document.getElementById('fileName').value=document.getElementById(file_id).innerHTML;
		arr_number=file_id.substring(3,file_id.length-4);
		}
		if(cash_item[arr_number]!=undefined&&cash_item[arr_number].split('◇')[1]!='⊙'){
			var cash_tr=cash_item[arr_number].split('◇')[1].split('□');
			for(var p=0;p<cash_tr.length;p++){
				addRow2();
				var q=parseInt(p)+1;
				document.getElementById('aaaaa'+q).value=cash_tr[p].split(',')[0];
				document.getElementById('ccccc'+q).value=cash_tr[p].split(',')[1];
				document.getElementById('cash_direct1').checked=true;
				getCashItem(cash_tr[p].split(',')[0],q);
			}
		}else if(cash_itema[arr_number]!=undefined&&cash_itema[arr_number].split('◇')[1]!='⊙'){
			var cash_tr=cash_itema[arr_number].split('◇')[1].split('□');
			for(var p=0;p<cash_tr.length;p++){
				addRow2();
				var q=parseInt(p)+1;
				document.getElementById('aaaaa'+q).value=cash_tr[p].split(',')[0];
				document.getElementById('ccccc'+q).value=cash_tr[p].split(',')[1];
				document.getElementById('cash_direct2').checked=true;
                getCashItem(cash_tr[p].split(',')[0],q);
			}
		}
	}
	document.getElementById('qian').style.display ='block';
}