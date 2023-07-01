package kr.co.cc.member.service;

import java.util.HashMap;
import java.util.Properties;
import java.util.UUID;

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
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import kr.co.cc.member.dao.MemberDAO;
import kr.co.cc.member.dto.MemberDTO;

@Service
@MapperScan(value={"kr.co.cc.member.dao"})
public class MemberService {
	
	@Autowired MemberDAO memberdao;
	
	@Autowired PasswordEncoder encoder;
	
	Logger logger = LoggerFactory.getLogger(getClass());

	public ModelAndView join(MemberDTO dto) {
		
		
		logger.info(dto.getUser_id()+"/"+dto.getPassword());
		String enc_pass = encoder.encode(dto.getPassword());
		dto.setPassword(enc_pass);
		int success = memberdao.join(dto);
		logger.info("join success : "+success);
		
		
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

	
	public boolean login(String user_id, String password) {
		
		boolean success = false;

		String enc_pw = memberdao.login(user_id);
	
		if(enc_pw != null && !enc_pw.equals("")) {
			success = encoder.matches(password, enc_pw);
		}
		
		return success;
	}
	
    public HashMap<String, Object> idChk(String user_id) {
         
         HashMap<String, Object> map = new HashMap<String, Object>();
         logger.info("service user_id");
         int idChk = memberdao.idChk(user_id);
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
			String content = "<b> 아이디 : " + userInfo.getUser_id() + "</b>"; // 메일 내용
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
			String temporaryPassword = generateTemporaryPassword(); // 임시 비밀번호 생성
			temporaryPassword = temporaryPassword.substring(0, 6);
			String encodedPassword = encodePassword(temporaryPassword); // 비밀번호 암호화
			userInfoPW.setPassword(encodedPassword);
			
			// DB에 임시 비밀번호 업데이트
	        boolean updateResult = memberdao.updateTemporaryPassword(userInfoPW);
	        
	        if(updateResult) {
	        
			Properties props = new Properties();

			props.put("mail.smtp.host", "smtp.gmail.com");
			props.put("mail.smtp.port", "587");
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

			Session session = Session.getInstance(props, new Authenticator() {
				@Override
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication("archeagemd1@gmail.com", "xgltqqhqiitmzzyd"); // 보내는 사람 메일, sendmail구글쪽
																								
				}
			});

			String receiver = userInfoPW.getEmail(); // 메일 받을 주소
			String title = "[Creator Company] 임시 비밀번호 발급"; // 메일 제목
			String content = "<b>임시 비밀번호: " + temporaryPassword + "</b>"; // 메일 내용
			logger.info("암호화 전 tp : " + temporaryPassword);
			logger.info("암호화 후 ep : " + encodedPassword);
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
	        }
	    } else {
			resMap.put("code", "DB_UPDATE_ERROR");
		}

		return resMap;
	}
    
    private String encodePassword(String password) {
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        return passwordEncoder.encode(password);
    }


	private String generateTemporaryPassword() {
        // UUID를 사용하여 임시 비밀번호 생성
        return UUID.randomUUID().toString();
    }
    


	public MemberDTO userInfo(Object attribute) {
		return memberdao.userInfo(attribute);
	}

}
