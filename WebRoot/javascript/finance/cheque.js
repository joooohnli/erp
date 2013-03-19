/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
function disinput(this_id) {
    var line = document.getElementById(this_id.substring(3));
    var tag = line.getElementsByTagName("input");
    if (document.getElementById(this_id).value != "" && document.getElementById("ppp" + this_id.substring(3)).value != "") {
        for (var j = 0; j < tag.length; j++) {
            if (tag[j].id != this_id) {
                tag[j].disabled = true;
            }
        }
    } else {
        for (var j = 0; j < tag.length; j++) {
            if (tag[j].id != this_id) {
                tag[j].disabled = false;
            }
        }
    }
}
var row_id1 = "";
var row_id2 = "";
function addRow() {//添加行
    var sTa = document.getElementById("theObjTable");
    var id_input = sTa.rows.length;
    tr = document.getElementById("theObjTable").insertRow(sTa.rows.length);
    tr.height = "25";
    tr.id = id_input;
    row_id1 = id_input;
    tr.insertCell(-1).innerHTML = "<input name='register_time' id='aaa" + id_input + "' type='text' style=\"width: 100%; height: 100%;\" onFocus=\"fo(this.id)\">";
    tr.insertCell(-1).innerHTML = "<input name='third_kind_name' id='bbb" + id_input + "' type='text' style=\"width: 100%; height: 100%;\" onFocus=\"fo(this.id)\" onkeyup=\"inputCancel(this.id)\"><div style=\"cursor: hand; display: none; padding-top: 10px; left: 202px; width: 18px; position: absolute; background-image: url('../../images/magnifier.gif'); background-repeat: no-repeat; background-attachment: scroll; right: 0px; background-position: 70% 50%;\" id='bbb_div" + id_input + "' onclick=\"showPart(this.id)\"></div>";
    tr.insertCell(-1).innerHTML = "<input name='human_name' id='ccc" + id_input + "' type='text' style=\"width: 100%; height: 100%;\" onFocus=\"loadAjaxDiv(this.id,'bbb',event);this.blur();\" onkeyup=\"inputCancel(this.id)\">";
    tr.insertCell(-1).innerHTML = "<input name='cheque_id' id='ddd" + id_input + "' type='text' style=\"width: 100%; height: 100%;\" onFocus=\"fo(this.id)\">";
    tr.insertCell(-1).innerHTML = "<input name='pre_subtotal' id='eee" + id_input + "' type='text' style=\"width: 100%; height: 100%;\" onFocus=\"fo(this.id)\" onkeyup=\"decimalControl(this.id);\">";
    tr.insertCell(-1).innerHTML = "<input name='field' id='fff" + id_input + "' type='text' style=\"width: 100%; height: 100%;\" onFocus=\"fo(this.id)\">";
    tr.insertCell(-1).innerHTML = "<input name='gatherer' id='ggg" + id_input + "' type='text' style=\"width: 100%; height: 100%;\" onFocus=\"fo(this.id)\">";
    tr.insertCell(-1).innerHTML = "<input name='chain_mate_id' id='hhh" + id_input + "' type='text' style=\"width: 100%; height: 100%;\" onFocus=\"fo(this.id)\">";
    tr.insertCell(-1).innerHTML = "<input name='bank' id='iii" + id_input + "' type='text' style=\"width: 100%; height: 100%;\" onFocus=\"fo(this.id)\">";
    tr.insertCell(-1).innerHTML = "<input name='account' id='jjj" + id_input + "' type='text' style=\"width: 100%; height: 100%;\" onFocus=\"fo(this.id)\">";
    tr.insertCell(-1).innerHTML = "<input name='pre_trans_time' id='kkk" + id_input + "' type='text' style=\"width: 100%; height: 100%;\" onFocus=\"fo(this.id)\" >";
    tr.insertCell(-1).innerHTML = "<input name='reim_time' id='lll" + id_input + "' type='text' style=\"width: 100%; height: 100%;\" onFocus=\"fo(this.id)\" onblur=\"disinput(this.id)\" >";
    tr.insertCell(-1).innerHTML = "<input name='remark' id='mmm" + id_input + "' type='text' style=\"width: 100%; height: 100%;\" onFocus=\"fo(this.id)\">";
    tr.insertCell(-1).innerHTML = "<input name='real_subtotal' id='nnn" + id_input + "' type='text' style=\"width: 100%; height: 100%;\" onFocus=\"fo(this.id)\" onkeyup=\"decimalControl(this.id);\">";
    tr.insertCell(-1).innerHTML = "<input name='password' id='ooo" + id_input + "' type='text' style=\"width: 100%; height: 100%;\" onFocus=\"fo(this.id)\">";
    tr.insertCell(-1).innerHTML = "<input id='ppp" + id_input + "' type='hidden' style=\"width: 100%; height: 100%;\" onFocus=\"fo(this.id)\">";
}
function deleteRow() {//删除
    if (row_id2 != "") {
        if (document.getElementById("lll" + row_id2).value == "") {
            var finance_cheque_id = document.getElementById("ppp" + row_id2).value;
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
                                multiLangValidate.dwrGetLang("erp","删除成功",{callback:function(msg){n_A.divShow(msg);}});
                            } else {
                                alert(xmlhttp3.status + "=" + xmlhttp3.statusText);
                            }
                        }
                        catch (exception) {
                            alert(exception);
                        }
                    }
                };
                xmlhttp3.open("POST", "../../finance_teller_cheque_delete_ok", true);
                xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xmlhttp3.send("finance_cheque_id=" + encodeURI(finance_cheque_id));
            }
            var sTa = document.getElementById("theObjTable");
            sTa.deleteRow(row_id2);
			var ddd1_divs=document.getElementsByTagName('div');
			var b=1;
			for(var a=0;a<ddd1_divs.length;a++){
				if(ddd1_divs[a].id.indexOf('bbb_div')==0){
					ddd1_divs[a].id='bbb_div'+b;
					b++;
				}
			}
            for (var j = 0; j < sTa.rows.length; j++) {
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
                      case 6:
                        sTa.getElementsByTagName("tr")[j].getElementsByTagName("input")[m].id = "ggg" + j;
                        break;
                      case 7:
                        sTa.getElementsByTagName("tr")[j].getElementsByTagName("input")[m].id = "hhh" + j;
                        break;
                      case 8:
                        sTa.getElementsByTagName("tr")[j].getElementsByTagName("input")[m].id = "iii" + j;
                        break;
                      case 9:
                        sTa.getElementsByTagName("tr")[j].getElementsByTagName("input")[m].id = "jjj" + j;
                        break;
                      case 10:
                        sTa.getElementsByTagName("tr")[j].getElementsByTagName("input")[m].id = "kkk" + j;
                        break;
                      case 11:
                        sTa.getElementsByTagName("tr")[j].getElementsByTagName("input")[m].id = "lll" + j;
                        break;
                      case 12:
                        sTa.getElementsByTagName("tr")[j].getElementsByTagName("input")[m].id = "mmm" + j;
                        break;
                      case 13:
                        sTa.getElementsByTagName("tr")[j].getElementsByTagName("input")[m].id = "nnn" + j;
                        break;
                      case 14:
                        sTa.getElementsByTagName("tr")[j].getElementsByTagName("input")[m].id = "ooo" + j;
                        break;
                      case 15:
                        sTa.getElementsByTagName("tr")[j].getElementsByTagName("input")[m].id = "ppp" + j;
                        break;
                    }
                }
            }
        } else {
            alert("\u5df2\u62a5\u652f\u7968\u4e0d\u80fd\u5220\u9664\uff01");
        }
    } else {
        alert("\u8bf7\u9009\u62e9\u8981\u5220\u9664\u7684\u884c\uff01");
    }
    row_id2 = "";
}
var row_id33;
function fo(id) {//聚焦事件，得到input框的ID
    row_id2 = id.substring(3);
    cal_init(row_id2);
	 if (id.indexOf('bbb') == 0) {
	 	loadMirror(document.getElementById(id),'bbb_div'+ row_id2);
        document.getElementById('bbb_div' + row_id2).style.display = 'block';
		if(row_id33!=''&&row_id33!=row_id2&&document.getElementById('bbb_div' + row_id33)!=undefined){
		document.getElementById('bbb_div' + row_id33).style.display = 'none';

		}
		row_id33=row_id2;
    }else{
		if(row_id33!=''&&document.getElementById('bbb_div' + row_id33)!=undefined){
	    document.getElementById('bbb_div' + row_id33).style.display = 'none';
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

function showPart(div_id) {
	loadCover('part');
    document.getElementById("part").style.display = "block";
	document.getElementById("Storage_input").value=div_id;
    document.getElementById(div_id).style.display = "none";
}
function selectToC(this_value) {
	document.getElementById("ccc" + row_id2).focus();
    document.getElementById("ccc" + row_id2).value = this_value;
}
function selectToB(this_value) {
	document.getElementById("bbb" + row_id2).focus();
    document.getElementById("bbb" + row_id2).value = this_value;
}
var cols_value = "";
var temp_value = "";
var cols_value1 = "";
function send(file_id) {
        var sTa = document.getElementById("theObjTable");
        for (var i = 1; i < sTa.rows.length; i++) {
            var line = document.getElementById(i);
            var tag = line.getElementsByTagName("input");
            for (var j = 0; j < tag.length; j++) {
                temp_value = tag[j].value;
                if (temp_value == "") {
                    temp_value = "\u2299";
                } else {
                    temp_value = temp_value.replace(/,/g, "");
                }
                cols_value += temp_value + "\u25c7";
            }
            cols_value1 += cols_value.substring(0, cols_value.length - 1) + "\u25a1";
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
                            multiLangValidate.dwrGetLang("erp","保存成功",{callback:function(msg){n_A.divShow(msg);}});
                        } else {
                            alert(xmlhttp3.status + "=" + xmlhttp3.statusText);
                        }
                    }
                    catch (exception) {
                        alert(exception);
                    }
                }
            };
            xmlhttp3.open("POST", "../../finance_teller_cheque_ok", true);
            xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xmlhttp3.send("cols_value=" + encodeURI(cols_value1) + "&file_id=" + file_id);
        }
        cols_value1 = "";

}
//弹出层
var EndV = 1;
var StartV = 1;
var Inc = 0.1;
var timer;
var timer1 = 0;
function dbNoteShow(stas) {
    var str = "";
    if (stas == 1) {//保存成功
        str = "\u4fdd\u5b58\u6210\u529f";
    }
    if (stas == 2) {//删除成功
        str = "\u5220\u9664\u6210\u529f";
    }
    var note = document.getElementById("db_note");
    note.innerHTML = "<div class=\"x-box-tl\"><div class=\"x-box-tr\"><div class=\"x-box-tc\"></div></div></div><div class=\"x-box-ml\"><div class=\"x-box-mr\"><div class=\"x-box-mc\"><div style=\"height:30px;text-align:center;color:#3300FF;\">" + str + "</div></div></div></div><div class=\"x-box-bl\"><div class=\"x-box-br\"><div class=\"x-box-bc\"></div></div></div>";
    if (parseInt(note.style.top) < 30) {
        StartV = StartV + Inc;
        MidV = Math.sin(StartV) + 1;
        EndV = Math.pow(MidV, 5);
        var top = parseInt(note.style.top) + EndV;
        note.style.top = top + "px";
        window.setTimeout("dbNoteShow(" + stas + ");", 30);
    } else {
        dbNoteHidden();
        StartV = 1;
        EndV = 1;
        Inc = 0.1;
    }
}
function dbNoteHidden() {
    var note_div2 = document.getElementById("db_note");
    if (parseInt(note_div2.style.top) > -80) {
        if (timer1 > 1040939000) {
            StartV = StartV + Inc;
            MidV = Math.sin(StartV) + 1;
            EndV = Math.pow(MidV, 4);
            var top = parseInt(note_div2.style.top) - EndV;
            note_div2.style.top = top + "px";
        }
        timer = window.setTimeout("dbNoteHidden();", 20);
        timer1 = timer1 + timer;
    } else {
        note_div2.style.top = "-100px";
        StartV = 1;
        EndV = 1;
        Inc = 0.1;
        timer1 = 0;
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