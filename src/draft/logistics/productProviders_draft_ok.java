package draft.logistics;

import include.nseer_cookie.counter;
import include.nseer_cookie.exchange;
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.sql.ResultSet;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

import validata.ValidataTag;

public class productProviders_draft_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
try{

ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 logistics_db = new nseer_db_backup1(dbApplication);
if(logistics_db.conn((String)dbSession.getAttribute("unit_db_name"))){

ValidataTag vt=new ValidataTag();
String product_logistics_recommend_ID=request.getParameter("product_logistics_recommend_ID") ;
String[] provider_IDn=request.getParameterValues("provider_ID") ;
int m=0;
for(int j=1;j<provider_IDn.length;j++){
	String sql3="select * from logistics_product_providers_recommend_details where product_logistics_recommend_ID='"+product_logistics_recommend_ID+"' and provider_ID='"+provider_IDn[j]+"'";
	ResultSet rs3=logistics_db.executeQuery(sql3) ;
	if(rs3.next()){
		m++;
	}
}
String provider_amount=request.getParameter("provider_amount") ;
int num=Integer.parseInt(provider_amount);
if(m!=0){
	response.sendRedirect("draft/logistics/productProviders_ok_a.jsp?product_logistics_recommend_ID="+product_logistics_recommend_ID+"");
}else if(num==0&&provider_IDn.length==1){
	response.sendRedirect("draft/logistics/productProviders_ok_b.jsp?product_logistics_recommend_ID="+product_logistics_recommend_ID+"");
	}else{
String bodyc = new String(request.getParameter("recommend_describe").getBytes("UTF-8"),"UTF-8");
String recommend_describe=exchange.toHtml(bodyc);
String register=request.getParameter("register") ;
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"logistics_product_providers_recommend","product_logistics_recommend_ID",product_logistics_recommend_ID,"check_tag").equals("5")||vt.validata((String)dbSession.getAttribute("unit_db_name"),"logistics_product_providers_recommend","product_logistics_recommend_ID",product_logistics_recommend_ID,"check_tag").equals("9")){
try{
for(int i=1;i<=num;i++){
	String tem_provider_ID="provider_ID"+i;
	String provider_ID=request.getParameter(tem_provider_ID) ;
	String sql1 = "update logistics_product_providers_recommend_details set details_number='"+i+"' where product_logistics_recommend_ID='"+product_logistics_recommend_ID+"' and provider_ID='"+provider_ID+"'" ;
	logistics_db.executeUpdate(sql1) ;
}
String[] provider_namen=request.getParameterValues("provider_name") ;
for(int j=1;j<provider_IDn.length;j++){
	int details_number=num+j;
	String sql4 = "insert into logistics_product_providers_recommend_details(product_logistics_recommend_ID,details_number,provider_ID,provider_name) values ('"+product_logistics_recommend_ID+"','"+details_number+"','"+provider_IDn[j]+"','"+provider_namen[j]+"')" ;
	logistics_db.executeUpdate(sql4) ;
}
String sql="update logistics_product_providers_recommend set recommend_describe='"+recommend_describe+"',register='"+register+"' where product_logistics_recommend_ID='"+product_logistics_recommend_ID+"'";
logistics_db.executeUpdate(sql) ;


}
catch (Exception ex){
ex.printStackTrace();
}
response.sendRedirect("draft/logistics/productProviders_ok.jsp?finished_tag=0");
}else{
response.sendRedirect("draft/logistics/productProviders_ok.jsp?finished_tag=1");
}
  }
		logistics_db.commit();	
logistics_db.close();

  }else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
} 