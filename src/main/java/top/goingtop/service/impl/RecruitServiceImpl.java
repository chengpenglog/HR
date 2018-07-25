package top.goingtop.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import top.goingtop.dao.RecruitDao;
import top.goingtop.pojo.Recruit;
import top.goingtop.service.RecruitService;
@Service("recruitService")
public class RecruitServiceImpl implements RecruitService{

	@Resource
	private RecruitDao recruitDao;
	@Override
	public Recruit findById(Integer id) {
		return recruitDao.findById(id);
	}

	@Override
	public Long getTotal(Map<String, Object> map) {
		return recruitDao.getTotal(map);
	}

	@Override
	public int delete(Integer id) {
		return recruitDao.delete(id);
	}

	@Override
	public int update(Recruit recruit) {
		return recruitDao.update(recruit);
	}

	@Override
	public int add(Recruit recruit) {
		return recruitDao.add(recruit);
	}

	@Override
	public List<Recruit> findInterview(Map<String, Object> map) {
		return recruitDao.findInterview(map);
	}

	@Override
	public List<Recruit> findRecruit(Map<String, Object> map) {
		return recruitDao.findRecruit(map);
	}

}
