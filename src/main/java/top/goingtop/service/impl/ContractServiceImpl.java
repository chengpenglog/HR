package top.goingtop.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import top.goingtop.dao.ContractDao;
import top.goingtop.pojo.Contract;
import top.goingtop.service.ContractService;
@Service("contractService")
public class ContractServiceImpl implements ContractService{

	@Resource
	private ContractDao contractDao;
	@Override
	public List<Contract> find(Map<String, Object> map) {
		return contractDao.find(map);
	}
	@Override
	public Long getTotal(Map<String, Object> map) {
		return contractDao.getTotal(map);
	}
	@Override
	public int delete(Integer id) {
		return contractDao.delete(id);
	}
	@Override
	public int update(Contract contract) {
		return contractDao.update(contract);
	}
	@Override
	public int add(Contract contract) {
		return contractDao.add(contract);
	}
	@Override
	public Contract findById(Integer id) {
		return contractDao.findById(id);
	}

}
