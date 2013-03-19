package include.tree_index;

import include.nseer_db.nseer_db;

import java.sql.ResultSet;
import java.util.Hashtable;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

public class BusSencond {
	public String getLang(String tablename,String column,String unit_db_name,HttpSession session,ServletContext context){
		String value="";
		try{
			String type=(String)session.getAttribute("language");
			if(type==null) type="chinese";
			type="multilanguage_"+tablename+"_"+type;
			Hashtable tt=(Hashtable)context.getAttribute(type);
			value=(String)tt.get(column);
			if (value==null){
				value=column;
				tt.put(column,column);
				context.setAttribute(type,tt);
				nseer_db db=new nseer_db(unit_db_name);
				String sql22="select * from document_multilanguage where tablename='"+tablename+"' and name='"+column+"'";
				ResultSet rs22=db.executeQuery(sql22);
				if(!rs22.next()){
				String sql1="insert into document_multilanguage(tablename,name)values('"+tablename+"','"+column+"')";
				db.executeUpdate(sql1);
				}
				db.close();
			}
		}catch(Exception r){
			r.printStackTrace();
		}
		return value;
	}
}