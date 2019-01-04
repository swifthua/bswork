package com.zh.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zh.dao.ExamineDao;
import com.zh.po.Examine;

@Transactional
@Service
public class ExamineService {
	@Autowired
	private ExamineDao examineDao;
	
	public void add(Examine examine){
		examineDao.add(examine);
	}
	
	public Examine findById(int id){
		return examineDao.findById(id);
	}

	public Examine findByShdmAndType(String shdm,String type,int pc) throws Exception{
		return  examineDao.findByShdmAndType(shdm,type,pc);
	}

	public void update(Examine examine) {
		examineDao.update(examine);
	}
}
