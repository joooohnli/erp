package security.workspace;
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import javax.servlet.*;
import java.io.* ;

import include.right.*;
import include.tree_index.BusFirst;
import include.tree_index.Nseer;
import include.tree_index.businessComment;
import include.nseer_db.*;
import include.nseer_cookie.*;

public class workspace_left extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext application=dbSession.getServletContext();
HttpSession session=request.getSession();
PrintWriter out=response.getWriter();
try{
	Nseer n=new Nseer();
	include.ajax.GetImg GetImg=new include.ajax.GetImg();
	nseer_db security_db = new nseer_db((String)session.getAttribute("unit_db_name"));
    businessComment demo = new businessComment();
	demo.setPath(request);
    BrowerVer browercheck=new BrowerVer();
String human_ID=(String)session.getAttribute("human_IDD");
String strhead = request.getHeader("User-Agent");
if(strhead.indexOf(browercheck.IE)!=-1){		 
			 	double ver = Double.parseDouble(strhead.substring(strhead.indexOf("MSIE ")+5,strhead.indexOf(";",strhead.indexOf("MSIE "))));
			 	if(ver <browercheck.IEVer){
			RequestDispatcher dispatcher=getServletContext().getRequestDispatcher("/alarm.html");
  dispatcher.include(request,response);
				}
		}
demo.setPath(request);
if(session.getAttribute("human_IDD")==null) response.sendRedirect("home/login.jsp");
String tree_view_name=exchange.unURL(request.getParameter("tree_view_name")) ;
String category_id=exchange.unURL(request.getParameter("category")) ;
      out.write("\r\n");
      out.write("\r\n");
      out.write("<script type='text/javascript' src='dwr/engine.js'></script>\r\n");
      out.write("<script type='text/javascript' src='dwr/util.js'></script>\r\n");
      out.write("<script type='text/javascript' src='dwr/interface/NseerModuleTreeNode.js'></script>\r\n");

nseer_db db = new nseer_db((String)session.getAttribute("unit_db_name"));

      out.write("\r\n");
      out.write("<style type=\"text/css\">\r\n");
      out.write("    body {\r\n");
      out.write("        font-size: 12px;\r\n");
      out.write("        font-family: verdana;\r\n");
      out.write("        background-color: white;\r\n");
      out.write("\t\t white-space:nowrap;\r\n");
      out.write("\t\t background: #ffffff;\r\n");
      out.write("      }\r\n");
      out.write("      .root {\t  \r\n");
      out.write("\t  border-left: #E1E1E1 1px solid;\r\n");
      out.write("\t  border-right: #E1E1E1 1px solid;\r\n");
      out.write("\t  border-top: #fff 0px solid;\r\n");
      out.write("\t  border-bottom: #ffffff 1px solid;\r\n");
      out.write("      padding: 0px 0px 0px 0px;\r\n");
      out.write("\t  background: transparent url(images/two.jpg) repeat-x 0 -15px;\r\n");
      out.write("      }\r\n");
      out.write("\t  .hrefdiv {\t  \r\n");
      out.write("\t  border-left: #E1E1E1 1px solid;\r\n");
      out.write("\t  border-right: #E1E1E1 1px solid;\r\n");
      out.write("\t  border-top: #fff 0px solid;\r\n");
      out.write("\t  border-bottom: #E1E1E1 1px solid;\r\n");
      out.write("      }\r\n");
      out.write("      A:visited {\r\n");
      out.write("\t  color:#000000;\r\n");
      out.write("\t  TEXT-DECORATION: none;\r\n");
      out.write("\t  }\r\n");
      out.write("\t  A:active {\r\n");
      out.write("\t  color:#000000;\r\n");
      out.write("\t  TEXT-DECORATION: none;\r\n");
      out.write("\t  }\r\n");
      out.write("\t  A:hover {\r\n");
      out.write("\t  TEXT-DECORATION: none;\r\n");
      out.write("\t  }\r\n");
      out.write("\t  A:link {\r\n");
      out.write("\t  color:#000000;\r\n");
      out.write("\t  TEXT-DECORATION: none;\r\n");
      out.write("\t  }\r\n");
      out.write("      .root div {\r\n");
      out.write("      padding: 0px 0px 0px 0px;\r\n");
      out.write("      display: none;\r\n");
      out.write("\t  border-left: 1px solid #E1E1E1;\r\n");
      out.write("      margin-left: 20px;\r\n");
      out.write("\t  margin-top: 1px;\r\n");
      out.write("      }\r\n");
      out.write("\t  #main_cur {\r\n");
      out.write("        color:#ffffff;       \r\n");
      out.write("       }\r\n");
      out.write("      </style>\r\n");
      out.write("<script type=\"text/javascript\" language=\"JavaScript\">\r\n");
      out.write("function toggleNode(node,id,tablename) \r\n");
      out.write("{\r\n");
      out.write("var parent_HTML=node.innerHTML;\r\n");
      out.write("var temp=parent_HTML.toLowerCase().indexOf('</a>');\r\n");
      out.write("temp=parent_HTML.substring(0,temp+4);\r\n");
      out.write("var div_num=node.getElementsByTagName('DIV');\r\n");
      out.write("if(div_num.length>0){\r\n");
      out.write("var nodeArray = node.childNodes;\r\n");
      out.write("        for(i=0; i < nodeArray.length; i++)\r\n");
      out.write("       {\r\n");
      out.write("          node = nodeArray[i];\r\n");
      out.write("        if (node.tagName && node.tagName.toLowerCase() == 'a'){\r\n");
      out.write("         var img=node.getElementsByTagName('IMG');\r\n");
      out.write("img[0].src = (img[0].src == img[0].src.substring(0,img[0].src.lastIndexOf('/')+1)+'side.gif') ?img[0].src.substring(0,img[0].src.lastIndexOf('/')+1)+'down.gif': img[0].src.substring(0,img[0].src.lastIndexOf('/')+1)+'side.gif';\r\n");
      out.write("\t\t   node.style.color = (node.style.color == '#1D27F3') ? '#000000' : '#000000';\r\n");
      out.write("        }\r\n");
      out.write("        if (node.tagName && node.tagName.toLowerCase() == 'div'){\r\n");
      out.write("        node.style.display = (node.style.display == 'block') ? 'none' : 'block';\r\n");
      out.write("\t\t}\r\n");
      out.write("        }\r\n");
      out.write("}else{\r\n");
      out.write("DWREngine.setAsync(true);\r\n");
      out.write("NseerModuleTreeNode.Category(id,tablename,{callback:function(msg){\r\n");
      out.write("node.innerHTML=temp+msg;\r\n");
      out.write("var nodeArray = node.childNodes;\r\n");
      out.write("        for(i=0; i < nodeArray.length; i++)\r\n");
      out.write("        {\r\n");
      out.write("          node = nodeArray[i];\r\n");
      out.write("\t\t  if (node.tagName && node.tagName.toLowerCase() == 'a'){\r\n");
      out.write("\t\t\t  var img=node.getElementsByTagName('IMG');\r\n");
      out.write("           img[0].src = img[0].src.substring(0,img[0].src.lastIndexOf('/')+1)+'down.gif'; \r\n");
      out.write("\t\t  node.style.color = (node.style.display == 'block') ? '#000000' : '#000000';\r\n");
      out.write("       }\r\n");
      out.write("          if (node.tagName && node.tagName.toLowerCase() == 'div'){\r\n");
      out.write("            node.style.display = (node.style.display == 'block') ? 'none' : 'block';\r\n");
      out.write("       }\r\n");
      out.write("\t\t}\r\n");
      out.write("}});\r\n");
      out.write("DWREngine.setAsync(true);\r\n");
      out.write("}}\r\n");
      out.write("var nowli;\r\n");
      out.write("function changeColor(obj,path){\r\n");
      out.write("window.status=\"科技强医 \"\r\n");
      out.write("obj.href=path\r\n");
      out.write("obj.target=\"content\"\r\n");
      out.write("if(nowli!=null)\r\n");
      out.write("{\t \r\n");
      out.write("nowli.id = \"\";\t\r\n");
      out.write("nowli.parentNode.style.background='#ffffff';\r\n");
      out.write("var span1=nowli.parentNode.getElementsByTagName('span');\r\n");
      out.write("span1[0].style.visibility = \"visible\";\r\n");
      out.write("}\r\n");
      out.write("obj.id = \"main_cur\";\r\n");
      out.write("obj.parentNode.style.background='#FFA54A';\r\n");
      out.write("var span=obj.parentNode.getElementsByTagName('span');\r\n");
      out.write("span[0].style.visibility = \"hidden\";\r\n");
      out.write("nowli = obj;\r\n");
      out.write("}\r\n");
      out.write("function chgColor(obj){\r\n");
      out.write("if(nowli!=null)\r\n");
      out.write("{\t \r\n");
      out.write("nowli.id = \"\";\t\r\n");
      out.write("nowli.parentNode.style.background='#ffffff';\r\n");
      out.write("var span1=nowli.parentNode.getElementsByTagName('span');\r\n");
      out.write("span1[0].style.visibility = \"visible\";\r\n");
      out.write("}\r\n");
      out.write("obj.id = \"main_cur\";\r\n");
      out.write("obj.parentNode.style.background='#FFA54A';\r\n");
      out.write("var span=obj.parentNode.getElementsByTagName('span');\r\n");
      out.write("span[0].style.visibility = \"hidden\";\r\n");
      out.write("nowli = obj;\r\n");
      out.write("}\r\n");
      out.write("</script>\r\n");
      out.write("<body>\r\n");
      out.write("<div style=\"position:absolute;top:0px;left:0px\" id=\"root1\">\r\n");

String sql1 = "select * from "+tree_view_name+" where PARENT_CATEGORY_ID='"+category_id+"' and human_id='"+human_ID+"'";
ResultSet rs =db.executeQuery(sql1);
while(rs.next()){
if(rs.getString("details_tag").equals("1")){
      out.write("\r\n");
      out.write("<div class=\"root\"><a href=\"\" onclick=\"toggleNode(this.parentNode,'");
      out.print(rs.getString("CATEGORY_ID"));
      out.write('\'');
      out.write(',');
      out.write('\'');
      out.print(tree_view_name.split("_")[0]);
      out.write("'); return false;\" style=\"background-image:url(images/tree/l.gif);width:100%;\"><span style=\"padding:0px 0px 0px 3px\"><img src=\"images/side.gif\" align=\"absmiddle\" style=\"border: 0;\" ></span><span style=\"padding:0px 0px 0px 8px\">");
      out.print(rs.getString("file_name"));
      out.write("</span></a></div>\r\n");
}else{
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<div style=\"background:#ffffff;width:100%;\"><span style=\"padding:0px 0px 0px 3px\"><img src=\"images/tree/2.gif\" align=\"absmiddle\" style=\"border: 0;\" ></span><span style=\"padding:0px 0px 0px 8px\" ></span><A HREF=\"/erp/");
      out.print(rs.getString("file_path"));
      out.print(rs.getString("hreflink"));
      out.write("\" target=\"content\" onclick=\"chgColor(this);\">");
      out.print(rs.getString("file_name"));
      out.write("</A></div>\r\n");
      out.write("\r\n");
      out.write("\r\n");
}}
db.close();
      out.write("\r\n");
      TreeMiddle.wr(out);
      out.write("</div>\r\n");
      out.write("</body>\r\n");
      out.write("<script>\r\n");
      out.write("window.onload=function (){\r\n");
      out.write("document.getElementById('root1').style.width=document.body.clientWidth+'px';\r\n");
      out.write("}\r\n");
      out.write("window.onresize=function (){\r\n");
      out.write("document.getElementById('root1').style.width=document.body.clientWidth+'px';\r\n");
      out.write("}\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
}
catch (Exception ex){
ex.printStackTrace();
}
}
}