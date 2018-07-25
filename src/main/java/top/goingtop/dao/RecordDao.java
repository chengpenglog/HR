package top.goingtop.dao;

import java.util.List;
import java.util.Map;
import top.goingtop.pojo.Record;

/**
 * 档案Dao接口
 * @author cheng
 *
 */
public interface RecordDao {
	/**
	 * 根据条件查询员工集合
	 * @return
	 */
	public List<Record> list(Map<String , Object> map);
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
	public int update(Record record);
	/**
	 * 添加用户
	 * @param user
	 * @return
	 */
	public int add(Record record);
	/**
	 * 根据员工id查询档案实体
	 * @param employerId
	 * @return
	 */
	public Record findByEmployerId(String employerId);
}
