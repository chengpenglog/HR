package top.goingtop.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import top.goingtop.pojo.Jurisdiction;
import top.goingtop.pojo.Membership;
import top.goingtop.pojo.User;
import top.goingtop.service.EmployerService;
import top.goingtop.service.JurisdictionService;
import top.goingtop.service.MembershipService;
import top.goingtop.service.UserService;
import top.goingtop.util.MD5Util;
import top.goingtop.util.PageBean;
import top.goingtop.util.ResponseUtil;
import top.goingtop.util.StringUtil;

/**
 * 用户Controller
 * @author cheng
 *
 */
@Controller
@RequestMapping("/user")
public class UserController {

	@Resource
	private UserService userService;
	@Resource
	private JurisdictionService jurisdictionService;
	@Resource
	private MembershipService membershipService;
	@Resource
	private EmployerService employerService;
	/**
	 * 根据条件分页查询用户集合
	 * @param page
	 * @param rows
	 * @param s_user
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public String list(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,User s_user,HttpServletResponse response)throws Exception {
		PageBean pageBean=new PageBean(Integer.parseInt(page), Integer.parseInt(rows));
		Map<String, Object> map=new HashMap<>();
		map.put("id", StringUtil.formatLike(s_user.getId()));//查询用户名并获取
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<User> userList = userService.find(map);
		Long total = userService.getTotal(map);
		JSONObject result=new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(userList);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
		
	}
	/**
	 * 删除用户
	 * @param ids
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/delete")
	public String delete(@RequestParam(value="ids",required=false)String ids,HttpServletResponse response)throws Exception {
		JSONObject result=new JSONObject();
		String[] idsStr = ids.split(",");
		for(int i=0;i<idsStr.length;i++){
			List<Membership> list = membershipService.findGroupByUserId(idsStr[i]);
			for(Membership memberShip:list){
				if (memberShip.getGroup().getId()!=null) {
					result.put("used", true);
					ResponseUtil.write(response, result);
					return null;
				}
			}
		}
		for(int i=0;i<idsStr.length;i++){
			userService.delete(idsStr[i]);
		}
		result.put("success", true);
		ResponseUtil.write(response, result);
		return null;
	}
	/**
	 * 添加或者修改用户
	 * @param user
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/save")
	public String save(User user,HttpServletResponse response,Integer flag)throws Exception {
		String password=MD5Util.md5(user.getPassword(), "152872");
		user.setPassword(password);
		int resultTotal=0;
		if (flag==1) {
			resultTotal=userService.add(user);
		}else {
			resultTotal=userService.update(user);
		}
		JSONObject result=new JSONObject();
		if (resultTotal>0) {
			result.put("success", true);
		}else {
			result.put("success", false);
		}
		ResponseUtil.write(response, result);
		return null;
	}
	/**
	 * 判断是否存在指定用户名
	 * @param userName
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/existUserName")
	public String existUserName(String userName,HttpServletResponse response)throws Exception {
		JSONObject result=new JSONObject();
		if (userService.findById(userName)==null) {
			result.put("exist", false);
		}else {
			result.put("exist", true);
		}
		ResponseUtil.write(response, result);
		return null;
	}
	/**
	 * 修改用户密码
	 * @param id
	 * @param newPassword
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/modifyPassword")
	public String modifyPassword(String id,String newPassword,HttpServletRequest request,HttpServletResponse response)throws Exception{
		JSONObject result=new JSONObject();
		String password=userService.findById(id).getPassword();
		String inputPassword=request.getParameter("oldPassword");
		String checkPassword=MD5Util.md5(inputPassword, "152872");
		if (!password.equals(checkPassword)) {
			result.put("chickPassword", true);
			ResponseUtil.write(response, result);
			return null;
		}
		User user=new User();
		user.setId(id);
		user.setPassword(MD5Util.md5(newPassword, "152872"));
		
		int resultTotal=userService.update(user);
		if(resultTotal>0){
			result.put("success", true);
		}else{
			result.put("success", false);
		}
		ResponseUtil.write(response, result);
		return null;
	}
	/**
	 * 根据条件分页查询用户及用户角色信息集合
	 * @param page
	 * @param rows
	 * @param s_user
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/listWithGroups")
	public String listWithGroups(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,User s_user,HttpServletResponse response)throws Exception {
		PageBean pageBean=new PageBean(Integer.parseInt(page), Integer.parseInt(rows));
		Map<String, Object> map=new HashMap<>();
		map.put("id", StringUtil.formatLike(s_user.getId()));//查询用户名并获取
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<User> userList = userService.find(map);
		for(User user:userList){
			StringBuffer groups=new StringBuffer();
			List<Jurisdiction> groupList = jurisdictionService.findByUserId(user.getId());
			for(Jurisdiction g:groupList){
				groups.append(g.getName()+",");
			}
			if (groups.length()>0) {
				user.setGroups(groups.deleteCharAt(groups.length()-1).toString());;
			}else {
				user.setGroups(groups.toString());
			}
		}
		Long total = userService.getTotal(map);
		JSONObject result=new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(userList);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
		
	}
	/**
	 * 用户注册，默认为工人角色
	 * @param user
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/register")
	public String register(User user,HttpServletResponse response)throws Exception {
		JSONObject result=new JSONObject();
		if(employerService.findById(user.getId())==null) {
			result.put("checkedWorker", true);
			ResponseUtil.write(response, result);
			return null;
		}
		String password=MD5Util.md5(user.getPassword(), "152872");
		user.setPassword(password);
		int resultTotal=0;
		resultTotal=userService.add(user);//保存注册用户信息
		if (resultTotal>0) {
			result.put("success", true);
			Jurisdiction group=new Jurisdiction();group.setId("worker");
			Membership memberShip=new Membership();
			memberShip.setUser(user);
			memberShip.setGroup(group);
			membershipService.add(memberShip);
		}else {
			result.put("success", false);
		}
		ResponseUtil.write(response, result);
		return null;
	}
	/**
	 * 用户注销
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/logout")
	public String logout(HttpSession session)throws Exception{
		session.invalidate();//清空session
		return "redirect:/login.jsp";
	}
}
