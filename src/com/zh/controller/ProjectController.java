package com.zh.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.zh.page.PageBean;
import com.zh.po.Project;
import com.zh.po.User;
import com.zh.service.ProjectService;
import com.zh.service.UserService;
import com.zh.utils.FavFTPUtil;
import com.zh.utils.WorkUtils;

@Controller
public class ProjectController {
	
	public static final String hostName="192.168.43.164";
	public static final int port = 21;
	public static final String username = "swifthua";
	public static final String password = "swifthua";
	public static final String pathname = "/zh";
	//String filename = "测试.txt";
	//String originfilename = "G:\\test.txt";
	
	@Autowired
	private ProjectService projectService;
	
	@Autowired
	private UserService userService;
	
	@RequestMapping("findAllProject")
	public ModelAndView findAllProject(HttpServletRequest req,HttpServletResponse rep) throws Exception{
		int pc = WorkUtils.getPc(req);
		String url = WorkUtils.getUrl(req);
		PageBean<Project> pb = projectService.findAllProject(pc);
		pb.setUrl(url);
		ModelAndView model=new ModelAndView("system/projectList");  
		model.addObject("pb", pb);
		return model;
	}
	
	@RequestMapping("findProjectByXmmc")
	public ModelAndView findProjectByXmmc(HttpServletRequest req,HttpServletResponse rep) throws Exception{
		int pc = WorkUtils.getPc(req);
		String url = WorkUtils.getUrl(req);
		String xmmc = req.getParameter("xmmc");
		PageBean<Project> pb = projectService.findProjectByXmmc(xmmc,pc);
		pb.setUrl(url);
		ModelAndView model=new ModelAndView("system/projectList");  
		model.addObject("pb", pb);
		return model;
	}
	
	@RequestMapping("toProjectForm")
	public ModelAndView toProjectForm(){
		ModelAndView model=new ModelAndView("system/projectForm");  
		return model;
	}
	
	@RequestMapping(value = ("/projectAdd"), method = RequestMethod.POST)
	public String projectAdd(HttpServletRequest request,HttpServletResponse response,
			@RequestParam(value = "fj", required = false) MultipartFile file) throws Exception{
		String xmmc=WorkUtils.getPar8(request.getParameter("xmmc"));
		String xmxx=WorkUtils.getPar8(request.getParameter("xmxx"));
		String remark=WorkUtils.getPar8(request.getParameter("remark"));
		Project project=new Project();
		
		String MaxXmdm=projectService.findMaxXmdm();
		int dm=1;
		if(!"".equals(WorkUtils.trim(MaxXmdm))){
			dm=Integer.valueOf(MaxXmdm.substring(2,MaxXmdm.length()));
			dm+=1;
		}
		
		String xmdm=String.valueOf(dm);
		if(xmdm.length()==1){
			xmdm="xm00"+xmdm;
		}else if(xmdm.length()==2){
			xmdm="xm0"+xmdm;
		}else if(xmdm.length()==3){
			xmdm="xm"+xmdm;
		}
		
		project.setXmdm(xmdm);
		
		project.setBbh("1.0");
		project.setXmmc(xmmc);
		project.setXmxx(xmxx);
		project.setRemark(remark);
		project.setSfjy(0);
		
		User lxr=(User)request.getSession().getAttribute("userExist");
		project.setLxr(lxr);
		
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		Date lxrq=df.parse(df.format(new Date()));
		project.setLxrq(lxrq);
		project.setLastUpdate(lxrq);
		
		if (!file.isEmpty()) {
			String originalFileName = file.getOriginalFilename();
			String fjmc=originalFileName.substring(0,originalFileName.lastIndexOf("."));
			project.setFjmc(fjmc);
			String fjgs=originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
			project.setFjgs(fjgs);
			DecimalFormat decimalFormat=new DecimalFormat(".00");
			float f=(float) file.getSize()/1024;  //以kb为单位
			float fjdx=Float.valueOf(decimalFormat.format(f));
			project.setFjdx(fjdx);
			project.setFtpUrl(pathname);
			
			//上传文件到FTP
			FavFTPUtil.uploadFile(hostName, port, username, password, pathname, originalFileName, file.getInputStream());
		}
		if(project!=null){
			projectService.add(project);
		}
		
		return "redirect:findAllProject.do";
	}
	
	@RequestMapping("downloadByXmdm")
	@ResponseBody
	public void downloadByXmdm(HttpServletRequest request,HttpServletResponse response){
		String xmdm=WorkUtils.getPar8(request.getParameter("xmdm"));
		System.out.println("xmdm=="+xmdm);
		Project project=projectService.findByXmdm(xmdm);
		String fileName=project.getFjmc()+"."+project.getFjgs();
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("multipart/form-data");
		response.setHeader("Content-Disposition","attachment;fileName=" + project.getFjmc()+"."+project.getFjgs());
		
		String temppath="G://temp";
		String localpath=FavFTPUtil.downloadFile(hostName, port, username, password, pathname, fileName,temppath);
		
		if(!temppath.equals(localpath)){
			try{
				InputStream in=new FileInputStream(localpath);
				byte[] b = new byte[1024];
				int i = 0;
				while ((i = in.read(b)) > 0) {
					response.getOutputStream().write(b, 0, i);
				}
				in.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			File file=new File(localpath);
			file.delete();
		}
	}
	
	@RequestMapping("delByXmdm")
	public String delByXmdm(HttpServletRequest request,HttpServletResponse response){
		String xmdm=WorkUtils.getPar8(request.getParameter("xmdm"));
		Project project=projectService.findByXmdm(xmdm);
		projectService.delete(project);
		String filename=project.getFjmc()+"."+project.getFjgs();
		FavFTPUtil.deleteFile(hostName, port, username, password, pathname, filename);
		return "redirect:findAllProject.do";
				
	}
	
	@RequestMapping("viewByXmdm")
	public ModelAndView viewByXmdm(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String xmdm=WorkUtils.getPar8(request.getParameter("xmdm"));
		Project project=projectService.findByXmdm(xmdm);
		ModelAndView model=new ModelAndView("system/projectView"); 
		model.addObject("project", project);
		return model;
	}
	

}
