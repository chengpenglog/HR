package top.goingtop.pojo;

public class TrainInfo {

	private int id;//培训信息编号
	private String type;//培训类别：岗前培训，在职培训
	private String employerId;//员工编号
	private String trainContent;//培训内容
	private String startTime;//培训开始时间
	private String endTime;//培训结束时间
	
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
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getEmployerId() {
		return employerId;
	}
	public void setEmployerId(String employerId) {
		this.employerId = employerId;
	}
	public String getTrainContent() {
		return trainContent;
	}
	public void setTrainContent(String trainContent) {
		this.trainContent = trainContent;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
}
