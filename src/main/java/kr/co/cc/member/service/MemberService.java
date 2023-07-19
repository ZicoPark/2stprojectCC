package kr.co.cc.member.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.UUID;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.co.cc.freeBoard.dto.FreeBoardDTO;
import kr.co.cc.main.dto.MainDTO;
import kr.co.cc.member.dao.MemberDAO;
import kr.co.cc.member.dto.MemberDTO;

@Service
@MapperScan(value={"kr.co.cc.member.dao"})
public class MemberService {
	
	@Autowired MemberDAO memberdao;
	
	@Autowired PasswordEncoder encoder;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Value("${spring.servlet.multipart.location}") private String attachmentRoot;
	
	@Value("${spring.servlet.multipart.location}") private String root;	
	
	
	
	public ModelAndView join(HashMap<String, String> params, MultipartFile file, MemberDTO dto) {
		logger.info("file: " + file);
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
			String userId = dto.getId();	
			logger.info("userId: " + userId);
	        if (file != null && !file.isEmpty()) {
	            // 입력받은 파일 이름
	            String oriFileName = file.getOriginalFilename();
	            // 확장자를 추출하기 위한 과정
	            String ext = oriFileName.substring(oriFileName.lastIndexOf("."));
	            // 새로운 파일 이름은?
	            UUID uuid = UUID.randomUUID();
	            String newFileName = uuid.toString() + ext;
	            logger.info("파일 업로드 : "+oriFileName+"=>"+newFileName+"으로 변경될 예정");
	            String classification = "프로필사진";
	            try {
	                byte[] bytes = file.getBytes();

	                Path path = Paths.get(attachmentRoot + "/" + newFileName);
	                Files.write(path, bytes);
	                memberdao.userfileWrite(oriFileName, newFileName, classification, userId);
	            } catch (IOException e) {
	                e.printStackTrace();
	            }
	        }	        
	    }
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName(page);
		mav.addObject("msg", msg);  
		logger.info("params: " + params);
		return mav;
	}

	
	public boolean login(String user_id, String password,String id) {
		
		Map<String, Object> enc_pw = memberdao.login(user_id);
	
		if (enc_pw != null && !enc_pw.isEmpty()) {
	        boolean matches = encoder.matches(password, enc_pw.get("password").toString());
	        return matches;
	    }
		
	    return false;
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
					return new PasswordAuthentication("archeagemd1@gmail.com", "xgltqqhqiitmzzyd");  // 보내는 사람 메일, 구글메일 인증키																							
				}
			});

			String receiver = userInfo.getEmail();
			String title = "[Creator Company] 아이디 찾기"; // 메일 제목
			String content = "<b> 아이디 : " + userInfo.getUser_id() + "</b>"; // 메일 내용
			Message message = new MimeMessage(session);
			try {
				message.setFrom(new InternetAddress("archeagemd1@gmail.com", "관리자", "utf-8")); // 보내는 사람 메일, 구글메일 인증키
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

				String receiver = userInfoPW.getEmail();
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
    
    // sendPWMail에서 암호화된 비밀번호 관련 작업 수행
    private String encodePassword(String password) {
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        return passwordEncoder.encode(password);
    }

    
    // UUID를 사용하여 임시 비밀번호 생성
	private String generateTemporaryPassword() {
        return UUID.randomUUID().toString();
    }
    
	// 로그인시 세션에 id값 넣기위한 설정
	public String loginid(String user_id) {
		return memberdao.loginid(user_id);
	}


	public MemberDTO userInfo(String id) {
		return memberdao.userInfo(id);
	}
	
	public String ori_file_name(String id) {
		return memberdao.ori_file_name(id);
	}
	
	public void userInfoUpdate(MultipartFile file, HashMap<String, String> params) {
	    logger.info("params : " + params);

	    int row = memberdao.userInfoUpdate(params);
	    logger.info("update row: " + row);
	    String id = params.get("id");

	    if (row > 0) {
	        logger.info("업로드할 file 있나요? :" + !file.isEmpty());

	        if (!file.isEmpty()) {
	            // 기존 프로필 사진을 데이터베이스에서 삭제합니다.
	        	memberdao.removeProfilePicture(id);
	           
	           attachmentSave(id, file, "프로필사진");
	        }
	        try {
	            Thread.sleep(1);
	        } catch (InterruptedException e) {
	            e.printStackTrace();
	        }
	    }
	}
	
	
	
	private void attachmentSave(String id, MultipartFile file, String cls) {
	    String oriFileName = file.getOriginalFilename();
	    String ext = oriFileName.substring(oriFileName.lastIndexOf("."));
	    UUID uuid = UUID.randomUUID();
	    String newFileName = uuid.toString() + ext;
	    logger.info("파일 업로드 : " + oriFileName + "=>" + newFileName + "으로 변경될 예정");

	    try {
	        byte[] bytes = file.getBytes();
	        Path path = Paths.get(attachmentRoot + "/" + newFileName);
	        Files.write(path, bytes);
	        logger.info(newFileName + " upload 디렉토리에 저장 완료 !");

	        memberdao.userinfofileWrite(oriFileName, newFileName, cls, id);
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	}
	
	public void signprofile(MultipartFile file, String id) {
	    logger.info("id : " + id);
	    
	    if (file != null) { // file이 null이 아닌지 확인
	        //int row = memberdao.signprofileUpdate(id);
	       // logger.info("update row: " + row);

	        //if (row > 0) {
	            logger.info("업로드할 file 있나요? :" + !file.isEmpty());

	            if (!file.isEmpty()) {
	                // 기존 서명 이미지를 데이터베이스에서 삭제합니다.
	                memberdao.removesignProfilePicture(id);
	               
	               attachmentSave(id, file, "서명이미지");
	            }
	            try {
	                Thread.sleep(1);
	            } catch (InterruptedException e) {
	                e.printStackTrace();
	            }
	        //}
	    }
	}
	
	public MemberDTO signinfo(String id) {
		return memberdao.signInfo(id);
	}
	
//
//	private void attachmentRemove(ArrayList<String> deletedFiles) {
//	    for (String id : deletedFiles) {
//	        logger.info(id);
//	        String fileName = memberdao.removeProfilePicture(id);
//	        if (fileName != null) {
//	            File file = new File(attachmentRoot + "/" + fileName);
//	            if (file.exists()) {
//	                file.delete();
//	            }
//	            memberdao.removeFileName(fileName);
//	        }
//	    }
//	}
	


//	public String userInfoUpdate(HashMap<String, String> params, MultipartFile file) {
//		String id = params.get("id");
//  		int row = memberdao.userInfoUpdate(params);
//  		String page = row>0 ? "redirect:/userinfo.go?user_id="+id : "redirect:/userinfo.go";
//  		logger.info("update => "+page);
//  		 if(!file.getOriginalFilename().equals("")) {
//  			String type="fileChange";
//  			 photoSave(file,params,type); 
//  		 }
//  		 
//  		return page;
//	}
//	
//	private int photoSave(MultipartFile file,HashMap<String, String> params, MemberDTO dto) {
//	    
//		int photoWrite = 0;
//		
//		if (file != null && !file.isEmpty()) {	 
//			String userId = dto.getId();	
//			logger.info("userId: " + userId);
//			// 입력받은 파일 이름
//			String oriFileName = file.getOriginalFilename();
//			// 확장자를 추출하기 위한 과정
//			String ext = oriFileName.substring(oriFileName.lastIndexOf("."));
//			// 새로운 파일 이름은?
//			UUID uuid = UUID.randomUUID();
//			String newFileName = uuid.toString() + ext;
//			logger.info("파일 업로드 : "+oriFileName+"=>"+newFileName+"으로 변경될 예정");
//			String classification = "프로필사진";
//			try {
//			    byte[] bytes = file.getBytes();
//			
//			    Path path = Paths.get(attachmentRoot + "/" + newFileName);
//			    Files.write(path, bytes);
//			    memberdao.userfileWrite(oriFileName, newFileName, classification, userId);
//			} catch (IOException e) {
//			    e.printStackTrace();
//			}
//		}
//		return photoWrite;
//	 }

	
	
	public HashMap<String, Object> departmentlist(HashMap<String, Object> params) {
		
		int page = Integer.parseInt(String.valueOf(params.get("page")));
	    String search = String.valueOf(params.get("search"));

	    
	    HashMap<String, Object> map = new HashMap<String, Object>();

	    int offset = 10*(page-1);	    
		
	    logger.info("offset : " + offset);
	    
	    logger.info("params : " + params);
	    
	    int total = 0;	    
		
	    if(search.equals("default") || search.equals("")) {
	      
	    	  total = memberdao.totalCount();

	      	}else {	      
	    	   	   
	    	  total = memberdao.totalCountSearch(search);
	       }
	    
	    int range = total%10  == 0 ? total/10 : total/10+1;

	      page = page>range ? range:page;
	      
	      ArrayList<MemberDTO> list = null;
	      
	      params.put("offset", offset);
			
	      logger.info("user search:"+search);
	      
	      if(search.equals("default") ||search.equals("")) {

	          list = memberdao.departmentlist(offset);
	       
	     
	      }else {

	         list = memberdao.departmentlistSearch(params);
	      }
	      		
		
	      //logger.info("list size : "+ list.size());
	      map.put("list", list);
	      map.put("currPage", page);	      
	      map.put("pages", range);

	
		return map;
		
		
		
		
		
//		logger.info("departmentlist 출력");
//		ModelAndView mav = new ModelAndView("departmentlist");
//		ArrayList<MemberDTO> departmentlist = memberdao.departmentlist(params);
//		logger.info("departmentlist cnt" + departmentlist.size());
//		mav.addObject("departmentlist", departmentlist);
//		return mav;
	}



	public MainDTO mainPage(String loginId) {
		logger.info("멤버 컨트롤러에서 메인페이지 이동 - 서비스 ");
		return memberdao.mainPage(loginId);
	}








//	public String profile(MultipartFile file) {
//		
//		String oriFileName = file.getOriginalFilename();
//		// 확장자를 추출하기 위한 과정
//		String ext = oriFileName.substring(oriFileName.lastIndexOf("."));
//		// 새로운 파일 이름은?
//		UUID uuid = UUID.randomUUID();
//		String newFileName = uuid.toString() + ext;
//		logger.info("파일 업로드 : "+oriFileName+"=>"+newFileName+"으로 변경될 예정");
//		String classification = "프로필사진";
//		try {
//		    byte[] bytes = file.getBytes();
//		
//		    Path path = Paths.get(attachmentRoot + "/" + newFileName);
//		    Files.write(path, bytes);
//		    memberdao.userfileWrite(oriFileName, newFileName, classification, userId);
//		} catch (IOException e) {
//		    e.printStackTrace();
//		}
//		return null;
//	}


}
