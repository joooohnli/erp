/*
 * 
 */
function beforeAddTreeNode(tree_obj){
if(document.getElementById('dialogAddI')!=null&&document.getElementById('dialogAddI')!='undefined'){/*将辅助核算五项拼起来放入assistance内好写入数据库*/
	var i='';
	if(document.getElementById('part').checked){i=i+'1';}else{i=i+'0';}
	if(document.getElementById('personal').checked){i=i+'1';}else{i=i+'0';}
	if(document.getElementById('customer').checked){i=i+'1';}else{i=i+'0';}
	if(document.getElementById('purchaser').checked){i=i+'1';}else{i=i+'0';}
	if(document.getElementById('programme').checked){i=i+'1';}else{i=i+'0';}
	document.getElementById('assistance').value=i;
}
}
function afterAddTreeNode(tree_obj){	
}
function beforeDeleteNode(tree_obj){
	
}
function afterDeleteNode(tree_obj){
	
}
function beforeChangeNode(tree_obj){
	
}
function afterChangeNode(tree_obj){

}
function beforeQuickSearchNode(tree_obj){
	
}
function afterQuickSearchNode(tree_obj){
	
}
function afterDoubleClick(tree_obj){
	
}
function afterSelectNodeInto(tree_obj){
var chain_str=selectIntoCccc0(tree_obj);
document.getElementById(file_id).value=chain_str;
document.getElementById('file_tree').style.display='none';
writerfile(event);
}
function aftershowAddBrotherDiv(tree_obj){
	
if(document.getElementById('dialogAddI')!=null&&document.getElementById('dialogAddI')!='undefined'){/*从后台查询资产负债表所属项目，损益表所属项目，现金流量表补充资料所属项目然后放入页面的selec框中*/	
		var xmlhttp3;
		if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
		xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
		if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200){
		var select=xmlhttp3.responseText.substring(0,xmlhttp3.responseText.length-2).split('☆');
		var	itema=select[0].split('◎');
		var	itemb=select[1].split('◎');
		var	itemd=select[2].split('◎');
		var option='';
		var itema_name=document.getElementById('itema_name');
		var itemb_name=document.getElementById('itemb_name');
		var itemd_name=document.getElementById('itemd_name');
		for(var i=0;i<itema.length-1;i++){
			option=document.createElement('option');
    		option.text=itema[i].split('⊙')[1];
     		option.value=itema[i].split('⊙')[0];
     		itema_name.add(option);
		}
		for(var i=0;i<itemb.length-1;i++){
			option=document.createElement('option');
    		option.text=itemb[i].split('⊙')[1];
     		option.value=itemb[i].split('⊙')[0];
     		itemb_name.add(option);
		}
		for(var i=0;i<itemd.length-1;i++){
			option=document.createElement('option');
    		option.text=itemd[i].split('⊙')[1];
     		option.value=itemd[i].split('⊙')[0];
     		itemd_name.add(option);
		}
		}else {
		alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
		xmlhttp3.open("POST", "registerNew_tree_search.jsp", true);
		xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		xmlhttp3.send('tag=select');
		}
}else if(document.getElementById('dialogAddII')!=null&&document.getElementById('dialogAddII')!='undefined'){
	var node=tree_obj.getSelectNode();
	var kind_tag=node.attributeArray[1][1];
	document.getElementById('kind_tag').value=kind_tag;
	var muti_field_type=node.attributeArray[1][2];
	document.getElementById('muti_field_type').value=muti_field_type;
	var debit_or_loan=node.attributeArray[1][3];
	document.getElementById('debit_or_loan').value=debit_or_loan;
	var itema_name=node.attributeArray[1][4];
	document.getElementById('itema_name').value=itema_name;
	var itemb_name=node.attributeArray[1][5];
	document.getElementById('itemb_name').value=itemb_name;
	var itemd_name=node.attributeArray[1][6];
	document.getElementById('itemd_name').value=itemd_name;
	var profit_or_cost=node.attributeArray[1][7];
	document.getElementById('profit_or_cost').value=profit_or_cost;
	var corr_stock_tag=node.attributeArray[1][8];
	document.getElementById('corr_stock_tag').value=corr_stock_tag;
	var cash_tag=node.attributeArray[1][9];
	document.getElementById('cash_tag').value=cash_tag;
	var daily_tag=node.attributeArray[1][10];
	document.getElementById('daily_tag').value=daily_tag;
	var bank_tag=node.attributeArray[1][11];
	document.getElementById('bank_tag').value=bank_tag;
	var assistance=node.attributeArray[1][12];
	document.getElementById('assistance').value=assistance;
	}
}
function beforeChangeDiv(tree_obj){

}
function afterChangeDiv(tree_obj){

}
function jionIn(my_id,tree_obj){
	var str="";
	if(my_id>0){
		str=tree_obj.node_list[my_id].showStr.substring(tree_obj.node_list[my_id].showStr.split(' ')[0].length+1);
		str=jionIn(tree_obj.node_list[my_id].pid,tree_obj)+"-"+str;
	}
	return str;
}
function selectIntoCccc0(tree_obj){ 
 var nodee=tree_obj.getSelectNode();
 var file_value='';
 if(nodee!=null){
 if(nodee.child_list.length==0&&nodee.detailsTag==0){
 file_value=nodee.showStr.split(' ')[0]+" "+jionIn(nodee.id,tree_obj).substring(1); 
 }
 }
	return file_value;
}