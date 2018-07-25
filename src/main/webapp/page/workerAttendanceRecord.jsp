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
			"startSearch":$("#startSearch").val(),
			"endSearch":$("#endSearch").val()
		});
	}
	
</script>
</head>
<body style="margin: 1px">
<table id="dg" title="用户管理" class="easyui-datagrid"
  fitColumns="true" pagination="true" rownumbers="true"
  url="${pageContext.request.contextPath}/check/listByUserId.do?userId=${currentMemberShip.user.id}" fit="true" toolbar="#tb">
 <thead>
 	<tr>
 		<th field="cb" checkbox="true" align="center"></th>
 		<th field="id" width="40" align="center">编号</th>
 		<th field="type" width="80" align="center">类型</th>
 		<th field="money" width="100" align="center">奖惩金额</th>
 		<th field="checkTime" width="100" align="center">考勤记录时间</th>
 	</tr>
 </thead>
</table>
<div id="tb">
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
	 考勤时间：<input type="date" id="startSearch" size="20" onkeydown="if(event.keyCode==13) searchTrainInfo()"/>
 	&nbsp;至&nbsp;<input type="date" id="endSearch" size="20" onkeydown="if(event.keyCode==13) searchTrainInfo()"/>
 	<a href="javascript:searchCheck()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
 </div>
</div>
</body>
</html>