<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseerdb.*,java.text.*,include.nseer_cookie.*"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db crmdb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<script language="JavaScript">
function newwin(file) {
winopen(file)
}
</script>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<style media=print> 
.Noprint{display:none;} 
.PageNext{page-break-after: always;} 
</style> 
<%
String customer_web="";
String customer_ID=request.getParameter("customer_ID");
try{
	String sql = "select * from crm_file where customer_ID='"+customer_ID+"'" ;
	ResultSet rs = crmdb.executeQuery(sql) ;
	if(rs.next()){
		String lately_trade_time=rs.getString("lately_trade_time");
		if(lately_trade_time.equals("1800-01-01 00:00:00.0")){
			lately_trade_time="没有交易";
		}
		String lately_contact_time=rs.getString("lately_contact_time");
		if(lately_contact_time.equals("1800-01-01 00:00:00.0")){
			lately_contact_time="没有联络";
		}
		String lately_change_time=rs.getString("change_time");
		if(lately_change_time.equals("1800-01-01 00:00:00.0")){
			lately_change_time="没有变更";
		}
		int a=rs.getString("customer_web").indexOf("http://");
	if(a!=-1){
	customer_web=rs.getString("customer_web");
	}else{
	customer_web="http://"+rs.getString("customer_web");
}
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td class="Noprint">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><OBJECT id=WebBrowser classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2 height=0 width=0></OBJECT><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","打印")%> onclick="javascript:window.print()">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","页面设置")%> onclick=document.all.WebBrowser.ExecWB(8,1)>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","打印预览")%> onclick=document.all.WebBrowser.ExecWB(7,1)></div>
 </td>
 </tr>
</table>
 <table <%=TABLE_STYLE7%> class="TABLE_STYLE5" style="width: 100%;">
 <tr style="background-image:url(../../images/line.gif)"><td colspan="4"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","主信息")%></div></td></tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","档案编号")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%" colspan="3"><%=rs.getString("customer_ID")%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","客户名称")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("customer_name"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","地址")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("customer_address"))%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","客户分类")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=rs.getString("chain_id")%>&nbsp;<%=exchange.toHtml(rs.getString("chain_name"))%></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","客户类型")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("type"))%>&nbsp;</td>
</tr>

 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","优质级别")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("customer_class"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","欠款额度")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=rs.getDouble("gather_sum_limit")%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","回款期限")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("gather_period_limit"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","联络期限")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("contact_period_limit"))%>&nbsp;
</tr>
 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","客户曾用名")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("used_customer_name"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","开户银行")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("customer_bank"))%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","银行账号")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("customer_account"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","网址")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(customer_web)%>&nbsp;</td>
 
 </tr>

<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","电话1")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("customer_tel1"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","电话2")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("customer_tel2"))%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","传真")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("customer_fax"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","邮政编码")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("customer_postcode"))%>&nbsp;</td>
</tr>
<tr style="background-image:url(../../images/line.gif)"><td colspan="4"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","联系人信息")%></div></td></tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","第一联系人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("contact_person1"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","部门")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("contact_person1_department"))%>&nbsp;</td>
  </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","职务")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("contact_person1_duty"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","办公电话")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("contact_person1_office_tel"))%>&nbsp;</td>
 
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","手机")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("contact_person1_mobile"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","家庭电话")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("contact_person1_home_tel"))%>&nbsp;</td>
  </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","EMAIL")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("contact_person1_email"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","性别")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("contact_person1_sex"))%>&nbsp; 
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","第二联系人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("contact_person2"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","部门")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("contact_person2_department"))%>&nbsp;</td>
  </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","职务")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("contact_person2_duty"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","办公电话")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("contact_person2_office_tel"))%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","手机")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("contact_person2_mobile"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","家庭电话")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("contact_person2_home_tel"))%>&nbsp;</td>
  </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","EMAIL")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("contact_person2_email"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","性别")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("contact_person2_sex"))%>&nbsp;
 </tr>
 <tr style="background-image:url(../../images/line.gif)"><td colspan="4"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","动态信息")%></div></td></tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE7" width="8%"><%=demo.getLang("erp","开票信息")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" height="65" width="18%"><%=rs.getString("invoice_info")%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE7" width="8%"><%=demo.getLang("erp","最新需求")%> &nbsp; </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" height="65" width="18%"><%=rs.getString("demand")%>&nbsp;
</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","交易次数累计")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2"  width="18%"><a href="javascript:winopen('../order/query_list.jsp?keyword_chain=<%=rs.getString("customer_ID")%>')"><%=exchange.toHtml(rs.getString("trade_amount"))%></a>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","退货次数累计")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2"  width="18%"><a href="javascript:winopen('../order/query_list.jsp?keyword_chain=<%=rs.getString("customer_ID")%>&&return_tag=1')"><%=exchange.toHtml(rs.getString("return_amount"))%></a>&nbsp;</td>
 </tr>

<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","销售额累计")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2"  width="18%"><a href="javascript:winopen('../order/query_list.jsp?keyword_chain=<%=rs.getString("customer_ID")%>')"><%=rs.getDouble("achievement_sum")%></a>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","退货额累计")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2"  width="18%"><a href="javascript:winopen('../order/query_list.jsp?keyword_chain=<%=rs.getString("customer_ID")%>&&return_tag=1')"><%=rs.getDouble("return_sum")%></a>&nbsp;</td>
 </tr>
<%
String[] attachment_name1=DealWithString.divide(rs.getString("attachment_name"),20);
%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","平均回款周期")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2"  width="18%"><%=rs.getDouble("gather_period_average")%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","档案附件")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2"  width="18%"><a href="javascript:winopenm('query_attachment.jsp?id=<%=rs.getString("id")%>&tablename=crm_file&fieldname=attachment_name')">
<%=attachment_name1[1]%></a>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","联络次数累计")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2"  width="18%"><a href="javascript:winopen('../contact/query_list.jsp?keyword_chain=<%=rs.getString("customer_ID")%>')">
 <%=exchange.toHtml(rs.getString("contact_amount"))%></a>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","档案变更累计")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2"  width="18%"><a href="javascript:winopen('change_file_dig.jsp?time=<%=exchange.toURL(rs.getString("lately_change_time"))%>&&customer_ID=<%=rs.getString("customer_ID")%>')">
<%=exchange.toHtml(rs.getString("file_change_amount"))%></a>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE7" width="8%"><%=demo.getLang("erp","备注")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" height="65" width="18%"><%=rs.getString("remark")%>&nbsp;</td>
<td <%=TD_STYLE11%> class="TD_STYLE7" width="8%">&nbsp;</td>
<td <%=TD_STYLE21%> class="TD_STYLE2" height="65" width="18%">&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","最近交易时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><a href="javascript:winopen('../order/query_list.jsp?keyword_chain=<%=rs.getString("customer_ID")%>')"><%=exchange.toHtml(lately_trade_time)%></a>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","最近联络时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><a href="javascript:winopen('../contact/query_list.jsp?keyword_chain=<%=rs.getString("customer_ID")%>')">
<%=exchange.toHtml(lately_contact_time)%></a>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","最近变更时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><a href="javascript:winopen('change_file_dig.jsp?time=<%=exchange.toURL(rs.getString("lately_change_time"))%>&&customer_ID=<%=rs.getString("customer_ID")%>')">
<%=exchange.toHtml(lately_change_time)%></a>&nbsp;</td>
<td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","建档时间")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("register_time"))%>&nbsp;</td>
 
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","销售人员")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("sales_name"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","登记人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("register"))%>&nbsp;</td>
  </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","审核人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("checker"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","审核时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("check_time"))%>&nbsp;</td>
 </tr>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/crm/crm_file.xml"/>
<%
String nickName="客户档案";%>
<%@include file="../../include/cDefineMouQ.jsp"%>
 </table>
</div>　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　 
<%
}
crmdb.close();
}
catch (Exception ex){
out.println("error"+ex);
}
%>