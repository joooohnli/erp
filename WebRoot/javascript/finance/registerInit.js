/*
  *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
function notReach(){//显示对账单期初未达项层
var notReach=document.getElementById('notReach');
notReach.style.display='block';
}
var row_id1='';
function addRow() {//动态添加行
    var sTa = document.getElementById("theObjTable");
    var id_input = sTa.rows.length;
    tr = document.getElementById("theObjTable").insertRow(sTa.rows.length);
    tr.height = "25";
    tr.id = id_input;
    row_id1 = id_input;
    tr.insertCell(-1).innerHTML = "<input name='settle_time' id='aaa" + id_input + "' type='text' style=\"width: 100%; height: 100%;border-style:none;\" onFocus=\"fo(this.id)\">";
    tr.insertCell(-1).innerHTML = "<input name='way3' id='bbb" + id_input + "' type='text' style=\"width: 100%; height: 100%; border-style:none;\" onFocus=\"fo(this.id)\" onkeyup=\"inputCancel(this.id);\">";
    tr.insertCell(-1).innerHTML = "<input name='attachment_id' id='ccc" + id_input + "' type='text' style=\"width: 100%; height: 100%; border-style:none;\" onFocus=\"fo(this.id)\">";
    tr.insertCell(-1).innerHTML = "<input name='debit_subtotal' id='ddd" + id_input + "' type='text' style=\"width: 100%; height: 100%; border-style:none;\" onFocus=\"fo(this.id)\" onkeyup=\"setNextNull(this.id)\">";
	tr.insertCell(-1).innerHTML = "<input name='locan_subtotal' id='eee" + id_input + "' type='text' style=\"width: 100%; height: 100%;\" onFocus=\"fo(this.id)\" onkeyup=\"setNextNull(this.id)\"><input id='fff" + id_input + "' type='hidden'>";

}
var row_id2='';
function deleteRow() {//删除选定的行，并对所有行和相关层重新排序
    if (row_id2 != "") {
            var finance_cheque_id = document.getElementById("fff" + row_id2).value;
            var sTa = document.getElementById('theObjTable');
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
                sTa.getElementsByTagName("tr")[j].id = j;
                for (var m = 0; m < sTa.getElementsByTagName("tr")[j].getElementsByTagName("input").length; m++) {
                    switch (m) {
                      case 0:
                        sTa.getElementsByTagName("tr")[j].getElementsByTagName("input")[m].id = "aaa" + j;
                        break;
                      case 1:
                        sTa.getElementsByTagName("tr")[j].getElementsByTagName("input")[m].id = "bbb" + j;
                        break;
                      case 2:
                        sTa.getElementsByTagName("tr")[j].getElementsByTagName("input")[m].id = "ccc" + j;
                        break;
                      case 3:
                        sTa.getElementsByTagName("tr")[j].getElementsByTagName("input")[m].id = "ddd" + j;
                        break;
                      case 4:
                        sTa.getElementsByTagName("tr")[j].getElementsByTagName("input")[m].id = "eee" + j;
                        break;
                      case 5:
                        sTa.getElementsByTagName("tr")[j].getElementsByTagName("input")[m].id = "fff" + j;
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
								        calculation();
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
                xmlhttp3.open("POST", "../../../finance_teller_checkup_registerInit_delete_ok", true);
                xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xmlhttp3.send("finance_cheque_id=" + encodeURI(finance_cheque_id));
            }
    } else {
        alert('请选择要删除的行');
    }
    row_id2 = "";
}
var row_id3='';
function fo(id) {//聚焦事件，得到input框的ID，并显示或隐藏相关层
    document.getElementById('notReach').nseerDef='';
    row_id2 = id.substring(3);
    cal_init(row_id2);
	
    if (id.indexOf('bbb') == 0){
    	loadMirror(document.getElementById(id),'show_div');
        document.getElementById('show_div').style.display = 'block';
		if(row_id3!=''&&row_id3!=row_id2&&document.getElementById('bbb_div' + row_id3)!=undefined){
		document.getElementById('bbb_div' + row_id3).style.display = 'none';
		}
		row_id3=row_id2;
    }else{
		if(row_id3!=''&&document.getElementById('show_div1')!=undefined){
	    document.getElementById('show_div1').style.display = 'none';
		}

	}
}

function cal_init(obj){//加载日历层
var a1='aaa'+obj;
Calendar.setup ({inputField : a1, ifFormat : "%Y-%m-%d", showsTime : false, button : a1, singleClick : true, step : 1});
}

function showWay(div_id) {//显示结算方式层，隐藏相关层
	document.getElementById('notReach').nseerDef='dragonly';
    document.getElementById("way").style.display = "block";
    document.getElementById(div_id).style.display = "none";
}

function selectToB(this_value) {//将选定结算方式赋值给指定input，隐藏结算方式层

    document.getElementById("bbb" + row_id2).value = this_value;
    document.getElementById("way").style.display = "none";

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
            if((new Date(tag[0].value.replace(/-/g,'/')).getTime()>=new Date(account_init_time.replace(/-/g,'/')).getTime())){
				alert('日期必须小于账务初始时间');
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
								cols_value1 = "";
								document.getElementById('notReach').style.display='none';
								saveCurrentSum(file_id);
							        calculation();
							}else if(parseInt(err_time)==1){
								alert('借方金额必须为数字');
							}else if(parseInt(err_time)==2){
								alert('贷方金额必须为数字');
							}else{
								alert('日期必须小于账务初始时间');
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
            xmlhttp3.open("POST", "../../../finance_teller_checkup_registerInit_ok", true);
            xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xmlhttp3.send("cols_value=" + encodeURI(cols_value1) + "&file_id=" + file_id+"&account_init_time="+account_init_time);
        }
        
        
    }
	
}

function realTimeCal(){//调整前余额改变时，实时计算
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

function calculation() {//计算相关input值
		var temp_value='';
		var debit_sum=0;
		var loan_sum=0;
		var balance_sum=0;
        var sTa = document.getElementById('theObjTable');
        for (var i = 1; i < sTa.rows.length; i++) {
            var line = document.getElementById(i);
            var tag = line.getElementsByTagName('input');
            for (var j = 0; j < tag.length; j++) {
                temp_value = tag[j].value;
                if (temp_value == '') {
                    temp_value = '⊙';
                } else {
                    temp_value = temp_value.replace(/,/g, '');
					if(j==3){
						debit_sum+=parseFloat(temp_value);
					}
					if(j==4){
						loan_sum+=parseFloat(temp_value);
					}
                }
				
            }
        }
		balance_sum=debit_sum-loan_sum;
	document.getElementById('debit_sum').value=debit_sum;
	document.getElementById('loan_sum').value=loan_sum;
	if(document.getElementById('last_balance_sum').value==''){
		document.getElementById('last_balance_sum').value=0;
	}	document.getElementById('balance_sum').value=parseFloat(document.getElementById('last_balance_sum').value.replace(/,/g, ''))+balance_sum;
	       
}

function setNextNull(inp_id){//禁止借贷金额同时录入
	var n=inp_id.substring(3);
	if(inp_id.indexOf('ddd')==0){
		document.getElementById('eee'+n).value='';	
	}else if(inp_id.indexOf('eee')==0){
		document.getElementById('ddd'+n).value='';
	}
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

function saveCurrentSum(file_id){//保存调整前余额至数据库
  var balance_sum=document.getElementById('last_balance_sum').value;
  var balance_sum1=document.getElementById('last_balance_sum1').value;
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
							if(parseInt(xmlhttp3.responseText)==1){
								alert('调整前余额必须为数字');
							}else{
							alert('保存成功！');
							        calculation();
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
            xmlhttp3.open("POST", "../../../finance_teller_checkup_registerInit_start_ok", true);
            xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xmlhttp3.send("balance_sum=" + encodeURI(balance_sum) + "&balance_sum1=" + balance_sum1+ "&file_id=" + file_id);
        }

}

function inputCancel(input_id){//录入框禁止输入控制
document.getElementById(input_id).value='';
}