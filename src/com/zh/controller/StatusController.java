package com.zh.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zh.po.Status;
import com.zh.service.StatusService;

@Controller
public class StatusController {
	
	@Autowired
	private StatusService statusService;
	
	@RequestMapping("getAllStatus")
	@ResponseBody
	public String getAllStatus(HttpServletRequest req, HttpServletResponse resp){
		List<Status> list_status=statusService.findAll();
		String result=toJSON(list_status);
		return result;
	}
	
	private String toJSON(List<Status> list) {
		StringBuilder json = new StringBuilder();
		json.append("[");
		for (Status s : list) {
			json.append(s.toJsonString());
			json.append(",");
		}
		json.setCharAt(json.length() - 1, ']');
		return json.toString();
	}
}
