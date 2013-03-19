<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="java.text.*"%>
<html>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<%
	 demo.setPath(request);
	 String language=request.getParameter("language");
	 if(language==null) language="chinese";
	 session.setAttribute("language",language);
%>
<%@include file="head.jsp"%>

 <center>
 <table cellpadding="2" width="650" height="10">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td height="60"></td>
 </tr>
 </table>
 </center>
</div>

 <center>
 <table width="650" cellpadding="2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <p align="center"><b><font color="#800000" size="3"><%=demo.getLang("erp","恩信科技ERP系统使用单位注册")%></b></td>
 </tr>
 </table>
 </center>
</div>
<DIV align="right">
 <TABLE cellpadding="2" width="90%" id="AutoNumber3">
	
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td width="100%" height="455">
 <DIV align="center">
 对不起，注册单位额度已满。清联系系统管理员。
   </div>
 </td>
  </tr>
  </table>
 </div>
 </td>
  </table> </DIV>
 <DIV>
 <center>
  <table width="650" align="center" cellpadding="0" cellspacing="0">
   <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td align="center"><input type="button" name="Submit" value="<%=demo.getLang("erp","返回")%>" onClick=location="login.jsp"></td>
   </tr>
  </table>
 </CENTER>
 </div>
<%@include file="foot.htm"%>
</html>
