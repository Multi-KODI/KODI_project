package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import dao.HomeDAO;
import dto.VehicleDTO;

@Service("homeservice")
public class HomeService {
	@Autowired
	@Qualifier("homedao")
	HomeDAO dao;

	/**
	 * 교통수단 비용 리스트 조회
	 * @return 교통수단 비용 리스트
	 */
	public List<VehicleDTO> getVehicleList() {
		return dao.selectVehicleList();
	}
	
}
