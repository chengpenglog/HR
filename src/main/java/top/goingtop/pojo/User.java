package top.goingtop.pojo;

public class User {

	private String id;
	private String password;
	private String groups;//用户拥有的角色(多个角色用逗号隔开)
	public String getGroups() {
		return groups;
	}
	public void setGroups(String groups) {
		this.groups = groups;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
}
