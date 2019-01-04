package com.zh.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zh.dao.ProjectDao;
import com.zh.page.PageBean;
import com.zh.po.Project;

@Transactional
@Service
public class ProjectService {
	
	@Autowired
	private ProjectDao projectDao;
	
	public void add(Project project){
		projectDao.add(project);
	}
	
	public void delete(Project project){
		projectDao.delete(project);
	}
	
	public PageBean<Project> findAllProject(int pc) throws Exception{
		return projectDao.findAllProject(pc);
	}
	
	public String findMaxXmdm(){
		return projectDao.findMaxXmdm();
	}
	
	public Project findByXmdm(String xmdm){
		return projectDao.findByXmdm(xmdm);
	}

	public PageBean<Project> findProjectByXmmc(String xmmc, int pc) throws Exception{
		return projectDao.findProjectByXmmc(xmmc,pc);
	}

}
