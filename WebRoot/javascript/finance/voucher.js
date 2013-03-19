/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
var row_id;
var row_id33='';
var data_tag;
var show;
var summary_id;
var file_id;
var data_div;
var row_id2=0;

var cash_item=new Array;
var cash_itema=new Array;
var qty=new Array;
var netPrice=new Array;
var tax_rate=new Array;
var sum=new Array;
var currency=new Array;
var cPrice=new Array;
var currency_rate=new Array;
var cSum=new Array;
var department=new Array;
var project=new Array;
var attachment_id=new Array;
var settle_way=new Array;
var settle_time=new Array;
var customer=new Array;
var product=new Array;
var order=new Array;
var remark=new Array;
var bank_tag=new Array;
var cash_tag=new Array;
var corr_stock_tag=new Array;
var debit_tag=new Array;
var cash_sum_temp=new Array;
var cash_direct_temp=new Array;
var sum_direct_temp=new Array;
var cash_sum=new Array;
var currency_tag=new Array;
function match(input_id){ //合计的计算
 var input=document.getElementById(input_id);
 input.value = input.value.replace(/[^-0123456789$]/g,'');
   if(input.value.indexOf("=")==0)  input.value=input.value.substring(1);
   if(input.value.indexOf("=")==(input.value.length-1))  input.value=input.value.substring(0,(input.value.length-1));
   if(input.value.indexOf("0")==0) input.value=input.value.substring(1);
   if(input.value.indexOf("-")==0) {input.value="-"+input.value.replace(/-/g,'');}else{input.value=input.value.replace(/-/g,'');}
 var sTa=document.getElementById('tablefield');
 var val=document.getElementById('aOuter');
 var va2=document.getElementById('bOuter');
 if(input_id.indexOf("aaa")==0){
    var Sub = 0;
    var Sub1 = 0;
    for(var j=0;j<sTa.rows.length;j++){ 
       if(document.getElementById('aaa'+j).value!="" && document.getElementById('aaa'+j).value!="-") Sub = parseInt(document.getElementById('aaa'+j).value)+Sub;	
    }
    val.value=Sub; 
    for(var j=0;j<sTa.rows.length;j++){ 
	   if(document.getElementById('bbb'+j).value!="" && document.getElementById('bbb'+j).value!="-") Sub1 = parseInt(document.getElementById('bbb'+j).value)+Sub1;	
    }	
    va2.value=Sub1; 
 }else if(input_id.indexOf("bbb")==0){
    Clear1 (input_id);
    var Sub = 0;
    var Sub1 = 0;
    for(var j=0;j<sTa.rows.length;j++){ 
       if(document.getElementById('bbb'+j).value!="" && document.getElementById('bbb'+j).value!="-") Sub = parseInt(document.getElementById('bbb'+j).value)+Sub;	
    }
  va2.value=Sub; 
  for(var j=0;j<sTa.rows.length;j++){ 
    if(document.getElementById('aaa'+j).value!="" && document.getElementById('aaa'+j).value!="-") Sub1 = parseInt(document.getElementById('aaa'+j).value)+Sub1;	
  }
  val.value=Sub1; 
  }
 }

 function Excessively(id_input,evt){//每行最后一个录入框内判断键值，如果是回车就创建一行，跳下个录入框，如果是录入数字就计算合计。
  if(keyControl(evt,id_input)){
 if(evt.keyCode==13){//13为回车的键值
	 addRow_enter(id_input,evt); 
	 return false;
 }
 if(evt.keyCode==187) Balance(id_input,evt);
  }
 }

 function Excessively_firefox(id_input,evt){//每行最后一个录入框内判断键值，如果是回车就创建一行，跳下个录入框，如果是录入数字就计算合计。
  if(keyControl(evt,id_input)){
 if(evt.keyCode==13){
	 addRow_firefox(id_input,evt); 
 }
 if(evt.keyCode==61) Balance(id_input,evt);
  }
 }

 function Balance(id_input,evt){ //'='号事件处理
 if(id_input.indexOf("bbb")==0){
 if(document.getElementById(id_input).value=="" && document.getElementById('aaa'+id_input.substring(3)).value==""){ document.getElementById(id_input).value=parseInt(document.getElementById('aOuter').value)-parseInt(document.getElementById('bOuter').value)
     }
   }else if(id_input.indexOf("aaa")==0){
     if(document.getElementById(id_input).value=="" && document.getElementById('bbb'+id_input.substring(3)).value==""){  document.getElementById(id_input).value=parseInt(document.getElementById('bOuter').value)-parseInt(document.getElementById('aOuter').value)
     }
   }
 }

function Clear1 (input_id) //在bbb中录入数字，清空aaa录入框的值。
{
if(document.getElementById(input_id).value!=""){
var inputId='aaa'+input_id.substring(3);
document.getElementById(inputId).value="";
}
}

function Clear(id_input,evt){//在aaa中录入数字，清空bbb录入框的值。
if(evt.keyCode==13) evt.keyCode=9; 
else if(id_input.indexOf("aaa")==0){
document.getElementById("bbb"+id_input.substring(3)).value="";
if(evt.keyCode==187) Balance(id_input,evt);
}

}

function div_match(input_id){ 
 var input=document.getElementById(input_id);
     input.value = input.value.replace(/[^\-0123456789.]/g,'');
   if(input.value.indexOf("0")==0)  input.value=input.value.substring(1);
   if(input.value.indexOf("+")!=-1) input.value=input.value.substring(0,input.value.indexOf("+"))+input.value.substring(input.value.indexOf("+")+1);
   if(input.value.indexOf("-")!=0) input.value=input.value.substring(0,input.value.indexOf("-"))+input.value.substring(input.value.indexOf("-")+1);
   if(input.value.indexOf("--")==0) input.value=input.value.substring(1);

var quantity=document.getElementById("quantity").value;
var net_price=document.getElementById("net_price").value;
var tax_rate=document.getElementById("tax_rate").value;
var list_price=document.getElementById("list_price").value;
var subtotal=document.getElementById("subtotal").value;

if(input_id=="quantity"){
if(quantity=="") quantity=0;
if(net_price=="") net_price=0;
if(tax_rate=="") {tax_rate=1;} else{tax_rate=parseFloat(tax_rate)/100+1;}
document.getElementById("subtotal").value=FormatNumberPoint(parseFloat(quantity)*parseFloat(net_price),2);
document.getElementById("list_price").value=FormatNumberPoint(parseFloat(net_price)*parseFloat(tax_rate),2);
}
if(input_id=="net_price"){
if(quantity=="") quantity=0;
if(net_price=="") net_price=0;
if(subtotal=="" || subtotal==".") subtotal=0;
if(tax_rate=="") {tax_rate=1;} else{tax_rate=parseFloat(tax_rate)/100+1;}
document.getElementById("subtotal").value=FormatNumberPoint(parseFloat(quantity)*parseFloat(net_price),2);
document.getElementById("list_price").value=FormatNumberPoint(parseFloat(net_price)*parseFloat(tax_rate),2);
}
if(input_id=="tax_rate"){
if(quantity=="") quantity=0;
if(net_price=="") net_price=0;
if(tax_rate=="") {tax_rate=1;} else{tax_rate=parseFloat(tax_rate)/100+1;}
if(list_price=="") list_price=0;
document.getElementById("net_price").value=FormatNumberPoint(parseFloat(list_price)/parseFloat(tax_rate),2);
document.getElementById("subtotal").value=FormatNumberPoint(parseFloat(quantity)*parseFloat(document.getElementById("net_price").value),2);
}
if(input_id=="list_price"){
if(quantity=="") quantity=0;
if(net_price=="") net_price=0;
if(tax_rate=="") {tax_rate=1;} else{tax_rate=parseFloat(tax_rate)/100+1;}
if(list_price=="") list_price=0;
document.getElementById("net_price").value=FormatNumberPoint(parseFloat(list_price)/parseFloat(tax_rate),2);
document.getElementById("subtotal").value=FormatNumberPoint(parseFloat(quantity)*parseFloat(document.getElementById("net_price").value),2);
}
if(input_id=="subtotal"){
if(quantity=="") quantity=0;
if(tax_rate=="") {tax_rate=1;} else{tax_rate=parseFloat(tax_rate)/100+1;}
if(subtotal=="" || subtotal==".") subtotal=0;
if(quantity!="") {document.getElementById("net_price").value=FormatNumberPoint(parseFloat(subtotal)/parseFloat(quantity),2);
document.getElementById("list_price").value=FormatNumberPoint(parseFloat(tax_rate)*parseFloat(document.getElementById("net_price").value),2);}
}
}

function FormatNumberPoint(srcStr,nAfterDot){//格式化显示数字，小数点后保存nAfterDot位小数
var   srcStr;
var nAfterDot;   
var   resultStr,nTen;   
srcStr   =   ""+srcStr+"";   
strLen   =   srcStr.length;   
dotPos   =   srcStr.indexOf(".",0); 
if(dotPos   ==   -1){
resultStr   =   srcStr+".";   
for(i=0;i<nAfterDot;i++){
resultStr = resultStr+"0";   
}   
return  resultStr;   
}   
else{   
if((strLen-dotPos-1)>=nAfterDot){
nTen=1;   
for(j=0;j<nAfterDot;j++){   
nTen=nTen*10;   
}   
resultStr =Math.round(parseFloat(srcStr)*nTen)/nTen;
resultStr   =   ""+resultStr+""; 
strLen   =   resultStr.length;   
dotPos   =   resultStr.indexOf(".",0);
for (i=0;i<(nAfterDot-strLen+dotPos+1);i++){   
resultStr=resultStr+"0";   
}
return   resultStr;   
}   
else{
resultStr=srcStr;   
for (i=0;i<(nAfterDot-strLen+dotPos+1);i++){   
resultStr=resultStr+"0";   
}   
return   resultStr;   
}   
}   
}

function decimalControl(input_id){  //金额类录入框输入控制  
  var input=document.getElementById(input_id);
     input.value = input.value.replace(/[^-0123456789.$]/g,'');
   if(input.value.indexOf("0")==0)  input.value=input.value.substring(1);
   if(input.value.indexOf("-")!=0) input.value=input.value.substring(0,input.value.indexOf("-"))+input.value.substring(input.value.indexOf("-")+1);
   if(input.value.indexOf("-")==0) {input.value="-"+input.value.replace(/-/g,'');}else{input.value=input.value.replace(/-/g,'');}
if(input.value.lastIndexOf("-")!=0&&input.value.lastIndexOf("-")!=-1) input.value=input.value.substring(0,input.value.lastIndexOf("-"));
if(input.value.indexOf(".")!=-1) input.value=input.value.substring(0,input.value.indexOf(".")+1)+input.value.substring(input.value.indexOf(".")+1).replace(/\./g,'');
if(input.value.indexOf(".")==0) input.value=input.value.substring(1);

 }  

function inputCancel(input_id){//录入框禁止输入控制
document.getElementById(input_id).value='';
}

function idControl(input_id){ //录入框只允许输入数字
 var input=document.getElementById(input_id);
 input.value = input.value.replace(/[^'0123456789']/g,'');
}

function Dynamic(obj){
	var el = document.getElementById(obj);
	var parent = null;
	var pos = []; 
	var box;
	if(el.getBoundingClientRect){
		box = el.getBoundingClientRect();
		var scrollTop = Math.max(document.documentElement.scrollTop, document.body.scrollTop);
		var scrollLeft = Math.max(document.documentElement.scrollLeft, document.body.scrollLeft);
		var left=box.left + scrollLeft;
		var top=box.top + scrollTop;
	}
	if(obj.indexOf("ccc")==0 && obj.indexOf("ccccc")==-1){
	document.getElementById('search_suggest').style.width='150';
    document.getElementById('search_suggest').style.top=top+30;
    document.getElementById('search_suggest').style.left=left;
    document.getElementById('search_suggest').style.display='block';
	}else if(obj.indexOf("ddd")==0 && obj.indexOf("ddddd")==-1){
	document.getElementById('search_suggest').style.width='291';
    document.getElementById('search_suggest').style.top=top+30;
    document.getElementById('search_suggest').style.left=left;
    document.getElementById('search_suggest').style.display='block';	
	}
}

function keyControl(evt,this_id){
	if(navigator.userAgent.indexOf("IE")>0){
		//允许使用"0~9"、小健盘"0~9"、"-"、"="、回车、BackSpace、Delete、、左、右、小健盘"-"、小健盘回车
		if(evt.keyCode==48||
		evt.keyCode==49||
		evt.keyCode==50||
		evt.keyCode==51||
		evt.keyCode==52||
		evt.keyCode==53||
		evt.keyCode==54||
		evt.keyCode==55||
		evt.keyCode==56||
		evt.keyCode==57||
		evt.keyCode==96||
		evt.keyCode==97||
		evt.keyCode==98||
		evt.keyCode==99||
		evt.keyCode==100||
		evt.keyCode==101||
		evt.keyCode==102||
		evt.keyCode==103||
		evt.keyCode==104||
		evt.keyCode==105||
		evt.keyCode==189||
		evt.keyCode==109||
		evt.keyCode==187||
		evt.keyCode==37||
		evt.keyCode==39||
		evt.keyCode==8||
		evt.keyCode==46||
		evt.keyCode==13){
		return true;
		}else{
			document.getElementById(this_id).blur();
			return false;
		}
	}
	if(navigator.userAgent.indexOf("Firefox")>0){
		if(evt.which==48||
		evt.which==49||
		evt.which==50||
		evt.which==51||
		evt.which==52||
		evt.which==53||
		evt.which==54||
		evt.which==55||
		evt.which==56||
		evt.which==57||
		evt.which==96||
		evt.which==97||
		evt.which==98||
		evt.which==99||
		evt.which==100||
		evt.which==101||
		evt.which==102||
		evt.which==103||
		evt.which==104||
		evt.which==105||
		evt.which==109||
		evt.keyCode==37||
		evt.keyCode==39||
		evt.which==61||
		evt.which==8||
		evt.which==46||
		evt.which==13){
		return true;
		}else{
			document.getElementById(this_id).blur();
			return false;
		}
	}
}

function movWink(inpid){
	var el = document.getElementById(inpid);
	var box;
	var left;
	var top;
	if(el.getBoundingClientRect){
		box = el.getBoundingClientRect();
		var scrollTop = Math.max(document.documentElement.scrollTop, document.body.scrollTop);
		var scrollLeft = Math.max(document.documentElement.scrollLeft, document.body.scrollLeft);
		left=parseInt(box.left + scrollLeft)+101;
		top=parseInt(box.top + scrollTop)+5;
	}
	document.getElementById('line_').style.left=left+"px";
	document.getElementById('line_').style.top=top+"px";
}

function Wink(show){
	var line = document.getElementById('inp2');
	if(show){
		line.innerText += "|";
	}else{
		line.innerText = line.innerText.replace(/_$/, "");
	}  
    setTimeout("Wink(" + !show + ")", 500);
}

function send(start_time,end_time,tag){//前台验证
	
	if(document.getElementById('voucher_id').value==''){
		alert('凭证号不能为空');
		return false;
	}	
	
	var date_start=document.getElementById('date_start').value;
	if(new Date(date_start.replace(/-/g,'/')).getTime()<new Date(start_time.replace(/-/g,'/')).getTime()||new Date(date_start.replace(/-/g,'/')).getTime()>new Date(end_time.replace(/-/g,'/')).getTime()){
		alert('制单时间必须在当前会计期间内');
		return false;
	}

	var summary=document.getElementsByName('summary');
	var file_name=document.getElementsByName('file_name1');
	var debit=document.getElementsByName('debit');
	var loan=document.getElementsByName('loan');
	var register_time=document.getElementById('date_start').value;
	if((debit[0].value==''||loan[0].value==''||file_name[0].value=='')&&summary[0].value==''){
			alert('请正确填写分录');
			return false;
		}
	for(var i=0;i<summary.length;i++){

		if((debit[i].value!=''||loan[i].value!=''||file_name[i].value!='')&&summary[i].value==''){
			alert('摘要不能为空');
			return false;
		}
		if((debit[i].value!=''||loan[i].value!=''||summary[i].value!='')&&file_name[i].value==''){
			alert('财务科目不能为空');
			return false;
		}
		if(summary[i].value!=''&&file_name[i].value!=''&&(debit[i].value==''&&loan[i].value==''||parseFloat(debit[i].value)==0&&parseFloat(loan[i].value)==0)){
			alert('借贷方金额不能同时为空');
			return false;
		}
		if(cash_direct_temp[i]=='0'&&(cash_sum[i]!=debit[i].value||debit[i].value=='')){
			alert('现金流量明细有误');
			return false;
		}
		if(cash_direct_temp[i]=='1'&&(cash_sum[i]!=loan[i].value||loan[i].value=='')){
			alert('现金流量明细有误');
			return false;
		}
		if(corr_stock_tag[i]=='是'&&(qty[i]==undefined||qty[i]=='')){
			alert('数量核算科目的数量有误');
			return false;
		}
		if(corr_stock_tag[i]=='是'&&sum_direct_temp[i]=='0'&&sum[i].toString().replace(/\./g,'')!=debit[i].value){
			alert('数量核算科目的明细有误');
			return false;
		}
		if(corr_stock_tag[i]=='是'&&sum_direct_temp[i]=='1'&&sum[i].toString().replace(/\./g,'')!=loan[i].value){
			alert('数量核算科目的明细有误');
			return false;
		}
		if(bank_tag[i]=='1'&&settle_way[i]==''){
			alert('结算方式不能为空');
			return false;
		}
		if(bank_tag[i]=='1'&&attachment_id[i]==''){
			alert('票号不能为空');
			return false;
		}
		if(bank_tag[i]=='1'&&settle_time[i]==''){
			alert('票据日期不能为空');
			return false;
		}
		if(bank_tag[i]=='1'&&new Date(settle_time[i].replace(/-/g,'/')).getTime()>new Date(register_time.replace(/-/g,'/')).getTime()){
			alert('票据日期不能大于制单日期');
			return false;		
		}
	}
	document.getElementById('aOuter').value=document.getElementById('aOuter').value==''?'0':document.getElementById('aOuter').value;
	document.getElementById('bOuter').value=document.getElementById('bOuter').value==''?'0':document.getElementById('bOuter').value;
	if(document.getElementById('aOuter').value!=document.getElementById('bOuter').value){
		alert('借贷不平衡');
		return false;
	}
	validateId(document.getElementById('voucher_id').value,start_time,end_time,tag);	
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
function loadMirror(obj1,div_id){//动态定位放大镜
    var w = obj1.offsetWidth;
    var h = obj1.offsetHeight;  

    var   x   =   obj1.offsetLeft,   y   =   obj1.offsetTop;   
    while(obj1=obj1.offsetParent) 
    { 
       x   +=   obj1.offsetLeft;   
       y   +=   obj1.offsetTop;
    } 
var obj=document.getElementById(div_id);
obj.style.top=y-6;
obj.style.left=x+w-18;
}