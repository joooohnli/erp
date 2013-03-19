/*
  *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
 function formSubmit(file_chain_id){
 if(doValidate('../../xml/fund/fund_fund.xml','mutiValidation')){
	document.getElementById('mutiValidation').submit();
}
}

function formSubmit1(file_chain_id){
	if((file_chain_id=='2121')){
		var subtotal_array=document.getElementsByName('subtotal');
		var gathered_amount=document.getElementById('executed_cost_price_subtotal');//executed_cost_price_subtotal代表已付金额
		var subtotal=0;
		var subtotal_array_temp;
		
		for(var i=0;i<subtotal_array.length;i++){
			subtotal_array_temp=subtotal_array[i].value==''?'0':subtotal_array[i].value;
			if(subtotal_array_temp!=null&&subtotal_array_temp!='undefined'){
			subtotal+=parseFloat(subtotal_array_temp);				
			}
		}
		subtotal=subtotal+parseFloat(gathered_amount.value);
		if(subtotal>parseFloat(document.getElementById('executing_cost_price_sum').value)){
			alert('本次付款金额加已付金额不能大于限付金额');
			return false;
		}
	}
	return true;
}
