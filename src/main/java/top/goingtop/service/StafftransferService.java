package top.goingtop.service;

import java.util.List;
import java.util.Map;

import top.goingtop.pojo.Stafftransfer;
/**
 * 人事调动Service接口
 * @author cheng
 *
 */
public interface StafftransferService {
	/**
	 * 根据id查询人事调动信息
	 * @param id
	 * @return
	 */
	public Stafftransfer findById(Integer id);
	/**
	 * 根据条件查询人事调动集合
	 * @return
	 */
	public List<Stafftransfer> find(Map<String , Object> map);
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
	public int update(Stafftransfer stafftransfer);
	/**
	 * 添加用户
	 * @param user
	 * @return
	 */
	public int add(Stafftransfer stafftransfer);
}
