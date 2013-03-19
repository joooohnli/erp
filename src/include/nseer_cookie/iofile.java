package include.nseer_cookie;

import java.io.*;
import java.sql.ResultSet;
import java.util.*;
import include.nseer_db.*;


public class iofile
{
  private BufferedReader br;
  private BufferedWriter bw;
  private String readFile,writeFile;
  private Vector ipVector;
  private Vector ipVector1;
  public String language;

public iofile(String read,String write) //构造函数
  {
    readFile=read;
    writeFile=write;
    ipVector = new Vector();
    ipVector1 = new Vector();
    try//源文件
    {
      br = new BufferedReader(new InputStreamReader(new FileInputStream(readFile)));
    }
    catch(Exception e)
    { 
    	e.printStackTrace();
    }
    
    try//目标文件
    {
         bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(writeFile)));
    }
    catch(Exception e)
    {
    	e.printStackTrace();
    }
  } 

 public Vector readLines()//读取源文件中的每一行到Vector中
 {      
   try 
   {
     String s;
     while ((s=br.readLine())!=null)

     {
    	 ipVector.add(s);
      
     }
		 
    br.close();
   }
   catch (Exception e) 
   {
     e.printStackTrace();
   }
   return ipVector;
 } 
   
 
 
 public Vector readDB()//读取源文件中的每一行到Vector中

 {      
   try 
   {
	   nseer_db  security_db=new nseer_db("ondemand1");
	   
	   
	   
	   String sql="select type_name from document_config_public_char where kind='语言类型'";
       ResultSet rs=security_db.executeQuery(sql);
       for (int i = 0; i < ipVector.size()-4; i++)
       {
		  String data=(String) ipVector.get(i);
    	   ipVector1.add(data);//取出第i条记录
         
       }
       
       
       
      while (rs.next())
		 {
	     language= rs.getString("type_name");
	  	  
	     
	     
	     ipVector1.add("<column nick=\""+language+"\" name=\""+language+"\" />");
	    
		 }
      
      security_db.close();
	   
   }
   catch (Exception e) 
   {
     e.printStackTrace();
   }
   return ipVector;
 } 
 
 
 
 
 
 
   public void writeLines()
	   
   {
	   
     readLines();
     readDB();
     
  
     
     
     int i;
     try
     {
       for (i = 0; i < ipVector1.size(); i++)
       {
         bw.write( (String) ipVector1.get(i));
         bw.write("\r\n");
       }
       
      
	     bw.write("</columns>");
		 bw.write("\r\n");
    bw.write("</table>");
	bw.write("\r\n");
  bw.write("</tables>");
  bw.write("\r\n");
bw.write("</config>");
       bw.close();
     }
     catch(Exception e)
     {
    	 e.printStackTrace();
     }
     
   }
  
  
}