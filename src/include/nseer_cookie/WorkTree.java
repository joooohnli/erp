package include.nseer_cookie;

import include.nseer_db.nseer_db;

import include.tree_index.Nseer;

public class WorkTree {
	public static void setZero(String unit_db_name,String mod,String first) {
		
		nseer_db db=new nseer_db(unit_db_name);
		Nseer n=new Nseer();
		try{
			String sql="update "+mod+"_tree set workflow_tag='0' where hreflink='"+"check_list.jsp"+"' and file_path='"+mod+"/"+first+"/"+"'";
			db.executeUpdate(sql);
			sql="update "+mod+"_view set workflow_tag='0' where hreflink='"+"check_list.jsp"+"' and file_path='"+mod+"/"+first+"/"+"'";
			db.executeUpdate(sql);
			db.close();
		
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}
	
	public static void setOne(String unit_db_name,String mod,String first) {
		
		nseer_db db=new nseer_db(unit_db_name);
		Nseer n=new Nseer();
		try{
			String sql="update "+mod+"_tree set workflow_tag='1' where hreflink='"+"check_list.jsp"+"' and file_path='"+mod+"/"+first+"/"+"'";
			db.executeUpdate(sql);
			sql="update "+mod+"_view set workflow_tag='1' where hreflink='"+"check_list.jsp"+"' and file_path='"+mod+"/"+first+"/"+"'";
			db.executeUpdate(sql);
			db.close();
		
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}
}
