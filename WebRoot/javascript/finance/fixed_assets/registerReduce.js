/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
var row_id=0;
var repeat_tag='⊙';

function addto(){//增加按钮调入的函数
var keyword=document.getElementById('file_id1').value;
if(repeat_tag.indexOf('⊙'+keyword+'⊙')!=-1){
alert('该资产已经在列表中');
return false;
}
if(keyword!=''){
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
if(parseInt(xmlhttp3.responseText)==179206725){
	alert('该资产不存在');
	}else{
var file_id =xmlhttp3.responseText.split('◎')[0];
var file_name =xmlhttp3.responseText.split('◎')[1];
addRow(file_id,file_name);
repeat_tag+=document.getElementById('file_id1').value+'⊙';
document.getElementById('file_id1').value='';
}
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "registerReduce_search.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('keyword='+encodeURI(keyword)+'&tag=1');
}
}else{ alert('请选择资产编号');}
}


function addRow(file_id,file_name){//动态创建行
 var mydate=new Date();
 	 mydate=mydate.toLocaleDateString().replace(/['年月日'$]/g,'-').substring(0,mydate.toLocaleDateString().length-1);

 var sTa=document.getElementById('tablefield');
 	 var id_input=sTa.rows.length; 

     tr = document.getElementById('tablefield').insertRow(sTa.rows.length);  
     tr.height='25';   
tr.insertCell(-1).innerHTML = "<input id='aaa"+id_input+"' type='text' value='"+file_id+"' style=\"width: 100%; height: 100%; text-align:center; border-style:none; border-bottom:  1px solid #000000; border-right: 1px solid #000000;\" onFocus=\"fo(this.id)\" readonly/>";

tr.insertCell(-1).innerHTML = "<input id='bbb"+id_input+"' type='text' value='"+file_name+"' style=\"width: 100%; height: 100%;  text-align:center; border-bottom:  1px solid #000000;BORDER-left: 0px; border-right: 1px solid #000000; border-top: 0px;\" onFocus=\"fo(this.id)\" readonly/>";

tr.insertCell(-1).innerHTML = "<input id='ccc"+id_input+"' type='text' value='"+mydate+"' style=\"width: 100%; height: 100%; border-bottom: 1px solid #000000;  text-align:left; BORDER-left: 0px; border-right: 1px solid #000000; border-top: 0px;\" onFocus=\"fo(this.id)\">";

tr.insertCell(-1).innerHTML ="<input type='text' id='ddd"+id_input+"' style=\"width: 100%; height: 100%; border-bottom:  1px solid #000000;text-align:left;border-right:  1px solid #000000; BORDER-left: 0px; border-top:  0px ;\" onFocus=\"showKind1(this)\" onkeyup=\"search_suggest(this.id)\" autocomplete=\"off\" />";

tr.insertCell(-1).innerHTML = "<input id='eee"+id_input+"' type='text' style=\"width: 100%; height: 100%; border-bottom:  1px solid #000000;BORDER-left: 0px; border-right: 1px solid #000000; border-top: 0px;\" onFocus=\"fo(this.id)\" onkeyup=\"decimalControl(this.id)\">";

tr.insertCell(-1).innerHTML = "<input id='fff "+id_input+"' type='text' style=\"width: 100%; height: 100%; border-style: none; border-right: 1px solid #000000; border-bottom:  1px solid #000000;\" onFocus=\"fo(this.id)\" onkeyup=\"decimalControl(this.id)\">";

tr.insertCell(-1).innerHTML = "<input id='ggg"+id_input+"' type='text' style=\"width: 100%; height: 100%; border-bottom:  1px solid #000000;BORDER-left: 0px; border-right: 1px solid #000000; border-top: 0px;\" onFocus=\"fo(this.id)\"><input id='ddd"+id_input+"_table' type='hidden' value=\"finance_config_assets_fluctuationway\" />";

/*for(var j=0;j<sTa.rows.length;j++)
    {	
	   sTa.getElementsByTagName('tr')[j].id=j;
	   for(var m=0;m<sTa.getElementsByTagName('tr')[j].getElementsByTagName('input').length;m++){
			if(m==0){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='aaa'+j;
			}else if(m==1){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='bbb'+j;
			}else if(m==2){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='ccc'+j;
			}else if(m==3){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='ddd'+j;
			}else if(m==4){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='eee'+j;
			}else if(m==5){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='fff'+j;
			}else{
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='ggg'+j;
			}
	   }
    }*/
}

function deleteRow(){//删除
if(row_id!=0){
var sTa=document.getElementById('tablefield');
sTa.deleteRow(row_id);
for(var j=0;j<sTa.rows.length;j++)
    {	
	   sTa.getElementsByTagName('tr')[j].id=j;
	   for(var m=0;m<sTa.getElementsByTagName('tr')[j].getElementsByTagName('input').length;m++){
			if(m==0){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='aaa'+j;
			}else if(m==1){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='bbb'+j;
			}else if(m==2){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='ccc'+j;
			}else if(m==3){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='ddd'+j;
			}else if(m==4){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='eee'+j;
			}else if(m==5){
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='fff'+j;
			}else{
			sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id='ggg'+j;
			}
    	}
	}
 }else{
	 alert('请选择要删除的行！');
	 }
 row_id=0;
}

function fo(input_id){
	if(input_id.indexOf('ccc')!=-1){
		row_id=parseInt(input_id.substring(3));
		time();
	}
row_id=parseInt(input_id.substring(3));
}

function search_suggest1(id){//根据输入内容快速查询资产编号写入下拉层
var keyword=document.getElementById(id).value;
if(keyword!=''){
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
loadDiv(document.getElementById(id));
var cla=document.getElementById('search_suggest');
cla.innerHTML='';
if(parseInt(xmlhttp3.responseText)==179206725){
	document.getElementById('search_suggest').style.display='none';
	}else{
var options =xmlhttp3.responseText.split('\n');
var conter='';
for (var i = 0; i < options.length-1; i++) {
var suggest = '<div onmouseover="style.backgroundColor=\'#E8F2FE\'" onmouseout="style.backgroundColor=\'\'"';
suggest += 'onclick=\"javascript:setSearch(this.innerHTML,\''+id+'\');\" ';
suggest += '>' + options[i] + '</div>';
conter += suggest;
}
cla.innerHTML = null;
cla.innerHTML = '';
cla.innerHTML = conter;
cla.style.display = 'block';
//Dynamic(id);
	}
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "registerReduce_search.jsp", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('keyword='+encodeURI(keyword)+'&tag=0');
}
}
}

function setSearch(obj,obj1){
	document.getElementById(obj1).value=obj;
	document.getElementById('search_suggest').style.display='none';
}

function decimalControl(input_id){//金额类录入框输入控制  
  var input=document.getElementById(input_id);
     input.value = input.value.replace(/[^-0123456789.$]/g,'');
   if(input.value.indexOf("0")==0)  input.value=input.value.substring(1);
   if(input.value.indexOf("-")!=0) input.value=input.value.substring(0,input.value.indexOf("-"))+input.value.substring(input.value.indexOf("-")+1);
   if(input.value.indexOf("-")==0) {input.value="-"+input.value.replace(/-/g,'');}else{input.value=input.value.replace(/-/g,'');}
if(input.value.lastIndexOf("-")!=0&&input.value.lastIndexOf("-")!=-1) input.value=input.value.substring(0,input.value.lastIndexOf("-"));
if(input.value.indexOf(".")!=-1) input.value=input.value.substring(0,input.value.indexOf(".")+1)+input.value.substring(input.value.indexOf(".")+1).replace(/\./g,'');
if(input.value.indexOf(".")==0) input.value=input.value.substring(1);
}  

function loadDiv(obj1){//动态生成下拉层
    var w = obj1.offsetWidth;
    var h = obj1.offsetHeight-2;  

    var   x   =   obj1.offsetLeft,   y   =   obj1.offsetTop;   
    while(obj1=obj1.offsetParent) 
    { 
       x   +=   obj1.offsetLeft;   
       y   +=   obj1.offsetTop;
    } 
var obj=document.getElementById('search_suggest');
obj.style.width=w;
obj.style.height='100px';
obj.style.background='yellow';
obj.style.position='absolute';
obj.style.top=y+h;
obj.style.left=x;
}
var reduce_id;
function showKind1(obj){//减少方式的聚焦事件
reduce_id=obj.id;
	//if(document.getElementById(obj.id+'_div')){
loadMirror1(obj,'ddd_div');
document.getElementById('ddd_div').style.display='block';
	//}
}

function loadMirror1(obj1,div_id){//动态定位放大镜
    var w = obj1.offsetWidth;
    var h = obj1.offsetHeight;  

    var   x   =   obj1.offsetLeft,   y   =   obj1.offsetTop;   
    while(obj1=obj1.offsetParent) 
    { 
       x   +=   obj1.offsetLeft;   
       y   +=   obj1.offsetTop;
    } 
var obj=document.getElementById(div_id);
obj.style.top=y;
obj.style.left=x+w-19;
}

function send() {//将有关行数据保存至数据库
	var fa_reduce='';
	var sta=document.getElementById('tablefield');
	for(var i=1;i<sta.rows.length;i++){	 		
		fa_reduce+=sta.getElementsByTagName('tr')[i].getElementsByTagName('input')[0].value+'⊙'+sta.getElementsByTagName('tr')[i].getElementsByTagName('input')[2].value+'⊙'+sta.getElementsByTagName('tr')[i].getElementsByTagName('input')[3].value+'⊙'+sta.getElementsByTagName('tr')[i].getElementsByTagName('input')[4].value+'⊙'+sta.getElementsByTagName('tr')[i].getElementsByTagName('input')[5].value+'⊙'+sta.getElementsByTagName('tr')[i].getElementsByTagName('input')[6].value+'◎';
	}
	
	fa_reduce=fa_reduce.substring(0,fa_reduce.length-1);
	var xmlhttp3;
        if (window.XMLHttpRequest) {
            xmlhttp3 = new XMLHttpRequest();
        } else {
            if (window.ActiveXObject) {
                xmlhttp3 = new ActiveXObject("Microsoft.XMLHTTP");
            }
        }
        if (xmlhttp3) {
            xmlhttp3.onreadystatechange = function(){
               if(xmlhttp3.readyState == 4){try {
               if (xmlhttp3.status == 200) {
				   if(parseInt(xmlhttp3.responseText)!=2){
						alert('提交成功');
						window.location.reload();
				   }else{
						alert('请填写资产减少明细');
				   }
               
				}else{alert(xmlhttp3.status + "=" + xmlhttp3.statusText);}}catch(exception){alert(exception);}}};
            xmlhttp3.open("POST", "../../finance_fixed_assets_registerReduce_ok", true);
            xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xmlhttp3.send("fa_reduce="+encodeURI(fa_reduce));
        }
}