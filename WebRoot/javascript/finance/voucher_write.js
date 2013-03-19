/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
function write_hidden(){//为所有辅助项隐含元素赋值
	var qty_arr='';
	var netPrice_arr='';
	var tax_rate_arr='';
	var sum_arr='';
	var currency_arr='';
	var cPrice_arr='';
	var currency_rate_arr='';
	var cSum_arr='';
	var department_arr='';
	var project_arr='';
	var attachment_id_arr='';
	var settle_way_arr='';
	var settle_time_arr='';
	var customer_arr='';
	var product_arr='';
	var order_arr='';
	var remark_arr='';
	var bank_tag_arr='';
	var cash_tag_arr='';
	var corr_stock_tag_arr='';
	var cash_direct_arr='';
	var stock_direct_arr='';
	var cash_sum_arr='';
	var currency_tag_arr='';
	for(var m=0;m<qty.length;m++){
			qty_arr+=qty[m]!=undefined&&qty[m]!=''?qty[m]+'◎':'⊙◎';
			netPrice_arr+=netPrice[m]!=undefined&&netPrice[m]!=''?netPrice[m]+'◎':'⊙◎';
			tax_rate_arr+=tax_rate[m]!=undefined&&tax_rate[m]!=''?tax_rate[m]+'◎':'⊙◎';
			sum_arr+=sum[m]!=undefined&&sum[m]!=''?sum[m]+'◎':'⊙◎';
			currency_arr+=currency[m]!=undefined&&currency[m]!=''?currency[m]+'◎':'⊙◎';
			cPrice_arr+=cPrice[m]!=undefined&&cPrice[m]!=''?cPrice[m]+'◎':'⊙◎';
			currency_rate_arr+=currency_rate[m]!=undefined&&currency_rate[m]!=''?currency_rate[m]+'◎':'⊙◎';
			cPrice_arr+=cPrice[m]!=undefined&&cPrice[m]!=''?cPrice[m]+'◎':'⊙◎';
			cSum_arr+=cSum[m]!=undefined&&cSum[m]!=''?cSum[m]+'◎':'⊙◎';
			department_arr+=department[m]!=undefined&&department[m]!=''?department[m]+'◎':'⊙◎';
			project_arr+=project[m]!=undefined&&project[m]!=''?project[m]+'◎':'⊙◎';
			attachment_id_arr+=attachment_id[m]!=undefined&&attachment_id[m]!=''?attachment_id[m]+'◎':'⊙◎';
			settle_way_arr+=settle_way[m]!=undefined&&settle_way[m]!=''?settle_way[m]+'◎':'⊙◎';
			settle_time_arr+=settle_time[m]!=undefined&&settle_time[m]!=''?settle_time[m]+'◎':'⊙◎';
			customer_arr+=customer[m]!=undefined&&customer[m]!=''?customer[m]+'◎':'⊙◎';
			product_arr+=product[m]!=undefined&&product[m]!=''?product[m]+'◎':'⊙◎';
			order_arr+=order[m]!=undefined&&order[m]!=''?order[m]+'◎':'⊙◎';
			remark_arr+=remark[m]!=undefined&&remark[m]!=''?remark[m]+'◎':'⊙◎';
			bank_tag_arr+=bank_tag[m]!=undefined&&bank_tag[m]!=''?bank_tag[m]+'◎':'⊙◎';
			cash_tag_arr+=cash_tag[m]!=undefined&&cash_tag[m]!=''?cash_tag[m]+'◎':'⊙◎';
			corr_stock_tag_arr+=corr_stock_tag[m]!=undefined&&corr_stock_tag[m]!=''?corr_stock_tag[m]+'◎':'⊙◎';
			cash_direct_arr+=cash_direct_temp[m]!=undefined&&cash_direct_temp[m]!=''?cash_direct_temp[m]+'◎':'⊙◎';
			stock_direct_arr+=sum_direct_temp[m]!=undefined&&sum_direct_temp[m]!=''?sum_direct_temp[m]+'◎':'⊙◎';
			cash_sum_arr+=cash_sum[m]!=undefined&&cash_sum[m]!=''?cash_sum[m]+'◎':'⊙◎';
			currency_tag_arr+=currency_tag[m]!=undefined&&currency_tag[m]!=''?currency_tag[m]+'◎':'⊙◎';
	}
	document.getElementById('qty_arr').value=qty_arr.substring(0,qty_arr.length-1);
	document.getElementById('netPrice_arr').value=netPrice_arr.substring(0,netPrice_arr.length-1);
	document.getElementById('tax_rate_arr').value=tax_rate_arr.substring(0,tax_rate_arr.length-1);
	document.getElementById('sum_arr').value=sum_arr.substring(0,sum_arr.length-1);
	document.getElementById('currency_arr').value=currency_arr.substring(0,currency_arr.length-1);
	document.getElementById('cPrice_arr').value=cPrice_arr.substring(0,cPrice_arr.length-1);
	document.getElementById('cSum_arr').value=cSum_arr.substring(0,cPrice_arr.length-1);
	document.getElementById('currency_rate_arr').value=currency_rate_arr.substring(0,currency_rate_arr.length-1);
	document.getElementById('cPrice_arr').value=cPrice_arr.substring(0,cPrice_arr.length-1);
	document.getElementById('department_arr').value=department_arr.substring(0,department_arr.length-1);
	document.getElementById('project_arr').value=project_arr.substring(0,project_arr.length-1);
	document.getElementById('attachment_id_arr').value=attachment_id_arr.substring(0,attachment_id_arr.length-1);
	document.getElementById('settle_way_arr').value=settle_way_arr.substring(0,settle_way_arr.length-1);
	document.getElementById('settle_time_arr').value=settle_time_arr.substring(0,settle_time_arr.length-1);
	document.getElementById('customer_arr').value=customer_arr.substring(0,customer_arr.length-1);
	document.getElementById('product_arr').value=product_arr.substring(0,product_arr.length-1);
	document.getElementById('order_arr').value=order_arr.substring(0,order_arr.length-1);
	document.getElementById('remark_arr').value=remark_arr.substring(0,remark_arr.length-1);
	document.getElementById('bank_tag_arr').value=bank_tag_arr.substring(0,bank_tag_arr.length-1);
	document.getElementById('cash_tag_arr').value=cash_tag_arr.substring(0,cash_tag_arr.length-1);
	document.getElementById('corr_stock_tag_arr').value=corr_stock_tag_arr.substring(0,corr_stock_tag_arr.length-1);
	document.getElementById('cash_direct_arr').value=cash_direct_arr.substring(0,cash_direct_arr.length-1);
	document.getElementById('stock_direct_arr').value=stock_direct_arr.substring(0,stock_direct_arr.length-1);
	document.getElementById('cash_sum_arr').value=cash_sum_arr.substring(0,cash_sum_arr.length-1);
	document.getElementById('currency_tag_arr').value=currency_tag_arr.substring(0,currency_tag_arr.length-1);
}

function write_hidden1(){//为现金流量科目隐含元素赋值
	var cash_item_arr='';
	var cash_itema_arr='';
	var cash_sum_arr='';
for(var m=0;m<cash_item.length;m++){
			cash_item_arr+=cash_item[m]!=undefined&&cash_item[m]!=''?cash_item[m]+'◎':'⊙◎';
			cash_itema_arr+=cash_itema[m]!=undefined&&cash_itema[m]!=''?cash_itema[m]+'◎':'⊙◎';
			cash_sum_arr+=cash_sum[m]!=undefined&&cash_sum[m]!=''?cash_sum[m]+'◎':'⊙◎';
	}
	document.getElementById('cash_item_arr').value=cash_item_arr.substring(0,cash_item_arr.length-1);
	document.getElementById('cash_itema_arr').value=cash_itema_arr.substring(0,cash_itema_arr.length-1);
	document.getElementById('cash_sum_arr').value=cash_sum_arr.substring(0,cash_sum_arr.length-1);
}

function writeAssis(){//为辅助项数组赋值	
	qty[data_tag]=document.getElementById('qty').value;
	netPrice[data_tag]=document.getElementById('netPrice').value;
	tax_rate[data_tag]=document.getElementById('tax_rate').value;

	if(qty[data_tag]!=''&&netPrice[data_tag]!=''){	sum[data_tag]=FormatNumberPoint(parseFloat(document.getElementById('qty').value)*parseFloat(document.getElementById('netPrice').value),2);
	document.getElementById('sum').value=sum[data_tag];
	}else{
	sum[data_tag]='';
	document.getElementById('sum').value=sum[data_tag];
	}
	currency[data_tag]=document.getElementById('currency').value;
	cPrice[data_tag]=document.getElementById('cPrice').value;
	currency_rate[data_tag]=document.getElementById('currency_rate').value;
	if(cPrice[data_tag]!=''&&currency_rate[data_tag]!=''){	cSum[data_tag]=FormatNumberPoint(parseFloat(document.getElementById('cPrice').value)*parseFloat(document.getElementById('currency_rate').value),2);
	document.getElementById('cSum').value=cSum[data_tag];
	}else{
	cSum[data_tag]='';
	document.getElementById('cSum').value=sum[data_tag];
	}
	department[data_tag]=document.getElementById('department').value;
	project[data_tag]=document.getElementById('project').value;
	attachment_id[data_tag]=document.getElementById('attachment_id').value;
	settle_way[data_tag]=document.getElementById('settle_way').value;
    settle_time[data_tag]=document.getElementById('settle_time').value;
	customer[data_tag]=document.getElementById('customer').value;
	product[data_tag]=document.getElementById('product').value;
	order[data_tag]=document.getElementById('order').value;
	remark[data_tag]=document.getElementById('remark').value;
	bank_tag[data_tag]=document.getElementById('page_bank_tag').value;
	cash_tag[data_tag]=document.getElementById('page_cash_tag').value;
	corr_stock_tag[data_tag]=document.getElementById('page_corr_stock_tag').value;
	cash_direct_temp[data_tag]=document.getElementById('cash_direct').value;
	sum_direct_temp[data_tag]=document.getElementById('stock_direct').value;
	cash_sum[data_tag]=document.getElementById('cash_sum').value;
	currency_tag[data_tag]=document.getElementById('page_currency_tag').value;
	write_hidden();
}

function writerfile(evt){
	var file_value=document.getElementById(file_id).value;
	if(file_value!=''){
	var arr_number=file_id.substring(3,file_id.length);
	getFileAttribute(file_value.substring(0,file_value.indexOf(' ')),arr_number,evt);
	blur1(file_id);
	data_div=file_id+'data';
	
	}else{
		return false;
	}
}

function writer(obj){ 
 var value1=obj.options[obj.selectedIndex].value;
 if (value1!='') {
 document.getElementById(summary_id).value=value1;
 }
 document.getElementById('summarydata').style.display ='none';
 blur1(summary_id);
}

