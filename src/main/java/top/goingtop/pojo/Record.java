package top.goingtop.pojo;
/**
 * 档案实体类
 * @author cheng
 *
 */
public class Record {
    private Integer id;//档案编号
    private String employerId;//员工编号
    private String recordName;//档案名称
    private String content;//内容摘要
    private String remark;//备注
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getEmployerId() {
		return employerId;
	}

	public void setEmployerId(String employerId) {
		this.employerId = employerId;
	}

	public String getRecordName() {
		return recordName;
	}

	public void setRecordName(String recordName) {
		this.recordName = recordName;
	}

	public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}