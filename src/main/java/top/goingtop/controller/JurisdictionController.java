package top.goingtop.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import top.goingtop.pojo.Jurisdiction;
import top.goingtop.pojo.Membership;
import top.goingtop.service.JurisdictionService;
import top.goingtop.service.MembershipService;
import top.goingtop.util.PageBean;
import top.goingtop.util.ResponseUtil;

@Controller
@RequestMapping("/group")
public class JurisdictionController {

	@Resource
	private JurisdictionService jurisdictionService;
	@Resource
	private MembershipService membershipService;
	/**
	 * 查询所有角色   下拉框使用
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/groupComboList")
	public String groupComboList(HttpServletResponse response) throws Exception{
		JSONArray jsonArray=new JSONArray();
		JSONObject jsonObject=new JSONObject();
		jsonObject.put("id", -1);
		jsonObject.put("name", "请选择角色...");
		jsonArray.add(jsonObject);
		List<Jurisdiction> groupList = jurisdictionService.find(null);
		JSONArray rows = JSONArray.fromObject(groupList);
		jsonArray.addAll(rows);
		ResponseUtil.write(response, jsonArray);
		return null;
	}
	/**
	 * 根据条件分页查询角色集合
	 * @param page
	 * @param rows
	 * @param s_group
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public String list(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,HttpServletResponse response)throws Exception {
		PageBean pageBean=new PageBean(Integer.parseInt(page), Integer.parseInt(rows));
		Map<String, Object> map=new HashMap<>();
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<Jurisdiction> groupList = jurisdictionService.find(map);
		Long total = jurisdictionService.getTotal(map);
		JSONObject result=new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(groupList);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
		
	}
	@RequestMapping("/delete")
	public String delete(@RequestParam(value="ids",required=false)String ids,HttpServletResponse response)throws Exception{
		JSONObject result=new JSONObject();
		String []idsStr=ids.split(",");
		for(int i=0;i<idsStr.length;i++){
			List<Membership> list = membershipService.findUserByGroupId(idsStr[i]);
			for(Membership memberShip:list) {
				System.out.println(memberShip.getUser().getId());
				if (memberShip.getUser().getId()!=null) {
					result.put("used", true);
					ResponseUtil.write(response, result);
					return null;
				}
			}
		}
		for(int i=0;i<idsStr.length;i++){
			jurisdictionService.delete(idsStr[i]);
		}
		result.put("success", true);
		ResponseUtil.write(response, result);
		return null;
	}
	/**
	 * 添加或者修改角色
	 * @param group
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/save")
	public String save(Jurisdiction group,HttpServletResponse response,Integer flag)throws Exception {
		int resultTotal=0;
		if (flag==1) {
			resultTotal=jurisdictionService.add(group);
		}else {
			resultTotal=jurisdictionService.update(group);
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
	 * 判断是否存在指定角色名
	 * @param groupName
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/existGroupName")
	public String existGroupName(String groupName,HttpServletResponse response)throws Exception {
		JSONObject result=new JSONObject();
		if (jurisdictionService.findById(groupName)==null) {
			result.put("exist", false);
		}else {
			result.put("exist", true);
		}
		ResponseUtil.write(response, result);
		return null;
	}
	/**
	 * 查询所有角色
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/listAllGroups")
	public String listAllGroups(HttpServletResponse response)throws Exception {
		List<Jurisdiction> groupList=jurisdictionService.find(null);
		JSONObject result=new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(groupList);
		result.put("groupList", jsonArray);
		ResponseUtil.write(response, result);
		return null;
	}
	/**
	 * 通过用户Id查询角色集合，多个角色逗号隔开
	 * @param userId
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/findGroupByUserId")
	public String findGroupByUserId(String userId,HttpServletResponse response)throws Exception {
		List<Jurisdiction> groupList = jurisdictionService.findByUserId(userId);
		StringBuffer groups=new StringBuffer();
		for(Jurisdiction g:groupList){
			groups.append(g.getId()+",");
		}
		JSONObject result=new JSONObject();
		if (groups.length()>0) {
			result.put("groups", groups.deleteCharAt(groups.length()-1).toString());
		}else {
			result.put("groups", groups.toString());
		}
		ResponseUtil.write(response, result);
		return null;
	}
}
