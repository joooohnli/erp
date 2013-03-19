package include.nseer_cookie;

import java.io.*;
import java.util.*;
import javax.servlet.http.*;

public class downfile {

	public void download(HttpServletResponse response, String filename)
			throws IOException {
		StringTokenizer tokenTO = new StringTokenizer(filename, "\\");
		int j = 0;
		String[] filepath1 = new String[10];
		while (tokenTO.hasMoreTokens()) {
			filepath1[j] = tokenTO.nextToken();
			j++;
		}
		String filepath = "";
		for (int m = 0; m < j - 1; m++) {
			filepath = filepath + filepath1[m] + "\\";
		}
		filepath = filepath + filepath1[j - 1];
		File down_file = new java.io.File(filepath);
		long l = down_file.length(); //文件长度
		InputStream in = new FileInputStream(down_file);

		if (in != null) {
			try {
				String fs = down_file.getName();
				response.reset();
				response.setContentType("application/vnd.ms-excel"); //
				String s = "attachment; filename=" + fs; //
				response.setHeader("Content-Disposition", s); //以上输出文件元信息

				OutputStream output = null;
				FileInputStream fis = null;

				output = response.getOutputStream();
				fis = new FileInputStream(filepath);
				response.setContentLength((int) l);
				byte[] b = new byte[2048];
				int i = 0;
				while ((i = fis.read(b)) > 0) {
					output.write(b, 0, i);
				}
				output.flush();
				in.close();
			} catch (Exception e) {
				e.printStackTrace();
			}

		}
	}

}