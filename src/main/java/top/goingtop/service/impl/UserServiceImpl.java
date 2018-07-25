package top.goingtop.service.impl;


import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import top.goingtop.dao.UserDao;
import top.goingtop.pojo.User;
import top.goingtop.service.UserService;
@Service("userService")
public class UserServiceImpl implements UserService{

	@Resource
	private UserDao userDao;


	@Override
	public User findById(String id) {
		return userDao.findById(id);
	}
	
	@Override
	public int update(User user) {
		return userDao.update(user);
	}

	@Override
	public List<User> find(Map<String, Object> map) {
		return userDao.find(map);
	}

	@Override
	public Long getTotal(Map<String, Object> map) {
		return userDao.getTotal(map);
	}

	@Override
	public int delete(String id) {
		return userDao.delete(id);
	}

	@Override
	public int add(User user) {
		return userDao.add(user);
	}
	
}
