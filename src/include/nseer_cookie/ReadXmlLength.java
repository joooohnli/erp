package include.nseer_cookie;

import java.io.File; 

import javax.xml.parsers.DocumentBuilder; 
import javax.xml.parsers.DocumentBuilderFactory; 

import org.w3c.dom.Document; 
import org.w3c.dom.Element; 
import org.w3c.dom.NodeList; 

public class ReadXmlLength { 
public String read(String path,String node,String ele) { 
String xml_value="";
try { 
DocumentBuilderFactory factory = DocumentBuilderFactory 
.newInstance(); 
DocumentBuilder builder = factory.newDocumentBuilder(); 
Document document = builder.parse(new File(path)); 
Element rootElement = document.getDocumentElement(); 

NodeList list = rootElement.getElementsByTagName(node);
Element element = (Element) list.item(0); 
xml_value=element.getAttributeNode(ele).getNodeValue(); 

} catch (Exception e) { 
e.printStackTrace();
} 
return xml_value;
} 
}