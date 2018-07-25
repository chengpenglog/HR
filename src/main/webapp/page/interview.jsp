<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>应聘管理页面</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<style type="text/css">
	    #progressBar{width: 400px;height: 12px;background: #FFFFFF;border: 1px solid #000000;padding: 1px;}
		#progressBarItem{width: 30%;height: 100%;background:#87CEFA;}
		#div{size: 12px;}
</style>
<script type="text/javascript">
	function openModifyTab(){
		var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要修改的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#dlg").dialog("open").dialog("setTitle","修改档案信息");
		$("#fm").form("load",row);
		url="${pageContext.request.contextPath}/recruit/save.do?recId="+row.recId;
	}
	
	function openAddTab(){
		var data="未处理";
		$("#dlg").dialog("open").dialog("setTitle","添加应聘者信息");
		url="${pageContext.request.contextPath}/recruit/save.do?recStatus="+data;
	}
	function AddRecru(){
		var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择至少一条要添加的数据！");
			return;
		}
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].recId);
		}
		var ids=strIds.join(",");
		$.messager.confirm("系统提示","您确定要添加这条数据吗？",function(r){
			if(r){
				$.post("${pageContext.request.contextPath}/recruit/saves.do",{ids:ids,state:"笔试过"},function(result){
					if(result.success){
						$.messager.alert("系统提示","数据添加成功！");
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert("系统提示","数据添加失败！");
					}
				},"json");
			}
		});
		
	}

	function searchInterview(){
		$("#dg").datagrid('load',{
			"userName":$("#find_name").val(),
	     	"job":$("#find_job").val()
		});
	}
	function saveInterview(){
		$("#fm").form("submit",{
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
	
	function deleteData(){
		var selectRows=$("#dg").datagrid("getSelections");
		if(selectRows.length==0){
			$.messager.alert("系统提示","请选择要删除的数据！");
			return;
		}
		var strIds=[];
		for(var i=0;i<selectRows.length;i++){
			strIds.push(selectRows[i].recId);
		}
		var ids=strIds.join(",");
		$.messager.confirm("系统提示","您确定要删除这<font color=red>"+selectRows.length+"</font>条数据吗?",function(r){
			if(r){
				$.post("${pageContext.request.contextPath}/recruit/delete.do",{ids:ids},function(result){
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
	
	function closeInterview(){
		resetValue();
		$("#dlg").dialog("close");
		$("#dg").datagrid("reload");
	}
	function resetValue(){
		$("#userName").val("");
		$("#sex").val("");
		$("#email").val("");
		$("#birthday").val("");
		$("#job").val("");
		$("#tel").val("");
		$("#remark").val("");
	}
	
	
</script>
</head>
<body style="margin: 1px">
<table id="dg" title="应聘信息管理" class="easyui-datagrid" 
  fitColumns="true" pagination="true" rownumbers="true"
  url="${pageContext.request.contextPath}/recruit/listInterview.do" fit="true" toolbar="#tb">
  <thead>
  	<tr>
  		<th field="cb" checkbox="true" align="center"></th>
  		<th field="recId" width="20" align="center">编号</th>
  		<th field="userName" width="40" align="center">姓名</th>
  		<th field="sex" width="40" align="center">性别</th>
  		<th field="birthday" width="40" align="center">生日</th>
  		<th field="tel" width="40" align="center">电话</th>
  		<th field="email" width="40" align="center">邮箱</th>
  		<th field="job" width="40" align="center">工作</th>
  		<th field="remark" width="40" align="center">备注</th>
  	 </tr>
  </thead>
</table>
<div id="tb">
	<div>
	    <a href="javascript:openAddTab()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加应聘记录</a>
		<a href="javascript:openModifyTab()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
		<a href="javascript:deleteData()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
		 <a href="javascript:AddRecru()" class="easyui-linkbutton" iconCls="icon-add" plain="true">加入招聘记录</a>
	</div>
	<div>
	    &nbsp;姓名&nbsp;<input type="text" id="find_name" size="20" onkeydown="if(event.keyCode==13) searchInterview()"/>
		&nbsp;应聘职位&nbsp;<input type="text" id="find_job" size="20" onkeydown="if(event.keyCode==13) searchInterview()"/> 
		<a href="javascript:searchInterview()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
	</div>
</div>

<div id="dlg" class="easyui-dialog" style="width: 600px;height: 250px;padding: 10px 20px" closed="true" buttons="#dlg-buttons">
	<form id="fm" method="post">
	<table cellspacing="8px">
			<tr>
				<td>姓名：</td>
				<td>
					<input type="text" id="userName" name="userName" class="easyui-validatebox" required="true"/>
				</td>
			
				<td>性别：</td>
				<td>
					<input type="text" id="sex" name="sex" class="easyui-validatebox"  />
				</td>
			</tr>
			<tr>
				<td>生日：</td>
				<td>
					<input type="date" id="birthday" name="birthday" class="easyui-validatebox"  />
				</td>
			
				<td>电话：</td>
				<td>
					<input type="text" id="tel" name="tel" class="easyui-validatebox"  />
				</td>
			</tr>
			<tr>
				<td>邮箱：</td>
				<td>
					<input type="text" id="email" name="email" class="easyui-validatebox"  />
				</td>
			
				<td>应聘职位：</td>
				<td>
					<input type="text" id="job" name="job" class="easyui-validatebox"   />
				</td>
			</tr>
			<tr>
				<td>备注：</td>
				<td>
					<input type="text" id="remark" name="remark" class="easyui-validatebox"   />
				</td>
			</tr>	    
		</table>
	</form>
</div>


<div id="dlg-buttons">
	<a href="javascript:saveInterview()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
	<a href="javascript:closeInterview()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>

</body>
</html>
