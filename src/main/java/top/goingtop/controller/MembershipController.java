package top.goingtop.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import top.goingtop.pojo.Jurisdiction;
import top.goingtop.pojo.Membership;
import top.goingtop.pojo.User;
import top.goingtop.service.MembershipService;
import top.goingtop.util.MD5Util;
import top.goingtop.util.ResponseUtil;
import top.goingtop.util.StringUtil;

@Controller
@RequestMapping("/membership")
public class MembershipController {

	@Resource
	private MembershipService membershipService;
	
	/**
	 * 用户登录
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/login")
	public String login(HttpServletRequest request,HttpServletResponse response)throws Exception {
		String userName=request.getParameter("userName");
		String password=request.getParameter("password");
		String groupId=request.getParameter("groupId");
		Map<String, Object> map=new HashMap<>();
		map.put("id", userName);
		map.put("password", MD5Util.md5(password, "152872"));
		map.put("groupId", groupId);
		Membership membership = membershipService.login(map);
		JSONObject result=new JSONObject();
		if (membership==null) {
			result.put("success", false);
			result.put("errorInfo", "用户名或密码错误!");
		}else {
			result.put("success", true);
			request.getSession().setAttribute("currentMemberShip", membership);
		}
		ResponseUtil.write(response, result);
		return null;
	}
	
	/**
	 * 更新用户权限 先删除 后批量添加
	 * @param userId
	 * @param groupsIds
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/update")
	public String update(String userId,String groupsIds,HttpServletResponse response)throws Exception{
		membershipService.deleteAllGroupsByUserId(userId);
		if(StringUtil.isNotEmpty(groupsIds)){
			String idsArr[]=groupsIds.split(",");
			for(String groupId:idsArr){
				User user=new User();user.setId(userId);
				Jurisdiction group=new Jurisdiction();group.setId(groupId);
				Membership memberShip=new Membership();
				memberShip.setUser(user);
				memberShip.setGroup(group);
				membershipService.add(memberShip);
			}
		}
		JSONObject result=new JSONObject();
		result.put("success", true);
		ResponseUtil.write(response, result);
		return null;
	}
}
