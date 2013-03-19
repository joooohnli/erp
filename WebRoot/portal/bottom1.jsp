<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
 <%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*,include.ecommerce.*"%>
 <style type="text/css">
<!--

.STYLE1 {

	line-height: 18pt;
	}


--></style>

 <table width="930" height="61" border="0" align="center" cellpadding="0" cellspacing="0" class="STYLE1">
  <tr>
    <td height="20" style="background-image:url(images/panel-bg.gif)"><font size="2" color="#FFFFFF">&nbsp;&nbsp;<%=demo.getLang("erp","友情链接")%></font></td>
	<td height="20" style="background-image:url(images/panel-bg.gif)" width="63%"><a href="link/register.jsp"><font size="2" color="#FFFFFF"><%=demo.getLang("erp","我要申请")%></font></a></td>
	<td height="20" style="background-image:url(images/panel-bg.gif)" width="20%"><font size="2" color="#000000">&nbsp;</font></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" colspan="3"><img src="images/list1.jpg" width="930" height="5"></td>
  </tr>
  <tr>
    <td colspan="3" bgcolor="#FFFFFF">
<%
nseer_db db_bottom = new nseer_db("ondemand1");
String sql_bottom="select topic,url from ecommerce_link where check_tag='1'";
ResultSet rs_bottom=db_bottom.executeQuery(sql_bottom);
while(rs_bottom.next()){
String url=rs_bottom.getString("url");
if(url.indexOf("http://")==-1) url="http://"+rs_bottom.getString("url");
%>
	<a href="<%=url%>" target="_blank"><font size="2" color="#000000"><%=exchange.toHtml(rs_bottom.getString("topic"))%></font></a>&nbsp;&nbsp;
<%}
db_bottom.close();
%>
	</td>
  </tr>
   <tr>
    <td bgcolor="#ffffff" colspan="3"><img src="images/list1.jpg" width="930" height="5"></td>
  </tr>
</table>
<table width="930" height="26" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="26" bgcolor="#D1D5DA" class="STYLE4" align="center">
      <table width="930" border="0" cellpadding="0" cellspacing="0" align="center">
<%
circle=(cols_bottom.length+12)/13;
m=0;
for(int xx=0;xx<circle;xx++){
%>
          <tr>
<%
	for(int yy=0;yy<15;yy++){
		if(m<cols_bottom.length){
String[] record2=tb.getTable("ondemand1","nseer",cols_bottom[m]);
if(record2[3].equals("common")||record2[3].equals("other")){
%>
            <td width="90" class="STYLE1" align="right"><font size="2" color="#00499A"><a href="<%=record2[3]%>/index.jsp?column=<%=toUtf8String.utf8String(exchange.toURL(cols_bottom[m]))%>"><%=exchange.toHtml(cols_bottom[m])%></a></font></td>
<%}else if(record2[3].equals("../home/login.jsp")){%>
			<td width="90" class="STYLE1" align="right"><font size="2" color="#00499A"><a href="<%=record2[3]%>"><%=exchange.toHtml(cols_bottom[m])%></a></font></td>
<%}else{%>
			<td width="90" class="STYLE1" align="right"><font size="2" color="#00499A"><a href="<%=record2[3]%>/index.jsp"><%=exchange.toHtml(cols_bottom[m])%></a></font></td>
<%}
}else{%>
            <td width="90" class="STYLE1">&nbsp;</td>
<%}
m++;
}%>
		  </tr>
<%}

%>
      </table>
    </td>
  </tr>
</table>
<table width="930" height="70" border="0" align="center" cellpadding="0" cellspacing="0">
 <tr>
    <td height="70"><div align="center" valign="top" class="STYLE1"><%=wb.getCopyright()%></div></td>
  </tr>
</table>
</body>
</html>