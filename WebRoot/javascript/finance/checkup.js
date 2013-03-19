/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
function addRow1() {//动态添加日记账行
    var sTa1 = document.getElementById('objtable');
    var id_input1 = sTa1.rows.length;
    tr = sTa1.insertRow(sTa1.rows.length);
    tr.height = "25";
    tr.id = 'tr'+id_input1;//因为有表头，从1开始
    row_id11 ='tr'+ id_input1;
	tr.insertCell(-1).innerHTML = "<input id='aaa1" + id_input1 + "' type='text' style=\"width: 100%; height: 100%;BORDER-BOTTOM:  0px;BORDER-left:  0px ;BORDER-right:  0px ;BORDER-top:  0px ;\">";
	tr.insertCell(-1).innerHTML = "<input id='bbb1" + id_input1 + "' type='text' style=\"width: 100%; height: 100%;BORDER-BOTTOM:  0px;BORDER-left:  0px ;BORDER-right:  0px ;BORDER-top:  0px ;\">";
	tr.insertCell(-1).innerHTML = "<input id='ccc1" + id_input1 + "' type='text' style=\"width: 100%; height: 100%;BORDER-BOTTOM:  0px;BORDER-left:  0px ;BORDER-right:  0px ;BORDER-top:  0px ;\">";
	tr.insertCell(-1).innerHTML = "<input id='ddd1" + id_input1 + "' type='text' style=\"width: 100%; height: 100%;BORDER-BOTTOM:  0px;BORDER-left:  0px ;BORDER-right:  0px ;BORDER-top:  0px ;\">";
	tr.insertCell(-1).innerHTML = "<input name='attachment_id1' id='eee1" + id_input1 + "' type='text' style=\"width: 100%; height: 100%;BORDER-BOTTOM:  0px;BORDER-left:  0px ;BORDER-right:  0px ;BORDER-top:  0px ;\">";
	tr.insertCell(-1).innerHTML = "<input id='fff1" + id_input1 + "' type='text' style=\"width: 100%; height: 100%;BORDER-BOTTOM: 0px;BORDER-left: 0px ;BORDER-right: 0px ;BORDER-top: 0px ;color:red; text-align:center;\" ondblclick=\"doubleClick(this.id,'1')\">";
	tr.insertCell(-1).innerHTML = "<input id='ggg1" + id_input1 + "' type='text' style=\"width: 100%; height: 100%;BORDER-BOTTOM:  0px;BORDER-left:  0px ;BORDER-right:  0px ;BORDER-top:  0px ;\">";
	tr.insertCell(-1).innerHTML = "<input id='hhh1" + id_input1 + "' type='text' style=\"width: 100%; height: 100%;BORDER-BOTTOM:  0px;BORDER-left:  0px ;BORDER-right:  0px ;BORDER-top:  0px ;\">";
	tr.insertCell(-1).innerHTML = "<input id='iii1" + id_input1 + "' type='text' style=\"width: 100%; height: 100%;BORDER-BOTTOM:  0px;BORDER-left:  0px ;BORDER-right:  0px ;BORDER-top:  0px ;\"><input id='jjj1" + id_input1 + "' type='hidden'>";

}

function addRow() {//动态添加银行账行
    var sTa = document.getElementById("theObjTable");
    var id_input = sTa.rows.length;
    tr = document.getElementById("theObjTable").insertRow(sTa.rows.length);
    tr.height = "25";
    tr.id = id_input;
    row_id1 = id_input;
    tr.insertCell(-1).innerHTML = "<input name='register_time' id='aaa" + id_input + "' type='text' style=\"width: 100%; height: 100%;BORDER-BOTTOM:  0px;BORDER-left:  0px ;BORDER-right:  0px ;BORDER-top:  0px ;\">";
    tr.insertCell(-1).innerHTML = "<input name='third_kind_name' id='bbb" + id_input + "' type='text' style=\"width: 100%; height: 100%;BORDER-BOTTOM:  0px;BORDER-left:  0px ;BORDER-right:  0px ;BORDER-top:  0px ;\">";
    tr.insertCell(-1).innerHTML = "<input name='human_name' id='ccc" + id_input + "' type='text' style=\"width: 100%; height: 100%;BORDER-BOTTOM:  0px;BORDER-left:  0px ;BORDER-right:  0px ;BORDER-top:  0px ;\">";
    tr.insertCell(-1).innerHTML = "<input name='cheque_id' id='ddd" + id_input + "' type='text' style=\"width: 100%; height: 100%;BORDER-BOTTOM:  0px;BORDER-left:  0px ;BORDER-right:  0px ;BORDER-top:  0px ;\">";
    tr.insertCell(-1).innerHTML = "<input name='pre_subtotal' id='eee" + id_input + "' type='text' style=\"width: 100%; height: 100%;BORDER-BOTTOM:  0px;BORDER-left:  0px ;BORDER-right:  0px ;BORDER-top:  0px ;\"><input id='fff" + id_input + "' type='hidden'>";
	tr.insertCell(-1).innerHTML = "<input name='human_name' id='ggg" + id_input + "' type='text' style=\"width: 100%; height: 100%; color:red; text-align:center; BORDER-BOTTOM:  0px;BORDER-left:  0px ;BORDER-right:  0px ;BORDER-top:  0px ;\" ondblclick=\"doubleClick(this.id,'0')\">";
}

function doubleClick(input_id,obj){//双击两清录入框，手工勾对或反勾对。
var status;
var id;
if(document.getElementById(input_id).value!=''){
document.getElementById(input_id).value='';
status=0;
}else{
document.getElementById(input_id).value='√';
status=1;
}
if(obj=='0') id=document.getElementById('fff'+input_id.substring(3)).value;
if(obj=='1') id=document.getElementById('jjj1'+input_id.substring(4)).value;
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
				if(obj=='0') xmlhttp3.open("POST", "../../../finance_teller_checkup_checkup_ok", true);
				if(obj=='1') xmlhttp3.open("POST", "../../../finance_teller_checkup_checkup_ok1", true);
                xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xmlhttp3.send("id=" + encodeURI(id)+"&&status=" + status);
            }
}

function checkupAuto(){//自动对账
            var sTa = document.getElementById('objtable');
			var sTa1 = document.getElementById('theObjTable');
			var id_group='';
			var id_group1='';
for (var i = 1; i < sTa.rows.length; i++) {
            var line = document.getElementById('tr'+i);
            var tag = line.getElementsByTagName('input');
            for (var j = 1; j < sTa1.rows.length; j++) {
				var line1 = document.getElementById(j);
				var tag1 = line1.getElementsByTagName('input');
			if(tag[1].value==tag1[1].value&&tag[2].value==tag1[2].value&&tag[3].value==tag1[3].value&&tag[4].value==tag1[4].value&&tag[5].value==''&&tag1[6].value==''){
				  id_group+=tag[9].value+'◇';
				  id_group1+=tag1[5].value+'◇';
				  tag[5].value='A√';
				  tag1[6].value='A√';
				}
			}
	}
	id_group=id_group.substring(0,id_group.length-1);
	id_group1=id_group1.substring(0,id_group1.length-1);
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
				xmlhttp3.open("POST", "../../../finance_teller_checkup_checkup_auto_ok", true);
                xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xmlhttp3.send("id_group=" + encodeURI(id_group)+"&&id_group1=" + id_group1);
            }
}

function uncheckupSelect(){//显示反对账条件选择层

	document.getElementById('query').style.display='block';
}

function unCheckup(){//反对账
var date_start = document.getElementById('date_start').value;
var date_end = document.getElementById('date_end').value;
var selected = document.getElementById('selected').value;
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
							var id_group=xmlhttp3.responseText.split('□');
							var sTa = document.getElementById('objtable');
								for (var i = 1; i < sTa.rows.length; i++) {
            var line = document.getElementById('tr'+i);
            var tag = line.getElementsByTagName('input');
			if(id_group[0].indexOf('◇'+tag[9].value+'◇')!=-1) tag[5].value='';
								}
			var sTa1 = document.getElementById('theObjTable');
								for (var i = 1; i < sTa1.rows.length; i++) {
            var line1 = document.getElementById(i);
            var tag1 = line1.getElementsByTagName('input');
			if(id_group[1].indexOf('◇'+tag1[5].value+'◇')!=-1) tag1[6].value='';
								}
				document.getElementById('query').style.display='none';

                            } else {
                                alert(xmlhttp3.status + "=" + xmlhttp3.statusText);
                            }
                        }
                        catch (exception) {
                            alert(exception);
                        }
                    }
                };
				xmlhttp3.open("POST", "../../../finance_teller_checkup_checkup_not_ok", true);
                xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xmlhttp3.send("date_start=" + date_start+"&&date_end=" + date_end+"&&selected=" + encodeURI(selected));
            }

}
