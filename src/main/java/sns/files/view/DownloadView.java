package sns.files.view;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

/*
	 파일 Download를 구현하려면 컨텐츠 타입을 "application/octet-stream"과 같이 
	Download를 위한 타입으로 설정해 주어야 하며, 
	Download 받는 파일 이름을 알맞게 설정하기 위해서는
	Content-Disposition 헤더의 값을 알맞게 설정해 주어야 한다. 
*/
public class DownloadView extends AbstractView{
	
	public DownloadView() {
		setContentType("application/download; charset=utf-8");
	}
	
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		File file = (File) model.get("downloadFile"); //리턴시킨 키 값으로 받아온다

		response.setContentType(getContentType());
		response.setContentLength((int) file.length());

		String userAgent = request.getHeader("User-Agent");

		boolean ie = userAgent.indexOf("MSIE") > -1;
		String fileName = null;
		if (ie) { 
			fileName = URLEncoder.encode(file.getName(), "utf-8");
		} else {
			fileName = new String(file.getName().getBytes("utf-8"),
					"iso-8859-1");
		
		}
		response.setHeader("Content-Disposition", "attachment; filename=\""
				+ fileName + "\";");

		response.setHeader("Content-Transfer-Encoding", "binary");
		OutputStream out = response.getOutputStream();

		FileInputStream fis = null;
		try {
			fis = new FileInputStream(file);
			FileCopyUtils.copy(fis, out);
		} finally {
			if (fis != null)
				try {
					fis.close();
				} catch (IOException ex) {
				
				}
		}
		out.flush();
	}
}
