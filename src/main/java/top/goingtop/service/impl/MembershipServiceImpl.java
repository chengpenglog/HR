package top.goingtop.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import top.goingtop.dao.MembershipDao;
import top.goingtop.pojo.Membership;
import top.goingtop.service.MembershipService;
@Service("membershipService")
public class MembershipServiceImpl implements MembershipService{

	@Resource
	private MembershipDao membershipDao;
	@Override
	public Membership login(Map<String, Object> map) {
		return membershipDao.login(map);
	}
	@Override
	public int deleteAllGroupsByUserId(String userId) {
		return membershipDao.deleteAllGroupsByUserId(userId);
	}
	@Override
	public int add(Membership memberShip) {
		return membershipDao.add(memberShip);
	}
	@Override
	public List<Membership> findUserByGroupId(String groupId) {
		return membershipDao.findUserByGroupId(groupId);
	}
	@Override
	public List<Membership> findGroupByUserId(String userId) {
		return membershipDao.findGroupByUserId(userId);
	}

}
