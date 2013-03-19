function addRow(table_id,this_obj){
	var obj=this_obj;
	var d=document.getElementById&&!document.all;
	while(obj.tagName.toLowerCase()!='tr'){
	obj=d?obj.parentNode:obj.parentElement;
	}
	var table_obj=document.getElementById(table_id);
	var row_num=1;
	for(var i=0;i<table_obj.rows.length;i++){
		if(table_obj.rows[i]==obj){row_num=i+1;break;}
	}
	var tr_obj=obj;
	var tr = table_obj.insertRow(row_num);
	for(var i=0;i<tr_obj.cells.length;i++){
	var td=tr.insertCell(-1);
	td.innerHTML=tr_obj.cells[i].innerHTML;
	}
	for(var i=0;i<tr.getElementsByTagName('input').length;i++){
		tr.getElementsByTagName('input')[i].value='';
	}
	for(var i=0;i<tr.getElementsByTagName('textarea').length;i++){
		tr.getElementsByTagName('textarea')[i].value='';
	}
	for(var i=0;i<tr.getElementsByTagName('select').length;i++){
		tr.getElementsByTagName('select')[i].getElementsByTagName('option')[0].selected=true;
	}
}
function delRow(table_id,this_obj){
	var obj=this_obj;
	var d=document.getElementById&&!document.all;
	while(obj.tagName.toLowerCase()!='tr'){
	obj=d?obj.parentNode:obj.parentElement;
	}
	var table_obj=document.getElementById(table_id);
	var row_num=1;
	for(var i=0;i<table_obj.rows.length;i++){
		if(table_obj.rows[i]==obj){row_num=i;break;}
	}
	var tr=obj;
	if(row_num>1){
		table_obj.deleteRow(row_num);
	}else{
		for(var i=0;i<tr.getElementsByTagName('input').length;i++){
			tr.getElementsByTagName('input')[i].value='';
		}
		for(var i=0;i<tr.getElementsByTagName('textarea').length;i++){
			tr.getElementsByTagName('textarea')[i].value='';
		}
		for(var i=0;i<tr.getElementsByTagName('select').length;i++){
			tr.getElementsByTagName('select')[i].getElementsByTagName('option')[0].selected=true;
		}
	}
}