package com.zh.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zh.dao.ArrangeDao;
import com.zh.page.PageBean;
import com.zh.po.Arrange;

@Transactional
@Service
public class ArrangeService {
	
	@Autowired
	private ArrangeDao arrangeDao;
	
	public PageBean<Arrange> findByFzrAndBmdm(String yhdm,String bmdm, int pc) throws Exception {
		return 	arrangeDao.findByFzrAndBmdm(yhdm,bmdm, pc);
	}

	public void delete(Arrange arrange) {
		arrangeDao.delete(arrange);
	}
	
	public Arrange findById(int id){
		return arrangeDao.findById(id);
	}

	public void add(Arrange arrange) {
		arrangeDao.add(arrange);
		
	}
}
