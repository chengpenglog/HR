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

import top.goingtop.pojo.Payment;
import top.goingtop.pojo.Employer;
import top.goingtop.service.CheckService;
import top.goingtop.service.PaymentService;
import top.goingtop.service.EmployerService;
import top.goingtop.util.DateJsonValueProcessor;
import top.goingtop.util.PageBean;
import top.goingtop.util.ResponseUtil;
import top.goingtop.util.StringUtil;

@Controller
@RequestMapping("/payment")
public class PaymentController {
	@Resource
	private PaymentService paymentService;
	@Resource
	private EmployerService employerService;
	@Resource
	private CheckService checkService;
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));   //true:允许输入空值，false:不能为空值
	}
	@RequestMapping("/list")
	public String list(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,Payment payment,HttpServletResponse response)throws Exception {
		PageBean pageBean=new PageBean(Integer.parseInt(page), Integer.parseInt(rows));
		Map<String, Object> map=new HashMap<>();
		JsonConfig jsonConfig=new JsonConfig();
		jsonConfig.setExcludes(new String[]{"resources"});
		jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd"));
		JSONObject result=new JSONObject();
		String employerInfo = payment.getEmployerId();
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
		List<Payment> paymentList = paymentService.find(map);
		Long total = paymentService.getTotal(map);
		JSONArray jsonArray = JSONArray.fromObject(paymentList,jsonConfig);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
	}
	
	@RequestMapping("/listByUserId")
	public String listByUserId(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,Payment payment,String userId,HttpServletResponse response)throws Exception {
		PageBean pageBean=new PageBean(Integer.parseInt(page), Integer.parseInt(rows));
		Map<String, Object> map=new HashMap<>();
		JsonConfig jsonConfig=new JsonConfig();
		jsonConfig.setExcludes(new String[]{"resources"});
		jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd"));
		JSONObject result=new JSONObject();
		map.put("employerId",userId);
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<Payment> paymentList = paymentService.find(map);
		Long total = paymentService.getTotal(map);
		JSONArray jsonArray = JSONArray.fromObject(paymentList,jsonConfig);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
	}
	/**
	 * 添加或者修改薪酬记录
	 * @param payment
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/save")
	public String save(Payment payment,HttpServletResponse response)throws Exception {
		Map<String, Object> map=new HashMap<>();
		String paymentTime = payment.getPaymentTime();
		String[] str=paymentTime.split("-");
		String startMonth=str[0]+"-"+str[1]+"-"+"01";
		map.put("startMonth", startMonth);
		map.put("endMonth", paymentTime);
		int resultTotal=0;//操作记录数
		if(paymentService.findById(payment.getId())==null){
			String employerId = payment.getEmployerId();
			map.put("employerId", employerId);
			Integer fine = checkService.getFine(map);
			if (fine==null) {
				fine=0;
			}
			Integer total = checkService.getBonus(map);
			if (total==null) {
				total=0;
			}
			Integer baseSalary = payment.getBaseSalary();
			Integer performanceSalary = payment.getPerformanceSalary();
			payment.setFine(fine);
			payment.setBonus(total-fine);
			payment.setPaymentNum(baseSalary+performanceSalary+total);
			resultTotal=paymentService.add(payment);
		}else{
			String employerId = payment.getEmployerId();
			map.put("employerId", employerId);
			Integer fine = checkService.getFine(map);
			Integer bonus = checkService.getBonus(map);
			Integer baseSalary = payment.getBaseSalary();
			Integer performanceSalary = payment.getPerformanceSalary();
			payment.setFine(fine);
			payment.setBonus(bonus);
			payment.setPaymentNum(baseSalary+performanceSalary+fine+bonus);
			resultTotal=paymentService.update(payment);
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
	 * 删除薪酬记录
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
			paymentService.delete(Integer.parseInt(idsStr[i]));
		}
		result.put("success", true);
		ResponseUtil.write(response, result);
		return null;
	}
}
