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
<%@include file="../../include/head_list.jsp"%>
<%nseer_db erp_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/security/security_license.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.query_three"/>
<jsp:useBean id="column" class="include.get_sql.getKeyColumn" scope="page"/>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
 <%

%>
<%
try{
String tablename="security_license";
String realname=(String)session.getAttribute("realeditorc");
String queue="order by register_time";
String condition="human_ID!=''and type='0'";
String validationXml="../../../xml/security/security_license.xml";
String nickName="申请单";
String fileName="shortCut.jsp";
String rowSummary=demo.getLang("erp","当前等待审核的申请单总数：");
%>
<%@include file="../../../include/search.jsp"%>
<%
ResultSet rs= erp_db.executeQuery(sql_search) ;
%>
<%@include file="../../../include/search_top.jsp"%>
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
                       {name: '<%=demo.getLang("erp","姓名")%>'},
                       {name: '<%=demo.getLang("erp","机构")%>'},
					   {name: '<%=demo.getLang("erp","变更")%>'}
                  ]
nseer_grid.column_width=[200,180,240,80];
nseer_grid.auto='<%=demo.getLang("erp","姓名")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>">
	
<%
String enrollment_tag="未注册";
	if(rs.getString("enrollment_tag").equals("1")){
			enrollment_tag="已注册";
		}
%>
  ['<%=rs.getString("human_ID")%>','<%=exchange.toHtml(rs.getString("human_name"))%>','<%=exchange.toHtml(rs.getString("chain_name"))%>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("shortCut_list.jsp?human_ID=<%=rs.getString("human_ID")%>&&human_name=<%=toUtf8String.utf8String(exchange.toURL(rs.getString("human_name")))%>")><%=demo.getLang("erp","变更")%></div>'],
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../../include/head_msg.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%	
erp_db.close();

}catch(Exception ex){ex.printStackTrace();}%>