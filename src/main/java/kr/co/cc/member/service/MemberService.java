package kr.co.cc.member.service;

import java.util.HashMap;

import org.apache.catalina.User;
import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import kr.co.cc.member.dao.MemberDAO;
import kr.co.cc.member.dto.MemberDTO;

@Service
@MapperScan(value={"kr.co.cc.member.dao"})
public class MemberService {
	
	@Autowired MemberDAO memberdao;
	
	Logger logger = LoggerFactory.getLogger(getClass());

	public ModelAndView join(MemberDTO dto) {
		
		int success = memberdao.join(dto);
		logger.info("success : " + success);
		
		String msg = "회원등록에 실패하였습니다.";
		String page = "JoinForm";
		
		if (success > 0) {
			msg = "회원등록에 성공하였습니다.";
			page = "Login";
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName(page);
		mav.addObject("msg", msg);
		return mav;
	}

	public String login(HashMap<String, String> params) {
		return memberdao.login(params);
	}
	
	/*public boolean userEmailCheck(String userEmail, String userName) {

        User user = UserRepository.findUserByUserId(userEmail);
        if(user!=null && user.getName().equals(userName)) {
            return true;
        }
        else {
            return false;
        }
    }
*/
}
