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
<%nseer_db hr_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="getAmount" class="hr.getAvailable" scope="request"/>
<%@include file="../../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<link rel="stylesheet" type="text/css" media="all" href="../../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../../javascript/calendar/cal.js"></script>
<script type="text/javascript" src="../../../dwr/engine.js"></script>
<script type="text/javascript" src="../../../dwr/util.js"></script>
<script type="text/javascript" src="../../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../../dwr/interface/validateV7.js"></script>
<script type="text/javascript" src="../../../javascript/include/validate/validation-framework.js"></script>
<form id="mutiValidation" method="POST" action="../../../hr_engage_test_questionesRegister_ok" onSubmit="return doValidate('../../../xml/hr/hr_test.xml','mutiValidation')">
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>" name="B1"> <input type="reset" <%=RESET_STYLE1%> class="RESET_STYLE1" value="<%=demo.getLang("erp","清除")%>"></div></td>
 </tr>
</table>
<%
String register=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
String time=formatter.format(now);
String first_kind_ID=request.getParameter("first_kind_ID");
String second_kind_ID=request.getParameter("second_kind_ID");
String first_kind_name=exchange.unURL(request.getParameter("first_kind_name"));
String second_kind_name=exchange.unURL(request.getParameter("second_kind_name"));
%>
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
<div id="nseerGround" class="nseerGround">
<%@include file="../../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","考试出题")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
 <table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","职位分类")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="select4" 
onChange="changelocation2(mutiValidation.select4.options[mutiValidation.select4.selectedIndex].value)">
<%
  String sql4 = "select * from hr_config_major_first_kind order by first_kind_ID" ;
	 ResultSet rs4 = hr_db.executeQuery(sql4) ;
while(rs4.next()){
	if(first_kind_ID.equals(rs4.getString("first_kind_ID"))){
	%>
		<option value="<%=rs4.getString("first_kind_ID")%>/<%=exchange.toHtml(rs4.getString("first_kind_name"))%>" selected><%=rs4.getString("first_kind_ID")%>/<%=exchange.toHtml(rs4.getString("first_kind_name"))%></option>
<%}else{%>
		<option value="<%=rs4.getString("first_kind_ID")%>/<%=exchange.toHtml(rs4.getString("first_kind_name"))%>"><%=rs4.getString("first_kind_ID")%>/<%=exchange.toHtml(rs4.getString("first_kind_name"))%></option>
<%
	}
}
%>
  </select></td> 
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","职位名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="select5">
	 <option value="<%=second_kind_ID%>/<%=exchange.toHtml(second_kind_name)%>" selected><%=second_kind_ID%>/<%=exchange.toHtml(second_kind_name)%></option>
	//if (mutiValidation.select1.value){ 如果select1没做出选择时，想让select2的值为空，则加上这个条件
	 changelocation2(mutiValidation.select4.value)
 //}
 </select></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register" value="<%=exchange.toHtml(register)%>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input name="register_time" type="hidden" value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","答题限时(分钟)")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="89%" colspan="3"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="test_limited_time" style="width:42%"></td>	 
 </tr>
<%
	 int j=1;
	 int n=0;
 String sqla="select * from hr_config_question_first_kind";
 ResultSet rsa=hr_db.executeQuery(sqla); 
 while(rsa.next()) {
  String sqll1 = "select * from hr_config_question_second_kind where first_kind_ID='"+rsa.getString("first_kind_ID")+"' and second_kind_name!='' order by id" ;
	 ResultSet rss1 = hr_db1.executeQuery(sqll1) ;
				if(rss1.last()){
				int countRow=rss1.getRow();

				rss1.first();
%>
<table <%=TABLE_STYLE5%> class="TABLE_STYLE5" <%if(n!=0){%>style="border-top:0px"<%}%>>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="9%"><%=rsa.getString("first_kind_name")%><input name="kind<%=j%>" type="hidden" value="<%=rsa.getString("first_kind_name")%>"></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="87%"> 

 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6" style="width:100%"  <%if(n!=0){%>style="border-top:0px"<%}%>>
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="30%"><%=demo.getLang("erp","试题II级分类名称")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="20%"><%=demo.getLang("erp","可用试题数量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="20%"><%=demo.getLang("erp","出题数量")%></td>
 </tr>
<%for(int k=1;k<=countRow;k++){%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rss1.getString("second_kind_name"))%>
 <input name="<%="group"+j+k%>" type="hidden" value="<%=exchange.toHtml(rss1.getString("second_kind_name"))%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="<%="amounta"+j+k%>" type="hidden" value="<%=getAmount.available((String)session.getAttribute("unit_db_name"),rsa.getString("first_kind_name"),rss1.getString("second_kind_name"))%>"><%=getAmount.available((String)session.getAttribute("unit_db_name"),rsa.getString("first_kind_name"),rss1.getString("second_kind_name"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="<%="amount"+j+k%>"></td>
  </tr>
<input name="group_amount<%=j%>" type="hidden" value="<%=countRow%>">
<%
	 
rss1.next();
}
j++;
%>
 </table>
 </td>
 </tr>
</table>
<%n++;
}
	 }
hr_db1.close();
hr_db.close();
%>
<%@include file="../../include/paper_bottom.html"%>
</div>
<input name="kind_amount" type="hidden" value="<%=j-1%>">
</form>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>