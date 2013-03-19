/*
 * 
 */
function XmlDocument() {}
XmlDocument.create = function () {//firefox读取xml文件时使用
	if (document.implementation && document.implementation.createDocument) {
		return document.implementation.createDocument("", "", null);
	} 
}

function readXml(css,url,cover){//读取xml文件,生成表单
cover=cover||'1';
//var nseer_tag=true;
var nseer_tag_id;
DWREngine.setAsync(false);
Multi.readXmlToHtml(url,{callback:function(html){
	var div_id=html.split('◎')[0];
	if(document.getElementById(div_id)!=null){
		document.getElementById(div_id).style.display='block';
	}else{
	var div1=document.createElement('div');
	div1.id=html.split('◎')[0];
	div1.innerHTML=html.split('◎')[1];
	nseer_tag_id=div1.id
  document.body.appendChild(div1);
  
	}
	}});
DWREngine.setAsync(true);
if(cover=='1'){
loadCover(nseer_tag_id);
}
}