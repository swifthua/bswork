package com.zh.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zh.dao.LeaveDao;
import com.zh.page.PageBean;
import com.zh.po.Leave;

@Transactional
@Service
public class LeaveService {
	
	@Autowired
	private LeaveDao leaveDao;
	
	public void delete(Leave leave) {
		leaveDao.delete(leave);
	}
	
	public Leave findById(int id){
		return leaveDao.findById(id);
	}

	public void add(Leave leave) {
		leaveDao.add(leave);
		
	}

	public PageBean<Leave> findByQjrAndBmdmAndWczt(String yhdm, String bmdm,String wczt,int pc) throws Exception{
		
		return leaveDao.findByQjrAndBmdmAndWczt(yhdm,bmdm,wczt,pc);
	}

	public void update(Leave leave) {
		leaveDao.update(leave);
		
	}

}
