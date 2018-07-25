package top.goingtop.service;

import java.util.List;
import java.util.Map;

import top.goingtop.pojo.Check;
import top.goingtop.pojo.Contract;

public interface CheckService {
	/**
	 * 根据id查询合同信息
	 * @param id
	 * @return
	 */
	public Contract findById(Integer id);
	/**
	 * 根据条件查询合同集合
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
	 * 删除用户
	 * @param id
	 * @return
	 */
	public int delete(Integer id);
	/**
	 * 修改用户
	 * @param user
	 * @return
	 */
	public int update(Check check);
	/**
	 * 添加用户
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
