package com.zh.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zh.dao.JournalDao;
import com.zh.page.PageBean;
import com.zh.po.Journal;

@Transactional
@Service
public class JournalService {
	
	@Autowired
	private JournalDao journalDao;
	
	public void delete(Journal journal) {
		journalDao.delete(journal);
	}
	
	public Journal findById(int id){
		return journalDao.findById(id);
	}

	public void add(Journal journal) {
		journalDao.add(journal);
		
	}

	public PageBean<Journal> findByDjrAndBmdm(String yhdm, String bmdm,int pc) throws Exception{
		
		return journalDao.findByDjrAndBmdm(yhdm,bmdm,pc);
	}

	public PageBean<Journal> findByYhdmAndRzsj(String rzsj, String yhdm,int pc)throws Exception {
		return journalDao.findByYhdmAndRzsj(rzsj,yhdm,pc);
	}
}
