package include.right;

import java.sql.ResultSet;
import include.nseer_db.*;
import javax.servlet.*;


public class TransferRight{

private String treetemp;
private ServletContext dbApplication;

public TransferRight(ServletContext dbApplication){
		this.dbApplication=dbApplication;
	}

public void run(String mod,String dbase,String human_ID){
String treeadd=mod+"_tree";
String treeAright=mod+"_allright";
this.treetemp=mod+"_view";
try{
nseer_db_backup demo=new nseer_db_backup(dbApplication);
nseer_db_backup demo1=new nseer_db_backup(dbApplication);

nseer_db_backup demo2=new nseer_db_backup(dbApplication);
if(demo.conn(dbase)&&demo1.conn(dbase)&&demo2.conn(dbase)){
String sql66="delete from "+treetemp+" where human_ID='"+human_ID+"'";
demo.executeUpdate(sql66);
ResultSet rs22=demo.executeQuery("select * from "+treetemp+" where module_name='all'");
if(!rs22.next()){
String sql6="insert into "+treetemp+"(MODULE_NAME,CATEGORY_ID,PARENT_CATEGORY_ID) values('all','0','-1')";
demo.executeUpdate(sql6);
}
String main_id="";
String second_id="";
String abc30="select * from "+treeAright+" where human_ID='"+human_ID+"' order by id" ;
ResultSet rs30=demo.executeQuery(abc30);

	int i=1;
	int j=100;
	int k=1000;
	int ii=0;
	int jj=0;
while(rs30.next()){

String abc="select * from "+treeadd+" where main='"+rs30.getString("main")+"' and secondary='"+rs30.getString("secondary")+"' and third='"+rs30.getString("third")+"'" ;
ResultSet rss=demo2.executeQuery(abc);

while(rss.next()){
String sqq="select * from "+treetemp+" where module_name='"+rs30.getString("main")+"' and human_ID='"+rs30.getString("HUMAN_ID")+"' and parent_category_id='0'";
ResultSet rsq=demo1.executeQuery(sqq);
if(!rsq.next()){

String sqla="insert into "+treetemp+"(MODULE_NAME,category_id,PARENT_CATEGORY_ID,HREFLINK,HUMAN_ID,NAME) values('"+rss.getString("main")+"','"+i+"','0','"+rss.getString("MAINURL").substring(6)+"','"+rs30.getString("HUMAN_ID")+"','"+rs30.getString("NAME")+"')";

demo1.executeUpdate(sqla);
main_id=i+"";
ii=i;
i++;
}else{
	main_id=rsq.getString("category_id");
}
sqq="select * from "+treetemp+" where module_name='"+rs30.getString("secondary")+"' and human_ID='"+rs30.getString("HUMAN_ID")+"' and parent_category_id='"+main_id+"' and category_id<=1000";
rsq=demo1.executeQuery(sqq);
if(!rsq.next()){

String sqla="insert into "+treetemp+"(MODULE_NAME,category_id,PARENT_CATEGORY_ID,HREFLINK,HUMAN_ID,NAME) values('"+rss.getString("secondary")+"','"+j+"','"+ii+"','"+rss.getString("secondURL").substring(6)+"','"+rs30.getString("HUMAN_ID")+"','"+rs30.getString("NAME")+"')";

demo1.executeUpdate(sqla);
second_id=j+"";
jj=j;
j++;
}else{
	second_id=rsq.getString("category_id");
}
if(!rs30.getString("third").equals("")){
sqq="select * from "+treetemp+" where module_name='"+rs30.getString("third")+"' and human_ID='"+rs30.getString("HUMAN_ID")+"' and parent_category_id='"+second_id+"' and category_id>=1000";
rsq=demo1.executeQuery(sqq);
if(!rsq.next()){

String sqla="insert into "+treetemp+"(MODULE_NAME,category_id,PARENT_CATEGORY_ID,HREFLINK,HUMAN_ID,NAME) values('"+rss.getString("third")+"','"+k+"','"+jj+"','"+rss.getString("thirdURL").substring(6)+"','"+rs30.getString("HUMAN_ID")+"','"+rs30.getString("NAME")+"')";

demo1.executeUpdate(sqla);
k++;
}
}
}
}
demo.close();
demo1.close();
demo2.close();
}else{
			System.out.println("i am sorry");
		}
}catch(Exception ex){
	ex.printStackTrace();
	}
}
}