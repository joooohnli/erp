package include.nseer_cookie;

import java.io.*;
import java.util.jar.*;
/**
 * ZipUtil, a Zip util class created by BeanSoft(beansoft@126.com).
 * 
 * Chinese documents:<br/>
 * 一个 ZIP 工具类, BeanSoft(beansoft@126.com) 创建.
 * 
 * @author BeanSoft
 * @version 1.00 2007-2-15
 */
public class ZipUtil {
	/**
	 * The buffer.
	 */
	protected static byte buf[] = new byte[1024];
	
	
	/**
	 * 遍历目录并添加文件.
	 * @param jos - JAR 输出流
	 * @param file - 目录文件名
	 * @param pathName - ZIP中的目录名
	 * @throws IOException
	 * @throws FileNotFoundException
	 */
	private static void recurseFiles(JarOutputStream jos, File file, String pathName)
		throws IOException, FileNotFoundException
	{
		if (file.isDirectory())
		{
			pathName = pathName + file.getName() + "/";
			jos.putNextEntry(new JarEntry(pathName));
			String fileNames[] = file.list();
			if (fileNames != null)
			{
				for (int i = 0; i < fileNames.length; i++)
					recurseFiles(jos, new File(file, fileNames[i]), pathName);
	
			}
		} else
		{
			JarEntry jarEntry = new JarEntry(pathName + file.getName());
//			System.out.println(pathName + "  " + file.getName());
			FileInputStream fin = new FileInputStream(file);
			BufferedInputStream in = new BufferedInputStream(fin);
			jos.putNextEntry(jarEntry);
			
			int len;
			while ((len = in.read(buf)) >= 0) 
				jos.write(buf, 0, len);
			in.close();
			jos.closeEntry();
		}
	}
	
	/**
	 * 创建 ZIP/JAR 文件.
	 * @param directory - 要添加的目录
	 * @param zipFile - 保存的 ZIP 文件名
	 * @param zipFolderName - ZIP 中的路径名
	 * @param level - 压缩级别(0~9)
	 * @throws IOException
	 * @throws FileNotFoundException
	 */
	public static void makeDirectoryToZip(File directory, File zipFile, String zipFolderName, int level)
		throws IOException, FileNotFoundException
	{
		level = checkZipLevel(level);
		
		if(zipFolderName == null) {
			zipFolderName = "";
		}
		
		JarOutputStream jos = new JarOutputStream(new FileOutputStream(zipFile), new Manifest());
		jos.setLevel(level);
		
		String fileNames[] = directory.list();
		if (fileNames != null)
		{
			for (int i = 0; i < fileNames.length; i++)
				recurseFiles(jos, new File(directory, fileNames[i]), zipFolderName);
	
		}
		jos.close();
	}
	
	
	/**
	 * 检查并设置有效的压缩级别.
	 * @param level - 压缩级别
	 * @return 有效的压缩级别或者默认压缩级别
	 */
	public static int checkZipLevel(int level)
	{
		if(level < 0 || level > 9) level = 7;
		return level;
	}
}

