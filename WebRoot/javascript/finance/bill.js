/*
  *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
var row_id1='';
function addRow() {//动态添加行
    var sTa = document.getElementById('theObjTable');
    var id_input = sTa.rows.length;
    tr = document.getElementById('theObjTable').insertRow(sTa.rows.length);
    tr.height = '25';
    tr.id = id_input;
    row_id1 = id_input;
    tr.insertCell(-1).innerHTML = "<input name='settle_time' id='aaa" + id_input + "' type='text' style=\"width: 100%; height: 100%;\" onFocus=\"fo(this.id)\">";
    tr.insertCell(-1).innerHTML = "<input name='way3' id='bbb" + id_input + "' type='text' style=\"width: 100%; height: 100%;\" onFocus=\"fo(this.id)\" onkeydown=\"this.blur();\"><div style=\"cursor: hand; display: none; padding-top: 10px; left: 218px; width: 18px; position: absolute; background-image: url('../../../images/magnifier.gif'); background-repeat: no-repeat; background-attachment: scroll; right: 0px; background-position: 70% 50%;\" id='bbb_div" + id_input + "' onclick=\"showWay(this.id)\"></div>";
    tr.insertCell(-1).innerHTML = "<input name='attachment_id' id='ccc" + id_input + "' type='text' style=\"width: 100%; height: 100%;\" onFocus=\"fo(this.id)\">";
    tr.insertCell(-1).innerHTML = "<input name='debit_subtotal' id='ddd" + id_input + "' type='text' style=\"width: 100%; height: 100%;\" onFocus=\"fo(this.id)\" onkeyup=\"setNextNull(this.id);doValidate(this);\">";
	tr.insertCell(-1).innerHTML = "<input name='loan_subtotal' id='eee" + id_input + "' type='text' style=\"width: 100%; height: 100%;\" onFocus=\"fo(this.id)\" onkeyup=\"setNextNull(this.id);doValidate(this);\">";
	tr.insertCell(-1).innerHTML = "<input name='cheque_id' id='fff" + id_input + "' type='text' style=\"width: 100%; height: 100%;\" disabled><input id='ggg" + id_input + "' type='hidden'>";
}
var row_id2='';
function deleteRow() {//删除选定的行，并对所有行和相关层重新排序
     var sTa = document.getElementById('theObjTable');
	 if (row_id2 != '') {
	    if(row_id2>=rows_init){
            var finance_cheque_id = document.getElementById('ggg' + row_id2).value;
            sTa.deleteRow(row_id2);
			var ddd1_divs=document.getElementsByTagName('div');
			var b=1;
			for(var a=0;a<ddd1_divs.length;a++){
				if(ddd1_divs[a].id.indexOf('bbb_div')==0){
					ddd1_divs[a].id='bbb_div'+b;
					b++;
				}
			}
            for (var j = 1; j < sTa.rows.length; j++) {
                sTa.getElementsByTagName('tr')[j].id = j;
                for (var m = 0; m < sTa.getElementsByTagName('tr')[j].getElementsByTagName('input').length; m++) {
                    switch (m) {
                      case 0:
                        sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id = 'aaa' + j;
                        break;
                      case 1:
                        sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id = 'bbb' + j;
                        break;
                      case 2:
                        sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id = 'ccc' + j;
                        break;
                      case 3:
                        sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id = 'ddd' + j;
                        break;
                      case 4:
                        sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id = 'eee' + j;
                        break;
                      case 5:
                        sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id = 'fff' + j;
                        break;
					  case 6:
                        sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id = 'ggg' + j;
                        break;
                    }
                }
            }
			var xmlhttp3;
            if (window.XMLHttpRequest) {
                xmlhttp3 = new XMLHttpRequest();
            } else {
                if (window.ActiveXObject) {
                    xmlhttp3 = new ActiveXObject("Microsoft.XMLHTTP");
                }
            }
            if (xmlhttp3) {
                xmlhttp3.onreadystatechange = function () {
                    if (xmlhttp3.readyState == 4) {
                        try {
                            if (xmlhttp3.status == 200) {//成功
                                //dbNoteShow(2);
                            } else {
                                alert(xmlhttp3.status + "=" + xmlhttp3.statusText);
                            }
                        }
                        catch (exception) {
                            alert(exception);
                        }
                    }
                };
                xmlhttp3.open("POST", "../../../finance_teller_checkup_bill_delete_ok", true);
                xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xmlhttp3.send("finance_cheque_id=" + encodeURI(finance_cheque_id));
            }
			recalculation(current_balance_sum);
    }else{
					alert('银行对账单期初请在银行期初登记功能中删除');
				}
	} else {
        alert('\u8bf7\u9009\u62e9\u8981\u5220\u9664\u7684\u884c\uff01');
    }
    row_id2 = '';
}
var row_id3='';
function fo(id) {//聚焦事件，得到input框的ID，并显示或隐藏相关层
    
    row_id2 = id.substring(3);
    cal_init(row_id2);

    if (id.indexOf('bbb') == 0) {
    	loadMirror(document.getElementById(id),'bbb_div'+ row_id2);
        document.getElementById('bbb_div' + row_id2).style.display = 'block';
		if(row_id3!=''&&row_id3!=row_id2&&document.getElementById('bbb_div' + row_id3)!=undefined){
		document.getElementById('bbb_div' + row_id3).style.display = 'none';

		}
		row_id3=row_id2;
    }else{
		if(row_id3!=''&&document.getElementById('bbb_div' + row_id3)!=undefined){
	    document.getElementById('bbb_div' + row_id3).style.display = 'none';
		}

	}
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
obj.style.top=y-22;
obj.style.left=x+w-25;
}

function cal_init(obj){//加载日历层
var a1='aaa'+obj;
Calendar.setup ({inputField : a1, ifFormat : "%Y-%m-%d", showsTime : false, button : a1, singleClick : true, step : 1});
}

function showWay(div_id) {//显示结算方式层，隐藏相关层
    document.getElementById('way').style.display = 'block';
    document.getElementById(div_id).style.display = 'none';
}

function selectToB(this_value) {//将选定结算方式赋值给指定input，隐藏结算方式层
    document.getElementById('bbb' + row_id2).value = this_value;
    document.getElementById('way').style.display = 'none';

}

function send(file_id,account_init_time) {//将所有行数据保存至数据库
	
	if(notAllNull()){
		var temp_value='';
		var cols_value='';
		var cols_value1='';
        var sTa = document.getElementById('theObjTable');
        for (var i = 1; i < sTa.rows.length; i++) {
            var line = document.getElementById(i);
            var tag = line.getElementsByTagName('input');
			if((new Date(tag[0].value.replace(/-/g,'/')).getTime()<new Date(account_init_time.replace(/-/g,'/')).getTime())&&i>=rows_init){
				alert('日期不能小于账务初始时间');
				return false;
				}
            for (var j = 0; j < tag.length; j++) {
                temp_value = tag[j].value;
                if (temp_value == '') {
                    temp_value = '⊙';
                } else {
                    temp_value = temp_value.replace(/,/g, '');
					
                }
                cols_value += temp_value + '◇';
				
            }
            cols_value1 += cols_value.substring(0, cols_value.length - 1) + '□';
            cols_value = "";
        }
        cols_value1 = cols_value1.substring(0, cols_value1.length - 1);
		
        var xmlhttp3;
        if (window.XMLHttpRequest) {
            xmlhttp3 = new XMLHttpRequest();
        } else {
            if (window.ActiveXObject) {
                xmlhttp3 = new ActiveXObject("Microsoft.XMLHTTP");
            }
        }
        if (xmlhttp3) {
            xmlhttp3.onreadystatechange = function () {
                if (xmlhttp3.readyState == 4) {
                    try {
                        if (xmlhttp3.status == 200) {
							var err_time=xmlhttp3.responseText;
							if(parseInt(err_time)==123454321){
							        recalculation(current_balance_sum);
									alert('保存成功');
							}else if(parseInt(err_time)==1){
								alert('借方金额必须为数字');
							}else if(parseInt(err_time)==2){
								alert('贷方金额必须为数字');
							}else{
								alert('日期不能小于账务初始时间');
							}

				} else {
                            alert(xmlhttp3.status + "=" + xmlhttp3.statusText);
                        }
                    }
                    catch (exception) {
                        alert(exception);
                    }
                }
            };
            xmlhttp3.open("POST", "../../../finance_teller_checkup_bill_ok", true);
            xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xmlhttp3.send("cols_value=" + encodeURI(cols_value1) + "&file_id=" + file_id+ "&rows_init=" + rows_init );
        }
        cols_value1 = '';
    }
	
}

function  realTimeCal(){//调整前余额改变时，实时计算
var last_balance_sum;
var debit_sum;
var loan_sum;	
var last_sum;
	if(document.getElementById('last_balance_sum').value==''){
	last_sum='0.00';
}else{
	last_sum=document.getElementById('last_balance_sum').value;
}
    last_balance_sum=parseFloat(last_sum.replace(/,/g, ''));

	if(document.getElementById('debit_sum').value==''){
	document.getElementById('debit_sum').value='0.00';
}
	debit_sum=parseFloat(document.getElementById('debit_sum').value.replace(/,/g, ''));

	if(document.getElementById('loan_sum').value==''){
	document.getElementById('loan_sum').value='0.00';
}
	loan_sum=parseFloat(document.getElementById('loan_sum').value.replace(/,/g, ''));
	
	document.getElementById('balance_sum').value=last_balance_sum+debit_sum-loan_sum;
}

function calculation(input_id) {//计算相关input值
var rows_temp=parseInt(input_id.substring(3))-1;
	if(input_id.indexOf('ddd')==0){
   document.getElementById('fff'+input_id.substring(3)).value=parseFloat( document.getElementById('fff'+rows_temp).value.replace(/,/g,''))+parseFloat(document.getElementById('ddd'+input_id.substring(3)).value.replace(/,/g,''));
document.getElementById('fff'+input_id.substring(3)).value=formatCash(FormatNumberPoint(parseFloat(document.getElementById('fff'+input_id.substring(3)).value),2));
    }else{
    document.getElementById('fff'+input_id.substring(3)).value=parseFloat( document.getElementById('fff'+rows_temp).value.replace(/,/g,''))-parseFloat(document.getElementById('eee'+input_id.substring(3)).value.replace(/,/g,''));
document.getElementById('fff'+input_id.substring(3)).value=formatCash(FormatNumberPoint(parseFloat(document.getElementById('fff'+input_id.substring(3)).value),2));
	}
}
var current_balance_sum=0;
function recalculation(balance_sum1) {//计算相关input值
		current_balance_sum=balance_sum1;
		if(init_tag=='1'){
			balance_sum=start_balance_sum;
		}else{
			balance_sum=balance_sum1;
		}
        var sTa = document.getElementById('theObjTable');
        for (var i = 1; i < sTa.rows.length; i++) {
            var line = document.getElementById(i);
            var tag = line.getElementsByTagName('input');
		if(tag[3].value!=''){ 
			tag[5].value=parseFloat(tag[3].value.replace(/,/g, ''))+parseFloat(balance_sum);
			balance_sum=tag[5].value;
            tag[5].value=formatCash(FormatNumberPoint(tag[5].value,2));
			}

		if(tag[4].value!=''){
			tag[5].value=parseFloat(balance_sum)-parseFloat(tag[4].value.replace(/,/g, ''));
			balance_sum=tag[5].value;
            tag[5].value=formatCash(FormatNumberPoint(tag[5].value,2));
			}            
        }	
	}	
	       
function setNextNull(inp_id){//禁止借贷金额同时录入

	var n=inp_id.substring(3);
	if(inp_id.indexOf('ddd')==0){
		document.getElementById('eee'+n).value='';	
		//doValidate(document.getElementById('ddd'+n));
	}else if(inp_id.indexOf('eee')==0){
		document.getElementById('ddd'+n).value='';
		//doValidate(document.getElementById('eee'+n));
	}
	calculation(inp_id);
}
function notAllNull(){//禁止借贷同时为零
	var flag=true;
	var sTa = document.getElementById('theObjTable');
    for (var i = 1; i < sTa.rows.length; i++) {
		if(document.getElementById('ddd'+i).value==document.getElementById('eee'+i).value){
			alert('借贷不能同时为零');
			flag=false;
		}
	}
	return flag;
}

var rows_init=1;
var start_balance_sum=0;
var init_tag='0';
function balanceInit(obj,tag){//根据期初录入计算余额
var theObjTable = document.getElementById('theObjTable');
init_tag=tag;
 rows_init = theObjTable.rows.length;
  var rows=rows_init-1;
document.getElementById('fff'+rows).value=formatCash(FormatNumberPoint(parseFloat(obj),2));
var rows_temp=0;
for(var i=rows-1;i>0;i--){	
	rows_temp=i+1;
	if(document.getElementById('ddd'+rows_temp).value==''){
   document.getElementById('fff'+i).value=parseFloat( document.getElementById('fff'+rows_temp).value.replace(/,/g,''))+parseFloat(document.getElementById('eee'+rows_temp).value.replace(/,/g,''));
document.getElementById('fff'+i).value=formatCash(FormatNumberPoint(parseFloat(document.getElementById('fff'+i).value),2));
    }else{
    document.getElementById('fff'+i).value=parseFloat( document.getElementById('fff'+rows_temp).value.replace(/,/g,''))-parseFloat(document.getElementById('ddd'+rows_temp).value.replace(/,/g,''));
document.getElementById('fff'+i).value=formatCash(FormatNumberPoint(parseFloat(document.getElementById('fff'+i).value),2));
	}
  }
  if(document.getElementById('ddd1').value==''){	start_balance_sum=parseFloat(document.getElementById('fff1').value.replace(/,/g,''))+parseFloat(document.getElementById('eee1').value.replace(/,/g,''));
	}else{	start_balance_sum=parseFloat(document.getElementById('fff1').value.replace(/,/g,''))-parseFloat(document.getElementById('ddd1').value.replace(/,/g,''));
	}
 }

function formatCash(cash){//金额类数字显示格式化，三位加一个“,”
var cash=cash+'';
var cash1=cash.substring(0,cash.indexOf('.'));
if(cash1.indexOf('-')==0) cash1=cash1.substring(1);
var cash2=cash.substring(cash.indexOf('.'),cash.length);
var   str_cash=cash1+'';
var   ret_cash=''; 
var   counter=   0; 
for(var   i=str_cash.length-1;i >=0;i--) 
{ 
ret_cash =str_cash.charAt(i)+ret_cash;
if(str_cash.charAt(i)== '.') 
{ 
counter=0; 
continue; 
} 
counter++; 
if(counter==3) 
{
counter=0; 
if(i!=0&&str_cash.charAt(i-1)!= '.') 
ret_cash =','+ret_cash; 
}
} 
ret_cash=ret_cash+cash2;
if(cash.indexOf('-')==0) ret_cash='-'+ret_cash;
return   ret_cash; 
}

function FormatNumberPoint(srcStr,nAfterDot){//定义数字小数点后位数，并四舍五入   
var   srcStr;
var nAfterDot;   
var   resultStr,nTen;   
srcStr   =   ''+srcStr+'';   
strLen   =   srcStr.length;   
dotPos   =   srcStr.indexOf('.',0);   
if(dotPos   ==   -1){   
resultStr   =   srcStr+'.';   
for(i=0;i<nAfterDot;i++){
resultStr = resultStr+'0';   
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
return   resultStr;   
}   
else{
resultStr=srcStr;   
for (i=0;i<(nAfterDot-strLen+dotPos+1);i++){   
resultStr=resultStr+'0';   
}   
return   resultStr;   
}   
}   
}