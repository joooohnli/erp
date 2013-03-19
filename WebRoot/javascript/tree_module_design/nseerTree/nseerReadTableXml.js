/*
 * 
 */
function XmlDocument() {}
XmlDocument.create = function () {//firefox读取xml文件时使用
	if (document.implementation && document.implementation.createDocument) {
		return document.implementation.createDocument("", "", null);
	} 
}

function readXml(css,url){//读取xml文件,生成表单
//var nseer_tag=true;

DWREngine.setAsync(false);
Multi.readXmlToHtml(url,{callback:function(html){
	var div_id=html.split('◎')[0];	
	if(document.getElementById(div_id)!=null){
		//alert(document.getElementById(div_id).style.display);
		document.getElementById(div_id).style.display='block';
	}else{
	var div1=document.createElement('div');
	div1.id=html.split('◎')[0];
    //alert(document.getElementById('nseer_pic').innerHTML);
    if(div_id=='dialogDelete'||div_id=='dialogQuery'){
    	div1.innerHTML=html.split('◎')[1]+'</div></div></TD><TD  background="../../images/bg_04.gif"></TD></TR><TR><TD width="1%" height="1%"><IMG  src="../../images/bg_0lbottom.gif" ></TD><TD background="../../images/bg_02.gif"></TD><TD width="1%" height="1%"><IMG  src="../../images/bg_0rbottom.gif"></TD></TR></TBODY></TABLE></div></div-config></div-config>';
    }else{
	div1.innerHTML=html.split('◎')[1]+'<div id=nseer_picture>'+document.getElementById('nseer_pic').innerHTML+'</div></div></TD><TD  background="../../images/bg_04.gif"></TD></TR><TR><TD width="1%" height="1%"><IMG  src="../../images/bg_0lbottom.gif" ></TD><TD background="../../images/bg_02.gif"></TD><TD width="1%" height="1%"><IMG  src="../../images/bg_0rbottom.gif"></TD></TR></TBODY></TABLE></div></div-config></div-config>';
	}
	document.body.appendChild(div1);
	}
	}});
DWREngine.setAsync(true);
}