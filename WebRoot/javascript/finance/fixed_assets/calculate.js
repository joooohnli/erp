/* 
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
function calway_ok(){
var xmlhttp3;
	if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
	xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
		if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200){
			if(xmlhttp3.responseText.substring(0,xmlhttp3.responseText.length-2)=='⊙'){
				alert('计提完成');
			}else if(xmlhttp3.responseText.substring(0,xmlhttp3.responseText.length-2)=='◎'){
					alert('本月已计提');
				}else{
					var file_name=xmlhttp3.responseText.replace(/⊙/g,',');
						alert(file_name+'数据有误无法计提,请确认数据');
			}
		}else{
	alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
	xmlhttp3.open("POST", "../../finance_fixed_assets_calculate_ok", true);
	xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xmlhttp3.send();
	}
}