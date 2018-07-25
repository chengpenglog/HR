<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>招聘管理页面</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">

	function searchCheck(){
		$("#dg").datagrid('load',{
			"userName":$("#find_name").val(),
	     	"job":$("#find_job").val(),
	     	"recStatus":$("#find_type").combobox("getValue")
		});
	}
    function formatAction(val,row){
        if(row.recStatus=="面试过"){
   			return "<a href='javascript:openEmployerAddTab()'>添加员工信息</a>";
        }
         if(row.recStatus=="签约完成"){
       		 return "<a href='javascript:openEmployerInfo()'>查看员工详情</a>";
        }
    }
     
     function openEmployerAddTab(){
    	var selectedRows=$("#dg").datagrid("getSelections");
     	var row=selectedRows[0];
    	$("#dlg2").dialog("open").dialog("setTitle","添加员工信息");
    	$("#form").form("load",row);
 		url="${pageContext.request.contextPath}/recruit/saveEmployer.do";
 	 }
     function openEmployerInfo() {
    	resetEmployerValue();
    	$("#dlg2").dialog("open").dialog("setTitle","查看员工信息");
    	var selectedRows=$("#dg").datagrid("getSelections");
     	var row=selectedRows[0];
     	//$("#form").form("load",row);
   		$.post("${pageContext.request.contextPath}/recruit/findEmployer.do?recId="+row.recId,function(result){
   			console.log(result);
	   		$("#id").val(result.employer.id);
			$("#e_userName").val(result.employer.userName);
			$("#e_sex").val(result.employer.sex);
			$("#e_birthday").val(result.employer.birthday);
			$("#e_tel").val(result.employer.tel);
			$("#e_email").val(result.employer.email);
			$("#major").val(result.employer.major);
			$("#dep").val(result.employer.dep);
			$("#e_job").val(result.employer.job);
			$("#startTime").val(result.employer.startTime);
			$("#status").val(result.employer.status);
			$("#e_remark").val(result.employer.remark);
   		},"json");
	}
     function saveEmployer(){
 		$("#form").form("submit",{
 			url:url,
 			onSubmit:function(){
 				return $(this).form("validate");
 			},
 			success:function(result){
 				var result=eval('('+result+')');
 				if(result.success){
 					$.messager.alert("系统提示","保存成功！");
 					resetEmployerValue();
 					$("#dlg2").dialog("close");
 					$("#dg").datagrid("reload");
 				}else{
 					$.messager.alert("系统提示","保存失败！");
 					return;
 				}
 			}
 		});
 	}
     function closeDialog(){
    	 resetEmployerValue();
 		$("#dlg2").dialog("close");
 		$("#dg").datagrid("reload");
 	}
     function resetEmployerValue(){
    	$("#employerId").val("");
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
 	}
	function openModifyTab(){
		var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要修改的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#dlg").dialog("open").dialog("setTitle","修改档案信息");
		$("#fm").form("load",row);
		url="${pageContext.request.contextPath}/recruit/save.do?id="+row.id;
	}
	
	function openAddTab(){
		$("#dlg").dialog("open").dialog("setTitle","添加应聘者记录");
		url="${pageContext.request.contextPath}/recruit/save.do";
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
			strIds.push(selectRows[i].id);
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
		$("#recId").val("");
		$("#userName").val("");
		$("#sex").val("");
		$("#email").val("");
		$("#birthday").val("");
		$("#state").combobox("setValue","");
		$("#tel").val("");
		$("#remark").val("");
	}
	
	
</script>
</head>
<body style="margin: 0px">
<table id="dg" title="员工档案管理" class="easyui-datagrid" 
  fitColumns="true" pagination="true" rownumbers="true"
  url="${pageContext.request.contextPath}/recruit/listRecruit.do" fit="true" toolbar="#tb">
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
  		<th field="recStatus" width="40" align="center">应聘状态</th>
  		<th field="remark" width="40" align="center">备注</th>
  		<th field="action" width="50" align="center" align="center" formatter="formatAction">操作</th>
  	 </tr>
  </thead>
</table>
<div id="tb">
	<div>
		<a href="javascript:openModifyTab()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
		<a href="javascript:deleteData()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
	</div>
	<div>
	    &nbsp;姓名&nbsp;<input type="text" id="find_name" size="20" onkeydown="if(event.keyCode==13) searchCheck()"/>
		&nbsp;应聘职位&nbsp;<input type="text" id="find_job" size="20" onkeydown="if(event.keyCode==13) searchCheck()"/>
		&nbsp;应聘状态&nbsp;<select class="easyui-combobox" id="find_type" edatible="false" panelHeight="auto" onkeydown="if(event.keyCode==13) searchCheck()">  
							    <option value="">请选择...</option>
							    <option value="未接受">未接受</option> 
							    <option value="笔试过">笔试过</option>   
							    <option value="面试过">面试过</option>   
							    <option value="签约完成">签约完成</option>    
							</select>  
		<a href="javascript:searchCheck()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
	</div>
</div>

<div id="dlg" class="easyui-dialog" style="width: 600px;height: 300px;padding: 10px 20px" closed="true" buttons="#dlg-buttons">
	<form id="fm" method="post">
	<table cellspacing="8px">
			<tr>
				<td>姓名：</td>
				<td>
					<input type="hidden" id="recId" name="recId"/>
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
			    <td>应聘状况：</td>
			    <td>
			     <select id="recStatus" name="recStatus" edatible="false" panelHeight="auto">   
				    <option value="">请选择...</option>
				    <option value="未接受">未接受</option> 
				    <option  value="笔试过">笔试过</option>   
				    <option  value="面试过">面试过</option>   
				    <option  value="签约完成">签约完成</option>   	
				</select>
				</td>
				<td>备注：</td>
				<td>
					<input type="text" id="remark" name="remark" class="easyui-validatebox"   />
				</td>
			</tr>	    
		</table>
	</form>
</div>

<div id="dlg2" class="easyui-dialog" style="width: 600px;height: 350px;padding: 10px 20px" closed="true" buttons="#dlg-buttons2">
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
 					<input type="text" id="e_userName" name="userName" class="easyui-validatebox" required="true"/>
 				</td>
 			</tr>
 			<tr>
 				<td>性别：</td>
 				<td>
 					<input type="text" id="e_sex" name="sex" class="easyui-validatebox" required="true"/>
 				</td>
 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
 				<td>出生日期：</td>
 				<td>
 					<input type="date" id="e_birthday" name="birthday" class="easyui-validatebox" required="true"/>
 				</td>
 			</tr>
 			<tr>
 				<td>电话号码：</td>
 				<td>
 					<input type="text" id="e_tel" name="tel" class="easyui-validatebox" required="true"/>
 				</td>
 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
 				<td>邮箱：</td>
 				<td>
 					<input type="text" id="e_email" name="email" class="easyui-validatebox" required="true"/>
 				</td>
 			</tr>
 			<tr>
 				<td>学历：</td>
 				<td>
 					<input type="text" id="major" name="major" class="easyui-validatebox" required="true"/>
 				</td>
 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
 				<td>部门：</td>
 				<td>
 					<input type="text" id="dep" name="dep" class="easyui-validatebox" required="true"/>
 				</td>
 			</tr>
 			<tr>
 				<td>职位：</td>
 				<td>
 					<input type="text" id="e_job" name="job" class="easyui-validatebox" required="true"/>
 				</td>
 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
 				<td>入职时间：</td>
 				<td>
 					<input type="date" id="startTime" name="startTime" class="easyui-validatebox" required="true"/>
 				</td>
 			</tr>
 			<tr>
 				<td>状态：</td>
 				<td>
 					<input type="text" id="status" name="status" class="easyui-validatebox" required="true"/>
 				</td>
 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
 				<td>备注：</td>
 				<td>
 					<input type="text" id="e_remark" name="remark" class="easyui-validatebox" required="true"/>
 					<input type="hidden" id="recId" name="recId"/>
 				</td>
 			</tr>
 		</table>
 	</form>
</div>
<div id="dlg-buttons">
	<a href="javascript:saveInterview()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
	<a href="javascript:closeInterview()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>
<div id="dlg-buttons2">
	<a href="javascript:saveEmployer()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
	<a href="javascript:closeDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>

</body>
</html>
