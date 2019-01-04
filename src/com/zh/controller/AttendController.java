package com.zh.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zh.page.PageBean;
import com.zh.po.Depart;
import com.zh.po.Examine;
import com.zh.po.Journal;
import com.zh.po.Leave;
import com.zh.po.Status;
import com.zh.po.User;
import com.zh.service.DepartService;
import com.zh.service.ExamineService;
import com.zh.service.JournalService;
import com.zh.service.LeaveService;
import com.zh.service.StatusService;
import com.zh.service.UserService;
import com.zh.utils.WorkUtils;

@Controller
public class AttendController {
	
	@Autowired
	private DepartService departService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private JournalService journalService;
	
	@Autowired
	private LeaveService leaveService;
	
	@Autowired
	private StatusService statusService;
	
	@Autowired
	private ExamineService examineService;
	
	@RequestMapping("toJournalForm")
	public ModelAndView toJournalForm(){
		ModelAndView model=new ModelAndView("attendance/journalForm");
		return model;
	}
	
	@RequestMapping("toJournalList")
	public ModelAndView toJournalList(HttpServletRequest request,HttpServletResponse response) throws Exception{
		int pc=WorkUtils.getPc(request);
		String url=WorkUtils.getUrl(request);
		User user=(User) request.getSession().getAttribute("userExist");
		PageBean<Journal> pb=new PageBean<Journal>();
		String zwdm=user.getZwdm().getZwdm();
		ModelAndView model=new ModelAndView("attendance/journalList");
		List<User> list_user=userService.getUserByDepart(user.getBmdm().getBmdm());
		Iterator<User> iterator=list_user.iterator();
		while(iterator.hasNext()){
            User userIterator = iterator.next();
            if("admin".equals(userIterator.getYhzh()))
                iterator.remove();   
        }
		if("0001".equals(WorkUtils.trim(zwdm))){
			pb=journalService.findByDjrAndBmdm(null, null, pc);
		}else if("01".equals(WorkUtils.trim(zwdm.substring(zwdm.length()-2,zwdm.length())))&&!"0001".equals(WorkUtils.trim(zwdm))){
			pb=journalService.findByDjrAndBmdm(null, user.getBmdm().getBmdm(), pc);
		}else{
			pb=journalService.findByDjrAndBmdm(user.getYhdm(), user.getBmdm().getBmdm(), pc);
		}
		pb.setUrl(url);
		model.addObject("list_user", list_user);
		model.addObject("pb", pb);
		return model;
	}
	
	@RequestMapping("journalAdd")
	public String journalAdd(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String rzsj=WorkUtils.getPar8(request.getParameter("rzsj"));
		String duration=WorkUtils.getPar8(request.getParameter("duration"));
		String rznr=WorkUtils.getPar8(new String(request.getParameter("rznr").getBytes("iso-8859-1"),"utf-8"));
		SimpleDateFormat formatter = new SimpleDateFormat( "yyyy-MM-dd");
		User djr=(User) request.getSession().getAttribute("userExist");
		
		Journal journal=new Journal();
		journal.setDjr(djr);
		Depart bmdm=departService.findByBmdm(djr.getBmdm().getBmdm());
		journal.setBmdm(bmdm);
		journal.setDjsj(new Date());
		journal.setDuration(duration);
		journal.setRznr(rznr);
		journal.setSfjy(0);
		journal.setRzsj(formatter.parse(rzsj));
		
		journalService.add(journal);
		return "redirect:toJournalList.do";
	}
	
	@RequestMapping("findRzMore")
	public ModelAndView findRzMore(HttpServletRequest request,HttpServletResponse response) throws Exception{
		int pc=WorkUtils.getPc(request);
		String url=WorkUtils.getUrl(request);
		String bmdm=request.getParameter("bmdm");
		String yhdm=request.getParameter("yhdm");
		User user=(User) request.getSession().getAttribute("userExist");
		PageBean<Journal> pb=new PageBean<Journal>();
		String zwdm=user.getZwdm().getZwdm();
		ModelAndView model=new ModelAndView("attendance/journalList"); 
		List<User> list_user=userService.getUserByDepart(user.getBmdm().getBmdm());
		Iterator<User> iterator=list_user.iterator();
		while(iterator.hasNext()){
			User userIterator = iterator.next();
			if("admin".equals(userIterator.getYhzh()))
				iterator.remove();   
		}
		if("0001".equals(WorkUtils.trim(zwdm))){
			pb=journalService.findByDjrAndBmdm(yhdm, bmdm, pc);
		}else if("01".equals(WorkUtils.trim(zwdm.substring(zwdm.length()-2,zwdm.length())))&&!"0001".equals(WorkUtils.trim(zwdm))){
			pb=journalService.findByDjrAndBmdm(yhdm, user.getBmdm().getBmdm(), pc);
		}else{
			pb=journalService.findByDjrAndBmdm(user.getYhdm(), user.getBmdm().getBmdm(), pc);
		}
		pb.setUrl(url);
		model.addObject("list_user", list_user);
		model.addObject("pb", pb);
		return model;
	}
	
	@RequestMapping("viewByRzid")
	public ModelAndView viewByRzid(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String rzid=request.getParameter("rzid");
		Journal journal=journalService.findById(Integer.parseInt(rzid));
		ModelAndView model=new ModelAndView("attendance/journalView"); 
		model.addObject("journal", journal);
		return model;
	}
	
	@RequestMapping("delByRzid")
	public String delByRzid(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String rzid=request.getParameter("rzid");
		Journal journal=journalService.findById(Integer.parseInt(rzid));
		journalService.delete(journal);
		return "redirect:toJournalList.do";
	}
	
	@RequestMapping("findByYhdmAndRzsj")
	@ResponseBody
	public String findByYhdmAndRzsj(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String flag="";
		String rzsj=request.getParameter("rzsj");
		String yhdm=request.getParameter("yhdm");
		PageBean<Journal> pb=journalService.findByYhdmAndRzsj(rzsj,yhdm,WorkUtils.getPc(request));
		if(pb.getList().size()>=1){
			flag="error";
		}
		return flag;
		
	}
	
	@RequestMapping("toLeaveForm")
	public ModelAndView toLeaveForm(){
		ModelAndView model=new ModelAndView("attendance/leaveForm");
		return model;
	}
	
	
	
	@RequestMapping("toLeaveList")
	public ModelAndView toLeaveList(HttpServletRequest request,HttpServletResponse response) throws Exception{
		int pc=WorkUtils.getPc(request);
		String url=WorkUtils.getUrl(request);
		User user=(User) request.getSession().getAttribute("userExist");
		PageBean<Leave> pb=new PageBean<Leave>();
		String zwdm=user.getZwdm().getZwdm();
		List<Status> list_status=statusService.findAll();
		ModelAndView model=new ModelAndView("attendance/leaveList");
		List<User> list_user=userService.getUserByDepart(user.getBmdm().getBmdm());
		Iterator<User> iterator=list_user.iterator();
		while(iterator.hasNext()){
            User userIterator = iterator.next();
            if("admin".equals(userIterator.getYhzh()))
                iterator.remove();   
        }
		if("0001".equals(WorkUtils.trim(zwdm))){
			pb=leaveService.findByQjrAndBmdmAndWczt(null, null,null, pc);
		}else if("01".equals(WorkUtils.trim(zwdm.substring(zwdm.length()-2,zwdm.length())))&&!"0001".equals(WorkUtils.trim(zwdm))){
			pb=leaveService.findByQjrAndBmdmAndWczt("", user.getBmdm().getBmdm(),null, pc);
		}else{
			pb=leaveService.findByQjrAndBmdmAndWczt(user.getYhdm(), user.getBmdm().getBmdm(),null, pc);
		}
		pb.setUrl(url);
		model.addObject("list_user", list_user);
		model.addObject("list_status", list_status);
		model.addObject("pb", pb);
		return model;
	}
	
	@RequestMapping("leaveAdd")
	public String leaveAdd(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String remark=WorkUtils.getPar8(new String(request.getParameter("remark").getBytes("iso-8859-1"),"utf-8"));
		
		SimpleDateFormat formatter = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss");
		User qjr=(User) request.getSession().getAttribute("userExist");
		String qjStart1=WorkUtils.getPar8(request.getParameter("qjStart1"));
		String qjStart2=WorkUtils.getPar8(request.getParameter("qjStart2"));
		Date qjStart=formatter.parse(qjStart1+" "+qjStart2);
		
		String qjStop1=WorkUtils.getPar8(request.getParameter("qjStop1"));
		String qjStop2=WorkUtils.getPar8(request.getParameter("qjStop2"));
		Date qjStop=formatter.parse(qjStop1+" "+qjStop2);
		Date djsj=formatter.parse(formatter.format(new Date()));
		
		Status wczt=statusService.findByZtid("1");
		Leave leave=new Leave();

		leave.setDjsj(djsj);
		leave.setQjStart(qjStart);
		leave.setQjStop(qjStop);
		leave.setQjr(qjr);
		leave.setRemark(remark);
		leave.setSfjy(0);
		leave.setWczt(wczt);
		leave.setBmdm(qjr.getBmdm());
		
		leaveService.add(leave);
		return "redirect:toLeaveList.do";
	}
	
	@RequestMapping("findQjMore")
	public ModelAndView findQjMore(HttpServletRequest request,HttpServletResponse response) throws Exception{
		int pc=WorkUtils.getPc(request);
		String url=WorkUtils.getUrl(request);
		String bmdm=request.getParameter("bmdm");
		String yhdm=request.getParameter("yhdm");
		String wczt=request.getParameter("wczt");
		User user=(User) request.getSession().getAttribute("userExist");
		PageBean<Leave> pb=new PageBean<Leave>();
		String zwdm=user.getZwdm().getZwdm();
		List<Status> list_status=statusService.findAll();
		ModelAndView model=new ModelAndView("attendance/leaveList"); 
		List<User> list_user=userService.getUserByDepart(user.getBmdm().getBmdm());
		Iterator<User> iterator=list_user.iterator();
		while(iterator.hasNext()){
			User userIterator = iterator.next();
			if("admin".equals(userIterator.getYhzh()))
				iterator.remove();   
		}
		if("0001".equals(WorkUtils.trim(zwdm))){
			pb=leaveService.findByQjrAndBmdmAndWczt(yhdm, bmdm,wczt, pc);
		}else if("01".equals(WorkUtils.trim(zwdm.substring(zwdm.length()-2,zwdm.length())))&&!"0001".equals(WorkUtils.trim(zwdm))){
			pb=leaveService.findByQjrAndBmdmAndWczt(yhdm, user.getBmdm().getBmdm(),wczt, pc);
		}else{
			pb=leaveService.findByQjrAndBmdmAndWczt(user.getYhdm(), user.getBmdm().getBmdm(),wczt, pc);
		}
		pb.setUrl(url);
		model.addObject("list_user", list_user);
		model.addObject("list_status", list_status);
		model.addObject("pb", pb);
		return model;
	}
	
	@RequestMapping("viewByQjid")
	public ModelAndView viewByQjid(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String qjid=request.getParameter("qjid");
		Leave leave=leaveService.findById(Integer.parseInt(qjid));
		Examine examine=examineService.findByShdmAndType(qjid,"请休假审核",WorkUtils.getPc(request));
		ModelAndView model=new ModelAndView("attendance/leaveView"); 
		model.addObject("leave", leave);
		model.addObject("examine", examine);
		return model;
	}
	
	@RequestMapping("delByQjid")
	public String delByQjid(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String qjid=request.getParameter("qjid");
		Leave leave=leaveService.findById(Integer.parseInt(qjid));
		leaveService.delete(leave);
		return "redirect:toLeaveList.do";
	}
	
}
