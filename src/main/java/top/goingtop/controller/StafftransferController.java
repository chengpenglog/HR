package top.goingtop.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import top.goingtop.pojo.Duty;
import top.goingtop.pojo.Employer;
import top.goingtop.pojo.Stafftransfer;
import top.goingtop.service.DutyService;
import top.goingtop.service.EmployerService;
import top.goingtop.service.StafftransferService;
import top.goingtop.util.DateJsonValueProcessor;
import top.goingtop.util.PageBean;
import top.goingtop.util.ResponseUtil;
import top.goingtop.util.StringUtil;

@Controller
@RequestMapping("/stafftransfer")
public class StafftransferController {

	@Resource
	private StafftransferService stafftransferService;
	@Resource
	private EmployerService employerService;
	@Resource
	private DutyService dutyService;
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));   //true:允许输入空值，false:不能为空值
	}
	@RequestMapping("/list")
	public String list(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,Stafftransfer stafftransfer,HttpServletResponse response)throws Exception {
		PageBean pageBean=new PageBean(Integer.parseInt(page), Integer.parseInt(rows));
		Map<String, Object> map=new HashMap<>();
		JsonConfig jsonConfig=new JsonConfig();
		jsonConfig.setExcludes(new String[]{"resources"});
		jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd"));
		JSONObject result=new JSONObject();
		String employerInfo = stafftransfer.getEmployerId();
		if (employerInfo==null || employerInfo.equals("")) {
			map.put("employerId", StringUtil.formatLike(""));
		}else {
			Employer employer = employerService.findById(employerInfo);
			if (employer==null) {
				Employer emp = employerService.findIdByName(employerInfo);
				if (emp==null) {
					result.put("rows", 0);
					result.put("total", 0);
					ResponseUtil.write(response, result);
					return null;
				}
				map.put("employerId", StringUtil.formatLike(emp.getId()));
			}else {
				map.put("employerId", StringUtil.formatLike(employer.getId()));
			}
		}
		
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<Stafftransfer> stafftransferList = stafftransferService.find(map);
		Long total = stafftransferService.getTotal(map);
		
		JSONArray jsonArray = JSONArray.fromObject(stafftransferList,jsonConfig);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
	}
	/**
	 * 添加或者修改用户
	 * @param stafftransfer
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/save")
	public String save(Stafftransfer stafftransfer,HttpServletResponse response)throws Exception {
		int resultTotal=0;//操作记录数
		Employer emp = employerService.findById(stafftransfer.getEmployerId());
		stafftransfer.setOldJob(emp.getJob());
		Duty outDuty=new Duty();
		outDuty.setFixNum(dutyService.findIdByName(emp.getJob()).getFixNum()-1);
		outDuty.setLackNum(dutyService.findIdByName(emp.getJob()).getLackNum()+1);
		outDuty.setId(dutyService.findIdByName(emp.getJob()).getId());
		Employer employer=new Employer();
		employer.setId(stafftransfer.getEmployerId());
		employer.setJob(stafftransfer.getNewJob());
		Duty inDuty=new Duty();
		inDuty.setFixNum(dutyService.findIdByName(stafftransfer.getNewJob()).getFixNum()+1);
		inDuty.setLackNum(dutyService.findIdByName(stafftransfer.getNewJob()).getLackNum()-1);
		inDuty.setId(dutyService.findIdByName(stafftransfer.getNewJob()).getId());
		if(stafftransferService.findById(stafftransfer.getId())==null){
			resultTotal=stafftransferService.add(stafftransfer);
		}else{
			resultTotal=stafftransferService.update(stafftransfer);
		}
		JSONObject result=new JSONObject();
		if(resultTotal>0){
			result.put("success", true);
			dutyService.update(outDuty);
			employerService.update(employer);//更新变更职务的员工信息
			dutyService.update(inDuty);
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
			stafftransferService.delete(Integer.parseInt(idsStr[i]));
		}
		result.put("success", true);
		ResponseUtil.write(response, result);
		return null;
	}
}
