import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.jar.JarInputStream;
import java.util.jar.Manifest;
import org.dom4j.Element;
import org.dom4j.dom.DOMElement;
import org.jsoup.Jsoup;
import com.alibaba.fastjson.JSONObject;
public class test {
	public static void main(String args[]){
		 Element dependencys = new DOMElement("dependencys");
	        File dir = new File("/Users/huanghong/Desktop/code/bankcard/src/main/resources/lib"); //lib目录
	        for (File jar : dir.listFiles()) {
	            String jarname  = jar.getName();
	            int index = jarname.lastIndexOf("-");
	            int jarIndex = jarname.lastIndexOf(".");

	            String  bundleName = jarname.substring(0,index);
	            String bundleVersion = jarname.substring(index +1 ,jarIndex );

	            if (bundleName ==null || bundleVersion == null){
	                continue;
	            }

	            System.out.println("<!--"+jar.getName()+"-->");
	            System.out.println(getDependices(bundleName,bundleVersion));
	            System.out.println();
	}

}
	public static String getDependices(String key, String ver) {

        String url ="https://mvnrepository.com/search?q="+key;

        org.jsoup.nodes.Document doc = null;
        org.jsoup.nodes.Document doc2 = null;

        try {
            doc = Jsoup.connect(url).ignoreContentType(true).timeout(30000).get();
        } catch (IOException e) {
            e.printStackTrace();
        }

        org.jsoup.nodes.Element elem = doc.body();

        String href = elem.childNodes().get(1).childNodes().get(2).childNodes().get(2).childNodes().get(0).attributes().get("href");

        String[] jarinfo = href.split("/");

        String result = "<dependency>\n" +
                "    <groupId>"+jarinfo[2]+"</groupId>\n" +
                "    <artifactId>"+key+"</artifactId>\n" +
                "    <version>"+ver+"</version>\n" +
                "</dependency>";



        return result;
    }

}
