package kr.co.cc.error.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ErrorController {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value = "/error/404")
	public ModelAndView notFound() {
		
		ModelAndView mav = new ModelAndView("error/404");
		
		return mav;
	}
	
	@RequestMapping(value = "/error/500")
	public ModelAndView serverError() {
		
		ModelAndView mav = new ModelAndView("error/500");
		
		return mav;
	}
	
	@RequestMapping(value = "/error/IOException")
	public ModelAndView ioException() {
		
		ModelAndView mav = new ModelAndView("error/500");
		
		return mav;
	}
}
