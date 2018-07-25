package top.goingtop.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import top.goingtop.dao.EmployerDao;
import top.goingtop.pojo.Employer;
import top.goingtop.service.EmployerService;
@Service("employerService")
public class EmployerServiceImpl implements EmployerService{

	@Resource
	private EmployerDao employerDao;
	@Override
	public List<Employer> list(Map<String, Object> map) {
		return employerDao.list(map);
	}

	@Override
	public Long getTotal(Map<String, Object> map) {
		return employerDao.getTotal(map);
	}

	@Override
	public int delete(String id) {
		return employerDao.delete(id);
	}

	@Override
	public int update(Employer employer) {
		return employerDao.update(employer);
	}

	@Override
	public int add(Employer employer) {
		return employerDao.add(employer);
	}

	@Override
	public Employer findById(String id) {
		return employerDao.findById(id);
	}

	@Override
	public Employer findIdByName(String userName) {
		return employerDao.findIdByName(userName);
	}

}
