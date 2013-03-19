package include.nseer_cookie;

import java.sql.*;

import include.nseer_db.nseer_db_backup1;

public class InsMod {
	public void insert(String mod,String human_ID,String human_name,String file_id,nseer_db_backup1 db){
		if(file_id.length()>4){
			try{
			String sql1="select id from "+mod+"_view where human_ID='"+human_ID+"' and file_id='"+file_id+"'";
			ResultSet rs =db.executeQuery(sql1);
			if(!rs.next()){
				sql1 = "select * from "+mod+"_tree where file_id='"+file_id+"'";
				rs =db.executeQuery(sql1);
				if(rs.next()){
				String sql="insert into "+mod+"_view(MODULE_NAME,reason,CATEGORY_ID,PARENT_CATEGORY_ID,ACTIVE_STATUS,HREFLINK,FILE_ID,FILE_NAME,DETAILS_TAG,HUMAN_ID,NAME,FILE_PATH) values('"+rs.getString("MODULE_NAME")+"','"+rs.getString("reason")+"','"+rs.getString("CATEGORY_ID")+"','"+rs.getString("PARENT_CATEGORY_ID")+"','"+rs.getString("ACTIVE_STATUS")+"','"+rs.getString("HREFLINK")+"','"+rs.getString("FILE_ID")+"','"+rs.getString("FILE_NAME")+"','"+rs.getString("DETAILS_TAG")+"','"+human_ID+"','"+human_name+"','"+rs.getString("FILE_PATH")+"')";	
				db.executeUpdate(sql);
				}
			}
			}catch(Exception ex){ex.printStackTrace();}
			insert(mod,human_ID,human_name,file_id.substring(0,file_id.length()-2),db);
		}else{
			try{
				String sql1="select id from "+mod+"_view where human_ID='"+human_ID+"' and file_id='"+file_id+"'";
				ResultSet rs =db.executeQuery(sql1);
				if(!rs.next()){
					sql1 = "select * from "+mod+"_tree where file_id='"+file_id+"'";
					rs =db.executeQuery(sql1);
					if(rs.next()){
					String sql="insert into "+mod+"_view(MODULE_NAME,reason,CATEGORY_ID,PARENT_CATEGORY_ID,ACTIVE_STATUS,HREFLINK,FILE_ID,FILE_NAME,DETAILS_TAG,HUMAN_ID,NAME,FILE_PATH) values('"+rs.getString("MODULE_NAME")+"','"+rs.getString("reason")+"','"+rs.getString("CATEGORY_ID")+"','"+rs.getString("PARENT_CATEGORY_ID")+"','"+rs.getString("ACTIVE_STATUS")+"','"+rs.getString("HREFLINK")+"','"+rs.getString("FILE_ID")+"','"+rs.getString("FILE_NAME")+"','"+rs.getString("DETAILS_TAG")+"','"+human_ID+"','"+human_name+"','"+rs.getString("FILE_PATH")+"')";	
					db.executeUpdate(sql);
					}
				}
				}catch(Exception ex){ex.printStackTrace();}
		}
	}
	
	public void insertw(String mod,String module_name,String human_ID,nseer_db_backup1 db){
		try{
		String sql="select id from security_workspace where human_ID='"+human_ID+"' and view_tree_name='"+mod+"'";
		ResultSet rs1=db.executeQuery(sql);
		if(!rs1.next()){
				sql="insert into security_workspace(module_name,view_tree_name,human_ID) values('"+module_name+"','"+mod+"','"+human_ID+"')";	
				db.executeUpdate(sql);
		}
		}catch(Exception ex){ex.printStackTrace();}
	}
}
