package top.goingtop.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import top.goingtop.pojo.Employer;
import top.goingtop.service.EmployerService;
import top.goingtop.util.DateJsonValueProcessor;
import top.goingtop.util.PageBean;
import top.goingtop.util.ResponseUtil;
import top.goingtop.util.StringUtil;

/**
 * 员工Controller
 * @author cheng
 *
 */
@Controller
@RequestMapping("/employer")
public class EmployerController {

	@Resource
	private EmployerService employerService;
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));   //true:允许输入空值，false:不能为空值
	}
	@RequestMapping("/findByEmployerId")
	public String findByEmployerId(String employerId,HttpServletRequest request,HttpServletResponse response) throws Exception {
		Employer employer = employerService.findById(employerId);
		JSONObject result=new JSONObject();
		result.put("employer", employer);
		ResponseUtil.write(response, result);
		return null;
	}
	/**
	 * 查询员工信息
	 * @param page
	 * @param rows
	 * @param s_employer
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public String list(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,Employer s_employer,HttpServletResponse response)throws Exception {
		PageBean pageBean=new PageBean(Integer.parseInt(page), Integer.parseInt(rows));
		Map<String, Object> map=new HashMap<>();
		map.put("userName", StringUtil.formatLike(s_employer.getUserName()));//查询用户名并获取
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<Employer> employerList = employerService.list(map);
		Long total = employerService.getTotal(map);
		JsonConfig jsonConfig=new JsonConfig();
		jsonConfig.setExcludes(new String[]{"resources"});
		jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd"));
		JSONObject result=new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(employerList,jsonConfig);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
	}
	/**
	 * 添加或者修改用户
	 * @param employer
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/save")
	public String save(Employer employer,HttpServletResponse response)throws Exception {
		int resultTotal=0;//操作记录数
		if(employerService.findById(employer.getId())==null){
			resultTotal=employerService.add(employer);
		}else{
			resultTotal=employerService.update(employer);
		}
		JSONObject result=new JSONObject();
		if(resultTotal>0){
			result.put("success", true);
		}else{
			result.put("success", false);
		}
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
			employerService.delete(idsStr[i]);
		}
		result.put("success", true);
		ResponseUtil.write(response, result);
		return null;
	}
}
