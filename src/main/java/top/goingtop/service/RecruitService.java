package top.goingtop.service;

import java.util.List;
import java.util.Map;

import top.goingtop.pojo.Recruit;

public interface RecruitService {
	/**
	 * 根据id查询应聘信息
	 * @param id
	 * @return
	 */
	public Recruit findById(Integer id);
	/**
	 * 根据条件查询应聘者集合
	 * @return
	 */
	public List<Recruit> findInterview(Map<String , Object> map);
	/**
	 * 根据条件查询应聘者集合
	 * @return
	 */
	public List<Recruit> findRecruit(Map<String , Object> map);
	/**
	 * 根据条件获取总记录数
	 * @param map
	 * @return
	 */
	public Long getTotal(Map<String, Object> map);
	/**
	 * 删除应聘信息
	 * @param id
	 * @return
	 */
	public int delete(Integer id);
	/**
	 * 修改应聘信息
	 * @param user
	 * @return
	 */
	public int update(Recruit recruit);
	/**
	 * 添加应聘信息
	 * @param user
	 * @return
	 */
	public int add(Recruit recruit);
}
