package com.zh.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zh.po.Position;
import com.zh.service.PositionService;
import com.zh.utils.WorkUtils;

@Controller
public class PositionController {

	@Autowired
	private PositionService positionService;
	
	@RequestMapping("getPositionByDepart")
	@ResponseBody
	public String getPositionByDepart(HttpServletRequest req, HttpServletResponse resp){
		String code = WorkUtils.getPar8(req.getParameter("code"));
		if(!"".equals(code)){
			code=code.substring(5,code.length());
		}
		List<Position> list_position=positionService.getPositionByDepart(code);
		String result=toJSON(list_position);
		return result;
	}
	
	private String toJSON(List<Position> list) {
		StringBuilder json = new StringBuilder();
		json.append("[");
		for (Position p : list) {
			json.append(p.toJsonString());
			json.append(",");
		}
		json.setCharAt(json.length() - 1, ']');
		return json.toString();
	}
}
