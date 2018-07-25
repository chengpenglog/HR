package top.goingtop.pojo;

/**
 * 人事调动实体类
 * @author cheng
 */
public class Stafftransfer {
    private Integer id;//编号
    private String employerId;//员工编号
    private String oldJob;//原职务
    private String newJob;//新职务
    private String staffTime;//调动时间
    private String staffReason;//调动原因
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
	public String getOldJob() {
		return oldJob;
	}
	public void setOldJob(String oldJob) {
		this.oldJob = oldJob;
	}
	public String getNewJob() {
		return newJob;
	}
	public void setNewJob(String newJob) {
		this.newJob = newJob;
	}
	public String getStaffTime() {
		return staffTime;
	}
	public void setStaffTime(String staffTime) {
		this.staffTime = staffTime;
	}
	public String getStaffReason() {
		return staffReason;
	}
	public void setStaffReason(String staffReason) {
		this.staffReason = staffReason;
	}
	
}