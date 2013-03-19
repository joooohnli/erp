<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import ="include.nseer_db.*,java.sql.*" import="java.util.*" import="java.io.*" %>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<%
	 demo.setPath(request);
	 String language=request.getParameter("language");
	 if(language==null) language="chinese";
	 session.setAttribute("language",language);
%>
<html>
<%@include file="head.jsp"%>
<%nseer_db erp_db = new nseer_db("mysql");%>
　

 <center>
 <table width="650" cellpadding="2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <p align="center"></td>
 </tr>
 </table>
 </center>
</div>
<%
String name = request.getParameter("name") ;
try{ 
	String sql="select * from unit_info where unit_id='"+name+"'";
	ResultSet rset=erp_db.executeQuery(sql) ;
if(rset.next()){
%>

 <center>
 <table width="650">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td colspan="3">
  <p align="center"><font size="2"><%=demo.getLang("erp","对不起，单位简称重名，请重试！")%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td width="15%"></td>
 <td width="30%"></td>
 <td width="55%"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td width="15%"></td>
 <td width="30%"></td>
 <td width="55%"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td width="15%"></td>
 <td width="30%"></td>
 <td width="55%"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td colspan="3">　
  <p align="center"><input type="button" value="<%=demo.getLang("erp","关闭窗口")%>" onClick="window.close()"></td>
 </tr>
 </table>
 </center>
</div>
<%}else{%>

 <center>
 <table width="650">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td colspan="3">
  <p align="center"><font size="2"><%=demo.getLang("erp","恭喜您，单位简称可用，请继续注册！")%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td width="15%"></td>
 <td width="30%"></td>
 <td width="55%"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td width="15%"></td>
 <td width="30%"></td>
 <td width="55%"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td width="15%"></td>
 <td width="30%"></td>
 <td width="55%"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td colspan="3">　
  <p align="center"><input type="button" value="<%=demo.getLang("erp","关闭窗口")%>" onClick="window.close()"></td>
 </tr>
 </table>
 </center>
</div>
<%
}
erp_db.close();
}
catch (Exception ex){
out.println("error"+ex);
}
%>
　
　
　
　
　
　
　
　
　
　
　
<%@include file="foot.htm"%>
</body>
</html>