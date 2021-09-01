package com.ssm.test;

import com.github.pagehelper.PageInfo;
import com.ssm.domain.Employee;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.Result;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.net.URLConnection;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:conf/applicationContext.xml","classpath:conf/dispatchServlet.xml"})
public class MvcTest {

//    虚拟mvc请求,获取到处理结果

    MockMvc mockMvc;
    //传入springmvc的ioc
    @Autowired
    WebApplicationContext context;

    @Before
    public void initMockMvc(){
         mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPageHelper() throws Exception {
        //模拟请求，拿到返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1")).andReturn();
        MockHttpServletRequest request = result.getRequest();
        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码"+pageInfo.getPageNum());
        System.out.println("总页码"+pageInfo.getPages());
        System.out.println("总记录数"+pageInfo.getTotal());
        System.out.println("在页面需要连续显示的页码");
        int[] nums = pageInfo.getNavigatepageNums();
        for (int i : nums) {
            System.out.println(" " + i);
        }
        System.out.println("获取员工数据");
        List<Employee> list = pageInfo.getList();
        for (Employee employee : list) {
            System.out.println(employee.getEmpId()+"\n"+employee.getEmpName()+"\n" + employee.getGender()
            +"\n" + employee.getEmail()+"\n" + employee.getdId());
        }

    }

    @Test
    public void testLog4j2(){
        Logger logger = LogManager.getLogger();
        logger.info("三生三世三生三世三生三世三生三世三生三世三生三世三生三世三生三世");
    }
}
