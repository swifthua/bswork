package com.zh.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;

import com.zh.po.User;

@Component
public class LoginFilter implements Filter {

	public void init(FilterConfig filterConfig) throws ServletException {

	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest servletRequest = (HttpServletRequest) request;
		HttpServletResponse servletResponse = (HttpServletResponse) response;
		HttpSession session = servletRequest.getSession();

		String path = servletRequest.getRequestURI();

		User user = (User) session.getAttribute("userExist");

		if (path.indexOf("/login") > -1|| path.indexOf("/images")>-1 || path.equals("/work/")) {
			chain.doFilter(servletRequest, servletResponse);
			return;
		}
		if (user == null) {
			servletResponse.sendRedirect(servletRequest.getContextPath());
			chain.doFilter(request, response);
		} else {
			chain.doFilter(request, response);
		}
	}

	public void destroy() {
	}

}
