package include.nseer_cookie;

import include.tree_index.businessComment;
import java.io.FileNotFoundException;
import java.io.RandomAccessFile;

import javax.servlet.ServletContext;
import javax.servlet.http.*;
import uk.ltd.getahead.dwr.WebContext;
import uk.ltd.getahead.dwr.WebContextFactory;

public class ReadXml {
	businessComment demo=new businessComment();
	WebContext ctx = WebContextFactory.get();
	HttpServletRequest request=ctx.getHttpServletRequest();
	HttpSession session=ctx.getSession();
	ServletContext application=session.getServletContext();
	public String readXmlToHtml(String file_name){
		String all_html="";
		String html="";
		demo.setPath(request);
		try{
			
			
			String path=application.getRealPath("/");
			path=path+file_name.replace("../", "");
			
	RandomAccessFile filee = new RandomAccessFile(path, "r");
	
	long filePointer = 0; 
	long length = filee.length(); 
	while (filePointer < length) {
		String mk = filee.readLine();
		byte []  bbbbb=mk.getBytes("8859_1"); 
		String content = new String(bbbbb, "UTF-8"); 
		all_html+=content;
		filePointer = filee.getFilePointer(); 
	}
	
	String[] demo1=all_html.split("⊙⊙⊙");
	for(int i=1;i<demo1.length;){
		demo1[i]=demo.getLang("erp", demo1[i]);		
		i=i+2;
	}
	
	
	for(int i=0;i<demo1.length;i++){
		html+=demo1[i];
	}
	
		}catch(Exception ex){ex.printStackTrace();}
	String id=html.substring(html.indexOf("id=\"")+4);
	id=id.substring(0,id.indexOf("\""));
	html=id+"◎"+html;
	return  html;
	}
}
