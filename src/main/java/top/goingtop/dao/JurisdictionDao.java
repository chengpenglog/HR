package top.goingtop.dao;

import java.util.List;
import java.util.Map;
import top.goingtop.pojo.Jurisdiction;


public interface JurisdictionDao {

	/**
	 * 根据条件查询角色集合
	 * @param id
	 * @return
	 */
	public List<Jurisdiction> find(Map<String, Object> map);
	/**
	 * 通过id查询角色实体
	 * @param id
	 * @return
	 */
	public Jurisdiction findById(String id);
	/**
	 * 根据条件获取总记录数
	 * @param map
	 * @return
	 */
	public Long getTotal(Map<String, Object> map);
	/**
	 * 删除角色
	 * @param id
	 * @return
	 */
	public int delete(String id);
	/**
	 * 修改角色
	 * @param jurisdiction
	 * @return
	 */
	public int update(Jurisdiction jurisdiction);
	/**
	 * 添加角色
	 * @param jurisdiction
	 * @return
	 */
	public int add(Jurisdiction jurisdiction);
	/**
	 * 通过用户Id查询角色集合
	 * @param userId
	 * @return
	 */
	public List<Jurisdiction> findByUserId(String userId);
}
