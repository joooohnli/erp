package draft.stock;
 
import include.nseer_cookie.NseerId;
import include.nseer_cookie.counter;
import include.nseer_cookie.exchange;
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.text.SimpleDateFormat;
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
import validata.ValidataRecord;
import validata.ValidataTag;

public class transferPay_draft_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);
ValidataNumber validata=new ValidataNumber();
counter count=new counter(dbApplication);
ValidataTag vt=new ValidataTag();
ValidataRecord vr=new ValidataRecord();

try{
if(stock_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String checker_ID=(String)session.getAttribute("human_IDD");//**************
String config_id=request.getParameter("config_id");//****************
String pay_ID=request.getParameter("pay_ID") ;
String product_amount=request.getParameter("product_amount") ;
int num=Integer.parseInt(product_amount);
String reasonexact=request.getParameter("reasonexact") ;
StringTokenizer tokenTO =null;
String stock_ID ="";
String stock_name="";
if(!reasonexact.equals("  /")){
tokenTO = new StringTokenizer(reasonexact,"/");        

            while(tokenTO.hasMoreTokens()) {
                stock_ID = tokenTO.nextToken();
				stock_name = tokenTO.nextToken();
		}
}else{
   tokenTO = new StringTokenizer(reasonexact,"/");        
     if(tokenTO.hasMoreTokens()) {
         stock_ID = tokenTO.nextToken();}
}
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String check_time=request.getParameter("check_time") ;
String checker=request.getParameter("checker") ;
String bodyc = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyc);
String[] product_IDn=request.getParameterValues("product_ID") ;
String[] amountn=request.getParameterValues("amount") ;
int p=0;
for(int i=1;i<=num;i++){
	String tem_amount="amount"+i;
String amount=request.getParameter(tem_amount) ;
if(amount.equals("")) amount="0";
	if(!validata.validata(amount)){
			p++;
		}
}
String product_ID_group=",";
for(int j=1;j<product_IDn.length;j++){
	product_ID_group+=product_IDn[j]+",";
		if(!validata.validata(amountn[j])){
			p++;
		}
}
if(num==0&&product_IDn.length==1){
	response.sendRedirect("draft/stock/transferPay_ok_c.jsp?pay_ID="+pay_ID+"");
}else{
int m=0;
for(int i=1;i<=num;i++){
	String tem_product_ID="product_ID"+i;
	String product_ID=request.getParameter(tem_product_ID) ;
	if(product_ID_group.indexOf(product_ID)!=-1) m++;
}
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"stock_transfer_pay","pay_ID",pay_ID,"check_tag").equals("5")||vt.validata((String)dbSession.getAttribute("unit_db_name"),"stock_transfer_pay","pay_ID",pay_ID,"check_tag").equals("9")){
if(p==0){
if(m==0){
int n=0;
double cost_price_sum=0.0d;
double demand_amount=0.0d;
for(int i=1;i<=num;i++){
	String tem_amount="amount"+i;
	String tem_balance_amount="balance_amount"+i;
	String amount=request.getParameter(tem_amount);
	if(amount.equals("")) amount="0";
	String balance_amount=request.getParameter(tem_balance_amount) ;
	if(Double.parseDouble(amount)>Double.parseDouble(balance_amount)){
		n++;
	}
}
String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);

String stock_gather_ID=NseerId.getId("stock/gather",(String)dbSession.getAttribute("unit_db_name"));
String stock_pay_ID=NseerId.getId("stock/pay",(String)dbSession.getAttribute("unit_db_name"));

try{
	
for(int i=1;i<=num;i++){
	String tem_product_name="product_name"+i;
	String tem_product_ID="product_ID"+i;
	String tem_amount="amount"+i;
	String tem_cost_price="cost_price"+i;
String product_name=request.getParameter(tem_product_name) ;
String product_ID=request.getParameter(tem_product_ID) ;
String amount=request.getParameter(tem_amount) ;
if(amount.equals("")) amount="0";
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
	String sql1 = "update stock_transfer_pay_details set product_ID='"+product_ID+"',product_name='"+product_name+"',amount='"+amount+"',cost_price='"+cost_price+"',subtotal='"+subtotal+"' where pay_ID='"+pay_ID+"' and details_number='"+i+"'" ;
	stock_db.executeUpdate(sql1) ;
}
String[] cost_pricen=request.getParameterValues("cost_price") ;
product_IDn=request.getParameterValues("product_ID") ;
String[] product_namen=request.getParameterValues("product_name") ;
String[] amount_unitn=request.getParameterValues("amount_unit") ;
String[] product_describen=request.getParameterValues("product_describe") ;
amountn=request.getParameterValues("amount") ;
for(int i=1;i<product_IDn.length;i++){
	StringTokenizer tokenTO3 = new StringTokenizer(cost_pricen[i],",");        
	String cost_price="";
            while(tokenTO3.hasMoreTokens()) {
                String cost_price1 = tokenTO3.nextToken();
		cost_price +=cost_price1;
		}
	if(!amountn[i].equals("")&&Double.parseDouble(amountn[i])!=0){
	double subtotal=Double.parseDouble(cost_price)*Double.parseDouble(amountn[i]);
	cost_price_sum+=subtotal;
	num++;
	demand_amount+=Double.parseDouble(amountn[i]);

	String sql1 = "insert into stock_transfer_pay_details(pay_ID,details_number,product_ID,product_name,product_describe,amount_unit,amount,cost_price,subtotal) values ('"+pay_ID+"','"+num+"','"+product_IDn[i]+"','"+product_namen[i]+"','"+product_describen[i]+"','"+amount_unitn[i]+"','"+amountn[i]+"','"+cost_pricen[i]+"','"+subtotal+"')" ;
	stock_db.executeUpdate(sql1) ;
	}
}
String sql ="update stock_transfer_pay set reasonexact='"+reasonexact+"',register='"+register+"',register_time='"+register_time+"',check_time='"+check_time+"',checker='"+checker+"',remark='"+remark+"',demand_amount='"+demand_amount+"',cost_price_sum='"+cost_price_sum+"' where pay_ID='"+pay_ID+"'" ;
		stock_db.executeUpdate(sql);
}
catch (Exception ex){
ex.printStackTrace();
}
response.sendRedirect("draft/stock/transferPay_ok.jsp?finished_tag=0");
}else{
	response.sendRedirect("draft/stock/transferPay_ok_a.jsp?pay_ID="+pay_ID);
}
}else{
	response.sendRedirect("draft/stock/transferPay_ok_b.jsp?pay_ID="+pay_ID);
}
}else{
response.sendRedirect("draft/stock/transferPay_ok.jsp?finished_tag=2");
}
}
	stock_db.commit();
	stock_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}