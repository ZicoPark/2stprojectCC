package kr.co.cc;

import java.util.Locale;
import java.util.TimeZone;

import javax.annotation.PostConstruct;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class CreatorCompanyApplication {
	
    @PostConstruct
    public void started() {
      // timezone KST 셋팅
      TimeZone.setDefault(TimeZone.getTimeZone("Asia/Seoul"));
      Locale.setDefault(Locale.KOREA);
    }
	public static void main(String[] args) {
		SpringApplication.run(CreatorCompanyApplication.class, args);
	}

}
