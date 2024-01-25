package dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import dto.VehicleDTO;

@Repository("homedao")
@Mapper
public interface HomeDAO {
	
	/**
	 * 교통수단 비용 리스트 조회
	 * @return 교통수단 비용 리스트
	 */
	List<VehicleDTO> selectVehicleList();
}
