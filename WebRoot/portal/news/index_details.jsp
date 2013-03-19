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
 <%@include file="../top.jsp"%>
 <%@include file="../include/head.jsp"%>
 <% nseer_db db = new nseer_db("ondemand1");%>
 <table width="930" height="500" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <tr>
    <td width="200" bgcolor="#ebf3fb">&nbsp;</td>
    <td width="600" valign="top">
	<table width="600" border="0">
	<tr>
        <td width="600" class="STYLE1">&nbsp;&nbsp;<%=demo.getLang("erp","首页")%>&gt;&gt;<%=demo.getLang("erp","新闻中心")%></td>
      </tr>
      <tr>
        <td><img src="../images/list.jpg" width="600" height="2" /></td>
      </tr>
<%
String id=request.getParameter("id");
try{
	String sql = "select * from ecommerce_news where id='"+id+"'" ;
	ResultSet rs = db.executeQuery(sql) ;
	if(rs.next()){	
%> 
      <TR>
        <TD>
              <P align="center"><%=exchange.toHtml(rs.getString("topic"))%>[<%=exchange.toHtml(rs.getString("register_time"))%>]</TD>
            </TR>
<%
if(!rs.getString("attachment1").equals("")){	
%>
			<TR>
		<TD align="center" width="700" height="525"><img src="../../ecommerce/file_attachments/<%=exchange.toHtml(rs.getString("attachment1"))%>" ></TR>
<%}
if(!rs.getString("attachment2").equals("")){	
%>
			<TR>
		<TD align="center" width="700" height="525"><img src="../../ecommerce/file_attachments/<%=exchange.toHtml(rs.getString("attachment2"))%>"></TR>
<%}
if(!rs.getString("attachment3").equals("")){	
%>
			<TR>
		<TD align="center" width="700" height="525"><img src="../../ecommerce/file_attachments/<%=exchange.toHtml(rs.getString("attachment3"))%>"></TR>
<%}%>
            <TR>
              <TD width="100%" height="300" valign="top"><P style="line-height: 200%"><%=rs.getString("content")%></TD></TR>


<%
            }
	    db.close();
	    }
	    catch(Exception e){
		out.println("error"+e);
	    }
%>
</table>
</td>
</tr>
</table>
<%@include file="../bottom.jsp"%>
