package sns.files.controller;

import java.io.File;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;

//AppicationContextAware 인터페이스를 상속받는다. 
//파일 Download를 구현하는 경우, 컨트롤 class는  Download받을 파일과 관련된 정보를 생성해서 뷰에 전달할 것이다. 
@Controller
public class DownloadController implements ApplicationContextAware{
	
	private WebApplicationContext context = null;
	
	@RequestMapping("/file") //url맵핑 경로
	public ModelAndView download() throws Exception {
		File downloadFile = getFile();
		return new ModelAndView("download", "downloadFile", downloadFile);//view값, key값, value 값 순서
	}
	
	//파일을 얻어온다.
	private File getFile() {
		String path = context.getServletContext().getRealPath(
				"/WEB-INF/S.N.S(업체신청).docx");
		return new File(path);
	}
	
	@Override
	public void setApplicationContext(ApplicationContext applicationContext)
			throws BeansException {
		this.context = (WebApplicationContext) applicationContext;
	}
	
}
