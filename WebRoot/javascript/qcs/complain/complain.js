function loadAjaxDiv(input_id,event){//弹出ajax动态查询数据库层
if(document.getElementById('result_div')!=null){document.body.removeChild(document.getElementById('result_div'));}
    var input_obj=document.getElementById(input_id);
	var input_value=input_obj;
    var w = input_obj.offsetWidth;
    var h = input_obj.offsetHeight;
    var   x   =   input_obj.offsetLeft,   y   =   input_obj.offsetTop;   
    while(input_obj=input_obj.offsetParent){ 
       x+=input_obj.offsetLeft;   
       y+=input_obj.offsetTop;
    }
	var result_div=document.createElement('div');
	result_div.id='result_div';
	result_div.className='result_div1';
	result_div.style.top=y+18;
	result_div.style.left=x;
	result_div.style.width=w;
	document.body.appendChild(result_div);
	search_suggest(input_value.value,input_id,result_div);
	if(document.attachEvent) document.attachEvent('onmousedown',closeResult,event);
	if(document.addEventListener) document.addEventListener('mousedown',closeResult,event);	
	
}
function search_suggest(keyword,input_id,div_obj){//根据输入内容快速查询下拉层
	var search_tag=0;
	if(input_id == 'complain_way'){
		search_tag=1;
	}else if(input_id == 'complain_type'){
        search_tag=2;
	}
		var xmlhttp;
		if(window.XMLHttpRequest){xmlhttp=new XMLHttpRequest();}else if (window.ActiveXObject){xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp) {xmlhttp.onreadystatechange = function() {
			if(xmlhttp.readyState==4){try {if(xmlhttp.status==200){
				//alert(xmlhttp.responseText);
				div_obj.innerHTML='';
				if(parseInt(xmlhttp.responseText)==179206725){
				document.getElementById(input_id).value='';
				div_obj.style.display='none';
				}else{
				var div_options =xmlhttp.responseText.split("\n");
				var conter='';
				for (var i = 0; i < div_options.length; i++){
                var array = div_options[i].split("/");
				var suggest = '<div  onmouseover="style.backgroundColor=\'#E8F2FE\'" onmouseout="style.backgroundColor=\'\'"';
				suggest += 'onclick=\"javascript:setSearch(this.innerHTML,\''+input_id+'\',\''+div_obj.id+'\',\''+array[1]+'\');\" ';
				suggest += '>' + div_options[i] + '</div>';
				conter += suggest;
				}
				div_obj.innerHTML = null;
				div_obj.innerHTML = '';
				div_obj.innerHTML = conter;
				}
			}else {alert( xmlhttp.status + '=' + xmlhttp.statusText);}} catch(exception) {alert(exception);}}};
			xmlhttp.open("POST", "register_search.jsp", true);
			xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			xmlhttp.send('search_tag='+encodeURI(search_tag)+'&&keyword='+encodeURI(keyword));
		}
}
function setSearch(input_value,input_id,div_id,input_value2){
	if (input_id == 'product_id') {
		var input_value1 = input_value.substring(0, input_value.indexOf("/"));
		document.getElementById(input_id).value = input_value1;
		document.getElementById('product_name').value = input_value2;
	}else if(input_id == 'complain_way'){
    document.getElementById(input_id).value = input_value;
	}
	else if(input_id == 'complain_type'){
		document.getElementById(input_id).value = input_value;
	}else{
	
}
document.body.removeChild(document.getElementById(div_id));
}
function registerOk(){
var form = document.getElementById('mutiValidation');
form.action='../../qcs_complain_register_ok';
if (doValidate('../../xml/qcs/complain/validation-config.xml', 'mutiValidation')){
if (doValidate('../../xml/qcs/qcs_complain.xml','mutiValidation')){
	form.submit();
	}
}
}
function checkOk(temp){
var form = document.getElementById('mutiValidation');
form.action='../../qcs_complain_check_ok?complain_id='+temp;
if (doValidate('../../xml/qcs/qcs_complain.xml','mutiValidation')){
form.submit();
}
}
function changeOk(temp){
	var form = document.getElementById('mutiValidation');
	form.action='../../qcs_complain_change_ok?complain_id='+temp;
	if (doValidate('../../xml/qcs/qcs_complain.xml','mutiValidation')){
	form.submit();
	}
}
