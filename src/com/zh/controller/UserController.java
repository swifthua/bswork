package com.zh.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zh.page.PageBean;
import com.zh.po.Depart;
import com.zh.po.Position;
import com.zh.po.User;
import com.zh.service.DepartService;
import com.zh.service.PositionService;
import com.zh.service.UserService;
import com.zh.utils.WorkUtils;

@Controller
public class UserController extends HttpServlet{

	private static final long serialVersionUID = 1L;

	@Autowired
	private UserService userService;
	
	@Autowired
	private DepartService departService;
	
	@Autowired 
	private PositionService positionService;
	
	//登录
	@RequestMapping("login")
	public String login(@RequestParam("username") String username, 
			@RequestParam("password") String password,HttpServletRequest request,HttpServletResponse response) {
		User user = new User();
		user.setYhzh(username);
		user.setYhkl(password);
		User userExist = userService.login(user);
		if(userExist != null) {//成功
			//使用session保持登录状态
			HttpSession session=request.getSession();
			session.setAttribute("userExist", userExist);
			User user1=(User)session.getAttribute("userExist");
			System.out.println(user1);
			
			if("ok".equals(request.getParameter("saveName"))){
				//创建cookie  记住用户名和密码
				Cookie c=new Cookie("savename", username+"-"+password);
				c.setMaxAge(3600);
				c.setPath(request.getContextPath()+"/");
				response.addCookie(c);
			}
			return "home";
		} else {//失败
			User user2=userService.findByYhzh(username);
			if(user2!=null){
				request.setAttribute("msg", "密码不正确!");
			}else{
				request.setAttribute("msg", "该用户不存在");
			}
			return "login";
		}
	}
	
	//跳到首页
	@RequestMapping("home")
	public String home(){
		return "home";
	}
	
	//跳到修改密码页面
	@RequestMapping("updatePassword")
	public String updatePassword(){
		return "updatePassword";
	}
	
	//重置密码
	@RequestMapping("repassword")
	public String repassword(HttpServletRequest request){
		User user = (User)request.getSession().getAttribute("userExist");
		String newpwd=WorkUtils.getPar8(request.getParameter("newpwd"));
		if(user!=null&&!"".equals(newpwd)){
			user.setYhkl(newpwd);
			userService.repassword(user);
		}
		request.getSession().invalidate();  //重置成功销毁session
		return "passwordsuss";
	}
	
	//退出
	@RequestMapping("quit")
	public String quit(HttpServletRequest request){
		request.getSession().invalidate();
		return "login";
	}
	
	//查询所有员工
	@RequestMapping("findAllUser")
	public ModelAndView findAllUser(HttpServletRequest request,HttpServletResponse response) throws Exception{
		int pc=WorkUtils.getPc(request);
		String url=WorkUtils.getUrl(request);
		PageBean<User> pb=userService.findByBmdmAndYhdm(null, null, pc);
		List<User> list_user=pb.getList();
		Iterator<User> iterator=list_user.iterator();
		while(iterator.hasNext()){
            User userIterator = iterator.next();
            if("admin".equals(userIterator.getYhzh()))
                iterator.remove();   
        }
		ModelAndView model=new ModelAndView("system/userlist");  // system/userlist此处是返回的界面
		pb.setUrl(url);
		model.addObject("pb", pb);
		return model;
	}
	
	@RequestMapping("findUserMore")
	public ModelAndView findUserMore(HttpServletRequest request,HttpServletResponse response) throws Exception{
		int pc=WorkUtils.getPc(request);
		String url=WorkUtils.getUrl(request);
		String bmdm=request.getParameter("bmdm");
		String yhdm=request.getParameter("yhdm");
		if(!"".equals(WorkUtils.trim(bmdm))){
			url+="&bmdm="+bmdm;
		}
		if(!"".equals(WorkUtils.trim(yhdm))){
			url+="&yhdm="+yhdm;
		}
		PageBean<User> pb=userService.findByBmdmAndYhdm(bmdm, yhdm, pc);
		pb.setUrl(url);
		List<User> list_user=pb.getList();
		Iterator<User> iterator=list_user.iterator();
		while(iterator.hasNext()){
            User userIterator = iterator.next();
            if("admin".equals(userIterator.getYhzh()))
                iterator.remove();   
        }
		ModelAndView model=new ModelAndView("system/userlist");  // system/userlist此处是返回的界面
		model.addObject("pb", pb);
		return model;
	}
	
	//通讯录
	@RequestMapping("tongxunlu")
	public ModelAndView tongxunlu(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		int pc = WorkUtils.getPc(req);
		String url = WorkUtils.getUrl(req);
		PageBean<User> pb = userService.tongxunlu( pc);
		pb.setUrl(url);
		
		for(int i=0;i<pb.getList().size();i++){
			User user=pb.getList().get(i);
			if("yh000".equals(user.getYhdm())||"admin".equals(user.getYhzh())){
				pb.getList().remove(user);
			}
		}
		ModelAndView model=new ModelAndView("system/tongxunlu");  // system/userlist此处是返回的界面
		model.addObject("pb", pb);
		return model;
	}
	
	//通讯录
	@RequestMapping("findByYhxm")
	public ModelAndView findByYhxm(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		//1. 得到pc：如果页面传递，使用页面的，如果没传，pc=1
		int pc = WorkUtils.getPc(req);
		//2. 得到url：...
		String url = WorkUtils.getUrl(req);
		//3. 获取查询条件，本方法就是yhxm
		String yhxm = req.getParameter("yhxm");
		//4. 使用pc和cid调用得到PageBean
		PageBean<User> pb = userService.findByYhxm(yhxm, pc);
		//5. 给PageBean设置url，保存PageBean
		pb.setUrl(url);
		for(int i=0;i<pb.getList().size();i++){
			User user=pb.getList().get(i);
			if("yh000".equals(user.getYhdm())||"admin".equals(user.getYhzh())){
				pb.getList().remove(user);
			}
		}
		ModelAndView model=new ModelAndView("system/tongxunlu");  // system/userlist此处是返回的界面
		model.addObject("pb", pb);
		return model;
	}
	
	@RequestMapping("toUserForm")
	public ModelAndView toUserForm(){
		ModelAndView model=new ModelAndView("system/userForm");  
		return model;
	}
	
	//ajax验证原始密码
	@RequestMapping("ajaxValidatePwd")
	@ResponseBody
	public String ajaxValidatePwd(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String flag="";
		String password=WorkUtils.getPar8(request.getParameter("password"));
		User user = (User)request.getSession().getAttribute("userExist");
		if(user.getYhkl().equals(password)){
			flag="ok";
		}
		return flag;
	}
	
	//新增用户
	@RequestMapping("userAdd")
	public String userAdd(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String yhxm=WorkUtils.getPar8(new String(request.getParameter("yhxm").getBytes("iso-8859-1"),"utf-8"));
		String yhxb=WorkUtils.getPar8(new String(request.getParameter("yhxb").getBytes("iso-8859-1"),"utf-8"));
		String bmdm=WorkUtils.getPar8(request.getParameter("bmdm"));
		Depart depart=departService.findByBmdm(bmdm);
		String zwdm=WorkUtils.getPar8(request.getParameter("zwdm"));
		Position position=positionService.findByZwdm(zwdm);
		String phone=WorkUtils.getPar8(request.getParameter("phone"));
		String email=WorkUtils.getPar8(request.getParameter("email"));
		String address=WorkUtils.getPar8(new String(request.getParameter("address").getBytes("iso-8859-1"),"utf-8"));
		String remark=WorkUtils.getPar8(new String(request.getParameter("remark").getBytes("iso-8859-1"),"utf-8"));
		String date=WorkUtils.getPar8(request.getParameter("csrq"));
		
		//日期转化和格式化
		SimpleDateFormat formatter = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss");
		Date csrq=formatter.parse(date);
		
		//得到yhzh和yhkl
		String yhzh=WorkUtils.converterToFirstSpell(yhxm);
		String yhkl=WorkUtils.converterToFirstSpell(yhxm);
		
		//查到最大yhdm，然后+1
		String Maxyhdm=userService.findMaxYhdm();
		int dm=Integer.valueOf(Maxyhdm.substring(2,Maxyhdm.length()));
		dm+=1;
		String yhdm=String.valueOf(dm);
		if(yhdm.length()==1){
			yhdm="yh00"+yhdm;
		}else if(yhdm.length()==2){
			yhdm="yh0"+yhdm;
		}else if(yhdm.length()==3){
			yhdm="yh"+yhdm;
		}
		
		User user=new User();
		user.setYhdm(yhdm);
		user.setYhxm(yhxm);
		user.setYhzh(yhzh);
		user.setYhkl(yhkl);
		user.setYhxb(yhxb);
		user.setBmdm(depart);
		user.setZwdm(position);
		user.setPhone(phone);
		user.setEmail(email);
		user.setAddress(address);
		user.setRemark(remark);
		user.setCsrq(csrq);
		user.setSfjy(0);
		userService.add(user);
		
		return "redirect:findAllUser.do";
	}
	
	//删除用户
	@RequestMapping("delByYhdm")
	public String delByYhdm(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String yhdm=WorkUtils.getPar8(request.getParameter("yhdm"));
		User user=userService.findByYhdm(yhdm);
		userService.delete(user);
		return "redirect:findAllUser.do";
	}
	
	//查看用户信息
	@RequestMapping("viewByYhdm")
	public ModelAndView viewByYhdm(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String yhdm=WorkUtils.getPar8(request.getParameter("yhdm"));
		User user=userService.findByYhdm(yhdm);
		ModelAndView model=new ModelAndView("system/userView"); 
		model.addObject("user", user);
		return model;
	}
	
	//跳转到修改页面
	@RequestMapping("editByYhdm")
	public ModelAndView editByYhdm(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String yhdm=WorkUtils.getPar8(request.getParameter("yhdm"));
		User user=userService.findByYhdm(yhdm);
		ModelAndView model=new ModelAndView("system/userEdit"); 
		model.addObject("user", user);
		return model;
	}
	
	//修改用户
	@RequestMapping("userEdit")
	public String userEdit(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String bmdm=WorkUtils.getPar8(request.getParameter("bmdm"));
		Depart depart=departService.findByBmdm(bmdm);
		String zwdm=WorkUtils.getPar8(request.getParameter("zwdm"));
		Position position=positionService.findByZwdm(zwdm);
		String phone=WorkUtils.getPar8(request.getParameter("phone"));
		String email=WorkUtils.getPar8(request.getParameter("email"));
		String address=WorkUtils.getPar8(new String(request.getParameter("address").getBytes("iso-8859-1"),"utf-8"));
		String remark=WorkUtils.getPar8(new String(request.getParameter("remark").getBytes("iso-8859-1"),"utf-8"));
		
		String yhdm=WorkUtils.getPar8(request.getParameter("yhdm"));
		User user=userService.findByYhdm(yhdm);
		user.setBmdm(depart);
		user.setZwdm(position);
		user.setPhone(phone);
		user.setEmail(email);
		user.setAddress(address);
		user.setRemark(remark);
		user.setSfjy(0);
		userService.update(user);
		return "redirect:findAllUser.do";
	}

	@RequestMapping("getUserByDepart")
	@ResponseBody
	public String getUserByDepart(HttpServletRequest req, HttpServletResponse resp){
		String code = WorkUtils.getPar8(req.getParameter("code"));
		List<User> list_user=userService.getUserByDepart(code);
		String result=toJSON(list_user);
		return result;
	}
	
	private String toJSON(List<User> list) {
		StringBuilder json = new StringBuilder();
		json.append("[");
		for (User u : list) {
			json.append(u.toJsonString());
			json.append(",");
		}
		json.setCharAt(json.length() - 1, ']');
		return json.toString();
	}
	
	//批量删除
	@RequestMapping("deleteUserByIds")
	public String deleteUserByIds(HttpServletRequest request,HttpServletResponse response) {
		String ids = WorkUtils.getPar8(request.getParameter("ids"));
		String id[] = ids.split(",");
		if (id.length > 0) {
			for (String i : id) {
				User user = userService.findByYhdm(i);
				userService.delete(user);
			}
		}
		return "redirect:findAllUser.do";
	}

}

