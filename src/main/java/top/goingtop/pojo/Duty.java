package top.goingtop.pojo;
/**
 * 职务实体类
 * @author cheng
 *
 */
public class Duty {

	private Integer id;//职务编号
	private String dutyName;//职务名称
	private Integer fixNum;//定员人数
	private Integer lackNum;//缺员人数
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getDutyName() {
		return dutyName;
	}
	public void setDutyName(String dutyName) {
		this.dutyName = dutyName;
	}
	public Integer getFixNum() {
		return fixNum;
	}
	public void setFixNum(Integer fixNum) {
		this.fixNum = fixNum;
	}
	public Integer getLackNum() {
		return lackNum;
	}
	public void setLackNum(Integer lackNum) {
		this.lackNum = lackNum;
	}
	
	
}
