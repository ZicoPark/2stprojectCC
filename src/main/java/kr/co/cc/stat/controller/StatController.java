package kr.co.cc.stat.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class StatController {
	
	@RequestMapping(value="/stat.go", method = RequestMethod.GET)
	public String statgo(Model model) {
		return "StatForm";
	}

}
