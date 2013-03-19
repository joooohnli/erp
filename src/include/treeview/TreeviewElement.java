package include.treeview;
public interface TreeviewElement {
	   public String getNodeName( );//该结点的名称
	   public String getNodeUrl();
	   public boolean canExpand();//是否能够展开
	   public TreeviewElement[] getChildren();//所有的一级子结点
	   public int getID();//结点的唯一标识
}
