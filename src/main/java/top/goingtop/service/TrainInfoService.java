package top.goingtop.service;

import java.util.List;
import java.util.Map;

import top.goingtop.pojo.TrainInfo;

public interface TrainInfoService {
	/**
	 * 根据id查询查询培训信息实体
	 * @param id
	 * @return
	 */
	public TrainInfo findById(Integer id);
	/**
	 * 根据条件查询培训信息集合
	 * @param map
	 * @return
	 */
	public List<TrainInfo> list(Map<String , Object> map);
	/**
	 * 根据条件获取总记录数
	 * @param map
	 * @return
	 */
	public Long getTotal(Map<String, Object> map);
	/**
	 * 删除培训信息
	 * @param id
	 * @return
	 */
	public int delete(Integer id);
	/**
	 * 修改培训信息
	 * @param user
	 * @return
	 */
	public int update(TrainInfo trainInfo);
	/**
	 * 添加培训信息
	 * @param user
	 * @return
	 */
	public int add(TrainInfo trainInfo);
}
