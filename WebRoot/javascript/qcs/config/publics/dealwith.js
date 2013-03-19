var selected_tag=0;
var selected_det_tag=0;
function selAll(){
	if(selected_tag==0){
    var input = document.getElementsByTagName('input');
	for(var i=0;i<input.length;i++){
		if(input[i].type=='checkbox'){
			input[i].checked=true;
		}
	}
document.getElementById('select_all').value='取消';
	}else if(selected_tag==1){
	var input = document.getElementsByTagName('input');
	for(var i=0;i<input.length;i++){
		if(input[i].type=='checkbox'){
			input[i].checked=false;
		}
	}
document.getElementById('select_all').value='全选';
	}
selected_tag=selected_tag==0?1:0;
}

function selAllDet(id){
	if(selected_det_tag==0){
    var input = document.getElementsByName('T'+id.substring(1));
	for(var i=0;i<input.length;i++){
		if(input[i].type=='checkbox'){
			input[i].checked=true;
		}
	}
document.getElementById(id).value='取消';
	}else if(selected_det_tag==1){
	 var input = document.getElementsByName('T'+id.substring(1));
	for(var i=0;i<input.length;i++){
		if(input[i].type=='checkbox'){
			input[i].checked=false;
		}
	}
document.getElementById(id).value='全选';
	}
selected_det_tag=selected_det_tag==0?1:0;
}

function registerOk(){
 var ids='';
 var nseers=new Array();
 var input = document.getElementsByTagName('input');
 var n=0;
	for(var i=0;i<input.length;i++){
		if(input[i].type=='checkbox'&&input[i].checked==true){
			ids+='◎'+input[i].value;
			nseers[n]=input[i].getAttribute('nseer');
			n++;
			}
	}
	var nseer_temp=nseers.join(',');
	n=0;
	for(var i=0;i<7;i++){
	if(nseer_temp.indexOf(i)!=-1){
	n++;
	}
	}
	if(n<7){
		alert('每种质检下最少选择一种处理方式！');
		return;
	}
	if(ids==''){ids='◎-1'}
	ids=ids.substring(1);
	
        var xmlhttp;
		if(window.XMLHttpRequest){xmlhttp=new XMLHttpRequest();}else if (window.ActiveXObject){xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp) {xmlhttp.onreadystatechange = function() {
			if(xmlhttp.readyState==4){try {if(xmlhttp.status==200){	
			if(parseInt(xmlhttp.responseText)==0){
				window.location="../../../qcs/config/publics/dealwith_ok.jsp?finished_tag=0"
			}else if(parseInt(xmlhttp.responseText)==1){
             window.location="../../../qcs/config/publics/dealwith_ok.jsp?finished_tag=1"
			}
			}else {alert( xmlhttp.status + '=' + xmlhttp.statusText);}} catch(exception) {alert(exception);}}};
			xmlhttp.open("POST", "../../../qcs_config_publics_dealwith_ok", true);
			xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			xmlhttp.send('ids='+encodeURI(ids));
		}

 }
