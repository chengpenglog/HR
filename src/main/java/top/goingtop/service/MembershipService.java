package top.goingtop.service;

import java.util.List;
import java.util.Map;

import top.goingtop.pojo.Membership;

public interface MembershipService {
	/**
	 * 用户登录
	 * @param map
	 * @return
	 */
	public Membership login(Map<String, Object> map);
	/**
	 * 删除用户权限
	 * @param userId
	 * @return
	 */
	public int deleteAllGroupsByUserId(String userId);
	/**
	 * 添加指定用户所有角色
	 * @param userId
	 * @return
	 */
	public int add(Membership memberShip);
	/**
	 * 根据角色Id查询用户集合
	 * @param groupId
	 * @return
	 */
	public List<Membership> findUserByGroupId(String groupId);
	/**
	 * 根据用户id查询角色集合
	 * @param userId
	 * @return
	 */
	public List<Membership> findGroupByUserId(String userId);
}
