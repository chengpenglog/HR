<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工合同管理</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
	var url;
	function searchContract(){
		$("#dg").datagrid('load',{
			"employerId":$("#employerId").val()
		});
	}
	
	function deleteContract(){
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
				$.post("${pageContext.request.contextPath}/contract/delete.do",{ids:ids},function(result){
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
	
	
	function openContractAddDiglog(){
		resetValue();
		$("#dlg").dialog("open").dialog("setTitle","添加员工信息");
    	url="${pageContext.request.contextPath}/contract/save.do";
	}
	
	function openContractModifyDiglog(){
		var selectedRows=$("#dg").datagrid("getSelections");
    	if(selectedRows.length!=1){
    		$.messager.alert("系统提示","请选择一条要编辑的数据!");
    		return;
    	}
    	var row=selectedRows[0];
    	$("#dlg").dialog("open").dialog("setTitle","编辑员工信息");
    	$("#form").form("load",row);
    	url="${pageContext.request.contextPath}/contract/save.do?id="+row.id;
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
		$("#startTime").val("");
		$("#endTime").val("");
		$("#job").val("");
		$("#content").val("");
		$("#remark").val("");
	}
	
	function closeContractDialog(){
		$("#dlg").dialog("close");
		resetValue();
	}
</script>
</head>
<body style="margin: 1px">
<table id="dg" title="用户管理" class="easyui-datagrid"
  fitColumns="true" pagination="true" rownumbers="true"
  url="${pageContext.request.contextPath}/contract/list.do" fit="true" toolbar="#tb">
 <thead>
 	<tr>
 		<th field="cb" checkbox="true" align="center"></th>
 		<th field="id" width="40" align="center">合同编号</th>
 		<th field="employerId" width="80" align="center">员工编号</th>
 		<th field="startTime" width="100" align="center">合同的开始日期</th>
 		<th field="endTime" width="100" align="center">结束日期</th>
 		<th field="job" width="40" align="center">职务</th>
 		<th field="content" width="200" align="center">合同内容</th>
 		<th field="remark" width="100" align="center">备注</th>
 	</tr>
 </thead>
</table>
<div id="tb">
 <div>
	<a href="javascript:openContractAddDiglog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
	<a href="javascript:openContractModifyDiglog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
	<a href="javascript:deleteContract()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
 </div>
 <div>
 	&nbsp;员工信息(编号/姓名):&nbsp;<input type="text" id="employerId" size="20" onkeydown="if(event.keyCode==13) searchContract()"/>
 	<a href="javascript:searchContract()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
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
 				<td>合同的开始日期：</td>
 				<td colspan="4">
 					<input type="date" id="startTime" name="startTime" class="easyui-validatebox" required="true"/>
 				</td>
 			</tr>
 			<tr>
 				<td>结束日期：</td>
 				<td colspan="4">
 					<input type="date" id="endTime" name="endTime" class="easyui-validatebox" required="true"/>
 				</td>
 			</tr>
 			<tr>
 				<td>职务：</td>
 				<td>
 					<input type="text" id="job" name="job" class="easyui-validatebox" required="true"/>
 				</td>
 			</tr>
 			<tr>
 				<td>合同内容：</td>
 				<td>
 					<input type="text" id="content" name="content" class="easyui-validatebox" required="true"/>
 				</td>
 			</tr>
 			<tr>
 				<td>备注：</td>
 				<td>
 					<input type="text" id="remark" name="remark" class="easyui-validatebox" required="true"/>
 				</td>
 			</tr>
 		</table>
 	</form>
</div>
<div id="dlg-buttons">
	<a href="javascript:checkData()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
	<a href="javascript:closeContractDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>
</body>
</html>