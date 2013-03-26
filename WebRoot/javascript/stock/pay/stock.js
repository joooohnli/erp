function registerOk() {
	//去处质检功能
//	var table_obj = document.getElementById('bill_body');
//	var tr_array = table_obj.rows.length;
//	for ( var i = 1; i < tr_array; i++) {
//		var amount = document.getElementById('amount' + i).value;
//		if (amount != '') {
//			var paid_amount = document.getElementById('paid_amount' + i).value;
//			var qualified_amount = document
//					.getElementById('qualified_amount' + i).value;
//			if (parseInt(amount) + parseInt(paid_amount) > parseInt(qualified_amount)) {
//				alert('本次出库数量加已出库数量不能大于质检合格数量');
//				return false;
//			}
//		}
//	}
	var form;
	form = document.getElementById('mutiValidation');
	form.action = '../../stock_pay_register_ok';
	if (doValidate('../../xml/stock/stock_pay.xml', 'mutiValidation')) {
		form.submit();
	}
}
function checkOk() {
	//去处质检功能
//	var table_obj = document.getElementById('bill_body');
//	var tr_array = table_obj.rows.length;
//	for ( var i = 1; i < tr_array; i++) {
//		var amount = document.getElementById('amount' + i).value;
//		if (amount != '') {
//			var paid_amount = document.getElementById('paid_amount' + i).value;
//			var qualified_amount = document
//					.getElementById('qualified_amount' + i).value;
//			if (parseInt(amount) + parseInt(paid_amount) > parseInt(qualified_amount)) {
//				alert('本次出库数量加已出库数量不能大于质检合格数量');
//				return false;
//			}
//		}
//	}
	var form;
	form = document.getElementById('mutiValidation');
	form.action = '../../stock_pay_check_ok';
	form.submit();
}
