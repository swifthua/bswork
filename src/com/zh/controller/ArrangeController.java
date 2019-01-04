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
import org.springframework.web.servlet.ModelAndView;

import com.zh.page.PageBean;
import com.zh.po.Arrange;
import com.zh.po.Depart;
import com.zh.po.Project;
import com.zh.po.User;
import com.zh.service.ArrangeService;
import com.zh.service.DepartService;
import com.zh.service.ProjectService;
import com.zh.service.UserService;
import com.zh.utils.WorkUtils;

@Controller
public class ArrangeController {
	
	@Autowired
	private ArrangeService arrangeService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private ProjectService projectService;
	
	@Autowired
	private DepartService departService;
	
	@RequestMapping("toGrjhList")
	public ModelAndView toGrjhList(HttpServletRequest request,HttpServletResponse response) throws Exception{
		int pc=WorkUtils.getPc(request);
		String url=WorkUtils.getUrl(request);
		User user=(User) request.getSession().getAttribute("userExist");
		PageBean<Arrange> pb=arrangeService.findByFzrAndBmdm(user.getYhdm(), "", pc);
		pb.setUrl(url);
		ModelAndView model=new ModelAndView("plan/grjhList"); 
		model.addObject("pb", pb);
		return model;
	}
	
	@RequestMapping("toBmjhList")
	public ModelAndView toBmjhList(HttpServletRequest request,HttpServletResponse response) throws Exception{
		int pc=WorkUtils.getPc(request);
		String url=WorkUtils.getUrl(request);
		User user=(User) request.getSession().getAttribute("userExist");
		PageBean<Arrange> pb=new PageBean<Arrange>();
		String zwdm=user.getZwdm().getZwdm();
		ModelAndView model=new ModelAndView("plan/bmjhList"); 
		if("0001".equals(WorkUtils.trim(zwdm))){
			pb=arrangeService.findByFzrAndBmdm(null, null, pc);
		}else{
			List<User> list_user=userService.getUserByDepart(user.getBmdm().getBmdm());
			Iterator<User> iterator=list_user.iterator();
			while(iterator.hasNext()){
	            User userIterator = iterator.next();
	            if("admin".equals(userIterator.getYhzh()))
	                iterator.remove();   //注意这个地方
	        }
			model.addObject("list_user", list_user);
			pb=arrangeService.findByFzrAndBmdm(null, user.getBmdm().getBmdm(), pc);
		}
		pb.setUrl(url);
		model.addObject("pb", pb);
		return model;
	}
	
	@RequestMapping("toNotFound")
	public ModelAndView toNotPermission(HttpServletRequest request,HttpServletResponse response) throws Exception{
		ModelAndView model=new ModelAndView("notfound"); 
		return model;
	}
	
	@RequestMapping("toJhForm")
	public ModelAndView toJhForm(HttpServletRequest request,HttpServletResponse response) throws Exception{
		User user=(User) request.getSession().getAttribute("userExist");
		List<User> list_user=userService.getUserByDepart(user.getBmdm().getBmdm());
		Iterator<User> iterator=list_user.iterator();
		while(iterator.hasNext()){
            User userIterator = iterator.next();
            if("admin".equals(userIterator.getYhzh()))
                iterator.remove();   //注意这个地方
        }
		PageBean<Project> page_project = projectService.findAllProject(WorkUtils.getPc(request));
		ModelAndView model=new ModelAndView("plan/jhForm"); 
		model.addObject("list_project", page_project.getList());
		model.addObject("list_user", list_user);
		return model;
	}
	
	@RequestMapping("viewByJhid")
	public ModelAndView viewByJhid(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String jhid=request.getParameter("jhid");
		Arrange arrange=arrangeService.findById(Integer.parseInt(jhid));
		ModelAndView model=new ModelAndView("plan/jhView"); 
		model.addObject("arrange", arrange);
		return model;
	}
	
	@RequestMapping("delByJhid")
	public String delByJhid(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String jhid=request.getParameter("jhid");
		Arrange arrange=arrangeService.findById(Integer.parseInt(jhid));
		arrangeService.delete(arrange);
		return "redirect:toBmjhList.do";
	}
	
	@RequestMapping("findJhMore")
	public ModelAndView findJhMore(HttpServletRequest request,HttpServletResponse response) throws Exception{
		int pc=WorkUtils.getPc(request);
		String url=WorkUtils.getUrl(request);
		String bmdm=request.getParameter("bmdm");
		String yhdm=request.getParameter("yhdm");
		User user=(User) request.getSession().getAttribute("userExist");
		PageBean<Arrange> pb=new PageBean<Arrange>();
		String zwdm=user.getZwdm().getZwdm();
		ModelAndView model=new ModelAndView("plan/bmjhList"); 
		if("0001".equals(WorkUtils.trim(zwdm))){
			pb=arrangeService.findByFzrAndBmdm(yhdm, bmdm, pc);
		}else{
			List<User> list_user=userService.getUserByDepart(user.getBmdm().getBmdm());
			Iterator<User> iterator=list_user.iterator();
			while(iterator.hasNext()){
	            User userIterator = iterator.next();
	            if("admin".equals(userIterator.getYhzh()))
	                iterator.remove();   //注意这个地方
	        }
			model.addObject("list_user", list_user);
			pb=arrangeService.findByFzrAndBmdm(yhdm, user.getBmdm().getBmdm(), pc);
		}
		pb.setUrl(url);
		model.addObject("pb", pb);
		return model;
	}
	
	@RequestMapping("arrangeAdd")
	public String arrangeAdd(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String xmdm=WorkUtils.getPar8(request.getParameter("xmdm"));
		String fzrdm=WorkUtils.getPar8(new String(request.getParameter("yhdm").getBytes("iso-8859-1"),"utf-8"));
		String bmdm=WorkUtils.getPar8(new String(request.getParameter("bmdm").getBytes("iso-8859-1"),"utf-8"));
		String jhnr=WorkUtils.getPar8(new String(request.getParameter("jhnr").getBytes("iso-8859-1"),"utf-8"));
		SimpleDateFormat formatter = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss");
		String jhStart1=WorkUtils.getPar8(request.getParameter("jhStart1"));
		String jhStart2=WorkUtils.getPar8(request.getParameter("jhStart2"));
		Date jhStart=formatter.parse(jhStart1+" "+jhStart2);
		
		String jhStop1=WorkUtils.getPar8(request.getParameter("jhStop1"));
		String jhStop2=WorkUtils.getPar8(request.getParameter("jhStop2"));
		Date jhStop=formatter.parse(jhStop1+" "+jhStop2);
		
		Date djsj=formatter.parse(formatter.format(new Date()));
		User apr=(User) request.getSession().getAttribute("userExist");
		User fzr=userService.findByYhdm(fzrdm);
		Arrange arrange=new Arrange();
		arrange.setApr(apr);
		Depart depart=departService.findByBmdm(bmdm);
		Project project=projectService.findByXmdm(xmdm);
		arrange.setBmdm(depart);
		arrange.setDjsj(djsj);
		arrange.setFzr(fzr);
		arrange.setJhlx("个人计划");
		arrange.setJhnr(jhnr);
		arrange.setJhStart(jhStart);
		arrange.setJhStop(jhStop);
		arrange.setSfjy(0);
		arrange.setXmdm(project);
		
		arrangeService.add(arrange);
		return "redirect:toBmjhList.do";
	}
}
