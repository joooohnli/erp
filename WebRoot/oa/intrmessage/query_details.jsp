<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,java.text.*"%>
<%nseer_db oa_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/oa/oa_intrmessage.xml"/>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6"> 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="关闭窗口" onClick="window.close();"></div></td>
 </tr>
</table>
<%
String intrmessage_ID=request.getParameter("intrmessage_ID");
String tablename="oa_intrmessage_details";
String realname=(String)session.getAttribute("realeditorc");
String condition="intrmessage_ID='"+intrmessage_ID+"'";
String queue="order by id";
String validationXml="../../xml/oa/oa_intrmessage.xml";
String nickName="sql_search外部消息";
String fileName="query_details.jsp";
String rowSummary=demo.getLang("erp","符合条件的消息总数：");
%>
 <%@include file="../../include/search.jsp"%>
 <%try{
ResultSet rs=oa_db.executeQuery(sql_search);
otherButtons="&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" value=\""+demo.getLang("erp","关闭窗口")+"\" onClick=\"window.close();\">";
%>

<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                     {name: '<%=demo.getLang("erp","档案编号")%>'}, 
	                 {name: '<%=demo.getLang("erp","类型")%>'},
                     {name: '<%=demo.getLang("erp","机构")%>'},
                     {name: '<%=demo.getLang("erp","姓名")%>'},
					 {name: '<%=demo.getLang("erp","发送次数")%>'}
					 ]
nseer_grid.column_width=[200,100,140,100,70];
nseer_grid.auto='<%=demo.getLang("erp","机构")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>">
<%if(rs.getString("type").equals("客户")){%>
	['<div style="text-decoration : underline;color:#3366FF" onclick=:winopenm("../../crm/file/query.jsp?customer_ID=<%=rs.getString("messager_ID")%>")><%=rs.getString("messager_ID")%></div>',
		<%}else if(rs.getString("type").equals("采购供应商")){%>
       ['<div style="text-decoration : underline;color:#3366FF" onclick=:winopenm("../../purchase/file/query.jsp?provider_ID=<%=rs.getString("messager_ID")%>")><%=rs.getString("messager_ID")%></div>',
<%}else if(rs.getString("type").equals("委外厂商")){%>
['<div style="text-decoration : underline;color:#3366FF" onclick=:winopenm("../../purchase/file/query.jsp?provider_ID=<%=rs.getString("messager_ID")%>")><%=rs.getString("messager_ID")%></div>',
<%}else{%>['<%=rs.getString("messager_ID")%>',<%}%>
'<%=exchange.toHtml(rs.getString("type"))%>','<%=exchange.toHtml(rs.getString("chain_name"))%>','<%=exchange.toHtml(rs.getString("messager_name"))%>','<%=rs.getString("batch_amount")%>'],
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/search_bottom.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%oa_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>
<%@include file="../../include/head_msg.jsp"%>