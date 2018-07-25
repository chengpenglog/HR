package top.goingtop.service;

import java.util.List;
import java.util.Map;

import top.goingtop.pojo.Employer;
/**
 * 员工Service接口
 * @author cheng
 *
 */
public interface EmployerService {
	/**
	 * 根据id查询员工信息
	 * @param id
	 * @return
	 */
	public Employer findById(String id);
	/**
	 * 根据姓名查询员工信息
	 * @param name
	 * @return
	 */
	public Employer findIdByName(String userName);
	/**
	 * 根据条件查询员工集合
	 * @return
	 */
	public List<Employer> list(Map<String , Object> map);
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
	public int delete(String id);
	/**
	 * 修改用户
	 * @param user
	 * @return
	 */
	public int update(Employer employer);
	/**
	 * 添加用户
	 * @param user
	 * @return
	 */
	public int add(Employer employer);
}
