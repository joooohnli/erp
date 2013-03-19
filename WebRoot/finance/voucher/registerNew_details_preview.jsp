<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<%counter count=new counter(application);%>
<%@include file="../include/head.jsp"%>

<%nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>

<head>

<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>

<script language="javascript">
 var onecount;
 subcat = new Array();
 <% int i=0;
 String sqlb1="select * from finance_config_file_second_kind where second_kind_name!='' order by first_kind_ID,second_kind_ID";
 ResultSet rsb1=finance_db.executeQuery(sqlb1); 
 while(rsb1.next()) {%> 
 subcat[<%=i++%>] = new 
 Array("<%=rsb1.getString("id")%>","<%=rsb1.getString("second_kind_ID")%>/<%=rsb1.getString("second_kind_name")%>","<%=rsb1.getString("first_kind_ID")%>/<%=rsb1.getString("first_kind_name")%>");
 <%
	 }
 %> 
 
 onecount=<%=i%>;
 
 function changelocation_b1(locationid)
  {
  mutiValidation.selectb2.length = 0; 
 
  var locid=locationid;
  var i;
  mutiValidation.selectb2.options[mutiValidation.selectb2.length]=new Option("",""); 
  for (i=0;i < onecount; i++)
  {
 		 if(locid==""||locid==null){mutiValidation.selectb2.options[mutiValidation.selectb2.length]=
 			 new Option(subcat[i][1],subcat[i][1]);}//如果select1为空，则selectb2选择全部值
  else if (subcat[i][2] == locid)
  { 
   mutiValidation.selectb2.options[mutiValidation.selectb2.length] = new Option(subcat[i][1], 
 subcat[i][1]);
  } 
  } 
 }



 var onecount1;
 subcat1 = new Array();
 <% int j=0;
 String sqlb2="select * from finance_config_file_third_kind where third_kind_name!='' order by first_kind_ID,second_kind_ID,third_kind_ID";
 ResultSet rsb2=finance_db.executeQuery(sqlb2); 
 while(rsb2.next()) {%> 
 subcat1[<%=j++%>] = new Array("<%=rsb2.getString("id")%>","<%=rsb2.getString("third_kind_ID")%>/<%=rsb2.getString("third_kind_name")%>","<%=rsb2.getString("second_kind_ID")%>/<%=rsb2.getString("second_kind_name")%>");
 <%
	 }
 %> 
 
 onecount1=<%=j%>;
 
 function changelocation1_b2(locationid1)
  {
  mutiValidation.selectb3.length = 0; 
 
  var locid1=locationid1;
  var j;
  mutiValidation.selectb3.options[mutiValidation.selectb3.length]=new Option("",""); 
  for (j=0;j < onecount1; j++)
  {
 		 if(locid1==""||locid1==null)
 		 {mutiValidation.selectb3.options[mutiValidation.selectb3.length]=new Option(subcat1[j][1],subcat1[j][1]);}
  else if (subcat1[j][2] == locid1){ 
   mutiValidation.selectb3.options[mutiValidation.selectb3.length] = new Option(subcat1[j][1],subcat1[j][1]);
  } 
  } 
 }

 

</script>

<script language="javascript">
 var onecount;
 subcat = new Array();
 <% int ii=0;
 String sqlc1="select * from finance_config_file_second_kind where second_kind_name!='' order by first_kind_ID,second_kind_ID";
 ResultSet rsc1=finance_db.executeQuery(sqlc1); 
 while(rsc1.next()) {%> 
 subcat[<%=ii++%>] = new 
 Array("<%=rsc1.getString("id")%>","<%=rsc1.getString("second_kind_ID")%>/<%=rsc1.getString("second_kind_name")%>","<%=rsc1.getString("first_kind_ID")%>/<%=rsc1.getString("first_kind_name")%>");
 <%
	 }
 %> 
 
 onecount=<%=ii%>;
 
 function changelocation_c1(locationid)
  {
  mutiValidation.selectc2.length = 0; 
 
  var locid=locationid;
  var ii;
  mutiValidation.selectc2.options[mutiValidation.selectc2.length]=new Option("",""); 
  for (i=0;i < onecount; i++)
  {
 		 if(locid==""||locid==null){mutiValidation.selectc2.options[mutiValidation.selectc2.length]=
 			 new Option(subcat[i][1],subcat[i][1]);}//如果select1为空，则selectc2选择全部值
  else if (subcat[i][2] == locid)
  { 
   mutiValidation.selectc2.options[mutiValidation.selectc2.length] = new Option(subcat[i][1], 
 subcat[i][1]);
  } 
  } 
 }



 var onecount1;
 subcat1 = new Array();
 <% int jj=0;
 String sqlc2="select * from finance_config_file_third_kind where third_kind_name!='' order by first_kind_ID,second_kind_ID,third_kind_ID";
 ResultSet rsc2=finance_db.executeQuery(sqlc2); 
 while(rsc2.next()) {%> 
 subcat1[<%=jj++%>] = new Array("<%=rsc2.getString("id")%>","<%=rsc2.getString("third_kind_ID")%>/<%=rsc2.getString("third_kind_name")%>","<%=rsc2.getString("second_kind_ID")%>/<%=rsc2.getString("second_kind_name")%>");
 <%
	 }
 %> 
 
 onecount1=<%=jj%>;
 
 function changelocation1_c2(locationid1)
  {
  mutiValidation.selectc3.length = 0; 
 
  var locid1=locationid1;
  var jj;
  mutiValidation.selectc3.options[mutiValidation.selectc3.length]=new Option("",""); 
  for (j=0;j < onecount1; j++)
  {
 		 if(locid1==""||locid1==null)
 		 {mutiValidation.selectc3.options[mutiValidation.selectc3.length]=new Option(subcat1[j][1],subcat1[j][1]);}
  else if (subcat1[j][2] == locid1){ 
   mutiValidation.selectc3.options[mutiValidation.selectc3.length] = new Option(subcat1[j][1],subcat1[j][1]);
  } 
  } 
 }

 

</script>

<script language="javascript">
 var onecount;
 subcat = new Array();
 <% int iii=0;
 String sqld1="select * from finance_config_file_second_kind where second_kind_name!='' order by first_kind_ID,second_kind_ID";
 ResultSet rsd1=finance_db.executeQuery(sqld1); 
 while(rsd1.next()) {%> 
 subcat[<%=iii++%>] = new 
 Array("<%=rsd1.getString("id")%>","<%=rsd1.getString("second_kind_ID")%>/<%=rsd1.getString("second_kind_name")%>","<%=rsd1.getString("first_kind_ID")%>/<%=rsd1.getString("first_kind_name")%>");
 <%
	 }
 %> 
 
 onecount=<%=iii%>;
 
 function changelocation_d1(locationid)
  {
  mutiValidation.selectd2.length = 0; 
 
  var locid=locationid;
  var iii;
  mutiValidation.selectd2.options[mutiValidation.selectd2.length]=new Option("",""); 
  for (i=0;i < onecount; i++)
  {
 		 if(locid==""||locid==null){mutiValidation.selectd2.options[mutiValidation.selectd2.length]=
 			 new Option(subcat[i][1],subcat[i][1]);}//如果select1为空，则selectd2选择全部值
  else if (subcat[i][2] == locid)
  { 
   mutiValidation.selectd2.options[mutiValidation.selectd2.length] = new Option(subcat[i][1], 
 subcat[i][1]);
  } 
  } 
 }

 var onecount1;
 subcat1 = new Array();
 <% int jjj=0;
 String sqld2="select * from finance_config_file_third_kind where third_kind_name!='' order by first_kind_ID,second_kind_ID,third_kind_ID";
 ResultSet rsd2=finance_db.executeQuery(sqld2); 
 while(rsd2.next()) {%> 
 subcat1[<%=jjj++%>] = new Array("<%=rsd2.getString("id")%>","<%=rsd2.getString("third_kind_ID")%>/<%=rsd2.getString("third_kind_name")%>","<%=rsd2.getString("second_kind_ID")%>/<%=rsd2.getString("second_kind_name")%>");
 <%
	 }
 %> 
 
 onecount1=<%=jjj%>;
 
 function changelocation1_d2(locationid1)
  {
  mutiValidation.selectd3.length = 0; 
 
  var locid1=locationid1;
  var jjj;
  mutiValidation.selectd3.options[mutiValidation.selectd3.length]=new Option("",""); 
  for (j=0;j < onecount1; j++)
  {
 		 if(locid1==""||locid1==null)
 		 {mutiValidation.selectd3.options[mutiValidation.selectd3.length]=new Option(subcat1[j][1],subcat1[j][1]);}
  else if (subcat1[j][2] == locid1){ 
   mutiValidation.selectd3.options[mutiValidation.selectd3.length] = new Option(subcat1[j][1],subcat1[j][1]);
  } 
  } 
 }
</script>
<script language="javascript">
 var onecount;
 subcat = new Array();
 <% int iiii=0;
 String sqle1="select * from finance_config_file_second_kind where second_kind_name!='' order by first_kind_ID,second_kind_ID";
 ResultSet rse1=finance_db.executeQuery(sqle1); 
 while(rse1.next()) {%> 
 subcat[<%=iiii++%>] = new 
 Array("<%=rse1.getString("id")%>","<%=rse1.getString("second_kind_ID")%>/<%=rse1.getString("second_kind_name")%>","<%=rse1.getString("first_kind_ID")%>/<%=rse1.getString("first_kind_name")%>");
 <%
	 }
 %> 
 
 onecount=<%=iiii%>;
 
 function changelocation_e1(locationid)
  {
  mutiValidation.selecte2.length = 0; 
 
  var locid=locationid;
  var iiii;
  mutiValidation.selecte2.options[mutiValidation.selecte2.length]=new Option("",""); 
  for (i=0;i < onecount; i++)
  {
 		 if(locid==""||locid==null){mutiValidation.selecte2.options[mutiValidation.selecte2.length]=
 			 new Option(subcat[i][1],subcat[i][1]);}//如果select1为空，则selecte2选择全部值
  else if (subcat[i][2] == locid)
  { 
   mutiValidation.selecte2.options[mutiValidation.selecte2.length] = new Option(subcat[i][1], 
 subcat[i][1]);
  } 
  } 
 }

 var onecount1;
 subcat1 = new Array();
 <% int jjjj=0;
 String sqle2="select * from finance_config_file_third_kind where third_kind_name!='' order by first_kind_ID,second_kind_ID,third_kind_ID";
 ResultSet rse2=finance_db.executeQuery(sqle2); 
 while(rse2.next()) {%> 
 subcat1[<%=jjjj++%>] = new Array("<%=rse2.getString("id")%>","<%=rse2.getString("third_kind_ID")%>/<%=rse2.getString("third_kind_name")%>","<%=rse2.getString("second_kind_ID")%>/<%=rse2.getString("second_kind_name")%>");
 <%
	 }
 %> 
 
 onecount1=<%=jjjj%>;
 
 function changelocation1_e2(locationid1)
  {
  mutiValidation.selecte3.length = 0; 
 
  var locid1=locationid1;
  var jjjj;
  mutiValidation.selecte3.options[mutiValidation.selecte3.length]=new Option("",""); 
  for (j=0;j < onecount1; j++)
  {
 		 if(locid1==""||locid1==null)
 		 {mutiValidation.selecte3.options[mutiValidation.selecte3.length]=new Option(subcat1[j][1],subcat1[j][1]);}
  else if (subcat1[j][2] == locid1){ 
   mutiValidation.selecte3.options[mutiValidation.selecte3.length] = new Option(subcat1[j][1],subcat1[j][1]);
  } 
  } 
 }
</script>
<script language="javascript">
 var onecount;
 subcat = new Array();
 <% int iiiii=0;
 String sqlf1="select * from finance_config_file_second_kind where second_kind_name!='' order by first_kind_ID,second_kind_ID";
 ResultSet rsf1=finance_db.executeQuery(sqlf1); 
 while(rsf1.next()) {%> 
 subcat[<%=iiiii++%>] = new 
 Array("<%=rsf1.getString("id")%>","<%=rsf1.getString("second_kind_ID")%>/<%=rsf1.getString("second_kind_name")%>","<%=rsf1.getString("first_kind_ID")%>/<%=rsf1.getString("first_kind_name")%>");
 <%
	 }
 %> 
 
 onecount=<%=iiiii%>;
 
 function changelocation_f1(locationid)
  {
  mutiValidation.selectf2.length = 0; 
 
  var locid=locationid;
  var iiiii;
  mutiValidation.selectf2.options[mutiValidation.selectf2.length]=new Option("",""); 
  for (i=0;i < onecount; i++)
  {
 		 if(locid==""||locid==null){mutiValidation.selectf2.options[mutiValidation.selectf2.length]=
 			 new Option(subcat[i][1],subcat[i][1]);}//如果select1为空，则selectf2选择全部值
  else if (subcat[i][2] == locid)
  { 
   mutiValidation.selectf2.options[mutiValidation.selectf2.length] = new Option(subcat[i][1], 
 subcat[i][1]);
  } 
  } 
 }
 var onecount1;
 subcat1 = new Array();
 <% int jjjjj=0;
 String sqlf2="select * from finance_config_file_third_kind where third_kind_name!='' order by first_kind_ID,second_kind_ID,third_kind_ID";
 ResultSet rsf2=finance_db.executeQuery(sqlf2); 
 while(rsf2.next()) {%> 
 subcat1[<%=jjjjj++%>] = new Array("<%=rsf2.getString("id")%>","<%=rsf2.getString("third_kind_ID")%>/<%=rsf2.getString("third_kind_name")%>","<%=rsf2.getString("second_kind_ID")%>/<%=rsf2.getString("second_kind_name")%>");
 <%
	 }
 %> 
 
 onecount1=<%=jjjjj%>;
 
 function changelocation1_f2(locationid1)
  {
  mutiValidation.selectf3.length = 0; 
 
  var locid1=locationid1;
  var jjjjj;
  mutiValidation.selectf3.options[mutiValidation.selectf3.length]=new Option("",""); 
  for (j=0;j < onecount1; j++)
  {
 		 if(locid1==""||locid1==null)
 		 {mutiValidation.selectf3.options[mutiValidation.selectf3.length]=new Option(subcat1[j][1],subcat1[j][1]);}
  else if (subcat1[j][2] == locid1){ 
   mutiValidation.selectf3.options[mutiValidation.selectf3.length] = new Option(subcat1[j][1],subcat1[j][1]);
  } 
  } 
 }
</script>

</head>
<form id="mutiValidation" method="POST" action="registerNew_details_preview_ok.jsp">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"> 
 <input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确认")%>"></div>
 </td>
 </tr>
 </table>
 
<%
String voucher_in_month_ID=request.getParameter("voucher_in_month_ID");
String voucher_ID=request.getParameter("voucher_ID");
String sqq1="select * from finance_voucher where voucher_in_month_ID='"+voucher_in_month_ID+"'";
ResultSet rsq1=finance_db.executeQuery(sqq1);
if(rsq1.next()){
%>
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" width="100%" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","凭证号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rsq1.getString("voucher_in_month_ID")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","附件数量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rsq1.getString("attachment_amount")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","制单")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=exchange.toHtml(rsq1.getString("register"))%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","时间")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3" width="18%"><%=exchange.toHtml(rsq1.getString("register_time"))%></td> 
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" colspan="2" width="24%"><%=demo.getLang("erp","摘要")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","I级科目")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="13%"><%=demo.getLang("erp","II级科目")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","III级科目")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="13%"><%=demo.getLang("erp","借方金额")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","贷方金额")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="5%"><%=demo.getLang("erp","数量")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","附件号码")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="5%"><%=demo.getLang("erp","删除")%></td>
 </tr>
<%
}
String sqq2="select * from finance_voucher_details where voucher_ID='"+voucher_ID+"'";
ResultSet rsq2=finance_db.executeQuery(sqq2);
while(rsq2.next()){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="2" width="24%"><%=exchange.toHtml(rsq2.getString("summary_content"))%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=rsq2.getString("first_kind_ID")%>/<%=exchange.toHtml(rsq2.getString("first_kind_name"))%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rsq2.getString("second_kind_ID")%>/<%=exchange.toHtml(rsq2.getString("second_kind_name"))%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=rsq2.getString("third_kind_ID")%>/<%=exchange.toHtml(rsq2.getString("third_kind_name"))%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rsq2.getString("debit_subtotal")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=rsq2.getString("loan_subtotal")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="5%"><%=rsq2.getString("product_amount")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="8%"><%=rsq2.getString("attachment_ID")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="5%"><a href="registerNew_details_delete.jsp?id=<%=rsq2.getString("id")%>"><%=demo.getLang("erp","删除")%></td>
 </tr>
<%}%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="2" width="24%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="summary_content1">

	 <option value="">&nbsp;</option>
  <%
  String sql1 = "select * from finance_config_summary_second_kind order by id" ;
	 ResultSet rs1 = finance_db.executeQuery(sql1) ;
while(rs1.next()){%>
		<option value="<%=exchange.toHtml(rs1.getString("second_kind_name"))%>"><%=exchange.toHtml(rs1.getString("second_kind_name"))%></option>
<%
}
%>

 </select></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="selectb1" 
onChange="changelocation_b1(mutiValidation.selectb1.options[mutiValidation.selectb1.selectedIndex].value)">
 <option value="">&nbsp;</option>
<%
  String sqla1 = "select * from finance_config_file_first_kind order by first_kind_ID" ;
	 ResultSet rsa1 = finance_db.executeQuery(sqla1) ;
while(rsa1.next()){%>
		<option value="<%=rsa1.getString("first_kind_ID")%>/<%=exchange.toHtml(rsa1.getString("first_kind_name"))%>"><%=rsa1.getString("first_kind_ID")%>/<%=exchange.toHtml(rsa1.getString("first_kind_name"))%></option>
<%
}
%>

  </select></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="selectb2" onChange="changelocation1_b2(mutiValidation.selectb2.options[mutiValidation.selectb2.selectedIndex].value)"><script language = "JavaScript">
	//if (mutiValidation.selectb1.value){ 如果selectb1没做出选择时，想让selectb2的值为空，则加上这个条件
	 changelocation_b1(mutiValidation.selectb1.value)
 //}
 </script>
 </select></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="selectb3"><script language = "JavaScript">
	//if (mutiValidation.selectb2.value){ 如果selectb2没做出选择时，想让selectb3的值为空，则加上这个条件
	 changelocation1_b2(mutiValidation.selectb2.value)
 //}
 </script>
 </select></td>
	 
 
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="debit_subtotal1" style="width:100%"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="loan_subtotal1" style="width:100%"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="5%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="product_amount1" style="width:100%"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="8%"><input type="text" <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="attachment_ID1" style="width:100%"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="5%">&nbsp;</td>
 </tr>
</table>

<%finance_db.close();%>
</form>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>