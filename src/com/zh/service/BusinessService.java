package com.zh.service;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zh.dao.BusinessDao;
import com.zh.page.PageBean;
import com.zh.po.Business;

@Transactional
@Service
public class BusinessService {

	@Autowired
	private BusinessDao businessDao;
	
	public void add(Business business){
		businessDao.add(business);
	}
	
	public PageBean<Business> findAllBusiness(int pc) throws SQLException{
		return 	businessDao.findAllBusiness(pc);
	}
	
	public Business findById(int id){
		return businessDao.findById(id);
	}
	
	public void delete(Business business){
		businessDao.delete(business);
	}

	public PageBean<Business> findByBmdmAndYhdmAndWczt(String bmdm,String yhdm,String wczt, int pc) throws Exception {
		
		return businessDao.findByBmdmAndYhdmAndWczt(bmdm,yhdm,wczt,pc);
	}

	public void update(Business business) {
		businessDao.update(business);
		
	}
}
