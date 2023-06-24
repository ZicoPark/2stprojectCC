package kr.co.cc.member.service;

import org.apache.catalina.User;

public interface UserRepository {

	static User findUserByUserId(String userEmail) {
		return null;
	}

	void updateUserPassword(int id, String pw);

}
