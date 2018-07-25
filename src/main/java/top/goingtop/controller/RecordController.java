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

import top.goingtop.pojo.Record;
import top.goingtop.service.RecordService;
import top.goingtop.util.PageBean;
import top.goingtop.util.ResponseUtil;
import top.goingtop.util.StringUtil;

/**
 * 员工Controller
 * @author cheng
 *
 */
@Controller
@RequestMapping("/record")
public class RecordController {

	@Resource
	private RecordService recordService;
	/**
	 * 查询员工信息
	 * @param page
	 * @param rows
	 * @param s_record
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public String list(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,Record s_record,HttpServletResponse response)throws Exception {
		PageBean pageBean=new PageBean(Integer.parseInt(page), Integer.parseInt(rows));
		Map<String, Object> map=new HashMap<>();
		map.put("recordName", StringUtil.formatLike(s_record.getRecordName()));//查询用户名并获取
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<Record> recordList = recordService.list(map);
		Long total = recordService.getTotal(map);
		JSONObject result=new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(recordList);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
	}
	/**
	 * 添加或者修改用户
	 * @param record
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/save")
	public String save(Record record,HttpServletResponse response)throws Exception {
		int resultTotal=0;//操作记录数
		if(record.getId()==null){
			resultTotal=recordService.add(record);
		}else{
			resultTotal=recordService.update(record);
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
			recordService.delete(Integer.parseInt(idsStr[i]));
		}
		result.put("success", true);
		ResponseUtil.write(response, result);
		return null;
	}
}
