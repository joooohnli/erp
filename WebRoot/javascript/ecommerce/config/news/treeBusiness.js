/*
 * 
 */
function beforeAddTreeNode(tree_obj){
	
}
function afterAddTreeNode(tree_obj){
		var file_id=document.getElementById('file_id').value;
	if(file_id!=''&&file_id.length<=8){
		if(file_id.length==2){file_id+='000000';}
		else if(file_id.length==4){file_id+='0000';}
		else if(file_id.length==6){file_id+='00';}
		kindCounter.setEcommerceNewsCounter(file_id);
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
function afterSelectNodeInto(tree_obj){

}
function aftershowAddBrotherDiv(tree_obj){
}
function beforeChangeDiv(tree_obj){

}
function afterChangeDiv(tree_obj){

}