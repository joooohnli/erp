package include.nseer_cookie;

import java.io.File;
import org.apache.tools.ant.Project;
import org.apache.tools.ant.taskdefs.Zip;
 
public class ZipUtil1{
 
public static void zip(String dest,String src){
  Zip zip = new Zip();
  zip.setBasedir(new File(src));
  //zip.setIncludes(...); 包括哪些文件或文件夹eg:zip.setIncludes("*.java");
  //zip.setExcludes(...); 排除哪些文件或文件夹
  zip.setDestFile(new File(dest));
  Project p = new Project();
  p.setBaseDir(new File(src));
  zip.setProject(p);
  zip.execute();
}
 
public static void main(String args[]){
	ZipUtil1 dd=new ZipUtil1();
	dd.zip("d:/金蝶K3V10.3.zip","d:/金蝶K3V10.3"); 
}
 
}
