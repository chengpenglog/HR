package top.goingtop.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import top.goingtop.dao.RecordDao;
import top.goingtop.pojo.Record;
import top.goingtop.service.RecordService;
@Service("recordService")
public class RecordServiceImpl implements RecordService{

	@Resource
	private RecordDao recordDao;
	@Override
	public List<Record> list(Map<String, Object> map) {
		return recordDao.list(map);
	}

	@Override
	public Long getTotal(Map<String, Object> map) {
		return recordDao.getTotal(map);
	}

	@Override
	public int delete(Integer id) {
		return recordDao.delete(id);
	}

	@Override
	public int update(Record record) {
		return recordDao.update(record);
	}

	@Override
	public int add(Record record) {
		return recordDao.add(record);
	}

	@Override
	public Record findByEmployerId(String employerId) {
		return recordDao.findByEmployerId(employerId);
	}

}
