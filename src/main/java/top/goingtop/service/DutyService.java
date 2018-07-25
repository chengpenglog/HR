package top.goingtop.service;

import java.util.List;
import java.util.Map;

import top.goingtop.pojo.Duty;

/**
 * 职务Service接口
 * @author cheng
 *
 */
public interface DutyService {
	/**
	 * 根据id查询职务信息
	 * @param id
	 * @return
	 */
	public Duty findById(Integer id);
	/**
	 * 根据姓名查询职务信息
	 * @param name
	 * @return
	 */
	public Duty findIdByName(String dutyName);
	/**
	 * 根据条件查询职务集合
	 * @return
	 */
	public List<Duty> list(Map<String , Object> map);
	/**
	 * 根据条件获取总记录数
	 * @param map
	 * @return
	 */
	public Long getTotal(Map<String, Object> map);
	/**
	 * 删除职务
	 * @param id
	 * @return
	 */
	public int delete(Integer id);
	/**
	 * 修改职务
	 * @param user
	 * @return
	 */
	public int update(Duty duty);
	/**
	 * 添加职务
	 * @param user
	 * @return
	 */		
	public int add(Duty duty);
	/**
	 * 查询所有处于缺员状态的职务
	 * @return
	 */
	public List<Duty> findIsLackDuty();
}
