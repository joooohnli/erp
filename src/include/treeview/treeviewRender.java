package include.treeview;


public class treeviewRender {
	static public String renderStatic(TreeviewElement treeElmt, boolean bHidden) {
		StringBuffer content = new StringBuffer();
		content.append("<li id=" + treeElmt.getID() + ">");
		if ( treeElmt.canExpand())
		content.append("<img src=/images/plus.gif onClick=\"showHide('"
					+ treeElmt.getID() + "')\">");
		else if (treeElmt.canExpand())
		content.append("<img src=/images/minus.gif onClick=\"showHide('"
					+ treeElmt.getID() + "')\">");
		else
		content.append("<img src=/images/blank.gif>");
if(treeElmt.canExpand()){
  content.append("<a href" );
		}else{
   content.append("<img src=/images/folder.gif><a href= "+treeElmt.getNodeUrl()+" target=\"mainFrame\"" );
 }
		if (treeElmt.canExpand())
		content.append("=\"javascript:showHide('" + treeElmt.getID() + "')\"");
		content.append(">" + treeElmt.getNodeName() + "</a>");
		if (treeElmt.canExpand()) { 
		content.append("<ul");
		if (!bHidden)
		content.append(" style=\"display:none;white-space: nowrap;TEXT-DECORATION:none\"");
		content.append(">");
		TreeviewElement[] elmts = treeElmt.getChildren();
		for (int i = 0; i < elmts.length; i++)
		content.append(renderStatic(elmts[i], bHidden));
		content.append("</ul>");
		}
		content.append("</li>");
		return content.toString();
}
}
