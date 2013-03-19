/*
 * 
 */
function beforeAddTreeNode(tree_obj){
	
}
function afterAddTreeNode(tree_obj){
	var file_id=document.getElementById('file_id').value;
	//在security_counter中插入计数器
	if(file_id!=''&&file_id.length<=8){
		if(file_id.length==2){file_id+='000000';}
		else if(file_id.length==4){file_id+='0000';}
		else if(file_id.length==6){file_id+='00';}
		kindCounter.setHrCounter(file_id);
	}
}
function beforeDeleteNode(tree_obj){
	
}
function afterDeleteNode(tree_obj){
	
}
function beforeChangeNode(tree_obj){
	
}
function afterChangeNode(tree_obj){
}
function beforeQuickSearchNode(tree_ob){
	
}
function afterQuickSearchNode(tree_obj){
	
}
function afterDoubleClick(tree_obj){
	
}
function beforeChangeDiv(tree_obj){

}
function afterChangeDiv(tree_obj){

}
function afterSelectNodeInto(tree_obj){
unloadCover('nseer1');
var chain_str=selectIntoCccc0(tree_obj);
document.getElementById('kind_chain').value=chain_str;
document.getElementById('human').value='';
document.getElementById('nseer1').style.display='none';
}
function aftershowAddBrotherDiv(tree_obj){
}
function closefile(){
document.getElementById('nseer1').style.display='none';
}
function jionIn(my_id,tree_obj){
	var str="";
	if(my_id>0){
		str=tree_obj.node_list[my_id].showStr.substring(tree_obj.node_list[my_id].showStr.split(' ')[0].length+1);
		str=jionIn(tree_obj.node_list[my_id].pid,tree_obj)+"-"+str;
	}
	return str;
}
function selectIntoCccc0(tree_obj){ 
 var nodee=tree_obj.getSelectNode();
 var file_value='';
 if(nodee!=null){
 if(nodee.pid>=0){
 file_value=nodee.showStr.split(' ')[0]+" "+jionIn(nodee.id,tree_obj).substring(1); 
 }
 }
	return file_value;
}