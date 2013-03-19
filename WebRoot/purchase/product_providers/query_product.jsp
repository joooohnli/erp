<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,include.nseerdb.*,java.text.*"%>
<%nseer_db purchase_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db purchasedb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<%
String product_ID=request.getParameter("product_ID") ;
try{
String sql="select * from purchase_product_providers_recommend where product_ID='"+product_ID+"' and check_tag='1'";
ResultSet rs=purchase_db.executeQuery(sql);
if(rs.next()){
String checker=rs.getString("checker");
String check_time=rs.getString("check_time");
String recommend_describe=rs.getString("recommend_describe");
String check_tag="";
String provider_recommend_tag=demo.getLang("erp","等待");
String color="#FF9A31";
String color1="#FF9A31";
if(rs.getString("check_tag").equals("0")){
check_tag=demo.getLang("erp","等待");
}else if(rs.getString("check_tag").equals("1")){
check_tag=demo.getLang("erp","通过");
color1="mediumseagreen";
}
else if(rs.getString("check_tag").equals("9")){
check_tag=demo.getLang("erp","未通过");
color1="red";
}
if((rs.getString("check_tag").equals("0")||rs.getString("check_tag").equals("9"))&&rs.getString("change_tag").equals("0")){
provider_recommend_tag=demo.getLang("erp","等待");
}else if(rs.getString("check_tag").equals("0")&&rs.getString("change_tag").equals("1")){
provider_recommend_tag=demo.getLang("erp","执行");
color="mediumseagreen";
}else if(rs.getString("check_tag").equals("1")&&rs.getString("change_tag").equals("0")){
provider_recommend_tag=demo.getLang("erp","完成");
color="3333FF";
}
%>
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","打印")%>" onClick="javascript:winopen('query_print.jsp?product_providers_recommend_ID=<%=rs.getString("product_providers_recommend_ID")%>')">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></td>
 </tr>
</table>
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","配置单编号")%>：<font color="<%=color%>"><%=rs.getString("product_providers_recommend_ID")%><%=provider_recommend_tag%></font> <%=demo.getLang("erp","其中审核状态")%>：<font color="<%=color1%>"><%=check_tag%></font></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","供应商推荐单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","产品编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=rs.getString("product_ID")%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","产品名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("product_name"))%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1"> 
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","推荐人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="89%" colspan="3"><%=exchange.toHtml(rs.getString("recommender"))%>&nbsp;</td>
 </tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>  
<table <%=TABLE_STYLE5%> class="TABLE_STYLE5">
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td width="5%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","序号")%></td>
	 <td width="13%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","供应商编号")%> </td>
 <td width="11%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","供应商名称")%> </td>
 <td width="8%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","所在区域")%></td>
 <td width="8%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","优质级别")%></td>
	 <td width="11%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","电话")%></td>
 <td width="8%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","联系人")%></td>
	 <td width="13%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","网址")%></td>
	</tr>
<%
String sql6="select * from purchase_product_providers_recommend_details where product_providers_recommend_ID='"+rs.getString("product_providers_recommend_ID")+"' order by details_number";
ResultSet rs6=purchase_db.executeQuery(sql6);
while(rs6.next()){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("details_number")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("provider_ID")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("provider_name"))%>&nbsp;</td>
<%
String sql7="select * from purchase_file where provider_ID='"+rs6.getString("provider_ID")+"'";
ResultSet rs7=purchasedb.executeQuery(sql7);
while(rs7.next()){	
%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs7.getString("type"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs7.getString("provider_class"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs7.getString("provider_tel1"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs7.getString("contact_person1"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs7.getString("provider_web"))%>&nbsp;</td>
 </tr>
<%
}
	}
%>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","审核人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(checker)%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","审核时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(check_time)%>&nbsp;</td>
 </tr>
	 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","推荐要求")%>：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="89%" colspan="3"><%=recommend_describe%>&nbsp;</td>
 </tr>
   </table>
<%@include file="../include/paper_bottom.html"%>
</div>
<%
}else{
	%>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","该产品尚未推荐供应商，请返回！")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
</table>
</div>
	<%
}
	purchase_db.close();
	purchasedb.close();
	}
catch (Exception ex){
out.println("error"+ex);
}
%>
</table>