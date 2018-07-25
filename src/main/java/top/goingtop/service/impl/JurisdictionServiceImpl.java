package top.goingtop.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import top.goingtop.dao.JurisdictionDao;
import top.goingtop.pojo.Jurisdiction;
import top.goingtop.service.JurisdictionService;
@Service("jurisdictionService")
public class JurisdictionServiceImpl implements JurisdictionService{

	@Resource
	private JurisdictionDao jurisdictionDao;

	@Override
	public List<Jurisdiction> find(Map<String, Object> map) {
		return jurisdictionDao.find(map);
	}

	@Override
	public Jurisdiction findById(String id) {
		return jurisdictionDao.findById(id);
	}

	@Override
	public Long getTotal(Map<String, Object> map) {
		return jurisdictionDao.getTotal(map);
	}

	@Override
	public int delete(String id) {
		return jurisdictionDao.delete(id);
	}

	@Override
	public int update(Jurisdiction jurisdiction) {
		return jurisdictionDao.update(jurisdiction);
	}

	@Override
	public int add(Jurisdiction jurisdiction) {
		return jurisdictionDao.add(jurisdiction);
	}

	@Override
	public List<Jurisdiction> findByUserId(String userId) {
		return jurisdictionDao.findByUserId(userId);
	}

}
