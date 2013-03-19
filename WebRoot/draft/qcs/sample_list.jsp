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
<jsp:useBean id="query" scope="page" class="include.excel_export.excel"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%nseer_db qcs_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/qcs/qcs_sample.xml"/>

<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String tablename="qcs_sample";
String realname=(String)session.getAttribute("realeditorc");
String condition="(check_tag='5' or check_tag='9')";
String queue="order by register_time desc";
String validationXml="../../input_control/validation-config.xml";
String validationXml1="input_control/validation-config.xml";
String nickName="样品管理";
String fileName="sample_list.jsp";
String rowSummary=demo.getLang("erp","符合条件的样品草稿总数");
int k=1;
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<%@include file="../../include/search.jsp"%>
<%try{
ResultSet rs=qcs_db.executeQuery(sql_search);
otherButtons="&nbsp;<input type=\"button\" "+BUTTON_STYLE1+" class=\"BUTTON_STYLE1\" id=\"select_all\" value=\""+demo.getLang("erp","全选")+"\" name=\"check\" onclick=\"selAll()\">"+DgButton.getGar(tablename,request);
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
                       {name: '&nbsp;'},
                       {name: '<%=demo.getLang("erp","登记单编号")%>'},
                       {name: '<%=demo.getLang("erp","质检类型")%>'},
                       {name: '<%=demo.getLang("erp","质检申请单编号")%>'},
					   {name: '<%=demo.getLang("erp","取样人")%>'},
                       {name: '<%=demo.getLang("erp","取样时间")%>'},
                       {name: '<%=demo.getLang("erp","登记")%>'}
]
nseer_grid.column_width=[40,180,180,180,100,160,60];
nseer_grid.auto='<%=demo.getLang("erp","质检申请单编号")%>';
nseer_grid.data = [
<page:pages rs="<%=rs%>" strPage="<%=strPage%>">
['<input type="checkbox" id="draft_gar<%=k%>" name="row_id" value="<%=rs.getString("id")%>" style="height:10">','<%=exchange.toHtml(rs.getString("sample_id"))%>','<%=rs.getString("quality_type")%>','<%=rs.getString("apply_id")%>','<%=exchange.toHtml(rs.getString("sampling_person"))%>','<%=exchange.toHtml(rs.getString("sampling_time"))%>',
<%if(rs.getString("check_tag").equals("9")){%>
'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("sample.jsp?sample_id=<%=rs.getString("sample_id")%>")><%=demo.getLang("erp","重新登记")%></div>'
<%}else{%>
'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("sample.jsp?sample_id=<%=rs.getString("sample_id")%>")><%=demo.getLang("erp","继续登记")%></div>'
<%}%>
],
<%
k++;
%>
</page:pages>
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<input type="hidden" name="" id="rows_num" value="<%=k%>">
<%@include file="../../include/search_bottom.jsp"%>
<%@include file="../../include/head_msg.jsp"%>

<%qcs_db.close();%>
<page:updowntag num="<%=intRowCount%>" file="<%=fileName%>"/>
<%
}catch(Exception ex){ex.printStackTrace();}
%>