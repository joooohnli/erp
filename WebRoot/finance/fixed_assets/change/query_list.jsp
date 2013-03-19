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
<%@include file="../../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/finance/finance_fa_change.xml"/>
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
<link rel="stylesheet" type="text/css" href="../../../css/include/nseer_cookie/xml-css.css"/>
<script type='text/javascript' src='../../../javascript/include/div/divViewChange.js'></script>
<script language="javascript" src="../../../javascript/winopen/winopens.js"></script>
<script type="text/javascript" src="../../../javascript/finance/fixed_assets/animation/jquery.js"></script>
<script type="text/javascript" src="../../../javascript/finance/fixed_assets/animation/interface.js"></script>
<script type="text/javascript" src="../../../javascript/finance/fixed_assets/change/query_locate.js"></script>
<%
String timea=(String)session.getAttribute("timea");
String timeb=(String)session.getAttribute("timeb");
String change_type=(String)session.getAttribute("change_type");
String file_id=(String)session.getAttribute("file_id");

String tablename="finance_fa_change";
String realname=(String)session.getAttribute("realeditorc");
String condition="id!=''";
String queue="order by changebill_id";
String validationXml="../../../xml/finance/finance_fa_change.xml";
String nickName="变动单";
String fileName="query_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的变动单总数");
%>
<%@include file="../../../include/search.jsp"%>
<%ResultSet rs = finance_db.executeQuery(sql_search);
otherButtons="&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" value=\""+demo.getLang("erp","返回")+"\" onClick=location=\"query_locate.jsp\">";
 %>
<%@include file="../../../include/search_top.jsp"%>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","变动单编号")%>'},
                       {name: '<%=demo.getLang("erp","固定资产编号")%>'},
                       {name: '<%=demo.getLang("erp","固定资产名称")%>'},
                       {name: '<%=demo.getLang("erp","资产变动类型")%>'},
                       {name: '<%=demo.getLang("erp","变动日期")%>'},
                       {name: '<%=demo.getLang("erp","变动人")%>'}
                  ]
nseer_grid.column_width=[180,150,200,150,160,100];
nseer_grid.auto='<%=demo.getLang("erp","固定资产名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 
  ['<div style="text-decoration : underline;color:#3366FF" onclick=id_link(this.innerHTML)><%=rs.getString("changebill_id")%></div>','<%=exchange.toHtml(rs.getString("file_id"))%>','<%=exchange.toHtml(rs.getString("file_name"))%>','<%=exchange.toHtml(rs.getString("change_kind"))%>','<%=exchange.toHtml(rs.getString("change_time"))%>','<%=exchange.toHtml(rs.getString("changer"))%>'],
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>

<div id="change_bill" style="position:absolute;top:100px;left:60px;width:700px;height:300px;display:none;" nseerDef="dragonly">
<TABLE width="100%" height="100%" border="0" align="center" cellPadding="0" cellSpacing="0">
  <TBODY>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../../../images/bg_0ltop.gif"></TD>
      <TD width="100%" background="../../../images/bg_01.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../../../images/bg_0rtop.gif"></TD>
    </TR>
    <TR>
      <TD  background="../../../images/bg_03.gif"></TD>
 <TD>
<div class="cssDiv1">
<div class="cssDiv2"><%=demo.getLang("erp","资产变动查询")%>：
</div>
</div>
<div class="cssDiv3"  onclick="close_clear();"  onmouseover="n_D.mmcMouseStyle(this);"></div>
<div style="width:100%; height:100%;background:#FFFFFF;">
<table id="theObjTable" align="center" width="100%" bgcolor=black border=0 cellspacing=1 cellpadding=0 style="position: absolute;top:34px;">
<tr style="background-image:url(../../../images/mungg.gif)">
<td colspan="4">
<div id="title" style="width:100%; height:12; padding:3px; color:#000000; font-weight:bold"><%=demo.getLang("erp","变动单")%></div>
</td>
</tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1" style="height:20px;">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","固定资产编号")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="33%" id="file_id"></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","固定资产名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="33%" id="file_name"></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","开始使用日期")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="33%" id="start_time"></td>
<td <%=TD_STYLE11%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","规格型号")%></td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="33%" id="specification"></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE7" width="17%"><%=demo.getLang("erp","变动原因")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="33%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" id="change_reason" style="width:214px;" readonly/></textarea></td>
<td <%=TD_STYLE11%> class="TD_STYLE7" width="17%">&nbsp;</td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="33%">&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","变动日期")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="33%" id="change_date"></td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="17%"><%=demo.getLang("erp","变动人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="33%" id="changer"></td>
 </tr>
</table>
</div>
 </TD>
<TD  background="../../../images/bg_04.gif"></TD>
    </TR>
    <TR>
      <TD width="1%" height="1%"><IMG  src="../../../images/bg_0lbottom.gif" ></TD>
      <TD background="../../../images/bg_02.gif"></TD>
      <TD width="1%" height="1%"><IMG  src="../../../images/bg_0rbottom.gif"></TD>
    </TR>    
  </TBODY>
</TABLE>
</div>

<%@include file="../../../include/search_bottom.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%@include file="../../../include/head_msg.jsp"%>
<%
finance_db.close();
%>
