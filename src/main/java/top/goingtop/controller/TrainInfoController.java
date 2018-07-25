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

import top.goingtop.pojo.Record;
import top.goingtop.pojo.TrainInfo;
import top.goingtop.service.RecordService;
import top.goingtop.service.TrainInfoService;
import top.goingtop.util.DateJsonValueProcessor;
import top.goingtop.util.PageBean;
import top.goingtop.util.ResponseUtil;
import top.goingtop.util.StringUtil;

/**
 * 培训信息Controller
 * @author cheng
 *
 */
@Controller
@RequestMapping("/trainInfo")
public class TrainInfoController {

	@Resource
	private RecordService recordService;
	@Resource
	private TrainInfoService trainInfoService;
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));   //true:允许输入空值，false:不能为空值
	}
	
	@RequestMapping("/list")
	public String list(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,TrainInfo trainInfo,HttpServletResponse response)throws Exception {
		PageBean pageBean=new PageBean(Integer.parseInt(page), Integer.parseInt(rows));
		Map<String, Object> map=new HashMap<>();
		JsonConfig jsonConfig=new JsonConfig();
		jsonConfig.setExcludes(new String[]{"resources"});
		jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd"));
		map.put("employerId", trainInfo.getEmployerId());//查询员工Id并获取
		map.put("startSearch", trainInfo.getStartSearch());
		map.put("trainContent",  StringUtil.formatLike(trainInfo.getTrainContent()));
		map.put("endSearch", trainInfo.getEndSearch());
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<TrainInfo> trainInfoList = trainInfoService.list(map);
		Long total = trainInfoService.getTotal(map);
		JSONObject result=new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(trainInfoList,jsonConfig);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
	}
	/**
	 * 添加或者修改用户
	 * @param trainInfo
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/save")
	public String save(TrainInfo trainInfo,String id,HttpServletResponse response)throws Exception {
		int resultTotal=0;//操作记录数
		JSONObject result=new JSONObject();
		StringBuffer stringBuffer=new StringBuffer();
		TrainInfo findTrainInfo = trainInfoService.findById(trainInfo.getId());
		String employerId = trainInfo.getEmployerId();
		if(findTrainInfo==null){
			Record record = recordService.findByEmployerId(employerId);
			if (record==null) {
				result.put("checkRecord", true);
				ResponseUtil.write(response, result);
				return null;
			}
			stringBuffer.append(record.getContent());
			stringBuffer.append(trainInfo.getTrainContent());
			record.setContent(stringBuffer.toString());
			recordService.update(record);
			resultTotal=trainInfoService.add(trainInfo);
		}else{
			Record record = recordService.findByEmployerId(employerId);
			stringBuffer.append(record.getContent()+"，");
			stringBuffer.append(trainInfo.getTrainContent());
			record.setContent(stringBuffer.toString());
			recordService.update(record);
			trainInfo.setId(Integer.parseInt(id));
			resultTotal=trainInfoService.update(trainInfo);
		}
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
			trainInfoService.delete(Integer.parseInt(idsStr[i]));
		}
		result.put("success", true);
		ResponseUtil.write(response, result);
		return null;
	}
}
