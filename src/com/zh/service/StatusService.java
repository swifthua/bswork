package com.zh.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zh.dao.StatusDao;
import com.zh.po.Status;

@Transactional
@Service
public class StatusService {
	
	@Autowired
	private StatusDao statusDao;
	
	public List<Status> findAll(){
		return statusDao.findAll();
	}
	
	public Status findByZtid(String ztid){
		return statusDao.findByZtid(ztid);
	}

}
