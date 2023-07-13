package kr.co.cc.notice.dao;

import java.util.ArrayList;

import kr.co.cc.notice.dto.NoticeDTO;

public interface NoticeDAO {

	ArrayList<NoticeDTO> nlist();

	ArrayList<NoticeDTO> nonReadAlarm(String loginId);

	ArrayList<NoticeDTO> readAlarm(String loginId);

}
