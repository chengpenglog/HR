package top.goingtop.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import top.goingtop.dao.StafftransferDao;
import top.goingtop.pojo.Stafftransfer;
import top.goingtop.service.StafftransferService;
@Service("stafftransferService")
public class StafftransferServiceImpl implements StafftransferService{

	@Resource
	private StafftransferDao stafftransferDao;
	@Override
	public Stafftransfer findById(Integer id) {
		return stafftransferDao.findById(id);
	}

	@Override
	public List<Stafftransfer> find(Map<String, Object> map) {
		return stafftransferDao.find(map);
	}

	@Override
	public Long getTotal(Map<String, Object> map) {
		return stafftransferDao.getTotal(map);
	}

	@Override
	public int delete(Integer id) {
		return stafftransferDao.delete(id);
	}

	@Override
	public int update(Stafftransfer stafftransfer) {
		return stafftransferDao.update(stafftransfer);
	}

	@Override
	public int add(Stafftransfer stafftransfer) {
		return stafftransferDao.add(stafftransfer);
	}

}
