package kr.co.cc.personal.dao;

import java.util.ArrayList;
import java.util.HashMap;

import kr.co.cc.personal.dto.PersonalDTO;

public interface PersonalDAO {

	ArrayList<PersonalDTO> personalList();

//	int pwrite(HashMap<String, String> params);

	int del(String id);

	int pwrite(PersonalDTO dto);




}
