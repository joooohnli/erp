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
 <%nseer_db db = new nseer_db("ondemand1");%>
 <% DealWithString DealWithString=new DealWithString(application);%>

<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>

<table width="930" height="500" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <tr>

    <td width="930" valign="top">
	<table width="930" border="0">
	<tr>
        <td width="930" class="STYLE1">&nbsp;&nbsp;<%=demo.getLang("erp","首页")%>&gt;&gt;<%=demo.getLang("erp","委外信息")%></td>
      </tr>
      <tr>
        <td align="center"><img src="../images/list.jpg" width="780" height="2" /></td>
      </tr>
<%
String id=request.getParameter("id");
try{
	String sql = "select * from design_file where id='"+id+"'" ;
	ResultSet rs = db.executeQuery(sql) ;
	while(rs.next()){
		String lately_trade_time=rs.getString("lately_trade_time");
		if(lately_trade_time.equals("1800-01-01 00:00:00.0")){
			lately_trade_time="没有销售";
		}
		String lately_change_time=rs.getString("change_time");
		if(lately_change_time.equals("1800-01-01 00:00:00.0")){
			lately_change_time="没有变更";
		}
%>
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">

</table>
<table width="805" bgcolor="#FFFFFF" align="center"  >
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="index.jsp"></div></td>
 </tr>
</table>
 <table <%=TABLE_STYLE7%> class="TABLE_STYLE7">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","档案编号")%> </td>
 <td colspan="3" <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=rs.getString("product_ID")%>&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","产品名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("product_name"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","制造商")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("factory_name"))%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","分类")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("chain_id"))%>&nbsp;<%=exchange.toHtml(rs.getString("chain_name"))%></td>
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","产品简称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("product_nick"))%>&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","用途类型")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("type"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","档次级别")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("product_class"))%>&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","计量单位")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("personal_unit"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","计量值")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("personal_value"))%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td height="65" <%=TD_STYLE11%> class="TD_STYLE7" width="8%"><%=demo.getLang("erp","产品描述")%> &nbsp; </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=rs.getString("product_describe")%>&nbsp;</td>
 <td height="65" <%=TD_STYLE11%> class="TD_STYLE7" width="8%">&nbsp;</td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%">&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","保修期")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("warranty"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","替代品名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("twin_name"))%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","替代品编号")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=rs.getString("twin_ID")%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","生命周期(年)")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("lifecycle"))%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","市场单价(元)")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("list_price"))%>&nbsp;</td>

  <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","单位")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("amount_unit"))%>&nbsp;</td>

 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","产品经理")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("responsible_person_name"))%>&nbsp;</td>

<td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","登记人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("register"))%>&nbsp;</td>


 </tr>

<%
String[] attachment_name1=DealWithString.divide(rs.getString("attachment_name"),20);
%>
 </table>
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