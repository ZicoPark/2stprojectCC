package kr.co.cc.stat.service;

import java.util.HashMap;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class StatService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Value("${spring.servlet.multipart.location}") private String attachmentRoot;
	
	String driver_id = "webdriver.chrome.driver";
	String driver_path = "/usr/local/tomcat/webapps/upload/chromedriver";

	WebDriver driver = null;
	ChromeOptions options = null;

	public StatService() { // 처음 실행되었을 때(기본 생성자)
		System.setProperty(driver_id, driver_path); // 시스템에 selenium 등록
		options = new ChromeOptions();
	}

	public HashMap<String, Object> findStat(String url) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		options.addArguments("--remote-allow-origins=*");
		
		// https://synkc.tistory.com/entry/Chromedriver-DevToolsActivePort-file-doesnt-exist-%EC%97%90%EB%9F%AC-%ED%95%B4%EA%B2%B0%EB%B2%95
		options.addArguments("--headless");
		options.addArguments("--no-sandbox");
		options.addArguments("--single-process");
		options.addArguments("--disable-dev-shm-usage");
		// 도커 내에서 크롬 실행하기 위해서 추가했음.(mobpolice)
		
		driver = new ChromeDriver(options);
		driver.get(url);

		try { // 가상 브라우저가 늦게 뜨는 경우 크롤링을 못하는 문제가 있음. 지연시간 1초 부여하면 잘 됨.
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}

		WebElement gak = driver.findElement(By.cssSelector("#main-content div.result-area ul.num-wrap"));

		String gudoksu = gak.findElement(By.cssSelector("span#follower-num")).getText();
		String monthearn = gak.findElement(By.cssSelector("span#mo-earn")).getText();
		String adearnrate = gak.findElement(By.cssSelector("span#po-earn")).getText();

		map.put("gudoksu", gudoksu);
		map.put("monthearn", monthearn);
		map.put("adearnrate", adearnrate);
		
		WebElement elementName = driver.findElement(By.id("star-name"));
		String youtuberName = elementName.getText();
		
		map.put("youtuberName", youtuberName);
		
		WebElement elementImg = driver.findElement(By.id("avatar-img"));
		String youtuberImg = elementImg.getAttribute("src");

		map.put("youtuberImg", youtuberImg);

		driver.close();
		
		return map;
	}
}