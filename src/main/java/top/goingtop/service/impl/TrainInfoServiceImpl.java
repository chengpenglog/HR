package top.goingtop.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import top.goingtop.dao.TrainInfoDao;
import top.goingtop.pojo.TrainInfo;
import top.goingtop.service.TrainInfoService;
@Service("trainInfoService")
public class TrainInfoServiceImpl implements TrainInfoService{

	@Resource
	private TrainInfoDao trainInfoDao;
	@Override
	public TrainInfo findById(Integer id) {
		return trainInfoDao.findById(id);
	}

	@Override
	public List<TrainInfo> list(Map<String, Object> map) {
		return trainInfoDao.list(map);
	}

	@Override
	public Long getTotal(Map<String, Object> map) {
		return trainInfoDao.getTotal(map);
	}

	@Override
	public int delete(Integer id) {
		return trainInfoDao.delete(id);
	}

	@Override
	public int update(TrainInfo trainInfo) {
		return trainInfoDao.update(trainInfo);
	}

	@Override
	public int add(TrainInfo trainInfo) {
		return trainInfoDao.add(trainInfo);
	}

}
