package kr.co.cc.stat.service;

import java.util.ArrayList;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Service
public class StatService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	String driver_id = "webdriver.chrome.driver";
	String driver_path = "C:/Users/mw310/chromedriver.exe";
	WebDriver driver = null;
	ChromeOptions options = null;
	   
	public StatService() { // 처음 실행되었을 때(기본 생성자)
		System.setProperty(driver_id, driver_path); // 시스템에 selenium 등록
		options = new ChromeOptions();
	}
	
   public String connect(String url) {
	      options.addArguments("--remote-allow-origins=*");
	      driver = new ChromeDriver(options); // chrome driver = 가상 브라우저를 뜻함.
	      driver.get(url);
	      String result = driver.getPageSource(); // 페이지의 전체 소스를 떼어 온다.
	      driver.close(); // 이걸 안해주면 가상 드라이버가 계속 떠 있게 된다.
	      
	      return result;
	   }

	
	


	public void findElem(String url) {
		  options.addArguments("--remote-allow-origins=*");
		  driver = new ChromeDriver(options); // chrome driver = 가상 브라우저를 뜻함.
		  driver.get(url);
		  
		  // 반응형 웹의 경우 변화에 따라 태그가 변동되는 경우가 있다.
		  // 창 크기를 최대화하여 창크기에 따른 반응형 요소 변화를 막는다.

		  
		  try { // 가상 브라우저가 늦게 뜨는 경우 크롤링을 못하는 문제가 있음. 지연시간 1초 부여하면 잘 됨.
		     Thread.sleep(1000);
		  } catch (InterruptedException e) {
		     e.printStackTrace();
		  }
		  

		  
		  WebElement gak = driver.findElement(By.cssSelector("#main-content div.result-area ul.num-wrap"));
		  
		  String gudoksu = gak.findElement(By.cssSelector("span#follower-num")).getText();
		  String monthearn = gak.findElement(By.cssSelector("span#mo-earn")).getText();
		  String adearnrate = gak.findElement(By.cssSelector("span#po-earn")).getText();
		  
		  
		  List<WebElement> gaklist = gak.findElements(By.cssSelector("span.item-key"));

		  ArrayList<String> nameList = new ArrayList<String>();
		  for (WebElement webElement : gaklist) {
			nameList.add(webElement.getText());
		}

		  
		  logger.info("gudoksu : " + gudoksu);
			 logger.info("monthearn : " + monthearn);
			 logger.info("adearnrate : " + adearnrate);
	
	}






}
