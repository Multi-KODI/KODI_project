package dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import dto.DiningCostDTO;

@Repository("diningcostdao")
@Mapper
public interface DiningCostDAO {
	public List<DiningCostDTO> selectCost();
}
