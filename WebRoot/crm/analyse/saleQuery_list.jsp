<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*,include.nseerdb.*" import="javax.servlet.*,javax.servlet.http.*"%>
<jsp:useBean id="query" scope="page" class="include.query.query"/>
<jsp:useBean id="pie" class="include.picture.MyPieChart"/>
<%counter count=new counter(application);%>
<jsp:useBean id="ana" class="include.nseer_cookie.analyseArray" scope="page"/>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<style>
.mengban{ 
position:absolute;
height:100%;
z-index:10;
top:0;
left:0;
background-color:#589DFA;
width:100%;
visibility: visible;
filter:alpha(opacity=40);
}
</style>
<script language="javascript">
function LoadFinish(){
document.all('LoadProcess').style.visibility = "hidden";
document.all('mengban').style.visibility = "hidden";
document.all('ifra').style.visibility = "hidden";
}
</script>
<body onload="LoadFinish();">
<iframe id="ifra" style="filter:alpha(opacity=40);position:absolute;width:expression(this.nextSibling.offsetWidth);height:expression(this.nextSibling.offsetHeight);top:expression(this.nextSibling.offsetTop);left:expression(this.nextSibling.offsetLeft);" frameborder="0" ></iframe>

<div class="mengban" id="mengban"></div>

<div  id="LoadProcess" style="position:absolute; left:40%; top:111px; width:280px; height:50px; z-index:1;z-index:11;"> 
  <table width="100%" border="0" cellspacing="2" cellpadding="3" height="26" class="font_12_a">
    <tr> 
      <td align="center" style="font:10pt;color:#3300FF"><img src="../../images/include/indicator_medium.gif">
        请稍候，正在加载数据......
      </td>
    </tr>
  </table>
</div>
<%nseer_db_backup crm_db = new nseer_db_backup(application);%>
<%@include file="../include/head_list.jsp"%>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
try{
if(crm_db.conn((String)session.getAttribute("unit_db_name"))){
int filenum=count.read((String)session.getAttribute("unit_db_name"),"crmsalepicturecount");
count.write((String)session.getAttribute("unit_db_name"),"crmsalepicturecount",filenum);
int aa=filenum-1;
String bb=aa+"";
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
File file=new File(path+"crm/analyse/"+bb+"sale_price_sum.jpg");
if(file.exists()){
	file.delete();
}
pie.setFileName(path+"crm/analyse/"+filenum+"sale_price_sum.jpg");
%>
<script src="../../javascript/table/movetable.js">
</script>
<%
double sale_price_sum=0.0d;
double sale_price_sum_all=0.0d;
String realname=(String)session.getAttribute("realeditorc");
String timea=(String)session.getAttribute("timea");
String timeb=(String)session.getAttribute("timeb");
String first_kind_name=(String)session.getAttribute("first_kind_name");
String second_kind_name=(String)session.getAttribute("second_kind_name");
String third_kind_name=(String)session.getAttribute("third_kind_name");
String sales_name=(String)session.getAttribute("sales_name");
String amount=(String)session.getAttribute("customer_amount");
String trade=(String)session.getAttribute("trade");
int customer_amount=Integer.parseInt(amount);

String dbase=(String)session.getAttribute("unit_db_name");
String tablename="crm_file";
String fieldName1="register_time";
String fieldName2="first_kind_name";
String fieldName3="third_kind_name";
String fieldName4="second_kind_name";
String fieldName5="sales_name";
String condition="";
if(trade.equals("")){
condition="check_tag='1'";
}else{
condition="type='"+trade+"' and check_tag='1'";
}
String queue="order by register_time desc";
String sqll="delete from crm_analyse";
crm_db.executeUpdate(sqll);
ResultSet rs1=query.queryDB(dbase,tablename,"","",first_kind_name,second_kind_name,third_kind_name,sales_name,fieldName1,fieldName2,fieldName3,fieldName4,fieldName5,condition,queue,realname);
int intRowCount=query.intRowCount();
if(intRowCount==0){
	%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>	 
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="saleQuery_locate.jsp"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","没有符合条件的客户，请返回！")%></td>
 </tr>
</table>
</div>
	<%
}else{
if(intRowCount<customer_amount) customer_amount=intRowCount;
String chain_name="";
String[] customer_name_group=new String[customer_amount+1];
String[] customer_ID_group=new String[customer_amount+1];
double[] sale_price_sum_group=new double[customer_amount+1];
while(rs1.next()){
	if(chain_name.equals("")){
	chain_name=rs1.getString("chain_name");
	}
	sale_price_sum=0.0d;
	String sql="";
	if(!timea.equals("")&&!timeb.equals("")){
		sql="select * from crm_order where check_time>='"+timea+"' and check_time<='"+timeb+"' and customer_ID='"+rs1.getString("customer_ID")+"' and check_tag='1'";
	}else if(timea.equals("")&&!timeb.equals("")){
		sql="select * from crm_order where check_time<='"+timeb+"' and customer_ID='"+rs1.getString("customer_ID")+"' and check_tag='1'";
		}else if(!timea.equals("")&&timeb.equals("")){
		sql="select * from crm_order where check_time>='"+timea+"' and customer_ID='"+rs1.getString("customer_ID")+"' and check_tag='1'";
		}else if(timea.equals("")&&timeb.equals("")){
		sql="select * from crm_order where customer_ID='"+rs1.getString("customer_ID")+"' and check_tag='1'";
		}
	ResultSet rs2=crm_db.executeQuery(sql);
	while(rs2.next()){
		sale_price_sum+=rs2.getDouble("sale_price_sum");
		sale_price_sum_all+=rs2.getDouble("sale_price_sum");
	}
	
	String sql1="insert into crm_analyse(customer_ID,customer_name,sale_price_sum) values('"+rs1.getString("customer_ID")+"','"+rs1.getString("customer_name")+"','"+sale_price_sum+"')";
	crm_db.executeUpdate(sql1);
}
query.close();

int i=0;
sale_price_sum=0.0d;
String sql2="select * from crm_analyse order by sale_price_sum desc limit "+customer_amount+"";
ResultSet rs2=crm_db.executeQuery(sql2);
while(rs2.next()){
	customer_ID_group[i]=rs2.getString("customer_ID");
	customer_name_group[i]=rs2.getString("customer_name");
	sale_price_sum_group[i]=rs2.getDouble("sale_price_sum");
	sale_price_sum+=rs2.getDouble("sale_price_sum");
	i++;
}
crm_db.close();
customer_name_group[customer_amount]=demo.getLang("erp","其他");
customer_name_group=ana.ana(customer_name_group);
sale_price_sum_group[customer_amount]=sale_price_sum_all-sale_price_sum;
%>
<jsp:setProperty name="pie" property="title" value="<%=demo.getLang("erp","客户销售额排名分析图")%>"/>
<jsp:setProperty name="pie" property="width" value="600"/>
<jsp:setProperty name="pie" property="height" value="400"/>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" height="30px">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"></td>
 </tr>
</table>
<jsp:setProperty name="pie" property="item" value="<%=customer_name_group%>"/>
<jsp:setProperty name="pie" property="quantity" value="<%=sale_price_sum_group%>"/>
<% pie.paint();%>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
  <tr <%=TR_STYLE1%> class="TR_STYLE1">
    <td <%=TD_STYLE3%> class="TD_STYLE3" width="50%" scope="col">
    <img src="<%=filenum%>sale_price_sum.jpg" width="600" height="400"></td>
	<td <%=TD_STYLE3%> class="TD_STYLE3" width="10%">&nbsp;</td>
    <td <%=TD_STYLE3%> class="TD_STYLE3" width="40%" valign="top">
	<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td width="285"><%=demo.getLang("erp","时间")%>：<%=exchange.toHtml(timea)%><%=demo.getLang("erp","至")%><%=exchange.toHtml(timeb)%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td
 width="285"><%=demo.getLang("erp","区域")%>：<%=exchange.toHtml(chain_name)%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td width="285"><%=demo.getLang("erp","客户经理")%>：<%=exchange.toHtml(sales_name)%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td width="285"><%=demo.getLang("erp","销售总额")%>：<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(sale_price_sum_all)%><%=demo.getLang("erp","元")%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td width="285"><%=demo.getLang("erp","排名数目")%>：<%=customer_amount%></td>
 </tr>
 <tr><td>
<div id="nseer_grid_div" style="width:220%;"></div></td>
</tr>
 </table>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<div id="nseer_grid_div"></div>
<script type="text/javascript">
function id_link(link){
winopen(link);
}
var nseer_grid = new nseergrid();
nseer_grid.callname = "nseer_grid";
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.magin_h='75%';
nseer_grid.parentNode = nseer_grid.$("nseer_grid_div");
nseer_grid.columns =[
                       {name: '<%=demo.getLang("erp","客户名称")%>'},
                       {name: '<%=demo.getLang("erp","销售额（元）")%>'}
]
nseer_grid.column_width=[80,80];
nseer_grid.auto='<%=demo.getLang("erp","客户名称")%>';
nseer_grid.data = [
<%
	for(int j=0;j<customer_amount;j++){
	%>	
['<div style="text-decoration : underline;color:#3366FF" onclick=id_link("../file/query.jsp?customer_ID=<%=customer_ID_group[j]%>")><%=exchange.toHtml(customer_name_group[j])%></div>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(sale_price_sum_group[j])%>'],
	 <%}%>
['<%=customer_name_group[customer_amount]%>','<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(sale_price_sum_group[customer_amount])%>'],
['']];
nseer_grid.init();
</script>
<div id="drag_div"></div>
<div id="point_div_t"></div>
<div id="point_div_b"></div>
<%}}else{%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table> 
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="saleQuery_locate.jsp"></div></td>
 </tr>
 </table> 
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","数据库连接故障，请返回。")%></td>
 </tr>
 </table> 
</div>
<%}
	 }catch(Exception ex){
ex.printStackTrace();
}%>