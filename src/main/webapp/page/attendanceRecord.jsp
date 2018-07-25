<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>考勤记录信息管理</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
	var url;
	function searchCheck(){
		$("#dg").datagrid('load',{
			"type":$("#chooseType").combobox("getValue"),
			"employerId":$("#employerid").val(),
			"startSearch":$("#startSearch").val(),
			"endSearch":$("#endSearch").val()
		});
	}
	
	function deleteCheck(){
		var selectRows=$("#dg").datagrid("getSelections");
		if(selectRows.length==0){
			$.messager.alert("系统提示","请选择要删除的数据！");
			return;
		}
		var strIds=[];
		for(var i=0;i<selectRows.length;i++){
			strIds.push(selectRows[i].id);
		}
		var ids=strIds.join(",");
		$.messager.confirm("系统提示","您确定要删除这<font color=red>"+selectRows.length+"</font>条数据吗?",function(r){
			if(r){
				$.post("${pageContext.request.contextPath}/check/delete.do",{ids:ids},function(result){
					if(result.success){
						$.messager.alert("系统提示","数据已经成功删除！");
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert("系统提示","数据删除失败，请联系运维！");
					}
				},"json");
			}
		});
	}
	
	
	function openCheckAddDiglog(){
		resetValue();
		$("#dlg").dialog("open").dialog("setTitle","添加考勤记录信息");
    	url="${pageContext.request.contextPath}/check/save.do";
	}
	
	function openCheckModifyDiglog(){
		var selectedRows=$("#dg").datagrid("getSelections");
    	if(selectedRows.length!=1){
    		$.messager.alert("系统提示","请选择一条要编辑的数据!");
    		return;
    	}
    	var row=selectedRows[0];
    	$("#dlg").dialog("open").dialog("setTitle","编辑考勤记录信息");
    	$("#form").form("load",row);
    	url="${pageContext.request.contextPath}/check/save.do?id="+row.id;
	}
	
	
	function checkData(){
		$("#form").form("submit",{
			url:url,
			onSubmit:function(){
				return $(this).form("validate");
			},
			success:function(result){
				var result=eval('('+result+')');
				if(result.success){
					$.messager.alert("系统提示","保存成功！");
					resetValue();
					$("#dlg").dialog("close");
					$("#dg").datagrid("reload");
				}else{
					$.messager.alert("系统提示","保存失败！");
					return;
				}
			}
		});
	}
	
	function resetValue(){
		$("#employerId").val("");
		$("#type").combobox("setValues","");
		$("#money").val("");
		$("#checkTime").val("");
	}
	
	function closeCheckDialog(){
		$("#dlg").dialog("close");
		resetValue();
	}
</script>
</head>
<body style="margin: 1px">
<table id="dg" title="用户管理" class="easyui-datagrid"
  fitColumns="true" pagination="true" rownumbers="true"
  url="${pageContext.request.contextPath}/check/list.do" fit="true" toolbar="#tb">
 <thead>
 	<tr>
 		<th field="cb" checkbox="true" align="center"></th>
 		<th field="id" width="40" align="center">编号</th>
 		<th field="employerId" width="100" align="center">员工编号</th>
 		<th field="type" width="80" align="center">类型</th>
 		<th field="money" width="100" align="center">奖惩金额</th>
 		<th field="checkTime" width="100" align="center">考勤记录时间</th>
 	</tr>
 </thead>
</table>
<div id="tb">
 <div>
	<a href="javascript:openCheckAddDiglog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
	<a href="javascript:openCheckModifyDiglog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
	<a href="javascript:deleteCheck()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
 </div>
 <div>
 &nbsp;类别:&nbsp;
	 <select class="easyui-combobox" id="chooseType" edatible="false" panelHeight="auto" onkeydown="if(event.keyCode==13) searchCheck()">
	 	<option value="">请选择...</option>
	 	<option value="迟到">迟到</option>
	 	<option value="旷工">旷工</option>
	 	<option value="请假">请假</option>
	 	<option value="加班">加班</option>
	 	<option value="出差">出差</option>
	 	<option value="调班">调班</option>
	 	<option value="停工">停工</option>
	 </select>
 	&nbsp;员工编号:&nbsp;<input type="text" id="employerid" size="20" onkeydown="if(event.keyCode==13) searchCheck()"/>
 	&nbsp;&nbsp; 考勤时间：<input type="date" id="startSearch" size="20" onkeydown="if(event.keyCode==13) searchTrainInfo()"/>
 	&nbsp;至&nbsp;<input type="date" id="endSearch" size="20" onkeydown="if(event.keyCode==13) searchTrainInfo()"/>
 	<a href="javascript:searchCheck()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
 </div>
</div>
<div id="dlg" class="easyui-dialog" style="width: 620px;height: 335px;padding: 10px 20px"closable: false closed="true" buttons="#dlg-buttons">
 
 	<form id="form" method="post">
 		<table cellpadding="8px">
 			<tr>
 				<td>员工编号：</td>
 				<td colspan="4">
 					<input type="text" id="employerId" name="employerId" class="easyui-validatebox" required="true"/>
 				</td>
 			</tr>
 			<tr>
 				<td>类型：</td>
 				<td colspan="4">
 					<select class="easyui-combobox" id="type" name="type" edatible="false" panelHeight="auto">
					 	<option value="">请选择...</option>
					 	<option value="迟到">迟到</option>
					 	<option value="旷工">旷工</option>
					 	<option value="请假">请假</option>
					 	<option value="加班">加班</option>
					 	<option value="出差">出差</option>
					 	<option value="调班">调班</option>
					 	<option value="停工">停工</option>
					 </select>
 				</td>
 			</tr>
 			<tr>
 				<td>奖惩金额：</td>
 				<td colspan="4">
 					<input type="text" id="money" name="money" class="easyui-validatebox" required="true"/>
 				</td>
 			</tr>
 			<tr>
 				<td>考勤记录时间：</td>
 				<td>
 					<input type="date" id="checkTime" name="checkTime" class="easyui-validatebox" required="true"/>
 				</td>
 			</tr>
 		</table>
 	</form>
</div>
<div id="dlg-buttons">
	<a href="javascript:checkData()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
	<a href="javascript:closeCheckDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>
</body>
</html>