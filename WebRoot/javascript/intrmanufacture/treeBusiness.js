/*
 * 
 */
function beforeAddTreeNode(tree_obj){
	
}
function afterAddTreeNode(tree_obj){
	
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
//var node=tree_obj.getSelectNode();
//alert(node.showStr);
document.getElementById('fileKind_chain').value=writerf(tree_obj);
document.getElementById('nseer1').style.display='none';
}
function aftershowAddBrotherDiv(tree_obj){
}
function jionIn(my_id,tree_obj){
	var str="";
	if(my_id>0){
		str=tree_obj.node_list[my_id].showStr.substring(tree_obj.node_list[my_id].showStr.split(' ')[0].length+1);
		str=jionIn(tree_obj.node_list[my_id].pid,tree_obj)+"-"+str;
	}
	return str;
}
function writerf(tree_obj){ 
 var nodee=tree_obj.getSelectNode();
 var file_value='';
 if(nodee!=null){
 if(nodee.id!==0){/////////////////////////////////////////////////////////////////////////
 file_value=nodee.showStr.split(' ')[0]+" "+jionIn(nodee.id,tree_obj).substring(1); 
 }
 }
	return file_value;
}