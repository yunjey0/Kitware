package com.kitware.authorization.control;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kitware.A.control.Controller;
import com.kitware.authorization.service.DocManipulService;
import com.kitware.authorization.service.DocSelectService;
import com.kitware.authorization.vo.DocDetailVO;
import com.kitware.authorization.vo.DocGiganVO;
import com.kitware.authorization.vo.DocVO;
import com.kitware.member.vo.Members;

public class DocEditGianController implements Controller {
	DocSelectService service;
	DocManipulService service2;
	
	public DocEditGianController() {
		super();
	}

	public DocEditGianController(DocSelectService service) {
		super();
		this.service = service;
	}
	
	public DocEditGianController(DocManipulService service2) {
		super();
		this.service2 = service2;
	}

	public DocEditGianController(DocSelectService service, DocManipulService service2) {
		super();
		this.service = service;
		this.service2 = service2;
	}

	public DocSelectService getService() {
		return service;
	}

	public void setService(DocSelectService service) {
		this.service = service;
	}

	public DocManipulService getService2() {
		return service2;
	}

	public void setService2(DocManipulService service2) {
		this.service2 = service2;
	}
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String forwardURL = null ;
		String mode = request.getParameter("mode");
		System.out.println("mode = "+mode);
		String doc_num = request.getParameter("doc_num");
		System.out.println("ddd"+doc_num);
		String doc_content = request.getParameter("chuljang_textarea");
		String doc_title = request.getParameter("title");
		System.out.println("doctitle"+doc_title);
		
		DocVO docvo = new DocVO();
		docvo.setDoc_num(doc_num);
		docvo.setDoc_content(doc_content);
		docvo.setDoc_title(doc_title);
		
		
		try {
			if(mode == null){
				service2.updateCJ(docvo, doc_num);
				forwardURL = "/authorization/editresult.jsp";
				request.setAttribute("result", "1");
			}else if(mode.equals("read")){
				List<DocDetailVO> doc_detail_list = service.selectConf(doc_num);
				DocVO docvo_list = service.selectAll(doc_num);
				request.setAttribute("doc_detail_list", doc_detail_list);
				request.setAttribute("docvo_list", docvo_list);
				forwardURL = "/authorization/docedit.jsp";
			}
		} catch (Exception e) {
			/*request.setAttribute("result", "-1");*/
			e.printStackTrace();
		}
		System.out.println(forwardURL);
		
		return forwardURL;
	}
}
