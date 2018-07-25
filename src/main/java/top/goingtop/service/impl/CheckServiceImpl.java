package top.goingtop.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import top.goingtop.dao.CheckDao;
import top.goingtop.pojo.Check;
import top.goingtop.pojo.Contract;
import top.goingtop.service.CheckService;
/**
 * 考勤记录Service实现类
 * @author cheng
 *
 */
@Service("checkService")
public class CheckServiceImpl implements CheckService{

	@Resource
	private CheckDao checkDao;
	@Override
	public List<Check> find(Map<String, Object> map) {
		return checkDao.find(map);
	}

	@Override
	public Long getTotal(Map<String, Object> map) {
		return checkDao.getTotal(map);
	}

	@Override
	public int delete(Integer id) {
		return checkDao.delete(id);
	}

	@Override
	public int update(Check check) {
		return checkDao.update(check);
	}

	@Override
	public int add(Check check) {
		return checkDao.add(check);
	}

	@Override
	public Contract findById(Integer id) {
		return checkDao.findById(id);
	}

	@Override
	public Integer getFine(Map<String, Object> map) {
		return checkDao.getFine(map);
	}

	@Override
	public Integer getBonus(Map<String, Object> map) {
		return checkDao.getBonus(map);
	}

}
