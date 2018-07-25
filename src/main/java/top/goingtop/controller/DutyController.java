package top.goingtop.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import top.goingtop.pojo.Duty;
import top.goingtop.service.DutyService;
import top.goingtop.util.PageBean;
import top.goingtop.util.ResponseUtil;
import top.goingtop.util.StringUtil;

@Controller
@RequestMapping("/duty")
public class DutyController {
	@Resource
	private DutyService dutyService;
	/**
	 * 根据条件分页查询职务信息
	 * @param page
	 * @param rows
	 * @param duty
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public String list(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,Duty duty,HttpServletResponse response)throws Exception {
		PageBean pageBean=new PageBean(Integer.parseInt(page), Integer.parseInt(rows));
		Map<String, Object> map=new HashMap<>();
		map.put("dutyName", StringUtil.formatLike(duty.getDutyName()));//查询职务名称并获取
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<Duty> dutyList = dutyService.list(map);
		Long total = dutyService.getTotal(map);
		JSONObject result=new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(dutyList);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
		
	}
	/**
	 * 删除职务信息
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
			dutyService.delete(Integer.parseInt(idsStr[i]));
		}
		result.put("success", true);
		ResponseUtil.write(response, result);
		return null;
	}
	/**
	 * 添加或者修改职务
	 * @param duty
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/save")
	public String save(Duty duty,HttpServletResponse response)throws Exception {
		int resultTotal=0;
		if(dutyService.findById(duty.getId())==null) {
			resultTotal=dutyService.add(duty);
		}else {
			resultTotal=dutyService.update(duty);
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
	 * 判断是否存在指定职务
	 * @param dutyName
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/existDutyName")
	public String existDutyName(String dutyName,HttpServletResponse response)throws Exception {
		JSONObject result=new JSONObject();
		if (dutyService.findIdByName(dutyName)==null) {
			result.put("exist", false);
		}else {
			result.put("exist", true);
		}
		ResponseUtil.write(response, result);
		return null;
	}
	/**
	 * 查询所有缺员的职务
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/dutyComboList")
	public String dutyComboList(HttpServletResponse response) throws Exception{
		JSONArray jsonArray=new JSONArray();
//		JSONObject jsonObject=new JSONObject();
//		jsonObject.put("id", -1);
//		jsonObject.put("dutyName", "请选择...");
//		jsonArray.add(jsonObject);
		List<Duty> dutyLackList = dutyService.findIsLackDuty();
		JSONArray rows = JSONArray.fromObject(dutyLackList);
		jsonArray.addAll(rows);
		ResponseUtil.write(response, jsonArray);
		return null;
	}
}
