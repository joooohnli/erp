package draft.manufacture;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import java.text.*;

import include.nseer_cookie.NseerId;
import include.nseer_cookie.exchange;
import validata.ValidataNumber;
import include.nseer_cookie.counter;
import validata.ValidataRecord;

public class moduleBalance_draft_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);
ValidataNumber validata=new ValidataNumber();
counter count=new counter(dbApplication);
ValidataRecord vr=new ValidataRecord();
String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);
try{
	if(manufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))&&stock_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String checker_ID=request.getParameter("checker_ID") ;
String config_id=request.getParameter("config_id");
String manufacture_ID=request.getParameter("manufacture_ID") ;
String module_time=request.getParameter("module_time");
String procedure_ID=request.getParameter("procedure_ID") ;
String procedure_name=request.getParameter("procedure_name") ;
String register_time=request.getParameter("register_time") ;
String procedure_responsible_person=request.getParameter("procedure_responsible_person") ;
String checker=request.getParameter("checker") ;
String[] product_IDn=request.getParameterValues("product_ID") ;
String bodyc = new String(request.getParameter("reason").getBytes("UTF-8"),"UTF-8");
String reason=exchange.toHtml(bodyc);
String product_amount=request.getParameter("product_amount") ;
String[] product_namen=request.getParameterValues("product_name") ;
String[] product_describen=request.getParameterValues("product_describe") ;
String[] cost_pricen=request.getParameterValues("cost_price") ;
String[] amountn=request.getParameterValues("amount") ;
String[] amount_unitn=request.getParameterValues("amount_unit") ;
int num=Integer.parseInt(product_amount);
int p=0;
int m=0;
String product_ID_group=",";
for(int i=1;i<=num;i++){
	String tem_amount="amount"+i;
	String amount=request.getParameter(tem_amount) ;
	if(!validata.validata(amount)){
			p++;
		}
}
for(int j=1;j<product_namen.length;j++){
	product_ID_group+=product_IDn[j]+",";
	if(!validata.validata(amountn[j])){
		p++;
	}
}
for(int i=1;i<=num;i++){
	String tem_product_ID="product_ID"+i;
	String product_ID=request.getParameter(tem_product_ID) ;
	if(product_ID_group.indexOf(product_ID)!=-1) m++;
}
String sql88="select * from manufacture_module_balance where manufacture_ID='"+manufacture_ID+"' and module_time='"+module_time+"' and procedure_name='"+procedure_name+"' and (check_tag='9' or check_tag='5')";
ResultSet rs88=manufacture_db.executeQuery(sql88);
if(rs88.next()){
if(p==0){
if(m==0){
	String pay_ID=NseerId.getId("stock/pay",(String)dbSession.getAttribute("unit_db_name"));

try{	
	double cost_price_sum=0.0d;
double demand_amount=0.0d;
for(int i=1;i<=num;i++){
	String tem_product_name="product_name"+i;
	String tem_product_ID="product_ID"+i;
	String tem_product_describe="product_describe"+i;
	String tem_amount="amount"+i;
	String tem_amount_unit="amount_unit"+i;
	String tem_cost_price="cost_price"+i;
String product_name=request.getParameter(tem_product_name) ;
String product_ID=request.getParameter(tem_product_ID) ;
String product_describe=request.getParameter(tem_product_describe) ;
String amount=request.getParameter(tem_amount) ;
String amount_unit=request.getParameter(tem_amount_unit) ;
String cost_price2=request.getParameter(tem_cost_price) ;
StringTokenizer tokenTO3 = new StringTokenizer(cost_price2,",");        
String cost_price="";
            while(tokenTO3.hasMoreTokens()) {
                String cost_price1 = tokenTO3.nextToken();
		cost_price +=cost_price1;
		}
	double subtotal=Double.parseDouble(cost_price)*Double.parseDouble(amount);
	cost_price_sum+=subtotal;
	demand_amount+=Double.parseDouble(amount);
	 String sql2 = "update manufacture_module_balance_details set amount='"+amount+"',subtotal='"+subtotal+"' where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"' and register_time='"+register_time+"' and details_number='"+i+"'" ;
	manufacture_db.executeUpdate(sql2) ;

}

for(int j=1;j<product_namen.length;j++){
	StringTokenizer tokenTO2 = new StringTokenizer(cost_pricen[j],",");        
	String cost_price="";
            while(tokenTO2.hasMoreTokens()) {
                String cost_price1 = tokenTO2.nextToken();
		cost_price +=cost_price1;
		}
	double subtotal=Double.parseDouble(cost_price)*Double.parseDouble(amountn[j]);
	cost_price_sum+=subtotal;
	int details_number=num+j;

	String sql4 = "insert into manufacture_module_balance_details(manufacture_ID,procedure_name,details_number,product_ID,product_name,product_describe,amount,cost_price,amount_unit,subtotal,register_time,module_time) values ('"+manufacture_ID+"','"+procedure_name+"','"+details_number+"','"+product_IDn[j]+"','"+product_namen[j]+"','"+product_describen[j]+"','"+amountn[j]+"','"+cost_price+"','"+amount_unitn[j]+"','"+subtotal+"','"+register_time+"','"+module_time+"')" ;
	manufacture_db.executeUpdate(sql4) ;
}
String sql3 = "update manufacture_module_balance set module_cost_price_sum='"+cost_price_sum+"',procedure_responsible_person='"+procedure_responsible_person+"',checker='"+checker+"',reason='"+reason+"' where manufacture_ID='"+manufacture_ID+"' and module_time='"+module_time+"' and procedure_name='"+procedure_name+"' and module_time='"+module_time+"'";
manufacture_db.executeUpdate(sql3) ;		
}
catch (Exception ex){
ex.printStackTrace();
}
	response.sendRedirect("draft/manufacture/moduleBalance_ok.jsp?finished_tag=0");
}else{	
	response.sendRedirect("draft/manufacture/moduleBalance_ok.jsp?finished_tag=6");
}
	}else{	
		response.sendRedirect("draft/manufacture/moduleBalance_ok.jsp?finished_tag=5");
	}
	}else{
	response.sendRedirect("draft/manufacture/moduleBalance_ok.jsp?finished_tag=1");
	}
	manufacture_db.commit();
    stock_db.commit();
	stock_db.close();
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