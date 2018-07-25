<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户登录</title>
<link rel="icon" href="favicon.ico" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
	function submitData(){
		$("#fm").form("submit",{
			url:"${pageContext.request.contextPath}/membership/login.do",
			/* onSubmit实现对表单进行验证再进行提交 */
			onSubmit:function(){
				if($("#groupId").combobox("getValue")=="-1"){
					$.messager.alert("系统提示","请选择用户角色！");
					return false;
				}
				return $(this).form("validate");
			},
			success:function(result){
				var result=eval('('+result+')');
				/* console.log('result：',result); */
				if(result.success){
					window.location.href="${pageContext.request.contextPath}/main.jsp";
				}else{
					$.messager.alert("系统提示",result.errorInfo);
					return;
				}
			}
		});
	}

	function resetValue(){
		$("#userName").val("");
		$("#password").val("");
		$("#groupId").combobox("setValue","");
	}
	
	function openUserRegisterDiglog(){
		$("#dlg").dialog("open").dialog("setTitle","用户注册");
	}
	
	function checkData(){
		if($("#id").val()==''){
			$.messager.alert("系统系统","请输入用户名！");
			$("#id").focus();
			return;
		}
		$.post("${pageContext.request.contextPath}/user/existUserName.do",{userName:$("#id").val()},function(result){
			if(result.exist){
				$.messager.alert("系统系统","该用户名已存在，请更换下！");
				$("#id").focus();
			}else{
				saveUser();
			}
		},"json");
	}
	function saveUser(){
		$("#fmRegister").form("submit",{
			url:'${pageContext.request.contextPath}/user/register.do',
			onSubmit:function(){
				return $(this).form("validate");
			},
			success:function(result){
				var result=eval('('+result+')');
				if(result.success){
					$.messager.alert("系统系统","保存成功！");
					resetValue();
					$("#dlg").dialog("close");
				}else if(result.checkedWorker){
					$.messager.alert("系统系统","您的员工编号有误！");
					return;
				}else{
					$.messager.alert("系统系统","保存失败！");
					return;
				}
			}
		});
	}
	function resetValue(){
		$("#id").val("");
		$("#password").val("");
	}
	function closeUserRegisterDiglog() {
		$("#dlg").dialog("close");
		resetValue();
	}
</script>

</head>
<body>
<div style="position: absolute;width: 100%;height: 100%;z-index: -1;left: 0;top: 0">
	<img src="${pageContext.request.contextPath}/static/images/login_bg.jpg" width="100%" height="100%" style="left: 0;top: 0;">
</div>
<div class="easyui-window" title="人力资源请假系统" data-options="modal:true,closable:false,maximizable:false,minimizable:false,collapsible:false" style="width: 400px;height: 280px;">
	<form id="fm" action="" method="post">
		<table cellpadding="6px" align="center">
			<tr align="center">
				<th colspan="2" style="padding-bottom: 10px;"><big>用户登录</big></th>
			</tr>
			<tr>
				<td>用户名:</td>
				<td>
					<input type="text" id="userName" name="userName" class="easyui-validatebox" required="true" style="width: 200px"/>
				</td>
			</tr>
			<tr>
				<td>密码：</td>
				<td>
					<input type="password" id="password" name="password" class="easyui-validatebox" required="true" style="width: 200px"/>
				</td>
			</tr>
			<tr>
				<td>角色：</td>
				<td>
					<input  id="groupId" name="groupId" class="easyui-combobox" data-options="panelHeight:'auto',valueField:'id',textField:'name',url:'${pageContext.request.contextPath}/group/groupComboList.do'" value="-1"/>
				</td>
			</tr>
			<tr>
				<td colspan="2"></td>
			</tr>
			<tr>
				<td colspan="2">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="javascript:openUserRegisterDiglog()" type="">没有账号,点击注册</a>
				</td>
			</tr>
			<tr>
				<td></td>
				<td>
					<a href="javascript:submitData()" class="easyui-linkbutton" iconCls="icon-submit">登录</a>&nbsp;
					<a href="javascript:resetValue()" class="easyui-linkbutton" iconCls="icon-reset">重置</a>
				</td>
			</tr>
		</table>
	</form>
</div>

<div id="dlg" class="easyui-dialog"  modal="true" style="width: 300px;height: 300px;padding: 10px 20px" closable="false" closed="true" buttons="#dlg-buttons">
 
 	<form id="fmRegister" method="post">
 		<table cellpadding="8px">
 			<tr>
 				<td>用户名：</td>
 				<td>
 					<input type="text" id="id" name="id" class="easyui-validatebox" required="true" data-options="prompt:'请输入您的员工编号'"/>
 				</td>
 			</tr>
 			<tr>
 				<td>密码：</td>
 				<td>
 					<input type="password" id="password" name="password" class="easyui-validatebox" required="true"/>
 				</td>
 			</tr>
 		</table>
 	</form>
</div>
<div id="dlg-buttons">
	<a href="javascript:checkData()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
	<a href="javascript:closeUserRegisterDiglog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>
</body>
</html>