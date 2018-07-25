package top.goingtop.service;

import java.util.List;
import java.util.Map;

import top.goingtop.pojo.Contract;

public interface ContractService {
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
	public List<Contract> find(Map<String , Object> map);
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
	public int update(Contract contract);
	/**
	 * 添加用户
	 * @param user
	 * @return
	 */
	public int add(Contract contract);
}
