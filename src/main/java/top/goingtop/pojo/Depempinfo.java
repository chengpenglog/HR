package top.goingtop.pojo;
/**
 * 部门实体类
 * @author cheng
 *
 */
public class Depempinfo {

	private String id;//编号
	private int fixationNum;//定员人数
	private int lackNum;//缺员人数
	private String lackDep;//缺员部门
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getFixationNum() {
		return fixationNum;
	}
	public void setFixationNum(int fixationNum) {
		this.fixationNum = fixationNum;
	}
	public int getLackNum() {
		return lackNum;
	}
	public void setLackNum(int lackNum) {
		this.lackNum = lackNum;
	}
	public String getLackDep() {
		return lackDep;
	}
	public void setLackDep(String lackDep) {
		this.lackDep = lackDep;
	}
	
}
