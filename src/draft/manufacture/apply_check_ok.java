package draft.manufacture;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.exchange;
import validata.ValidataNumber;
import include.nseer_cookie.counter;

public class apply_check_ok extends HttpServlet{

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

for(int j=1;j<product_IDn.length;j++){
	String sql3="select * from manufacture_apply where apply_ID='"+apply_ID+"' and product_ID='"+product_IDn[j]+"'";
	ResultSet rs3=manufacture_db.executeQuery(sql3) ;
	if(rs3.next()){
		m++;
	}
}
if(num==0&&product_IDn.length==1){
	response.sendRedirect("draft/manufacture/apply_ok_a.jsp?apply_ID="+apply_ID+"");
}else{
	if(m!=0){
		response.sendRedirect("draft/manufacture/apply_ok_b.jsp?apply_ID="+apply_ID+"");
	}else{
		for(int i=1;i<=num;i++){
		String amount_i=request.getParameter("amount"+i);
		if(amount_i.equals("")||!validata.validata(amount_i)){
			n++;
		}
		}
for(int j=1;j<product_IDn.length;j++){
		if(!validata.validata(amount1[j])){
			n++;
		}
}
if(n==0){
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String bodyb = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyb);
try{
	String sql1="delete from manufacture_apply where apply_ID='"+apply_ID+"' and product_ID=''";
			manufacture_db.executeUpdate(sql1) ;
	for(int i=1;i<=num;i++){
	String tem_product_name="product_name"+i;
	String tem_product_ID="product_ID"+i;
	String tem_product_describe="product_describe"+i;
	String tem_amount="amount"+i;
String product_name=request.getParameter(tem_product_name) ;
String product_ID=request.getParameter(tem_product_ID) ;
String product_describe=request.getParameter(tem_product_describe) ;
String amount=request.getParameter(tem_amount) ;
		 sql1 = "update manufacture_apply set product_ID='"+product_ID+"',product_name='"+product_name+"',product_describe='"+product_describe+"',amount='"+amount+"',remark='"+remark+"',register='"+register+"',register_time='"+register_time+"' where apply_ID='"+apply_ID+"' and product_ID='"+product_ID+"'";
	manufacture_db.executeUpdate(sql1) ;
	
}
String[] product_namen=request.getParameterValues("product_name") ;
String[] product_describen=request.getParameterValues("product_describe") ;
String[] amountn=request.getParameterValues("amount") ;
String[] type=request.getParameterValues("type") ;
for(int j=1;j<product_IDn.length;j++){
	String sql4 = "insert into manufacture_apply(apply_ID,product_ID,product_name,product_describe,amount,remark,type,register,register_time) values('"+apply_ID+"','"+product_IDn[j]+"','"+product_namen[j]+"','"+product_describen[j]+"','"+amountn[j]+"','"+remark+"','"+type[j]+"','"+register+"','"+register_time+"')";
	manufacture_db.executeUpdate(sql4) ;
}

List rsList = (List)new java.util.ArrayList();
	String[] elem=new String[3];
	  String sql="select id,describe1,describe2 from manufacture_config_workflow where type_id='03'";
	ResultSet rset=manufacture_db.executeQuery(sql);
	while(rset.next()){
		elem=new String[3];
		elem[0]=rset.getString("id");
		elem[1]=rset.getString("describe1");
		elem[2]=rset.getString("describe2");
		rsList.add(elem);
	}
	if(rsList.size()==0){
		String pay_ID_group="";
		 sql = "update manufacture_apply set check_tag='1' where apply_ID='"+apply_ID+"'" ;
	manufacture_db.executeUpdate(sql) ;
		 sql="select * from manufacture_apply where apply_ID='"+apply_ID+"'";
	ResultSet rs1=manufacture_db.executeQuery(sql) ;
	if(rs1.next()){
		pay_ID_group=rs1.getString("pay_ID_group");
	}
StringTokenizer tokenTO = new StringTokenizer(pay_ID_group,", ");        
        while(tokenTO.hasMoreTokens()) {
		 sql="select * from stock_pay where pay_ID='"+tokenTO.nextToken()+"'";
		 rs1=manufacture_db.executeQuery(sql) ;
		if(rs1.next()){
			 sql = "update crm_order set manufacture_tag='2' where order_ID='"+rs1.getString("reasonexact")+"'" ;
			manufacture_db.executeUpdate(sql) ;
		}
		}
		 
	}else{
		sql="delete from manufacture_workflow where object_ID='"+apply_ID+"'";
			manufacture_db.executeUpdate(sql) ;
		sql="update manufacture_apply set check_tag='0' where apply_ID='"+apply_ID+"'";
			manufacture_db.executeUpdate(sql);
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		elem=(String[])ite.next();
		sql = "insert into manufacture_workflow(config_id,object_ID,describe1,describe2,type_id) values ('"+elem[0]+"','"+apply_ID+"','"+elem[1]+"','"+elem[2]+"','03')" ;
		manufacture_db.executeUpdate(sql) ;
  
		}
	}

}
catch (Exception ex){
ex.printStackTrace();
}
response.sendRedirect("draft/manufacture/apply_ok.jsp?finished_tag=4");
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