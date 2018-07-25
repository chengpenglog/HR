<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工基本信息</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
	var url;
	function searchEmployer(){
		$("#dg").datagrid('load',{
			"userName":$("#username").val()
		});
	}
	
	function deleteEmployer(){
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
				$.post("${pageContext.request.contextPath}/employer/delete.do",{ids:ids},function(result){
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
	
	
	function openEmployerAddDiglog(){
		resetValue();
		$("#dlg").dialog("open").dialog("setTitle","添加员工信息");
    	url="${pageContext.request.contextPath}/employer/save.do";
	}
	
	function openEmployerModifyDiglog(){
		var selectedRows=$("#dg").datagrid("getSelections");
    	if(selectedRows.length!=1){
    		$.messager.alert("系统提示","请选择一条要编辑的数据!");
    		return;
    	}
    	var row=selectedRows[0];
    	$("#dlg").dialog("open").dialog("setTitle","编辑员工信息");
    	$("#form").form("load",row);
    	url="${pageContext.request.contextPath}/employer/save.do";
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
		$("#id").val("");
		$("#userName").val("");
		$("#sex").val("");
		$("#birthday").val("");
		$("#tel").val("");
		$("#email").val("");
		$("#major").val("");
		$("#job").val("");
		$("#startTime").val("");
		$("#status").val("");
		$("#remark").val("");
	}
	
	function closeEmployerDialog(){
		$("#dlg").dialog("close");
		resetValue();
	}
</script>
</head>
<body style="margin: 1px">
<table id="dg" title="用户管理" class="easyui-datagrid"
  fitColumns="true" pagination="true" rownumbers="true"
  url="${pageContext.request.contextPath}/employer/list.do" fit="true" toolbar="#tb">
 <thead>
 	<tr>
 		<th field="cb" checkbox="true" align="center"></th>
 		<th field="id" width="30" align="center">编号</th>
 		<th field="userName" width="80" align="center">姓名</th>
 		<th field="sex" width="50" align="center">性别</th>
 		<th field="birthday" width="50" align="center">出生日期</th>
 		<th field="tel" width="100" align="center">电话</th>
 		<th field="email" width="80" align="center">邮箱</th>
 		<th field="major" width="80" align="center">学历</th>
 		<th field="job" width="50" align="center">职务</th>
 		<th field="startTime" width="50" align="center">入职时间</th>
 		<th field="status" width="50" align="center">状态</th>
 		<th field="remark" width="100" align="center">备注</th>
 	</tr>
 </thead>
</table>
<div id="tb">
 <div>
	<a href="javascript:openEmployerAddDiglog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
	<a href="javascript:openEmployerModifyDiglog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
	<a href="javascript:deleteEmployer()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
 </div>
 <div>
 	&nbsp;姓名:&nbsp;<input type="text" id="username" size="20" onkeydown="if(event.keyCode==13) searchEmployer()"/>
 	<a href="javascript:searchEmployer()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
 </div>
</div>
<div id="dlg" class="easyui-dialog" style="width: 620px;height: 335px;padding: 10px 20px"closable: false closed="true" buttons="#dlg-buttons">
 
 	<form id="form" method="post">
 		<table cellpadding="8px">
 			<tr>
 				<td>员工编号：</td>
 				<td>
 					<input type="text" id="id" name="id" class="easyui-validatebox" required="true"/>
 				</td>
 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
 				<td>姓名：</td>
 				<td>
 					<input type="text" id="userName" name="userName" class="easyui-validatebox" required="true"/>
 				</td>
 			</tr>
 			<tr>
 				<td>性别：</td>
 				<td>
 					<input type="text" id="sex" name="sex" class="easyui-validatebox" required="true"/>
 				</td>
 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
 				<td>出生日期：</td>
 				<td>
 					<input type="date" id="birthday" name="birthday" class="easyui-validatebox" required="true"/>
 				</td>
 			</tr>
 			<tr>
 				<td>电话号码：</td>
 				<td>
 					<input type="text" id="tel" name="tel" class="easyui-validatebox" required="true"/>
 				</td>
 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
 				<td>邮箱：</td>
 				<td>
 					<input type="text" id="email" name="email" class="easyui-validatebox" required="true"/>
 				</td>
 			</tr>
 			<tr>
 				<td>学历：</td>
 				<td>
 					<input type="text" id="major" name="major" class="easyui-validatebox" required="true"/>
 				</td>
 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
 				<td>职位：</td>
 				<td>
 					<input type="text" id="job" name="job" class="easyui-validatebox" required="true"/>
 				</td>
 			</tr>
 			<tr>
 				<td>入职时间：</td>
 				<td>
 					<input type="date" id="startTime" name="startTime" class="easyui-validatebox" required="true"/>
 				</td>
 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
 				<td>状态：</td>
 				<td>
 					<input type="text" id="status" name="status" class="easyui-validatebox" required="true"/>
 				</td>
 			</tr>
 			<tr>
 				<td>备注：</td>
 				<td colspan="4">
 					<input type="text" id="remark" name="remark" class="easyui-validatebox" required="true"/>
 				</td>
 			</tr>
 		</table>
 	</form>
</div>
<div id="dlg-buttons">
	<a href="javascript:checkData()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
	<a href="javascript:closeEmployerDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>
</body>
</html>