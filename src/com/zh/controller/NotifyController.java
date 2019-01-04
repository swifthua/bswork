package com.zh.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.zh.page.PageBean;
import com.zh.po.User;
import com.zh.po.Notify;
import com.zh.service.NotifyService;
import com.zh.service.UserService;
import com.zh.utils.WorkUtils;

@Controller
public class NotifyController {
	
	@Autowired
	private NotifyService notifyService;
	
	@Autowired
	private UserService userService;
	
	@RequestMapping("findAllNotify")
	public ModelAndView findAllNotify(HttpServletRequest req,HttpServletResponse rep) throws Exception{
		int pc = WorkUtils.getPc(req);
		String url = WorkUtils.getUrl(req);
		User user=(User) req.getSession().getAttribute("userExist");
		PageBean<User> pbUser=userService.findByZwdm(pc);
		ModelAndView model=null;
		if(user!=null){
			String zwdm=user.getZwdm().getZwdm();
			if("01".equals(zwdm.substring(zwdm.length()-2, zwdm.length()))){
				PageBean<Notify> pb = notifyService.findNotifyCondition("",user.getYhdm(),pc);
				pb.setUrl(url);
				model=new ModelAndView("daily/gglist"); 
				model.addObject("pb", pb);
			}else{
				PageBean<Notify> pb = notifyService.findAllNotify(pc);
				pb.setUrl(url);
				model=new ModelAndView("daily/gglistcommon");
				model.addObject("pb", pb);
			}
			model.addObject("userlist", pbUser.getList());
		}else{
			model=new ModelAndView("login");
		}
		return model;
	}
	
	@RequestMapping("findNotifyCondition")
	public ModelAndView findNotifyCondition(HttpServletRequest req,HttpServletResponse rep) throws Exception{
		int pc = WorkUtils.getPc(req);
		String url = WorkUtils.getUrl(req);
		String ggbt=WorkUtils.getPar8(req.getParameter("ggbt"));
		String fqr=WorkUtils.getPar8(req.getParameter("fqr"));
		PageBean<Notify> pb = notifyService.findNotifyCondition(ggbt,fqr,pc);
		PageBean<User> pbUser=userService.findByZwdm(pc);
		pb.setUrl(url);
		ModelAndView model=new ModelAndView("daily/gglist");  
		model.addObject("pb", pb);
		model.addObject("userlist", pbUser.getList());
		return model;
	}
	
	@RequestMapping("toNotifyForm")
	public ModelAndView toProjectForm(){
		ModelAndView model=new ModelAndView("daily/ggForm");  
		return model;
	}
	
	@RequestMapping("notifyAdd")
	public String meetingAdd(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String ggbt=WorkUtils.getPar8(new String(request.getParameter("ggbt").getBytes("iso-8859-1"),"utf-8"));
		String ggnr=WorkUtils.getPar8(new String(request.getParameter("ggnr").getBytes("iso-8859-1"),"utf-8"));
		
		SimpleDateFormat formatter = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss");
		Date fqsj=formatter.parse(formatter.format(new Date()));
		Date lastUpdate=formatter.parse(formatter.format(new Date()));
		System.out.println("fqsj==="+fqsj);
		
		User fqr=(User) request.getSession().getAttribute("userExist");
		
		Notify notify=new Notify();
		notify.setGgbt(ggbt);
		notify.setGgnr(ggnr);
		notify.setFqsj(fqsj);
		notify.setLastUpdate(lastUpdate);
		notify.setFqr(fqr);
		notify.setSfjy(0);
		
		notifyService.add(notify);
		
		return "redirect:findAllNotify.do";
	}
	
	//删除公告
	@RequestMapping("delByGgid")
	public String delByHyid(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String ggid=WorkUtils.getPar8(request.getParameter("ggid"));
		int id=Integer.parseInt(ggid);
		Notify notify=notifyService.findById(id);
		notifyService.delete(notify);
		return "redirect:findAllNotify.do";
	}
	
	@RequestMapping("viewByGgid")
	public ModelAndView viewByHyid(HttpServletRequest request,HttpServletResponse response){
		String ggid=WorkUtils.getPar8(request.getParameter("ggid"));
		int id=Integer.parseInt(ggid);
		Notify notify=notifyService.findById(id);
		ModelAndView model=new ModelAndView("daily/ggView");  
		model.addObject("notify", notify);
		return model;
	}
	
	@RequestMapping("editByGgid")
	public ModelAndView editByHyid(HttpServletRequest request,HttpServletResponse response){
		String ggid=WorkUtils.getPar8(request.getParameter("ggid"));
		int id=Integer.parseInt(ggid);
		Notify notify=notifyService.findById(id);
		ModelAndView model=new ModelAndView("daily/ggEdit");  
		model.addObject("notify", notify);
		return model;
	}

	//修改公告信息
	@RequestMapping("ggEdit")
	public String ggEdit(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String ggnr=WorkUtils.getPar8(new String(request.getParameter("ggnr").getBytes("iso-8859-1"),"utf-8"));
		SimpleDateFormat formatter = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss");
		Date lastUpdate=formatter.parse(formatter.format(new Date()));
		
		String ggid=WorkUtils.getPar8(request.getParameter("ggid"));
		int id=Integer.parseInt(ggid);
		Notify notify=notifyService.findById(id);
		
		notify.setGgnr(ggnr);
		notify.setLastUpdate(lastUpdate);
		
		notifyService.update(notify);
		return "redirect:findAllNotify.do";
	}
	
	//批量删除
	@RequestMapping("deleteNotifyByIds")
	public String deleteNotifyByIds(HttpServletRequest request,HttpServletResponse response) {
		String ids = WorkUtils.getPar8(request.getParameter("ids"));
		String id[] = ids.split(",");
		if (id.length > 0) {
			for (String i : id) {
				Notify notify = notifyService.findById(Integer.parseInt(i));
				notifyService.delete(notify);
			}
		}
		return "redirect:findAllNotify.do";
	}
	
}
