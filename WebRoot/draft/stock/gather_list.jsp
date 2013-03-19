
<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseerdb.*,java.text.*"%>
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db stockdb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<script language="javascript" src="../../javascript/winopen/winopens.js"></script>

<%
try{
String register_ID=(String)session.getAttribute("human_IDD");
String stock_ID="";
String sql3="select * from stock_config_public_char where describe1='库房' and responsible_person_ID like '%"+register_ID+"%'";
ResultSet rs3=stock_db.executeQuery(sql3);
while(rs3.next()){
	stock_ID+=rs3.getString("stock_ID")+",";
}
int k=0;
String[] gather_ID_group1=new String[10000];
    String gather_check_tag="";
	String sql = "select * from stock_gather where gather_pre_tag='1' and gather_tag!='2' order by register_time" ;
	ResultSet rs = stockdb.executeQuery(sql) ;
	while(rs.next()){
		String sql4="select * from stock_pre_gathering where gather_ID='"+rs.getString("gather_ID")+"'";
		ResultSet rs4 = stock_db.executeQuery(sql4) ;
		while(rs4.next()){
			if((rs4.getString("gather_check_tag").equals("9")||rs4.getString("gather_check_tag").equals("5"))&&rs4.getString("gather_tag").equals("0")){
				gather_ID_group1[k]=rs4.getString("gather_ID")+"⊙"+rs4.getString("gather_check_tag");
				k++;
			}
		}
	}
	String gather_ID_group="";
int p=0;
if(k!=0){

for(int v=0;v<k-1;v++){
	if(gather_ID_group.indexOf(gather_ID_group1[v])== -1){
		gather_ID_group+=gather_ID_group1[v]+",";
		p++;
	}
}
	if(gather_ID_group.indexOf(gather_ID_group1[k-1])== -1){
		gather_ID_group+=gather_ID_group1[k-1];
		p++;
	}
}
int v;
int intPageSize; 
int intRowCount;
int intPageCount; 
int intPage; 
intPageSize = 20;
String strPage = request.getParameter("page");
if(strPage!=null&&!strPage.equals("")&&!validata.validata(strPage)){
	strPage="";
}
if(strPage==null||strPage.equals("")){
intPage = 1;
}
else{
intPage = Integer.parseInt(strPage);
if(intPage<1) intPage = 1;
}
intRowCount = p;
String[] gather_ID=new String[p+1];
p=1;
StringTokenizer tokenTO = new StringTokenizer(gather_ID_group,","); 
	while(tokenTO.hasMoreTokens()) {
 gather_ID[p] = tokenTO.nextToken();
		p++;
		}
%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
 </table>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
document.location.href=link;
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[                   
                       {name: '<%=demo.getLang("erp","入库单编号")%>'},
                       {name: '<%=demo.getLang("erp","入库理由")%>'},
					   {name: '<%=demo.getLang("erp","入库详细理由")%>'},
                       {name: '<%=demo.getLang("erp","登记时间")%>'},
	                   {name: '<%=demo.getLang("erp","总件数")%>'},
                       {name: '<%=demo.getLang("erp","总金额（元）")%>'},
                       {name: '<%=demo.getLang("erp","登记")%>'}
                       ]
nseer_grid.column_width=[180,180,180,160,100,100,70];
nseer_grid.auto='<%=demo.getLang("erp","总金额（元）")%>';
nseer_grid.data = [
 
	<%	
intPageCount = (intRowCount+intPageSize-1) / intPageSize;
if(intPage>intPageCount) intPage = intPageCount;
if(intPageCount>0){
//rs.absolute((intPage-1) * intPageSize +1);
v = (intPage-1) * intPageSize +1;
int j=intPage*intPageSize+1;
while(v<j&&v<=intRowCount){
	String sql6="select * from stock_gather where gather_ID='"+gather_ID[v].split("⊙")[0]+"'";
	ResultSet rs6=stock_db.executeQuery(sql6);
	if(rs6.next()){
%>
['<%=rs6.getString("gather_ID")%>','<%=exchange.toHtml(rs6.getString("reason"))%>','<%=exchange.toHtml(rs6.getString("reasonexact"))%>','<%=exchange.toHtml(rs6.getString("register_time"))%>','<%=demo.qformat(rs6.getDouble("demand_amount"))%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("cost_price_sum"))%>',
<%if(gather_ID[v].split("⊙")[1].equals("9")){%>
'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("gather.jsp?gather_ID=<%=rs6.getString("gather_ID")%>&gathering_time=<%=rs6.getString("gathering_time")%>")><%=demo.getLang("erp","重新登记")%></div>'
<%}else{%>
'<div style="text-decoration : underline;color:#3366FF" onclick=id_link("gather.jsp?gather_ID=<%=rs6.getString("gather_ID")%>&gathering_time=<%=rs6.getString("gathering_time")%>")><%=demo.getLang("erp","继续登记")%></div>'
<%}%>
],
<%
}
v++;
}
}
if(intPageCount==0){
intPage=1;
intPageCount=1;
}
%>
['']];

nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<div style="position:absolute;bottom:0px;left:8px;">

 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2"> 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<form id=form1 action="gather_list.jsp">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <%=demo.getLang("erp","总数：")%><%=intRowCount%><%=demo.getLang("erp","例")%>&nbsp;&nbsp;&nbsp; <%if(intPage>1){%><a href="gather_list.jsp?page=<%=intPage-1%>"><%=demo.getLang("erp","上页")%></a>&nbsp;&nbsp;&nbsp;<%}%>  
 <%=demo.getLang("erp","当前第")%><%=intPage%><%=demo.getLang("erp","页")%>&nbsp;&nbsp;&nbsp; <%if(intPage<intPageCount){%><a href="gather_list.jsp?page=<%=intPage+1%>"><%=demo.getLang("erp","下页")%></a>&nbsp;&nbsp;&nbsp;<%}%> <%=demo.getLang("erp","共")%><%=intPageCount%><%=demo.getLang("erp","页")%>&nbsp;&nbsp;<%=demo.getLang("erp","跳到第")%> <input name=page type="text" size=1> <%=demo.getLang("erp","页")%>&nbsp;&nbsp; 
<input type=image src="../../images/go.bmp" width=18 border=0></td></form> 
 </tr> 
 </table> 
 
<%	
stockdb.close();
stock_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>
<%@include file="../../include/head_msg.jsp"%>
