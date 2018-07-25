package top.goingtop.pojo;
/**
 * 考勤实体类
 * @author cheng
 *
 */
public class Check {
    private Integer id;//编号
    private String employerId;//员工编号
    private String type;//类型（迟到、旷工、请假、加班、出差、调班、停工）
    private Integer money;//奖惩金额
    private String checkTime;//考勤记录时间
    
    private String startSearch;//开始时间
	private String endSearch;//结束时间
	public String getStartSearch() {
		return startSearch;
	}
	public void setStartSearch(String startSearch) {
		this.startSearch = startSearch;
	}
	public String getEndSearch() {
		return endSearch;
	}
	public void setEndSearch(String endSearch) {
		this.endSearch = endSearch;
	}
    
    private String startMonth;//月初
    private String endMonth;//月末
    private Integer flag;
    public Integer getFlag() {
		return flag;
	}

	public void setFlag(Integer flag) {
		this.flag = flag;
	}

	public String getStartMonth() {
		return startMonth;
	}

	public void setStartMonth(String startMonth) {
		this.startMonth = startMonth;
	}
	public String getEndMonth() {
		return endMonth;
	}

	public void setEndMonth(String endMonth) {
		this.endMonth = endMonth;
	}

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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Integer getMoney() {
		return money;
	}

	public void setMoney(Integer money) {
		this.money = money;
	}

	public String getCheckTime() {
		return checkTime;
	}

	public void setCheckTime(String checkTime) {
		this.checkTime = checkTime;
	}

}