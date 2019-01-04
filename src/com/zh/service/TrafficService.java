package com.zh.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zh.dao.TrafficDao;
import com.zh.po.Traffic;

@Transactional
@Service
public class TrafficService {
	
	@Autowired
	private TrafficDao trafficDao;
	
	public List<Traffic> findAllTraffic(){
		return trafficDao.findAll();
	}
	
	public Traffic findByGjid(String gjid){
		return trafficDao.findByGjid(gjid);
	}
	
}
