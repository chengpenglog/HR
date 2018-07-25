package top.goingtop.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import top.goingtop.dao.TrainTypeDao;
import top.goingtop.pojo.TrainType;
import top.goingtop.service.TrainTypeService;

/**
 * 培训类别Service实现类
 * @author cheng
 *
 */
@Service("trainTypeService")
public class TrainTypeServiceImpl implements TrainTypeService{

	@Resource
	private TrainTypeDao trainTypeDao;
	@Override
	public List<TrainType> list(Map<String, Object> map) {
		return trainTypeDao.list(map);
	}

	@Override
	public Long getTotal(Map<String, Object> map) {
		return trainTypeDao.getTotal(map);
	}

	@Override
	public int delete(Integer id) {
		return trainTypeDao.delete(id);
	}

	@Override
	public int update(TrainType trainType) {
		return trainTypeDao.update(trainType);
	}

	@Override
	public int add(TrainType trainType) {
		return trainTypeDao.add(trainType);
	}

	@Override
	public TrainType findById(Integer id) {
		return trainTypeDao.findById(id);
	}

}
