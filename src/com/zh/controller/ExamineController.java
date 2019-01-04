package com.zh.controller;

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
import com.zh.po.Leave;
import com.zh.po.Status;
import com.zh.po.User;
import com.zh.service.BusinessService;
import com.zh.service.DepartService;
import com.zh.service.ExamineService;
import com.zh.service.ExpenseService;
import com.zh.service.LeaveService;
import com.zh.service.StatusService;
import com.zh.service.UserService;
import com.zh.utils.WorkUtils;

@Controller
public class ExamineController {
	@Autowired
	private DepartService departService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private LeaveService leaveService;
	
	@Autowired
	private StatusService statusService;
	
	@Autowired
	private ExamineService examineService;
	
	@Autowired
	private ExpenseService expenseService;
	
	@Autowired
	private BusinessService businessService;
	
	@RequestMapping("toLeaveExamineList")
	public ModelAndView toLeaveExamineList(HttpServletRequest request,HttpServletResponse response) throws Exception{
		int pc=WorkUtils.getPc(request);
		String url=WorkUtils.getUrl(request);
		User user=(User) request.getSession().getAttribute("userExist");
		PageBean<Leave> pb=new PageBean<Leave>();
		String zwdm=user.getZwdm().getZwdm();
		List<Status> list_status=statusService.findAll();
		ModelAndView model=new ModelAndView("examine/leaveExamineList");
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
	
	@RequestMapping("findQjExamineMore")
	public ModelAndView findQjExamineMore(HttpServletRequest request,HttpServletResponse response) throws Exception{
		int pc=WorkUtils.getPc(request);
		String url=WorkUtils.getUrl(request);
		String bmdm=request.getParameter("bmdm");
		String yhdm=request.getParameter("yhdm");
		String wczt=request.getParameter("wczt");
		User user=(User) request.getSession().getAttribute("userExist");
		PageBean<Leave> pb=new PageBean<Leave>();
		String zwdm=user.getZwdm().getZwdm();
		List<Status> list_status=statusService.findAll();
		ModelAndView model=new ModelAndView("examine/leaveExamineList"); 
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
	
	@RequestMapping("toLeaveExamine")
	public ModelAndView toLeaveExamine(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String qjid=request.getParameter("qjid");
		Leave leave=leaveService.findById(Integer.parseInt(qjid));
		Examine examine=examineService.findByShdmAndType(qjid,"请休假审核",WorkUtils.getPc(request));
		ModelAndView model=new ModelAndView("examine/leaveExamine");
		model.addObject("leave",leave);
		model.addObject("examine", examine);
		return model;
	}
	
	@RequestMapping("examineByQjid")
	public String examineByQjid(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String qjid=request.getParameter("qjid");
		User user=(User) request.getSession().getAttribute("userExist");
		
		Leave leave=leaveService.findById(Integer.parseInt(qjid));
		Status wczt5=statusService.findByZtid("5");  //待上级审核
		Status wczt4=statusService.findByZtid("4");  //审核通过
		Status wczt3=statusService.findByZtid("3");  //审核未通过
		Examine examine=new Examine();
		if("admin".equals(user.getYhzh())){
			String zwdm=leave.getQjr().getZwdm().getZwdm();
			String shyj2=WorkUtils.getPar8(new String(request.getParameter("shyj2").getBytes("iso-8859-1"),"utf-8"));
			if("01".equals(zwdm.substring(zwdm.length()-2, zwdm.length()))){
				examine.setType("请休假审核");
				examine.setShdm(qjid);
				examine.setShr1(user);
				examine.setShr2(user);
				examine.setShyj2(shyj2);
				examine.setShsj2(new Date());
				examineService.add(examine);
			}else{
				examine=examineService.findByShdmAndType(qjid,"请休假审核",WorkUtils.getPc(request));
				examine.setShr2(user);
				examine.setShyj2(shyj2);
				examine.setShsj2(new Date());
				
				examineService.update(examine);
			}
			if("同意".equals(shyj2)){
				leave.setWczt(wczt4);
			}else{
				leave.setWczt(wczt3);
			}
		}else{
			String shyj1=WorkUtils.getPar8(new String(request.getParameter("shyj1").getBytes("iso-8859-1"),"utf-8"));
			examine.setType("请休假审核");
			examine.setShdm(qjid);
			examine.setShr1(user);
			examine.setShr2(user);
			examine.setShyj1(shyj1);
			examine.setShsj1(new Date());
			examineService.add(examine);
			
			if("同意".equals(shyj1)){
				leave.setWczt(wczt5);
			}else{
				leave.setWczt(wczt3);
			}
		}
		leaveService.update(leave);
		
		return "redirect:toLeaveExamineList.do";
	}
	
	
	
	@RequestMapping("toExpenseExamineList")
	public ModelAndView toExpenseExamineList(HttpServletRequest request,HttpServletResponse response) throws Exception{
		int pc=WorkUtils.getPc(request);
		String url=WorkUtils.getUrl(request);
		User user=(User) request.getSession().getAttribute("userExist");
		PageBean<Expense> pb=new PageBean<Expense>();
		String zwdm=user.getZwdm().getZwdm();
		ModelAndView model=new ModelAndView("examine/expenseExamineList"); 
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
	
	@RequestMapping("toBusinessExamineList")
	public ModelAndView toBusinessExamineList(HttpServletRequest request,HttpServletResponse response) throws Exception{
		int pc=WorkUtils.getPc(request);
		String url=WorkUtils.getUrl(request);
		User user=(User) request.getSession().getAttribute("userExist");
		PageBean<Business> pb=new PageBean<Business>();
		String zwdm=user.getZwdm().getZwdm();
		ModelAndView model=new ModelAndView("examine/expenseExamineList"); 
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
	
	@RequestMapping("toExpenseExamine")
	public ModelAndView toExpenseExamine(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String bxid=request.getParameter("bxid");
		Expense expense=expenseService.findById(Integer.parseInt(bxid));
		Examine examine=examineService.findByShdmAndType(bxid,"费用报销审核",WorkUtils.getPc(request));
		ModelAndView model=new ModelAndView("examine/expenseExamine");
		model.addObject("expense",expense);
		model.addObject("examine", examine);
		return model;
	}
	
	@RequestMapping("toBusinessExamine")
	public ModelAndView toBusinessExamine(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String ccid=request.getParameter("ccid");
		Business business=businessService.findById(Integer.parseInt(ccid));
		Examine examine=examineService.findByShdmAndType(ccid,"差旅报销审核",WorkUtils.getPc(request));
		ModelAndView model=new ModelAndView("examine/travelExamine");
		model.addObject("business",business);
		model.addObject("examine", examine);
		return model;
	}
	
	@RequestMapping("examineByBxid")
	public String examineByBxid(HttpServletRequest request,HttpServletResponse response) throws Exception{
		User user=(User) request.getSession().getAttribute("userExist");
		Status wczt4=statusService.findByZtid("4");  //审核通过
		Status wczt3=statusService.findByZtid("3");  //审核未通过
		String bxid=request.getParameter("bxid");
		String shyj2=WorkUtils.getPar8(new String(request.getParameter("shyj2").getBytes("iso-8859-1"),"utf-8"));
		Expense expense=expenseService.findById(Integer.parseInt(bxid));
		if("同意".equals(shyj2)){
			expense.setWczt(wczt4);
		}else{
			expense.setWczt(wczt3);
		}
		expenseService.update(expense);
		Examine examine=new Examine();
		examine.setShdm(bxid);
		examine.setType("费用报销审核");
		examine.setShr1(user);
		examine.setShr2(user);
		examine.setShyj2(shyj2);
		examine.setShsj2(new Date());
		
		examineService.add(examine);
		return "redirect:toExpenseExamineList.do";
	}
	
	@RequestMapping("examineByCcid")
	public String examineByCcid(HttpServletRequest request,HttpServletResponse response) throws Exception{
		User user=(User) request.getSession().getAttribute("userExist");
		Status wczt4=statusService.findByZtid("4");  //审核通过
		Status wczt3=statusService.findByZtid("3");  //审核未通过
		String ccid=request.getParameter("ccid");
		String shyj2=WorkUtils.getPar8(new String(request.getParameter("shyj2").getBytes("iso-8859-1"),"utf-8"));
		Business business=businessService.findById(Integer.parseInt(ccid));
		if("同意".equals(shyj2)){
			business.setWczt(wczt4);
		}else{
			business.setWczt(wczt3);
		}
		businessService.update(business);
		Examine examine=new Examine();
		examine.setShdm(ccid);
		examine.setType("差旅报销审核");
		examine.setShr1(user);
		examine.setShr2(user);
		examine.setShyj2(shyj2);
		examine.setShsj2(new Date());
		
		examineService.add(examine);
		return "redirect:toBusinessExamineList.do";
	}
	
	@RequestMapping("findExpenseExamineMore")
	public ModelAndView findExpenseExamineMore(HttpServletRequest request,HttpServletResponse response) throws Exception{
		int pc=WorkUtils.getPc(request);
		String bxlx = request.getParameter("bxlx");
		String bmdm=request.getParameter("bmdm");
		String yhdm=request.getParameter("yhdm");
		String wczt = request.getParameter("wczt");
		User user=(User) request.getSession().getAttribute("userExist");
		String zwdm=user.getZwdm().getZwdm();
		PageBean<Business> page_business=new PageBean<Business>();
		PageBean<Expense> page_expense=new PageBean<Expense>();
		ModelAndView model=new ModelAndView("examine/expenseExamineList"); 
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
