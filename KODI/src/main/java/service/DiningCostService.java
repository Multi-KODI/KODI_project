package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import dao.DiningCostDAO;
import dto.DiningCostDTO;

@Service("diningcostservice")
public class DiningCostService {
	@Autowired
	@Qualifier("diningcostdao")
	DiningCostDAO dao;
	
	public List<DiningCostDTO> selectCost(){
		System.out.println("service");
		return dao.selectCost();
	}
}
