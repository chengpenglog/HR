package top.goingtop.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import top.goingtop.dao.DutyDao;
import top.goingtop.pojo.Duty;
import top.goingtop.service.DutyService;
@Service("dutyService")
public class DutyServiceImpl implements DutyService{

	@Autowired
	private DutyDao dutyDao;
	@Override
	public Duty findById(Integer id) {
		return dutyDao.findById(id);
	}

	@Override
	public Duty findIdByName(String dutyName) {
		return dutyDao.findIdByName(dutyName);
	}

	@Override
	public List<Duty> list(Map<String, Object> map) {
		return dutyDao.list(map);
	}

	@Override
	public Long getTotal(Map<String, Object> map) {
		return dutyDao.getTotal(map);
	}

	@Override
	public int delete(Integer id) {
		return dutyDao.delete(id);
	}

	@Override
	public int update(Duty duty) {
		return dutyDao.update(duty);
	}

	@Override
	public int add(Duty duty) {
		return dutyDao.add(duty);
	}

	@Override
	public List<Duty> findIsLackDuty() {
		return dutyDao.findIsLackDuty();
	}

}
