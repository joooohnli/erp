/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
function deleteRow(evt){//删除凭证行
if(row_id!= null && row_id!=''){
var sTa=document.getElementById('tablefield');
var sTa_rows=sTa.rows.lenth;

if(document.getElementById('aaa'+row_id).value!="") {
var val=document.getElementById('aOuter');
    val.value=parseInt(val.value)-parseInt(document.getElementById('aaa'+row_id).value);
}
if(document.getElementById('bbb'+row_id).value!="") {
var va2=document.getElementById('bOuter');
    va2.value=parseInt(va2.value)-parseInt(document.getElementById('bbb'+row_id).value);
}
if(row_id==0){
  for(var m=0;m<sTa.getElementsByTagName('tr')[0].getElementsByTagName('input').length;m++){
			sTa.getElementsByTagName('tr')[0].getElementsByTagName('input')[m].value='';
	   }
	qty[0]='';
netPrice[0]='';
tax_rate[0]='';
sum[0]='';
currency[0]='';
cPrice[0]='';
currency_rate[0]='';
cSum[0]='';
department[0]='';
project[0]='';
attachment_id[0]='';
settle_way[0]='';
settle_time[0]='';
customer[0]='';
product[0]='';
order[0]='';
remark[0]='';
cash_tag[0]='';
corr_stock_tag[0]='';
bank_tag[0]='';
cash_direct_temp[0]='';
sum_direct_temp[0]='';
cash_sum[0]='';
currency_tag[0]='';
cash_item[0]='0◇⊙';
cash_itema[0]='0◇⊙';
    }else{
		sTa.deleteRow(row_id);
		var sTa1=document.getElementById('tablefield');
		for(var j=0;j<sTa1.rows.length;j++){
	    sTa1.getElementsByTagName('tr')[j].id=j;
		
		for(var m=0;m<document.getElementById(j).getElementsByTagName('input').length;m++){
			
			if(m==1){
			sTa1.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='ddd'+j;
			}else if(m==2){
			sTa1.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='aaa'+j;
			}else if(m==3){
			sTa1.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='bbb'+j;
			}else if(m==0){
			sTa1.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='ccc'+j;
			}
	   }
	   for(var m=0;m<sTa1.getElementsByTagName('tr')[j].getElementsByTagName('div').length;m++){
	       if(m==0){
			sTa1.getElementsByTagName('tr')[j].getElementsByTagName('div')[m].id='c_div'+j;
			}else{
            sTa1.getElementsByTagName('tr')[j].getElementsByTagName('div')[m].id='d_div'+j;
			} 
	   }
    }
		if(document.getElementById('tablefield').rows.length<5){
		var rows=parseInt(document.getElementById('tablefield').rows.length)-1;
		rows="abc"+rows;
		addRow(rows,evt);
}
for(var m=data_tag;m<qty.length-1;m++){
	var mm=parseInt(m)+1;
	qty[m]=qty[mm];
	netPrice[m]=netPrice[mm];
	tax_rate[m]=tax_rate[mm];
	sum[m]=sum[mm];
	currency[m]=currency[mm];
	cPrice[m]=cPrice[mm];
	currency_rate[m]=currency_rate[mm];
	cSum[m]=cSum[mm];
	department[m]=department[mm];
	project[m]=project[mm];
	attachment_id[m]=attachment_id[mm];
	settle_way[m]=settle_way[mm];
	settle_time[m]=settle_time[mm];
	customer[m]=customer[mm];
	product[m]=product[mm];
	order[m]=order[mm];
	remark[m]=remark[mm];
	cash_tag[m]=cash_tag[mm];
	corr_stock_tag[m]=corr_stock_tag[mm];
	bank_tag[m]=bank_tag[mm];
	cash_direct_temp[m]=cash_direct_temp[mm];
	sum_direct_temp[m]=sum_direct_temp[mm];
	currency_tag[m]=currency_tag[mm];
	cash_sum[m]=cash_sum[mm];
	cash_item[m]=parseInt(cash_item[mm].split('◇')[0])-1+'◇'+cash_item[mm].split('◇')[1];
	cash_itema[m]=parseInt(cash_itema[mm].split('◇')[0])-1+'◇'+cash_itema[mm].split('◇')[1];
	}
qty[qty.length-1]='';
netPrice[qty.length-1]='';
tax_rate[qty.length-1]='';
sum[qty.length-1]='';
currency[qty.length-1]='';
cPrice[qty.length-1]='';
currency_rate[qty.length-1]='';
cSum[qty.length-1]='';
department[qty.length-1]='';
project[qty.length-1]='';
attachment_id[qty.length-1]='';
settle_way[qty.length-1]='';
settle_time[qty.length-1]='';
customer[qty.length-1]='';
product[qty.length-1]='';
order[qty.length-1]='';
remark[qty.length-1]='';
cash_tag[qty.length-1]='';
corr_stock_tag[qty.length-1]='';
bank_tag[qty.length-1]='';
cash_direct_temp[qty.length-1]='';
sum_direct_temp[qty.length-1]='';
cash_sum[qty.length-1]='';
currency_tag[qty.length-1]='';
cash_item[qty.length-1]=qty.length-1+'◇⊙';
cash_itema[qty.length-1]=qty.length-1+'◇⊙';
	}	
  row_id='';
  }else{
    return false;
  }
write_hidden();
write_hidden1();
row_id33='';
}

function deleteRow1(evt){//删除
if(row_id2!=0){
var sTa=document.getElementById('tablefield2');
sTa.deleteRow(row_id2);
for(j=0;j<sTa.rows.length;j++){
	   sTa.getElementsByTagName('tr')[j].id=j;
	  for(var m=0;m<sTa.getElementsByTagName('tr')[j].getElementsByTagName('input').length;m++){
			if(m==0){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='aaaaa'+j;
			}else if(m==1){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='bbbbb'+j;
			}else if(m==2){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='ccccc'+j;
			}
	   }
	   for(var m=0;m<sTa.getElementsByTagName('tr')[j].getElementsByTagName('div').length;m++){
	       if(m==0){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('div')[m].id='aaaaa_div'+j;
			}
	   }
    }
 }else{
	 alert("请选择要删除的行！");
	 }
 row_id2=0;
}

function changeFile(row_id){
qty[row_id]='';
netPrice[row_id]='';
tax_rate[row_id]='';
sum[row_id]='';
currency[row_id]='';
cPrice[row_id]='';
currency_rate[row_id]='';
cSum[row_id]='';
department[row_id]='';
project[row_id]='';
attachment_id[row_id]='';
settle_way[row_id]='';
settle_time[row_id]='';
customer[row_id]='';
product[row_id]='';
order[row_id]='';
remark[row_id]='';
cash_tag[row_id]='';
corr_stock_tag[row_id]='';
bank_tag[row_id]='';
cash_direct_temp[row_id]='';
sum_direct_temp[row_id]='';
cash_sum[row_id]='';
currency_tag[row_id]='';
cash_item[row_id]=row_id+'◇⊙';
cash_itema[row_id]=row_id+'◇⊙';

	document.getElementById('qty').value=qty[row_id];
	document.getElementById('netPrice').value=netPrice[row_id];
	document.getElementById('tax_rate').value=tax_rate[row_id];
	document.getElementById('sum').value=sum[row_id];
	document.getElementById('currency').value=currency[row_id];
	document.getElementById('cPrice').value=cPrice[row_id];
	document.getElementById('currency_rate').value=currency_rate[row_id];
	document.getElementById('cSum').value=sum[row_id];
	document.getElementById('department').value=department[row_id];
	document.getElementById('project').value=project[row_id];
	document.getElementById('attachment_id').value=attachment_id[row_id];
	document.getElementById('settle_way').value=settle_way[row_id];
    document.getElementById('settle_time').value=settle_time[row_id];
	document.getElementById('customer').value=customer[row_id];
	document.getElementById('product').value=product[row_id];
	document.getElementById('order').value=order[row_id];
	document.getElementById('remark').value=remark[row_id];
	document.getElementById('page_bank_tag').value=bank_tag[row_id];
	document.getElementById('page_cash_tag').value=cash_tag[row_id];
	document.getElementById('page_corr_stock_tag').value=corr_stock_tag[row_id];
	document.getElementById('cash_direct').value=cash_direct_temp[row_id];
	document.getElementById('stock_direct').value=sum_direct_temp[row_id];
	document.getElementById('cash_sum').value=cash_sum[row_id];
	document.getElementById('page_currency_tag').value=currency_tag[row_id];
	document.getElementById('d_currency_amount').value='';
	document.getElementById('currency_rate').value='';
}