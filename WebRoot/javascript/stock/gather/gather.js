/*
  *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
 function formSubmit(reason,dealwith_tag){
 if (doValidate('../../xml/stock/stock_gather.xml','mutiValidation')){
	if((reason=='委外入库'||reason=='采购入库')&&dealwith_tag=='3'){
		var amount_array=document.getElementsByName('amount');
		var gathered_amount_array=document.getElementsByName('gathered_amount');
		var subtotal=0;
		var amount_array_temp;
		for(var i=0;i<amount_array.length;i++){
			amount_array_temp=amount_array[i].value==''?'0':amount_array[i].value;
			if(amount_array_temp!=null&&amount_array_temp!='undefined'){
	
			subtotal+=parseFloat(amount_array_temp)+parseFloat(gathered_amount_array[i].value);
				
			}
		}

		if(subtotal>parseFloat(document.getElementById('qualified_amount').value)){
			alert('本次入库数量加已入库件数不能大于质检合格数');
			return false;
		}
	}
	document.getElementById('mutiValidation').submit();
	}
}

function formSubmit1(reason,dealwith_tag){
	if((reason=='委外入库'||reason=='采购入库')&&dealwith_tag=='3'){
		var amount_array=document.getElementsByName('amount');
		var gathered_amount=document.getElementById('gathered_total_amount');
		var subtotal=0;
		var amount_array_temp;
		for(var i=0;i<amount_array.length;i++){
			amount_array_temp=amount_array[i].value==''?'0':amount_array[i].value;
			if(amount_array_temp!=null&&amount_array_temp!='undefined'){
	
			subtotal+=parseFloat(amount_array_temp);
				
			}
		}
		subtotal=subtotal+parseFloat(gathered_amount.value);
		
		if(subtotal>parseFloat(document.getElementById('qualified_amount').value)){
			alert('本次入库数量加已入库件数不能大于质检合格数');
			return false;
		}
	}
	return true;
}
