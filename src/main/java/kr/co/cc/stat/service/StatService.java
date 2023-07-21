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
	


	public ArrayList<String> findElem(String url) {
		  options.addArguments("--remote-allow-origins=*");
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
		  
		  
		  List<WebElement> gaklist = gak.findElements(By.cssSelector("span.item-key"));

		  ArrayList<String> nameList = new ArrayList<String>();
		  for (WebElement webElement : gaklist) {
			nameList.add(webElement.getText());
		}
	  
		  logger.info("gudoksu : " + gudoksu);
		  logger.info("monthearn : " + monthearn);
		  logger.info("adearnrate : " + adearnrate);
			 
			 ArrayList<String> list = new ArrayList<String>();
			 list.add(gudoksu);
			 list.add(monthearn);
			 list.add(adearnrate);	 
			 
			 driver.close();
			return list;
	
	}
}