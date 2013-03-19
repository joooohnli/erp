package draft.design;
 
import include.nseer_cookie.GetWorkflow;
import include.nseer_cookie.exchange;
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.Iterator;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

import validata.ValidataNumber;

public class design_check_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 design_db = new nseer_db_backup1(dbApplication);
ValidataNumber validata=new ValidataNumber();
try{
if(design_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String design_ID=request.getParameter("design_ID") ;
String[] product_IDn=request.getParameterValues("product_ID") ;
String product_amount=request.getParameter("product_amount") ;
int num=Integer.parseInt(product_amount);
int m=0;
for(int j=1;j<product_IDn.length;j++){
	String sql3="select * from design_module_details where design_ID='"+design_ID+"' and product_ID='"+product_IDn[j]+"'";
	ResultSet rs3=design_db.executeQuery(sql3) ;
	if(rs3.next()){
		m++;
	}
}
if(num==0&&product_IDn.length==1){
	response.sendRedirect("draft/design/design_ok_a.jsp?design_ID="+design_ID);
}else{
	if(m!=0){
		response.sendRedirect("draft/design/design_ok_c.jsp?design_ID="+design_ID+"");
	}else{
int n=0;
for(int i=1;i<=num;i++){
	String tem_amount="amount"+i;
String amount=request.getParameter(tem_amount) ;
		if(!validata.validata(amount)){
			n++;
		}
}
String[] amountn=request.getParameterValues("amount") ;
for(int j=1;j<product_IDn.length;j++){
		if(!validata.validata(amountn[j])){
			n++;
		}
}
if(n==0){
String designer=request.getParameter("designer") ;
String bodyc = new String(request.getParameter("module_describe").getBytes("UTF-8"),"UTF-8");
String module_describe=exchange.toHtml(bodyc);
String register_time=request.getParameter("register_time") ;
String register=request.getParameter("register") ;
try{
	String sql = "update design_module set register_time='"+register_time+"',register='"+register+"',designer='"+designer+"',module_describe='"+module_describe+"' where design_ID='"+design_ID+"'" ;
	design_db.executeUpdate(sql) ;
double cost_price_sum=0.0d;
for(int i=1;i<=num;i++){
	String tem_product_name="product_name"+i;
	String tem_product_ID="product_ID"+i;
	String tem_type="type"+i;
	String tem_product_describe="product_describe"+i;
	String tem_amount="amount"+i;
	String tem_amount_unit="amount_unit"+i;
	String tem_cost_price="cost_price"+i;
String product_name=request.getParameter(tem_product_name) ;
String product_ID=request.getParameter(tem_product_ID) ;
String type=request.getParameter(tem_type) ;
String product_describe=request.getParameter(tem_product_describe) ;
String amount=request.getParameter(tem_amount) ;
String amount_unit=request.getParameter(tem_amount_unit) ;
String cost_price2=request.getParameter(tem_cost_price) ;
StringTokenizer tokenTO3 = new StringTokenizer(cost_price2,",");        
String cost_price="";
            while(tokenTO3.hasMoreTokens()){
                String cost_price1 = tokenTO3.nextToken();
		cost_price +=cost_price1;
		}
	double subtotal=Double.parseDouble(cost_price)*Double.parseDouble(amount);
	cost_price_sum+=subtotal;
	String sql1 = "update design_module_details set details_number='"+i+"',product_ID='"+product_ID+"',product_name='"+product_name+"',product_describe='"+product_describe+"',type='"+type+"',amount='"+amount+"',cost_price='"+cost_price+"',amount_unit='"+amount_unit+"',subtotal='"+subtotal+"' where design_ID='"+design_ID+"' and product_ID='"+product_ID+"'" ;
	design_db.executeUpdate(sql1) ;
}
String[] product_namen=request.getParameterValues("product_name") ;
String[] typen=request.getParameterValues("type") ;
String[] product_describen=request.getParameterValues("product_describe") ;
String[] amountm=request.getParameterValues("amount") ;
String[] amount_unitn=request.getParameterValues("amount_unit") ;
String[] cost_pricen=request.getParameterValues("cost_price") ;
for(int j=1;j<product_IDn.length;j++){
	StringTokenizer tokenTO4 = new StringTokenizer(cost_pricen[j],",");        
	String cost_price4="";
            while(tokenTO4.hasMoreTokens()) {
                String cost_price3 = tokenTO4.nextToken();
		cost_price4 +=cost_price3;
		}
	double subtotal=Double.parseDouble(cost_price4)*Double.parseDouble(amountm[j]);
	cost_price_sum+=subtotal;
	int details_number=num+j;
	String sql4 = "insert into design_module_details(design_ID,details_number,product_ID,product_name,type,product_describe,amount,cost_price,amount_unit,subtotal) values ('"+design_ID+"','"+details_number+"','"+product_IDn[j]+"','"+product_namen[j]+"','"+typen[j]+"','"+product_describen[j]+"','"+amountm[j]+"','"+cost_price4+"','"+amount_unitn[j]+"','"+subtotal+"')" ;
	design_db.executeUpdate(sql4) ;
}

List rsList = GetWorkflow.getList(design_db, "design_config_workflow", "03");
	String[] elem=new String[3];
	String sql2="";
	if(rsList.size()==0){
sql2="update design_module set cost_price_sum='"+cost_price_sum+"',check_tag='1',change_tag='1' where design_ID='"+design_ID+"'";
design_db.executeUpdate(sql2) ;
}else{
		sql2="delete from design_workflow where object_ID='"+design_ID+"'";
		design_db.executeUpdate(sql2) ;

sql2="update design_module set cost_price_sum='"+cost_price_sum+"',check_tag='0',change_tag='1' where design_ID='"+design_ID+"'";
design_db.executeUpdate(sql2) ;

Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		elem=(String[])ite.next();
		sql2 = "insert into design_workflow(config_id,object_ID,describe1,describe2,type_id) values ('"+elem[0]+"','"+design_ID+"','"+elem[1]+"','"+elem[2]+"','03')" ;
		design_db.executeUpdate(sql2) ;
		}
	}
}
catch (Exception ex){
ex.printStackTrace();
}
	response.sendRedirect("draft/design/design_ok.jsp?finished_tag=4");
		}else{
			response.sendRedirect("draft/design/design_ok_b.jsp?design_ID="+design_ID+"");
		}
	}
}
design_db.commit();
design_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}
