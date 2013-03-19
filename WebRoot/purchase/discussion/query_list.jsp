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
<%nseer_db purchase_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/purchase/purchase_discussion.xml"/>
<% 
String tablename="purchase_discussion";
DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<%
try{
String condition="";
String register_ID=(String)session.getAttribute("human_IDD");
String realname=(String)session.getAttribute("realeditorc");
String condition0="check_tag not in ('2','5','9') and  gar_tag='0' and excel_tag='2'";
String queue="order by register_time desc";
String validationXml="../../xml/purchase/purchase_discussion.xml";
String nickName="报价单";
String fileName="query_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的报价单总数");
int k=1;
String condition1="discussion_tag='0' and excel_tag='2'";
String condition2="discussion_tag='1' and excel_tag='2'";
String condition3="discussion_tag='2' and excel_tag='2'";
%>
<%@include file="../../include/search_a.jsp"%>
<%
condition=condition1;
%>
<%@include file="../../include/search_bn.jsp"%>
<%
int intRowCount1 = query.count((String)session.getAttribute("unit_db_name"),sql_search);
%>
<%
condition=condition2;
%>
<%@include file="../../include/search_bn.jsp"%>
<%
int intRowCount2 = query.count((String)session.getAttribute("unit_db_name"),sql_search);
%>
<%
condition=condition3;
%>
<%@include file="../../include/search_bn.jsp"%>
<%
int intRowCount3 = query.count((String)session.getAttribute("unit_db_name"),sql_search);
%>
<%
condition=condition0;
%>
<%@include file="../../include/search_b.jsp"%>
<%
ResultSet rs1 = purchase_db.executeQuery(sql_search) ;
%>
<%@include file="../../include/search_top.jsp"%>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
					   {name: '<%=demo.getLang("erp","报价单编号")%>'},
                       {name: '<%=demo.getLang("erp","供应商名称")%>'},
                       {name: '<%=demo.getLang("erp","报价单状态")%>'},
					   {name: '<%=demo.getLang("erp","审核状态")%>'}
]
nseer_grid.column_width=[160,200,70,70];
nseer_grid.auto='<%=demo.getLang("erp","供应商名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs1%>" strPage="<%=strPage%>">
<%	
String check_tag="";
String discussion_tag=demo.getLang("erp","等待");
String color="#FF9A31";
if(rs1.getString("check_tag").equals("0")){
check_tag=demo.getLang("erp","等待");
}else if(rs1.getString("check_tag").equals("1")){
check_tag=demo.getLang("erp","通过");
}else if(rs1.getString("check_tag").equals("9")){
check_tag=demo.getLang("erp","未通过");
}
if(rs1.getString("discussion_tag").equals("1")){
discussion_tag=demo.getLang("erp","等待");
color="mediumseagreen";
}else if(rs1.getString("discussion_tag").equals("2")){
discussion_tag=demo.getLang("erp","处理完成");
color="3333FF";
}
%>
['<div style="text-decoration : underline;color:#3366FF" onclick=id_link("query.jsp?discussion_ID=<%=rs1.getString("discussion_ID")%>")><span style="color:<%=color%>"><%=rs1.getString("discussion_ID")%></span></div>','<%=rs1.getString("provider_name")%>','<span style="color:<%=color%>"><%=discussion_tag%></span>','<span style="color:<%=color%>"><%=check_tag%></span>'],
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/search_bottom.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%
purchase_db.close();	
}catch(Exception e){e.printStackTrace();}	
%>
<%@include file="../../include/head_msg.jsp"%>