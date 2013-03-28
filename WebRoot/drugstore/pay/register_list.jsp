<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,include.nseerdb.*,java.text.*"%>
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db stockdb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@include file="../include/head_list.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="NseerSql" class="include.query.NseerSql" scope="page"/>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/stock/stock_pay.xml"/>
<script language="javascript" src="../../javascript/winopen/winopens.js"></script>
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
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
 </table>
<%
String register_ID=(String)session.getAttribute("human_IDD");
String stock_ID="";
String sql3="select * from stock_config_public_char where describe1='库房' and responsible_person_ID like '%"+register_ID+"%'";
ResultSet rs3=stock_db.executeQuery(sql3);
while(rs3.next()){
	stock_ID+=rs3.getString("stock_ID")+",";
}
int k=0;
String[] pay_ID_group1=new String[10000];
	String sql = "select * from stock_pay where pay_pre_tag='1' and pay_tag!='2' order by register_time" ;
	ResultSet rs = stockdb.executeQuery(sql);
	while(rs.next()){
		String sql4="select * from stock_pre_paying where pay_ID='"+rs.getString("pay_ID")+"'";
		ResultSet rs4 = stock_db.executeQuery(sql4);
		while(rs4.next()){
			if(stock_ID.indexOf(rs4.getString("stock_ID"))!= -1&&rs4.getString("pay_check_tag").equals("0")&&rs4.getString("pay_tag").equals("0")){
				pay_ID_group1[k]=rs4.getString("pay_ID");
				k++;
			}
		}
	}
	String pay_ID_group="";
int p=0;
if(k!=0){

for(int i=0;i<k-1;i++){
	if(pay_ID_group.indexOf(pay_ID_group1[i])== -1){
		pay_ID_group+=pay_ID_group1[i]+",";
		p++;
	}
}
	if(pay_ID_group.indexOf(pay_ID_group1[k-1])== -1){
		pay_ID_group+=pay_ID_group1[k-1];
		p++;
	}
}
int m;
int intPageSize; 
int intRowCount; 
int intPageCount; 
int intPage; 
intPageSize = 25;
String pageSize_temp=request.getParameter("pageSize");
if(pageSize_temp!=null&&!pageSize_temp.equals("")){intPageSize=Integer.parseInt(pageSize_temp);}
pageContext.setAttribute("pageSize",new Integer(intPageSize).toString());
String strPage = request.getParameter("page");
intRowCount = p;
int maxPage=(intRowCount+intPageSize-1)/intPageSize;
if(maxPage==0) maxPage=1;

if(strPage==null||strPage!=null&&(strPage.equals("")||!validata.validata(strPage))){
	strPage="1";
	intPage = 1;
}else if(Integer.parseInt(strPage)<=0){
	strPage="1";
	intPage = 1;
}else if(maxPage>0&&Integer.parseInt(strPage)>maxPage){
	strPage=maxPage+"";
	intPage = maxPage;
}else{
intPage = Integer.parseInt(strPage);
if(intPage<1) intPage = 1;
}
pageContext.setAttribute("intPage",strPage);
pageContext.setAttribute("PageCount",maxPage+"");
String[] pay_ID=new String[p+1];
p=1;
StringTokenizer tokenTO = new StringTokenizer(pay_ID_group,","); 
	while(tokenTO.hasMoreTokens()){
 pay_ID[p] = tokenTO.nextToken();
		p++;
 }
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
                       {name: '<%=demo.getLang("erp","出库单编号")%>'},
                       {name: '<%=demo.getLang("erp","出库理由")%>'},
					   {name: '<%=demo.getLang("erp","出库详细理由")%>'},
                       {name: '<%=demo.getLang("erp","登记时间")%>'},
	                   {name: '<%=demo.getLang("erp","总件数")%>'},
                       {name: '<%=demo.getLang("erp","总金额（元）")%>'},
					   {name: '<%=demo.getLang("erp","登记")%>'}
]
nseer_grid.column_width=[180,70,180,160,70,100,70];
nseer_grid.auto='<%=demo.getLang("erp","出库详细理由")%>';
nseer_grid.data = [
<%	
intPageCount = (intRowCount+intPageSize-1) / intPageSize;
if(intPage>intPageCount) intPage = intPageCount;
if(intPageCount>0){
//rs.absolute((intPage-1) * intPageSize +1);
m = (intPage-1) * intPageSize +1;
int j=intPage*intPageSize+1;
while(m<j&&m<=intRowCount){
	String sql6="select * from stock_pay where pay_ID='"+pay_ID[m]+"'";
	ResultSet rs6=stock_db.executeQuery(sql6);
	if(rs6.next()){
%>

['<%=rs6.getString("pay_ID")%>','<%=exchange.toHtml(rs6.getString("reason"))%>','<%=exchange.toHtml(rs6.getString("reasonexact"))%>','<%=exchange.toHtml(rs6.getString("register_time"))%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(rs6.getDouble("demand_amount"))%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("cost_price_sum"))%>','<div style="text-decoration : underline;color:#3366FF" onclick=id_link("register.jsp?pay_ID=<%=rs6.getString("pay_ID")%>")><%=demo.getLang("erp","登记")%></div>'],

<%
	}
m++;
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
<page:updowntag num="<%=intRowCount%>" file="register_list.jsp"/>
<%	
stockdb.close();
stock_db.close();
%>
<%@include file="../../include/head_msg.jsp"%>