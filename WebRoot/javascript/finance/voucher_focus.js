/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
var select_input_id;
function fo(id){//聚焦事件，得到input框的ID，显示后面的小层。
if(id.substring(3)!='0'){
if(document.getElementById('ccc'+(id.substring(3)-1)).value==''||document.getElementById('ddd'+(id.substring(3)-1)).value==''||(document.getElementById('aaa'+(id.substring(3)-1)).value==''&&document.getElementById('bbb'+(id.substring(3)-1)).value=='')){
	if(id.indexOf('ccc')==0) document.getElementById('c_div'+id.substring(3)).style.display='none';
	if(id.indexOf('ddd')==0) {
		document.getElementById('d_div'+id.substring(3)).style.display='none';
	}
	document.getElementById(id).blur();
	if(id.substring(3,id.length)!=data_tag) data_tag=id.substring(3,id.length);
	alert('请按正确顺序填写分录');
	return false;
}
}

if(document.getElementById('search_suggest').style.display=='block'){
	document.getElementById('search_suggest').style.display='none';
}
if(id.substring(3,id.length)!=data_tag){
data_tag=id.substring(3,id.length);
document.getElementById('qty').value=qty[data_tag]!=undefined?qty[data_tag]:'';
document.getElementById('netPrice').value=netPrice[data_tag]!=undefined?netPrice[data_tag]:'';
document.getElementById('tax_rate').value=tax_rate[data_tag]!=undefined?tax_rate[data_tag]:'';
document.getElementById('sum').value=sum[data_tag]!=undefined?sum[data_tag]:'';
document.getElementById('currency').value=currency[data_tag]!=undefined?currency[data_tag]:'';
document.getElementById('cPrice').value=cPrice[data_tag]!=undefined?cPrice[data_tag]:'';
document.getElementById('currency_rate').value=currency_rate[data_tag]!=undefined?currency_rate[data_tag]:'';
document.getElementById('cSum').value=cSum[data_tag]!=undefined?cSum[data_tag]:'';
document.getElementById('department').value=department[data_tag]!=undefined?department[data_tag]:'';
document.getElementById('project').value=project[data_tag]!=undefined?project[data_tag]:'';
document.getElementById('attachment_id').value=attachment_id[data_tag]!=undefined?attachment_id[data_tag]:'';
document.getElementById('settle_way').value=settle_way[data_tag]!=undefined?settle_way[data_tag]:'';
document.getElementById('settle_time').value=settle_time[data_tag]!=undefined?settle_time[data_tag]:'';
document.getElementById('customer').value=customer[data_tag]!=undefined?customer[data_tag]:'';
document.getElementById('product').value=product[data_tag]!=undefined?product[data_tag]:'';
document.getElementById('order').value=order[data_tag]!=undefined?order[data_tag]:'';
document.getElementById('remark').value=remark[data_tag]!=undefined?remark[data_tag]:'';
document.getElementById('page_bank_tag').value=bank_tag[data_tag]!=undefined?bank_tag[data_tag]:'';
document.getElementById('page_cash_tag').value=cash_tag[data_tag]!=undefined?cash_tag[data_tag]:'';
document.getElementById('page_corr_stock_tag').value=corr_stock_tag[data_tag]!=undefined?corr_stock_tag[data_tag]:'';
document.getElementById('cash_direct').value=cash_direct_temp[data_tag]!=undefined?cash_direct_temp[data_tag]:'';
document.getElementById('stock_direct').value=sum_direct_temp[data_tag]!=undefined?sum_direct_temp[data_tag]:'';
document.getElementById('cash_sum').value=cash_sum[data_tag]!=undefined?cash_sum[data_tag]:'';
document.getElementById('page_currency_tag').value=currency_tag[data_tag]!=undefined?currency_tag[data_tag]:'';
cash_item[data_tag]=cash_item[data_tag]!=undefined?cash_item[data_tag]:data_tag+'◇⊙';
cash_itema[data_tag]=cash_itema[data_tag]!=undefined?cash_itema[data_tag]:data_tag+'◇⊙';
}
writeAssis();
write_hidden1();
summary_id=id;
file_id=id;
row_id=id.substring(3);
if (id.indexOf('ccc') == 0) {
if(isFirefox=navigator.userAgent.indexOf("Firefox")>0){
loadMirror(document.getElementById(id),'c_div' + row_id);
}
        document.getElementById('c_div' + row_id).style.display = 'block';
		document.getElementById('d_div' + row_id).style.display = 'none';
		if(row_id33!=''&&row_id33!=row_id){
		document.getElementById('c_div' + row_id33).style.display = 'none';
		document.getElementById('d_div' + row_id33).style.display = 'none';

		}
		row_id33=row_id;
    }else if (id.indexOf('ddd') == 0) {
if(isFirefox=navigator.userAgent.indexOf("Firefox")>0){
loadMirror(document.getElementById(id),'d_div' + row_id);
}
        document.getElementById('d_div' + row_id).style.display = 'block';
		document.getElementById('c_div' + row_id).style.display = 'none';
		if(row_id33!=''&&row_id33!=row_id){
		document.getElementById('d_div' + row_id33).style.display = 'none';
		document.getElementById('c_div' + row_id33).style.display = 'none';

		}
		row_id33=row_id;
    }else{
		if(row_id33!=''){
	    document.getElementById('d_div' + row_id33).style.display = 'none';
		document.getElementById('c_div' + row_id33).style.display = 'none';
        row_id33='';
		}
	}
}

function fox(id){//聚焦事件，得到input框的ID，显示后面的小层
file_id=id;
var arr_number=id.indexOf('file')!=-1?id.substring(3,id.indexOf('file')):id;
document.getElementById(id).focus=function(){this.blur();}
id=id.indexOf('file')!=-1?id.substring(0,id.indexOf('file')):id;
if(id.substring(3,id.length)!=data_tag){
data_tag=id.substring(3,id.length);
document.getElementById('qty').value=qty[data_tag]!=undefined?qty[data_tag]:'';
document.getElementById('netPrice').value=netPrice[data_tag]!=undefined?netPrice[data_tag]:'';
document.getElementById('tax_rate').value=tax_rate[data_tag]!=undefined?tax_rate[data_tag]:'';
document.getElementById('sum').value=sum[data_tag]!=undefined?sum[data_tag]:'';
document.getElementById('currency').value=currency[data_tag]!=undefined?currency[data_tag]:'';
document.getElementById('cPrice').value=cPrice[data_tag]!=undefined?cPrice[data_tag]:'';
document.getElementById('currency_rate').value=currency_rate[data_tag]!=undefined?currency_rate[data_tag]:'';
document.getElementById('cSum').value=cSum[data_tag]!=undefined?cSum[data_tag]:'';
document.getElementById('department').value=department[data_tag]!=undefined?department[data_tag]:'';
document.getElementById('project').value=project[data_tag]!=undefined?project[data_tag]:'';
document.getElementById('attachment_id').value=attachment_id[data_tag]!=undefined?attachment_id[data_tag]:'';
document.getElementById('settle_way').value=settle_way[data_tag]!=undefined?settle_way[data_tag]:'';
document.getElementById('settle_time').value=settle_time[data_tag]!=undefined?settle_time[data_tag]:'';
document.getElementById('customer').value=customer[data_tag]!=undefined?customer[data_tag]:'';
document.getElementById('product').value=product[data_tag]!=undefined?product[data_tag]:'';
document.getElementById('order').value=order[data_tag]!=undefined?order[data_tag]:'';
document.getElementById('remark').value=remark[data_tag]!=undefined?remark[data_tag]:'';
document.getElementById('page_bank_tag').value=bank_tag[data_tag]!=undefined?bank_tag[data_tag]:'';
document.getElementById('page_cash_tag').value=cash_tag[data_tag]!=undefined?cash_tag[data_tag]:'';
document.getElementById('page_corr_stock_tag').value=corr_stock_tag[data_tag]!=undefined?corr_stock_tag[data_tag]:'';
document.getElementById('cash_direct').value=cash_direct_temp[data_tag]!=undefined?cash_direct_temp[data_tag]:'';
document.getElementById('stock_direct').value=sum_direct_temp[data_tag]!=undefined?sum_direct_temp[data_tag]:'';
document.getElementById('cash_sum').value=cash_sum[data_tag]!=undefined?cash_sum[data_tag]:'';
document.getElementById('page_currency_tag').value=currency_tag[data_tag]!=undefined?currency_tag[data_tag]:'';
cash_item[data_tag]=cash_item[data_tag]!=undefined?cash_item[data_tag]:data_tag+'◇⊙';
cash_itema[data_tag]=cash_itema[data_tag]!=undefined?cash_itema[data_tag]:data_tag+'◇⊙';
}
writeAssis();
write_hidden1();

if(currency_tag[arr_number]=='1'){
	if(document.getElementById('currency').value!='') document.getElementById('d_currency_name').value=document.getElementById('currency').value;
	if(document.getElementById('cPrice').value) document.getElementById('d_currency_amount').value=document.getElementById('cPrice').value;
	if(document.getElementById('currency_rate').value) document.getElementById('d_currency_rate').value=document.getElementById('currency_rate').value;
	if(cash_item[arr_number].split('◇')[1]!='⊙'){
	document.getElementById('d_sum_direct1').checked=true;
	}else{
	document.getElementById('d_sum_direct2').checked=true;
	}
	document.getElementById('currency_div').style.display='block';
}else if(cash_tag[arr_number]=='1'){
		document.getElementById('qian').style.display ='block';
		document.getElementById('fileName').value=document.getElementById(id).innerHTML;
		if(cash_item[arr_number].split('◇')[1]!='⊙'){
			var cash_tr=cash_item[arr_number].split('◇')[1].split('□');
			for(var p=0;p<cash_tr.length;p++){
				addRow2();
				var q=parseInt(p)+1;
				document.getElementById('aaaaa'+q).value=cash_tr[p].split(',')[0];
				document.getElementById('ccccc'+q).value=cash_tr[p].split(',')[1];
				document.getElementById('cash_direct1').checked=true;
				getCashItem(cash_tr[p].split(',')[0],q);
			}
		}else if(cash_itema[arr_number].split('◇')[1]!='⊙'){
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
if(corr_stock_tag[arr_number]=='是'){	
		document.getElementById('ddd0data').style.display ='block';
		document.getElementById('quantity').value=qty[arr_number]!=''?qty[arr_number]:'';
		document.getElementById('net_price').value=netPrice[arr_number]!=''?netPrice[arr_number]:'';
		document.getElementById('tax_rate').value=tax_rate[arr_number]!=''?tax_rate[arr_number]:'';
		var tax_rate_temp=tax_rate[arr_number]!=''?tax_rate[arr_number]:'0';
		document.getElementById('subtotal').value=sum[arr_number]!=''?sum[arr_number]:'';		
		document.getElementById('list_price').value=netPrice[arr_number]!=''?FormatNumberPoint(parseFloat(netPrice[arr_number])*(1+parseFloat(tax_rate_temp)/100),2):'';
		if(debit_tag[arr_number]=='1'){
			document.getElementById('sum_direct1').checked=true;
		}else{
			document.getElementById('sum_direct2').checked=true;
		}
	}
}

function fo2(id){//聚焦事件，得到input框的ID，显示后面的小层。
row_id2=parseInt(id.substring(5));
if(isFirefox=navigator.userAgent.indexOf("Firefox")>0){
loadMirror(document.getElementById(id),'aaaaa_div' + row_id2);
}
if(id.indexOf("aaaaa")==0) document.getElementById('aaaaa_div'+row_id2).style.display="block";  
}

function blur1(id){//聚焦事件，得到input框的ID，关闭后面的小层。
var blur1=id.substring(3);
if(id.indexOf("ccc")==0){document.getElementById('c_div'+blur1).style.display="none";}
else if(id.indexOf("ddd")==0){document.getElementById('d_div'+blur1).style.display="none";}  
}

function blur2(id){//聚焦事件，得到input框的ID，显示后面的小层。
document.getElementById('aaaaa_div'+row_id2).style.display="none";
}