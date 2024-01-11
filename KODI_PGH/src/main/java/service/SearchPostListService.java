package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import dao.SearchPostListDAO;

@Service("searchpostlistservice")
public class SearchPostListService {
	
	@Autowired
	@Qualifier("searchpostlistdao")
	SearchPostListDAO dao;
	
	

}
