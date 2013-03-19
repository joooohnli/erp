package security.user;
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.io.* ;
import include.tree_index.Nseer;
import include.nseer_db.*;
import include.nseer_cookie.*;

public class change_module_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
ServletContext dbApplication=dbSession.getServletContext();
try{
InsMod im=new InsMod();
nseer_db_backup1 db = new nseer_db_backup1(dbApplication);
String human_name=request.getParameter("human_name");
String human_ID=request.getParameter("human_ID");
String choose_value=request.getParameter("choose_value");
String[] file_id=request.getParameterValues("file_id");
if(db.conn((String)dbSession.getAttribute("unit_db_name"))){
db.executeUpdate("delete from "+choose_value.split("/")[0]+"_view where module_name!='all' and human_ID='"+human_ID+"'");
db.executeUpdate("delete from security_workspace where human_ID='"+human_ID+"' and view_tree_name='"+choose_value.split("/")[0]+"'");
db.executeUpdate("delete from drag_img where human_ID='"+human_ID+"' and tree_view_name='"+choose_value.split("/")[0]+"_view'");
if(file_id!=null){
for(int i=0;i<file_id.length;i++){
im.insert(choose_value.split("/")[0],human_ID,human_name,file_id[i],db);
im.insertw(choose_value.split("/")[0],choose_value.split("/")[1],human_ID,db);
}
}
db.commit();
db.close();
response.sendRedirect("security/user/change_module_ok_a.jsp?human_ID="+human_ID+"&&module="+toUtf8String.utf8String(exchange.toURL(choose_value.split("/")[1]))+"&&human_name="+toUtf8String.utf8String(exchange.toURL(human_name)));
}else{
response.sendRedirect("error_conn.htm");
}
}catch (Exception ex){
ex.printStackTrace();
}
}
}