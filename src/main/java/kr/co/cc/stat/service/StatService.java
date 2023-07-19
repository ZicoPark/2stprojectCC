package kr.co.cc.stat.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

@Service
public class StatService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	public ModelAndView statdo(Document doc) {
		ModelAndView mav = new ModelAndView("Statresult");
		Elements elems = doc.select("div.ChannelDetailWrapper_content__fJEvg");
		logger.info("elems size : " + elems.size());
		Element elem = elems.get(0);
		logger.info("elem : " + elem);
		Elements cardList = elem.select("div.PerformanceSummaryStatInfo_statWrapper__GyFbn");
		
		String url="";
	    String title="";
	    String content="";
	      
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String,String>>();
		  
		for(Element card : cardList) {
			HashMap<String, String> map = new HashMap<String, String>();
			title = card.select("p.PerformanceSummaryStatInfo_text__5t2kq").html();
			content = card.select("p.PerformanceSummaryStatInfo_positiveStat__O0QQk").html();
			logger.info(title+" : "+url);

			map.put("title",title);
			map.put("content", content);
			list.add(map);
		}
		mav.addObject("elem",list);
		mav.addObject("full",false);

		
		
		return mav;
	}

}
