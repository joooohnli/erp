<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="java.text.*"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<STYLE>
A:visited {
	TEXT-DECORATION: none
}
A:active {
	TEXT-DECORATION: none
}
A:hover {
	TEXT-DECORATION: underline overline
}
A:link {
	TEXT-DECORATION: none
}
.t {
	LINE-HEIGHT: 1.4
}
BODY {
	FONT-FAMILY: 宋体;
	FONT-SIZE: 9pt;
	SCROLLBAR-HIGHLIGHT-COLOR: buttonface;
	SCROLLBAR-SHADOW-COLOR: buttonface;
	SCROLLBAR-3DLIGHT-COLOR: buttonhighlight;
	SCROLLBAR-TRACK-COLOR: #eeeeee;
	SCROLLBAR-DARKSHADOW-COLOR: buttonshadow;
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
TD {
	FONT-FAMILY: 宋体; FONT-SIZE: 9pt
}
DIV {
	FONT-FAMILY: 宋体; FONT-SIZE: 9pt
}
FORM {
	FONT-FAMILY: 宋体; FONT-SIZE: 9pt
}
OPTION {
	FONT-FAMILY: 宋体; FONT-SIZE: 9pt
}
P {
	FONT-FAMILY: 宋体; FONT-SIZE: 9pt
}
TD {
	FONT-FAMILY: 宋体; FONT-SIZE: 9pt
}
BR {
	FONT-FAMILY: 宋体; FONT-SIZE: 9pt
}
INPUT {
	BORDER-BOTTOM-COLOR: #cccccc; BORDER-BOTTOM-WIDTH: 1px; BORDER-LEFT-COLOR: #cccccc;  BORDER-LEFT-WIDTH: 1px; BORDER-RIGHT-COLOR: #cccccc; BORDER-RIGHT-WIDTH: 1px;  BORDER-TOP-COLOR: #cccccc; BORDER-TOP-WIDTH: 1px; FONT-SIZE: 9pt; HEIGHT: 18px;  PADDING-BOTTOM: 1px; PADDING-LEFT: 1px; PADDING-RIGHT: 1px; PADDING-TOP: 1px
}
TEXTAREA {
	BACKGROUND-COLOR: #efefef; BORDER-BOTTOM-COLOR: #000000; BORDER-BOTTOM-WIDTH: 1px;  BORDER-LEFT-COLOR: #000000; BORDER-LEFT-WIDTH: 1px; BORDER-RIGHT-COLOR: #000000;  BORDER-RIGHT-WIDTH: 1px; BORDER-TOP-COLOR: #000000; BORDER-TOP-WIDTH: 1px; FONT-FAMILY: 宋体 ; FONT-SIZE: 9pt
}
SELECT {
	BACKGROUND-COLOR: #efefef; BORDER-BOTTOM-COLOR: #000000; BORDER-BOTTOM-WIDTH: 1px;  BORDER-LEFT-COLOR: #000000; BORDER-LEFT-WIDTH: 1px; BORDER-RIGHT-COLOR: #000000;  BORDER-RIGHT-WIDTH: 1px; BORDER-TOP-COLOR: #000000; BORDER-TOP-WIDTH: 1px; FONT-FAMILY: 宋体 ; FONT-SIZE: 9pt
}
</STYLE><% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
String path=mod.substring(1);
    path=mod.split("/")[0];
	 demo.setPath(request);
int finished_tag=Integer.parseInt(request.getParameter("finished_tag"));
%>
<body bgcolor="#E9F8F3" oncontextmenu="event.returnValue=true" style="background-image:url(/<%=path%>/images/lili.gif)">
<table>
 <tr>
 <td>
<%
switch(finished_tag){
	case 0:
		out.println(demo.getLang("erp","对不起，您的操作是重复提交"));
		break;
	case 1:
		out.println(demo.getLang("erp","对不起，附件容量超出限制"));
		break;
}
%>
 </td>
 <td></td>
 </tr>
 </table>