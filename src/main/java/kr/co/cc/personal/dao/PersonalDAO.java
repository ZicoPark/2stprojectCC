package kr.co.cc.personal.dao;

import java.util.ArrayList;
import java.util.HashMap;

import kr.co.cc.personal.dto.PersonalDTO;

public interface PersonalDAO {

	ArrayList<PersonalDTO> personalList(String id);

	int pwrite(PersonalDTO dto);
	
	PersonalDTO personalUpdate(String id);

	void update(HashMap<String, String> params);

	int del(String id);





}
