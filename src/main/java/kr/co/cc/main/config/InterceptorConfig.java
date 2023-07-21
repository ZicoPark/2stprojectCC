package kr.co.cc.main.config;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import kr.co.cc.main.utils.LoginCheck;

@Configuration
public class InterceptorConfig implements WebMvcConfigurer{
	
	@Autowired LoginCheck check;
	
	// 오버라이드 된 이 메서드는 진입할 때 잡는 역할까지만 수행한다.
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		
		// 예외 패턴을 저장할 Arraylist 선언
		ArrayList<String> excludeList = new ArrayList<String>();
		excludeList.add("/");
		
		excludeList.add("/join*"); // join 뒤에 뭐가 오는 요청의 경우에 제외(회원가입)
		excludeList.add("/login*");
		excludeList.add("/*.ajax"); // .ajax로 끝나는 요청은 제외
		excludeList.add("/find*");
		// static
		excludeList.add("/resources/**"); // css 파일 접근 시 제외
		excludeList.add("/img/**");
		excludeList.add("/plugins/**");
		excludeList.add("/dist/**");
		excludeList.add("/richtexteditor/**");
		
		// registry에 인터셉트할 여러 내용이 추가된다.
		registry.addInterceptor(check) //1. 실행할 클래스
		.addPathPatterns("/**") // 2. 인터셉트 적용할 URL pattern 등록
		.excludePathPatterns(excludeList); // 3. 예외 pattern을 등록
	}

}
