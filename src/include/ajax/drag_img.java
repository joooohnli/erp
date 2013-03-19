package include.ajax;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.io.*;
import include.nseer_db.*;
import include.tree_index.Nseer;
import include.ajax.ajax_businessComment;

public class drag_img extends HttpServlet{
ServletContext application;
HttpSession session;
nseer_db_backup erp_db = null;
Nseer n=new Nseer();
public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
try{
PrintWriter out=response.getWriter();
nseer_db_backup db = new nseer_db_backup(dbApplication);
nseer_db_backup db1 = new nseer_db_backup(dbApplication);
if(db.conn((String)dbSession.getAttribute("unit_db_name"))&&db1.conn((String)dbSession.getAttribute("unit_db_name"))){
String human_ID=(String)dbSession.getAttribute("human_IDD");
String id=request.getParameter("id") ;
String link=request.getParameter("link") ;
String drag_text=request.getParameter("drag_text") ;
String drag_img_top=request.getParameter("drag_img_top") ;
String drag_img_left=request.getParameter("drag_img_left") ;
String drag_img_name=request.getParameter("drag_img_name") ;
String tree_view_name=request.getParameter("tree_view_name") ;
String category=request.getParameter("category") ;
String groupName="";
if(tree_view_name.indexOf("_")!=-1){
	groupName=tree_view_name.substring(0,tree_view_name.indexOf("_"))+"Tree";
}
ajax_businessComment demo = new ajax_businessComment();
demo.setPath(request);
multi_businessComment mdemo = new multi_businessComment();
String sql="select * from "+tree_view_name+" where category_id='"+category+"' and human_id='"+human_ID+"' order by id";
ResultSet rs1=db1.executeQuery(sql);
String firstworkname="";
String file_id="";
if(rs1.next()){
file_id=rs1.getString("file_id");
}
String sql2="";
sql2="select * from "+tree_view_name+" where human_id='"+human_ID+"' order by id";
ResultSet rs2=db1.executeQuery(sql2);
while(rs2.next()){
if(!rs2.getString("hreflink").equals("")&&rs2.getString("file_path").indexOf("config")==-1&&rs2.getString("file_id").indexOf(file_id)==0){
firstworkname=rs2.getString("file_path")+rs2.getString("hreflink");
rs2.last();
}
}
String sq="select * from drag_img where img_id='"+id+"' and human_ID='"+human_ID+"'";
ResultSet rs=db.executeQuery(sq);

if(!rs.next()){
String sq11="insert into drag_img(drag_img_top,drag_img_left,drag_img_name,drag_text,link,img_id,tree_view_name,category,human_ID,firstworkname)values('"+drag_img_top+"','"+drag_img_left+"','"+drag_img_name+"','"+drag_text+"','"+link+"','"+id+"','"+tree_view_name+"','"+category+"','"+human_ID+"','"+firstworkname+"')";
db.executeUpdate(sq11) ;
if(drag_text.indexOf("--")==-1){
	out.println("1,"+demo.getLang("erp",drag_text));
}else{
	out.println("1,"+mdemo.getLang(demo,groupName,drag_text));
}
}else{
if(drag_text.indexOf("--")==-1){
	out.println("2,"+demo.getLang("erp",drag_text));
}else{
	out.println("2,"+mdemo.getLang(demo,groupName,drag_text));
}
}
db1.close();
db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
ex.printStackTrace();
}
}
}





