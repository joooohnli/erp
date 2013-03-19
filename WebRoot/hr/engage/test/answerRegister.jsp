<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="java.text.*" import ="include.nseer_db.*,include.nseer_db.*,java.text.*,include.nseer_cookie.exchange"%>
<%nseer_db hr_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%counter count=new counter(application);%>
<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<script language="javascript" src="../../../javascript/ajax/ajax-validation-f.js"></script>
<script type="text/javascript" src="../../../javascript/calendar/cal.js"></script>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<form id="mutiValidation" class="x-form" method="GET" action="answerRegister_getpara.jsp" onSubmit="return doValidate('../../../xml/hr/hr_tester.xml','mutiValidation')">
<script language="javascript">
 var onecount2;
 subcat2 = new Array();
 <% int p=0;
 String sql8="select * from hr_config_major_second_kind where second_kind_name!='' order by first_kind_ID,second_kind_ID";
 ResultSet rs8=hr_db.executeQuery(sql8); 
 while(rs8.next()) {%> 
 subcat2[<%=p++%>] = new 
 Array("<%=rs8.getString("id")%>","<%=rs8.getString("second_kind_ID")%>/<%=rs8.getString("second_kind_name")%>","<%=rs8.getString("first_kind_ID")%>/<%=rs8.getString("first_kind_name")%>");
 <%
	 }
 %>  
 onecount2=<%=p%>; 
 function changelocation2(locationid)
  {
  mutiValidation.select5.length = 0;  
  var locid=locationid;
  var p;
  mutiValidation.select5.options[mutiValidation.select5.length]=new Option("",""); 
  for (p=0;p < onecount2; p++)
  {
 		 if(locid==""||locid==null){mutiValidation.select5.options[mutiValidation.select5.length]=
 			 new Option(subcat2[p][1],subcat2[p][1]);}//如果select1为空，则select5选择全部值
  else if (subcat2[p][2] == locid)
  { 
   mutiValidation.select5.options[mutiValidation.select5.length] = new Option(subcat2[p][1], 
 subcat2[p][1]);
  } 
  } 
 }
</script>
<script type="text/javascript" src="../../../dwr/engine.js"></script>
<script type="text/javascript" src="../../../dwr/util.js"></script>
<script type="text/javascript" src="../../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../../dwr/interface/validateV7.js"></script>
<script type="text/javascript" src="../../../javascript/include/validate/validation-framework.js"></script>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>" name="B1"> <input type="reset" <%=RESET_STYLE1%> class="RESET_STYLE1" value="<%=demo.getLang("erp","清除")%>"></div>
 </td>
 </tr>
 </table>
 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" width="100%" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","姓名")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="37.4%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="human_name" style="width:42%"></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","身份证号码")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="37.4%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="idcard" style="width:42%"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","职位分类")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="37.4%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="select4" style="width: 130;" 
onChange="changelocation2(mutiValidation.select4.options[mutiValidation.select4.selectedIndex].value)">
 <option value="">&nbsp;</option>
<%
  String sql4 = "select * from hr_config_major_first_kind order by first_kind_ID" ;
	 ResultSet rs4 = hr_db.executeQuery(sql4) ;
while(rs4.next()){%>
		<option value="<%=rs4.getString("first_kind_ID")%>/<%=exchange.toHtml(rs4.getString("first_kind_name"))%>"><%=rs4.getString("first_kind_ID")%>/<%=exchange.toHtml(rs4.getString("first_kind_name"))%></option>
<%
}
%>
  </select></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","职位名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="37.4%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="select5" style="width: 130;"><script language = "JavaScript">
	//if (mutiValidation.select1.value){ 如果select1没做出选择时，想让select2的值为空，则加上这个条件
	 changelocation2(mutiValidation.select4.value)
 //}
 </script>
 </select></td>
 </tr>
</table>
</form>
</div>