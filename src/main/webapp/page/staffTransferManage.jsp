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
	function searchStafftransfer(){
		$("#dg").datagrid('load',{
			"employerId":$("#employerId").val()
		});
	}
	
	function deleteStafftransfer(){
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
				$.post("${pageContext.request.contextPath}/stafftransfer/delete.do",{ids:ids},function(result){
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
	
	
	function openStafftransferAddDiglog(){
		resetValue();
		$("#dlg").dialog("open").dialog("setTitle","添加员工信息");
    	url="${pageContext.request.contextPath}/stafftransfer/save.do";
	}
	
	function openStafftransferModifyDiglog(){
		var selectedRows=$("#dg").datagrid("getSelections");
    	if(selectedRows.length!=1){
    		$.messager.alert("系统提示","请选择一条要编辑的数据!");
    		return;
    	}
    	var row=selectedRows[0];
    	$("#dlg").dialog("open").dialog("setTitle","编辑员工信息");
    	$("#form").form("load",row);
    	url="${pageContext.request.contextPath}/stafftransfer/save.do?id="+row.id;
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
		$("#employerid").val("");
		$("#newJob").combobox('setValue', '请选择...');
		$("#staffTime").val("");
		$("#staffReason").val("");
		$("#id").val("");
	}
	
	function closeStafftransferDialog(){
		$("#dlg").dialog("close");
		resetValue();
	}
	function formatAction(val,row){
		return "<a href='javascript:openDeployerDiglog()'>查看员工信息</a>"
	}
	function openDeployerDiglog(){
		resetValue();
		$("#dlgInfo").dialog("open").dialog("setTitle","员工信息");
		var selectedRows=$("#dg").datagrid("getSelections");
		var row=selectedRows[0];
		$.post("${pageContext.request.contextPath}/employer/findByEmployerId.do?employerId="+row.employerId,function(result){
			console.log(result);
			$("#id").val(result.employer.id);
			$("#userName").val(result.employer.userName);
			$("#sex").val(result.employer.sex);
			$("#birthday").val(result.employer.birthday);
			$("#tel").val(result.employer.tel);
			$("#email").val(result.employer.email);
			$("#major").val(result.employer.major);
			$("#dep").val(result.employer.dep);
			$("#job").val(result.employer.job);
			$("#startTime").val(result.employer.startTime);
			$("#status").val(result.employer.status);
			$("#remark").val(result.employer.remark);
		},"json");
	}
	function closeInfoDialog() {
		$("#id").val("");
		$("#userName").val("");
		$("#sex").val("");
		$("#birthday").val("");
		$("#tel").val("");
		$("#email").val("");
		$("#major").val("");
		$("#dep").val("");
		$("#job").val("");
		$("#startTime").val("");
		$("#status").val("");
		$("#remark").val("");
		$("#dlgInfo").dialog("close");
		$("#dg").datagrid("reload");
	}
	
	
	function findLackInfo() {
		$("#dlgLackInfo").dialog("open").dialog("setTitle","职务缺员信息");
		$("#dgLackInfo").datagrid("reload");
	}
</script>
</head>
<body style="margin: 1px">
<table id="dg" title="用户管理" class="easyui-datagrid"
  fitColumns="true" pagination="true" rownumbers="true"
  url="${pageContext.request.contextPath}/stafftransfer/list.do" fit="true" toolbar="#tb">
 <thead>
 	<tr>
 		<th field="cb" checkbox="true" align="center"></th>
 		<th field="id" width="40" align="center">编号</th>
 		<th field="employerId" width="80" align="center">员工编号</th>
 		<th field="oldJob" width="100" align="center">原职务</th>
 		<th field="newJob" width="100" align="center">新职务</th>
 		<th field="staffTime" width="40" align="center">调动时间</th>
 		<th field="staffReason" width="200" align="center">调动原因</th>
 		<th field="aa" width="60" align="center" formatter="formatAction">操作</th>
 	</tr>
 </thead>
</table>
<div id="tb">
 <div>
	<a href="javascript:openStafftransferAddDiglog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
	<a href="javascript:openStafftransferModifyDiglog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
	<a href="javascript:deleteStafftransfer()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
	<a href="javascript:findLackInfo()" class="easyui-linkbutton" iconCls="icon-search" plain="true">查看职务缺员信息</a>
 </div>
 <div>
 	&nbsp;员工信息(编号/姓名):&nbsp;<input type="text" id="employerId" size="20" onkeydown="if(event.keyCode==13) searchStafftransfer()"/>
 	<a href="javascript:searchStafftransfer()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
 </div>
</div>
<div id="dlg" class="easyui-dialog" style="width: 620px;height: 335px;padding: 10px 20px" closable: false closed="true" buttons="#dlg-buttons">
 
 	<form id="form" method="post">
 		<table cellpadding="8px">
 			<tr>
 				<td>员工编号：</td>
 				<td colspan="4">
 					<input type="text" id="employerid" name="employerId" class="easyui-validatebox" required="true"/>
 				</td>
 			</tr>
 			<tr>
 				<td>新职务：</td>
 				<td colspan="4">
 					<input  id="newJob" name="newJob" class="easyui-combobox" data-options="panelHeight:'auto',valueField:'dutyName',textField:'dutyName',url:'${pageContext.request.contextPath}/duty/dutyComboList.do'" value="请选择..."/>
 					<!-- <input type="text" id="newJob" name="newJob" class="easyui-validatebox" required="true"/> -->
 				</td>
 			</tr>
 			<tr>
 				<td>调动时间：</td>
 				<td>
 					<input type="date" id="staffTime" name="staffTime" class="easyui-validatebox" required="true"/>
 				</td>
 			</tr>
 			<tr>
 				<td>调动原因：</td>
 				<td>
 					<input type="text" id="staffReason" name="staffReason" class="easyui-validatebox" required="true"/>
 				</td>
 			</tr>
 		</table>
 	</form>
</div>
<div id="dlg-buttons">
	<a href="javascript:checkData()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
	<a href="javascript:closeStafftransferDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>

<div id="dlgInfo" class="easyui-dialog" style="width: 620px;height: 335px;padding: 10px 20px" closable="false"  closed="true" buttons="#dlgInfo-buttons">
 
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
 				<td>状态：</td>
 				<td>
 					<input type="text" id="status" name="status" class="easyui-validatebox" required="true"/>
 				</td>
 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
 				<td>入职时间：</td>
 				<td>
 					<input type="date" id="startTime" name="startTime" class="easyui-validatebox" required="true"/>
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
<div id="dlgInfo-buttons">
	<a href="javascript:closeInfoDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>


<div id="dlgLackInfo" class="easyui-dialog" style="width: 400px;height: 500px;padding: 10px 20px" closable: false closed="true">
<table id="dgLackInfo"  class="easyui-datagrid"
  fitColumns="true" pagination="true" rownumbers="true"
  url="${pageContext.request.contextPath}/duty/list.do"  fit="true">
 <thead>
 	<tr>
 		<th field="dutyName" width="80" align="center">职务名称</th>
 		<th field="fixNum" width="80" align="center">定员人数</th>
 		<th field="lackNum" width="80" align="center">缺员人数</th>
 	</tr>
 </thead>
</table>
</div>
</body>
</html>