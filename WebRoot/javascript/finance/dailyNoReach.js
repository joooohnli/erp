/*
  *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
function dailyNoReach(){//显示日记账期初未达项层
var notReach=document.getElementById('dailyNoReach');
notReach.style.display='block';
}
var row_id11='';
var row_id22='';
function addRow1() {//动态添加行
    var sTa1 = document.getElementById('objtable');
    var id_input1 = sTa1.rows.length;
    tr = sTa1.insertRow(sTa1.rows.length);
    tr.height = "25";
    tr.id = 'tr'+id_input1;//因为有表头，从1开始
    row_id11 ='tr'+ id_input1;
	tr.insertCell(-1).innerHTML = "<input name='voucher_time' id='aaa1" + id_input1 + "' type='text' style=\"width: 100%; height: 100%;\" onFocus=\"fo1(this.id)\">";
	tr.insertCell(-1).innerHTML = "<input name='voucher_type' id='bbb1" + id_input1 + "' type='text' style=\"width: 100%; height: 100%;\" onFocus=\"fo1(this.id)\">";
	tr.insertCell(-1).innerHTML = "<input name='voucher_in_month_id' id='ccc1" + id_input1 + "' type='text' style=\"width: 100%; height: 100%;\" onFocus=\"fo1(this.id)\">";
	tr.insertCell(-1).innerHTML = "<input name='way1' id='ddd1" + id_input1 + "' type='text' style=\"width: 100%; height: 100%;\" onFocus=\"fo1(this.id)\" onkeyup=\"inputCancel(this.id);\">";
	tr.insertCell(-1).innerHTML = "<input name='attachment_id1' id='eee1" + id_input1 + "' type='text' style=\"width: 100%; height: 100%;\" onFocus=\"fo1(this.id)\">";
	tr.insertCell(-1).innerHTML = "<input name='debit_subtotal1' id='fff1" + id_input1 + "' type='text' style=\"width: 100%; height: 100%;\" onFocus=\"fo1(this.id)\" onkeyup=\"setNextNull1(this.id)\">";
	tr.insertCell(-1).innerHTML = "<input name='loan_subtotal1' id='ggg1" + id_input1 + "' type='text' style=\"width: 100%; height: 100%;\" onFocus=\"fo1(this.id)\" onkeyup=\"setNextNull1(this.id)\">";
	tr.insertCell(-1).innerHTML = "<input name='notes_time' id='hhh1" + id_input1 + "' type='text' style=\"width: 100%; height: 100%;\" onFocus=\"fo1(this.id)\">";
	tr.insertCell(-1).innerHTML = "<input name='summary' id='iii1" + id_input1 + "' type='text' style=\"width: 100%; height: 100%;\" onFocus=\"fo1(this.id)\" >";
	tr.insertCell(-1).innerHTML = "<input id='jjj1" + id_input1 + "' type='hidden' style=\"width: 100%; height: 100%;\" onFocus=\"fo1(this.id)\">";
}

function deleteMyRow1() {//删除选定的行，并对所有行和相关层重新排序
    if (row_id22 != '') {
           var finance_cheque_id = document.getElementById("jjj1" + row_id22).value;
          
            var sTa = document.getElementById('objtable');
            sTa.deleteRow(row_id22);
			var ddd1_divs=document.getElementsByTagName('div');
			var b=1;
			for(var a=0;a<ddd1_divs.length;a++){
				if(ddd1_divs[a].id.indexOf('ddd1_div')==0){
					ddd1_divs[a].id='ddd1_div'+b;
					b++;
				}
			}
            for (var j = 0; j < sTa.rows.length; j++) {
                sTa.getElementsByTagName('tr')[j].id = 'tr'+j;
                for (var m = 0; m < sTa.getElementsByTagName('tr')[j].getElementsByTagName('input').length; m++) {
                    switch (m) {
                      case 0:
                        sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id = 'aaa1' + j;
                        break;
                      case 1:
                        sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id = 'bbb1' + j;
                        break;
                      case 2:
                        sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id = 'ccc1' + j;
                        break;
                      case 3:
                        sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id = 'ddd1' + j;
                        break;
                      case 4:
                        sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id = 'eee1' + j;
                        break;
                      case 5:
                        sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id = 'fff1' + j;
                        break;
                      case 6:
                        sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id = 'ggg1' + j;
                        break;
                      case 7:
                        sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id = 'hhh1' + j;
                        break;
                      case 8:
                        sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id = 'iii1' + j;
                        break;
                      case 9:
                        sTa.getElementsByTagName('tr')[j].getElementsByTagName('input')[m].id = 'jjj1' + j;
                        break;
                    }
                }
            }
			 var xmlhttp3;
            if (window.XMLHttpRequest) {
                xmlhttp3 = new XMLHttpRequest();
            } else if(window.ActiveXObject){
				xmlhttp3 = new ActiveXObject("Microsoft.XMLHTTP");
            }
            if (xmlhttp3) {
                xmlhttp3.onreadystatechange = function () {
                    if (xmlhttp3.readyState == 4) {
                        try {
                            if (xmlhttp3.status == 200) {
                                calculation1();
                            } else {
                                alert(xmlhttp3.status + "=" + xmlhttp3.statusText);
                            }
                        }
                        catch (exception) {
                            alert(exception);
                        }
                    }
                };
                xmlhttp3.open("POST", "../../../finance_teller_checkup_registerInit_delete_ok1", true);
                xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xmlhttp3.send("finance_cheque_id=" + encodeURI(finance_cheque_id));
            }
      
    } else {
        alert('请选择要删除的行');
    }
    row_id22 = '';
}
var row_id33='';
function fo1(id) {//聚焦事件，得到input框的ID，并显示或隐藏相关层 
   document.getElementById('dailyNoReach').nseerDef='';
    row_id22 = id.substring(4);
    cal_init1(row_id22);
    if (id.indexOf('ddd1') == 0) {
    	loadMirror(document.getElementById(id),'show_div1');
        document.getElementById('show_div1').style.display = 'block';
		if(row_id33!=''&&row_id33!=row_id22&&document.getElementById('ddd1_div' + row_id33)!=undefined){
		document.getElementById('show_div1').style.display = 'none';

		}
		row_id33=row_id22;
    }else{
		if(row_id33!=''&&document.getElementById('show_div')!=undefined){
	    document.getElementById('show_div').style.display = 'none';
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
obj.style.top=y;
obj.style.left=x+w-19;
}

function cal_init1(obj){//加载日历层
var a1='aaa1'+obj;
Calendar.setup ({inputField : a1, ifFormat : "%Y-%m-%d", showsTime : false, button : a1, singleClick : true, step : 1});
var a2='hhh1'+obj;
Calendar.setup ({inputField : a2, ifFormat : "%Y-%m-%d", showsTime : false, button : a2, singleClick : true, step : 1});
}

function showWay1(div_id) {//显示结算方式层，隐藏相关层
	document.getElementById('dailyNoReach').nseerDef='dragonly';
    document.getElementById('way2').style.display = 'block';
    document.getElementById(div_id).style.display = 'none';
    	
}

function selectToB1(this_value) {//将选定结算方式赋值给指定input，隐藏结算方式层
    document.getElementById('ddd1' + row_id22).value = this_value;
    document.getElementById('way2').style.display = 'none';
}

function send1(file_id,account_init_time) {//将所有行数据保存至数据库
	
		if(notAllNull1()){
		var temp_value='';
		var cols_value='';
		var cols_value11='';
		var debit_sum=0;
		var loan_sum=0;
		var balance_sum=0;
        var sTa1 = document.getElementById('objtable');
        for (var i = 1; i < sTa1.rows.length; i++) {
            var line1 = document.getElementById('tr'+i);
            var tag1 = line1.getElementsByTagName('input');
			if((new Date(tag1[0].value.replace(/-/g,'/')).getTime()>=new Date(account_init_time.replace(/-/g,'/')).getTime())){
				alert('日期必须小于账务初始时间');
				return false;
				}
            for (var j = 0; j < tag1.length; j++) {
                temp_value = tag1[j].value;
                if (temp_value == '') {
                    temp_value = '⊙';
                } else {
                    temp_value = temp_value.replace(/,/g, '');
                }
                cols_value += temp_value + '◇';
            }
            cols_value11 += cols_value.substring(0, cols_value.length - 1) + '□';
            cols_value = "";
        }
        cols_value11 = cols_value11.substring(0, cols_value11.length - 1);
		
        var xmlhttp3;
        if (window.XMLHttpRequest) {
            xmlhttp3 = new XMLHttpRequest();
        } else if (window.ActiveXObject){
			xmlhttp3 = new ActiveXObject('Microsoft.XMLHTTP');
        }
        if (xmlhttp3) {
            xmlhttp3.onreadystatechange = function () {
                if (xmlhttp3.readyState == 4) {
                    try {
                        if (xmlhttp3.status == 200) {
				           var err_time=xmlhttp3.responseText;
							if(parseInt(err_time)==123454321){
								cols_value11 = "";
								document.getElementById('dailyNoReach').style.display='none';
								saveCurrentSum(file_id);
							        calculation1();
							}else if(parseInt(err_time)==1){
								alert('借方金额必须为数字');
							}else if(parseInt(err_time)==2){
								alert('贷方金额必须为数字');
							}else{
								var error=err_time.split('◇');
								if(error[0]!='□'){
									alert('日期必须小于账务初始时间');
								}else{
									alert('票据日期不能大于凭证日期');
								}
							}

						} else {
                            alert(xmlhttp3.status + '=' + xmlhttp3.statusText);
                        }
                    }
                    catch (exception) {
                        alert(exception);
                    }
                }
            };
            xmlhttp3.open('POST', '../../../finance_teller_checkup_registerInit_ok1', true);
            xmlhttp3.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xmlhttp3.send('cols_value=' + encodeURI(cols_value11) + '&file_id=' + file_id+"&account_init_time="+account_init_time);
        }
		}

}

function setNextNull1(inp_id){//禁止借贷金额同时录入
	var n=inp_id.substring(4);
	if(inp_id.indexOf('fff1')==0){
		document.getElementById('ggg1'+n).value='';	
	}else if(inp_id.indexOf('ggg1')==0){
		document.getElementById('fff1'+n).value='';
	}
}

function notAllNull1(){//禁止借贷同时为零
	var flag=true;
	var sTa = document.getElementById('objtable');
    for (var i = 1; i < sTa.rows.length; i++) {
		if(document.getElementById('fff1'+i).value==document.getElementById('ggg1'+i).value){
			alert('借贷不能同时为零');
			flag=false;
		}
	}
	 return flag;
}

function calculation1() {//计算相关input值
		var temp_value='';
		var debit_sum=0;
		var loan_sum=0;
		var balance_sum=0;
        var sTa = document.getElementById('objtable');
        for (var i = 1; i < sTa.rows.length; i++) {
            var line = document.getElementById('tr'+i);
            var tag = line.getElementsByTagName('input');
            for (var j = 0; j < tag.length; j++) {
                temp_value = tag[j].value;
                if (temp_value == '') {
                    temp_value = '⊙';
                } else {
                    temp_value = temp_value.replace(/,/g, '');
					if(j==5){
						debit_sum+=parseFloat(temp_value);
					}
					if(j==6){
						loan_sum+=parseFloat(temp_value);
					}
                }
				
            }
        }
		balance_sum=debit_sum-loan_sum;
	document.getElementById('debit_sum1').value=debit_sum;
	document.getElementById('loan_sum1').value=loan_sum;
	if(document.getElementById('last_balance_sum1').value==''){
		document.getElementById('last_balance_sum1').value=0;
	}	document.getElementById('balance_sum1').value=parseFloat(document.getElementById('last_balance_sum1').value.replace(/,/g, ''))+balance_sum;
	       
}

function  realTimeCal1(){//调整前余额改变时，实时计算
var last_balance_sum;
var debit_sum;
var loan_sum;
var last_sum;

	if(document.getElementById('last_balance_sum1').value==''){
	last_sum='0.00';
}else{
    last_sum=document.getElementById('last_balance_sum1').value;
}
	last_balance_sum=parseFloat(last_sum.replace(/,/g, ''));

	if(document.getElementById('debit_sum1').value==''){
	document.getElementById('debit_sum1').value='0.00';
}
	debit_sum=parseFloat(document.getElementById('debit_sum1').value.replace(/,/g, ''));

	if(document.getElementById('loan_sum1').value==''){
	document.getElementById('loan_sum1').value='0.00';
}
	loan_sum=parseFloat(document.getElementById('loan_sum1').value.replace(/,/g, ''));
	
	document.getElementById('balance_sum1').value=last_balance_sum+debit_sum-loan_sum;
}