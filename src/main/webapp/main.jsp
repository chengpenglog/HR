<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="top.goingtop.util.MD5Util" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>人力资源管理系统-主页面</title>
<%
	// 权限验证
	if(session.getAttribute("currentMemberShip")==null){
		response.sendRedirect("login.jsp");
		return;
	}
%>
<link rel="icon" href="favicon.ico" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
	
	var url;
	
	function openTab(text,url,iconCls){
		if($("#tabs").tabs("exists",text)){
			$("#tabs").tabs("select",text);
		}else{
			var content="<iframe frameborder=0 scrolling='auto' style='width:100%;height:100%' src='${pageContext.request.contextPath}/page/"+url+"'></iframe>";
			$("#tabs").tabs("add",{
				title:text,
				iconCls:iconCls,
				closable:true,
				content:content
			});
		}
	}
	function openPasswordModifyDialog(){
		url="${pageContext.request.contextPath}/user/modifyPassword.do?id=${currentMemberShip.user.id}";
		$("#dlg").dialog("open").dialog("setTitle","修改密码");
	}
	
	function modifyPassword(){
		$("#fm").form("submit",{
			url:url,
			onSubmit:function(){
				var newPassword=$("#newPassword").val();
				var reNewPassword=$("#reNewPassword").val();
				if(!$(this).form("validate")){
					return false;
				}
				if(newPassword!=reNewPassword){
					$.messager.alert("系统提示","确认密码输入错误！");
					return false;
				}
				return true;
			},
			success:function(result){
				var result=eval('('+result+')');
				if(result.success){
					$.messager.alert("系统提示","密码修改成功,下一次登录失效！");
					resetValue();
					$("#dlg").dialog("close");
				}else if (result.chickPassword) {
					$.messager.alert("系统提示","原密码错误!！");
				}else{
					$.messager.alert("系统提示","密码修改失败！");
					return;
				}
			}
		});

	}
		
	function resetValue(){
		$("#oldPassword").val("");
		$("#newPassword").val("");
		$("#reNewPassword").val("");
	}
	
	function closePasswordModifyDialog(){
		resetValue();
		$("#dlg").dialog("close");
	}
	
	function logout(){
		$.messager.confirm("系统提示","您确定要退出系统吗?",function(r){
			if(r){
				window.location.href='${pageContext.request.contextPath}/user/logout.do';
			}
		});
	}
	
</script>
</head>
<body class="easyui-layout">
<div region="north" style="height: 78px;background-color: #E0ECFF">
 <table style="padding: 5px;" width="100%">
 	<tr>
 		<td width="50%">
 			<img src="${pageContext.request.contextPath}/static/images/logo.png"/>
 		</td>
 		<td valign="bottom" align="right" width="50%">
 			<font size="3">&nbsp;&nbsp;<strong>欢迎：</strong>${currentMemberShip.user.id}【${currentMemberShip.group.name}】</font>
 		</td>
 	</tr>
 </table>
</div>
<div region="center" >
	<div class="easyui-tabs" fit="true" border="false" id="tabs">
		<div title="首页" data-options="iconCls:'icon-home'">
			<div align="center" style="padding-top: 200px;"><font color="red" size="10" face="楷体">欢迎使用人事管理系统</font></div>
		</div>
	</div>
</div>
<div region="west" style="width: 200px;" title="导航菜单" split="true">
	<div class="easyui-accordion" data-options="fit:true,border:false">
		<div title="安全管理"  data-options="selected:true,iconCls:'icon-system'" style="padding:10px">
			<a href="javascript:openPasswordModifyDialog()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-modifyPassword'" style="width: 150px;">密码维护</a>
			<a href="javascript:logout()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-exit'" style="width: 150px;">安全退出</a>
		</div>
		<c:if test="${currentMemberShip.group.name=='管理员' }">
		<div title="系统管理"  data-options="iconCls:'icon-sys'" style="padding:10px;">
			<a href="javascript:openTab('用户管理','userManage.jsp','icon-user')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-user'" style="width: 150px">用户管理</a>
				<a href="javascript:openTab('角色管理','groupManage.jsp','icon-role')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-role'" style="width: 150px">角色管理</a>
				<a href="javascript:openTab('用户权限管理','authManage.jsp','icon-power')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-power'" style="width: 150px">用户权限管理</a>
		</div>
		<div title="员工信息" data-options="iconCls:'icon-edit'" style="padding: 10px">
			<a href="javascript:openTab('员工基本信息','employerBaseInfo.jsp','icon-user')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-user'" style="width: 150px">员工基本管理</a>
			<a href="javascript:openTab('员工档案管理','employerFileManage.jsp','icon-role')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-role'" style="width: 150px">员工档案管理</a>
			<a href="javascript:openTab('员工合同管理','employerContractManage.jsp','icon-power')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-power'" style="width: 150px">员工合同管理</a>
		</div>
		</c:if>
		<c:if test="${currentMemberShip.group.name=='领导层' }">
		<div title="人事调配"  data-options="iconCls:'icon-flow'" style="padding:10px;">
			<a href="javascript:openTab('职务管理','dutyManage.jsp','icon-role')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-role'" style="width: 150px;">职务管理</a>
			<a href="javascript:openTab('人事调动管理','staffTransferManage.jsp','icon-deploy')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-deploy'" style="width: 150px;">人事调动管理</a>
		</div>
		<div title="教育培训"  data-options="iconCls:'icon-yewu'" style="padding:10px">
			<a href="javascript:openTab('培训类别维护','trainTypeManage.jsp','icon-apply')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-edit'" style="width: 150px">培训类别维护</a>
			<a href="javascript:openTab('培训信息','trainInfo.jsp','icon-apply')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-apply'" style="width: 150px">培训信息</a>
		</div>
		<div title="考勤管理" data-options="iconCls:'icon-check'" style="padding:10px">
			<a href="javascript:openTab('考勤记录','attendanceRecord.jsp','icon-daiban')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-daiban'" style="width: 150px;">考勤记录</a>
			<a href="javascript:openTab('薪酬记录','payrollRecord.jsp','icon-yiban')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-yiban'" style="width: 150px;">薪酬记录</a>
		</div>
		<div title="招聘管理" data-options="iconCls:'icon-task'" style="padding:10px">
			<a href="javascript:openTab('应聘信息','interview.jsp','icon-daiban')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-daiban'" style="width: 150px;">应聘信息</a>
			<a href="javascript:openTab('招聘记录','recruitInfo.jsp','icon-yiban')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-yiban'" style="width: 150px;">招聘记录</a>
		</div>
		</c:if>
		<c:if test="${currentMemberShip.group.name=='工人' }">
		<div title="考勤管理" data-options="iconCls:'icon-check'" style="padding:10px">
			<a href="javascript:openTab('考勤记录','workerAttendanceRecord.jsp','icon-daiban')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-daiban'" style="width: 150px;">考勤记录</a>
			<a href="javascript:openTab('薪酬记录','workerPayrollRecord.jsp','icon-yiban')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-yiban'" style="width: 150px;">薪酬记录</a>
		</div>
		</c:if>
	</div>
	
</div>
<div region="south" style="height: 26px;padding: 5px" align="center">
	Copyright &copy; 2018-2019 goingtop.top 版权所有
</div>

<div id="dlg" class="easyui-dialog" style="width: 400px;height: 250px;padding: 10px 20px" closed="true" buttons="#dlg-buttons">
 
 	<form id="fm" method="post">
 		<table cellpadding="8px">
 			<tr>
 				<td>用户名：</td>
 				<td>
 					<input type="text" id="userId" name="userId" readonly="readonly" value="${currentMemberShip.user.id }" style="width: 200px"/>
 				</td>
 			</tr>
 			<tr>
 				<td>原密码：</td>
 				<td>
 					<input type="password" id="oldPassword" name="oldPassword" class="easyui-validatebox" required="true" style="width: 200px"/>
 				</td>
 			</tr>
 			<tr>
 				<td>新密码：</td>
 				<td>
 					<input type="password" id="newPassword" name="newPassword" class="easyui-validatebox" required="true" style="width: 200px"/>
 				</td>
 			</tr>
 			<tr>
 				<td>用户名：</td>
 				<td>
 					<input type="password" id="reNewPassword" name="reNewPassword" class="easyui-validatebox" required="true" style="width: 200px"/>
 				</td>
 			</tr>
 		</table>
 	</form>
 
</div>

<div id="dlg-buttons">
	<a href="javascript:modifyPassword()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
	<a href="javascript:closePasswordModifyDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>

</body>
</html>