package include.nseer_cookie;

import include.nseer_db.nseer_db;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import uk.ltd.getahead.dwr.WebContext;
import uk.ltd.getahead.dwr.WebContextFactory;

public class kindCounter {
	WebContext ctx = WebContextFactory.get();
	HttpServletRequest request=ctx.getHttpServletRequest();
	HttpSession session=request.getSession();
	nseer_db hr_db=new nseer_db((String)session.getAttribute("unit_db_name"));
	public void setDesignCounter(String kind){
		try{
		String sql="insert into security_counter(kind,count_value,kind_name) values('designcount_"+kind+"','100001','designcount')";
		hr_db.executeUpdate(sql);
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}
	public void setPurchaseCounter(String kind){
		try{
		String sql="insert into security_counter(kind,count_value,kind_name) values('purchasecount_"+kind+"','100001','purchasecount')";
		hr_db.executeUpdate(sql);
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}
	public void setIntrmanufactureCounter(String kind){
		try{
		String sql="insert into security_counter(kind,count_value,kind_name) values('intrmanufacturecount_"+kind+"','100001','intrmanufacturecount')";
		hr_db.executeUpdate(sql);
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}
	public void setLogisticsCounter(String kind){
		try{
		String sql="insert into security_counter(kind,count_value,kind_name) values('logisticscount_"+kind+"','100001','logisticscount')";
		hr_db.executeUpdate(sql);
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}
	public void setHrCounter(String kind){
		try{
		String sql="insert into security_counter(kind,count_value,kind_name) values('hrcount_"+kind+"','100001','hrcount')";
		hr_db.executeUpdate(sql);
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}
	public void setCrmCounter(String kind){
		try{
		String sql="insert into security_counter(kind,count_value,kind_name) values('crmcount_"+kind+"','100001','crmcount')";
		hr_db.executeUpdate(sql);
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}
	public void setEcommerceNewsCounter(String kind){
		try{
		String sql="insert into security_counter(kind,count_value,kind_name) values('ecommercenewscount_"+kind+"','100001','ecommercenewscount')";
		hr_db.executeUpdate(sql);
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}
	public void setEcommerceOtherCounter(String kind){
		try{
		String sql="insert into security_counter(kind,count_value,kind_name) values('ecommerceothercount_"+kind+"','100001','ecommerceothercount')";
		hr_db.executeUpdate(sql);
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}
}
