/*
  *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
function deleteReconfirm() {//确认是否能够核销银行账
        var sTa = document.getElementById('selected').value;
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
							if(parseInt(xmlhttp3.responseText)==0){
								document.getElementById('reconfirm').style.display='block';
								}else{
								document.getElementById('notDelete').style.display='block';
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
            xmlhttp3.open("POST", "../../../finance_teller_checkup_delete_reconfirm", true);
            xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xmlhttp3.send("sTa=" +sTa);
				}
    }

function deleteBank(){//核销银行账
	    var sTa = document.getElementById('selected').value;
		document.getElementById('reconfirm').style.display='none';	

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
						alert("核销完成");
								
				        } else {
                            alert(xmlhttp3.status + "=" + xmlhttp3.statusText);
                        }
                    }
                    catch (exception) {
                        alert(exception);
                    }
                }
            };
            xmlhttp3.open("POST", "../../../finance_teller_checkup_delete_ok", true);
            xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xmlhttp3.send("sTa=" +sTa);
				}
}
