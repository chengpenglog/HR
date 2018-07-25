<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>培训类别管理</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
	var url;
	function searchTrainInfo(){
		$("#dg").datagrid('load',{
			"trainContent":$("#content").val(),
			"employerId":$("#employerid").val(),
			"startSearch":$("#startSearch").val(),
			"endSearch":$("#endSearch").val()
		});
	}
	
	function deleteTrainInfo(){
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
				$.post("${pageContext.request.contextPath}/trainInfo/delete.do",{ids:ids},function(result){
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
	
	
	function openTrainInfoAddDiglog(){
		resetValue();
		$("#dlg").dialog("open").dialog("setTitle","添加培训类别信息");
    	url="${pageContext.request.contextPath}/trainInfo/save.do";
	}
	
	function openTrainInfoModifyDiglog(){
		var selectedRows=$("#dg").datagrid("getSelections");
    	if(selectedRows.length!=1){
    		$.messager.alert("系统提示","请选择一条要编辑的数据!");
    		return;
    	}
    	var row=selectedRows[0];
    	$("#dlg").dialog("open").dialog("setTitle","编辑培训类别信息");
    	$("#form").form("load",row);
    	url="${pageContext.request.contextPath}/trainInfo/save.do?id="+row.id;
	}
	
	
	function checkData(){
		$("#form").form("submit",{
			url:url,
			onSubmit:function(){
				if($("#type").combobox("getValue")==""){
					$.messager.alert("系统提示","请选择培训类别！");
					return false;
				}
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
		$("#type").combobox("setValues","");
		$("#employerid").val("");
		$("#traincontent").val("");
		$("#startTime").val("");
		$("#endTime").val("");
	}
	
	function closeTrainInfoDialog(){
		$("#dlg").dialog("close");
		resetValue();
	}
</script>
</head>
<body style="margin: 1px">
<table id="dg" title="培训信息管理" class="easyui-datagrid"
  fitColumns="true" pagination="true" rownumbers="true"
  url="${pageContext.request.contextPath}/trainInfo/list.do" fit="true" toolbar="#tb">
 <thead>
 	<tr>
 		<th field="cb" checkbox="true" align="center"></th>
 		<th field="id" width="50" align="center">培训记录编号</th>
 		<th field="type" width="80" align="center">培训类别</th>
 		<th field="employerId" width="80" align="center">员工编号</th>
 		<th field="trainContent" width="200" align="center">培训内容</th>
 		<th field="startTime" width="100" align="center">培训开始时间</th>
 		<th field="endTime" width="100" align="center">培训结束时间</th>
 	</tr>
 </thead>
</table>
<div id="tb">
 <div>
	<a href="javascript:openTrainInfoAddDiglog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
	<a href="javascript:openTrainInfoModifyDiglog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
	<a href="javascript:deleteTrainInfo()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
 </div>
 <div>
 	&nbsp;&nbsp;
 	培训内容:&nbsp;<input type="text" id="content" size="20" onkeydown="if(event.keyCode==13) searchTrainInfo()"/>
 	&nbsp;&nbsp;
 	员工编号:&nbsp;<input type="text" id="employerid" size="20" onkeydown="if(event.keyCode==13) searchTrainInfo()"/>
 	&nbsp;&nbsp;
 	培训开始时间：<input type="date" id="startSearch" size="20" onkeydown="if(event.keyCode==13) searchTrainInfo()"/>
 	&nbsp;至&nbsp;<input type="date" id="endSearch" size="20" onkeydown="if(event.keyCode==13) searchTrainInfo()"/>
 	<a href="javascript:searchTrainInfo()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
 </div>
</div>
<div id="dlg" class="easyui-dialog" style="width: 620px;height: 335px;padding: 10px 20px"closable: false closed="true" buttons="#dlg-buttons">
 
 	<form id="form" method="post">
 		<table cellpadding="8px">
 			<tr>
 				<td>培训类别：</td>
 				<td>
 					<select class="easyui-combobox" id="type" name="type" edatible="false" panelHeight="auto">
 						<option value="">请选择...</option>
 						<option value="岗前培训">岗前培训</option>
 						<option value="在职培训">在职培训</option>
 					</select>
 				</td>
 			</tr>
 			<tr>
 				<td>员工编号：</td>
 				<td colspan="4">
 					<input type="text" id="employerid" name="employerId" class="easyui-validatebox" required="true"/>
 				</td>
 			</tr>
 			<tr>
 				<td>培训内容：</td>
 				<td colspan="4">
 					<input type="text" id="traincontent" name="trainContent" class="easyui-validatebox" required="true"/>
 				</td>
 			</tr>
 			<tr>
 				<td>培训开始时间：</td>
 				<td colspan="4">
 					<input type="date" id="startTime" name="startTime" class="easyui-validatebox" required="true"/>
 				</td>
 			</tr>
 			<tr>
 				<td>培训结束时间：</td>
 				<td colspan="4">
 					<input type="date" id="endTime" name="endTime" class="easyui-validatebox" required="true"/>
 				</td>
 			</tr>
 			
 		</table>
 	</form>
</div>
<div id="dlg-buttons">
	<a href="javascript:checkData()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
	<a href="javascript:closeTrainInfoDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>
</body>
</html>