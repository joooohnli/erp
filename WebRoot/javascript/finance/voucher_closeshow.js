/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
function closefile(){//关闭科目层
	document.getElementById('file_tree').style.display ='none';
	file_id='';
}

function closedata(obj){//写入借贷方金额及分录对应的数量、单价，并关闭“数量金额”层
	document.getElementById(obj).style.display ='none';
	qty[data_tag]=document.getElementById('quantity').value;
	netPrice[data_tag]=document.getElementById('net_price').value;
	tax_rate[data_tag]=document.getElementById('tax_rate').value;
	sum[data_tag]=document.getElementById('subtotal').value;
	document.getElementById('qty').value=qty[data_tag]!=undefined?qty[data_tag]:'';
	document.getElementById('netPrice').value=netPrice[data_tag]!=undefined?netPrice[data_tag]:'';
	document.getElementById('sum').value=sum[data_tag]!=undefined?sum[data_tag]:'';
	var sum_direct;
    var sum_direct1;
	if(document.getElementById('sum_direct1').checked){
	sum_direct='aaa'+file_id.substring(3);
	sum_direct1='bbb'+file_id.substring(3);
	sum_direct_temp[data_tag]='0';
	}else{
	sum_direct='bbb'+file_id.substring(3);
	sum_direct1='aaa'+file_id.substring(3);
	sum_direct_temp[data_tag]='1';
	}
	document.getElementById('stock_direct').value=sum_direct_temp[data_tag]!=undefined?sum_direct_temp[data_tag]:'';
	document.getElementById(sum_direct).value=sum[data_tag]!=undefined?sum[data_tag].replace(/\./g,""):'';
	document.getElementById(sum_direct1).value='';
	writeAssis();
	match(sum_direct);
	file_id='';
}

function closedata1(obj){//将结算辅助项层内容赋给数组和页面辅助项
	document.getElementById(obj).style.display ='none';
	settle_way[data_tag]=document.getElementById('settleWay').value;
	attachment_id[data_tag]=document.getElementById('attachmentId').value;
	settle_time[data_tag]=document.getElementById('settleTime').value;
	document.getElementById('settle_way').value=settle_way[data_tag]!=undefined?settle_way[data_tag]:'';
	document.getElementById('attachment_id').value=attachment_id[data_tag]!=undefined?attachment_id[data_tag]:'';
	document.getElementById('settle_time').value=settle_time[data_tag]!=undefined?settle_time[data_tag]:'';
	
	writeAssis();
}

function closesum(){
	document.getElementById('summarydata').style.display ='none';
	summary_id='';
}

function closedata2(obj,evt){
	var sTa=document.getElementById('tablefield2');	
	for(var m=sTa.rows.length-1;m>0;m--){		
		sTa.deleteRow(m);
	}
	row_id2=0;
	cash_direct_temp[row_id]=document.getElementById('cash_direct1').checked?'0':'1';
	document.getElementById(obj).style.display ='none';
	document.getElementById('itemc').style.display='none';
	document.getElementById('cash_direct').value=cash_direct_temp[data_tag]!=undefined?cash_direct_temp[data_tag]:'';
	writeAssis();
	if(bank_tag[data_tag]=='1'){
	document.getElementById('attachmentId').value=attachment_id[data_tag]!=undefined?attachment_id[data_tag]:'';
	document.getElementById('settleWay').value=settle_way[data_tag]!=undefined?settle_way[data_tag]:'';
	document.getElementById('settleTime').value=settle_time[data_tag]!=undefined?settle_time[data_tag]:'';	
	document.getElementById('settlement').style.display ='block';
}
}

function showSummary(obj) {
	document.getElementById('summarydata').style.display ='block';
	
}

function open_cash(obj) {
	document.getElementById('itemc').style.display ='block';
	
}

function fill(obj) {
document.getElementById('search_suggest').style.display='none';
	if(Nseer_tree0=='undefined'||typeof(Nseer_tree0)!='object'){
		changeTab('nseer0');
	}else{
		document.getElementById('file_tree').style.display ='block';
	}
}

function showDiv(arr_number,evt){
if(corr_stock_tag[arr_number]=='是'){
		document.getElementById('ddd0data').style.display ='block';
		document.getElementById('quantity').value=qty[arr_number]!=''?qty[arr_number]:'';
		document.getElementById('net_price').value=netPrice[arr_number]!=''?netPrice[arr_number]:'';
		document.getElementById('tax_rate').value=tax_rate[arr_number]!=''?tax_rate[arr_number]:'';
		document.getElementById('subtotal').value=sum[arr_number]!=''?sum[arr_number]:'';		
		document.getElementById('list_price').value=netPrice[arr_number]!=''?FormatNumberPoint(parseFloat(netPrice[arr_number])*(1+parseFloat(tax_rate[arr_number])/100),2):'';
	}
	if(cash_tag[arr_number]=='1'){
		document.getElementById('qian').style.display ='block';
		
		if(cash_item[arr_number].split('◇')[1]!='⊙'){
			var cash_tr=cash_item[arr_number].split('◇')[1].split('□');
			for(var p=0;p<cash_tr.length;p++){
				addRow1(evt);
				var q=parseInt(p)+1;
				document.getElementById('aaaaa'+q).value=cash_tr[p].split(',')[0];
				document.getElementById('ccccc'+q).value=cash_tr[p].split(',')[1];
				document.getElementById('cash_direct1').checked=true;
				getCashItem(cash_tr[p].split(',')[0],q);
				

			}
		}
	if(cash_itema[arr_number].split('◇')[1]!='⊙'){
			var cash_tr=cash_itema[arr_number].split('◇')[1].split('□');
			for(var p=0;p<cash_tr.length;p++){
				addRow1(evt);
				var q=parseInt(p)+1;
				document.getElementById('aaaaa'+q).value=cash_tr[p].split(',')[0];
				document.getElementById('ccccc'+q).value=cash_tr[p].split(',')[1];
				document.getElementById('cash_direct2').checked=true;
                getCashItem(cash_tr[p].split(',')[0],q);
			}
		}
	}
	if(corr_stock_tag[arr_number]=='否'){
		document.getElementById('quantity').value='';
		qty[arr_number]='';
		document.getElementById('net_price').value='';
		netPrice[arr_number]='';
		document.getElementById('tax_rate').value='';
		tax_rate[arr_number]!='';
		document.getElementById('subtotal').value='';
		sum[arr_number]='';	
		document.getElementById('stock_direct').value='';
		sum_direct_temp[arr_number]='';	
		document.getElementById('list_price').value='';
		document.getElementById('qty').value=qty[arr_number]!=undefined?qty[arr_number]:'';
		document.getElementById('netPrice').value=netPrice[arr_number]!=undefined?netPrice[arr_number]:'';
		document.getElementById('sum').value=sum[arr_number]!=undefined?sum[arr_number]:'';
		writeAssis();
	}
	if(cash_tag[arr_number]=='0'){
		cash_item[arr_number]=arr_number+'◇⊙';
		cash_itema[arr_number]=arr_number+'◇⊙';
		cash_sum[arr_number]='';
		cash_direct_temp[arr_number]='';
		write_hidden1();
	}
}

function dbclick(db_id){//双击后显示相关层
var data_tag=db_id.indexOf('file')!=-1?db_id.substring(3,db_id.indexOf('file')):db_id.substring(3,db_id.length);
if(currency_tag[data_tag]=='1'){
	if(document.getElementById('currency').value!='') document.getElementById('d_currency_name').value=document.getElementById('currency').value;
	if(document.getElementById('cPrice').value) document.getElementById('d_currency_amount').value=document.getElementById('cPrice').value;
	if(document.getElementById('currency_rate').value) document.getElementById('d_currency_rate').value=document.getElementById('currency_rate').value;
	if(cash_item[data_tag].split('◇')[1]!='⊙'){
	document.getElementById('d_sum_direct1').checked=true;
	}else{
	document.getElementById('d_sum_direct2').checked=true;
	}
	document.getElementById('currency_div').style.display='block';
}else if(cash_tag[data_tag]=='1'){
		document.getElementById('fileName').value=document.getElementById(db_id).value;
		if(cash_item[data_tag].split('◇')[1]!='⊙'){
			var cash_tr=cash_item[data_tag].split('◇')[1].split('□');
			for(var p=0;p<cash_tr.length;p++){
				addRow3();
				var q=parseInt(p)+1;
				document.getElementById('aaaaa'+q).value=cash_tr[p].split(',')[0];
				document.getElementById('ccccc'+q).value=cash_tr[p].split(',')[1];
				document.getElementById('cash_direct1').checked=true;
				getCashItem(cash_tr[p].split(',')[0],q);
			}
		}else if(cash_itema[data_tag].split('◇')[1]!='⊙'){
			var cash_tr=cash_itema[data_tag].split('◇')[1].split('□');
			for(var p=0;p<cash_tr.length;p++){
				addRow3();
				var q=parseInt(p)+1;
				document.getElementById('aaaaa'+q).value=cash_tr[p].split(',')[0];
				document.getElementById('ccccc'+q).value=cash_tr[p].split(',')[1];
				document.getElementById('cash_direct2').checked=true;
                getCashItem(cash_tr[p].split(',')[0],q);
			}
		}
		document.getElementById('qian').style.display ='block';
	}
if(corr_stock_tag[data_tag]=='是'){	
		document.getElementById('ddd0data').style.display ='block';
		document.getElementById('quantity').value=qty[data_tag]!=''?qty[data_tag]:'';
		document.getElementById('net_price').value=netPrice[data_tag]!=''?netPrice[data_tag]:'';
		document.getElementById('tax_rate').value=tax_rate[data_tag]!=''?tax_rate[data_tag]:'';
		var tax_rate_temp=tax_rate[data_tag]!=''?tax_rate[data_tag]:'0';
		document.getElementById('subtotal').value=sum[data_tag]!=''?sum[data_tag]:'';		
		document.getElementById('list_price').value=netPrice[data_tag]!=''?FormatNumberPoint(parseFloat(netPrice[data_tag])*(1+parseFloat(tax_rate_temp)/100),2):'';
		if(sum_direct_temp[data_tag]=='0'){
			document.getElementById('sum_direct1').checked=true;
		}else{
			document.getElementById('sum_direct2').checked=true;
		}
	}
}