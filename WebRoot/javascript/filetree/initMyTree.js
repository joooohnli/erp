var data;
var id=0;
var kind_tag_this;
var my_pid_this;
var totalRows;
var nseer_img_tag=0;
var nseer_img_close='';
var nseer_img_open='';

function initMyTree(){
var node1=Nseer_tree.getNodeByName("No"+0);	
nseer_img_tag=1;
nseer_img_close=nseer_img_tag==1?"driver.gif":"close.gif";	
nseer_img_open=nseer_img_tag==1?"driver.gif":"open.gif";
DWREngine.setAsync(false);
if(Nseer_tree.getNodeByName("No0")!=null&&Nseer_tree.getNodeByName("No0")!=""){//如果已经声明了tree，并且创建了根节点
NseerFileTree.rootNode('0',{callback:function (msg){
data=msg;
	if(data!=null&&data!=""){
		var node1=Nseer_tree.getNodeByName("No"+id);
		if(node1!=null&&node1!=""){
			for(var i=0;i<data.length;i++){
var dbCol1=data[i].toString();
var nodeName1=dbCol1.split('*');
node1.addNode("No"+i+1,nodeName1[0],false,nodeName1[1],'','',nodeName1[2]);
			}
		}
	}
}});//创建一级节点
}
DWREngine.setAsync(true);
Nseer_tree.DrawTree(true);
id=0;
}

function initTreeNode(my_pid,path){

nseer_img_tag=0;
nseer_img_close=nseer_img_tag==1?"driver.gif":"close.gif";
nseer_img_open=nseer_img_tag==1?"driver.gif":"open.gif";
	my_pid_this=my_pid;
	DWREngine.setAsync(true);
	window.openDialog('fileopen','#CACACA');
	NseerFileTree.rootNode(path,getNameCallback2);//创建二级以下节点
	DWREngine.setAsync(true);
}
function getNameCallback2(msg1){//回调方法
neatDialog.close();
var node11=Nseer_tree.getNodeByName("No"+my_pid_this);
	if(msg1!=null&&msg1!=""){
	for(var i=1;i<msg1.length+1;i++){
				var dbCol1=msg1[i-1].toString();
				var nodeName1=dbCol1.split('*');
				node11.addNode(node11.name+i+1,nodeName1[0],false,nodeName1[1],'','',nodeName1[2]);
			}
	}else{
	}


}
