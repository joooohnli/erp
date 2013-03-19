package include.treeview;

import javax.servlet.http.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import include.nseer_db.*;
import include.tree_index.businessComment;

public class Category implements TreeviewElement {
	protected int ID;//代表数据库中category_id列;
	protected int parentID;//代表数据库中parent_category_id列;
	private String mod;
	private String sql1;
	private String human_ID;
	private String dbase;
	protected String categoryName;
	private String categoryTemp;
	private businessComment demo;
	protected String categoryUrl;//代表数据库中category_name列;
	protected String activeStatus="Y";//代表数据库中active_status列;
	private HttpServletRequest request;
	public Category() {//无参的构造方法 
		this.ID = -1;
}
public Category(int id,String mod,String human_ID,String dbase,HttpServletRequest request){//有参的构造方法，参数为portlet_id
this.request=request;
this.ID = id;
this.mod=mod;
this.human_ID=human_ID;
this.dbase=dbase;
demo=new businessComment();
	demo.setPath(request);
if (!FromDb())//如果有找到该id的porlet
this.ID = -1;
}
public boolean FromDb() {//从数据库中读出，并更新bean
		int row = -1;
		//读记录的sql语句

		this.categoryTemp=mod+"_view";
		String group_name=mod+"Tree";
		nseer_db demoa=new nseer_db(dbase);

		if(this.ID==0){
		 sql1 = "select * from "+categoryTemp+" where category_id=" + this.ID + " and active_status='Y'";
		
		}else{
		 sql1 = "select * from "+categoryTemp+" where category_id=" + this.ID + " and active_status='Y' and HUMAN_ID='"+human_ID+"'";

		 }
		ResultSet rs =demoa.executeQuery(sql1);
		//执行sql语句并返回ResultSet
		try {
			rs.last();//移动到最后一行
			row = rs.getRow();//得到总记录数
			if (row == 1) {
				this.parentID = rs.getInt("PARENT_CATEGORY_ID");
				this.categoryName = demo.getLang(group_name,rs.getString("MODULE_NAME"));
				this.categoryUrl = rs.getString("HREFLINK");
				this.activeStatus = rs.getString("ACTIVE_STATUS");
				demoa.close();
				return true;
} else{
	demoa.close();
				return false;			
}
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} 

	}
	public String getActiveStatus() {
		return activeStatus;
	}
	public void setActiveStatus(String activeStatus) {
		this.activeStatus = activeStatus;
	}
	public String getCategoryName() {
		return categoryName;
	}

public String getCategoryUrl() {
		return categoryUrl;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public void setCategoryUrl(String categoryUrl) {
		this.categoryUrl = categoryUrl;
	}
	public int getID() {
		return ID;
	}
	public void setID(int id) {
		ID = id;
	}
	public int getParentID() {
		return parentID;
	}
	public void setParentID(int parentID) {
		this.parentID = parentID;
	}
	public String getNodeName() {
		return getCategoryName();
	}
	public String getNodeUrl() {
		return getCategoryUrl();
	}
	public boolean canExpand() {
		
		nseer_db democ=new nseer_db(dbase);
		String sql ="select category_id from "+categoryTemp+" where parent_category_id="+getID()+" and HUMAN_ID='"+human_ID+"'";
		ResultSet rs = democ.executeQuery(sql);//执行sql语句并返回ResultSet
		try {
			rs.last();//移动到最后一行
			int row = rs.getRow();//得到总记录数
			democ.close();
			if (row <= 0) 
				return false;
		    else
				return true;
			
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} 
		
	}




	public TreeviewElement[] getChildren( ) {
		nseer_db demob=new nseer_db(dbase);
		String sql ="select category_id from "+categoryTemp+" where parent_category_id="+getID()+" and HUMAN_ID='"+human_ID+"'";
		ResultSet rs =demob.executeQuery(sql);//执行sql语句并返回ResultSet
		try {
			rs.last();//移动到最后一行
			int row = rs.getRow();//得到总记录数
			if (row <= 0) {//如果没有子结点
				demob.close();
				return null;//返回null
			}
		    else{//如果有子结点
		    	Vector vData = new Vector();
		    	rs.beforeFirst();
		    	while (rs.next())
		    		vData.add(""+rs.getInt("CATEGORY_ID"));
		    	TreeviewElement[] children = new TreeviewElement[vData.size()];
		    	for (int i=0;i<vData.size();i++)
		    	{
		    		int id = Integer.parseInt((String)vData.get(i));
		    		children[i] = new Category(id,mod,human_ID,dbase,request);
		    	}
		    	demob.close();
		    	return children;//返回该记录的所有子结点
		    }

				} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		
	}
}
