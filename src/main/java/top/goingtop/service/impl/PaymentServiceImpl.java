package top.goingtop.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import top.goingtop.dao.PaymentDao;
import top.goingtop.pojo.Payment;
import top.goingtop.service.PaymentService;
@Service("paymentService")
public class PaymentServiceImpl implements PaymentService{

	@Resource
	private PaymentDao paymentDao;
	@Override
	public Payment findById(Integer id) {
		return paymentDao.findById(id);
	}

	@Override
	public List<Payment> find(Map<String, Object> map) {
		return paymentDao.find(map);
	}

	@Override
	public Long getTotal(Map<String, Object> map) {
		return paymentDao.getTotal(map);
	}

	@Override
	public int delete(Integer id) {
		return paymentDao.delete(id);
	}

	@Override
	public int update(Payment payment) {
		return paymentDao.update(payment);
	}

	@Override
	public int add(Payment payment) {
		return paymentDao.add(payment);
	}

}
