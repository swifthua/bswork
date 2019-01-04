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
import com.zh.po.Business;
import com.zh.po.Examine;
import com.zh.po.Expense;
import com.zh.po.Project;
import com.zh.po.Status;
import com.zh.po.Traffic;
import com.zh.po.User;
import com.zh.service.BusinessService;
import com.zh.service.ExamineService;
import com.zh.service.ExpenseService;
import com.zh.service.ProjectService;
import com.zh.service.StatusService;
import com.zh.service.TrafficService;
import com.zh.service.UserService;
import com.zh.utils.WorkUtils;

@Controller
public class ExpenseController {
	@Autowired
	private ExpenseService expenseService;
	
	@Autowired
	private BusinessService businessService;
	
	@Autowired
	private StatusService statusService;
	
	@Autowired
	private ProjectService projectService;
	
	@Autowired
	private TrafficService trafficService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private ExamineService examineService;
	
	@RequestMapping("toExpense")
	public ModelAndView toExpense(HttpServletRequest request,HttpServletResponse response) throws Exception{
		PageBean<Project> page_project = projectService.findAllProject(WorkUtils.getPc(request));
		ModelAndView model=new ModelAndView("expense/expense"); 
		model.addObject("list_project", page_project.getList());
		return model;
	}
	
	@RequestMapping("toTravel")
	public ModelAndView toTravlel(HttpServletRequest request,HttpServletResponse response) throws Exception{
		PageBean<Project> page_project = projectService.findAllProject(WorkUtils.getPc(request));
		List<Traffic> list_traffic=trafficService.findAllTraffic();
		ModelAndView model=new ModelAndView("expense/travel"); 
		model.addObject("list_project", page_project.getList());
		model.addObject("list_traffic", list_traffic);
		return model;
	}
	
	@RequestMapping("expenseAdd")
	public String meetingAdd(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String bxyt=WorkUtils.getPar8(new String(request.getParameter("bxyt").getBytes("iso-8859-1"),"utf-8"));
		String bxfy=WorkUtils.getPar8(new String(request.getParameter("bxfy").getBytes("iso-8859-1"),"utf-8"));
		String remark=WorkUtils.getPar8(new String(request.getParameter("remark").getBytes("iso-8859-1"),"utf-8"));
		
		User bxr=(User) request.getSession().getAttribute("userExist");
		
		SimpleDateFormat formatter = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss");
		Date bxrq=formatter.parse(formatter.format(new Date()));
		
		Status wczt=statusService.findByZtid("1");
		
		Expense expense=new Expense();
		expense.setBxfy(bxfy);
		expense.setBxyt(bxyt);
		expense.setBxr(bxr);
		expense.setBmdm(bxr.getBmdm());
		expense.setRemark(remark);
		expense.setWczt(wczt);
		expense.setBxrq(bxrq);
		expense.setSfjy(0);
		
		String xmdm=WorkUtils.getPar8(request.getParameter("xmdm"));
		if(!"".equals(WorkUtils.trim(xmdm))){
			Project project=projectService.findByXmdm(xmdm);
			expense.setXmdm(project);
		}
		
		expenseService.add(expense);
		
		return "redirect:tofindExpense.do";
	}
	
	@RequestMapping("travelAdd")
	public String travelAdd(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String snjtfy=WorkUtils.getPar8(new String(request.getParameter("snjtfy").getBytes("iso-8859-1"),"utf-8"));
		String zsfy=WorkUtils.getPar8(new String(request.getParameter("zsfy").getBytes("iso-8859-1"),"utf-8"));
		String xcfy=WorkUtils.getPar8(new String(request.getParameter("xcfy").getBytes("iso-8859-1"),"utf-8"));
		int zfy=Integer.parseInt(snjtfy)+Integer.parseInt(zsfy)+Integer.parseInt(xcfy);
		String ccly=WorkUtils.getPar8(new String(request.getParameter("ccly").getBytes("iso-8859-1"),"utf-8"));
		
		String remark=WorkUtils.getPar8(new String(request.getParameter("remark").getBytes("iso-8859-1"),"utf-8"));
		SimpleDateFormat formatter = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss");
		String ccStart1=WorkUtils.getPar8(request.getParameter("ccStart1"));
		String ccStart2=WorkUtils.getPar8(request.getParameter("ccStart2"));
		Date ccStart=formatter.parse(ccStart1+" "+ccStart2);
		
		String ccStop1=WorkUtils.getPar8(request.getParameter("ccStop1"));
		String ccStop2=WorkUtils.getPar8(request.getParameter("ccStop2"));
		Date ccStop=formatter.parse(ccStop1+" "+ccStop2);
		
		User ccr=(User) request.getSession().getAttribute("userExist");
		
		Date djrq=formatter.parse(formatter.format(new Date()));
		
		Status wczt=statusService.findByZtid("1");
		
		Business business=new Business();
		business.setCcStart(ccStart);
		business.setCcStop(ccStop);
		business.setXcStart(ccStart);
		business.setXcStop(ccStop);
		business.setCcr(ccr);
		business.setBmdm(ccr.getBmdm());
		business.setDjrq(djrq);
		business.setZsfy(zsfy);
		business.setSnjtfy(snjtfy);
		business.setRemark(remark);
		business.setWczt(wczt);
		business.setXcfy(xcfy);
		business.setCcly(ccly);
		business.setZfy(String.valueOf(zfy));
		business.setSfjy(0);
		
		String xmdm=WorkUtils.getPar8(request.getParameter("xmdm"));
		if(!"".equals(WorkUtils.trim(xmdm))){
			Project project=projectService.findByXmdm(xmdm);
			business.setXmdm(project);
		}
		
		String xcgj=WorkUtils.getPar8(request.getParameter("xcgj"));
		if(!"".equals(WorkUtils.trim(xcgj))){
			Traffic traffic=trafficService.findByGjid(xcgj);
			business.setXcgj(traffic);
		}
		
		
		businessService.add(business);
		
		return "redirect:tofindBusiness.do";
	}
	
	@RequestMapping("tofindExpense")
	public ModelAndView findAllExpense(HttpServletRequest request,HttpServletResponse response) throws Exception{
		int pc=WorkUtils.getPc(request);
		String url=WorkUtils.getUrl(request);
		User user=(User) request.getSession().getAttribute("userExist");
		PageBean<Expense> pb=new PageBean<Expense>();
		String zwdm=user.getZwdm().getZwdm();
		ModelAndView model=new ModelAndView("expense/expensecx"); 
		List<User> list_user=userService.getUserByDepart(user.getBmdm().getBmdm());
		Iterator<User> iterator=list_user.iterator();
		while(iterator.hasNext()){
            User userIterator = iterator.next();
            if("admin".equals(userIterator.getYhzh()))
                iterator.remove();   
        }
		if("0001".equals(WorkUtils.trim(zwdm))){
			pb=expenseService.findByBmdmAndYhdmAndWczt(null,null, null, pc);
		}else if("01".equals(WorkUtils.trim(zwdm.substring(zwdm.length()-2,zwdm.length())))&&!"0001".equals(WorkUtils.trim(zwdm))){
			pb=expenseService.findByBmdmAndYhdmAndWczt(user.getBmdm().getBmdm(),null, null, pc);
		}else{
			pb=expenseService.findByBmdmAndYhdmAndWczt(user.getBmdm().getBmdm(),user.getYhdm(), null, pc);
		}
		pb.setUrl(url);
		List<Status> list_status=statusService.findAll();
		model.addObject("list_user",list_user);
		model.addObject("list_status", list_status);
		model.addObject("page_expense", pb);
		model.addObject("pb", pb);
		return model;
	}
	
	@RequestMapping("tofindBusiness")
	public ModelAndView findAllBusiness(HttpServletRequest request,HttpServletResponse response) throws Exception{
		int pc=WorkUtils.getPc(request);
		String url=WorkUtils.getUrl(request);
		User user=(User) request.getSession().getAttribute("userExist");
		PageBean<Business> pb=new PageBean<Business>();
		String zwdm=user.getZwdm().getZwdm();
		ModelAndView model=new ModelAndView("expense/expensecx"); 
		List<User> list_user=userService.getUserByDepart(user.getBmdm().getBmdm());
		Iterator<User> iterator=list_user.iterator();
		while(iterator.hasNext()){
            User userIterator = iterator.next();
            if("admin".equals(userIterator.getYhzh()))
                iterator.remove();   
        }
		if("0001".equals(WorkUtils.trim(zwdm))){
			pb=businessService.findByBmdmAndYhdmAndWczt(null,null, null, pc);
		}else if("01".equals(WorkUtils.trim(zwdm.substring(zwdm.length()-2,zwdm.length())))&&!"0001".equals(WorkUtils.trim(zwdm))){
			pb=businessService.findByBmdmAndYhdmAndWczt(user.getBmdm().getBmdm(),null, null, pc);
		}else{
			pb=businessService.findByBmdmAndYhdmAndWczt(user.getBmdm().getBmdm(),user.getYhdm(), null, pc);
		}
		pb.setUrl(url);
		List<Status> list_status=statusService.findAll();
		model.addObject("list_user",list_user);
		model.addObject("list_status", list_status);
		model.addObject("page_business", pb);
		model.addObject("pb", pb);
		return model;
	}
	

	@RequestMapping("viewByCcid")
	public ModelAndView viewByCcid(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String ccid=WorkUtils.getPar8(request.getParameter("ccid"));
		Business business=businessService.findById(Integer.parseInt(ccid));
		Examine examine=examineService.findByShdmAndType(ccid,"差旅报销审核",WorkUtils.getPc(request));
		ModelAndView model=new ModelAndView("expense/travelView"); 
		model.addObject("business", business);
		model.addObject("examine", examine);
		return model;
	}
	
	@RequestMapping("delByCcid")
	public String delByCcid(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String ccid=WorkUtils.getPar8(request.getParameter("ccid"));
		Business business=businessService.findById(Integer.parseInt(ccid));
		businessService.delete(business);
		return "redirect:findAllBusiness.do";
	}
	
	@RequestMapping("viewByBxid")
	public ModelAndView viewByBxid(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String bxid=WorkUtils.getPar8(request.getParameter("bxid"));
		Expense expense=expenseService.findById(Integer.parseInt(bxid));
		Examine examine=examineService.findByShdmAndType(bxid,"费用报销审核",WorkUtils.getPc(request));
		ModelAndView model=new ModelAndView("expense/expenseView"); 
		model.addObject("expense", expense);
		model.addObject("examine",examine);
		return model;
	}
	
	@RequestMapping("delByBxid")
	public String delByBxid(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String bxid=WorkUtils.getPar8(request.getParameter("bxid"));
		Expense expense=expenseService.findById(Integer.parseInt(bxid));
		expenseService.delete(expense);
		return "redirect:findAllExpense.do";
	}
	
	@RequestMapping("findBxMore")
	public ModelAndView findBxMore(HttpServletRequest req,HttpServletResponse resp) throws Exception{
		int pc=WorkUtils.getPc(req);
		String bxlx = req.getParameter("bxlx");
		String bmdm=req.getParameter("bmdm");
		String yhdm=req.getParameter("yhdm");
		String wczt = req.getParameter("wczt");
		User user=(User) req.getSession().getAttribute("userExist");
		String zwdm=user.getZwdm().getZwdm();
		PageBean<Business> page_business=new PageBean<Business>();
		PageBean<Expense> page_expense=new PageBean<Expense>();
		ModelAndView model=new ModelAndView("expense/expensecx"); 
		List<User> list_user=userService.getUserByDepart(user.getBmdm().getBmdm());
		Iterator<User> iterator=list_user.iterator();
		while(iterator.hasNext()){
			User userIterator = iterator.next();
			if("admin".equals(userIterator.getYhzh()))
				iterator.remove();   
		}
		if("费用报销".equals(bxlx)){
			if("0001".equals(WorkUtils.trim(zwdm))){
				page_expense=expenseService.findByBmdmAndYhdmAndWczt(bmdm,yhdm, wczt, pc);
			}else if("01".equals(WorkUtils.trim(zwdm.substring(zwdm.length()-2,zwdm.length())))&&!"0001".equals(WorkUtils.trim(zwdm))){
				page_expense=expenseService.findByBmdmAndYhdmAndWczt(user.getBmdm().getBmdm(),yhdm, wczt, pc);
			}else{
				page_expense=expenseService.findByBmdmAndYhdmAndWczt(user.getBmdm().getBmdm(),user.getYhdm(), wczt, pc);
			}
			model.addObject("pb", page_expense);
			model.addObject("page_expense", page_expense);
		}
		if("差旅报销".equals(bxlx)){
			if("0001".equals(WorkUtils.trim(zwdm))){
				page_business=businessService.findByBmdmAndYhdmAndWczt(bmdm,yhdm, wczt, pc);
			}else if("01".equals(WorkUtils.trim(zwdm.substring(zwdm.length()-2,zwdm.length())))&&!"0001".equals(WorkUtils.trim(zwdm))){
				page_business=businessService.findByBmdmAndYhdmAndWczt(user.getBmdm().getBmdm(),yhdm, wczt, pc);
			}else{
				page_business=businessService.findByBmdmAndYhdmAndWczt(user.getBmdm().getBmdm(),user.getYhdm(), wczt, pc);
			}
			model.addObject("pb", page_business);
			model.addObject("page_business", page_business);
		}
		
		List<Status> list_status=statusService.findAll();
		model.addObject("list_user",list_user);
		model.addObject("list_status", list_status);
		return model;
	}
	
	
}
