package cn.fh.client;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

/**
 * 向localhost:8080发送GET请求，获取返回的HTML代码并保存到文件中
 * @author whf
 *
 */
public class Client {

	public static void main(String[] args) throws Exception {
		CloseableHttpClient httpclient = HttpClients.createDefault();
		try {
			HttpGet httpGet = new HttpGet("http://127.0.0.1:8080/codeschool");
			CloseableHttpResponse response = httpclient.execute(httpGet);
			try {
				System.out.println(response.getStatusLine());
				HttpEntity entity = response.getEntity();
				
				String html =  EntityUtils.toString(entity);
				saveContent(html, "/home/whf/workspace-sts/codeschool/home.html");
				
				EntityUtils.consume(entity);
			} finally {
				response.close();
			}

		} finally {
			httpclient.close();
		}
	}
	
	/**
	 * 将HTML写入到指定文件中
	 * 
	 * @param html
	 * @param path 文件路径
	 * @throws IOException
	 */
	private static void saveContent(String html, String path) throws IOException {
		FileOutputStream fos = new FileOutputStream(path);
		BufferedOutputStream bos = new BufferedOutputStream(fos);
		bos.write(html.getBytes());
		bos.close();
	}

}
