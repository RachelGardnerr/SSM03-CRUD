package com.ssm.serivce;

import com.ssm.dao.EmployeeMapper;
import com.ssm.domain.Employee;
import com.ssm.domain.EmployeeExample;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class EmployeeService {

    @Resource
    private EmployeeMapper employeeMapper;

    public int deleteById(Integer id){
        return employeeMapper.deleteByPrimaryKey(id);
    }

    /**
     * 获取所有员工
     * @return
     */
    public List<Employee> getAll(){
        return employeeMapper.selectByExampleWithDept(null);
    }

    /**
     * 添加员工
     * @param employee
     * @return
     */
    public int insertEmpDATA(Employee employee){
        return employeeMapper.insertSelective(employee);
    }

    /**
     *
     * @param empName
     * @return cont == 0
     *          true 库中没有名为empName的记录
     */
    public boolean checkUser(String empName) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long cont = employeeMapper.countByExample(example);
        return cont == 0;
    }

    /**
     * 查询员工
     * @param id
     * @return
     */
    public Employee getEmp(Integer id){
        return employeeMapper.selectByPrimaryKey(id);
    }

    public int updateEmp(Employee employee){
        return employeeMapper.updateByPrimaryKeySelective(employee);
    }

    public void deleteBatch(List<Integer> ids) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(example);
    }
}
