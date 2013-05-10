<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import ="include.nseer_db.*,java.sql.*" import="java.util.*" import="java.io.*" import="java.net.*" import="java.text.*"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page" />
<%    
demo.setPath(request);
%>


<html>
<head>
<title><%=demo.getLang("erp","川大科技信息化平台")%></title>

<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
<link rel="stylesheet" href="images/CSS.CSS" type="text/css">

<style type="text/css">
<!--
.style1 {font-size: 12px}
body {
	margin-top: 0px;
	margin-bottom: 0px;
}
--
</style>
<style type="text/css">
    body {
	margin:0;
	padding:0;
	font: bold 11px/1.5em Verdana;
}

h2 {
	font: bold 14px Verdana, Arial, Helvetica, sans-serif;
	color: #000;
	margin: 0px;
	padding: 0px 0px 0px 15px;
}
 
/*- Menu Tabs--------------------------- */ 


    #tabs {
      float:left;
      width:100%;
      background:#BBD9EE;
      font-size:93%;
      line-height:normal;
      }
    #tabs ul {
	margin:0;
	padding:10px 10px 0 50px;
	list-style:none;
      }
    #tabs li {
      display:inline;
      margin:0;
      padding:0;
      }
    #tabs a {
      float:left;
      background:url("../images/main/tableft.gif") no-repeat left top;
      margin:0;
      padding:0 0 0 4px;
      text-decoration:none;
      }
    #tabs a span {
      float:left;
      display:block;
      background:url("../images/main/tabright.gif") no-repeat right top;
      padding:5px 15px 4px 6px;
      color:#666;
      }
    /* Commented Backslash Hack hides rule from IE5-Mac \*/
    #tabs a span {float:none;}
    /* End IE5-Mac hack */
    #tabs a:hover span {
      color:#FF9834;
      }
    #tabs a:hover {
      background-position:0% -42px;
      }
    #tabs a:hover span {
      background-position:100% -42px;
      }


	  
/*- Menu Tabs B--------------------------- */

    #tabsB {
      float:left;
      width:100%;
      background:#F4F4F4;
      font-size:93%;
      line-height:normal;
      }
    #tabsB ul {
	margin:0;
	padding:10px 10px 0 50px;
	list-style:none;
      }
    #tabsB li {
      display:inline;
      margin:0;
      padding:0;
      }
    #tabsB a {
      float:left;
      background:url("../images/main/tableftB.gif") no-repeat left top;
      margin:0;
      padding:0 0 0 4px;
      text-decoration:none;
      }
    #tabsB a span {
      float:left;
      display:block;
      background:url("../images/main/tabrightB.gif") no-repeat right top;
      padding:5px 15px 4px 6px;
      color:#666;
      }
    /* Commented Backslash Hack hides rule from IE5-Mac \*/
    #tabsB a span {float:none;}
    /* End IE5-Mac hack */
    #tabsB a:hover span {
      color:#000;
      }
    #tabsB a:hover {
      background-position:0% -42px;
      }
    #tabsB a:hover span {
      background-position:100% -42px;
      }
	
	
	
/*- Menu Tabs C--------------------------- */

    #tabsC {
      float:left;
      width:100%;
      background:#EDF7E7;
      font-size:93%;
      line-height:normal;
      }
    #tabsC ul {
	margin:0;
	padding:10px 10px 0 50px;
	list-style:none;
      }
    #tabsC li {
      display:inline;
      margin:0;
      padding:0;
      }
    #tabsC a {
      float:left;
      background:url("../images/main/tableftC.gif") no-repeat left top;
      margin:0;
      padding:0 0 0 4px;
      text-decoration:none;
      }
    #tabsC a span {
      float:left;
      display:block;
      background:url("../images/main/tabrightC.gif") no-repeat right top;
      padding:5px 15px 4px 6px;
      color:#464E42;
      }
    /* Commented Backslash Hack hides rule from IE5-Mac \*/
    #tabsC a span {float:none;}
    /* End IE5-Mac hack */
    #tabsC a:hover span {
      color:#FFF;
      }
    #tabsC a:hover {
      background-position:0% -42px;
      }
    #tabsC a:hover span {
      background-position:100% -42px;
      }  
	
	
	
/*- Menu Tabs D--------------------------- */

    #tabsD {
      float:left;
      width:100%;
      background:#FCF3F8;
      font-size:93%;
      line-height:normal;
	  border-bottom:1px solid #F4B7D6;
      }
    #tabsD ul {
	margin:0;
	padding:10px 10px 0 50px;
	list-style:none;
      }
    #tabsD li {
      display:inline;
      margin:0;
      padding:0;
      }
    #tabsD a {
      float:left;
      background:url("../images/main/tableftD.gif") no-repeat left top;
      margin:0;
      padding:0 0 0 4px;
      text-decoration:none;
      }
    #tabsD a span {
      float:left;
      display:block;
      background:url("../images/main/tabrightD.gif") no-repeat right top;
      padding:5px 15px 4px 6px;
      color:#C7377D;
      }
    /* Commented Backslash Hack hides rule from IE5-Mac \*/
    #tabsD a span {float:none;}
    /* End IE5-Mac hack */
    #tabsD a:hover span {
      color:#C7377D;
      }
    #tabsD a:hover {
      background-position:0% -42px;
      }
    #tabsD a:hover span {
      background-position:100% -42px;
      }  
	
	
	
/*- Menu Tabs E--------------------------- */

    #tabsE {
      float:left;
      width:100%;
      background:#000;
      font-size:93%;
      line-height:normal;

      }
    #tabsE ul {
	margin:0;
	padding:10px 10px 0 50px;
	list-style:none;
      }
    #tabsE li {
      display:inline;
      margin:0;
      padding:0;
      }
    #tabsE a {
      float:left;
      background:url("../images/main/tableftE.gif") no-repeat left top;
      margin:0;
      padding:0 0 0 4px;
      text-decoration:none;
      }
    #tabsE a span {
      float:left;
      display:block;
      background:url("../images/main/tabrightE.gif") no-repeat right top;
      padding:5px 15px 4px 6px;
      color:#FFF;
      }
    /* Commented Backslash Hack hides rule from IE5-Mac \*/
    #tabsE a span {float:none;}
    /* End IE5-Mac hack */
    #tabsE a:hover span {
      color:#FFF;
      }
    #tabsE a:hover {
      background-position:0% -42px;
      }
    #tabsE a:hover span {
      background-position:100% -42px;
      }  
	
	
	
/*- Menu Tabs F--------------------------- */

    #tabsF {
      float:left;
      width:100%;
      background:#efefef;
      font-size:93%;
      line-height:normal;
	  border-bottom:1px solid #666;
      }
    #tabsF ul {
	margin:0;
	padding:10px 10px 0 50px;
	list-style:none;
      }
    #tabsF li {
      display:inline;
      margin:0;
      padding:0;
      }
    #tabsF a {
      float:left;
      background:url("../images/main/tableftF.gif") no-repeat left top;
      margin:0;
      padding:0 0 0 4px;
      text-decoration:none;
      }
    #tabsF a span {
      float:left;
      display:block;
      background:url("../images/main/tabrightF.gif") no-repeat right top;
      padding:5px 15px 4px 6px;
      color:#666;
      }
    /* Commented Backslash Hack hides rule from IE5-Mac \*/
    #tabsF a span {float:none;}
    /* End IE5-Mac hack */
    #tabsF a:hover span {
      color:#FFF;
      }
    #tabsF a:hover {
      background-position:0% -42px;
      }
    #tabsF a:hover span {
      background-position:100% -42px;
      }
	
	
	
/*- Menu Tabs G--------------------------- */

    #tabsG {
      float:left;
      width:100%;
      background:#666;
      font-size:93%;
      line-height:normal;
      }
    #tabsG ul {
	margin:0;
	padding:10px 10px 0 50px;
	list-style:none;
      }
    #tabsG li {
      display:inline;
      margin:0;
      padding:0;
      }
    #tabsG a {
      float:left;
      background:url("../images/main/tableftG.gif") no-repeat left top;
      margin:0;
      padding:0 0 0 4px;
      text-decoration:none;
      }
    #tabsG a span {
      float:left;
      display:block;
      background:url("../images/main/tabrightG.gif") no-repeat right top;
      padding:5px 15px 4px 6px;
      color:#FFF;
      }
    /* Commented Backslash Hack hides rule from IE5-Mac \*/
    #tabsG a span {float:none;}
    /* End IE5-Mac hack */
    #tabsG a:hover span {
      color:#FFF;
      }
    #tabsG a:hover {
      background-position:0% -42px;
      }
    #tabsG a:hover span {
      background-position:100% -42px;
      } 


/*- Menu Tabs H--------------------------- */

    #tabsH {
      float:left;
      width:100%;
      background:#000;
      font-size:93%;
      line-height:normal;
      }
    #tabsH ul {
	margin:0;
	padding:10px 10px 0 50px;
	list-style:none;
      }
    #tabsH li {
      display:inline;
      margin:0;
      padding:0;
      }
    #tabsH a {
      float:left;
      background:url("../images/main/tableftH.gif") no-repeat left top;
      margin:0;
      padding:0 0 0 4px;
      text-decoration:none;
      }
    #tabsH a span {
      float:left;
      display:block;
      background:url("../images/main/tabrightH.gif") no-repeat right top;
      padding:5px 15px 4px 6px;
      color:#FFF;
      }
    /* Commented Backslash Hack hides rule from IE5-Mac \*/
    #tabsH a span {float:none;}
    /* End IE5-Mac hack */
    #tabsH a:hover span {
      color:#FFF;
      }
    #tabsH a:hover {
      background-position:0% -42px;
      }
    #tabsH a:hover span {
      background-position:100% -42px;
      }


/*- Menu Tabs I--------------------------- */

    #tabsI {
      float:left;
      width:100%;
      background:#EFF4FA;
      font-size:93%;
      line-height:normal;
	  border-bottom:1px solid #DD740B;
      }
    #tabsI ul {
	margin:0;
	padding:10px 10px 0 50px;
	list-style:none;
      }
    #tabsI li {
      display:inline;
      margin:0;
      padding:0;
      }
    #tabsI a {
      float:left;
      background:url("../images/main/tableftI.gif") no-repeat left top;
      margin:0;
      padding:0 0 0 5px;
      text-decoration:none;
      }
    #tabsI a span {
      float:left;
      display:block;
      background:url("../images/main/tabrightI.gif") no-repeat right top;
      padding:5px 15px 4px 6px;
      color:#FFF;
      }
    /* Commented Backslash Hack hides rule from IE5-Mac \*/
    #tabsI a span {float:none;}
    /* End IE5-Mac hack */
    #tabsI a:hover span {
      color:#FFF;
      }
    #tabsI a:hover {
      background-position:0% -42px;
      }
    #tabsI a:hover span {
      background-position:100% -42px;
      }
	#tabsI #main_cur a {
                background-position:0% -42px;
       }
	#tabsI #main_cur a span {
	text-align:center;
	background-position:100% -42px;
     }


/*- Menu Tabs J--------------------------- */

    #tabsJ {
      float:right;
      width:100%;
      background:#505050;
      font-size:93%;
      line-height:normal;
	  border-bottom:1px solid #24618E;
      }
    #tabsJ ul {
		font-size: 9pt;
	float:right;
	margin:0;
	padding:0px 0px 0 50px;
	list-style:none;
      }
    #tabsJ li {
	  font-size: 9pt;
      display:inline;
      margin:0;
      padding:0;
      }
    #tabsJ a {
      float:left;
      background:url("../images/main/tableftJ.gif") no-repeat left top;
      margin:0;
      padding:0 0 0 5px;
      text-decoration:none;
      }
    #tabsJ a span {
      float:left;
      display:block;
      background:url("../images/main/tabrightJ.gif") no-repeat right top;
      padding:5px 15px 4px 6px;
      color:#24618E;
      }
    /* Commented Backslash Hack hides rule from IE5-Mac \*/
    #tabsJ a span {float:none;}
    /* End IE5-Mac hack */
    #tabsJ a:hover span {
      color:#FFF;
      }
    #tabsJ a:hover {
      background-position:0% -42px;
      }
    #tabsJ a:hover span {
      background-position:100% -42px;
      }
	#tabsJ #main_cur a {
                background-position:0% -42px;
       }
	#tabsJ #main_cur a span {
	text-align:center;
	background-position:100% -42px;
     }


/*- Menu Tabs K--------------------------- */ 	

    #tabsK {
      float:left;
      width:100%;
      background:#E7E5E2;
      font-size:93%;
      line-height:normal;
	  border-bottom:1px solid #54545C;
      }
    #tabsK ul {
	margin:0;
	padding:10px 10px 0 50px;
	list-style:none;
      }
    #tabsK li {
      display:inline;
      margin:0;
      padding:0;
      }
    #tabsK a {
      float:left;
      background:url("../images/main/tableftK.gif") no-repeat left top;
      margin:0;
      padding:0 0 0 4px;
      text-decoration:none;
      }
    #tabsK a span {
      float:left;
      display:block;
      background:url("../images/main/tabrightK.gif") no-repeat right top;
      padding:5px 15px 4px 6px;
      color:#FFF;
      }
    /* Commented Backslash Hack hides rule from IE5-Mac \*/
    #tabsK a span {float:none;}
    /* End IE5-Mac hack */
    #tabsK a:hover span {
      color:#FFF;
	  background-position:100% -42px;
      }
    #tabsK a:hover {
      background-position:0% -42px;
      }
    #tabsK a:hover span {
      background-position:100% -42px;
	  }
	#tabsF #main_cur a {
                background-position:0% -42px;
       }
	#tabsF #main_cur a span {
	text-align:center;
	background-position:100% -42px;
     }
</style>
</head>

<body topmargin="0" bgcolor="#505050">
<script> 
function tick() {
var hours, minutes, seconds, noon;
var intHours, intMinutes, intSeconds;
var now;
now = new Date();
intHours = now.getHours();
intMinutes = now.getMinutes();
intSeconds = now.getSeconds();
if (intHours < 12) {
hours = intHours+":";
noon = "A.M.";
} else {
intHours = intHours - 12
hours = intHours + ":";
noon = "P.M.";
}
if (intMinutes < 10) {
minutes = "0"+intMinutes+":";
} else {
minutes = intMinutes+":";
}
if (intSeconds < 10) {
seconds = "0"+intSeconds+" ";
} else {
seconds = intSeconds+" ";
}
timeString = hours+minutes+seconds+noon;
Clock.innerHTML = timeString;
window.setTimeout("tick();", 100);
}
window.onload = tick;
</script>
<script language="javascript" src="../javascript/winopen/winopen.js"></script>

<%java.util.Date  now  =  new  java.util.Date();
	GregorianCalendar now1=new GregorianCalendar();
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	String current=formatter.format(now);
	int day=now1.get(Calendar.DAY_OF_WEEK);
	String weekday="";
	if(day==1) weekday=demo.getLang("erp","星期日");
	if(day==2) weekday=demo.getLang("erp","星期一");
	if(day==3) weekday=demo.getLang("erp","星期二");
	if(day==4) weekday=demo.getLang("erp","星期三");
	if(day==5) weekday=demo.getLang("erp","星期四");
	if(day==6) weekday=demo.getLang("erp","星期五");
	if(day==7) weekday=demo.getLang("erp","星期六");
	String uname=(String)session.getAttribute("realeditorc");
	String user_ID=(String)session.getAttribute("human_IDD");

%>
<%
nseer_db db = new nseer_db((String)session.getAttribute("unit_db_name"));
String field_type=(String)session.getAttribute("field_type");
String unit_name=(String)session.getAttribute("unit_name");
String weburl="";
String sqlweb="select type_name from oa_config_public_char where kind='公司网站'";
ResultSet rsweb=db.executeQuery(sqlweb);
if(rsweb.next()){
	weburl=rsweb.getString("type_name");
}
String status="";
ResultSet rss=db.executeQuery("select type_name from document_config_public_char where kind='调试状态'");
if(rss.next()){
	status=rss.getString("type_name");
}
nseer_db db1 = new nseer_db((String)session.getAttribute("unit_db_name"));
String develop="";
String sqld="select * from document_main where value='开发管理' order by id";
	ResultSet rsd=db.executeQuery(sqld);
	while(rsd.next()){
		String tablename=rsd.getString("reason")+"_view";
		String sql1d="select * from "+tablename+" where human_ID='"+user_ID+"'";
	ResultSet rs1d=db1.executeQuery(sql1d);
	if(rs1d.next()){
		develop=rsd.getString("reason");
	}
	}
%>
<div align="left">
  <center>
<table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" background="/images/tab_inactive1.jpg" style="border-collapse: collapse">
        <tr>
		  <td align="left" width="33%">
          <p class="style1" align="left"><font color="#ffffff"style="font-size: 13"><%=current%></font>  <font id="Clock" align="center" style="font-size: 13; color:#ffffff"></font>  <font color="#ffffff"><%=weekday%></font><a href="../hr/file/query.jsp?human_ID=<%=user_ID%>" target="_top"><font color="#ffffff"><%=uname%></a> <%=demo.getLang("erp","您好!")%></p>          </td>
<%
InetAddress addr=InetAddress.getLocalHost();
String addr1 = addr.getHostAddress();
%>

<td>
<div id="tabsJ">

<ul>
    <li><a href="../security/workspace/workspace.jsp" target="_top" onclick="selectM(this);"><span><font color="#FFFFFF"><%=demo.getLang("erp","个性化界面")%></span></a></li>
	<%
String sql = "select * from document_main where value!='开发管理' order by id";
ResultSet rs=db.executeQuery(sql);
	while(rs.next()){	
	String table=rs.getString("reason");
	String tablenick = "";	       
	String tablename=rs.getString("reason")+"_view";
	String sql1="select * from "+tablename+" where human_ID='"+user_ID+"'";
	ResultSet rs1=db1.executeQuery(sql1);
	if(rs1.next()&&(rs.getString("reason").equals("erpPlatform")||rs.getString("reason").equals("draft")||rs.getString("reason").equals("garbage"))){
	%>
<li><a href="../<%=table%>/include/index_middle1.jsp?mod_c=<%=demo.getLang("erp",rs.getString("value"))%>" onclick="selectM(this);" name="nseer_mod" nseer1="<%=rs.getString("reason")%>" target="a"><span><font color="#FFFFFF"><%=demo.getLang("erp",rs.getString("value"))%></span></a></li>
<%}}%>
	<li><a href="../portal/index.jsp"  target="_blank" onclick="selectM(this);"><span><font color="#FFFFFF"><%=demo.getLang("erp","我的网站")%></span></a></li>
    <li><a href="../home/logout.jsp" target="_top" onclick="selectM(this);"><span><font color="#FFFFFF"><%=demo.getLang("erp","退出系统")%></span></a></li>
 </ul>
</div>
</td>       
  </tr>
</table></center>
</div>
<IFRAME frameBorder=0 height=0 marginHeight=0 marginWidth=0 name=window
                                src="refresh.jsp"
                                width=420 height=40></IFRAME>
</body>
</html>
<script>
function selectM(obj){
var obj1=document.getElementsByName('nseer_mod');
for(var i=0;i<obj1.length;i++){
obj1[i].parentNode.id = "";
}
obj.parentNode.id = "main_cur";	
window.parent.window.frames[0].setNull();
obj.blur();
}
function setNull(){
	var lis=document.getElementById('tabsJ').getElementsByTagName('li');
	for(var a=0;a<lis.length;a++){
		lis[a].id='';
	}
}

function setId(s){
var obj=document.getElementsByName('nseer_mod');

for(var i=0;i<obj.length;i++){

if(s==obj[i].nseer1){
obj[i].parentNode.id = "main_cur";
}

}
}



</script>