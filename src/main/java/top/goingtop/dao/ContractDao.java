package top.goingtop.dao;

import java.util.List;
import java.util.Map;

import top.goingtop.pojo.Contract;

/**
 * 合同Dao接口
 * @author cheng
 *
 */
public interface ContractDao {

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
	 * 删除合同
	 * @param id
	 * @return
	 */
	public int delete(Integer id);
	/**
	 * 修改合同
	 * @param user
	 * @return
	 */
	public int update(Contract contract);
	/**
	 * 添加合同
	 * @param user
	 * @return
	 */
	public int add(Contract contract);
}
