package kr.co.cc.main.utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class LoginCheck implements HandlerInterceptor{
	
	Logger logger = LoggerFactory.getLogger(this.getClass());

	// preHandler : Controller 진입 전에 이 곳을 지나간다.
	// true : Controller에 접근 허용한다.
	// false : Controller에 접근 허용하지 않는다.
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		logger.info("preHandler : "+request.getRequestURI());
		
		boolean pass = true;
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("id")==null) {
			response.sendRedirect("/");
			pass = false;
		}
		
		return pass;
	}
}
