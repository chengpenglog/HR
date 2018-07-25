package top.goingtop.dao;

import java.util.List;
import java.util.Map;
import top.goingtop.pojo.Payment;

/**
 * 薪酬记录Dao接口
 * @author cheng
 *
 */
public interface PaymentDao {
	/**
	 * 根据id查询考勤记录信息
	 * @param id
	 * @return
	 */
	public Payment findById(Integer id);
	/**
	 * 根据条件查询考勤记录集合
	 * @return
	 */
	public List<Payment> find(Map<String , Object> map);
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
	public int update(Payment payment);
	/**
	 * 添加考勤记录
	 * @param user
	 * @return
	 */
	public int add(Payment payment);
}
