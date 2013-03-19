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
<%nseer_db ecommerce_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db ecommerce_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="query" scope="page" class="include.union.getSql"/>
<jsp:useBean id="getRecordCount" scope="page" class="include.query.getRecordCount"/>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/ecommerce/ecommerce_news.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<%
String tablename="ecommerce_news";
String register_ID=(String)session.getAttribute("human_IDD");
String realname=(String)session.getAttribute("realeditorc");
String condition="check_tag='0'";
String queue="order by register_time";
String validationXml="../../xml/ecommerce/ecommerce_news.xml";
String nickName="新闻";
String fileName="check_list.jsp";
String rowSummary=demo.getLang("erp","当前等待发布审核的新闻总数：");
%>
<%@include file="../../include/search.jsp"%>
<%
try{
/*
String sql=sqq.substring(0,sqq.indexOf("*"))+"distinct ecommerce_news.news_ID,ecommerce_news.topic,ecommerce_news.first_kind_name,ecommerce_news.second_kind_name,ecommerce_news.third_kind_name"+sqq.substring(sqq.indexOf("*")+1,sqq.indexOf("where"))+"LEFT JOIN ecommerce_news_file ON ecommerce_news.news_ID=ecommerce_news_file.news_ID WHERE ecommerce_news_file.describe1 like '%"+register_ID+"%' and ecommerce_news_file.check_tag='0' and"+sqq.substring(sqq.indexOf("where")+5);
*/
int workflow_amount=0;
String sql="select count(id) from ecommerce_config_workflow where type_id='07'";
ResultSet rs=ecommerce_db.executeQuery(sql);
if(rs.next()){
	workflow_amount=rs.getInt("count(id)");
}
rs=ecommerce_db.executeQuery(sql_search);
/*
int workflow_amount=0;
int n=0;
sql="select max(c.co) from ecommerce_news u,(select a.news_id,count(a.news_id) as co from ecommerce_news_file a group by news_id) as c";
ResultSet rs1=ecommerce_db.executeQuery(sql);
if(rs1.next()){
	workflow_amount=rs1.getInt("max(c.co)");
}
*/
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
                       {name: '<%=demo.getLang("erp","新闻编号")%>'},
                       {name: '<%=demo.getLang("erp","新闻标题")%>'},
                       {name: '<%=demo.getLang("erp","新闻分类")%>'},
<%
for(int i=1;i<workflow_amount;i++){
		String title="流程"+i;
%>
					   {name: '<%=demo.getLang("erp",title)%>'},

	<%
}
	String title="流程"+workflow_amount;

%> 
                           {name: '<%=demo.getLang("erp",title)%>'}
]
nseer_grid.column_width=[200,100,150,<%for(int i=1;i<workflow_amount;i++){%>70,<%}%>70];
nseer_grid.auto='<%=demo.getLang("erp","新闻标题")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 
<%
	/*
String sql1="select * from ecommerce_news_file where news_ID='"+rs.getString("news_ID")+"' and describe1 like '%"+register_ID+"%' and check_tag='0'";
ResultSet rs2=ecommerce_db.executeQuery(sql1);
if(rs2.next()){
	sql1="select * from ecommerce_news_file where news_ID='"+rs.getString("news_ID")+"' order by id";
	rs2=ecommerce_db.executeQuery(sql1);
	*/

String register_time="";
if(rs.getString("register_time").equals("1800-01-01 00:00:00.0")){
register_time="";
}else{
register_time=rs.getString("register_time");
}
String sql1="select id from ecommerce_workflow where object_ID='"+rs.getString("news_ID")+"' and check_tag='0'";
ResultSet rs2=ecommerce_db1.executeQuery(sql1);
if(rs2.next()){
	sql1="select check_tag,describe1,config_id from ecommerce_workflow where object_ID='"+rs.getString("news_ID")+"' order by id";
	rs2=ecommerce_db1.executeQuery(sql1);
%>
  ['<div style="text-decoration : underline;color:#3366FF" onclick=id_link("query.jsp?news_ID=<%=rs.getString("news_ID")%>")><%=rs.getString("news_ID")%></div>','<%=exchange.toHtml(rs.getString("topic"))%>','<%=exchange.toHtml(rs.getString("chain_name"))%>'
<%
for(int i=1;i<=workflow_amount;i++){
	String status="";
	if(rs2.next()){
			if(rs2.getString("check_tag").equals("0")){
			status="无权限";
		}else if(rs2.getString("check_tag").equals("1")){
			status="通过";
			}else if(rs2.getString("check_tag").equals("9")){
			status="未通过";
			}
			if(rs2.getString("check_tag").equals("0")&&rs2.getString("describe1").indexOf(register_ID)!=-1){
%>
	,'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("check.jsp?news_ID=<%=rs.getString("news_ID")%>&config_ID=<%=rs2.getString("config_id")%>")><%=demo.getLang("erp","审核")%></div>'<%}else{%>,'<%=demo.getLang("erp",status)%>'<%}}else{%>,''<%}}%>],
<%}%>
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%@include file="../../include/search_bottom.jsp"%>
<%@include file="../../include/head_msg.jsp"%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%
ecommerce_db.close();
ecommerce_db1.close();
}catch(Exception ex){ex.printStackTrace();}
%>
