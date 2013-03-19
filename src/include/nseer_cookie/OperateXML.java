package include.nseer_cookie;

import java.io.*;
import java.util.*;
import org.jdom.*;
import org.jdom.output.*;
import org.jdom.input.*;
import org.jdom.output.Format;
import org.jdom.Attribute;
import org.jdom.Content;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.output.Format;
import org.jdom.output.XMLOutputter;
import javax.servlet.*;
import javax.servlet.http.*;


public class OperateXML {
	
	private FileInputStream fi = null;
	private FileOutputStream fo = null;
	
	
	public  void editXML(String file,String tsAttributeName,String tsAttributeValue,String tAttributeName,String tAttributeValue,String colsAttributeName,String colsAttributeValue,String colAttributeName,String colAttributeValue,String colTargetName,String colTargetValue){
		
		try{
		String path=file;
		int xmlid=Integer.parseInt("0");
		fi = new FileInputStream(path);
		SAXBuilder sb = new SAXBuilder();
		Document doc = sb.build(fi);
		Element config = doc.getRootElement(); //得到根元素


		List tables_list = config.getChildren(); //得到根元素所有子元素的集合
        Element tables=null;
		Element table=null;
		Element cols=null;
		Element col=null;

		for(int i=0;i<tables_list.size();i++){
			
        tables=(Element)tables_list.get(i);

        if(tables.getAttributeValue(tsAttributeName).equals(tsAttributeValue)){
		
		break;
		
		}

		}
		

		List table_list = tables.getChildren(); //得到根元素所有子元素的集合
		
        for(int i=0;i<table_list.size();i++){
			
        table=(Element)table_list.get(i);

        if(table.getAttributeValue(tAttributeName).equals(tAttributeValue)){
		
		break;
		
		}

		}

		List cols_list = table.getChildren(); //得到根元素所有子元素的集合
		
        for(int i=0;i<cols_list.size();i++){
			
        cols=(Element)cols_list.get(i);

        if(cols.getAttributeValue(colsAttributeName).equals(colsAttributeValue)){
		
		break;
		
		}

		}

		List col_list = cols.getChildren(); //得到根元素所有子元素的集合
		
        for(int i=0;i<col_list.size();i++){
			
        col=(Element)col_list.get(i);

        if(col.getAttributeValue(colAttributeName).equals(colAttributeValue)){
		col.setAttribute(colTargetName, colTargetValue);
		
		}

		}
		XMLOutputter outp = new XMLOutputter();
		fo=new FileOutputStream(path);
		outp.output(doc,fo);
		}
		catch(Exception e){
		System.err.println(e+"error");
		}
		finally{
		try{
		
		}
		catch(Exception e){
		e.printStackTrace();
		}
		}
		}



   public  void editXML(String file,String tAttributeName,String tAttributeValue,String colAttributeName,String colAttributeValue,String depAttributeName,String depAttributeValue1,String depAttributeValue2,String depTargetName,String depTargetValue){
		
		try{
		String path=file;
		int xmlid=Integer.parseInt("0");
		fi = new FileInputStream(path);
		SAXBuilder sb = new SAXBuilder();
		Document doc = sb.build(fi);
		Element config = doc.getRootElement(); //得到根元素
        Element table=null;
		Element col=null;
        Element dep=null;

		List table_list = config.getChildren(); //得到根元素所有子元素的集合
        

		for(int i=0;i<table_list.size();i++){
			
        table=(Element)table_list.get(i);

        if(table.getAttributeValue(tAttributeName).equals(tAttributeValue)){
		
		break;
		
		}

		}
		


		List col_list = table.getChildren(); //得到根元素所有子元素的集合
		
        for(int i=0;i<col_list.size();i++){
			
        col=(Element)col_list.get(i);

        if(col.getAttributeValue(colAttributeName).toLowerCase().equals(colAttributeValue.toLowerCase())){
		
		break;
		
		}

		}


		List dep_list = col.getChildren(); //得到根元素所有子元素的集合
		
        for(int i=0;i<dep_list.size();i++){
			
        dep=(Element)dep_list.get(i);

        if(dep.getAttributeValue(depAttributeName).equals(depAttributeValue1)||dep.getAttributeValue(depAttributeName).equals(depAttributeValue2)){
		
		dep.setAttribute(depTargetName, depTargetValue);
		
		}

		}
		
	
		XMLOutputter outp = new XMLOutputter();
		fo=new FileOutputStream(path);
		outp.output(doc,fo);
		}
		catch(Exception e){
		System.err.println(e+"error");
		}
		finally{
		try{
		
		}
		catch(Exception e){
		e.printStackTrace();
		}
		}
		}


//***********************************MSG*****************************************************

public  void msgUpdateXml(String file,String id,String tagName,String value){

FileInputStream fi = null;
FileOutputStream fo = null;
try{
fi = new FileInputStream(file);
SAXBuilder sb = new SAXBuilder();
Document doc = sb.build(fi);
Element root = doc.getRootElement(); //得到根元素
List infos = root.getChildren(); //得到根元素所有子元素的集合
Element info=(Element)infos.get(Integer.parseInt(id));
Element newname= info.getChild(tagName);
newname.setText(value);
XMLOutputter outp = new XMLOutputter();
fo=new FileOutputStream(file);
outp.output(doc,fo);
}
catch(Exception e){
System.err.println(e+"error");
}
finally{
try{
fi.close();
fo.close();
}
catch(Exception e){
e.printStackTrace();
}
}
}
		





		public  void close(){
		try{
		fi.close();
		fo.close();
		
		}
		catch(Exception e){
		e.printStackTrace();
		}
		
		} 
		public List returnList(String file,String tAttributeName,String tAttributeValue,String colAttributeName,String depAttributeName,String depAttributeValue1,String depAttributeValue2){
			List list=(List)(new java.util.ArrayList());
			try{
			String path=file;
			int xmlid=Integer.parseInt("0");
			fi = new FileInputStream(path);
			SAXBuilder sb = new SAXBuilder();
			Document doc = sb.build(fi);
			Element config = doc.getRootElement(); //得到根元素
        Element table=null;
		Element col=null;
        Element dep=null;
			List table_list = config.getChildren(); //得到根元素所有子元素的集合
        
		for(int i=0;i<table_list.size();i++){
			
        table=(Element)table_list.get(i);

        if(table.getAttributeValue(tAttributeName).equals(tAttributeValue)){
		
		break;
		
		}

		}
			List col_list = table.getChildren(); //得到根元素所有子元素的集合
			for(int i=0;i<col_list.size();i++){
				col=(Element)col_list.get(i);
				List dep_list = col.getChildren();
				String[] dep_array=new String[2]; 
				for(int j=0;j<dep_list.size();j++){
					dep=(Element)dep_list.get(j);
					if(dep.getAttributeValue(depAttributeName).toLowerCase().equals(depAttributeValue1.toLowerCase())||dep.getAttributeValue(depAttributeName).toLowerCase().equals(depAttributeValue2.toLowerCase())){
						dep_array[0]=col.getAttributeValue(colAttributeName).toLowerCase();
						dep_array[1]=dep.getAttributeValue(depAttributeName).toLowerCase();
						list.add(dep_array);
						}
				}
		}
			}catch(Exception ex){ex.printStackTrace();}
		return list;		

		}
		public String returnTag(List targetList,String name){
			String tag="";
			for(int i=0;i<targetList.size();i++){
				String[] dep_array=(String[])targetList.get(i);
				if(dep_array[0].equals(name.toLowerCase())){
					if(dep_array[1].equals("required")){
					tag="<font color=red>*</font>";
					}
					break;
				}
			}
			return tag;
			
		}
	public static void main (String args[]){
	 	try{
	 
	 		OperateXML dd=new OperateXML();
	 	dd.editXML("D:\\tomcat-5.0.28\\webapps\\erp\\WEB-INF\\classes\\conf\\xml\\design\\data.xml","nick","ts1","nick","产品档案","nick","col1","nick","自定义属性1","usedTag","n");
	 	
	 		}catch(Exception ex){ex.printStackTrace();}
	 	}
	
}
