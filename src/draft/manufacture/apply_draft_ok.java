package draft.manufacture;
 
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

import validata.ValidataNumber;

public class apply_draft_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication);
counter count=new counter(dbApplication);
ValidataNumber validata=new ValidataNumber();

try{
	if(manufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String apply_ID=request.getParameter("apply_ID") ;
String[] product_IDn=request.getParameterValues("product_ID") ;
String[] amount1=request.getParameterValues("amount") ;
String product_amount=request.getParameter("product_amount") ;
int num=Integer.parseInt(product_amount);
int m=0;
int n=0;
for(int i=1;i<=num;i++){
	String tem_amount="amount"+i;
String amount=request.getParameter(tem_amount) ;
		if(!validata.validata(amount)){
			n++;
		}
}
for(int j=1;j<product_IDn.length;j++){
	String sql3="select * from manufacture_apply where apply_ID='"+apply_ID+"' and product_ID='"+product_IDn[j]+"'";
	ResultSet rs3=manufacture_db.executeQuery(sql3) ;
	if(rs3.next()){
		m++;
	}
		if(!validata.validata(amount1[j])){
			n++;
		}
}
if(num==0&&product_IDn.length==1){
	response.sendRedirect("draft/manufacture/apply_ok_a.jsp?apply_ID="+apply_ID+"");
}else{
	if(m!=0){
		response.sendRedirect("draft/manufacture/apply_ok_b.jsp?apply_ID="+apply_ID+"");
	}else{
if(n==0){
String reason=request.getParameter("reason") ;
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String bodyb = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyb);
try{
	
	String sql1="delete from manufacture_apply where apply_ID='"+apply_ID+"' and product_ID=''";
			manufacture_db.executeUpdate(sql1) ;
			
	for(int i=1;i<=num;i++){
	String tem_real_cost_price="real_cost_price"+i;	
	String tem_product_name="product_name"+i;
	String tem_product_ID="product_ID"+i;
	String tem_product_describe="product_describe"+i;
	String tem_amount="amount"+i;
String real_cost_price=request.getParameter(tem_real_cost_price) ;
String product_name=request.getParameter(tem_product_name) ;
String product_ID=request.getParameter(tem_product_ID) ;
String product_describe=request.getParameter(tem_product_describe) ;
String amount=request.getParameter(tem_amount) ;
		 sql1 = "update manufacture_apply set product_ID='"+product_ID+"',product_name='"+product_name+"',product_describe='"+product_describe+"',amount='"+amount+"',remark='"+remark+"',pay_id_group='"+reason+"',register='"+register+"',register_time='"+register_time+"' where apply_ID='"+apply_ID+"' and product_ID='"+product_ID+"'";
	manufacture_db.executeUpdate(sql1) ;
	
}	
String[] amount_unitn=request.getParameterValues("amount_unit") ;
String[] real_cost_pricen=request.getParameterValues("real_cost_price") ;	
String[] product_namen=request.getParameterValues("product_name") ;
String[] product_describen=request.getParameterValues("product_describe") ;
String[] type=request.getParameterValues("type") ;
for(int j=1;j<product_IDn.length;j++){
	String sql4 = "insert into manufacture_apply(apply_ID,product_ID,product_name,product_describe,amount,remark,type,pay_id_group,register,register_time) values('"+apply_ID+"','"+product_IDn[j]+"','"+product_namen[j]+"','"+product_describen[j]+"','"+amount1[j]+"','"+remark+"','"+type[j]+"','"+reason+"','"+register+"','"+register_time+"')";
	manufacture_db.executeUpdate(sql4) ;
}
}
catch (Exception ex){
ex.printStackTrace();
}
response.sendRedirect("draft/manufacture/apply_ok.jsp?finished_tag=0");
}else{
	
	response.sendRedirect("draft/manufacture/apply_ok_c.jsp?apply_ID="+apply_ID+"");
}
  }
}
  manufacture_db.commit();
  manufacture_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
} 