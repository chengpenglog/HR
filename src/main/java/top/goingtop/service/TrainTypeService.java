package top.goingtop.service;

import java.util.List;
import java.util.Map;

import top.goingtop.pojo.TrainType;

/**
 * 培训类别Service接口
 * @author cheng
 *
 */
public interface TrainTypeService {

	/**
	 * 根据id查询查询培训类别实体
	 * @param id
	 * @return
	 */
	public TrainType findById(Integer id);
	/**
	 * 根据条件查询培训类别集合
	 * @param map
	 * @return
	 */
	public List<TrainType> list(Map<String , Object> map);
	/**
	 * 根据条件获取总记录数
	 * @param map
	 * @return
	 */
	public Long getTotal(Map<String, Object> map);
	/**
	 * 删除培训类别
	 * @param id
	 * @return
	 */
	public int delete(Integer id);
	/**
	 * 修改培训类别
	 * @param user
	 * @return
	 */
	public int update(TrainType trainType);
	/**
	 * 添加培训类别
	 * @param user
	 * @return
	 */
	public int add(TrainType trainType);
}
