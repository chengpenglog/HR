<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>职务管理</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">

	function searchDuty(){
		$("#dg").datagrid('load',{
			"dutyName":$("#s_dutyName").val()
		});
	}
	
	function deleteDuty(){
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
				$.post("${pageContext.request.contextPath}/duty/delete.do",{ids:ids},function(result){
					if(result.success){
						$.messager.alert("系统提示","数据已经成功删除！");
						$("#dg").datagrid("reload");
					}else if (result.used) {
						$.messager.alert("系统提示","该职务已有权限,如需删除,请先移出使用的权限!");
					}else{
						$.messager.alert("系统提示","数据删除失败，请联系运维！");
					}
				},"json");
			}
		});
	}
	
	
	function openDutyAddDiglog(){
		$("#dlg").dialog("open").dialog("setTitle","添加职务信息");
		$("#flag").val(1);
	}
	
	function openDutyModifyDiglog(){
		var selectRows=$("#dg").datagrid("getSelections");
		if(selectRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectRows[0];
		$("#dlg").dialog("open").dialog("setTitle","编辑职务信息");
		$("#fm").form("load",row);
		$("#flag").val(2);
	}
	
	
	function checkData(){
		console.log(flag);
		if($("#dutyName").val()==''){
			$.messager.alert("系统系统","请输入职务名！");
			$("#dutyName").focus();
			return;
		}
		var flag=$("#flag").val();
		if(flag==1){
			$.post("${pageContext.request.contextPath}/duty/existDutyName.do",{dutyName:$("#dutyName").val()},function(result){
				if(result.exist){
					$.messager.alert("系统系统","该职务名已存在，请更换！");
					$("#dutyName").focus();
				}else{
					saveDuty();
				}
			},"json");
		}else{
			saveDuty();
		}
	}
	
	function saveDuty(){
		var flag=$("#flag").val();
		$("#fm").form("submit",{
			url:'${pageContext.request.contextPath}/duty/save.do',
			onSubmit:function(){
				return $(this).form("validate");
			},
			success:function(result){
				var result=eval('('+result+')');
				if(result.success){
					$.messager.alert("系统系统","保存成功！");
					resetValue();
					$("#dlg").dialog("close");
					$("#dg").datagrid("reload");
				}else{
					$.messager.alert("系统系统","保存失败！");
					return;
				}
			}
		});
	}
	
	function resetValue(){
		$("#dutyName").val("");
		$("#id").val("");
		$("#fixNum").val("");
		$("#lackNum").val("");
	}
	
	function closeDutyDialog(){
		$("#dlg").dialog("close");
		resetValue();
	}

</script>
</head>
<body style="margin: 1px">
<table id="dg" title="职务管理" class="easyui-datagrid"
  fitColumns="true" pagination="true" rownumbers="true"
  url="${pageContext.request.contextPath}/duty/list.do" fit="true" toolbar="#tb">
 <thead>
 	<tr>
 		<th field="cb" checkbox="true" align="center"></th>
 		<th field="id" width="80" align="center">职务编号</th>
 		<th field="dutyName" width="80" align="center">职务名称</th>
 		<th field="fixNum" width="80" align="center">定员人数</th>
 		<th field="lackNum" width="80" align="center">缺员人数</th>
 	</tr>
 </thead>
</table>
<div id="tb">
 <div>
	<a href="javascript:openDutyAddDiglog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
	<a href="javascript:openDutyModifyDiglog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
	<a href="javascript:deleteDuty()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
 </div>
 <div>
 	&nbsp;职务名：&nbsp;<input type="text" id="s_dutyName" size="20" onkeydown="if(event.keyCode==13) searchDuty()"/>
 	<a href="javascript:searchDuty()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
 </div>
</div>

<div id="dlg" class="easyui-dialog" style="width: 300px;height: 300px;padding: 10px 20px" closed="true" buttons="#dlg-buttons">
 
 	<form id="fm" method="post">
 		<table cellpadding="8px">
 			<tr>
 				<td>职务名称：</td>
 				<td>
 					<input type="hidden" id="id" name="id"/>
 					<input type="text" id="dutyName" name="dutyName" class="easyui-validatebox" required="true"/>
 					<input type="hidden" id="flag" name="flag"/>
 				</td>
 			</tr>
 			<tr>
 				<td>定员人数：</td>
 				<td>
 					<input type="text" id="fixNum" name="fixNum" class="easyui-validatebox" required="true"/>
 				</td>
 			</tr>
 			<tr>
 				<td>缺员人数：</td>
 				<td>
 					<input type="text" id="lackNum" name="lackNum" class="easyui-validatebox" required="true"/>
 				</td>
 			</tr>
 		</table>
 	</form>
 
</div>
<div id="dlg-buttons">
	<a href="javascript:checkData()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
	<a href="javascript:closeDutyDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>
</body>
</html>