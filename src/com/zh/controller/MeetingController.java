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
import com.zh.po.Meeting;
import com.zh.po.User;
import com.zh.service.MeetingService;
import com.zh.service.UserService;
import com.zh.utils.WorkUtils;

@Controller
public class MeetingController {
	
	@Autowired
	private MeetingService meetingService;
	
	@Autowired
	private UserService userService;
	
	@RequestMapping("findAllMeeting")
	public ModelAndView findAllMeeting(HttpServletRequest req,HttpServletResponse rep) throws Exception{
		int pc = WorkUtils.getPc(req);
		String url = WorkUtils.getUrl(req);
		PageBean<Meeting> pb = meetingService.findAllMeeting(pc);
		PageBean<User> pbUser=userService.findByZwdm(pc);
		pb.setUrl(url);
		ModelAndView model=null;
		User user=(User) req.getSession().getAttribute("userExist");
		if(user!=null){
			String zwdm=user.getZwdm().getZwdm();
			if("01".equals(zwdm.substring(zwdm.length()-2, zwdm.length()))){
				model=new ModelAndView("daily/hylist"); 
			}else{
				model=new ModelAndView("daily/hylistcommon");
			}
			model.addObject("pb", pb);
			model.addObject("userlist", pbUser.getList());
		}else{
			model=new ModelAndView("login");
		}
		return model;
	}
	
	@RequestMapping("findMeetingCondition")
	public ModelAndView findMeetingCondition(HttpServletRequest req,HttpServletResponse rep) throws Exception{
		int pc = WorkUtils.getPc(req);
		String url = WorkUtils.getUrl(req);
		String hybt=WorkUtils.getPar8(req.getParameter("hybt"));
		String hyfqr=WorkUtils.getPar8(req.getParameter("hyfqr"));
		PageBean<Meeting> pb = meetingService.findMeetingCondition(hybt,hyfqr,pc);
		PageBean<User> pbUser=userService.findByZwdm(pc);
		pb.setUrl(url);
		ModelAndView model=new ModelAndView("daily/hylist");  
		model.addObject("pb", pb);
		model.addObject("userlist", pbUser.getList());
		return model;
	}
	
	@RequestMapping("toMeetingForm")
	public ModelAndView toProjectForm(){
		ModelAndView model=new ModelAndView("daily/hyForm");  
		return model;
	}
	
	@RequestMapping("meetingAdd")
	public String meetingAdd(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String hybt=WorkUtils.getPar8(new String(request.getParameter("hybt").getBytes("iso-8859-1"),"utf-8"));
		String hynr=WorkUtils.getPar8(new String(request.getParameter("hynr").getBytes("iso-8859-1"),"utf-8"));
		
		String hysj1=WorkUtils.getPar8(request.getParameter("hysj1"));
		String hysj2=WorkUtils.getPar8(request.getParameter("hysj2"));
		String date=hysj1+" "+hysj2;
		SimpleDateFormat formatter = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss");
		Date hysj=formatter.parse(date);
		Date djsj=formatter.parse(formatter.format(new Date()));
		
		String remark=WorkUtils.getPar8(new String(request.getParameter("remark").getBytes("iso-8859-1"),"utf-8"));
		
		User hyfqr=(User) request.getSession().getAttribute("userExist");
		
		Meeting meeting=new Meeting();
		meeting.setHybt(hybt);
		meeting.setHynr(hynr);
		meeting.setHysj(hysj);
		meeting.setDjsj(djsj);
		meeting.setRemark(remark);
		meeting.setHyfqr(hyfqr);
		meeting.setHydz("会议室");
		
		meetingService.add(meeting);
		
		return "redirect:findAllMeeting.do";
	}
	
	//删除会议
	@RequestMapping("delByHyid")
	public String delByHyid(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String hyid=WorkUtils.getPar8(request.getParameter("hyid"));
		int id=Integer.parseInt(hyid);
		Meeting meeting=meetingService.findById(id);
		meetingService.delete(meeting);
		return "redirect:findAllMeeting.do";
	}
	
	@RequestMapping("viewByHyid")
	public ModelAndView viewByHyid(HttpServletRequest request,HttpServletResponse response){
		String hyid=WorkUtils.getPar8(request.getParameter("hyid"));
		int id=Integer.parseInt(hyid);
		Meeting meeting=meetingService.findById(id);
		ModelAndView model=new ModelAndView("daily/hyView");  
		model.addObject("meeting", meeting);
		return model;
	}
	
}
