<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.text.*" import="java.io.*" %>
<script language="JavaScript">
function closewin() {
setTimeout("javascript:CloseWin()",100)
}
</script>
<body bgcolor="#E7E8C9" onload="closewin()">
<script>
function CloseWin()
{
var ua=navigator.userAgent
var ie=navigator.appName=="Microsoft Internet Explorer"?true:false
if(ie){
 var IEversion=parseFloat(ua.substring(ua.indexOf("MSIE ")+5,ua.indexOf(";",ua.indexOf("MSIE "))))
 if(IEversion< 5.5){
 var str = '<object id=noTipClose classid="clsid:ADB880A6-D8FF-11CF-9377-00AA003B7A11">'
 str += '<param name="Command" value="Close"></object>';
 document.body.insertAdjacentHTML("beforeEnd", str);
 document.all.noTipClose.Click();
 }
 else{
 winopener =null;
 window.close();
 }
}
else{
window.close()
}
}
</script>
<%
session.removeAttribute("USERC");
session.removeValue("usernamec");
session.removeValue("tagc");
session.removeValue("realeditorc");
session.removeValue("idc");
session.removeValue("human_IDD");
session.removeValue("unit_db_name");
session.removeValue("language");
%>