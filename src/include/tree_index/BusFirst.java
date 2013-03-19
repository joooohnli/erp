package include.tree_index;

import include.nseer_db.nseer_db;
import include.nseer_cookie.ToHTML;
import include.nseer_cookie.getTime;

import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class BusFirst {
	public String businessComment(String url, String base, String table_name,
			String field_name, String field_name1, String unit_db_name) {
		String ab = "";
		try {
			String note = "";
			nseer_db db = new nseer_db(unit_db_name);
			String url_l = url.split("/")[url.split("/").length - 1];
			String url_l1 = url.split("/")[url.split("/").length - 2];
			String url_temp = url.substring(0, url.indexOf("/", 2) + 1);
			url = url.substring(1);
			url = url.substring(url.indexOf("/") + 1);
			String table = url.substring(0, url.indexOf("/")) + "_tree";
			String group_name = url.substring(0, url.indexOf("/")) + "Tree";
			String filepath = url.substring(0, url.lastIndexOf("/") + 1);
			String filetemp = url.substring(url.lastIndexOf("/") + 1);
			String filename = "";
			if (filetemp.indexOf("_") != -1) {
				filename = filetemp.substring(0, filetemp.indexOf("_"));
			} else {
				filename = filetemp.substring(0, filetemp.indexOf("."));
			}
			ResultSet rs = db.executeQuery("select chain_name,hreflink from "
					+ table + " where file_path='" + filepath + "'");
			while (rs.next()) {
				String aa = filename + "[^a-zA-Z].*";
				Pattern b = Pattern.compile(aa);
				Matcher m1 = b.matcher(rs.getString("hreflink"));
				if (m1.find()) {
					ab = base + rs.getString("chain_name");
					break;
				}
			}
			rs = db
					.executeQuery("select used_tag from erpPlatform_config_public_char where kind='nseer_file_1' and type_name='js' and used_tag='0' and all_tag='0'");
			String ad = "";
			if (rs.next()) {
				ad = "<script type=\"text/javascript\" src=\"" + url_temp
						+ "javascript/include/nseer_cookie/ad.js\"></script>";
			}
			String other_str = "";
			if (url_l.indexOf("_dig") != -1) {
				other_str = "<font color=\"red\">(" + "历史数据" + ")</font>";
			}
			ab = ab + other_str + note;
			String msg_td = "", pdf_td = "", excel_import_td = "", excel_export_td = "", xml_import_td = "", xml_export_td = "", advance_search_td = "";

			String tds = msg_td + pdf_td + excel_import_td + excel_export_td
					+ xml_import_td + xml_export_td + advance_search_td;
			ab = ab
					+ "<script type=\"text/javascript\" src=\""
					+ url_temp
					+ "javascript/include/nseer_cookie/toolTip.js\"></script><script type=\"text/javascript\" src=\""
					+ url_temp + "javascript/include/div/alert.js\"></script>"
					+ ad;
			ab += "<script>function _killerrors(){return true;}window.onerror=_killerrors;</script>";
			ab = ab
					+ " <div style=\"position:absolute;top:25px;width:50px;left:0;\"><table><tr>"
					+ tds + "</tr></table></div>";
			ab = ab + "<input type=\"hidden\" id=\"show-dialog-btn\">";

			db.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return ab;
	}
}
