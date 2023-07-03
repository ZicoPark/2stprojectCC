package kr.co.cc.member.pwmail;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;

import kr.co.cc.member.service.MemberService;

public class MailUtil {
	
//@Autowired MemberService service;
//	
//	public void sendEmail(UserVo vo) throws Exception{
//		
//		//Mail Server 설정
//		String charSet="utf-8";
//		String hostSMTP="smtp.gmail.com";
//		String hostSMTPid=""; //관리자 이메일 아이디
//		String hostSMTPpw=""; //관리자 이메일 비밀번호
//		
//		//보내는 사람 
//		String fromEmail=""; //보내는 사람 이메일 
//		String fromName=""; //보내는 사람 이름
//		
//		String subject=""; //메일 제목
//		String msg="";
//		
//		msg +="<div align='lift'";
//		msg +="<h3>";
//		msg +=vo.getUi_id() + "님의 임시 비밀번호입니다. <br>로그인 후 비밀번호를 변경해 주세요</h3>";
//		msg +="<p>임시 비밀번호:";
//		msg +=vo.getUi_pwd() + "</p></div>";
//		
//		//email전송
//		String mailRecipient=vo.getUi_email();//받는 사람 이메일 주소
//		try {
//			//객체 선언
//			HtmlEmail mail = new HtmlEmail();
//			mail.setDebug(true);
//			mail.setCharset(charSet);
//			mail.setSSLOnConnect(true);
//			mail.setHostName(hostSMTP);
//			mail.setSmtpPort(587); 
//			mail.setAuthentication(hostSMTPid, hostSMTPpw);
//			mail.setStartTLSEnabled(true);
//			mail.addTo(mailRecipient,charSet);
//			mail.setFrom(fromEmail, fromName, charSet);
//			mail.setSubject(subject);
//			mail.setHtmlMsg(msg);
//			mail.send();
//			
//		}catch(Exception e) {
//			e.printStackTrace();
//		}
//	}
//	public void findPw(HttpServletResponse response, UserVo vo) {
//		response.setContentType("text/html;charset=utf-8");
//		
//	}

}
