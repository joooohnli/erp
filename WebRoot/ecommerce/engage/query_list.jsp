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
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/hr/hr_major_release.xml"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<%
try{
String realname=(String)session.getAttribute("realeditorc");
String register_ID=(String)session.getAttribute("release_idD");
String tablename="hr_major_release";
String condition="check_tag!='2'";
String condition1="check_tag='9'" ;
String condition2="check_tag='0'" ;
String condition3="check_tag='1'" ;
String queue="order by register_time";
String validationXml="../../xml/hr/hr_major_release.xml";
String nickName="职位";
String fileName="query_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的职位总数");
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
<%@include file="../../include/search_b.jsp"%>
<%
int intRowCount3 = query.count((String)session.getAttribute("unit_db_name"),sql_search);
%>
<%
condition="check_tag!='2'";
%>
<%
int workflow_amount=0;
String sql="select count(id) from ecommerce_config_workflow where type_id='06'";
ResultSet rs1=ecommerce_db.executeQuery(sql);
if(rs1.next()){
	workflow_amount=rs1.getInt("count(id)");
}
ResultSet rs = ecommerce_db.executeQuery(sql_search) ;
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
                       {name: '<%=demo.getLang("erp","职位分类")%>'},
                       {name: '<%=demo.getLang("erp","职位名称")%>'},
                       {name: '<%=demo.getLang("erp","机构")%>'},
					
<%
for(int i=1;i<=workflow_amount;i++){
		String title="流程"+i;
%>
					   {name: '<%=demo.getLang("erp",title)%>'},
<%
}
%> 
                           {name: '<%=demo.getLang("erp","审核状态")%>'}
]
nseer_grid.column_width=[200,100,150,<%for(int i=1;i<=workflow_amount;i++){%>70,<%}%>70];
nseer_grid.auto='<%=demo.getLang("erp","职位名称")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>"> 
<%
String sql1="select * from ecommerce_workflow  where object_id='"+rs.getString("release_id")+"'";
ResultSet rs2=ecommerce_db1.executeQuery(sql1);
%>
  ['<%=exchange.toHtml(rs.getString("human_major_first_kind_name"))%>','<%=exchange.toHtml(rs.getString("human_major_second_kind_name"))%>','<%=exchange.toHtml(rs.getString("chain_name"))%>',
<%
for(int i=1;i<=workflow_amount;i++){
	if(rs2.next()){
%>
	'<div style="text-decoration : underline;color:#3366FF" onclick=winopen("query_details.jsp?release_id=<%=rs2.getString("object_id")%>&config_id=<%=rs2.getString("config_id")%>")><%=demo.getLang("erp","查看")%></div>',<%}else{%>'',
		<%}}
	String status="";
if(rs.getString("check_tag").equals("0")){
			status="未审核";
			}else if(rs.getString("check_tag").equals("1")){
			status="通过";
			}else if(rs.getString("check_tag").equals("9")){
			status="未通过";
			}
%>'<%=status%>'
		],

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