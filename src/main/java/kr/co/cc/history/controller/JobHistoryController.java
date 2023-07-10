package kr.co.cc.history.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

public class JobHistoryController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@GetMapping("/job-history/{id}")
    public ModelAndView viewJobHistory(@PathVariable("id") String memberId) {
		
		logger.info("history 여긴오니? ");
        // 여기에서 필요한 로직을 처리하고 jobhistory.jsp로 리다이렉션 또는 모델과 뷰를 반환하는 코드 작성
        // memberId를 사용하여 해당 멤버의 직급 히스토리를 조회하고, 필요한 데이터를 jobhistory.jsp에 전달하는 등의 작업 수행

        // 예시로 모델과 뷰를 반환하는 방식으로 작성하였습니다.
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("memberId", memberId);  // 모델에 데이터 추가
        modelAndView.setViewName("redirect:/job-history.jsp");  // jobhistory.jsp로 리다이렉션
        return modelAndView;
    }

}
