package top.goingtop.dao;

import java.util.List;
import java.util.Map;

import top.goingtop.pojo.Check;
import top.goingtop.pojo.Contract;

/**
 * 考勤记录Dao接口
 * @author cheng
 *
 */
public interface CheckDao {
	/**
	 * 根据id查询考勤记录信息
	 * @param id
	 * @return
	 */
	public Contract findById(Integer id);
	/**
	 * 根据条件查询考勤记录集合
	 * @return
	 */
	public List<Check> find(Map<String , Object> map);
	/**
	 * 根据条件获取总记录数
	 * @param map
	 * @return
	 */
	public Long getTotal(Map<String, Object> map);
	/**
	 * 删除考勤记录
	 * @param id
	 * @return
	 */
	public int delete(Integer id);
	/**
	 * 修改考勤记录
	 * @param user
	 * @return
	 */
	public int update(Check check);
	/**
	 * 添加考勤记录
	 * @param user
	 * @return
	 */
	public int add(Check check);
	/**
	 * 根据员工id查询一个月的奖金总和
	 * @param employerId
	 * @return
	 */
	public Integer getFine(Map<String, Object> map);
	/**
	 * 根据员工id查询一个月的罚款总和
	 * @param employerId
	 * @return
	 */
	public Integer getBonus(Map<String, Object> map);
}
