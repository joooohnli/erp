<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,java.text.*"%>
<jsp:useBean id="browercheck" scope="session" class="include.nseer_cookie.BrowerVer"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html><head>
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>New Page 1</title>
<base target="bottom">
</head>
<style type="text/css"> 
.spanstyle{ 
border-bottom-style : none ;
BORDER-top:1px solid #ffffff;
BORDER-RIGHT:1px solid #12D608;

} 
</style> 
<script language="java script"> 
<!-- hide 
function killerrors() { 
return true; 
} 
window.onerror = killerrors; 
// --> 
</script>
<script language="JavaScript">

var maximizeListeners=new Object();
function registerMaximizeListener(name, listener){
	maximizeListeners[name]=listener;
}
function notifyMaximizeListeners(maximizedNotRestored){
	for(i in maximizeListeners){
		try{
			maximizeListeners[i](maximizedNotRestored);
		}catch(exc){}
	}
}

var leftCols = "20%";
var rightCols = "80%";


function toggleFrame(title)
{
	var frameset = document.getElementById("helpFrameset"); 
	var listSize = frameset.getAttribute("cols");
	var comma = listSize.indexOf(',');
	var left = listSize.substring(0,comma);
	var right = listSize.substring(comma+1);

	if (left == "*" || right == "*") {
		// restore frames
		frameset.frameSpacing="3";
		frameset.setAttribute("border", "6");
		frameset.setAttribute("cols", leftCols+","+rightCols);
		notifyMaximizeListeners(false);
	} else {
		// the "cols" attribute is not always accurate, especially after resizing.
		// offsetWidth is also not accurate, so we do a combination of both and 
		// should get a reasonable behavior

		var leftSize = list.document.body.offsetWidth;
		var rightSize = content.document.body.offsetWidth;

		
		leftCols = leftSize * 100 / (leftSize + rightSize);
		rightCols = 100 - leftCols-5;

		// maximize the frame.
		//leftCols = left;
		//rightCols = right;
		// Assumption: the content toolbar does not have a default title.

		if (title != "") // this is the left side for left-to-right rendering
			frameset.setAttribute("cols", "30%,*");
		else // this is the content toolbar
			frameset.setAttribute("cols", "*,100%");
	
		frameset.frameSpacing="0";
		frameset.setAttribute("border", "1");
		notifyMaximizeListeners(true);
	}
}
</script>
<%
String mod_c=request.getParameter("mod_c");

String main_code=request.getParameter("main_code");

String mod=request.getRequestURI();
mod=mod.substring(1);
int location=mod.indexOf("/");
mod=mod.substring(location+1);
location=mod.indexOf("/");
mod=mod.substring(0,location);
String strhead = request.getHeader("User-Agent");
if(strhead.indexOf(browercheck.IE)==-1){
%>


 <frameset cols="17%,83%" id="helpFrameset" border="0">
        <frame src="../../include_tree1?mod=<%=mod%>&&mod_c=<%=mod_c%>&&main_code=<%=main_code%>" name="list" class="spanstyle"  >
        <frame src="index_right.jsp?mod=<%=mod%>&&mod_c=<%=mod_c%>&&main_code=<%=main_code%>" name="content"  >
        
<body>

 </frameset>
<%
}else{
%>

<frameset cols="17%,83%" id="helpFrameset" border="0">
        <frame src="../../include_tree1?mod=<%=mod%>&&mod_c=<%=mod_c%>&&main_code=<%=main_code%>" name="list"  class="spanstyle" >
        <frame src="index_right.jsp?mod=<%=mod%>&&mod_c=<%=mod_c%>&&main_code=<%=main_code%>" name="content"  >
        
  

  <p>This page uses frames, but your browser doesn't support them.</p>

  </body>
  </noframes>
</frameset>
<%
}
%>

</html>