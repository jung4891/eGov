/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.example.sendmail.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.example.sendmail.service.MailService;
import egovframework.example.sendmail.service.MailVO;
import egovframework.example.sendmail.service.impl2.MailMapper2;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

/**
 * @Class Name : MailServiceImpl.java
 * @Description : Mail Business Implement Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2009.03.16           최초생성
 *
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2009. 03.16
 * @version 1.0
 * @see
 *
 *  Copyright (C) by MOPAS All right reserved.
 */

@Service("mailService")
public class MailServiceImpl extends EgovAbstractServiceImpl implements MailService {

	private static final Logger LOGGER = LoggerFactory.getLogger(MailServiceImpl.class);

	/** MailDAO */ 
	// TODO ibatis 사용
//	@Resource(name = "mailDAO")
//	private MailDAO mailDAO;
	// TODO mybatis 사용
	@Resource(name="mailMapper")
	private MailMapper mailDAO;
	
	@Resource(name="mailMapper2")
	private MailMapper2 mailDAO2;

	/** ID Generation */
	@Resource(name = "egovIdGnrService")
	private EgovIdGnrService egovIdGnrService;

	/**
	 * 글을 등록한다.
	 * @param vo - 등록할 정보가 담긴 MailVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	@Override
	public String insertMail(MailVO vo) throws Exception {
		LOGGER.debug(vo.toString());

		/** ID Generation Service */
//		String id = egovIdGnrService.getNextStringId();
//		vo.setId(id);
//		LOGGER.debug(vo.toString());

		mailDAO2.insertMail(vo);
		return vo.getIdx();
	}

	/**
	 * 글을 수정한다.
	 * @param vo - 수정할 정보가 담긴 MailVO
	 * @return void형
	 * @exception Exception
	 */
	@Override
	public void updateMail(MailVO vo) throws Exception {
		mailDAO.updateMail(vo);
	}

	/**
	 * 글을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 MailVO
	 * @return void형
	 * @exception Exception
	 */
	@Override
	public void deleteMail(MailVO vo) throws Exception {
		mailDAO.deleteMail(vo);
	}

	/**
	 * 글을 조회한다.
	 * @param vo - 조회할 정보가 담긴 MailVO
	 * @return 조회한 글
	 * @exception Exception
	 */
	@Override
	public MailVO selectMail(MailVO vo) throws Exception {
		MailVO resultVO = mailDAO.selectMail(vo);
		if (resultVO == null)
			throw processException("info.nodata.msg");
		return resultVO;
	}

	/**
	 * 글 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	
	// DAO를 부른다.
	@Override
	public List<?> selectMailList(MailVO vo) throws Exception {
		return mailDAO.selectMailList(vo);
	}
	
	@Override
	public List<?> selectInboxList(MailVO vo) throws Exception {
		return mailDAO.selectInboxList(vo);
	}
	
	@Override
	public List<?> selectOutboxList(MailVO vo) throws Exception {
		return mailDAO2.selectOutboxList(vo);
	}

	/**
	 * 글 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 총 갯수
	 * @exception
	 */
	@Override
	public int selectMailListTotCnt(MailVO vo) {
		return mailDAO.selectMailListTotCnt(vo);
	}

	@Override
	public String selectLoginCheck(MailVO vo) {
		return mailDAO.selectLoginCheck(vo);
	}
	
	

}
