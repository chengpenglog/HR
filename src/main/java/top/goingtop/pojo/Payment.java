package top.goingtop.pojo;


public class Payment {
    private Integer id;//编号
    private String employerId;//员工编号
    private Integer baseSalary;//基本工资
    private Integer performanceSalary;//绩效工资
    private Integer bonus;//奖金
    private Integer fine;//罚款
    private Integer paymentNum;//薪酬数目
    private String paymentTime;//获薪时间
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

	public Integer getBaseSalary() {
		return baseSalary;
	}

	public void setBaseSalary(Integer baseSalary) {
		this.baseSalary = baseSalary;
	}

	public Integer getPerformanceSalary() {
		return performanceSalary;
	}

	public void setPerformanceSalary(Integer performanceSalary) {
		this.performanceSalary = performanceSalary;
	}

	public Integer getBonus() {
		return bonus;
	}

	public void setBonus(Integer bonus) {
		this.bonus = bonus;
	}

	public Integer getFine() {
		return fine;
	}

	public void setFine(Integer fine) {
		this.fine = fine;
	}

	public Integer getPaymentNum() {
		return paymentNum;
	}

	public void setPaymentNum(Integer paymentNum) {
		this.paymentNum = paymentNum;
	}

	public String getPaymentTime() {
		return paymentTime;
	}

	public void setPaymentTime(String paymentTime) {
		this.paymentTime = paymentTime;
	}

}