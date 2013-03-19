package draft.stock;
 
 
import include.get_rate_from_ID.getRateFromID;
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.sql.ResultSet;
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

import stock.getLength;
import validata.ValidataNumber;

public class gather_draft_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);
ValidataNumber validata=new ValidataNumber();
getLength length=new getLength();
getRateFromID getRateFromID=new getRateFromID();
try{
if(stock_db.conn((String)dbSession.getAttribute("unit_db_name"))){

String gather_ID=request.getParameter("gather_ID");
String gathering_time=request.getParameter("gathering_time");
String[] stock_name=request.getParameterValues("stock_name");
String[] amount=request.getParameterValues("amount");
java.util.Date  now  =  new  java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String register=request.getParameter("register") ;
String register_ID=request.getParameter("register_id") ;
String register_time=request.getParameter("register_time") ;
String reason=request.getParameter("reason");
String reasonexact=request.getParameter("reasonexact");
String reasonexact_details=request.getParameter("reasonexact_details");
String[] id=request.getParameterValues("id");
String[] product_ID=request.getParameterValues("product_ID");
String[] product_name=request.getParameterValues("product_name");
String[] cost_price=request.getParameterValues("cost_price");
String[] demand_amount=request.getParameterValues("demand_amount") ;
String[] gathered_amount=request.getParameterValues("gathered_amount") ;
String[] gathered_subtotal=request.getParameterValues("gathered_subtotal");
String[] stock_ID=request.getParameterValues("stock_ID");
String[] nick_name=request.getParameterValues("nick_name");
String[] max_capacity_amount=request.getParameterValues("max_capacity_amount");
String[] details_number=request.getParameterValues("details_number");
String[] available_amount=request.getParameterValues("available_amount");
String[] serial_number_group=request.getParameterValues("serial_number_group");
	String stock_name_control=stock_name[0];
	String product_ID_control=product_ID[0];
	double amount_control=0.0d;
int p=0;
int lll=0;
for(int i=0;i<stock_name.length;i++){
	if(!amount[i].equals("")){
		if(!validata.validata(amount[i])){
			p++;
		}
	}else{
		amount[i]="0";
	}
	int serial_number_tag=0;
	String sql6="select * from stock_cell where product_ID='"+product_ID[i]+"' and check_tag='1'";
	ResultSet rs6=stock_db.executeQuery(sql6);
	if(rs6.next()){
		serial_number_tag=rs6.getInt("serial_number_tag");
	}
	if(serial_number_tag==1){
		lll=length.getLength((String)dbSession.getAttribute("unit_db_name"));
		}else{
			lll=length.getLength2((String)dbSession.getAttribute("unit_db_name"));
			}
	if(serial_number_tag!=0&&Double.parseDouble(amount[i])!=0&&serial_number_group[i].equals("")){
		p++;
	}else if(serial_number_tag==0&&Double.parseDouble(amount[i])!=0&&!serial_number_group[i].equals("")){
		p++;
	}

	if(!serial_number_group[i].equals("")){
	StringTokenizer tokenTO = new StringTokenizer(serial_number_group[i],", ");        
	while(tokenTO.hasMoreTokens()) {
		String serial_number_temp=tokenTO.nextToken();
		if(serial_number_temp.length()!=lll){
			p++;
		}

		if(serial_number_tag==1){
		String sql3="select * from stock_balance_details_details where serial_number='"+serial_number_temp+"' and stock_name!='内部调入' and stock_name!='内部调出'";
		ResultSet rs3=stock_db.executeQuery(sql3);
		if(rs3.next()){
			p++;
		}
		}
		String sql="insert into stock_serial_number_temp(serial_number) values('"+serial_number_temp+"')";
		stock_db.executeUpdate(sql);
		}
	if(serial_number_tag==1){
	String sql1="select distinct serial_number from stock_serial_number_temp";
	ResultSet rs1=stock_db.executeQuery(sql1);
	rs1.last();
	if(rs1.getRow()!=Double.parseDouble(amount[i])){
		p++;
	}
	String sql2="delete from stock_serial_number_temp";
	stock_db.executeUpdate(sql2);
	}else{
	String sql1="select distinct serial_number from stock_serial_number_temp";
	ResultSet rs1=stock_db.executeQuery(sql1);
	rs1.last();
	if(rs1.getRow()!=1){
		p++;
	}
	String sql2="delete from stock_serial_number_temp";
	stock_db.executeUpdate(sql2);
	}
	}
}
String sql88="select * from stock_paying_gathering where gather_ID='"+gather_ID+"' and check_tag='0' and gathering_time='"+gathering_time+"' order by details_number";
	ResultSet rs88=stock_db.executeQuery(sql88);
	if(rs88.next()){
if(p==0){

int n=0;
double amount_sum=0.0d;
for(int i=0;i<stock_name.length;i++){
	if(!amount[i].equals("")){
		if(Double.parseDouble(demand_amount[i])>=0){
		amount_sum+=Double.parseDouble(amount[i]);
		if(Double.parseDouble(amount[i])>Double.parseDouble(available_amount[i])){
		n++;
	}else if(Math.abs(Double.parseDouble(amount[i])+Double.parseDouble(gathered_amount[i]))>Math.abs(Double.parseDouble(demand_amount[i]))){
		n++;
	}
		}
	}
	if(stock_name[i].equals(stock_name_control)&&product_ID[i].equals(product_ID_control)){
		amount_control+=Double.parseDouble(amount[i]);
		if(Math.abs(amount_control+Double.parseDouble(gathered_amount[i]))>Math.abs(Double.parseDouble(demand_amount[i]))){
		n++;
		}
	}else{
		stock_name_control=stock_name[i];
		product_ID_control=product_ID[i];
		amount_control=0;
	}
}
if(n==0){
double amount4=0.0d;
double cost_price_sum=0.0d;
for(int i=0;i<stock_name.length;i++){
	if(!amount[i].equals("")&&Double.parseDouble(amount[i])!=0){
		String chain_id="";
		String chain_name="";
		
		String sql22="select * from stock_cell where product_ID='"+product_ID[i]+"'";
		ResultSet rs22=stock_db.executeQuery(sql22);
		if(rs22.next()){
			chain_id=rs22.getString("chain_id");
			chain_name=rs22.getString("chain_name");
			
		}
		String address_group="";
		String sql8="select * from stock_balance where product_ID='"+product_ID[i]+"'"; 
		ResultSet rs8=stock_db.executeQuery(sql8);
		if(rs8.next()){
			address_group=rs8.getString("address_group");
		}
		String address=stock_name[i];
		if(address_group.indexOf(address)== -1){
			address_group+=address+",";
		}
	double subtotal=Double.parseDouble(cost_price[i])*Double.parseDouble(amount[i]);
	amount4+=Double.parseDouble(amount[i]);
	cost_price_sum+=subtotal;

	double balance_amount11=getRateFromID.getRateFromID((String)dbSession.getAttribute("unit_db_name"),"stock_balance","product_ID",product_ID[i],"amount")+Double.parseDouble(amount[i]);
	double amount22=Double.parseDouble(amount[i])+Double.parseDouble(gathered_amount[i]);

		String sql4="update stock_paying_gathering set amount='"+amount[i]+"',gathered_amount='"+gathered_amount[i]+"',balance_amount='"+balance_amount11+"',subtotal='"+subtotal+"',register='"+register+"',register_time='"+register_time+"',serial_number='"+serial_number_group[i]+"',paying_or_gathering='入库' where id='"+id[i]+"'";
		stock_db.executeUpdate(sql4);

	}else{
		String sql56="delete from stock_paying_gathering where gather_ID='"+gather_ID+"' and product_ID='"+product_ID[i]+"' and stock_ID='"+stock_ID[i]+"' and check_tag='0'";
		stock_db.executeUpdate(sql56);
		String sql57="update stock_pre_gathering set gather_check_tag='0' where gather_ID='"+gather_ID+"' and product_ID='"+product_ID[i]+"' and stock_ID='"+stock_ID[i]+"'";
			stock_db.executeUpdate(sql57);
	}
}
response.sendRedirect("draft/stock/gather_ok.jsp?finished_tag=1");
}else{
response.sendRedirect("draft/stock/gather_ok.jsp?finished_tag=2");
}
}else{
response.sendRedirect("draft/stock/gather_ok.jsp?finished_tag=3");
}
}else{
response.sendRedirect("draft/stock/gather_ok.jsp?finished_tag=4");
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