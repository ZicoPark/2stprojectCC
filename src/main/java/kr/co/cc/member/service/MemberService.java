package kr.co.cc.member.service;

import java.util.HashMap;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

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
	
    public HashMap<String, Object> idChk(String id) {
         
         HashMap<String, Object> map = new HashMap<String, Object>();
         logger.info("service id");
         int idChk = memberdao.idChk(id);
         map.put("idChk", idChk);
         return map;
     }
    
    public HashMap<String, Object> sendMail(HashMap<String, String> params) {
		HashMap<String, Object> resMap = new HashMap<String, Object>();

		MemberDTO userInfo = memberdao.getUserInfo(params);

		if (userInfo != null) {
			Properties props = new Properties();

			props.put("mail.smtp.host", "smtp.gmail.com");
			props.put("mail.smtp.port", "587");
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

			Session session = Session.getInstance(props, new Authenticator() {
				@Override
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication("archeagemd1@gmail.com", "xgltqqhqiitmzzyd"); // 보내는 사람 메일, 앱
																									
				}
			});

			String receiver = userInfo.getEmail(); // 메일 받을 주소
			String title = "[Creator Company] 아이디 찾기"; // 메일 제목
			String content = "<b> 아이디 : " + userInfo.getId() + "</b>"; // 메일 내용
			Message message = new MimeMessage(session);
			try {
				message.setFrom(new InternetAddress("archeagemd1@gmail.com", "관리자", "utf-8")); // 보내는 사람 메일, 보내는 사람 이름
				message.addRecipient(Message.RecipientType.TO, new InternetAddress(receiver));
				message.setSubject(title);
				message.setContent(content, "text/html; charset=utf-8");

				Transport.send(message);
				resMap.put("code", "COMPLETE");
			} catch (Exception e) {
				e.printStackTrace();
				resMap.put("code", "ERROR");
			}
		} else {
			resMap.put("code", "NO_DATA");
		}

		return resMap;
	}
	
    public HashMap<String, Object> sendPWMail(HashMap<String, String> params) {
		HashMap<String, Object> resMap = new HashMap<String, Object>();

		MemberDTO userInfoPW = memberdao.getUserInfoPW(params);
		logger.info(userInfoPW.getName());
		if (userInfoPW != null) {
			Properties props = new Properties();

			props.put("mail.smtp.host", "smtp.gmail.com");
			props.put("mail.smtp.port", "587");
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

			Session session = Session.getInstance(props, new Authenticator() {
				@Override
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication("archeagemd1@gmail.com", "xgltqqhqiitmzzyd"); // 보내는 사람 메일, 앱
																								
				}
			});

			String receiver = userInfoPW.getEmail(); // 메일 받을 주소
			String title = "[Creator Company] 비밀번호 찾기"; // 메일 제목
			String content = "<b> 비밀번호 : " + userInfoPW.getPassword() + "</b>"; // 메일 내용
			Message message = new MimeMessage(session);
			try {
				message.setFrom(new InternetAddress("archeagemd1@gmail.com", "관리자", "utf-8")); // 보내는 사람 메일, 보내는 사람 이름
				message.addRecipient(Message.RecipientType.TO, new InternetAddress(receiver));
				message.setSubject(title);
				message.setContent(content, "text/html; charset=utf-8");

				Transport.send(message);
				resMap.put("code", "TRANSFER_COMPLETE");
			} catch (Exception e) {
				e.printStackTrace();
				resMap.put("code", "ERROR");
			}
		} else {
			resMap.put("code", "NO_MATCHING_DATA");
		}

		return resMap;
	}

	public MemberDTO userInfo(Object attribute) {
		return memberdao.userInfo(attribute);
	}
}
