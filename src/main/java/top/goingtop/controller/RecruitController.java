package top.goingtop.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
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
import top.goingtop.pojo.Recruit;
import top.goingtop.service.EmployerService;
import top.goingtop.service.RecruitService;
import top.goingtop.util.DateJsonValueProcessor;
import top.goingtop.util.PageBean;
import top.goingtop.util.ResponseUtil;

@Controller
@RequestMapping("/recruit")
public class RecruitController {

	@Resource
	private RecruitService recruitService;
	@Resource
	private EmployerService employerService;
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));   //true:允许输入空值，false:不能为空值
	}
	@RequestMapping("/findEmployer")
	public String findEmployer(String recId,HttpServletResponse response) throws Exception {
		Recruit rec = recruitService.findById(Integer.parseInt(recId));
		Employer employer = employerService.findById(rec.getEmployerId());
		JSONObject result=new JSONObject();
		result.put("employer", employer);
		ResponseUtil.write(response, result);
		return null;
	}
	@RequestMapping("/listInterview")
	public String listInterview(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,Recruit recruit,HttpServletResponse response)throws Exception {
		PageBean pageBean=new PageBean(Integer.parseInt(page), Integer.parseInt(rows));
		Map<String, Object> map=new HashMap<>();
		JsonConfig jsonConfig=new JsonConfig();
		jsonConfig.setExcludes(new String[]{"resources"});
		jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd"));
		JSONObject result=new JSONObject();
		map.put("name", recruit.getUserName());
		map.put("job", recruit.getJob());
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<Recruit> recruitList = recruitService.findInterview(map);
		Long total = recruitService.getTotal(map);
		JSONArray jsonArray = JSONArray.fromObject(recruitList,jsonConfig);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
	}
	@RequestMapping("/listRecruit")
	public String listRecruit(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,Recruit recruit,HttpServletResponse response)throws Exception {
		PageBean pageBean=new PageBean(Integer.parseInt(page), Integer.parseInt(rows));
		Map<String, Object> map=new HashMap<>();
		JsonConfig jsonConfig=new JsonConfig();
		jsonConfig.setExcludes(new String[]{"resources"});
		jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd"));
		JSONObject result=new JSONObject();
		map.put("userName", recruit.getUserName());
		map.put("job", recruit.getJob());
		map.put("recStatus", recruit.getRecStatus());
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<Recruit> recruitList = recruitService.findRecruit(map);
		Long total = recruitService.getTotal(map);
		JSONArray jsonArray = JSONArray.fromObject(recruitList,jsonConfig);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
	}
	/**
	 * 保存员工信息并修改招聘状态
	 * @param employer
	 * @param response
	 * @param status
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/saveEmployer")
	public String saveEmployer(Employer employer,HttpServletResponse response,Integer recId) throws Exception {
		Recruit recruit=new Recruit();
		recruit.setRecId(recId);
		recruit.setRecStatus("签约完成");
		recruit.setEmployerId(employer.getId());
		int addEmployer = employerService.add(employer);
		int updateRecruit = recruitService.update(recruit);
		JSONObject result=new JSONObject();
		if(addEmployer>0 && updateRecruit>0){
			result.put("success", true);
		}else{
			result.put("success", false);
		}
		ResponseUtil.write(response, result);
		return null;
	}
	/**
	 * 添加或者修改招聘信息
	 * @param recruit
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/save")
	public String save(Recruit recruit,HttpServletResponse response)throws Exception {
		int resultTotal=0;//操作记录数
		if(recruitService.findById(recruit.getRecId())==null){
			resultTotal=recruitService.add(recruit);
		}else{
			resultTotal=recruitService.update(recruit);
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
	
	@RequestMapping("/saves")
	public String saves(@RequestParam(value="ids",required=false)String ids,@RequestParam(value="state",required=false)String state,HttpServletResponse response) throws Exception{
		int resultTotal=0; 
	    String idList[]=ids.split(",");
	      for(int i=0;i<idList.length;i++){
	    	  Recruit recruit=new Recruit();
	    	  recruit.setRecId(Integer.parseInt(idList[i]));
	    	  recruit.setRecStatus(state);
	    	  System.out.println(state);
	    	  resultTotal= recruitService.update(recruit);	  
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
	 * 删除招聘信息
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
			recruitService.delete(Integer.parseInt(idsStr[i]));
		}
		result.put("success", true);
		ResponseUtil.write(response, result);
		return null;
	}
}
