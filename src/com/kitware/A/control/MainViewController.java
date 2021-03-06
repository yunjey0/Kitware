package com.kitware.A.control;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kitware.authorization.service.DocSelectService;
import com.kitware.authorization.vo.DocVO;
import com.kitware.board.service.BoardService;
import com.kitware.board.vo.NoticeBoard;
import com.kitware.guntae.service.GTService;
import com.kitware.guntae.vo.Gunte;
import com.kitware.guntae.vo.Yeoncha;
import com.kitware.member.vo.Members;
import com.kitware.schedule.service.SchCodeService;
import com.kitware.schedule.vo.Schedule;

public class MainViewController implements Controller {
	DocSelectService service;
	SchCodeService sservice;
	BoardService bservice;
	GTService gservice;

	public GTService getGservice() {
		return gservice;
	}

	public void setGservice(GTService gservice) {
		this.gservice = gservice;
	}

	public DocSelectService getService() {
		return service;
	}

	public void setService(DocSelectService service) {
		this.service = service;
	}

	public BoardService getBservice() {
		return bservice;
	}

	public void setBservice(BoardService bservice) {
		this.bservice = bservice;
	}

	public SchCodeService getSservice() {
		return sservice;
	}

	public void setSservice(SchCodeService sservice) {
		this.sservice = sservice;
	}

	public MainViewController() {
		super();
	}

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		Members loginInfo = (Members) session.getAttribute("loginInfo");
		String emp_num = loginInfo.getEmp_num();
		int intPage = 1;

		try {
			List<NoticeBoard> board_list = bservice.findAll(intPage);
			List<DocVO> doc_list = service.selectGJWait(emp_num);
			List<Schedule> listSchedule = sservice.findSchPersonal(emp_num);
			List<List<String>> yeonchagiganlist = gservice.giganselectAll(emp_num, "2018");
			List<Gunte> gslist = gservice.gselectAll(emp_num);
			List<Yeoncha> yeonchalist = gservice.selectAll(emp_num, "2018");
			request.setAttribute("yclist", yeonchalist);
			int useyc = 0;
			for (Yeoncha yc : yeonchalist) {
				useyc+=yc.getUse_yeoncha();
			}
			request.setAttribute("use", Integer.toString(useyc));
			
			//chart value select
			int list1 = service.findIng(emp_num).size();
			int list2 = service.selectOK(emp_num).size();
			int list3 = service.selectCancle(emp_num).size();
			int list4 = service.selectZero(emp_num).size();
			
			request.setAttribute("board_list", board_list);
			request.setAttribute("doc_list", doc_list);
			request.setAttribute("schedule", listSchedule);
			request.setAttribute("Yeoncha_gigan", yeonchagiganlist);
			request.setAttribute("Yeoncha", yeonchalist);
			request.setAttribute("Gunte", gslist);
			
			request.setAttribute("chartlist1", list1);
			request.setAttribute("chartlist2", list2);
			request.setAttribute("chartlist3", list3);
			request.setAttribute("chartlist4", list4);

		} catch (Exception e) {
			e.printStackTrace();
		}

		String forwardURL = "/home/home.jsp";
		return forwardURL;
	}

}
