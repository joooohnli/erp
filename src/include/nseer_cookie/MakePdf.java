/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.nseer_cookie;

import java.io.*;
import java.sql.*;
import java.util.*;
import include.nseer_db.*;
import com.lowagie.text.*;
import com.lowagie.text.Document;
import com.lowagie.text.pdf.*;
import javax.servlet.*;
import javax.servlet.http.*;
import include.excel_export.Masking;


public class MakePdf
	{
		private int fileAmount=0;
		private int allpage=0;
		private String configFile;


public void setConfigFile(String configFile){
    this.configFile=configFile;
  }
	public void make(String database,String tablename,String sql1,String sql2,String filename,int everypage,HttpSession session)
{
  try{


nseer_db aaa=new nseer_db(database);   
nseer_db demo_db=new nseer_db(database);   

ServletContext context=session.getServletContext();
String path=context.getRealPath("/");




 Masking reader=new Masking(configFile);
 Vector columnNames=new Vector();
 Vector tables=reader.getTableNicks();
 Iterator loop=tables.iterator();
 while(loop.hasNext()) {
	String tablenick=(String)loop.next();
	columnNames=reader.getColumnNames(tablenick);
 }

 

int cpage=1; //当前页 

int spage=1;
int ipage=everypage;
String pagesql = sql1 ; 

//取总文章数 
ResultSet pagers = demo_db.executeQuery(pagesql); 
pagers.next();
int allCol = pagers.getInt("A"); 

allpage = (int)Math.ceil((allCol + ipage-1) / ipage); 
//获得总文件数
for(int m=1;m<=allpage;m++)
{
spage=(m-1)*ipage; 
String sql = sql2+" limit "+spage+","+ipage;

ResultSet bbb=aaa.executeQuery(sql); 	   
 //ResultSetMetaData tt=bbb.getMetaData();		 //得到列
 int b=columnNames.size(); 	      //得到列数
 int a=0;
 while(bbb.next()){a++;}			  //得到行数
	bbb.first();					  //光标回到首行	 还要在循环得数据
 Rectangle rectPageSize = new Rectangle(PageSize.A4);// 
 rectPageSize = rectPageSize.rotate();
 Document document = new Document(rectPageSize, 20,20,20,20);	   //定义一个打印的 Document
 PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(path+filename+m+".pdf"));  //保存的PDF文件名称和路径
 document.open(); 	    //开始写内容
 BaseFont bfChinese = BaseFont.createFont("STSong-Light", "UniGB-UCS2-H", BaseFont.NOT_EMBEDDED);	   //定义了一种中文基础字体
  com.lowagie.text.Font FontChinese = new com.lowagie.text.Font(bfChinese, 8, com.lowagie.text.Font.NORMAL); //用这个中文的基础字体实例化了一个字体类


  Paragraph title1 = new Paragraph("nseer ERP",FontFactory.getFont(FontFactory.HELVETICA,18, Font.BOLDITALIC));
  Chapter chapter1 = new Chapter(title1, 1);		 //定义一个章节 包括字体大小 等
  chapter1.setNumberDepth(0); 

  Paragraph title11 = new Paragraph(tablename,FontFactory.getFont(FontFactory.HELVETICA, 16, Font.BOLD));	  Section section1 = chapter1.addSection(title11);		//页面输出的一些标题什么的													 	 																
																 

  Table t = new Table(b,a);			  //定义一个表 （要定义列，行数） 
  t.setPadding(1);						  //  
  t.setSpacing(0);						  //  不详
  t.setBorderWidth(1);					  //

 
  do{													//
														//
 for(int k=0;k<b;k++){								//
 Cell cell =new Cell(new Paragraph(bbb.getString((String)columnNames.elementAt(k)),FontChinese));	//将字体类用到了一个段落中												//
 t.addCell(cell);	                                    //	写入数据
														//
      }													//
    }while(bbb.next());									//
	
  section1.add(t); 			//
   document.add(chapter1);	//显示输出 整章
   document.close(); 
   
   
   
   
   
   
   
}//章节 结束
  }catch(Exception pp){pp.printStackTrace();}
	   }

	public int fileAmount(){
		fileAmount=allpage;
		return fileAmount;
	}
}












