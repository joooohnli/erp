<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<%nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/finance/finance_fa_file.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<link rel="stylesheet" type="text/css" href="../../css/include/nseer_cookie/xml-css.css"/>
<script type='text/javascript' src='../../javascript/include/div/divViewChange.js'></script>
<script language="javascript" src="../../javascript/winopen/winopens.js"></script>
<script type="text/javascript" src="../../javascript/finance/fixed_assets/animation/jquery.js"></script>
<script type="text/javascript" src="../../javascript/finance/fixed_assets/animation/interface.js"></script>
<script type="text/javascript" src="../../javascript/finance/fixed_assets/query_locate.js"></script>
<%
String file_id=(String)session.getAttribute("file_id");
String kind_id=(String)session.getAttribute("kind_id");
String kind_name=(String)session.getAttribute("kind_name");
String type_id=(String)session.getAttribute("type_id");
String type_name=(String)session.getAttribute("type_name");

String tablename="finance_fa_file";
String realname=(String)session.getAttribute("realeditorc");
String condition="id!=''";
String queue="order by file_id";
String validationXml="../../xml/finance/finance_fa_file.xml";
String nickName="固定资产";
String fileName="query_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的固定资产总数");
%>
<%@include file="../../include/search.jsp"%>
<%ResultSet rs = finance_db.executeQuery(sql_search);
otherButtons="&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" value=\""+demo.getLang("erp","返回")+"\" onClick=location=\"query_locate.jsp\">";
 %>
<%@include file="../../include/search_top.jsp"%>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","固定资产编号")%>'},
                       {name: '<%=demo.getLang("erp","固定资产名称")%>'},
                       {name: '<%=demo.getLang("erp","所在机构")%>'},
                       {name: '<%=demo.getLang("erp","增加方式")%>'},
                       {name: '<%=demo.getLang("erp","资产类别")%>'},
                       {name: '<%=demo.getLang("erp","规格型号")%>'}
                  ]
nseer_grid.column_width=[100,200,200,100,100,100];
nseer_grid.auto='<%=demo.getLang("erp","规格型号")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 
  ['<div style="text-decoration : underline;color:#3366FF" onclick=id_link(this.innerHTML)><%=rs.getString("file_id")%></div>','<%=exchange.toHtml(rs.getString("file_name"))%>','<%=exchange.toHtml(rs.getString("department_name"))%>','<%=exchange.toHtml(rs.getString("addway_name"))%>','<%=exchange.toHtml(rs.getString("type_name"))%>','<%=exchange.toHtml(rs.getString("specification"))%>'],
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>

<div id="file_details" style="position:absolute;top:50px;left:60px;width:700px;height:383px;display:none;" nseerDef="dragonly">
<TABLE width="100%" height="100%" border="0" align="center" cellPadding="0" cellSpacing="0">
  <TBODY>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0ltop.gif"  ></TD>
      <TD width="100%" background="../../images/bg_01.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0rtop.gif"></TD>
    </TR>
    <TR>
      <TD  background="../../images/bg_03.gif"></TD>
 <TD>
<div class="cssDiv1">
<div class="cssDiv2"><%=demo.getLang("erp","资产查询")%>：
</div>
</div>
<div class="cssDiv3"  onclick="document.getElementById('file_details').style.display='none';"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<div style="width:100%;height:100%;background:#FFFFFF;">
<table id="theObjTable" align="center" width="100%" bgcolor=black border=0 cellspacing=1 cellpadding=0 style="position: absolute;top:34px;">
<tr style="background-image:url(../../images/mungg.gif)"><td colspan="4"><div style="width:100%; height:12; padding:3px; color:#000000; font-weight:bold "><%=demo.getLang("erp","主信息")%></div></td></tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","类别")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="33%" id="type_name" colspan="3">&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","固定资产编号")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="33%" id="file_id">&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","固定资产名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="33%" id="file_name">&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","增加方式")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="33%" id="addway">&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","所在机构")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="33%" id="department">&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","规格型号")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="33%" id="specification">&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","存放地址")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="33%" id="deposit_place">&nbsp;</td>
  </tr>
<tr style="background-image:url(../../images/mungg.gif)"><td colspan="4"><div style="width:100%; height:12; padding:3px; color:#000000; font-weight:bold "><%=demo.getLang("erp","折旧信息")%></div></td></tr>

<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","使用状态")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="33%" id="status">&nbsp;</td>
<td <%=TD_STYLE11%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","开始使用日期")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="33%" id="start_time">&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","折旧方法")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="33%" id="calway">&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","使用年限")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="33%" id="life_cycle">&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","币种")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="33%" id="currency">&nbsp;</td>
<td <%=TD_STYLE11%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","原值")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="33%" id="original_value">&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","净残值率")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="33%" id="remnant_value_rate">&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","净残值")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="33%" id="remnant_value">&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","已计提月份")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="33%" id="caled_month">&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","累计折旧")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="33%" id="caled_sum">&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="17%">&nbsp;</td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="33%">&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","月折旧额")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="33%" id="caled_subtotal">&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","净值")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="33%" id="net_value">&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","折旧对应科目")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="33%" id="cal_file_name">&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","变动次数")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="33%" id="change_amount">&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","最近变动时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="33%" id="lately_change_time">&nbsp;</td>
 </tr>
</table>
</div>
 </TD>
<TD  background="../../images/bg_04.gif"></TD>
    </TR>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0lbottom.gif" ></TD>
      <TD background="../../images/bg_02.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../../images/bg_0rbottom.gif"></TD>
    </TR>    
  </TBODY>
</TABLE>
</div>

<%@include file="../../include/search_bottom.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%@include file="../../include/head_msg.jsp"%>
<%
finance_db.close();
%>