package draft.purchase;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import java.util.* ;
import include.nseer_db.*;
import include.nseer_cookie.exchange;
import include.nseer_cookie.counter;
import validata.ValidataTag;
import include.nseer_cookie.*;

public class productProvider_garbage_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
try{

ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 purchase_db = new nseer_db_backup1(dbApplication);
if(purchase_db.conn((String)dbSession.getAttribute("unit_db_name"))){

counter count=new counter(dbApplication);
ValidataTag vt=new ValidataTag();
String product_providers_recommend_ID=request.getParameter("product_providers_recommend_ID") ;
String[] provider_IDn=request.getParameterValues("provider_ID") ;
int m=0;
for(int j=1;j<provider_IDn.length;j++){
	String sql3="select * from purchase_product_providers_recommend_details where product_providers_recommend_ID='"+product_providers_recommend_ID+"' and provider_ID='"+provider_IDn[j]+"'";
	ResultSet rs3=purchase_db.executeQuery(sql3) ;
	if(rs3.next()){
		String provider_ID_repeat=rs3.getString("provider_ID");
		m++;
	}
}
String provider_amount=request.getParameter("provider_amount") ;
int num=Integer.parseInt(provider_amount);
if(m!=0){
response.sendRedirect("draft/purchase/productProvider_ok_a.jsp?product_providers_recommend_ID="+product_providers_recommend_ID+"");
}else if(num==0&&provider_IDn.length==1){
	response.sendRedirect("draft/purchase/productProvider_ok_b.jsp?product_providers_recommend_ID="+product_providers_recommend_ID+"");
	}else{
	String recommender=request.getParameter("recommender") ;
String bodyc = new String(request.getParameter("recommend_describe").getBytes("UTF-8"),"UTF-8");
String recommend_describe=exchange.toHtml(bodyc);
String change_time=request.getParameter("change_time") ;
String changer=request.getParameter("changer") ;
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"purchase_product_providers_recommend","product_providers_recommend_ID",product_providers_recommend_ID,"check_tag").equals("5")||vt.validata((String)dbSession.getAttribute("unit_db_name"),"purchase_product_providers_recommend","product_providers_recommend_ID",product_providers_recommend_ID,"check_tag").equals("9")){
try{
for(int i=1;i<=num;i++){
	String tem_provider_name="provider_name"+i;
	String tem_provider_ID="provider_ID"+i;
String provider_name=request.getParameter(tem_provider_name) ;
String provider_ID=request.getParameter(tem_provider_ID) ;
	String sql1 = "update purchase_product_providers_recommend_details set details_number='"+i+"' where product_providers_recommend_ID='"+product_providers_recommend_ID+"' and provider_ID='"+provider_ID+"'" ;
	purchase_db.executeUpdate(sql1) ;
}
String[] provider_namen=request.getParameterValues("provider_name") ;
for(int j=1;j<provider_IDn.length;j++){
	int details_number=num+j;
	String sql4 = "insert into purchase_product_providers_recommend_details(product_providers_recommend_ID,details_number,provider_ID,provider_name) values ('"+product_providers_recommend_ID+"','"+details_number+"','"+provider_IDn[j]+"','"+provider_namen[j]+"')" ;
	purchase_db.executeUpdate(sql4) ;
}
String sql="update purchase_product_providers_recommend set check_tag='2' where product_providers_recommend_ID='"+product_providers_recommend_ID+"'";
purchase_db.executeUpdate(sql) ;


}
catch (Exception ex){
ex.printStackTrace();
}
response.sendRedirect("draft/purchase/productProvider_ok.jsp?finished_tag=2");
}else{
response.sendRedirect("draft/purchase/productProvider_ok.jsp?finished_tag=3");
}
  }
		purchase_db.commit();	
purchase_db.close();

  }else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
} 