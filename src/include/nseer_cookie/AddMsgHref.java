package include.nseer_cookie;

import java.util.ArrayList;
import java.util.List;

public class AddMsgHref {
	public String addHref(String a){
		String[] href={"www.","http://","https://"};
		List list=(List)(new ArrayList());
		list.add(a);
		String a_aft_l="";
		while(a.toLowerCase().indexOf("www.")!=-1||a.toLowerCase().indexOf("http://")!=-1||a.toLowerCase().indexOf("https://")!=-1){
			for(int i=0;i<href.length;i++){
				if(a.toLowerCase().indexOf(href[i])!=-1){
					int tag=0;
					int bef=a.toLowerCase().substring(0,a.toLowerCase().indexOf(href[i])).lastIndexOf("http://");
					int bef_temp=a.toLowerCase().substring(0,a.toLowerCase().indexOf(href[i])).lastIndexOf("https://");
					if(bef!=-1&&bef_temp!=-1){
						bef=bef<bef_temp?bef_temp:bef;
					}else{
						bef=bef==-1?bef_temp:bef;
					}
					if(bef==-1&&bef_temp==-1){bef=a.toLowerCase().indexOf(href[i]);tag=1;}					
					String a_bef=a.toLowerCase().substring(0,bef);//得出www.前空格之前的字符串
					String a_temp=a.substring(bef,a.length());
					int aft=a_temp.indexOf(" ");
					int aft_temp=a_temp.indexOf("⊙");
					if(aft!=-1&&aft_temp!=-1){
						aft=aft<aft_temp?aft:aft_temp;
					}else{
						aft=aft==-1?aft_temp:aft;
					}
					String a_mid="";
					String a_aft="";
					if(aft!=-1){
						a_mid=a_temp.substring(0,aft);
						a_aft=a_temp.substring(aft);
					}else{
						a_mid=a_temp;
					}
					String a_mid_temp=a_mid;
					if(href[i].equals("www.")&&tag==1){
						a_mid_temp="http://"+a_mid_temp;
					}
					a_mid="<A href=\""+a_mid_temp+"\" target=\"_blank\">"+a_mid+"</A>";
					list.add(a_bef+a_mid);
					a=a_aft;
					a_aft_l=a_aft;
				}
			}
		}
		list.add(a_aft_l);
		String result="";
		if(list.size()>2){
		for(int i=1;i<list.size();i++){
			result+=list.get(i);			
		}
		}else{
			result=(String)list.get(0);
		}
		return result;
	}
}
