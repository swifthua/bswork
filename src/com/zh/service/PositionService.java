package com.zh.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zh.dao.PositionDao;
import com.zh.po.Position;

@Transactional
@Service
public class PositionService {

	@Autowired
	private PositionDao positionDao;
	
	public List<Position> findAllPosition(){
		return positionDao.findAllPosition();
	}
	
	public List<Position> getPositionByDepart(String code){
		return positionDao.getPositionByDepart(code);
	}
	
	public Position findByZwdm(String zwdm){
		return positionDao.findByZwdm(zwdm);
	}
}
