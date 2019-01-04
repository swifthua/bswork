package com.zh.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zh.dao.DepartDao;
import com.zh.po.Depart;

@Transactional
@Service
public class DepartService {
	
	@Autowired
	private DepartDao departDao;
	
	public List<Depart> findAllDepart(){
		return departDao.findAllDepart();
	}
	
	public Depart findByBmdm(String bmdm){
		return departDao.findByBmdm(bmdm);
	}

}
