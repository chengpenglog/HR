<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>薪酬记录管理</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
	var url;
	function searchCheck(){
		$("#dg").datagrid('load',{
			"employerId":$("#employerid").val()
		});
	}
</script>
</head>
<body style="margin: 1px">
<table id="dg" title="用户管理" class="easyui-datagrid"
  fitColumns="true" pagination="true" rownumbers="true"
  url="${pageContext.request.contextPath}/payment/listByUserId.do?userId=${currentMemberShip.user.id}" fit="true" toolbar="#tb">
 <thead>
 	<tr>
 		<th field="cb" checkbox="true" align="center"></th>
 		<th field="id" width="40" align="center">编号</th>
 		<th field="baseSalary" width="80" align="center">基本工资</th>
 		<th field="performanceSalary" width="100" align="center">绩效工资</th>
 		<th field="fine" width="100" align="center">奖金</th>
 		<th field="bonus" width="80" align="center">罚款</th>
 		<th field="paymentNum" width="100" align="center">薪酬数目</th>
 		<th field="paymentTime" width="100" align="center">获薪时间</th>
 	</tr>
 </thead>
</table>
<div id="tb">
 <div>
 	&nbsp;员工信息(编号/姓名):&nbsp;<input type="text" id="employerid" size="20" onkeydown="if(event.keyCode==13) searchCheck()"/>
 	<a href="javascript:searchCheck()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
 </div>
</div>
</body>
</html>