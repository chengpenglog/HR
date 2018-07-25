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
	function searchTrainType(){
		$("#dg").datagrid('load',{
			"type":$("#type").val()
		});
	}
	
	function deleteTrainType(){
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
				$.post("${pageContext.request.contextPath}/trainType/delete.do",{ids:ids},function(result){
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
	
	
	function openTrainTypeAddDiglog(){
		resetValue();
		$("#dlg").dialog("open").dialog("setTitle","添加培训类别信息");
    	url="${pageContext.request.contextPath}/trainType/save.do";
	}
	
	function openTrainTypeModifyDiglog(){
		var selectedRows=$("#dg").datagrid("getSelections");
    	if(selectedRows.length!=1){
    		$.messager.alert("系统提示","请选择一条要编辑的数据!");
    		return;
    	}
    	var row=selectedRows[0];
    	$("#dlg").dialog("open").dialog("setTitle","编辑培训类别信息");
    	$("#form").form("load",row);
    	url="${pageContext.request.contextPath}/trainType/save.do?id="+row.id;
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
		$("#traintype").val("");
		$("#remark").val("");
	}
	
	function closeTrainTypeDialog(){
		$("#dlg").dialog("close");
		resetValue();
	}
</script>
</head>
<body style="margin: 1px">
<table id="dg" title="用户管理" class="easyui-datagrid"
  fitColumns="true" pagination="true" rownumbers="true"
  url="${pageContext.request.contextPath}/trainType/list.do" fit="true" toolbar="#tb">
 <thead>
 	<tr>
 		<th field="cb" checkbox="true" align="center"></th>
 		<th field="id" width="40" align="center">培训类别编号</th>
 		<th field="type" width="100" align="center">培训类别</th>
 		<th field="remark" width="200" align="center">备注</th>
 	</tr>
 </thead>
</table>
<div id="tb">
 <div>
	<a href="javascript:openTrainTypeAddDiglog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
	<a href="javascript:openTrainTypeModifyDiglog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
	<a href="javascript:deleteTrainType()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
 </div>
 <div>
 	&nbsp;培训类别:&nbsp;<input type="text" id="type" size="20" onkeydown="if(event.keyCode==13) searchTrainType()"/>
 	<a href="javascript:searchTrainType()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
 </div>
</div>
<div id="dlg" class="easyui-dialog" style="width: 620px;height: 335px;padding: 10px 20px"closable: false closed="true" buttons="#dlg-buttons">
 
 	<form id="form" method="post">
 		<table cellpadding="8px">
 			<tr>
 				<td>培训类别：</td>
 				<td>
 					<input type="text" id="traintype" name="type" class="easyui-validatebox" required="true"/>
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
	<a href="javascript:closeTrainTypeDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>
</body>
</html>