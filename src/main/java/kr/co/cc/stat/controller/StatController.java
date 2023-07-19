package kr.co.cc.stat.controller;

import java.io.IOException;
import java.util.HashMap;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.co.cc.stat.service.StatService;

@Controller
public class StatController {
	
	@Autowired StatService statservice;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value="/stat.go", method = RequestMethod.GET)
	public String statgo() {
		return "StatForm";
	}
	
//	@GetMapping(value="/stat1.do")
//	public String statearn(Model model) throws IOException{
//		String url="https://vling.net/channel/UCaxbXRPhdHPXjM-e-F00LVA";
//	      HashMap<String, String> params = new HashMap<String, String>();
//      
//	      Document doc = Jsoup.connect(url).data(params).get();
//	      logger.info("doc :"+doc);
//	      model.addAttribute("full",true);
//	      model.addAttribute("elem",doc);
//	      return "Statresult";		
//	}
	
	@RequestMapping(value="/stat1.do", method = RequestMethod.GET)
	public ModelAndView statdo(Model model) throws Exception {
		
		Document doc = Jsoup.connect("https://vling.net/channel/UCaxbXRPhdHPXjM-e-F00LVA/channel-info").get();

		return statservice.statdo(doc);
	}

}
