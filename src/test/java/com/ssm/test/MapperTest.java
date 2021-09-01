package com.ssm.test;

import com.ssm.dao.DeptMapper;
import com.ssm.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:conf/applicationContext.xml"})
public class MapperTest {

    @Autowired
    DeptMapper deptMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;

    @Test
    public void testCRUD() {
        System.out.println(deptMapper + "===================================");
//        deptMapper.insertSelective(new Dept(1,"开发部"));
//        employeeMapper.insertSelective(new Employee(null,"张三","M","zs@qq.com",1));
        employeeMapper.deleteByPrimaryKey(340);
//        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
//        for (int i = 0; i < 1000; i++) {
//            String uuid = UUID.randomUUID().toString().substring(0, 5) + i;
//            mapper.insertSelective(new Employee(null, uuid, "M", uuid + "@189.cn", 1));
//        }
//        System.out.println("批量完成 ");
    }

}
